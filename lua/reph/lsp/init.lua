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

vim.lsp.config('ty', coq.lsp_ensure_capabilities({
    settings = {
        ty = {}
    }
}))
vim.lsp.enable('ty')

vim.lsp.config('ts_ls', coq.lsp_ensure_capabilities({
  on_attach = function(client, bufnr)
    client.server_capabilities.completionProvider = {
      resolveProvider = true,
      triggerCharacters = { ".", "(", "[" }
    }
  end,
}))
vim.lsp.enable('ts_ls')

vim.lsp.config('eslint', coq.lsp_ensure_capabilities({}))
vim.lsp.enable('eslint')


local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
