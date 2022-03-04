const LIMIT = UInt(20)
const FACT_20 = UInt(2432902008176640000)
# factorial(20)
# 2432902008176640000 -> Int64
#

"""
   all_perms_nr(limit::UInt, p::UInt)::String

Calculate the p-th permutation of the sequence 0,1,...limit - 1
non recursive version.

# Examples
```julia-repl
all_perms_nr(10, 999_999)
"2783915460"
```
"""
function all_perms_nr(limit::UInt, p::UInt)::String
  @assert(limit ≤ LIMIT &&  p ≤ FACT_20,
          "limit: $(limit) ≤ $(LIMIT) && p $(p) ≤ $(FACT_20)")
  perm = collect(0:limit - 1)
  n = length(perm) |> UInt

  for _ ∈ UInt(1):p
    ix = n
    while perm[ix - 1] ≥ perm[ix]; ix -= 1; end

    jx = n + 1
    while perm[jx - 1] ≤ perm[ix - 1]; jx -= 1; end

    swap!(perm, ix - 1 , jx - 1)

    ix += 1
    jx = n + 1 # reset
    while ix ≤ jx
      swap!(perm, ix - 1 , jx - 1)
      ix += 1
      jx -= 1
    end
  end

  join(perm) # return p-th permutation as a String
end

function all_perms_nr(limit::Integer, p::Integer)::String
  @assert limit > 0 && p > 0

  all_perms_nr(UInt(limit), UInt(p))
end

function swap!(v::Vector{UInt}, ix::UInt, jx::UInt)
  tmp = v[ix]
  v[ix] = v[jx]
  v[jx] = tmp
end
