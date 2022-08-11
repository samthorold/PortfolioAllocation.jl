module PortfolioAllocation

using LinearAlgebra

"""
    minimum_variance(σ, C)

The asset weights giving the minimum variance portfolio.

# Arguments
- `σ::Array{Float64}`: the asset volatilities.
- `C::Matrix{Float64}`: the asset correlation matrix.

# Examples
```jldoctest
julia> using LinearAlgebra
julia> σ = [.04, .06, .08, 1.];
julia> C = fill(.2, length(σ), length(σ));
julia> C[diagind(C)] .= 1.
julia> minimum_variance(σ, C)
4-element Vector{Float64}:
 0.6587633032466659
 0.22362926040684358
 0.08689209214603259
 0.030715344200458013
```

"""
function minimum_variance(σ, C)
    S = diagm(σ)
    Σ = S * C * S
    Σ_inv = inv(Σ)
    i = ones(length(σ))
    return (Σ_inv * i) / (transpose(i) * Σ_inv * i)
end

export minimum_variance

end
