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

"""
    most_diversified(σ, C)

The asset weights giving the most diversified portfolio.

# Arguments
- `σ::Array{Float64}`: the asset volatilities.
- `C::Matrix{Float64}`: the asset correlation matrix.

# Examples
```jldoctest
julia> σ = [.20, .10, .20, .25];

julia> C = [
       1.00 0.80 0.40 0.30
       0.80 1.00 0.30 0.10
       0.40 0.30 1.00 -.10
       0.30 0.10 -.10 1.00
       ];

julia> round.(most_diversified(σ, C), digits=4)
4-element Vector{Float64}:
 -0.1815
  0.6121
  0.2989
  0.2705

```

"""
function most_diversified(σ, C)
    M = inv(diagm(σ)) * inv(C) * ones(length(σ))
    return M / sum(M)
end

function cov_matrix(σ, C)
    S = diagm(σ)
    return S * C * S
end

portfolio_variance(w, σ, C) = transpose(w) * cov_matrix(σ, C) * w

diversification_ratio(w, σ, C) = (transpose(w) * σ) / sqrt(portfolio_variance(w, σ, C))

export diversification_ratio
export minimum_variance
export most_diversified
export portfolio_variance

end
