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
  power = fill(0, N+1)
  #     [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
  #  ix: 1  2  3  4   5   6   7   8   9  10
  for d ∈ 2:N+1; power[d] = (d-1)^n; end

  nfound, sum_ = 0, 0
  range_ = max(10, 10^(n-2)):9^(n+1)
  with_print && println("\trange $(range_)")

  for num ∈ range_
    sa = fill(0, n+2) # number of digits
    num_cp, ix = num, 1
    while num_cp > 0
      (num_cp, d) = divrem(num_cp, 10)
      sa[ix] = d
      ix += 1
    end

    if num == reduce((s, d) -> s += power[d+1], sa; init=0)
      # found one...
      nfound += 1
      sum_ += num
      if with_print
        repr = [string(d, "^", n) for d ∈ reverse(sa[1:end])] |> s -> join(s, " + ")

        while repr[1] == '0' # starts with char. 0
          repr = repr[6+length(string(n)):end]
          # why 6? "0^8 + "
          #         2 (for 0^) + len(str(8)) + 3 for " + " + 1
        end
        println("\t$(num) == $(repr)")
      end
    end
  end

  (nfound, sum_)
end
