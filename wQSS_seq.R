#
## Function to do extinctions by Total Interaction Strength, Degree, Trophic Level, Omnivory and Trophic Similarity
## Calculate Quasi-sign stability 'QSS' for each extinction sequence
#
## Load packages
library(igraph)
library(multiweb)
library(dplyr)
library(tictoc)
#
## Load data
load("IS.RData")
#
# Number of simulations
nsim <- 1000
#
# Extinction sequences
#
## By total Interaction Strength
order_is <- arrange(spp_prop, desc(total_IS)) %>% dplyr::select(TrophicSpecies, total_IS)
is_seq <- order_is$TrophicSpecies
is_seq <- is_seq[1:50]
print(paste("Extinction sequences by total IS - Nsim = ", nsim))
QSS_extinction_is <- calc_QSS_extinctions_seq(pw, is_seq, nsim=nsim, ncores=48, istrength=TRUE)
#
## By Trophic Level
order_tl <- arrange(spp_prop, desc(TL)) %>% dplyr::select(TrophicSpecies, TL)
tl_seq <- order_tl$TrophicSpecies
tl_seq <- tl_seq[1:50]
print(paste("Extinction sequences by TL - Nsim = ", nsim))
QSS_extinction_tl <- calc_QSS_extinctions_seq(pw, tl_seq, nsim=nsim, ncores=48, istrength=TRUE)
#
## By Degree
order_deg <- arrange(spp_prop, desc(Degree)) %>% dplyr::select(TrophicSpecies, Degree)
deg_seq <- order_deg$TrophicSpecies
deg_seq <- deg_seq[1:50]
print(paste("Extinction sequences by Degree - Nsim = ", nsim))
QSS_extinction_deg <- calc_QSS_extinctions_seq(pw, deg_seq, nsim=nsim, ncores=48, istrength=TRUE)
#
## By Omnivory
order_omn <- arrange(spp_prop, desc(Omn)) %>% dplyr::select(TrophicSpecies, Omn)
omn_seq <- order_omn$TrophicSpecies
omn_seq <- omn_seq[1:50]
print(paste("Extinction sequences by Omnivory - Nsim = ", nsim))
QSS_extinction_omn <- calc_QSS_extinctions_seq(pw, omn_seq, nsim=nsim, ncores=48, istrength=TRUE)
#
## By Trophic Similarity
order_ts <- arrange(spp_prop, desc(meanTrophicSimil)) %>% dplyr::select(TrophicSpecies, meanTrophicSimil)
ts_seq <- order_ts$TrophicSpecies
ts_seq <- ts_seq[1:50]
print(paste("Extinction sequences by TS - Nsim = ", nsim))
QSS_extinction_ts <- calc_QSS_extinctions_seq(pw, ts_seq, nsim=nsim, ncores=48, istrength=TRUE)  
#
# Save data
save(QSS_extinction_is, QSS_extinction_tl, QSS_extinction_deg, QSS_extinction_topol, QSS_extinction_omn, QSS_extinction_ts, file="Data/wQSS_seq_extinctions.rds")
#
# Automatic upload
system(paste('git add','Data/wQSS_seq_extinctions.rds'))
system('git commit -am "Added results seq extinctions"')
system('git push')