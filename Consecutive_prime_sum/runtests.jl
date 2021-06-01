using Test

include("./consec-primes-sum.jl")

@testset "begin" begin
  consecutive_prime_sum(100)
end
