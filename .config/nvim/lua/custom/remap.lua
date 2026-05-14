vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<CR>", ":noh<CR>")

-- Fast FZF for file operations
vim.keymap.set("n", "<leader>ff", ":Files<CR>", { desc = "Find files (FZF)" })
vim.keymap.set("n", "<leader>fg", ":Rg<CR>", { desc = "Live grep (FZF)" })
vim.keymap.set("n", "<leader>fb", ":Buffers<CR>", { desc = "Buffers (FZF)" })

-- Telescope for specific features where preview is valuable
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })

-- Key mappings
vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle("diagnostics")
end)
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end)

-- Diagnostic navigation
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- Buffer navigation
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bprev<CR>", { desc = "Previous buffer" })

vim.keymap.set({ "v", "x" }, "<C-c>", '"+y<CR>', { desc = "Copy to system clipboard" })

-- LSP rename mapping
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
