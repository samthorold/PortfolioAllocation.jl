using LinearAlgebra
using Test
using PortfolioAllocation

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
end
