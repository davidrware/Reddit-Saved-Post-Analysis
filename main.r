
#if(!exists("mydb")){
mydb = dbConnect(MySQL(),user="davew",password="tandy23",dbname="redditsaved",host="sextoysfor.me")
#}

#To get available tables
# dbListTables
#dbListFields(mydb,"savedposts")

q = dbSendQuery(mydb,"SELECT subreddit,count(*) as count FROM savedposts GROUP BY subreddit ORDER BY count DESC LIMIT 10")

top10Subs = fetch(q,n=-1)

q = dbSendQuery(mydb,"SELECT subreddit,avg(score) as average FROM savedposts GROUP BY subreddit ORDER BY average DESC LIMIT 9")

top10ByScore = fetch(q,n=-1)

png("Top10ByOcc.png")
slices <- as.integer(unlist(top10Subs$count))
lbls <- unlist(top10Subs$subreddit)
pie(slices,labels=lbls,col=rainbow(length(lbls)),
    main="My Top 10 By Occurrences")
dev.off()


png("Top10ByScore.png")
barplot(top10ByScore$average,col=rainbow(length(lbls)),
        main="My Top 9 By Average Score")
legend("topright",title="Subreddits",names(table(top10ByScore$subreddit)),cex=.9,
       fill=rainbow(length(top10ByScore$subreddit)))
dev.off()