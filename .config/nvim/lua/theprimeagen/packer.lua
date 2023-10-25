-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    -- use("tpope/vim-sleuth")  -- Detect tabstop and shiftwidth automatically
    use {
        "navarasu/onedark.nvim",
        config = function()
            vim.cmd.colorscheme "onedark"
        end,
    }
    use("nvim-lualine/lualine.nvim")
    use("f-person/git-blame.nvim")
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.2",
        -- or                            , branch = "0.1.x",
        requires = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            }
        }
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        run = ":TSUpdate"
    }
    use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("terryma/vim-expand-region")
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
end)
