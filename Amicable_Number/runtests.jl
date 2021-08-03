using Test

include("solver.jl")

@testset "(220, 284) are amicable numbers" begin

  @test divisors(220) == [1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110]
  @test divisors(284) == [1, 2, 4, 71, 142]

  @test is_amicable(220, 284)
end

@testset "amicable exception" begin
  @test_throws ArgumentError is_amicable(3.5, -10)
end

@testset "Σ(amicable) ≤ 10_000" begin
  s, _v = find_amicable(10_000)

  @test sum(s) == 31626
end
