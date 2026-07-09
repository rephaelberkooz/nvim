-- Treesitter setup — nvim-treesitter `main` branch API (Neovim 0.12+).
--
-- WHY THIS LOOKS DIFFERENT NOW (migration notes):
--   After upgrading to Neovim 0.12, the old setup on the `master` branch started
--   crashing: render-markdown parsing markdown code-block injections hit
--   `attempt to call method 'range' (a nil value)` inside nvim-treesitter's
--   `set-lang-from-info-string!` query directive. The `master` branch is frozen
--   and will not be fixed for 0.12, so we moved to the `main` branch
--   (`branch = 'main'` in lua/reph/plugins.lua), whose queries/directives are
--   0.12-compatible.
--
-- WHAT CHANGED BETWEEN THE TWO BRANCHES:
--   * `master` used `require('nvim-treesitter.configs').setup{ ensure_installed,
--     highlight = { enable = true }, ... }`. That module DOES NOT EXIST on `main`
--     (hence the earlier "module 'nvim-treesitter.configs' not found" error).
--   * On `main` you instead: (1) install parsers explicitly with
--     `require('nvim-treesitter').install{...}`, and (2) turn on highlighting per
--     buffer via Neovim's built-in `vim.treesitter.start()` (there is no
--     plugin-managed `highlight` option anymore).
--   * `main` compiles parsers with the `tree-sitter` CLI (unlike `master`, which
--     shipped precompiled parsers). We installed it once via
--     `brew install tree-sitter-cli`; without it, `install()` fails to build
--     non-bundled parsers (js/ts) and spams errors on every startup.
--
-- Parsers to install (async; a no-op if already present). Equivalent to the old
-- `ensure_installed`. `latex` is intentionally omitted so .tex files keep
-- vimtex's rich regex syntax instead of the treesitter LaTeX parser.
require("nvim-treesitter").install({
  "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query",
  "markdown", "markdown_inline",
})

-- Enable treesitter highlighting per buffer. Replaces the old `highlight` block.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    -- Was `highlight.disable`: skip treesitter on very large files.
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    -- pcall guards filetypes without an installed parser (e.g. tex -> vimtex).
    pcall(vim.treesitter.start, ev.buf)
  end,
})
