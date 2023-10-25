return {
    {
        'chrisbra/csv.vim',
        config = function ()
            vim.g.csv_delim_test = ',;|'
            vim.g.csv_col='[^,]*,'
        end
    }
}
