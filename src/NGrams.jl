module NGrams

type NGramNode
    word
    count::Int
    children::Vector{NGramNode}
end
NGramNode(word, count::Int) = NGramNode(word, count, Vector{NGramNode}())
NGramNode(word) = NGramNode(word, 0)

function NGramNode{T}(word, wordss::Vector{Vector{T}})
    ret = NGramNode(word, length(wordss))
    store_ngrams!(ret.children, wordss)
    ret
end


function Base.sort!(node::NGramNode)
    sort_nodes!(node.children)
end


type NGram
    n::Int
    children::Vector{NGramNode}
end
NGram(n) = NGram(n, Vector{NGramNode}())

function NGram(n, words::Vector)
    @assert n > 0
    ret = NGram(n)
    store_ngrams!(ret.children, each_cons(words, n))
    sort_nodes!(ret.children)
    ret
end

function NGram(n, s::AbstractString)
    NGram(n, split(s))
end


function bundle{T}(wordss::Vector{Vector{T}})
    ret = Dict{T, Vector{Vector{T}}}()
    for words in wordss
        w1 = words[1]
        if haskey(ret, w1)
            push!(ret[w1], words[2:end])
        else
            # todo: cleaner way?
            ret[w1] = push!(Vector{Vector{T}}(), words[2:end])
        end
    end
    ret
end


function store_ngrams!(children, wordss)
    if length(wordss[1]) > 0
        for (head, more) in bundle(wordss)
            push!(children, NGramNode(head, more))
        end
    end
    children
end


function sort_nodes!(nodes)
    for node in nodes
        sort!(node)
    end
    sort!(nodes, by=node->-node.count)
    nodes
end


function each_cons(xs, n)
    @assert n >= 1
    m = n - 1
    [xs[i:(i + m)] for i in 1:(length(xs) - m)]
end

end
