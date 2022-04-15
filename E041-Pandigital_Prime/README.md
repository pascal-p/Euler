# Pandigital Prime

  Problem 41 [Pandigital Prime](https://projecteuler.net/problem=41)

## Description

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?

<hr />

Solutions in
  - `Julia`

<hr />

For julia, testing can be called as follows (assuming a project was set up) from current dir. `Projects/Euler/E041-Pandigital_Prime`:

> julia --project=.. runtests.jl

```julia-repl
julia> pandigital_prime(7)
7652413
```

<p><sub><em>Apr 2022 Corto Inc</sub></em></p>
