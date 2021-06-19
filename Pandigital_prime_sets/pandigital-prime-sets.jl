const T = Int
const VT = Vector{T}

function solve(;n=9)
  count = 0
  perm = collect(1:n)
  sols = [[]]

  while true
    length(sols[end]) > 0 && push!(sols, [])

    count += check_partition(perm, 1, T[0], sols)
    !next_permutation!(perm) && break
  end

  ## flatten sols
  nsols = Vector{VT}[]
  for sol ∈ sols
    nsols = VT[nsols..., sol...]
  end

  (count, nsols)
end

function next_permutation!(perm::VT)
  n = length(perm)
  ix = n
  while perm[ix - 1] ≥ perm[ix]
    ix -= 1
    ix == 1 && return false
  end
  # now: perm[ix - 1] < perm[ix] && ix ≥ 1

  jx = n
  while perm[jx] ≤ perm[ix - 1]
    jx -= 1
  end

  swap!(perm, jx, ix - 1)

  jx = n
  while ix < jx
    swap!(perm, ix, jx)
    ix += 1
    jx -= 1
  end

  true
end

function check_partition(perm::VT, six::T, prevnum::VT, sols::Vector)::T
  np = length(perm)

  function _check(six::T)
    count = 0
    for ix ∈ six:np
      number = reduce((num, d) -> num = num * 10 + d, view(perm, six:ix);
                      init=0)

      number < prevnum[end] && continue
      !isprime(number) && continue

      if ix == np
        push!(sols[end], [prevnum[2:end]..., number])
        return count + 1
      end
      prevnum = T[prevnum..., number]
      count += _check(ix + 1)
    end

    count
  end

  _check(six)
end

@inline function swap!(perm::VT, ix::Int, jx::Int)
  perm[ix], perm[jx] = perm[jx], perm[ix]
end

function isprime(p::T)::Bool where {T <: Integer}
  (p ≤ 1 || (p > 2 && p % 2 == 0)) && return false
  (p % 3 == 0 || p % 5 == 0) && return false
  p < 9 && return true

  n = floor(T, √(p))
  prime, cp = true, 5
  while cp < n
    (p % cp == 0 || p % (cp + 2) == 0) && return false
    cp += 6
  end
  prime
end
