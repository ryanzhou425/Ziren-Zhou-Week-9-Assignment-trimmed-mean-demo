# Demo Overview
This is a demonstration program for the [Trimmed Mean Go](https://github.com/ryanzhou425/Ziren-Zhou-Week-9-Assignment-trimmed-mean-demo) package, designed to test and verify the functionality of a custom trimmed mean function. The program generates random samples containing 100 integers and 100 floating-point numbers, performs a 5% symmetric trim using a Go function, and compares the results with those from an [R script](trimmed_mean.R).

---

# How to run
Use the following command to run the program:
- go run main.go

If everything works correctly, the terminal will display:
- Trimmed Mean of Integer Data (5% trimmed): XXXXX
- Trimmed Mean of Float Data   (5% trimmed): XXXXX

Output generated:
- [integers.csv](integers.csv)
- [floats.csv](floats.csv)

[integers.csv](integers.csv): Contains 100 integer samples automatically generated by the program, with values ranging from 10 to 100

[floats.csv](floats.csv): Contains 100 floating-point samples generated by the program, with values ranging from 0.0 to 1.0

---

# Results Comparison
I wrote a simple [comparison script](trimmed_mean.R) using R. The script reads data from [integers.csv](integers.csv) and [floats.csv](floats.csv) to calculate the 5% symmetric trimmed mean.

**Output results:**

**Go:**
- Trimmed Mean of Integer Data (5% trimmed): 56.4889
- Trimmed Mean of Float Data   (5% trimmed): 0.4744

**R:**
- R Trimmed Mean (Integers, trim = 0.05): 56.48889
- R Trimmed Mean (Floats, trim = 0.05): 0.4744128

The output shows that the results calculated by Go and the R script are completely consistent. This comparison confirms that the trimmed mean function implemented in Go is accurate and reliable, making it suitable for real-world data processing tasks.

---

# Bootstrap Robustness Analysis
To further validate the robustness of the trimmed mean in the presence of outliers, I ran the provided R [script run-bootstrap-robust.R](run-bootstrap-robust.R).

**The results are as follows:**

- Samples of size n = 25
  - SE Mean from Central Limit Theorem (assuming no outliers): 2
  - SE Mean from Samples (with outliers): 2.64
  - SE Mean from Bootstrap Samples (with outliers): 2.65
  - SE Median from Bootstrap Samples (with outliers): 2.17
  - SE Trimmed Mean from Bootstrap Samples (with outliers): 2.25

- Samples of size n = 100
  - SE Mean from Central Limit Theorem (assuming no outliers): 1
  - SE Mean from Samples (with outliers): 1.41
  - SE Mean from Bootstrap Samples (with outliers): 1.42
  - SE Median from Bootstrap Samples (with outliers): 1.11
  - SE Trimmed Mean from Bootstrap Samples (with outliers): 1.02

- Samples of size n = 225
  - SE Mean from Central Limit Theorem (assuming no outliers): 0.67
  - SE Mean from Samples (with outliers): 0.91
  - SE Mean from Bootstrap Samples (with outliers): 0.91
  - SE Median from Bootstrap Samples (with outliers): 0.72
  - SE Trimmed Mean from Bootstrap Samples (with outliers): 0.63

- Samples of size n = 400
  - SE Mean from Central Limit Theorem (assuming no outliers): 0.5
  - SE Mean from Samples (with outliers): 0.75
  - SE Mean from Bootstrap Samples (with outliers): 0.75
  - SE Median from Bootstrap Samples (with outliers): 0.68
  - SE Trimmed Mean from Bootstrap Samples (with outliers): 0.57

The results clearly show that when data contains a small number of outliers, the standard error of the mean increases significantly compared to the theoretical value. In contrast, the SEs of the trimmed mean and the median remain relatively lower. For instance, with a sample size of 100, the SE of the trimmed mean is 1.02, which is substantially lower than the mean’s SE of 1.42. This demonstrates that the trimmed mean effectively mitigates the influence of outliers, providing a more robust estimate of central tendency.

---

# Use of AI Assistants
- Searched for whether, after creating a Go package locally and uploading it to GitHub, I would need to re-download it from GitHub in order to use it.
- Used Gemini to generate the trimmedmean_test test code.
- Searched for how to generate 100 integers and 100 floating-point numbers in Go.
- Used Gemini to write a comparison script in R.

---