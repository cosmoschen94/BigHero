library("rjson")
library(fpc)
library(cluster)
library("party")
json_file <- "data.json"
json_data <- fromJSON(file=json_file)

nrow <- length(json_data)
ncol <- length(json_data[[1]])
data_attribute <- names(json_data[[1]])
data_mat <- matrix(data = unlist(json_data), nrow = nrow, ncol = ncol, byrow = TRUE)
colnames(data_mat) <- data_attribute
data_frame <- data.frame(data_mat)
data_frame_no_price <- data_frame
data_frame_no_price$Rent.Price <- NULL

#visualize
pie(table(data_frame$Number.of.Bedrooms))
pie(table(data_frame$Rent.Price))

#dbscan
ds <- dbscan(data_frame_no_price, eps = 0.5, MinPts = 2)
plot(ds, data_frame)
plotcluster(data_frame_no_price, ds$cluster)


#k-mean
set.seed(8953)
(kmeans.result <- kmeans(data_frame,2))
plot(data_frame[c("Latitude", "Longitude","Number.of.Bedrooms","Rent.Price")], col = kmeans.result$cluster)

#pam, k = 2
pam.result <- pam(data_frame,2)
plot(pam.result)

#pam, k = 3
pam.result <- pam(data_frame,3)
plot(pam.result)

#pam, k = 4
pam.result <- pam(data_frame,4)
plot(pam.result)

#pam, k = 5
pam.result <- pam(data_frame,5)
plot(pam.result)

cluster_result <- pam(data_frame,2)$clustering
data_frame$Cluster <- cluster_result
data_frame_no_price$Cluster <- cluster_result

cluster1_mean<-mean(data_frame$Rent.Price[data_frame$Cluster == 1])
cluster2_mean<-mean(data_frame$Rent.Price[data_frame$Cluster == 2])

cluster1_min<-min(data_frame$Rent.Price[data_frame$Cluster == 1])
cluster2_min<-min(data_frame$Rent.Price[data_frame$Cluster == 2])

cluster1_max<-max(data_frame$Rent.Price[data_frame$Cluster == 1])
cluster2_max<-max(data_frame$Rent.Price[data_frame$Cluster == 2])

#decision tree
my_ctree <- ctree(Cluster ~ Number.of.Bedrooms + Latitude + Longitude, data=data_frame_no_price)
print(my_ctree)
plot(my_ctree, type="simple")


