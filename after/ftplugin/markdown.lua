-- after/ftplugin/markdown.lua
-- Buffer-local keymaps and prose settings for markdown buffers only.
-- Loaded automatically by Neovim's filetype mechanism for filetype=markdown,
-- so nothing here leaks into your global keymap space.
--
-- Two complementary renderers, both surfaced through which-key under <leader>m:
--   render-markdown.nvim  -> in-buffer rendering (concealed markup, icons)
--   markdown-preview.nvim -> full HTML render in your web browser, synced scroll

local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, silent = true, desc = desc })
end

-- Preview
map("<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", "Markdown: toggle browser preview")
map("<leader>mr", "<cmd>RenderMarkdown toggle<cr>", "Markdown: toggle in-buffer render")

-- Soft-wrap prose nicely: wrap on word boundaries, move by screen line.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.keymap.set("n", "j", "gj", { buffer = true })
vim.keymap.set("n", "k", "gk", { buffer = true })

-- Spell-check prose (toggle off with `:set nospell` if it gets noisy).
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
