const DT = Integer

function find_amicable(limit::DT)
  T = typeof(limit)
  v = Vector{Tuple{Pair{T, Vector{T}}, Pair{T, Vector{T}}}}()
  t = Set{T}()

  for n ∈ one(T):limit
    d₁ = divisors(n)
    p = sum(d₁)
    d₂ = divisors(p)
    s = sum(d₂)

    if s == n && d₁ ≠ d₂ && s ∉ t
      push!(t, s)
      push!(t, p)
      push!(v, (n => d₁, p => d₂))
    end
  end

  (t, v)
end


# (Set([2924, 5564, 6232, 5020, 220, 284, 1184, 2620, 1210, 6368]),
#  [(220 => [1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110], 284 => [1, 2, 4, 71, 142]), (1184 => [1, 2, 4, 8, 16, 32, 37, 74, 148, 296, 592], 1210 => [1, 2, 5, 10, 11, 22, 55, 110, 121, 242, 605]), (2620 => [1, 2, 4, 5, 10, 20, 131, 262, 524, 655, 1310], 2924 => [1, 2, 4, 17, 34, 43, 68, 86, 172, 731, 1462]), (5020 => [1, 2, 4, 5, 10, 20, 251, 502, 1004, 1255, 2510], 5564 => [1, 2, 4, 13, 26, 52, 107, 214, 428, 1391, 2782]), (6232 => [1, 2, 4, 8, 19, 38, 41, 76, 82, 152, 164, 328, 779, 1558, 3116], 6368 => [1, 2, 4, 8, 16, 32, 199, 398, 796, 1592, 3184])])
#
# julia> s |> sum
# 31626

function is_amicable(n₁::Any, n₂::Any)
  throw(ArgumentError("n₁ and n₂ should be Integers"))
end

function is_amicable(n₁::DT, n₂::DT)::Bool
  d₁ = divisors(n₁)
  d₂ = divisors(n₂)
  n₂ == sum(d₁) && n₁ == sum(d₂)
end

function divisors(n::DT)::Vector{<: DT}
  T = typeof(n)
  ary::Vector{T} = [one(T), ]

  d = T(2)
  while d * d ≤ n
    q, r = divrem(n, d)
    if r == 0
      q == d ? push!(ary, d) : push!(ary, d, q)
    end
    d += 1
  end

  return ary |> sort
end
