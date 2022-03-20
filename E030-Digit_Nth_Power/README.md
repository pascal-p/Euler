# Digit fifth powers

  Problem 30 [Digit fifth powers](https://projecteuler.net/problem=30)

## Description

Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

    1634 = 1⁴ + 6⁴ + 3⁴ + 4⁴
    8208 = 8⁴ + 8⁴ + 0⁴ + 8⁴
    9474 = 9⁴ + 4⁴ + 7⁴ + 4⁴

As 1 = 1⁴ is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

<hr />

Solutions in
  - `Julia`

<hr />

For julia, testing can be called as follows (assuming a project was set up) from current dir. `Projects/Euler/E030-Digit_Nth_Power`:

> julia --project=.. runtests.jl

```julia-repl
julia> digit_nth_power(7)
(5, 40139604)
```

<p><sub><em>Mar 2022 Corto Inc</sub></em></p>
