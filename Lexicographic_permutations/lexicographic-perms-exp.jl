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
  @assert(limit ≤ LIMIT && p ≤ FACT_20,
          "limit: $(limit) ≤ $(LIMIT) && p $(p) ≤ $(FACT_20)")
  @assert(p ≤ Base.factorial(limit), "p should nbe less than factorial(limit)")

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
  @assert(limit > 0 && p > 0, "limit and p must be natural integers")

  nth_perm(UInt(limit), UInt(p))
end

@inline swap!(v::Vector{UInt}, ix::UInt, jx::UInt) = v[ix], v[jx] = v[jx], v[ix]

"""
   Alternative - using factorial number system (cf. https://en.wikipedia.org/wiki/Factorial_number_system)

The method is described here: https://en.wikipedia.org/wiki/Factorial_number_system#Permutations

ex. 1_000_000 in factorial number system is 2662512200
now start with the digit (say d) at the rightmost position, prepend it to prev. digits after incrementing all
these digits if they are ≥ d

          0   - start with 0
         01   - next prepend 0 to (0+1)
        201   - next prepend 2 to 01 (no inc, because both 0 and 1 < 2)
       2301   - next prepend 2 to 2+1 0 1
      13402   - next prepend 1 to 2+1 3+1 0 1+1
     513402   ...
    2614503
   62714503
  672814503
 2783915604


Other way, take 2662512200 and the set (to permut.) 0123456789

  ix: 012              (index is 2 starting at 0, hence 012)
perm: 0123456789 -> 2
  ix: 0123456          (index is 6 starting at 0, hence 0123456)
perm: 013456789  -> 7
  ix: 0123456          (index is 6 starting at 0, hence 0123456)
perm: 01345689   => 8
  ix: 012              ...
perm: 0134569    => 3
  ix: 012345           (index is 5 starting at 0, hence 012345)
perm: 014569     => 9
  ix: 01               ...
perm: 01456      => 1
  ix: 012              ...
perm: 0456       => 5
  ix: 012              ...
perm: 046        => 6
  ix: 0                ...
perm: 04         => 4
  ix: 0                ...
perm: 0          => 0

"""

function nth_perm_alt1(limit::UInt, p::UInt)::String
  @assert(p ≤ Base.factorial(limit), "p should be less than factorial(limit)")
  @assert(limit ≤ LIMIT && p ≤ FACT_20,
          "limit: $(limit) ≤ $(LIMIT) && p $(p) ≤ $(FACT_20)")

  n_fb = to_factorial_base(p)
  perm = zeros(UInt, limit)
  ix = limit

  for sd ∈ length(n_fb):-1:1
    d = parse(UInt, n_fb[sd])

    for jx ∈ limit:-1:ix
      perm[jx] ≥ d && (perm[jx] += 1)
    end

    perm[ix] = d
    ix -= 1
  end

  join(perm)
end

function nth_perm_alt1(limit::Integer, p::Integer)::String
  limit > 0 && p > 0 && (return nth_perm_alt1(UInt(limit), UInt(p)))
  throw(ArgumentError("Expecting limit, p to be natural integers"))
end

"""
   to_factorial_base(p::UInt)::String

Convert given p into factorial base system (expressed as a string)

Examples
```julia-repl
to_factorial_base(1_000_000)
"2662512200"
```
"""
function to_factorial_base(p::UInt)::String
  p > FACT_20 && throw(ArgumentError("Limit is fixed at $(FACT_20)"))

  d = one(UInt)
  s = ""
  while p > zero(UInt)
    p, r = divrem(p, d)
    s = string(r, s)
    d += one(UInt)
  end

  s
end

function to_factorial_base(p::Integer)::String
  (p < 0) && throw(ArgumentError("Expecting p to be a natural integer"))
  to_factorial_base(UInt(p))
end
