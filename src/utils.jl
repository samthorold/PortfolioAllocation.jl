module Utils

using LinearAlgebra

function cov(s, C)
    S = diagm(s)
    return S * C * S
end

function implied_return(s)
    0.3 * s
end

end

