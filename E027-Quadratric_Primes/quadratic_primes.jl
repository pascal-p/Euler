function quadratic_primes(range::T) where {T <: Integer}
  aₘ, bₘ, nₘ = zero(T), zero(T), zero(T)
  primes = sieve(range * range * 4)

  for a ∈ -range+1:range-1, b ∈ -range:range
    n = zero(T)
    while is_prime(primes, abs(n * n + a * n + b)); n += 1; end

    if n > nₘ
      nₘ = n
      aₘ = a
      bₘ = b
    end
  end

  (aₘ, bₘ, aₘ * bₘ)
end


function is_prime(primes::Vector{T}, candidate::T)::Bool where {T <: Integer}
  ix = one(T)
  while primes[ix] < candidate; ix += 1; end
  ix ≤ length(primes) ? primes[ix] == candidate : false
end


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
