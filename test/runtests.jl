import Base.Test: @test, @test_throws

unshift!(LOAD_PATH, joinpath(dirname(@__FILE__), "..", "src"))
import NGrams


let
    NGrams.NGram(3, "ab c de f g c de g")
end
