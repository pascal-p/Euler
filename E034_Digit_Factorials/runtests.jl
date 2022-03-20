using Test

include("./digit_factorials.jl")

@testset "#digit_factorials" begin
  @test digit_factorials() == (2, [145, 40585], 40730)
end
