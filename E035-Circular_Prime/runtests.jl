using Test

include("./circular-primes.jl")

@testset "#circular_primes" begin
  @test circular_primes(10) == 4

  @test circular_primes(100) == 13

  @test circular_primes(100_000) == 43

  @test circular_primes(250_000) == 45

  @test circular_primes(500_000) == 49

  @test circular_primes(750_000) == 49

  @test circular_primes(1_000_000) == 55
end

# @time circular_primes(1_000_000)
# 3.550430 seconds (2.15 M allocations: 81.520 MiB, 0.15% gc time)

@testset "Exceptions" begin
  @test_throws ArgumentError circular_primes(-110)

  @test_throws ArgumentError circular_primes(2.3)

  @test_throws ArgumentError circular_primes("foobar")
end
