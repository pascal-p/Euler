# Lexicographic permutations

  Problem 24 [Lexicographic permutations](https://projecteuler.net/problem=24)

## Description
A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order.

The lexicographic permutations of 0, 1 and 2 are:
  - 012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?


<hr />

Solutions in
  - `Julia`
  - `Python`
  - `Javascript`

<hr />

For julia, testing can be called as follows (assuming a project was set up) from current dir. `Projects/Euler/Lexicographic_permutations`:

> julia --project=.. runtests-lp.jl  # for lexicographic-perms.jl

> julia --project=.. runtests.lpe.jl # for lexicographic-perms-exp.jl

```julia-repl
@time all_perms_nr(10, 1_000_000)
  0.004265 seconds (25 allocations: 1.297 KiB)
"2783915604"
```

<p><sub><em>April-May 2021 Corto Inc</sub></em></p>
