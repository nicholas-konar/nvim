local ok, neoscroll = pcall(require, "neoscroll")
if not ok then
  return
end

-- disable defaults so we can fine-tune duration per motion
neoscroll.setup {
  mappings = {},
  easing = "quadratic",
  hide_cursor = false,
  respect_scrolloff = true,
  stop_eof = false,
  performance_mode = true,
}

local modes = { "n", "v", "x" }
local keymap = {
  ["<C-u>"] = function()
    neoscroll.ctrl_u { duration = 220 }
  end,
  ["<C-d>"] = function()
    neoscroll.ctrl_d { duration = 220 }
  end,
  ["<C-b>"] = function()
    neoscroll.ctrl_b { duration = 320 }
  end,
  ["<C-f>"] = function()
    neoscroll.ctrl_f { duration = 320 }
  end,
  ["zz"] = function()
    neoscroll.zz { half_win_duration = 220 }
  end,
  ["zt"] = function()
    neoscroll.zt { half_win_duration = 220 }
  end,
  ["zb"] = function()
    neoscroll.zb { half_win_duration = 220 }
  end,
}

for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func, { silent = true })
end
