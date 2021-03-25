#Models of pollinator interference as described in the manuscript
# All models use bombus individuals as random effects for all of the parameters
# Random effects inside a model are correlated to each other, see the brms vignette for the nomenclature
library(brms)

dat <- read.csv("bombus_foraging_data.csv")

#the null model only fits a rate
null <- brm(
  bf(time_between_visits ~  exp(rate),
     rate ~  1 + (1 | beeCor | beeID),
     nl = T),
  data = dat,
  family = exponential(link = "identity"),
  iter = 5000,
  warmup = 3000,
  cores = 4,
  chains = 4,
  control = list(adapt_delta = .99 , max_treedepth = 13)
)

saveRDS(null, file="null.rds")


#the interference model only uses species abundances as predictors
interference <-brm(
    bf(time_between_visits ~  exp(rate) + (beta_b * Bombus) + (beta_a * Apis) + (beta_o * Osmia) + (beta_m * Megachile),
      rate ~ 1  + (1 | beeCor | beeID),
      beta_b ~ 1 + (1 | beeCor | beeID),
      beta_a ~ 1 + (1 | beeCor | beeID),
      beta_o ~ 1 + (1 | beeCor | beeID),
      beta_m ~ 1 + (1 | beeCor | beeID),
      nl = T
    ),
    data = dat,
    family = exponential(link = "identity"),
    iter = 5000,
    warmup = 3000,
    cores = 4,
    chains = 4,
    control = list(adapt_delta = .99 , max_treedepth = 13)
  )


saveRDS(interference, file="interference.rds")





treatments <-brm(
    bf(time_between_visits ~  exp(rate) + (beta_b * Bombus) + (beta_a * Apis) + (beta_o * Osmia) + (beta_m * Megachile),
      rate ~ 1 + neonic + refill  + (1 + neonic + refill | beeCor | beeID),
      beta_b ~ 1 + neonic + refill  + (1 + neonic + refill | beeCor | beeID),
      beta_a ~ 1 + neonic + refill  + (1 + neonic + refill | beeCor | beeID),
      beta_o ~ 1 + neonic + refill  + (1 + neonic + refill | beeCor | beeID),
      beta_m ~ 1 + neonic + refill  + (1 + neonic + refill | beeCor | beeID),
      nl = T
    ),
    data = dat,
    family = exponential(link = "identity"),
    iter = 5000,
    warmup = 3000,
    cores = 4,
    chains = 4,
    control = list(adapt_delta = .99 , max_treedepth = 13)
  )

saveRDS(treatments, file="treatments.rds")