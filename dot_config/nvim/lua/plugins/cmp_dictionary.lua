require("cmp_dictionary").setup({
    paths = {
        "/usr/share/dict/words",
        "~/.config/nvim/dicts/personal",
    },
    exact_length = 4,
    first_case_insensitive = true,
})
