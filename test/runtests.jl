using Documenter, LinearAlgebra, PortfolioAllocation, Test

DocMeta.setdocmeta!(PortfolioAllocation, :DocTestSetup, :(using PortfolioAllocation); recursive=true)

@testset "Minimum variance" begin

    σ = [.04, .06, .08, .10]
    C = fill(.2, length(σ), length(σ))
    C[diagind(C)] .= 1.
    expected = [
        0.6587633032466659
        0.22362926040684358
        0.08689209214603259
        0.030715344200458013
    ]
    @test minimum_variance(σ, C) ≈ expected

    C = fill(.5, length(σ), length(σ))
    C[diagind(C)] .= 1.
    expected = [
        .9065
        .1904
        -.0124
        -.0844
    ]
    @test minimum_variance(σ, C) ≈ expected atol=.0001
end

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

doctest(PortfolioAllocation)

