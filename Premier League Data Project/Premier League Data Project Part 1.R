library(readxl)
library(dplyr)
df <- read_excel("C:/R/FixedPremStat.xlsx")

cropped <- df %>% select(HomeTeam, AwayTeam, FTR)

cropped$Attendance <- 1
cropped$HomeWin <- as.numeric(cropped$FTR == "H")
cropped$AwayWin <- as.numeric(cropped$FTR == "A")

total_attendance_per_team <- tapply(cropped$Attendance, cropped$HomeTeam, sum) + tapply(cropped$Attendance, cropped$AwayTeam, sum)
home <- tapply(cropped$HomeWin, cropped$HomeTeam, mean)*100
away <- tapply(cropped$AwayWin, cropped$AwayTeam, mean)*100

complete <- data.frame(Team=names(home), Home=home, Away=away, Attendance=total_attendance_per_team)

better_away_record <- complete[complete$Home<complete$Away,]

barplot(c(better_away_record$Home, better_away_record$Away), 
        col=c("yellow", "blue"),  
        ylab="Percentage",
        ylim=c(0,max(c(max(better_away_record$Home),max(better_away_record$Away)))),
        beside=TRUE,
        main="Leeds United Home vs. Away Win Percentage",
        names.arg = c("Home", "Away")
)
established_teams <- complete[((complete$Home+complete$Away)/2)>15 & complete$Attendance>75,]
overall_stats <- data.frame(Team="Premier League Overall",Home=mean(established_teams$Home), Away=mean(established_teams$Away))

barplot(c(overall_stats$Home, overall_stats$Away), 
        col=c("yellow", "blue"), 
        main="Premier League Home vs. Away Win Percentage of Established Teams**",
        sub="**Established Team: min. 2 season & 15% win rate",
        ylab="Percentage",
        ylim=c(0,max(c(max(overall_stats$Home),max(overall_stats$Away)))),
        names.arg = c("Home", "Away")
)



#FOR ARTICLE: PlusMinus calculated to show the spectrum of home advantage
established_teams$PlusMinus <- established_teams$Home-established_teams$Away

#see the PlusMinus of each established team
#established_teams[,c("Team","PlusMinus")]
#max(established_teams$PlusMinus)

#minimum of PlusMinus (without Leeds)
#min(established_teams[established_teams$PlusMinus>0,]$PlusMinus)


#scatterplot of established teams
#x-axis: Away Win Pct
plot(established_teams$Home, 
     established_teams$Away,
     xlab="Home Win Pct",
     ylab="Away Win Pct",
     col="blue",
     xlim=c(20,round(max(established_teams$Home),0)),
     ylim=c(20,round(max(established_teams$Away),0)),
     main="Home Win Pct vs Away Win Pct for Established Teams**",
     sub="**Teams with min. 2 season & >15% win rate"
)

#Asked GPT for some help on this one
#I remember seeing an easy way to do this with a video given by Mardekian but needed a refresher
#The linear regression model really helps me as a viewer to make interpretations visually
# Fit linear regression model
linear_model <- lm(Away ~ Home, data = established_teams)
# Add regression line to the plot
abline(linear_model, col = "red")

points(x = better_away_record$Home,
       y = better_away_record$Away,
       col = "black",  # Color of the dot
       pch = 16  # Type of plotting character (a solid circle)
)









team_results <- subset(df, HomeTeam=="Liverpool" | AwayTeam=="Liverpool")

team_results$Result <- as.numeric((team_results$HomeTeam=="Liverpool"&team_results$FTR=="H")|(team_results$AwayTeam=="Liverpool"&team_results$FTR=="A")|team_results$FTR=="D")
team_results$Attendance <- 1
team_results<- team_results %>% select(Referee, Result, Attendance)
total <- tapply(team_results$Attendance, team_results$Referee, sum)
ref_tap <- tapply(team_results$Result, team_results$Referee, sum)

referee <- data.frame(Referee=names(ref_tap), Win=ref_tap, Loss=total-ref_tap )

plot(referee$Win, 
     referee$Loss,
     xlab="Win/Draw",
     ylab="Loss",
     col="blue",
     xlim=c(0,30),
     ylim=c(0,30),
     main="Liverpool Win (or draw) vs Loss per Referee"
)

# Fit linear regression model
linear_model <- lm(Loss ~ Win, data = referee)

# Add regression line to the plot
abline(linear_model, col = "red")


text(referee[referee$Referee=="H Webb",]$Win,
     referee[referee$Referee=="H Webb",]$Loss,
     labels = "Howard Webb",  # Assuming Team names are the labels
     pos = 3,  # Adjust the position of the labels (3 means above and to the left)
     col = "black",  # Label text color
)


#Howard Webb --- Anti-Livpool Bias (w+d vs l)
#Spurs, no agenda (w+d vs l)
#Arsnal, more games --> periods of ups and downs
#maybe recently lots of wins but before lots of losses
#depends when the referee was doing Liverpool games if they
#had good Liverpool time period or bad
#













mean(df$AY)+mean(df$AR)
mean(df$HY)+mean(df$HR)

home_cards <- df$HY + df$HR
away_cards <- df$AY + df$AR

total <- data.frame(Cards=c(home_cards,away_cards), Side=c(rep("Home",length(home_cards)),rep("Away",length(away_cards))))

tapply(total$Cards, total$Side, mean)

total$Side <- factor(total$Side, levels = c("Home", "Away"))

boxplot(Cards~Side, 
        data=total, 
        xlab="",
        ylab="Number of Cards",
        col=c("blue", "red"),
        head="Number of cards given to Home vs. Away Sides"
)











#Prediction: Man City will NOT lose if Jonathan Moss is the referee

#make a subset of only Man City games reffed by J Moss
j_moss <- subset(df, Referee=="J Moss" & ( HomeTeam=="Man City" | AwayTeam=="Man City" ))

#keep only the necessary columns for easy management
j_moss <- j_moss %>% select(HomeTeam, AwayTeam, FTR)

j_moss$Win <- (
  (j_moss$HomeTeam=="Man City" & j_moss$FTR=="H") | 
    (j_moss$AwayTeam=="Man City" & j_moss$FTR=="A")| 
    ( j_moss$FTR=="D"))

mean(rep(TRUE, nrow(j_moss))==j_moss$Win)



#Other queries attempted that were not used for project final

mean(better_away_record[better_away_record$Attendance>75,]$Home)
mean(better_away_record[better_away_record$Attendance>75.]$Away)
j_moss2 <- j_moss
j_moss2$Win <- (j_moss2$HomeTeam=="Man City" & j_moss2$FTR=="H") | (j_moss2$AwayTeam=="Man City" & j_moss2$FTR=="A")

mean(rep(TRUE, nrow(j_moss))==j_moss2$Win)
tapply(total$Cards, total$Side, max)
tapply(total$Cards, total$Side, min)
tapply(total$Cards, total$Side, sd)

table(total[max(total$Cards)>3])


