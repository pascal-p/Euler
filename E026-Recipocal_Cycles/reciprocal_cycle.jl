const T = UInt

"""
TBD...
Euler Problem 26: https://projecteuler.net/problem=26

Example:
A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

    1/2	= 	0.5
    1/3	= 	0.(3)
    1/4	= 	0.25
    1/5	= 	0.2
    1/6	= 	0.1(6)
    1/7	= 	0.(142857)
    1/8	= 	0.125
    1/9	= 	0.(1)
    1/10	= 	0.1

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.
"""

# NOTE: failed sometimes - ex:

# #reciprocal_cycles: Test Failed at /home/pascal/Projects/Euler/E026-Recipocal_Cycles/runtests.jl:18
#   Expression: reciprocal_cycles(900) == 887
#    Evaluated: 0x000000000000003d == 887

function reciprocal_cycles(n::T)::T
  rest = Vector{Int}(undef, n)
  len = zero(T)
  for d ∈ n:-1:one(T)
    len ≥ d && break
    num, ix, r = one(T), one(T), one(T)
    while r ≠ zero(T) && r ∉ rest[1:ix - one(T)]
      _, r = divrem(num, d)
      ix += one(T)
      rest[ix] = r
      num = r * T(10)
    end
    len = r == zero(T) ? ix : ix - one(T)
  end

  len
end

function reciprocal_cycles(n::S)::T where S <: Integer
  n < 0 && throw(ArgumentError("Expecting a natural integer"))
  reciprocal_cycles(T(n))
end

reciprocal_cycles(::Any) = throw(ArgumentError("Expecting a natural integer"))

function reciprocal_cycles_with_dev(n::T)::Tuple{T, String}
  rest = Vector{Int}(undef, n)

  len, s = -1, ""
  for d ∈ n:-1:one(T)
    len ≥ d && break

    s = ""
    num, ix, r = one(T), one(T), one(T)
    while r ≠ zero(T) && r ∉ rest[1:ix - one(T)]
      q, r = divrem(num, d)
      ix += one(T)
      rest[ix] = r
      s = string(s, q)
      num = r * T(10)
    end

    # s = r == zero(T) ? string(s[1], ".", s[2:end - 1]) : string(s[1], ".", s[2:end])
    s = string(s[1], ".", s[2:end])
    len = length(s) - 2
  end

  (len, s)
end

function reciprocal_cycles_with_dev(n::S)::Tuple{T, String} where S <: Integer
  n <0  && throw(ArgumentError("Expecting a natural integer"))
  reciprocal_cycles_with_dev(T(n))
end

reciprocal_cycles_with_dev(::Any) = throw(ArgumentError("Expecting a natural integer"))
