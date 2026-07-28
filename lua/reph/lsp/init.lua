local coq = require("coq")
-- Configure LSP servers with coq
-- lspconfig.pyright.setup(coq.lsp_ensure_capabilities({
--   on_attach = function(client, bufnr)
--     -- Force LSP to provide completions
--     client.server_capabilities.completionProvider = {
--       resolveProvider = true,
--       triggerCharacters = { ".", "(", "[" }
--     }
--   end,
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = "standard",
--         extraPaths = { 
--           "~/Nuclei/nuclei-compliance/nuclei-compliance/shared/"
--         },
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         diagnosticMode = "openFilesOnly", -- is this giving me workspace-level errors
--         completeFunctionCalls = true,
--         autoImportCompletions = true,
--         indexing = true,
--         inlayHints = {
--             callArgumentNames = "all"
--         },
--       }
--     }
--   }
-- }))

-- Pin the ty version here rather than inheriting whatever `ty` happens to be on
-- PATH: this file is version-controlled, a `uv tool` receipt is not. Keep in sync
-- with TY_VERSION in nuclei-compliance/.github/workflows/python-*-typecheck.yml
-- and with the ty pin in packages/core-ai/pyproject.toml, so editor and CI agree.
--
-- Do not float this to @latest. 0.0.12 and 0.0.21 both panic on completion when
-- a project sets `environment.root` to a path outside its own project root (as
-- nuclei-compliance/packages/core-ai does): "No root found for path ... shared".
-- Fixed upstream in astral-sh/ruff#25522 (astral-sh/ty#3594), released in 0.0.4x+.
--
-- uvx resolves from its local cache after the first fetch, so this costs one
-- download per new pinned version and needs the network only that once.
--
-- Most services in the nuclei-compliance monorepo (api, jobs, processing,
-- analytics, reports, streams, ...) import `core.*` from nuclei-compliance/shared
-- but ship no ty.toml/pyproject.toml of their own, so ty roots them at the git
-- root and cannot resolve those imports. `ty.configuration` is inline editor
-- config taking the same shape as ty.toml, and it takes precedence over on-disk
-- config files, so keep it to this one key and let per-project ty.toml own the
-- rest (core-ai's `environment.root`, shared's `src.exclude`, ...).
--
-- Absolute, not relative: ty resolves a relative path against whichever
-- directory it picked as the project root, which differs per service (git root
-- for the config-less ones above, packages/<name> for those with a pyproject).
-- "nuclei-compliance/shared/" was only ever correct for the former.
local nuclei_shared = vim.env.HOME .. '/Nuclei/nuclei-compliance/nuclei-compliance/shared'
local ty_settings = nil
if vim.fn.getcwd():find('nuclei-compliance', 1, true) and vim.uv.fs_stat(nuclei_shared) then
    ty_settings = {
        ty = {
            configuration = {
                environment = {
                    ['extra-paths'] = { nuclei_shared },
                },
            },
        },
    }
end

vim.lsp.config('ty', {
    cmd = { 'uvx', 'ty@0.0.64', 'server' },
    settings = ty_settings,
})
vim.lsp.enable('ty')

-- vim.lsp.config('ts_ls', coq.lsp_ensure_capabilities({
--   on_attach = function(client, bufnr)
--     client.server_capabilities.completionProvider = {
--       resolveProvider = true,
--       triggerCharacters = { ".", "(", "[" }
--     }
--   end,
-- }))
vim.lsp.enable('ts_ls')

vim.lsp.enable('eslint')


-- NOTE: rust-tools.nvim (simrat39) is unmaintained and still uses the old
-- `require('lspconfig')` framework, which nvim-lspconfig now raises an error on
-- (nvim 0.11+). That throw was aborting this whole module mid-load and taking
-- the other LSP servers (ty / ts_ls / eslint) down with it. Commented out for
-- now. If you need Rust again, migrate to `mrcjkb/rustaceanvim`.
--
-- local rt = require("rust-tools")
--
-- rt.setup({
--   server = {
--     on_attach = function(_, bufnr)
--       -- Hover actions
--       vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--       -- Code action groups
--       vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--     end,
--   },
-- })
