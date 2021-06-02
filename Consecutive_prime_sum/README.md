# Consecutive prime sum

  Problem 50 [Consecutive prime sum](https://projecteuler.net/problem=50)

## Description

The prime 41, can be written as the sum of six consecutive primes:
  - 41 = 2 + 3 + 5 + 7 + 11 + 13

This is the longest sum of consecutive primes that adds to a prime below one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most consecutive primes?


<hr />

Solutions in
  - `Julia` using `YA_PRIMES.jl`

Benchmark

```julia
julia> @time consecutive_prime_sum(10_000)
  0.000027 seconds (10 allocations: 17.641 KiB)
(9521, [3, 5, 7, 11, 13, 17, 19, 23, 29, 31  …  269, 271, 277, 281, 283, 293, 307, 311, 313, 317], 65)

julia> @time consecutive_prime_sum(100_000)
  0.000028 seconds (11 allocations: 20.688 KiB)
(92951, [3, 5, 7, 11, 13, 17, 19, 23, 29, 31  …  1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097], 183)

julia> @time consecutive_prime_sum(1_000_000)
  0.000069 seconds (13 allocations: 35.594 KiB)
(997651, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  3877, 3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931], 543)

julia> @time consecutive_prime_sum(10_000_000)
  0.000206 seconds (16 allocations: 169.000 KiB)
(9951191, [5, 7, 11, 13, 17, 19, 23, 29, 31, 37  …  13309, 13313, 13327, 13331, 13337, 13339, 13367, 13381, 13397, 13399], 1587)

julia> @time consecutive_prime_sum(100_000_000)
  0.002255 seconds (19 allocations: 1.237 MiB)
(99819619, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  45061, 45077, 45083, 45119, 45121, 45127, 45131, 45137, 45139, 45161], 4685)

julia> @time consecutive_prime_sum(10_000_000)
  0.000281 seconds (16 allocations: 169.000 KiB)
(9951191, [5, 7, 11, 13, 17, 19, 23, 29, 31, 37  …  13309, 13313, 13327, 13331, 13337, 13339, 13367, 13381, 13397, 13399], 1587)

julia> @time consecutive_prime_sum(100_000_000)
  0.002096 seconds (19 allocations: 1.237 MiB)
(99819619, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  45061, 45077, 45083, 45119, 45121, 45127, 45131, 45137, 45139, 45161], 4685)

julia> @time consecutive_prime_sum(1_000_000_000)
  0.002336 seconds (20 allocations: 1.433 MiB)
(999715711, [11, 13, 17, 19, 23, 29, 31, 37, 41, 43  …  150967, 150979, 150989, 150991, 151007, 151009, 151013, 151027, 151049, 151051], 13935)

julia> @time consecutive_prime_sum(10_000_000_000)
  0.003894 seconds (22 allocations: 2.395 MiB)
(9999419621, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29  …  502081, 502087, 502093, 502121, 502133, 502141, 502171, 502181, 502217, 502237], 41708)

julia> @time consecutive_prime_sum(100_000_000_000)
  0.027574 seconds (23 allocations: 12.797 MiB)
(99987684473, [19, 23, 29, 31, 37, 41, 43, 47, 53, 59  …  1662121, 1662149, 1662161, 1662163, 1662191, 1662211, 1662217, 1662223, 1662229, 1662257], 125479)

julia> @time consecutive_prime_sum(1_000_000_000_000)
  0.039307 seconds (25 allocations: 17.734 MiB, 5.47% gc time)
(999973156643, [5, 7, 11, 13, 17, 19, 23, 29, 31, 37  …  5476843, 5476847, 5476859, 5476901, 5476909, 5476931, 5476937, 5476943, 5476951, 5476973], 379317)

julia> @time consecutive_prime_sum(10_000_000_000_000)
  0.448165 seconds (27 allocations: 117.422 MiB, 2.72% gc time)
(9999946325147, [5, 7, 11, 13, 17, 19, 23, 29, 31, 37  …  17993263, 17993279, 17993309, 17993333, 17993351, 17993357, 17993377, 17993413, 17993419, 17993449], 1150971)

julia> @time consecutive_prime_sum(100_000_000_000_000)
  0.546649 seconds (28 allocations: 151.373 MiB, 13.98% gc time)
(99999863884699, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29  …  58954201, 58954229, 58954271, 58954279, 58954297, 58954307, 58954327, 58954331, 58954373, 58954381], 3503790)

julia> @time consecutive_prime_sum(1_000_000_000_000_000)
  4.844245 seconds (30 allocations: 1.050 GiB, 0.06% gc time)
(999998764608469, [7, 11, 13, 17, 19, 23, 29, 31, 37, 41  …  192682219, 192682229, 192682253, 192682261, 192682271, 192682277, 192682291, 192682297, 192682307, 192682309], 10695879)
```

<hr />
<p><sub><em>June 2021 Corto Inc</sub></em></p>
