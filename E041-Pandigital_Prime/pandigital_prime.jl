const BASE_CIRCULAR_PRIMES = [2, 3, 5, 7, 11, 13, 17]
const DT = UInt


function pandigital_prime(n::Integer)::Integer
  (n <1 || n > 9) && throw(ArgumentError("Expecting 1 ≤ n ≤ 9, got $(n)"))

  cprimes = calc_primes(DT(10^n))
  primes = filter_primes(cprimes, n)

  for ix ∈ length(primes):-1:1
    cp = Int(primes[ix])
    is_pandigital(cp, n) && (return cp)
  end

  -1 # no pandigital prime found
end

pandigital_prime(::Any) = throw(ArgumentError("Expecting 1 ≤ n ≤ 9"))

function is_pandigital(n::Integer, ndigits::Integer)::Bool
  n < 10^(ndigits - 1) && (return false)

  vb = fill(false, ndigits)
  q = n
  while q > 0
    q, r = divrem(q, 10)
    r > ndigits && (return false)
    r == 0 && (return false)
    vb[r] && (return false) # early return
    vb[r] = true
  end
  all(vb)
end

function calc_primes(limit::DT)::Vector{Bool}
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

  ary
end

function filter_primes(ary::Vector{Bool}, ndigits)
  ## find lower bound
  ulim = DT(10)^(ndigits - 1) - 1
  l_jx = findfirst((t) -> ary[t[1]] && t[1] > ulim,
                   enumerate(ary) |> collect)
  l_jx === nothing && (return [])

  ## increase the lower bound if candidate prime contains 0
  found = false
  for ix ∈ l_jx:length(ary)
    if ary[ix] && !contains_0(ix)
      l_jx = ix
      found = true
      break
    end
  end

  ## exhausted all primes?
  !found && (return [])

  ## find upper bound
  slim = ""
  for ix in ndigits:-1:1; slim = string(slim, ix); end
  ulim = parse(Int, slim)
  u_jx = findfirst((t) -> ary[t[1]] && t[1] > ulim,
                   enumerate(ary[l_jx:end]) |> collect)
  u_jx === nothing && (return [])

  ## TODO: decrease upper bound if candidate prime contains 0

  [ix for ix in l_jx:u_jx if ary[ix]]
end

contains_0(n::Integer)::Bool = "0" ∈ (ary = string(n) |> s -> split(s, ""))
