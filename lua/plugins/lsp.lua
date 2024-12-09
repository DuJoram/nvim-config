
return {
    {
        "williamboman/mason.nvim",
        cmd = "Maosn",
        keys = {{ "<leader>cm", "<cmd>Mason<cr>", desc="Mason" }},
        opts = {
            ensure_installed = {
                "shfmt",
                "isort",
                "stylua",
                "luacheck",
            --     "shfmt",
            --     "isort",
            --     "bash-language-server",
            --     "clangd",
            --     "ltex-ls",
            --     "stylua",
            --     "lua-language-server",
            --     "luacheck",
            }
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local registry = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = registry.get_package(tool)
                    if not p:is_installed()then
                        p:install()
                    end
                end
            end

            if registry.refresh then
                registry.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "bashls",
                "clangd",
                "ltex",
                "lua_ls",
            },
            handlers = {
                function (server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function(_, opts)
            -- Extend configurations servers if set in config.lsp_configs.
            local lspconfig = require("lspconfig")
            for server, settings in pairs(require("config.lsp_configs").servers) do
                lspconfig[server].setup(settings)
            end
        end
    }
}
