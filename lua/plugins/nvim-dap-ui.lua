return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    config = function() 
        local dapui = require("dapui")
        dapui.setup({
            layouts = {
                {
                    elements = {
                        { id = "breakpoints", size = 0.13 },
                        { id = "stacks", size = 0.13 },
                        { id = "watches", size = 0.13 },
                        { id = "scopes", size = 0.6 }
                    },
                    position = "left",
                    size = 50
                },
                {
                    elements = {
                        { id = "repl", size = 0.3 },
                        { id = "console", size = 0.7 },
                    },
                    position = "bottom",
                    size = 15
                }
            }
        })
    
        local dap = require("dap")
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
    end
}
