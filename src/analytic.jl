module Analytic

using LinearAlgebra
import ..Utils: cov

export minimum_variance
export most_diversified

function minimum_variance(s, C)
    i = ones(length(s))
    V = cov(s, C)
    return (inv(V) * i) / (i' * inv(V) * i)
end

function most_diversified(s, C)
    M = inv(diagm(s)) * inv(C) * ones(length(s))
    return M / sum(M)
end

end
