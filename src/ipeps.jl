"""
Load InfinitePEPS from folder
"""
function load_iPEPS(folder::AbstractString, N1::Int, N2::Int)
    peps = InfinitePEPS(load_tensors(folder, "A", N1, N2))
    return peps
end

"""
Load (1-layer) InfinitePEPO from folder
"""
function load_iPEPO(folder::AbstractString, N1::Int, N2::Int)
    pepo = InfinitePEPO(cat(load_tensors(folder, "A", N1, N2); dims = 3))
    return pepo
end

"""
Load SUWeight from folder
"""
function load_SUWeight(folder::AbstractString, N1::Int, N2::Int)
    wxs = collect(DiagonalTensorMap(wt) for wt in load_tensors(folder, "x", N1, N2))
    wys = collect(DiagonalTensorMap(wt) for wt in load_tensors(folder, "y", N1, N2))
    return SUWeight(wxs, wys)
end

"""
Save `InfinitePEPS` to files
"""
function save_iPEPS(folder::AbstractString, peps::InfinitePEPS)
    save_tensors(folder, "A", peps.A)
    return nothing
end

"""
Save (1-layer) `InfinitePEPO` to files
"""
function save_iPEPO(folder::AbstractString, pepo::InfinitePEPO)
    @assert size(pepo, 3) == 1
    save_tensors(folder, "O", pepo.A[:, :, 1])
    return nothing
end

"""
Save `SUWeight` to files
"""
function save_SUWeight(folder::AbstractString, wts::SUWeight)
    save_tensors(folder, "x", wts[1, :, :])
    save_tensors(folder, "y", wts[2, :, :])
    return nothing
end
