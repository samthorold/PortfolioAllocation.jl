module Objectives

import ..Utils.cov
import ..Utils.implied_return

export diversification_ratio
export variance

variance(w, s, C) = w' * cov(s, C) * w

holdings_weight(w, _, _) = w' * w

risk_weight(_, s, C) = s' * s

risk_contribution(w, s, C) = w' * cov(s, C) * w

diversification_ratio(w, s, C) = (w' * s) / sqrt(variance(w, s, C))

sharpe_ratio(w, s, C) = (w' * implied_return(s)) / sqrt(variance(w, s, C))

end
