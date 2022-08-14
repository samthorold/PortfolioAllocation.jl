import PortfolioAllocation.Objectives: diversification_ratio
using Test

@testset "Diversification ratio" begin

    σ = [.2, .2, .2, .2]
    C = [
         1.00  0.80  0.00  0.00
         0.80  1.00  0.00  0.00
         0.00  0.00  1.00 -0.50
         0.00  0.00 -0.50  1.00
    ]
    
    w = [.25, .25, .25, .25]
    expected = 1.87
    @test diversification_ratio(w, σ, C) ≈ expected atol=.01


    σ = [.1, .2, .3, .4]
    C = [
         1. .8 .0 .0
         .8 1. .0 .0
         .0 .0 1. -.5
         .0 .0 -.5 1.
    ]

    w = [.25, .25, .25, .25]
    @test diversification_ratio(w, σ, C) ≈ 2.17 atol=.01
    w = [.7448, .0, .1517, .1034]
    @test diversification_ratio(w, σ, C) ≈ 1.87 atol=.01
    w = [.2778, .1389, .3333, .25]
    @test diversification_ratio(w, σ, C) ≈ 2.26 atol=.01
end

