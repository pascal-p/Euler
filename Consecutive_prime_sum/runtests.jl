using Test

include("./consec-primes-sum.jl")

@testset "prime sum ≤ 100" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(100)
  @test (sum, ary[1], ary[end], nterms) == (41, 2, 13, 6)
end

@testset "prime sum ≤ 1000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(1000)
  @test (sum, ary[1], ary[end], nterms) == (953, 7, 89, 21)
end

@testset "prime sum ≤ 10_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(10_000)
  @test (sum, ary[1], ary[end], nterms) == (9521, 3, 317, 65)
end

@testset "prime sum ≤ 100_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(100_000)
  @test (sum, ary[1], ary[end], nterms) == (92951, 3, 1097, 183)
end

@testset "prime sum ≤ 1_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(1_000_000)
  @test (sum, ary[1], ary[end], nterms) == (997651, 7, 3931, 543)
end

@testset "prime sum ≤ 10_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(10_000_000)
  @test (sum, ary[1], ary[end], nterms) == (9951191, 5, 13399, 1587)
end

@testset "prime sum ≤ 100_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(100_000_000)
  @test (sum, ary[1], ary[end], nterms) == (99819619, 7, 45161, 4685)
end

@testset "prime sum ≤ 1_000_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(1_000_000_000)
  @test (sum, ary[1], ary[end], nterms) == (999715711, 11, 151051, 13935)
end

@testset "prime sum ≤ 10_000_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(10_000_000_000)
  @test (sum, ary[1], ary[end], nterms) == (9999419621, 2, 502237, 41708)
end

@testset "prime sum ≤ 100_000_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(100_000_000_000)
  @test (sum, ary[1], ary[end], nterms) == (99987684473, 19, 1662257, 125479)
end

@testset "prime sum ≤ 1_000_000_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(1_000_000_000_000)
  @test (sum, ary[1], ary[end], nterms) == (999973156643, 5, 5476973, 379317)
end

@testset "prime sum ≤ 1_000_000_000_000_000" begin
  @time (sum, ary, nterms) = consecutive_prime_sum(1_000_000_000_000_000)
  @test (sum, ary[1], ary[end], nterms) == (999998764608469, 7, 192682309, 10695879)
end

## Too inefficient...

# @testset "alt prime sum ≤ 100" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(100)
#   @test (sum, ary[1], ary[end], nterms) == (41, 2, 13, 6)
# end

# @testset "alt prime sum ≤ 1000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(1000)
#   @test (sum, ary[1], ary[end], nterms) == (953, 7, 89, 21)
# end

# @testset "alt prime sum ≤ 10_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(10_000)
#   @test (sum, ary[1], ary[end], nterms) == (9521, 3, 317, 65)
# end

# @testset "alt prime sum ≤ 100_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(100_000)
#   @test (sum, ary[1], ary[end], nterms) == (92951, 3, 1097, 183)
# end

# @testset "alt prime sum ≤ 1_000_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(1_000_000)
#   @test (sum, ary[1], ary[end], nterms) == (997651, 7, 3931, 543)
# end

# @testset "alt prime sum ≤ 10_000_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(10_000_000)
#   @test (sum, ary[1], ary[end], nterms) == (9951191, 5, 13399, 1587)
# end

# @testset "alt prime sum ≤ 100_000_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(100_000_000)
#   @test (sum, ary[1], ary[end], nterms) == (99819619, 7, 45161, 4685)
# end

# @testset "alt prime sum ≤ 1_000_000_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(1_000_000_000)
#   @test (sum, ary[1], ary[end], nterms) == (999715711, 11, 151051, 13935)
# end

# @testset "alt prime sum ≤ 10_000_000_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(10_000_000_000)
#   @test (sum, ary[1], ary[end], nterms) == (9999419621, 2, 502237, 41708)
# end

# @testset "alt prime sum ≤ 100_000_000_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(100_000_000_000)
#   @test (sum, ary[1], ary[end], nterms) == (99987684473, 19, 1662257, 125479)
# end

# @testset "alt prime sum ≤ 1_000_000_000_000" begin
#   @time (sum, ary, nterms) = consecutive_prime_sum_alt(1_000_000_000_000)
#   @test (sum, ary[1], ary[end], nterms) == (999973156643, 5, 5476973, 379317)
# end
