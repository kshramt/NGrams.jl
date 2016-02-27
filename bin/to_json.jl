#!/usr/bin/env julia


import JSON

unshift!(LOAD_PATH, joinpath(dirname(@__FILE__), "..", "src"))
import NGrams


function usage_and_exit(s=1)
    println(STDERR, "$(@__FILE__) <n> < <file>")
    exit(s)
end


function main(args)
    length(args) != 1 && usage_and_exit()
    n = try
        parse(Int, args[1])
    catch
        usage_and_exit()
    end
    n < 1 && usage_and_exit()

    JSON.print(NGrams.plain(NGrams.NGram(n, readstring(STDIN))))
end


main(ARGS)
