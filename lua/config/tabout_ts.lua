local M = {}

-- Extend these sets to support more delimiters or contexts.
local OPENERS = {
	["("] = true,
	["["] = true,
	["{"] = true,
	["'"] = true,
	['"'] = true,
	["`"] = true,
}

local CLOSERS = {
	[")"] = true,
	["]"] = true,
	["}"] = true,
	["'"] = true,
	['"'] = true,
	["`"] = true,
}

local function get_line(bufnr, row)
	return vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
end

local function get_char(bufnr, row, col)
	if row < 0 or col < 0 then
		return nil
	end
	local line = get_line(bufnr, row)
	if not line or col >= #line then
		return nil
	end
	return line:sub(col + 1, col + 1)
end

local function add_candidate(bufnr, list, row, col, kind)
	if row < 0 or col < 0 then
		return
	end
	local line = get_line(bufnr, row)
	if not line or col > #line then
		return
	end
	local key = row .. ":" .. col
	if not list._seen[key] then
		list._seen[key] = true
		table.insert(list, { row = row, col = col, kind = kind })
	end
end

local function get_named_node_at_cursor(bufnr, row, col)
	local function get_node_at(r, c)
		local node
		local ok = pcall(function()
			node = vim.treesitter.get_node({ bufnr = bufnr, pos = { r, c } })
		end)
		if not ok or not node then
			pcall(function()
				node = vim.treesitter.get_node_at_pos(bufnr, r, c)
			end)
		end
		return node
	end

	local node = get_node_at(row, col)
	if not node and col > 0 then
		node = get_node_at(row, col - 1)
	end
	if not node then
		local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
		if ok then
			node = ts_utils.get_node_at_cursor()
		end
	end
	while node and not node:named() do
		node = node:parent()
	end
	return node
end

local function collect_candidates(bufnr, node)
	local candidates = { _seen = {} }
	while node do
		local sr, sc, er, ec = node:range()

		local ch_start = get_char(bufnr, sr, sc)
		if OPENERS[ch_start] then
			add_candidate(bufnr, candidates, sr, sc, "open")
		end
		local ch_before = get_char(bufnr, sr, sc - 1)
		if OPENERS[ch_before] then
			add_candidate(bufnr, candidates, sr, sc - 1, "open")
		end

		local ch_end_prev = get_char(bufnr, er, ec - 1)
		if CLOSERS[ch_end_prev] then
			add_candidate(bufnr, candidates, er, ec, "close")
		end
		local ch_end = get_char(bufnr, er, ec)
		if CLOSERS[ch_end] then
			add_candidate(bufnr, candidates, er, ec + 1, "close")
		end

		node = node:parent()
	end
	candidates._seen = nil
	return candidates
end

local function is_after(a, b)
	return a.row > b.row or (a.row == b.row and a.col > b.col)
end

local function is_before(a, b)
	return a.row < b.row or (a.row == b.row and a.col < b.col)
end

-- Forward uses only "after closer" targets; backward uses "before opener" targets.
local function select_forward(candidates, cursor)
	local best
	for _, candidate in ipairs(candidates) do
		if candidate.kind == "close" and is_after(candidate, cursor) then
			if not best or is_before(candidate, best) then
				best = candidate
			end
		end
	end
	return best
end

local function select_backward(candidates, cursor)
	local best
	for _, candidate in ipairs(candidates) do
		if candidate.kind == "open" and is_before(candidate, cursor) then
			if not best or is_after(candidate, best) then
				best = candidate
			end
		end
	end
	return best
end

local function jump(select_fn)
	local bufnr = vim.api.nvim_get_current_buf()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local cursor = { row = row - 1, col = col }

	local node = get_named_node_at_cursor(bufnr, cursor.row, cursor.col)
	if not node then
		return false
	end

	-- Boundaries are derived from the node range and its immediate delimiters.
	local candidates = collect_candidates(bufnr, node)
	local target = select_fn(candidates, cursor)
	if not target then
		return false
	end

	vim.api.nvim_win_set_cursor(0, { target.row + 1, target.col })
	return true
end

function M.jump_forward()
	return jump(select_forward)
end

function M.jump_backward()
	return jump(select_backward)
end

return M
