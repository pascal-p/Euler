using Test

include("number_spiral_diag.jl")

@testset "#number_spiral_diagonal" begin
  @test number_spiral_diagonal(5) == 101
  @test number_spiral_diagonal(101) == 692101
  @test number_spiral_diagonal(303) == 18591725
  @test number_spiral_diagonal(505) == 85986601
  @test number_spiral_diagonal(1001) == 669171001
end

@testset "#number_spiral_diagonal exceptions" begin
  @test_throws ArgumentError number_spiral_diagonal(-5)
  @test_throws ArgumentError number_spiral_diagonal(101.1)
  @test_throws ArgumentError number_spiral_diagonal(:foo)
  @test_throws ArgumentError number_spiral_diagonal("foobnar")
end
