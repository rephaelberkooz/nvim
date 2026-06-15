-- after/ftplugin/tex.lua
-- Buffer-local keymaps for LaTeX / Beamer buffers only.
-- Loaded automatically by Neovim's filetype mechanism for filetype=tex,
-- so nothing here leaks into your global keymap space.
--
-- vimtex also provides its own mappings under <localleader> (localleader = `\`):
--   \ll  toggle continuous compile      \lv  forward-search (view) in Skim
--   \lk  stop compilation               \lc  clean aux files
--   \lt  table of contents              \le  show errors (quickfix)
-- The <leader>l* maps below mirror the common ones in your <Space>-leader
-- muscle memory and are surfaced through which-key.

local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, silent = true, desc = desc })
end

-- Compilation / preview
map("<leader>ll", "<cmd>VimtexCompile<cr>", "LaTeX: toggle live compile (latexmk -pvc)")
map("<leader>lv", "<cmd>VimtexView<cr>", "LaTeX: view PDF in Skim (forward search)")
map("<leader>lk", "<cmd>VimtexStop<cr>", "LaTeX: stop compilation")
map("<leader>lK", "<cmd>VimtexStopAll<cr>", "LaTeX: stop all compilations")
map("<leader>lc", "<cmd>VimtexClean<cr>", "LaTeX: clean aux files")
map("<leader>lC", "<cmd>VimtexClean!<cr>", "LaTeX: clean all (incl. PDF)")

-- Navigation / info
map("<leader>lt", "<cmd>VimtexTocToggle<cr>", "LaTeX: table of contents")
map("<leader>le", "<cmd>VimtexErrors<cr>", "LaTeX: show errors / log")
map("<leader>ls", "<cmd>VimtexStatus<cr>", "LaTeX: compiler status")
map("<leader>li", "<cmd>VimtexInfo<cr>", "LaTeX: vimtex info")
map("<leader>lm", "<cmd>VimtexImapsList<cr>", "LaTeX: list insert-mode maps")

-- Soft-wrap prose nicely: wrap on word boundaries, move by screen line.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.keymap.set("n", "j", "gj", { buffer = true })
vim.keymap.set("n", "k", "gk", { buffer = true })

-- Spell-check prose (toggle off with `:set nospell` if it gets noisy).
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
