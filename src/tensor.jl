"""
Load a single tensor
"""
function load_tensor(filename::AbstractString)
    @assert endswith(filename, ".jld2")
    return convert(TensorMap, JLD2.load_object(filename))
end

"""
Load a matrix of TensorMaps
"""
function load_tensors(folder::AbstractString, label::AbstractString, N1::Int, N2::Int)
    @assert endswith(folder, "/")
    arr = collect(
        load_tensor(folder * "$label$r$c.jld2") for (r, c) in Iterators.product(1:N1, 1:N2)
    )
    return arr
end

"""
Save a single tensor 
"""
function save_tensor(filename::AbstractString, t::AbstractTensorMap)
    @assert endswith(filename, ".jld2")
    return JLD2.save_object(filename, convert(Dict, t))
end

"""
Save a matrix of TensorMaps
"""
function save_tensors(
        folder::AbstractString, label::AbstractString, arr::Matrix{<:AbstractTensorMap}
    )
    @assert endswith(folder, "/")
    mkpath(folder)
    for ind in CartesianIndices(arr)
        r, c = Tuple(ind)
        filename = folder * "$label$r$c.jld2"
        save_tensor(filename, arr[ind])
    end
    return
end
