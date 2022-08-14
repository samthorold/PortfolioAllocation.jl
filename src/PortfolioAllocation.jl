module PortfolioAllocation

using JuMP
using LinearAlgebra
import Ipopt

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

julia> round.(minimum_variance(σ, C), digits=4)
4-element Vector{Float64}:
 0.6588
 0.2236
 0.0869
 0.0307

```

"""
function minimum_variance(σ, C)
    S = diagm(σ)
    Σ = S * C * S
    Σ_inv = inv(Σ)
    i = ones(length(σ))
    return (Σ_inv * i) / (transpose(i) * Σ_inv * i)
end

function allocate(objective, σ, C; long_only = true)
    if long_only
        w_min = 0
    else
        w_min = -1000000
    end
    m = Model(Ipopt.Optimizer)
    set_silent(m)
    @variable(m, w[1:length(σ)] >= w_min)
    @objective(m, Min, objective(w, σ, C))
    @constraint(m, sum(w) == 1)
    optimize!(m)
    return value.(w)
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

export allocate
export diversification_ratio
export minimum_variance
export most_diversified
export portfolio_variance

end
