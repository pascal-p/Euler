const TIVN = Tuple{Int, Union{Vector, Nothing}}

function read_input(input::Vector)::Matrix{Int}
  n = length(input)
  dist = fill(zero(Int), n, n)

  for (rix, row) ∈ input |> enumerate
    for (cjx, col) ∈ split(row, r"\s+") |> enumerate
      dist[rix, cjx] = parse(Int, col)
    end
  end

  dist
end

function max_path(d::Matrix{Int}; show_path=false)::TIVN
  """
  Start from penultimate row downto 1st row using max. from
  2 possible cells (from the row below)
  """
  for prow_ix ∈ size(d)[1] - 1:-1:1   # penultimate row index
    for cjx ∈ 1:prow_ix
      d[prow_ix, cjx] += max(d[prow_ix + 1, cjx], d[prow_ix + 1, cjx + 1])
    end
  end

  show_path ? (d[1, 1], find_path(d)) : (d[1, 1], nothing)
end

function find_path(d::Matrix{Int})::Vector
  path = [(1, 1)]

  for row ∈ 2:size(d)[1]
    push!(path, coord_max(d, path[end]))
  end

  path
end

function coord_max(d, coord)
  (x, y) = coord
  d[x + 1, y] > d[x + 1, y + 1] ? (x + 1, y) : (x + 1, y + 1)
end

function calc_max_path(input::AbstractString; show_path=false)::TIVN
  vstr = if occursin(".txt", input)
    # file
    open(input) do f
      readlines(f)
    end
  else
    split(input, "\n")
  end

  vstr .|>
    strip |>
    a -> filter(s -> length(s) > 0, a) .|>
    String |>
    read_input |>
    d -> max_path(d; show_path)
end
