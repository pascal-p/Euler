const FACT = [
  factorial(n) for n in 0:9
]

"""
  cf. https://projecteuler.net/problem=34

  145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

  Find the numbers and the sum of the numbers which are equal to the sum of the factorial of their digits.

  Note: as 1! = 1 and 2! = 2 are not sums they are not included.
"""
function digit_factorials()
  sols = []
  for n in 10:sum(FACT)
    q, s = n, 0

    while q > 0
      (q, r) = divrem(q, 10)
      s += FACT[r + 1]
      s > n && break
    end

    s == n && push!(sols, n)
  end

  (length(sols), sols, sum(sols))
end
