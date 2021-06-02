push!(LOAD_PATH, "../../Exercism/julia/primes/src/")
using YA_PRIMES

function consecutive_prime_sum(n::T) where {T <: Integer}
  limit = T(log(n) ÷ log(10)) ÷ 2 + 2 # heuristic ?
  primes = Primes{T}(10^limit)
  #
  # compute all the sum starting from 1st prime number
  # as the sum and the number of terms need to be maximize start scanning by
  # last candidate prime sum (downto)
  #
  max_sum = zero(T)
  sum_primes = [zero(T)]

  for p ∈ primes
    push!(sum_primes, sum_primes[end] + p)
    sum_primes[end] ≥ n && break
  end

  m = T(length(sum_primes))
  start_ix = one(T)
  nterms = one(T)

  for ix ∈ one(T):m
    for jx ∈ m:T(-1):(ix + nterms)
      psum = sum_primes[jx] - sum_primes[ix]

      if (jx - ix) > nterms && isprime(psum)  #
        psum > n && continue
        max_sum, start_ix, nterms = psum, ix, jx - ix
      end
    end
  end

  (max_sum, v(primes)[start_ix:start_ix + nterms - 1], nterms)
end

# ---------------------- A first benchmark - too slow!
# julia> @time consective_prime_sum(10_000)
#   0.008910 seconds (49.92 k allocations: 15.661 MiB)
# (9521, [3, 5, 7, 11, 13, 17, 19, 23, 29, 31  …  269, 271, 277, 281, 283, 293, 307, 311, 313, 317], 65)

# julia> @time consecutive_prime_sum(100_000)
#   0.163134 seconds (490.22 k allocations: 339.731 MiB, 9.41% gc time)
# (92951, [3, 5, 7, 11, 13, 17, 19, 23, 29, 31  …  1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097], 183)

# julia> @time consecutive_prime_sum(1_000_000)
#   6.825734 seconds (5.42 M allocations: 12.378 GiB, 4.85% gc time)
# (997651, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  3877, 3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931], 543)

# julia> @time consecutive_prime_sum(2_000_000)
#  21.232955 seconds (11.46 M allocations: 36.335 GiB, 3.30% gc time)
# (1999219, [11, 13, 17, 19, 23, 29, 31, 37, 41, 43  …  5653, 5657, 5659, 5669, 5683, 5689, 5693, 5701, 5711, 5717], 749)

# julia> @time consecutive_prime_sum(5_000_000)
#  88.024431 seconds (30.19 M allocations: 140.041 GiB, 2.52% gc time)
# (4975457, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29  …  9203, 9209, 9221, 9227, 9239, 9241, 9257, 9277, 9281, 9283], 1150)


# ---------------------- A second benchmark - still too slow!
# julia> @time consecutive_prime_sum(10_000)
#   0.000316 seconds (1.52 k allocations: 848.375 KiB)
# (9521, [3, 5, 7, 11, 13, 17, 19, 23, 29, 31  …  269, 271, 277, 281, 283, 293, 307, 311, 313, 317], 65)

# julia> @time consecutive_prime_sum(100_000)
#   0.005229 seconds (10.62 k allocations: 15.791 MiB)
# (92951, [3, 5, 7, 11, 13, 17, 19, 23, 29, 31  …  1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097], 183)

# julia> @time consecutive_prime_sum(1_000_000)
#   0.062776 seconds (81.37 k allocations: 342.527 MiB, 22.20% gc time)
# (997651, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  3877, 3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931], 543)

# julia> @time consecutive_prime_sum(10_000_000)
#   0.664440 seconds (675.23 k allocations: 8.030 GiB, 13.65% gc time)
# (9951191, [5, 7, 11, 13, 17, 19, 23, 29, 31, 37  …  13309, 13313, 13327, 13331, 13337, 13339, 13367, 13381, 13397, 13399], 1587)

# julia> @time consecutive_prime_sum(100_000_000)
#  20.069132 seconds (11.56 M allocations: 202.315 GiB, 7.09% gc time)
# (99819619, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  45061, 45077, 45083, 45119, 45121, 45127, 45131, 45137, 45139, 45161], 4685)

# julia> @time consecutive_prime_sum(10_000_000)
#   0.644315 seconds (675.16 k allocations: 8.029 GiB, 14.15% gc time)
# (9951191, [5, 7, 11, 13, 17, 19, 23, 29, 31, 37  …  13309, 13313, 13327, 13331, 13337, 13339, 13367, 13381, 13397, 13399], 1587)

# julia> @time consecutive_prime_sum(100_000_000)
#  18.991867 seconds (11.56 M allocations: 202.313 GiB, 6.90% gc time)
# (99819619, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  45061, 45077, 45083, 45119, 45121, 45127, 45131, 45137, 45139, 45161], 4685)

# ---------------------- A better benchmark (more pruning)

# cf. README for better benchmark
