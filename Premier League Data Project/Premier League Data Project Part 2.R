#install.packages("devtools")
#library(devtools)
#devtools::install_github("janish-parikh/ZTest")
#library(HypothesisTesting)

df <- read.csv("C:\\R\\HW\\HW2\\soccer.csv")


######################
# Hypothesis Testing #
######################

#tapply functions to test differences
tapply(df$Passes.per.match, df$Club, mean)
tapply(df$Passes.per.match, df$Nationality, mean)
tapply(df$Passes.per.match, df$Position, mean)
tapply(df$Passes, df$Club, mean)
tapply(df$Passes, df$Nationality, mean)
tapply(df$Passes, df$Position, mean)
tapply(df$Assists, df$Club, mean)
tapply(df$Assists, df$Nationality, mean)
tapply(df$Assists, df$Position, mean)
tapply(df[df$Position!="Goalkeeper",]$Interceptions, df[df$Position!="Goalkeeper",]$Club, mean)
tapply(df[df$Position!="Goalkeeper",]$Tackles, df[df$Position!="Goalkeeper",]$Nationality, mean)
tapply(df[df$Position!="Goalkeeper",]$Interceptions, df[df$Position!="Goalkeeper",]$Nationality, mean)
#many more tested but this was the general method

permutation_test(df, 'Club', 'Passes.per.match', 10000, 'West-Bromwich-Albion', 'Aston-Villa')
z_test_from_data(df, 'Club', 'Passes.per.match', 'West-Bromwich-Albion', 'Aston-Villa')
#.045 REJECT CLOSE
permutation_test(df[df$Position!="Goalkeeper",], 'Club', 'Interceptions', 10000, 'Leeds-United', 'Manchester-City')
z_test_from_data(df[df$Position!="Goalkeeper",], 'Club', 'Interceptions', 'Leeds-United', 'Manchester-City')
#.0001970053 REJECT
permutation_test(df[df$Position!="Goalkeeper",], 'Nationality', 'Interceptions', 10000, "Cote D'Ivoire", 'England')
z_test_from_data(df[df$Position!="Goalkeeper",], 'Nationality', 'Interceptions', "Cote D'Ivoire", 'England')
#.07975594 FAIL

################
# Narrow Query #
################

#No goalkeeper since they do not have Big Chances
overall_bc <- df[df$Position!='Goalkeeper',c('Club', 'Nationality','Position','Big.chances.created')]
tapply(overall_bc[overall_bc$Position=='Forward',]$Big.chances.created, overall_bc[overall_bc$Position=='Forward',]$Club, mean)
tapply(overall_bc[overall_bc$Position=='Defender',]$Big.chances.created, overall_bc[overall_bc$Position=='Defender',]$Nationality, mean)


#-------eq1v-------eq1-------eq1-------eq1-------eq1-------eq1v-------eq1-------eq1-------eq1-------
bc_subset_eq1 <- subset(overall_bc, Club=='Tottenham-Hotspur' & Position=='Forward')
#M
mean(bc_subset_eq1$Big.chances.created)
#M0
mean(overall_bc$Big.chances.created)
#mean(bc[bc$Club=='Tottenham-Hotspur' & bc$Position=='Forward',]$Big.chances.created)
#-------eq1-------eq1-------eq1-------eq1-------eq1-------eq1v-------eq1-------eq1-------eq1-------



#-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------
bc_subset_eq2 <- subset(overall_bc, Nationality=='France' & Position=='Defender')
#M
mean(bc_subset_eq2$Big.chances.created)
#M0
mean(overall_bc$Big.chances.created)
#-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------eq2-------





#before talking with Aditya (TA) --- accounted for bonferroni unnecessarily
##################################################################################################
#* PREVIOUS MISTAKES w/ Bonferroni
#unique(df$Club)
#m_club <- length(unique(df$Club))
#bon_club <- m_club*(m_club-1)/2
#number of pairs: 20choose2 = 190
#.05/190 = 0.0002632 <-- new significance level
####WRONG Bonferroni only used with multiple hypotheses
#-------REJECT-------REJECT-------REJECT-------REJECT-------REJECT-------REJECT-------REJECT-------
#Manchester-United
#cat("new significance level: ",(.05/bon_club))
#permutation_test(df, 'Club', 'Passes.per.match', 10000, 'West-Bromwich-Albion', 'Manchester-United')
#0
#z_test_from_data(df, 'Club', 'Passes.per.match', 'West-Bromwich-Albion', 'Manchester-United')
#z-score: 4.24045718
#p-value: 0.00001115
#-------REJECT-------REJECT-------REJECT-------REJECT-------REJECT-------REJECT-------REJECT-------
#-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL
#Arsenal
#z-score: 3.43735947
#p-value: 0.00029370
#.05/190= 0.0002632 <-- new significance level
#cat("new significance level: ",(.05/bon_club))
#permutation_test(df, 'Club', 'Passes.per.match', 10000, 'West-Bromwich-Albion', 'Arsenal')
#0.0001
#z_test_from_data(df, 'Club', 'Passes.per.match', 'West-Bromwich-Albion', 'Arsenal')
#-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL-------CLOSE_FAIL
#make subset of goals with right foot
#goals_with_right_foot <- df[,c('Name','Club','Goals.with.right.foot','Appearances')]
#goals_with_right_foot[is.na(goals_with_right_foot)] <- 0
#colnames(goals_with_right_foot)[3] <- 'Goals'
#check different means
#tapply(goals_with_right_foot$Goals, goals_with_right_foot$Club, mean)
#permutation test between min and max
#permutation_test(goals_with_right_foot, 'Club','Goals',10000,'Leeds-United','Manchester-City')
#z_test_from_data(goals_with_right_foot, 'Club','Goals','Leeds-United','Manchester-City')
#5e^-4
#permutation_test(goals_with_right_foot[goals_with_right_foot$Goals>0,], 'Club','Goals',10000,'Leeds-United','Manchester-City')
#3e^-4
#z_test_from_data(goals_with_right_foot[goals_with_right_foot$Goals>0,], 'Club','Goals','Leeds-United','Manchester-City')
#Null: The amount of right-footed goals scored by Manchester City and Leeds United is the same
#Alternate: Manchester City score more right-footed goals than Leeds United
#-------CLOSE_REJECT-------CLOSE_REJECT-------CLOSE_REJECT-------CLOSE_REJECT-------CLOSE_REJECT-------
#unique_pos <- length(unique(df$Position))
#bon_pos <- unique_pos*(unique_pos-1)/2
#cat("new significance level: ",(.05/bon_pos))
#.05 / (4 choose 2) = .05 / 6 = 0.00833333333
#narrow_query <- subset(df, Jersey.Number<15 & Age>25)
#narrow_query <- df
#tapply(narrow_query$Passes, narrow_query$Position, mean)
#narrow_query[narrow_query$Position=='Forward' | narrow_query$Position=='Goalkeeper',]$Passes
#permutation_test(narrow_query, 'Position','Passes', 1000, 'Forward','Defender')
#z_test_from_data(narrow_query, 'Position','Passes','Forward','Defender')
#z-score: 3.5049502
#p-value: 0.0002283
#.05/190= 0.0002632 <-- new significance level
#-------CLOSE_REJECT-------CLOSE_REJECT-------CLOSE_REJECT-------CLOSE_REJECT-------CLOSE_REJECT-------

#*
#permutation_test(df, 'Club', 'Passes.per.match', 10000, 'West-Bromwich-Albion', 'Manchester-City')
#0
#z_test_from_data(df, 'Club', 'Passes.per.match', 'West-Bromwich-Albion', 'Manchester-City')
#z-score: 3.5685534246
#p-value: 0.0001794788
#
#Chelsea
#permutation_test(df, 'Club', 'Passes.per.match', 10000, 'West-Bromwich-Albion', 'Chelsea')
#0
#z_test_from_data(df, 'Club', 'Passes.per.match', 'West-Bromwich-Albion', 'Chelsea')
#z-score: 3.56855914
#p-value: 0.00017947
#Leicester-City
#permutation_test(df, 'Club', 'Passes.per.match', 10000, 'West-Bromwich-Albion', 'Leicester-City')
#3^e-4
#z_test_from_data(df, 'Club', 'Passes.per.match', 'West-Bromwich-Albion', 'Leicester-City')
#z-score: 3.15452833
#p-value: 0.00080378
#passes_per_match <- as.data.frame(tapply(df$Passes.per.match, df$Club, mean))
#colnames(passes_per_match)[1] <- 'Passes'
#**
