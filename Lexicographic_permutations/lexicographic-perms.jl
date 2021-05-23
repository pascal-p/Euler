const VT = Vector
const VVT = Vector{VT}


millionnth(coll::VT) = all_perms(coll::VT, 1_000_000)[end]


function all_perms(coll::VT)::VVT
  length(coll) == 0 && return [[]]
  length(coll) == 1 && return [coll]
  length(coll) == 2 && return [coll, coll |> reverse]

  # length of coll ≥ 3
  perms = VVT([])

  for d ∈ coll
    coll_d = filter(x -> x != d, coll)
    _perms = prepend_all!(d, all_perms(coll_d))  # rec. call
    push!(perms, _perms...)
  end

  return perms
end

function all_perms(coll::VT, limit)::VVT
  length(coll) == 0 && return [[]]
  length(coll) == 1 && return [coll]
  length(coll) == 2 && return [coll, coll |> reverse]

  limit == 0 && return [[]]

  # length of coll ≥ 3
  perms = VVT([])

  for d ∈ coll
    coll_d = filter(x -> x != d, coll)
    _perms = prepend_all!(d, all_perms(coll_d, limit - 1))  # rec. call
    push!(perms, _perms...)
  end

  return perms
end


function prepend_all!(item, perms::VVT)::VVT
  for perm ∈ perms
    pushfirst!(perm, item)
  end

  perms
end

prepend_all!(item::T, perms::Vector{Vector{T}}) where T <: Integer = prepend_all!(item, VVT(perms))

prepend_all!(item::T, perms::Vector{Vector{T}}) where T <: Any = prepend_all!(T(item), VVT(perms))

prepend_all!(item::T, perms::Vector{Vector{Any}}) where T <: Any = prepend_all!(item, VVT(perms))
