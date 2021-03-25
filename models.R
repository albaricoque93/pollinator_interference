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
  inits = 0,
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
    bf(time_between_visits ~  exp(rate) + (b * Bombus) + (a * Apis) + (o * Osmia) + (m * Megachile),
      rate ~ 1  + (1 | beeCor | beeID),
      b ~ 1 + (1 | beeCor | beeID),
      a ~ 1 + (1 | beeCor | beeID),
      o ~ 1 + (1 | beeCor | beeID),
      m ~ 1 + (1 | beeCor | beeID),
      nl = T
    ),
    inits = 0,
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
  bf(time_between_visits ~  exp(rate) + (b * Bombus) + (a * Apis) + (o * Osmia) + (m * Megachile),
     rate ~ 1 + neonic_treatment  + time_between_floral_refill + (1 + time_between_floral_refill +neonic_treatment | beeCor | beeID),
     b ~ 1 + neonic_treatment  + time_between_floral_refill + (1 + time_between_floral_refill +neonic_treatment | beeCor | beeID),
     a ~ 1 + neonic_treatment  + time_between_floral_refill + (1 + time_between_floral_refill +neonic_treatment | beeCor | beeID),
     o ~ 1 + neonic_treatment  + time_between_floral_refill + (1 + time_between_floral_refill +neonic_treatment | beeCor | beeID),
     m ~ 1 + neonic_treatment  + time_between_floral_refill + (1 + time_between_floral_refill +neonic_treatment | beeCor | beeID),
     nl = T
  ),
  inits = 0,
  data = dat,
  family = exponential(link = "identity"),
  iter = 5000,
  warmup = 3000,
  cores = 4,
  chains = 4,
  control = list(adapt_delta = .99 , max_treedepth = 13)
)



saveRDS(treatments, file="treatments.rds")