library(Matrix)
library(matrixcalc)
library(cPCG)

set.seed(123)

df <- data.frame()
file.remove("threads.txt")
file.remove("time.txt")

mat <- readHB("/home/sarpi/bcsstk13.rsa")

b <- matrix(1:1, ncol = 1, nrow = 2003)

i <- 1

while (i <= 150) {
  start.time <- Sys.time()
  
  x <- cgsolve_sparseOMP(mat, b, tol = 1e-98, maxIter = 3000, nThreads = i)
  
  end.time <- Sys.time()
  
  time.taken <- as.numeric(end.time - start.time)
  
  # создание новой строки
  new_row <- data.frame(threads = i, time = time.taken)
  
  # добавление строки в таблицу
  df <- rbind(df, new_row)
  
  #запись в файлы
  write.table(i, file = "threads.txt", append = TRUE, 
              sep = "\t", dec = ".", row.names = FALSE, col.names = FALSE)
  write.table(time.taken, file = "time.txt", append = TRUE, 
              sep = "\t", dec = ".", row.names = FALSE, col.names = FALSE)
  if (i <= 10) {
    i <- i + 1
  }
  else {
    if (i <= 150) {
      i <- i + 10
    }
  }
  
}

write.csv(df, "my_dataframe.csv", row.names = FALSE)

plot(df$threads, df$time, type = "o", xlab = "Threads", ylab = "Time")
# Найти индекс строки с минимальным временем
min_index <- which.min(df$time)

# Добавить точку на график с помощью функции points
points(df$threads[min_index], df$time[min_index], col = "red", pch = 19)

# Добавить легенду
legend("topright", legend = "Минимальное время", col = "red", pch = 19)