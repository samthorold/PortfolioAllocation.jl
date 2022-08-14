module PortfolioAllocation

export Allocate
export allocate  # allocate is "the point"
export Analytic
export Objectives
# export Utils

include("utils.jl")
include("analytic.jl")
include("objectives.jl")
include("allocate.jl")

using .Allocate

end
