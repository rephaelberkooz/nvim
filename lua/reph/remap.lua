vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Netrw Ex'})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line down' })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>/", ":noh<CR>")
