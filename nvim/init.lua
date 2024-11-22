require("config.lazy")
require("config.maps")

vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Enable line numbers
vim.wo.number = true

local set = vim.opt -- set options
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

