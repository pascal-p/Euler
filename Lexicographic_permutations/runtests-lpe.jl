using Test

include("lexicographic-perms-exp.jl")


@testset "#all_perms_nr" begin
  @test all_perms(10, 699_999)   == "1938246570"
  @test all_perms(10, 899_999)   == "2536987410"
  @test all_perms(10, 900_000)   == "2537014689"
  @test all_perms(10, 999_999)   == "2783915460"
  @test all_perms(10, 1_000_000) == "2783915604"
  @test all_perms(10, 2_000_000) == "5468731209"
  @test all_perms(10, 3_000_000) == "8241703569"
end

# because of order - need to a prep for the 1_000_000th
@testset  "Prep. for performance timing" begin
  @test_skip all_perms(10, 3_000_000)
  @test_skip all_perms(10, 1_000_000)
  @test_skip all_perms(10, 2_000_000)
end

@time @testset "1_000_000-th permutation of 10 digits" begin
  @test all_perms(10, 1_000_000) == "2783915604"
end

@time @testset "2_000_000-th permutation of 10 digits" begin
  @test all_perms(10, 2_000_000) == "5468731209"
end

@time @testset "3_000_000-th permutation of 10 digits" begin
  @test all_perms(10, 3_000_000) == "8241703569"
end
