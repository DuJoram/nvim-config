return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
      { "mfussenegger/nvim-dap-python" },
    },

    -- stylua: ignore start
    wk_groups = { "<leader>d", desc = "Debug" },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
    -- stylua: ignore end
    config = function()
      local dap = require("dap")
      require("dap.ext.vscode").json_decode = require("json5").parse
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local symbols = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = ".",
      }
      for name, sign in pairs(symbols) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      require("config.dap-breakpoints").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local path = vim.fs.joinpath(
        (vim.env.MASON or vim.fs.joinpath(vim.fn.stdpath("data"), "mason")),
        "packages/debugpy",
        "venv/bin/python"
      )
      require("dap-python").setup(path)
    end,
  },
  {
    "igorlfs/nvim-dap-view",
    lazy = false,
    version = "1.*",
    ---@module 'dap-view'
    ---@type dapbiew.Config
    keys = {
      { "<leader>du", ":DapViewToggle<CR>", desc = "Dap View Toggle" },
    },
    opts = {},
  },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --     "nvim-neotest/nvim-nio",
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
  --     { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     local dap = require("dap")
  --     local dapui = require("dapui")
  --     dap.defaults.switchbuf = "usevisible,uselast,usetab"
  --     dapui.setup(opts)
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open({})
  --     end
  --     dap.listeners.after.event_terminated["dapui_config"] = function()
  --       dapui.close({})
  --     end
  --     dap.listeners.after.event_exited["dapui_config"] = function()
  --       dapui.close({})
  --     end
  --   end,
  -- },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      ensure_installed = {
        "python",
        "lua",
      },
      automatic_installation = true,
    },
    config = function() end,
  },
}
