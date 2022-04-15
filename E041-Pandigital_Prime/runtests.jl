using Test

include("./pandigital_prime.jl")


@testset "#pandigital_prime" begin
  @test pandigital_prime(5) == -1

  @test pandigital_prime(4) == 4_231  # for n == 4 anything > 4321 can be pruned

  @test pandigital_prime(7) == 7_652_413

  @test pandigital_prime(8) == -1

  @test pandigital_prime(9) == -1
end


@testset "Exceptions" begin
  @test_throws ArgumentError pandigital_prime(0)

  @test_throws ArgumentError pandigital_prime(2.3)

  @test_throws ArgumentError pandigital_prime(-1)

  @test_throws ArgumentError pandigital_prime(10)

  @test_throws ArgumentError pandigital_prime("foobar")
end
