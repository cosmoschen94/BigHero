library("rjson")
library(fpc)
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


#dbscan
ds <- dbscan(data_frame, eps = 0.45, MinPts = 3)
plot(ds, data_frame)
plotcluster(data_frame, ds$cluster)


#k-mean
set.seed(8953)
(kmeans.result <- kmeans(data_frame,3))
plot(data_frame[c("Latitude", "Longitude","Number.of.Bedrooms","Rent.Price")], col = kmeans.result$cluster)




