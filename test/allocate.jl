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

    @testset "Minium Variance" begin
        

        expected = [
            0.6588
            0.2236
            0.0869
            0.0307
        ]

        got = Allocate.minimum_variance( s, C)

        @test got ≈ expected atol=0.0001

    end

    @testset "Asset contribution" begin
    
        expected = [
            0.25
            0.25
            0.25
            0.25
        ]

        got = Allocate.equal_asset_contribution(length(s))

        @test got ≈ expected atol=0.01

    end

    @testset "Most Diversified Portfolio" begin
        s = [.2, .1, .2, .25]
        C = [
              1.0  0.8  0.4  0.5
              0.8  1.0  0.3  0.1
              0.4  0.3  1.0 -0.1
              0.3  0.1 -0.1 1.0
        ]

        expected = [
            -0.1815
             0.6121
             0.2989
             0.2705
        ]

        got = Allocate.most_diversified(s, C, long_only = false)

        @test got ≈ expected atol = 0.0001

        expected = [
            0.0
            0.4170
            0.3071
            0.2760
        ]

        got = Allocate.most_diversified(s, C)

        @test got ≈ expected atol = 0.0001

    end
end


