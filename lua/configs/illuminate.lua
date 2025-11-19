local illuminate = require "illuminate"

local M = {}

local state = {}
local next_keys = { "<Tab>", "<CR>" }
local prev_keys = { "<S-Tab>" }

local function clear_nav_keys(bufnr)
  for _, key in ipairs(next_keys) do
    pcall(vim.keymap.del, "n", key, { buffer = bufnr })
  end

  for _, key in ipairs(prev_keys) do
    pcall(vim.keymap.del, "n", key, { buffer = bufnr })
  end
end

local function map_nav_keys(bufnr)
  local base_opts = { buffer = bufnr, silent = true }

  for _, key in ipairs(next_keys) do
    vim.keymap.set("n", key, function()
      illuminate.goto_next_reference(false)
    end, vim.tbl_extend("force", base_opts, { desc = "LSP highlight: next reference" }))
  end

  for _, key in ipairs(prev_keys) do
    vim.keymap.set("n", key, function()
      illuminate.goto_prev_reference(false)
    end, vim.tbl_extend("force", base_opts, { desc = "LSP highlight: previous reference" }))
  end
end

function M.setup()
  illuminate.configure {
    providers = { "lsp" },
    delay = 0,
    under_cursor = false,
    modes_denylist = { "i", "t" },
  }
end

function M.toggle(bufnr)
  local buf = bufnr or vim.api.nvim_get_current_buf()
  local info = state[buf]

  if not info then
    info = { active = false }
    state[buf] = info
  end

  if info.active then
    clear_nav_keys(buf)
    illuminate.pause_buf(buf)
    info.active = false
  else
    map_nav_keys(buf)
    illuminate.resume_buf(buf)
    info.active = true
  end
end

function M.attach(bufnr)
  if state[bufnr] then
    return
  end

  state[bufnr] = { active = false }
  illuminate.pause_buf(bufnr)

  vim.api.nvim_create_autocmd("BufUnload", {
    buffer = bufnr,
    once = true,
    callback = function()
      M.detach(bufnr)
    end,
  })
end

function M.detach(bufnr)
  local info = state[bufnr]
  if not info then
    return
  end

  if info.active then
    clear_nav_keys(bufnr)
    illuminate.pause_buf(bufnr)
  end
  state[bufnr] = nil
end

return M
