#same as HW1
df <- read.csv("C:/R/FixedPremStat.csv")

#what are the chances man city win when they are the home team
#observation: man city are home team
#belief: home team win

nf <- nrow(df[df$FTR == 'H',])
nf

n <- nrow(df)
n

Prior <- nf / n
Prior

PriorOdds <- round(Prior / (1 - Prior), 2)

TruePositive <- round(nrow(df[df$HomeTeam=='Man City' & df$FTR=='H',])/nrow(df[df$FTR=='H',]), 2)

FalsePositive <- round(nrow(df[df$HomeTeam=='Man City' & df$FTR!='H',])/nrow(df[df$FTR!='H',]), 2)

LikelihoodRatio <- round(TruePositive / FalsePositive, 2)

PosteriorOdds <- LikelihoodRatio * PriorOdds

Posterior <- PosteriorOdds / (1 + PosteriorOdds)
Posterior

PosteriorOdds
PriorOdds

#plot for article p1
colors<- c('red','blue','green')
mosaicplot(df$HomeTeam~df$FTR,
           xlab = 'HomeTeam',
           ylab = 'FTR', 
           main = "Full Time Result of each Premier League home side",
           col=colors,
           legend=TRUE,
           border="black"
)


#plot for article p2
#least winning away teams selected for easier visuals
colors<- c('red','blue','green', '#00990044')
est <- subset(df, AwayTeam=='Birmingham' | AwayTeam=='Blackburn' | AwayTeam=='Blackpool' | AwayTeam=='Burnley' | AwayTeam=='Cardiff' | AwayTeam=='Huddersfield' | AwayTeam=='Hull' | AwayTeam=='Middlesbrough' | AwayTeam=='Portsmouth' | AwayTeam=='Reading' | AwayTeam=='QPR' | AwayTeam=='Sheffield United' | AwayTeam=='Wigan' | AwayTeam=='Leeds' | AwayTeam=='Bournemouth')
mosaicplot(est$AwayTeam~est$FTR,
           xlab = 'HomeTeam',
           ylab = 'FTR', 
           main = "Full Time Result of the lower end of Premier League away sides ",
           col=colors,
           legend=TRUE,
           border="black"
)









# Exercise-3

# Given a contingency table between AwayTeam and FTR
# The values which label the column represents the observations
# The values which label the row represents the beliefs

t <- table(df$FTR, df$AwayTeam)
#nucasel
cat("Contingency table of AwayTeam vs FTR:\n")
t

# Observation is AwayTeam==Reading, Belief is being a Away loss (FTR=='H')
PriorProb <- sum(t[3, ]) / sum(t[ , ])
PriorProb

PriorOdds <- PriorProb / (1 - PriorProb)
cat("Prior Odds of being Man City:", PriorOdds, "\n")

TruePositive <- t[3, 28] / sum(t[3, ])
TruePositive

FalsePositive <- sum(t[1:2, 28]) / sum(t[1:2, ])
FalsePositive

LikelihoodRatio <- TruePositive / FalsePositive
LikelihoodRatio

cat("How odds of AwayTeam being Reading change if home team win:", LikelihoodRatio, "\n")
# This is the your odds of away team losing change if it is Reading
PosteriorOdds <- LikelihoodRatio * PriorOdds
PosteriorOdds

Posterior <- PosteriorOdds / (1 + PosteriorOdds)
Posterior


#for article
#mc_home <- df[df$HomeTeam=='Man City',]
#nrow(mc_home[mc_home$FTR=='H',])
#nrow(mc_home[mc_home$FTR=='D',])
#nrow(mc_home[mc_home$FTR=='A',])
