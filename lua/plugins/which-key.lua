return {
    "folke/which-key.nvim",
    keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        }
    },
    init = function()
        local wk = require("which-key")
        
        -- NETRW
        wk.add({
            "E", 
            "<cmd>Explore<cr>", 
            desc = "Open Netrw Explorer"
        })
        
        -- TELESCOPE
        wk.add({
            group = "telescope",
            { 
                "<leader>ff", 
                "<cmd>Telescope find_files<cr>", 
                desc = "Telescope Find Files" 
            },
            { 
                "<leader>fg", 
                "<cmd>Telescope live_grep<cr>",  
                desc = "Telescope Live Grep" 
            },
            { 
                "<leader>fb", 
                "<cmd>Telescope buffers<cr>",
                desc = "Telescope Buffers" 
            },
            { 
                "<leader>fh", 
                "<cmd>Telescope help_tags<cr>",  
                desc = "Telescope Help Tags" 
            }
        })
        
        -- HARPOON
        local harpoon = require("harpoon")
        wk.add({
                group = "harpoon",
                {
                    "<leader>a", 
                    function() harpoon:list():add() end, 
                    desc = "Harpoon Add File"
                },
                { 
                    "<C-e>", 
                    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 
                    desc = "Harpoon Show List" 
                },
                { 
                    "<C-j>", 
                    function() harpoon:list():select(1) end, 
                    desc = "Harpoon Buffer 1" },
                { 
                    "<C-k>", 
                    function() harpoon:list():select(2) end, 
                    desc = "Harpoon Buffer 2" 
                },
                { 
                    "<C-l>", 
                    function() harpoon:list():select(3) end, 
                    desc = "Harpoon Buffer 3" 
                },
                { 
                    "<C-S-P>", 
                    function() harpoon:list():prev() end, 
                    desc = "Harpoon Previous Buffer" 
                },
                { 
                    "<C-S-N>", 
                    function() harpoon:list():next() end, 
                    desc = "Harpoon Next Buffer" 
                }
        })
        
        -- LSP
        wk.add({
            group = "lsp",
            { 
                "K", 
                function() vim.lsp.buf.hover() end, 
                desc = "Hover" 
            },
            { 
                "gd", 
                function() vim.lsp.buf.definition() end, 
                desc = "Go To Definition" 
            },
            { 
                "gD", 
                function() vim.lsp.buf.declaration() end, 
                desc = "Go To Declaration" 
            },
            { 
                "gi", 
                function() vim.lsp.buf.implementation() end, 
                desc = "Go To Implementation" 
            },
            { 
                "go", 
                function() vim.lsp.buf.type_definition() end, 
                desc = "Go To Type Definition" 
            },
            { 
                "gr", 
                function() vim.lsp.buf.references() end, 
                desc = "Show References" 
            },
            { 
                "gs", 
                function() vim.lsp.buf.signature_help() end, 
                desc = "Signature Help" 
            },
            { 
                "<F2>", 
                function() vim.lsp.buf.rename() end, 
                desc = "LSP Rename" 
            },
            { 
                "<F3>", 
                function() vim.lsp.buf.format({ async = true}) end, 
                desc = "LSP Format", mode = { "n", "x" } 
            },
            { 
                "<F4>", 
                function() vim.lsp.buf.code_action() end, 
                desc = "LSP Code Action" 
            }
        })

        -- DIAGNOSTIC
        wk.add({ 
            "gl", 
            function() vim.diagnostic.open_float() end, 
            desc = "Open Diagnostic Pop-up" 
        })

        -- NVIM TREE
        wk.add({
            { "<leader>t", function()
                local nvim_tree_loaded = require("lazy.core.config").plugins["nvim-tree.lua"]._.loaded

                if not nvim_tree_loaded then
                    require("nvim-tree").setup({})
                end

                if require("nvim-tree.view").is_visible() then
                    -- if the tree is the only loaded buffer, open netrw
                    local windows = vim.api.nvim_list_wins()
                    if #windows == 1 then
                        vim.cmd("vsplit")
                        vim.cmd("Explore")
                    end

                    require("nvim-tree.api").tree.close()
                else
                    require("nvim-tree.api").tree.open() 
                    
                    -- close all netrw buffers
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_get_option(buf, "filetype") == "netrw" then
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end
                    end
                end
            end,
            desc = "Toggle Nvim-Tree" }
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
            }
        }) 
        
        -- DAP (Debug Adapter Protocol)
        wk.add({
            group = "dap",
            icon = { icon = "", color = "green" },
            { 
                "<leader>db", 
                function() require("dap").toggle_breakpoint() end, 
                desc = "DAP Toggle Breakpoint",
                icon = { icon = "", color = "yellow" },
            },
            { 
                "<leader>dB", 
                function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, 
                desc = "DAP Breakpoint Condition",
                icon = { icon = "", color = "yellow" }
            },
            { 
                "<leader>dc", 
                function() require("dap").continue() end, 
                desc = "DAP Run/Continue",
                icon = { icon = "󰐊", color = "red" }
            },
            -- TODO
            -- { 
            --     "<leader>da", 
            --     function() require("dap").continue({ before = get_args }) end, 
            --     desc = "DAP Run With Args" 
            -- },
            { 
                "<leader>dC", 
                function() require("dap").run_to_cursor() end, 
                desc = "DAP Run To Cursor" 
            },
            { 
                "<leader>dg", 
                function() require("dap").goto_() end, 
                desc = "DAP Go To Line (No Execute)" 
            },
            { 
                "<leader>di", 
                function() require("dap").step_into() end, 
                desc = "DAP Step Into",
                icon = { icon = "󰆹", color = "red" }
            },
            { 
                "<leader>dj", 
                function() require("dap").down() end, 
                desc = "DAP Down" 
            },
            { 
                "<leader>dk", 
                function() require("dap").up() end, 
                desc = "DAP Up" 
            },
            { 
                "<leader>dl", 
                function() require("dap").run_last() end, 
                desc = "DAP Run Last" 
            },
            { 
                "<leader>do", 
                function() require("dap").step_out() end, 
                desc = "DAP Step Out",
                icon = { icon = "󰆸", color = "red" }
            },
            { 
                "<leader>ds", 
                function() require("dap").step_over() end, 
                desc = "DAP Step Over",
                icon = { icon = "󰆷", color = "red" }
            },
            { 
                "<leader>dp", 
                function() require("dap").pause() end, 
                desc = "DAP Pause",
                icon = { icon = "", color = "red" }
            },
            { 
                "<leader>dr", 
                function() require("dap").repl.toggle() end, 
                desc = "DAP Toggle REPL",
            },
            { 
                "<leader>dS", 
                function() require("dap").session() end, 
                desc = "DAP Session" },
            { 
                "<leader>dt", 
                function() require("dap").terminate() end, 
                desc = "DAP Terminate",
                icon = { icon = "", color = "red" }
            },
            { 
                "<leader>dw", 
                function() require("dap.ui.widgets").hover() end,
                desc = "DAP Widgets" 
            },
            {
                "<leader>du",
                function() require("dapui").toggle() end,
                desc = "DAP Toggle UI"
            }
        })
    end
}
