using PortfolioAllocation
using Test

@testset "Portfolio variance" begin
    σ = [.1, .2, .3, .4]
    C = [
         1. .8 .0 .0
         .8 1. .0 .0
         .0 .0 1. -.5
         .0 .0 -.5 1.
    ]

    w = [.25, .25, .25, .25]
    @test sqrt(portfolio_variance(w, σ, C)) ≈ .1151 atol=.0001

    w = [.7448, .0, .1517, .1034]
    @test sqrt(portfolio_variance(w, σ, C)) ≈ .0863 atol=.0001

    w = [.2778, .1389, .3333, .25]
    @test sqrt(portfolio_variance(w, σ, C)) ≈ .1130 atol=.0001
end
