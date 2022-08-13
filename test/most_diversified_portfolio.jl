using PortfolioAllocation
using Test

@testset "Most diversified portfolio" begin
    σ = [.1, .2, .3, .4]
    C = [
         1. .8 .0 .0
         .8 1. .0 .0
         .0 .0 1. -.5
         .0 .0 -.5 1.
    ]
    expected = [
        .2778
        .1389
        .3333
        .25
    ]
    @test most_diversified(σ, C) ≈ expected atol=.0001


    σ = [.20, .10, .20, .25]
    C = [
         1.00 0.80 0.40 0.30
         0.80 1.00 0.30 0.10
         0.40 0.30 1.00 -.10
         0.30 0.10 -.10 1.00
    ]
    expected = [
        -.1815
        0.6121
        0.2989
        0.2705
    ]
    @test most_diversified(σ, C) ≈ expected atol=0.0001
    
end
