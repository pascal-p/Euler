### A Pluto.jl notebook ###
# v0.19.3

using Markdown
using InteractiveUtils

# ╔═╡ 76ae6259-ee38-4c70-ad9d-013dadc97a69
begin
	using PlutoUI
	PlutoUI.TableOfContents(indent=true, depth=4, aside=true)
end

# ╔═╡ a768c8a8-ce53-11ec-27b2-2d58744be722
md"""
### E008 - Largest product in a series
"""

# ╔═╡ 235e8f81-d8bb-4b27-af08-f993b2d1f050
md"""
Given a string 1000-digit number:

0. Find the greatest product of four consecutive digits in the 1000-digit number. (warm up)
1. Find the greatest product of five consecutive digits in the 1000-digit number.
2. Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?
"""

# ╔═╡ b72f0a35-4c16-4659-9c6e-db132f0eae0d
const SERIE1000 = """
73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450
""" |> s -> split(s, "\n") |> a -> join(a)

# ╔═╡ 4221e56f-d664-46f5-bd3b-179c8149eb3b
const SERIE18 = "134506207689915732"

# ╔═╡ 7952c915-8401-4a0d-8338-beb54e1730f2
md"""
#### 1. Brute Force approach 
"""

# ╔═╡ 4391bbf3-48c2-4fc7-b4e7-f6402622ebdd
function largest_bf(serie::String, len::Int; verbose=false)
	largest = 0
	for ix ∈ 1:length(serie) - len
		prod = 1
		for jx ∈ 0:len - 1
			d = parse(Int64, serie[ix + jx])
			d == 0 && break
			prod *= d
			# verbose && print("$(d) x ")
		end
		# verbose && println(" => $(prod)")
		prod > largest && (largest = prod)
	end
	largest
end

# ╔═╡ c3383019-53f8-4168-a662-2027b7416d9a
@time @show largest_bf(SERIE18, 4)

# ╔═╡ a72ccbc7-47d2-446d-b9ba-50e2eb927eb8
@time @show largest_bf(SERIE18, 5; verbose=true)

# ╔═╡ fcb361e5-f020-46e8-8b83-23d87fb0b8fe
@time @show largest_bf(SERIE1000, 5)

# ╔═╡ 322ae6a9-ebef-4ea6-b71e-d1a7f6ad6608
@time @show largest_bf(SERIE1000, 6)

# ╔═╡ 4ae19c5c-8328-4746-828e-9351769932e3
@time @show largest_bf(SERIE1000, 13)

# ╔═╡ b48b02fa-2f7b-41da-9e04-f277e256ba0a
md"""
#### 2. Less of a Brute Force approach

Skipping ahead id 0 if found
"""

# ╔═╡ 8d910572-bb95-4088-abec-9b01cb97ca7d
function largest_v2(serie::String, len::Int; verbose=false)
	largest = 0
	ix, limit = 1, length(serie) - len
	offset = 1
	while ix ≤ limit
		prod = 1
		for jx ∈ 0:len - 1
			d = parse(Int64, serie[ix + jx])
			if d == 0
				# skipping the 0 in a product
				prod = 0
				offset = jx + 1
				break
			end
			prod *= d
			# verbose && print("$(d) x ")
		end

		if prod > 0 
			# verbose && println(" => $(prod)")
			prod > largest && (largest = prod)
			ix += 1
		else
			ix += offset
		end
	end

	largest
end

# ╔═╡ 26977398-ea06-4df4-9083-0c89299e74e1
@time @show largest4b = largest_v2(SERIE18, 4; verbose=true)

# ╔═╡ 95976c79-1267-47c3-bb03-ab631406a2e7
@time @show largest_v2(SERIE18, 5; verbose=true)

# ╔═╡ 9d24e1b5-f2af-440d-b289-0d8fbf63f8db
@time @show largest_v2(SERIE1000, 5)

# ╔═╡ 873c490f-7a30-433a-abcb-6a754d9f8eae
@time @show largest_v2(SERIE1000, 6)

# ╔═╡ 60798404-1572-4792-a9c2-41b25e5e4555
@time @show largest_v2(SERIE1000, 13)

# ╔═╡ 4a38b070-62f5-4641-8388-973ef9696d17
md"""
#### 3. DP approach

[DP] Dynamic Programming
"""

# ╔═╡ e4d7fa37-c50d-4af8-b7f5-9ab7f5ff3e43
function largest_dp(serie::String, len::Int)
	largest, zeros = 0, 0
	prod = 1
	
	for ix ∈ 1:length(serie)
		if ix > len
			# need to update product by "cancelling" effect of leftmost digit in the multiplication
			# need to avoid division by zero!
			old_digit = serie[ix - len]
			if old_digit == '0'
				zeros -= 1
			else
				prod ÷= old_digit - '0' # using ascii offset, rather than parsing
			end
		end
		
		# serie[ix] is our next digit - either it is a 0 or not
		if serie[ix] == '0'
			zeros += 1
		else
			prod *= serie[ix] - '0'
		end

		if ix > len && zeros == 0 && prod > largest
			largest = prod
		end
	end

	largest
end

# ╔═╡ a099df62-c378-4a18-94ab-eec5859837aa
@time @show largest_dp(SERIE18, 5)

# ╔═╡ 87042eb0-a9cf-4b9a-a00b-42f6b0de9027
@time @show largest_dp(SERIE18, 5)

# ╔═╡ 2e71b71c-4d07-4d8d-a737-661f798f2934
@time @show largest_dp(SERIE1000, 5)

# ╔═╡ 15d56db3-e3c3-4a08-b872-7174380a38fb
@time @show largest_dp(SERIE1000, 6)

# ╔═╡ 994395c2-32bc-4ebe-a01d-1294e78ee1c4
@time @show largest_dp(SERIE1000, 13)

# ╔═╡ 7571e02b-08f8-4d82-ba35-72ea41e16a3d
html"""
<style>

  main {
    max-width: calc(900px + 25px + 6px);
  }

  .plutoui-toc.aside {
    background-color: black;
	color: linen;
  }

  h4, h5 {
	background-color: black;
    color: wheat;
	text-decoration: underline overline dotted darkred;
  }
</style>
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "1285416549ccfcdf0c50d4997a94331e88d68413"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "670e559e5c8e191ded66fa9ea89c97f10376bb4c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.38"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─a768c8a8-ce53-11ec-27b2-2d58744be722
# ╟─76ae6259-ee38-4c70-ad9d-013dadc97a69
# ╟─235e8f81-d8bb-4b27-af08-f993b2d1f050
# ╠═b72f0a35-4c16-4659-9c6e-db132f0eae0d
# ╠═4221e56f-d664-46f5-bd3b-179c8149eb3b
# ╟─7952c915-8401-4a0d-8338-beb54e1730f2
# ╠═4391bbf3-48c2-4fc7-b4e7-f6402622ebdd
# ╠═c3383019-53f8-4168-a662-2027b7416d9a
# ╠═a72ccbc7-47d2-446d-b9ba-50e2eb927eb8
# ╠═fcb361e5-f020-46e8-8b83-23d87fb0b8fe
# ╠═322ae6a9-ebef-4ea6-b71e-d1a7f6ad6608
# ╠═4ae19c5c-8328-4746-828e-9351769932e3
# ╟─b48b02fa-2f7b-41da-9e04-f277e256ba0a
# ╠═8d910572-bb95-4088-abec-9b01cb97ca7d
# ╠═26977398-ea06-4df4-9083-0c89299e74e1
# ╠═95976c79-1267-47c3-bb03-ab631406a2e7
# ╠═9d24e1b5-f2af-440d-b289-0d8fbf63f8db
# ╠═873c490f-7a30-433a-abcb-6a754d9f8eae
# ╠═60798404-1572-4792-a9c2-41b25e5e4555
# ╟─4a38b070-62f5-4641-8388-973ef9696d17
# ╠═e4d7fa37-c50d-4af8-b7f5-9ab7f5ff3e43
# ╠═a099df62-c378-4a18-94ab-eec5859837aa
# ╠═87042eb0-a9cf-4b9a-a00b-42f6b0de9027
# ╠═2e71b71c-4d07-4d8d-a737-661f798f2934
# ╠═15d56db3-e3c3-4a08-b872-7174380a38fb
# ╠═994395c2-32bc-4ebe-a01d-1294e78ee1c4
# ╟─7571e02b-08f8-4d82-ba35-72ea41e16a3d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
