"""
   E030 - Digit fifth powers
"""

const N = 9

function digit_nth_power_range()
  ary = fill(0, N)
  sum_ = fill(0, N)

  for n ∈ 2:N
    println("$(n): ")
    ary[n], s_ = digit_nth_power(n; with_print=true)
    sum_[n] = s_
  end

  ary, sum_, sum(ary)
end

function digit_nth_power(n::T; with_print=false) where {T <: Integer}
  lim = min(9^(n+1), Int(10^n * 3.35)) # not such a great heuristic!
  power = fill(0, N+1)
  #     [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
  #  ix: 1  2  3  4   5   6   7   8   9  10
  for d ∈ 2:N+1; power[d] = (d-1)^n; end
  nfound, sum_ = 0, 0
  range_ = max(10, 10^(n-2)):lim
  with_print && println("range $(range_)")

  for num ∈ range_
    sa = fill(0, n+2) # number of digits
    num_cp, ix = num, 1
    while num_cp > 0
      (num_cp, d) = divrem(num_cp, 10)
      sa[ix] = d
      ix += 1
    end
    m = reduce((s, d) -> s += power[d+1], sa;
               init=0)
    if num == m
      nfound += 1 # found one...
      sum_ += num
      with_print && print_repr(sa, n, num)
    elseif m > lim
      println(" case n: $(2) m is: $(m), num: $(num) - lim: $(lim)? ")
      break
    end
  end

  (nfound, sum_)
end

@inline function print_repr(sa, n, num)
  repr = [string(d, "^", n) for d ∈ reverse(sa[1:end])] |> s -> join(s, " + ")
  while repr[1] == '0' # starts with char. 0
    repr = repr[6+length(string(n)):end]
    # why 6? "0^8 + "
    #         2 (for 0^) + len(str(8)) + 3 for " + " + 1
  end
  println("\t$(num) == $(repr)")
end
