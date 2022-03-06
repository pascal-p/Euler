const T = UInt

"""
   number_spiral_diagonal(n::T)::T

Calculate the sum of the 2 diagonals given integer n, which represents a square (matrix)
Example:
21 22 23 24 25
  \\       /
20  7  8  9 10
     \\ /
19  6  1  2 11
     /  \\
18  5  4  3 12
  /        \\
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

```julia-repl
julia> number_spiral_diagonal(5)
101
```
"""
function number_spiral_diagonal(n::T)::T
  u, v, k = one(T), one(T), T(4)
  s = zero(T)

  for ix ∈ T(2):n
    u += T(2) * (ix - 1)
    v += k
    isodd(ix) && (k += T(4))
    s += u + v
  end
  s += 1
end

function number_spiral_diagonal(n::ST)::T where {ST <: Integer}
  n < 0 && throw(ArgumentError("Expecting a natural integer"))
  number_spiral_diagonal(T(n))
end

number_spiral_diagonal(::Any) = throw(ArgumentError("Expecting a natural integer"))
