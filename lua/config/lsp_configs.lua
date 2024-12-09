local M = {
    servers = {
        ["racket_langserver"] = {
            cmd = { "racket", "--lib", "racket-langserver" },
        },
        ["lua_ls"] = {
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        },
    },
}

return M
