require("reph.remap")
require("reph.lazy")
require("reph.options")
require("reph.lsp")


require("mason").setup()
-- ts_ls / eslint are enabled in reph/lsp; mason supplies their binaries so they
-- survive asdf node version bumps (npm -g installs are per-node-version).
require("mason-lspconfig").setup({
    ensure_installed = { "ts_ls", "eslint" },
})
