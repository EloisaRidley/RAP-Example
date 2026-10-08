leaf <- 24 + 23
print(leaf)
sum <-  0
for (i in 1:586000){
  square <- i ^ 2
  if (square %% 2 != 0){
    sum <- sum + square
  }
}
typeof(sum)
print(sum)