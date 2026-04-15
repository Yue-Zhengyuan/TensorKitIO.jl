"""
Load `CTMRGEnv` from folder
"""
function load_CTMRGEnv(folder::AbstractString, Nrow::Int, Ncol::Int)
    @assert endswith(folder, "/")
    corners = collect(
        load_tensor(folder * "c$n-$r$c.jld2") for
            (n, r, c) in Iterators.product(1:4, 1:Nrow, 1:Ncol)
    )
    edges = collect(
        load_tensor(folder * "t$n-$r$c.jld2") for
            (n, r, c) in Iterators.product(1:4, 1:Nrow, 1:Ncol)
    )
    return CTMRGEnv(corners, edges)
end

"""
Load `CTMRGEnv` from folder
"""
function save_CTMRGEnv(folder::AbstractString, env::CTMRGEnv)
    @assert endswith(folder, "/")
    for ind in CartesianIndices(env.corners)
        (n, r, c) = Tuple(ind)
        save_tensor(folder * "c$n-$r$c.jld2", env.corners[ind])
        save_tensor(folder * "t$n-$r$c.jld2", env.edges[ind])
    end
    return
end
