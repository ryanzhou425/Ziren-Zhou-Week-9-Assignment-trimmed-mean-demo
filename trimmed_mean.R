ints <- scan("integers.csv")
floats <- scan("floats.csv")

int_trimmed_mean <- mean(ints, trim = 0.05)
float_trimmed_mean <- mean(floats, trim = 0.05)

cat("R Trimmed Mean (Integers, trim = 0.05):", int_trimmed_mean, "\n")
cat("R Trimmed Mean (Floats, trim = 0.05):", float_trimmed_mean, "\n")
