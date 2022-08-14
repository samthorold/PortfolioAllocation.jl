module Allocate

using JuMP
import Ipopt
import ..Objectives
import ..Utils.w_min


export equal_asset_contribution
export minimum_variance

equal_asset_contribution(n) = ones(n) / n

function minimum_variance(s, C; long_only = true)
    m = Model(Ipopt.Optimizer)
    set_silent(m)
    @variable(m, w[1:length(s)] >= w_min(long_only))
    @constraint(m, sum(w) == 1)
    @objective(m, Min, Objectives.variance(w, s, C))
    optimize!(m)
    return value.(w)
end

function most_diversified(s, C; long_only = true)
    m = Model(Ipopt.Optimizer)
    set_silent(m)
    @variable(m, w[1:length(s)] >= w_min(long_only))
    # @constraint(m, sum(w) == 1)
    @variable(m, t >= 0)
    @constraint(m, s' * w == 1)
    @constraint(m, sum(w) == t)
    @objective(m, Min, Objectives.variance(w, s, C))
    optimize!(m)
    return value.(w) / value(t)
end

end

