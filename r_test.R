library(ggplot2)
library(gridExtra)

my_dataframe <- read.csv("my_dataframe.csv")

par(mfrow = c(2, 2))

min_index <- which.min(my_dataframe$time)

my_dataframe$sp <- my_dataframe$time[1] / my_dataframe$time
my_dataframe$alpha <- (my_dataframe$threads - my_dataframe$sp) / (my_dataframe$sp * (my_dataframe$threads - 1))
my_dataframe$alpha[1] <- 0
my_dataframe$E <- my_dataframe$sp / my_dataframe$threads



plot(my_dataframe$threads, my_dataframe$time, type = "o", xlab = "Threads", ylab = "Time")
points(my_dataframe$threads[min_index], my_dataframe$time[min_index], col = "tomato", pch = 19)
points(my_dataframe$threads[4], my_dataframe$time[4], col = "green", pch = 19)

legend("top", inset = c(0, -0.5), legend = "Minimum time", col = "tomato", pch = 19, xpd = TRUE, horiz = TRUE)

plot(my_dataframe$threads, my_dataframe$sp, type = "o", xlab = "Threads", ylab = "Sp")
points(my_dataframe$threads[min_index], my_dataframe$sp[min_index], col = "steelblue", pch = 19)
points(my_dataframe$threads[4], my_dataframe$sp[4], col = "green", pch = 19)

legend("top", inset = c(0, -0.5), legend = paste0("Optimal number of threads: ", as.character(my_dataframe$threads[min_index])), xpd = TRUE, horiz = TRUE)

plot(my_dataframe$threads, my_dataframe$alpha, type = "o", xlab = "Threads", ylab = "alpha")
points(my_dataframe$threads[min_index], my_dataframe$alpha[min_index], col = "steelblue", pch = 19)

plot(my_dataframe$threads, my_dataframe$E, type = "o", xlab = "Threads", ylab = "E")
points(my_dataframe$threads[min_index], my_dataframe$E[min_index], col = "steelblue", pch = 19)