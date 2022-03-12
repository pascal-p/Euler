"""
  n² + a⨱n + b, where |a| < 1000 and |b|  ≤ 1000
  max will be n*n + 999n + 1000

  as we get all primes form n =0 upto a limit, we have:

  n = 0 ⟹ n² + a⨱n + b = b,  b must be a prime
  n = 1 ⟹ n² + a⨱n + b = 1 + a + b, 2 cases:
    (i) b = 2  ⟹ 3 + a must be prime ⟹ a is even
    (ii) b > 2 ⟹ (1 + b) + a must be prime ⟹ a is odd (as 1 + b is even)
"""

function quadratic_primes(limit::T) where {T <: Integer}
  primes = sieve((2 * (limit - 1) -1) * (2 * limit - 1))
  @inline function is_prime(candidate::T)::Bool # where {T <: Integer}
    ix = one(T)
    while primes[ix] < candidate; ix += 1; end
    ix ≤ length(primes) ? primes[ix] == candidate : false
  end

  a_b_n = (zero(T), zero(T), zero(T))
  bprimes = sieve(limit)
  for a ∈ -limit+1:2:limit-1
    for b ∈ bprimes[1]     # case (i)
      n = zero(T)
      while is_prime(abs(n * n + (a + 1) * n + b)); n += 1; end
      n > a_b_n[end] && (a_b_n = (a + 1, b, n))
    end

    for b ∈ bprimes[2:end] # case (ii)
      n = zero(T)
      while is_prime(abs(n * n + a * n + b)); n += 1; end
      n > a_b_n[end] && (a_b_n = (a, b, n))
    end
  end

  (a_b_n[1:2]..., prod(a_b_n[1:2]), a_b_n[end])
end


# "brute force"
function quadratic_primes_bf(range::T) where {T <: Integer}
  primes = sieve((2 * (range - 1) -1) * (2 * range - 1))
  @inline function is_prime(candidate::T)::Bool
    ix = one(T)
    while primes[ix] < candidate; ix += 1; end
    ix ≤ length(primes) ? primes[ix] == candidate : false
  end

  aₘ, bₘ, nₘ = zero(T), zero(T), zero(T)
  for a ∈ -range+1:range-1, b ∈ -range:range
    n = zero(T)
    while is_prime(abs(n * n + a * n + b)); n += 1; end
    n > nₘ && ((nₘ, aₘ, bₘ) = (n, a, b))
  end

  (aₘ, bₘ, aₘ * bₘ, nₘ)
end


# @inline function is_prime(primes::Vector{T}, candidate::T)::Bool where {T <: Integer}
#   ix = one(T)
#   while primes[ix] < candidate; ix += 1; end
#   ix ≤ length(primes) ? primes[ix] == candidate : false
# end


function sieve(limit::T)::Vector{T} where {T <: Integer}
  limit <= 1 && (return [])
  limit == 2 && (return [2])

  ary = fill(true, limit)
  ary[1] = false   ## exclude 1
  cand, ix = 2, 3  ## start with 2, and prep. for next candidate

  ## upper limit for candidate prime (cand)
  rlimit = T(ceil(√limit))

  while cand ≤ rlimit
    ## eliminate
    for jx ∈ 2*cand:cand:limit; ary[jx] = false end

    ## next candidate prime
    while !ary[ix]; ix += 1; end
    cand = ix

    ## next
    ix += 1
  end

  num_cand = sum(ary) # how many prime

  ## build actual array, first pre-allocate array
  primes, jx = Array{Int,1}(undef, num_cand), 1
  for ix ∈ 2:limit
    ary[ix] && (primes[jx] = ix; jx += 1)
  end

  primes
end

# function sieve(limit::T) where {T <: Integer}
#   ## considering 0 as a natural integer
#   limit < 0 && throw(ArgumentError("Expecting a natural integer"))

#   DT = typeof(limit)
#   if DT ≡ Int8
#     sieve(UInt8(limit))
#   elseif DT ≡ Int16
#     sieve(UInt16(limit))
#   elseif DT ≡ Int32
#     sieve(UInt32(limit))
#   elseif DT ≡ Int64
#     sieve(UInt64(limit))
#   elseif DT ≡ Int128
#     sieve(UInt128(limit))
#   else
#     throw(ArgumentError("type $(DT) not yet handled"))
#   end
# end

sieve(::Any) = throw(ArgumentError("Expecting a natural integer"))
