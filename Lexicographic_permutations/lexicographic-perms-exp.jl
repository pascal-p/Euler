const LIMIT = UInt(20)
const FACT_20 = UInt(2432902008176640000)
# factorial(20)
# 2432902008176640000 -> Int64
#

"""
   nth_perm(limit::UInt, p::UInt)::String

Calculate the p-th permutation of the sequence 0,1,...limit - 1
non recursive version.

# Examples
```julia-repl
nth_perm(10, 999_999)  # 999_999th permutaion of sequence 0..9
"2783915460"
```
"""
function nth_perm(limit::UInt, p::UInt)::String
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

function nth_perm(limit::Integer, p::Integer)::String
  @assert limit > 0 && p > 0

  nth_perm(UInt(limit), UInt(p))
end

@inline swap!(v::Vector{UInt}, ix::UInt, jx::UInt) = v[ix], v[jx] = v[jx], v[ix]
