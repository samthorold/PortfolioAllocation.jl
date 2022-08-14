using PortfolioAllocation
using Test

@testset "Allocation" begin
    s = [.04, .06, .08, .1]    
    C = [
        1.0 0.2 0.2 0.2
        0.2 1.0 0.2 0.2
        0.2 0.2 1.0 0.2
        0.2 0.2 0.2 1.0
    ]

    expected = [
        0.6588
        0.2236
        0.0869
        0.0307
    ]

    got = allocate(Objectives.variance, s, C)

    @test got ≈ expected atol=0.0001
    

    s = [.20, .10, .20, .25]

    C = [
       1.00 0.80 0.40 0.30
       0.80 1.00 0.30 0.10
       0.40 0.30 1.00 -.10
       0.30 0.10 -.10 1.00
       ]

    expected = [
        -0.1815
        0.6121
        0.2989
        0.2705
    ]

    got = allocate(Objectives.sharpe_ratio, s, C)

    @test got ≈ expected atol=0.0001
end


