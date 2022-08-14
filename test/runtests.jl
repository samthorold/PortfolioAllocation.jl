using Documenter
using LinearAlgebra
using PortfolioAllocation
using Test

DocMeta.setdocmeta!(PortfolioAllocation, :DocTestSetup, :(using PortfolioAllocation); recursive=true)

@testset "PortfolioAllocation" begin
    include("allocate.jl")
    include("minimum_variance.jl")
    include("diversification_ratio.jl")
    include("variance.jl")
    include("most_diversified_portfolio.jl")
end

doctest(PortfolioAllocation)

