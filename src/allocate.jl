module Allocate

using JuMP
import Ipopt


export allocate

"""
    allocate(objective, s, C)

The asset weights minimising the objective function.

Objective functions include;

- variance
- diversification_ratio

# Arguments
- `objective`: objective function to minimise.
- `s::Array{Float64}`: the asset volatilities.
- `C::Matrix{Float64}`: the asset correlation matrix.

# Examples
```jldoctest
julia> s = [.04, .06, .08, .1];

julia> C = [
       1.0 0.2 0.2 0.2
       0.2 1.0 0.2 0.2
       0.2 0.2 1.0 0.2
       0.2 0.2 0.2 1.0
       ];

julia> round.(allocate(Objectives.variance, s, C), digits=4)
4-element Vector{Float64}:
 0.6588
 0.2236
 0.0869
 0.0307

```
julia> s = [.20, .10, .20, .25];

julia> C = [
       1.00 0.80 0.40 0.30
       0.80 1.00 0.30 0.10
       0.40 0.30 1.00 -.10
       0.30 0.10 -.10 1.00
       ];

julia> round.(allocate(diversification_ratio, s, C; long_only = false), digits=4)
4-element Vector{Float64}:
 -0.1815
  0.6121
  0.2989
  0.2705

"""
function allocate(objective, s, C; long_only = true)
    if long_only
        w_min = 0
    else
        w_min = -1000000
    end
    w = ones(length(s))
    m = Model(Ipopt.Optimizer)
    set_silent(m)
    @variable(m, w[1:length(s)] >= w_min)
    @objective(m, Min, objective(w, s, C))
    @constraint(m, sum(w) == 1)
    optimize!(m)
    return value.(w)
end

end

