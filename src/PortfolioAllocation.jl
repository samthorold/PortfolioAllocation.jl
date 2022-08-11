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
julia> σ = [.04, .06, .08, .1];

julia> C = [
       1.0 0.2 0.2 0.2
       0.2 1.0 0.2 0.2
       0.2 0.2 1.0 0.2
       0.2 0.2 0.2 1.0
       ];

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

function cov_matrix(σ, C)
    S = diagm(σ)
    return S * C * S
end

function portfolio_variance(w, σ, C)
    Σ = cov_matrix(σ, C)
    return transpose(w) * Σ * w
end

function diversification_ratio(w, σ, C)
    (transpose(w) * σ) / sqrt(portfolio_variance(w, σ, C))
end

export diversification_ratio, minimum_variance, portfolio_variance

end
