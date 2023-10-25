return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "mfussenegger/nvim-dap",
            },
            config = function()
                require("dapui").setup(opts)
            end,
        },
        -- "theHamsta/nvim-dap-virtual-text",
        {
            "microsoft/vscode-js-debug",
            build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        }
    },
}
