using Test

include("lexicographic-perms.jl")


@testset "#all_perms base cases" begin
  @test all_perms([]) == [[]]

  @test all_perms([0]) == [[0]]

  @test all_perms([1, 2]) == [[1, 2], [2, 1]]
end


@testset "#prepend_all!" begin
  @test prepend_all!(3, [[]]) == [[3]]

  @test prepend_all!(3, [[1, 2], [2, 1]]) == [[3, 1, 2], [3, 2, 1]]

  @test prepend_all!(4, [[1, 2, 3], [1, 3, 2],
                         [2, 1, 3], [2, 3, 1],
                         [3, 1, 2], [3, 2, 1]]) == [[4, 1, 2, 3], [4, 1, 3, 2],
                                                    [4, 2, 1, 3], [4, 2, 3, 1],
                                                    [4, 3, 1, 2], [4, 3, 2, 1]]

end


@testset "#all_perms rec. cases" begin
  @test all_perms([true, false]) ==  [Bool[1, 0], Bool[0, 1]]

  @test all_perms([1, 2, 3]) == [[1, 2, 3], [1, 3, 2], [2, 1, 3],
                                 [2, 3, 1], [3, 1, 2], [3, 2, 1]]

  @test all_perms([1, 'a', "foo"]) == [Any[1, 'a', "foo"], Any[1, "foo", 'a'],
                                       Any['a', 1, "foo"], Any['a', "foo", 1],
                                       Any["foo", 1, 'a'], Any["foo", 'a', 1]]

  @test all_perms(Vector{Int}([1, 2, 3])) == Vector{Vector{Int}}([[1, 2, 3], [1, 3, 2], [2, 1, 3],
                                                                  [2, 3, 1], [3, 1, 2], [3, 2, 1]])

  @test all_perms(Vector{Float64}([1., 2., 3.])) == Vector{Vector{Float64}}([
                                                                             [1., 2., 3.], [1., 3., 2.], [2., 1., 3.],
                                                                             [2., 3., 1.], [3., 1., 2.], [3., 2., 1.]])


  @test all_perms([1, 2, 3, 4]) == Vector{Vector{Int}}([
                                    [1, 2, 3, 4], [1, 2, 4, 3],
                                    [1, 3, 2, 4], [1, 3, 4, 2],
                                    [1, 4, 2, 3], [1, 4, 3, 2],
                                    [2, 1, 3, 4], [2, 1, 4, 3],
                                    [2, 3, 1, 4], [2, 3, 4, 1],
                                    [2, 4, 1, 3], [2, 4, 3, 1],
                                    [3, 1, 2, 4], [3, 1, 4, 2],
                                    [3, 2, 1, 4], [3, 2, 4, 1],
                                    [3, 4, 1, 2], [3, 4, 2, 1],
                                    [4, 1, 2, 3], [4, 1, 3, 2],
                                    [4, 2, 1, 3], [4, 2, 3, 1],
                                    [4, 3, 1, 2], [4, 3, 2, 1],
  ])

  @test all_perms(['v', 'x', 'y', 'z']) == [['v', 'x', 'y', 'z'], ['v', 'x', 'z', 'y'],
                                            ['v', 'y', 'x', 'z'], ['v', 'y', 'z', 'x'],
                                            ['v', 'z', 'x', 'y'], ['v', 'z', 'y', 'x'],
                                            ['x', 'v', 'y', 'z'], ['x', 'v', 'z', 'y'],
                                            ['x', 'y', 'v', 'z'], ['x', 'y', 'z', 'v'],
                                            ['x', 'z', 'v', 'y'], ['x', 'z', 'y', 'v'],
                                            ['y', 'v', 'x', 'z'], ['y', 'v', 'z', 'x'],
                                            ['y', 'x', 'v', 'z'], ['y', 'x', 'z', 'v'],
                                            ['y', 'z', 'v', 'x'], ['y', 'z', 'x', 'v'],
                                            ['z', 'v', 'x', 'y'], ['z', 'v', 'y', 'x'],
                                            ['z', 'x', 'v', 'y'], ['z', 'x', 'y', 'v'],
                                            ['z', 'y', 'v', 'x'], ['z', 'y', 'x', 'v']
  ]

  @test all_perms(collect(0:4)) |> length == 120

  @test all_perms(collect(0:5)) |> length == 720

  @test all_perms(collect(0:6)) |> length == 5040
end

@time @testset "#all_perms of 10 digits => 10!" begin
  # 10! ≡ 3_628_800
  @test_skip all_perms(collect(0:9)) |> length == 3_628_800
end
#
# Test Summary:                  | Pass  Total
# #all_perms of 10 digits => 10! |    1      1
#   6.666260 seconds (36.33 M allocations: 3.653 GiB, 26.40% gc time, 5.47% compilation time)
#

@time @testset "#all_perms of 11 digits => 11!" begin
  # 11! ≡ 39_916_800
  @test_skip all_perms(collect(0:10)) |> length == 39_916_800
end
#
# Test Summary:                  | Pass  Total
# #all_perms of 11 digits => 11! |    1      1
# 169.726583 seconds (284.85 M allocations: 31.599 GiB, 46.52% gc time, 1.47% compilation time)
#

# way too long...
# @time @testset "#all_perms of 12 digits => 12!" begin
#   # 12! ≡ 479_001_600
#   @test_skip all_perms(collect(0:11)) |> length == 479_001_600
# end


@time @testset "millionnth permutation of 0..9" begin
  @test millionnth(collect(0:9)) == [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
end
