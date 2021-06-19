using Test

include("pandigital-prime-sets.jl")

function test_perms(n::Int)
  perm = collect(1:n)    # first valid (and trivial) permutation

  @test length(perm) > 1 # for the sake of completness

  for ix ∈ 1:factorial(n) - 1
    @test next_permutation!(perm)
  end

  @test !next_permutation!(perm)
end


@testset "#next_permutation! of 3 elements => 6 permutations" begin
  test_perms(3)
end

@testset "#next_permutation! of 4 elements => 24 permutations" begin
  test_perms(4)
end

@testset "#next_permutation! of 5 elements => 120 permutations" begin
  test_perms(5)
end

@testset "#next_permutation! of 6 elements => 720 permutations" begin
  test_perms(6)
end

@testset "#next_permutation! of 7 elements => 5040 permutations" begin
  test_perms(7)
end

@testset "#next_permutation! of 8 elements => 40320 permutations" begin
  test_perms(8)
end

@testset "#next_permutation! of 10 elements => 3628800 permutations" begin
  test_perms(10)
end

# 60.529417 seconds (1.44 G allocations: 78.514 GiB, 1.41% gc time)
# @testset "#next_permutation! of 12 elements => 479_001_600 permutations" begin
#  @time test_perms(12)
# end


@testset "#solve" begin
end
