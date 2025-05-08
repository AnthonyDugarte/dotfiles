return {
        {
                'echasnovski/mini.nvim',
                version = '*',
                config = function()
                        require('mini.comment').setup()
                        require('mini.surround').setup()
                        require('mini.pairs').setup()
                        require('mini.sessions').setup()
                        require('mini.starter').setup()
                end
        },
}
