const BASE_CIRCULAR_PRIMES = [2, 3, 5, 7, 11, 13, 17]
const DT = UInt

function circular_primes(n::Integer)
  n < 0 && throw(ArgumentError("Expecting a positive integer"))
  circular_primes(DT(n))
end

circular_primes(::Any) = throw(ArgumentError("Expecting a positive integer"))

"""
   Build all primes p ≤ n, ∀ p check if p is circular

   the number of circular rotations of p is a function of the number of its digits,
   ie if p is m-digits number, the number of circular rotation is m

   ex. 197 ⇒ 971 ⇒ 719
"""
function circular_primes(n::DT)::Integer
  # for 100, 500, 900 -> max num can be 9xx - thus need all primes under 1000
  lim = DT(floor(log(n) / log(DT(10)))) + DT(1) # number of digits + 1

  primes = sieve(DT(10)^lim)
  m = zero(DT)

  for p ∈ primes
    p > n && break # generated more primes to account for circular rotations
    cp = circular_rotation(p)

    all_primes = true
    for x ∈ cp[1:end - 1] # last one is prime because it is p iteself
      if x ∉ primes
        all_primes = false
        break # early stopping
      end
    end
    all_primes && (m += DT(1))
  end

  m
end

function circular_rotation(n::DT)::Vector{DT}
  sn = string(n)
  m = length(sn)
  v = fill(zero(DT), m)
  for ix ∈ 1:m
    sn = string(sn[2:end], sn[1])
    v[ix] = parse(DT, sn)
  end
  v
end

function sieve(limit::DT)::Vector{DT}
  limit <= DT(1) && (return [])
  limit == DT(2) && (return [DT(2)])

  ary = fill(true, limit)
  one, two = DT(1), DT(2)
  ary[one] = false ## exclude 1
  cand, ix = two, DT(3)  ## start with 2, and prep. for next candidate

  ## upper limit for candidate prime (cand)
  rlimit = convert(DT, ceil(√limit))
  while cand ≤ rlimit
    ## eliminate
    for jx in two*cand:cand:limit
      ary[jx] = false
    end
    ## select next prime candidate
    while !ary[ix]; ix += one; end
    cand = ix
    ix += one
  end

  [ix for ix in two:limit if ary[ix]]
end

## slower and more allocations consuming
# function sieve(limit::DT)::Vector{DT}
#   limit <= DT(1) && (return [])
#   limit == DT(2) && (return [DT(2)])

#   ary = fill(true, limit)
#   ary[1] = false   ## exclude 1
#   one, two = DT(1), DT(2)
#   cand, ix = two, DT(3)  ## start with 2, and prep. for next candidate

#   ## upper limit for candidate prime (cand)
#   rlimit = convert(DT, ceil(√limit))
#   while cand ≤ rlimit
#     ## eliminate
#     for jx in two*cand:cand:limit
#       ary[jx] = false
#     end
#     ## select next prime candidate
#     while !ary[ix]; ix += one; end
#     cand = ix
#     ix += one
#   end
#   num_cand = sum(ary)

#   ## build actual array, first pre-allocate array
#   n_ary, jx = Vector{DT}(undef, num_cand), one

#   ## then fill it
#   for ix in two:limit
#     ary[ix] && (n_ary[jx] = ix; jx += one)
#   end

#   n_ary
# end
