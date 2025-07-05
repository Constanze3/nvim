return {
    "folke/which-key.nvim",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    init = function()
        local wk = require("which-key")

        -- NETRW
        wk.add({
            "E",
            "<cmd>Explore<cr>",
            desc = "Open Netrw Explorer",
        })

        -- TELESCOPE
        wk.add({
            group = "telescope",
            {
                "<leader>ff",
                "<cmd>Telescope find_files<cr>",
                desc = "Telescope Find Files",
            },
            {
                "<leader>fg",
                "<cmd>Telescope live_grep<cr>",
                desc = "Telescope Live Grep",
            },
            {
                "<leader>fb",
                "<cmd>Telescope buffers<cr>",
                desc = "Telescope Buffers",
            },
            {
                "<leader>fh",
                "<cmd>Telescope help_tags<cr>",
                desc = "Telescope Help Tags",
            },
        })

        -- DIAGNOSTIC
        wk.add({
            "gl",
            function()
                vim.diagnostic.open_float()
            end,
            desc = "Open Diagnostic Pop-up",
        })

        -- TROUBLE
        wk.add({
            group = "trouble",
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Trouble Diagnostics",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Trouble Buffer Diagnostics",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Trouble Symbols",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "Trouble LSP Definitions / references / ...",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Trouble Location List",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Trouble Quickfix List",
            },
        })

        -- DAP (Debug Adapter Protocol)
        wk.add({
            group = "dap",
            icon = { icon = "", color = "green" },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "DAP Toggle Breakpoint",
                icon = { icon = "", color = "yellow" },
            },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "DAP Breakpoint Condition",
                icon = { icon = "", color = "yellow" },
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "DAP Run/Continue",
                icon = { icon = "󰐊", color = "red" },
            },
            -- TODO
            -- {
            --     "<leader>da",
            --     function() require("dap").continue({ before = get_args }) end,
            --     desc = "DAP Run With Args"
            -- },
            {
                "<leader>dC",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "DAP Run To Cursor",
            },
            {
                "<leader>dg",
                function()
                    require("dap").goto_()
                end,
                desc = "DAP Go To Line (No Execute)",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "DAP Step Into",
                icon = { icon = "󰆹", color = "red" },
            },
            {
                "<leader>dj",
                function()
                    require("dap").down()
                end,
                desc = "DAP Down",
            },
            {
                "<leader>dk",
                function()
                    require("dap").up()
                end,
                desc = "DAP Up",
            },
            {
                "<leader>dl",
                function()
                    require("dap").run_last()
                end,
                desc = "DAP Run Last",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
                desc = "DAP Step Out",
                icon = { icon = "󰆸", color = "red" },
            },
            {
                "<leader>ds",
                function()
                    require("dap").step_over()
                end,
                desc = "DAP Step Over",
                icon = { icon = "󰆷", color = "red" },
            },
            {
                "<leader>dp",
                function()
                    require("dap").pause()
                end,
                desc = "DAP Pause",
                icon = { icon = "", color = "red" },
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "DAP Toggle REPL",
            },
            {
                "<leader>dS",
                function()
                    require("dap").session()
                end,
                desc = "DAP Session",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "DAP Terminate",
                icon = { icon = "", color = "red" },
            },
            {
                "<leader>dw",
                function()
                    require("dap.ui.widgets").hover()
                end,
                desc = "DAP Widgets",
            },
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                desc = "DAP Toggle UI",
            },
        })
    end,
}
