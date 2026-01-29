return {
    library = {
        -- 自动为 config 目录下的文件提供 vim 全局变量补全
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
}
