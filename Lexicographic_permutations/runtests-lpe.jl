using Test

include("lexicographic-perms-exp.jl")


@testset "#nth_perms" begin
  @test nth_perm(10, 699_999)   == "1938246570"
  @test nth_perm(10, 899_999)   == "2536987410"
  @test nth_perm(10, 900_000)   == "2537014689"
  @test nth_perm(10, 999_999)   == "2783915460"
  @test nth_perm(10, 1_000_000) == "2783915604"
  @test nth_perm(10, 2_000_000) == "5468731209"
  @test nth_perm(10, 3_000_000) == "8241703569"
end

@testset "Exception with nth_perms" begin
  @test_throws AssertionError nth_perm(-10, 2_000)

  @test_throws AssertionError nth_perm(3, 10) # 0, 1, 2 has only 6 permutations
end

@testset "#nth_perms_alt1" begin
  @test nth_perm_alt1(10, 699_999)   == "1938246570"
  @test nth_perm_alt1(10, 899_999)   == "2536987410"
  @test nth_perm_alt1(10, 900_000)   == "2537014689"
  @test nth_perm_alt1(10, 999_999)   == "2783915460"
  @test nth_perm_alt1(10, 1_000_000) == "2783915604"
  @test nth_perm_alt1(10, 2_000_000) == "5468731209"
  @test nth_perm_alt1(10, 3_000_000) == "8241703569"

  @test nth_perm_alt1(7, 2982) == "4062135" # 2982nd perm of 0..6
end

@testset "Exception with nth_perms" begin
  @test_throws ArgumentError nth_perm_alt1(10, -2_000)

  @test_throws AssertionError nth_perm_alt1(5, 1000) # 0, 1, 2, 3, 4 has only 120 permutations
end

@testset "#to_factorial_base" begin
  @test to_factorial_base(463) == "341010"
  @test to_factorial_base(2982) == "4041000"

  @test to_factorial_base(1_000_000) == "2662512200" # "2662512110"
end


## Timing

# because of order - need to a prep for the 1_000_000th
@testset  "Prep. for performance timing" begin
  @test_skip nth_perm(10, 3_000_000)
  @test_skip nth_perm(10, 1_000_000)
  @test_skip nth_perm(10, 2_000_000)
end

@time @testset "nth_perm: 1_000_000-th permutation of 10 digits" begin
  @test nth_perm(10, 1_000_000) == "2783915604"
end

@time @testset "nth_perm: 2_000_000-th permutation of 10 digits" begin
  @test nth_perm(10, 2_000_000) == "5468731209"
end

@time @testset "nth_perm: 3_000_000-th permutation of 10 digits" begin
  @test nth_perm(10, 3_000_000) == "8241703569"
end


@time @testset "nth_perm_alt1: 1_000_000-th permutation of 10 digits" begin
  @test nth_perm_alt1(10, 1_000_000) == "2783915604"
end

@time @testset "nth_perm_alt1: 2_000_000-th permutation of 10 digits" begin
  @test nth_perm_alt1(10, 2_000_000) == "5468731209"
end

@time @testset "nth_perm_alt1: 3_000_000-th permutation of 10 digits" begin
  @test nth_perm_alt1(10, 3_000_000) == "8241703569"
end
