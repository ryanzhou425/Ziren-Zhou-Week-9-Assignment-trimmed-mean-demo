package main

import (
	"encoding/csv"
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"time"

	trimmedmean "github.com/ryanzhou425/Ziren-Zhou-Week-9-Assignment-trimmed-mean-package"
)

func main() {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))

	// Generate 100 random integers in the range [10, 100]
	intData := make([]float64, 100)
	for i := range intData {
		intData[i] = float64(r.Intn(91) + 10)
	}

	// Generate 100 random float values in the range [0.0, 1.0)
	floatData := make([]float64, 100)
	for i := range floatData {
		floatData[i] = r.Float64()
	}

	// Compute trimmed means (5% trimmed) using the custom Go package
	intMean, _ := trimmedmean.TrimmedMean(intData, 0.05)
	floatMean, _ := trimmedmean.TrimmedMean(floatData, 0.05)

	fmt.Printf("Trimmed Mean of Integer Data (5%% trimmed): %.4f\n", intMean)
	fmt.Printf("Trimmed Mean of Float Data   (5%% trimmed): %.4f\n", floatMean)

	// Save generated data to CSV files (for verification in R)
	writeToCSV("integers.csv", intData)
	writeToCSV("floats.csv", floatData)
}

func writeToCSV(filename string, data []float64) {
	file, err := os.Create(filename)
	if err != nil {
		fmt.Printf("Error creating file %s: %v\n", filename, err)
		return
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	for _, v := range data {
		err := writer.Write([]string{strconv.FormatFloat(v, 'f', 6, 64)})
		if err != nil {
			fmt.Println("Error writing to CSV:", err)
			return
		}
	}
}
