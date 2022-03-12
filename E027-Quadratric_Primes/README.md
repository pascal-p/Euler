# Quadratic primes

  Problem 27 [Quadratic primes](https://projecteuler.net/problem=27)

## Description
Euler discovered the remarkable quadratic formula: n² + n + 41

It turns out that the formula will produce 40 primes for the consecutive integer values 0 ≤ n ≤ 39. However, when n = 40, 40² + 40 + 41 = 40 × (40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.

The incredible formula n² - 79n + 1601 was discovered, which produces 80 primes for the consecutive values 0 ≤ n ≤ 79. The product of the coefficients, −79 and 1601, is −126479.

Considering quadratics of the form: n² + a⨱n + b, where |a| < 1000 and |b|  ≤ 1000

where |n| is the modulus/absolute value of n
e.g. |11| = 11 and |-4|=4

Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n=0.
<hr />

Solutions in
  - `Julia`

<hr />

For julia, testing can be called as follows (assuming a project was set up) from current dir. `Projects/Euler/Lexicographic_permutations`:

> julia --project=.. runtests-bf.jl  # for quadratic_primes_bf.jl

> julia --project=.. runtests.jl     # for quadratic_primes.jl

```julia-repl
```

<p><sub><em>Mar 2022 Corto Inc</sub></em></p>
