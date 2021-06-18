"""
  all_partitions(3)   # of set [1, 2, 3]
 Partition         Encoding
 [[1, 2, 3]]       [1, 1, 1]
 [[1, 2], [3]]     [2, 1, 1]
 [[1, 3], [2]]     [1, 2, 1]
 [[1], [2, 3]]     [2, 2, 1]
 [[1], [2], [3]]   [3, 2, 1]
"""
function all_partitions(n::Int)
  # first partition to init. the process
  s = ones(Int, n)
  m = ones(Int, n)
  cont = 1
  all_enc_parts = [copy(s), ]

  while true
    !calc_all_partitions!(s, m, n) && break
    push!(all_enc_parts, copy(s))
  end

  assign_partitions(all_enc_parts, n)
end

function calc_all_partitions!(s::Vector, m::Vector, n::Int)::Bool
  #
  # Update s: 1 1 1 => 2 1 1 => 1 2 1 => 2 2 1 => 3 2 1
  # side effect on s and m
  #
  i = 1
  s[i] += 1
  while i < n && s[i] > m[i] + 1
    s[i] = 1
    i += 1
    s[i] += 1
  end

  # if i is has reached n-th element, then the last unique partition has been found
  (i == n) && return false

  #
  # The first i elements of s are all 1 and s[i + 1] is the largest element
  # we update m  by copying the max to all the first i positions.
  #
  max_ = max(s[i], m[i])
  for j ∈ i-1:-1:1
    m[j] = max_
  end
  return true
end

function assign_partitions(s::Vector, n::Int)
  @assert all(s_ -> length(s_) == n, s)     # all partitions encoding should be of length n
  #
  all_parts = fill(Vector{Int}[], length(s))
  for (jx, part) ∈ enumerate(s)
    v = Vector{Int}[Int[]]
    e, prev = 1, part[1]
    for p ∈ (part |> reverse)                # from smallest to largest
      (p > prev) && p > length(v) && push!(v, Vector{Int}[])  # add new subset
      push!(v[p], e)                         # populate p-th subset
      prev = p
      e += 1                                 # 1, 2, ... n
    end
    all_parts[jx] = v                        # add the partition to set of all partitions
  end
  all_parts
end
