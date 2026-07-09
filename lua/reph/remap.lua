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

vim.keymap.set({'i', 'v', 'c', 'o'}, 'jk', '<Esc>', { desc = 'Exit to normal mode with jk' })
vim.keymap.set({'i', 'v', 'c', 'o'}, 'kj', '<Esc>', { desc = 'Exit to normal mode with kj' })

vim.keymap.set("n", "<leader>cf", ':let @+=@%<CR>', { desc = 'Copy file path'})

-- coq v2 drops keymap.jump_to_mark in favor of Neovim's built-in vim.snippet.
-- Jump forward through snippet placeholders (was coq v1's <c-k>).
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  end
end, { desc = 'Snippet: jump to next placeholder' })
