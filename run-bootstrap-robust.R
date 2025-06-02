# example of bootstrap sampling and estimation of standard errors

# revised May 23, 2024 by Thomas W. Miller

# estimating standard error of the median and trimmed mean
# providing comparisons with the standard error of the mean

# the standard error is the standard deviation
# of the sampling distribution

# comparing standard error estimates in this program
# assumes a normal population distribution using rnorm() 

# of course, one of the advantages of bootstrap
# estimation of standard errors is that it may be
# used for any population distribution

# bootstrap sampling is sampling with replacement
# which can be accomplished with the R sample() function

# larger numbers of bootstrap samples B 
# will yield better estimates of the true standard errors
# vary B by using separate executions of this program
B = 100
cat("\nRunning study with",B,"bootstrap samples\n")

ROUTE_OUTPUT_TO_LISTING = FALSE
if (ROUTE_OUTPUT_TO_LISTING) {
    listing_file_name = paste("listing-from-",as.character(B),"-run-bootstrap-robust.txt",sep="")
    cat("\nStudy results will be provided in:",listing_file_name,"\n")
    sink(listing_file_name)
}

# set up a data frame for saving study results
studyResults = NULL

# set the mean and standard deviation of two normal distributions,
# identified as main and outlier distributions
# the large percentage of observations come from the main distribution
# and a small percentage come from the outlier distribution
# the outlier distribution has a mean 
# much larger than the main distribution... 
mainPopMean = 100
mainPopSD = 10
outlierPopMean = 200 # far above main distribution mean
outlierPopSD = 1 
outlierProbability = 0.01 # very low probability of outliers contaminating the sample
cat("\nStudy conditions:")
cat("\n  Main population mean:",mainPopMean,"SD:",mainPopSD)
cat("\n  Outlier mean:",outlierPopMean,"SD:",outlierPopSD)
cat("\n  Probability of outliers:",outlierProbability,"\n")

# define probability distribution for the mixture
# of normal probability distributions
rmixnorm = function(outlierProbability,mainPopMean,mainPopSD,outlierPopMean,outlierPopSD) {
    if (runif(1) >= outlierProbability) {
        rnorm(1,mainPopMean,mainPopSD) 
    } else {
        rnorm(1,outlierPopMean,outlierPopSD)
    }
}

studySampleSizes = c(25,100,225,400) # convenient square-roots

# set trimming proportion for trimmed mean
TRIMMING_PROPORTION = 0.05
cat("\nTrimmed mean computed with trimming proportion",TRIMMING_PROPORTION,"\n")

# the Central Limit Theorem states that the standard
# error of the mean should be equal to the population
# standard deviation divided by the square-root 
# of the sample size

set.seed(9999) # for reproducible results for each study
# set inside the for-loop so larger n values build on same base as smaller values
for (iteration in 1:100) {
    # vary the sample size N
    for (nindex in seq(along=studySampleSizes)) {
        n = studySampleSizes[nindex]

        # generate sample with occasional outliers
        thisSample = numeric(n)
        for (iSample in seq(along=thisSample))
            thisSample[iSample] = rmixnorm(outlierProbability,mainPopMean,mainPopSD,outlierPopMean,outlierPopSD) 

        thisSampleMean = mean(thisSample)
        bootstrapSampleResults = NULL
        for (b in 1:B) {
            thisBootstrapSample = sample(thisSample, n, replace=TRUE)
            thisBootstrapMean = mean(thisBootstrapSample)
            thisBootstrapMedian = median(thisBootstrapSample)
            thisBootstrapTrimmedMean = mean(thisBootstrapSample, trim = TRIMMING_PROPORTION)

            thisBootstrapSampleResults = data.frame(bootMean=thisBootstrapMean, bootMedian=thisBootstrapMedian,
            bootTrimmedMean=thisBootstrapTrimmedMean)

            bootstrapSampleResults = rbind(thisBootstrapSampleResults,bootstrapSampleResults)
        }
        bootMean = mean(bootstrapSampleResults$bootMean)
        bootMedian = mean(bootstrapSampleResults$bootMedian)
        bootTrimmedMean = mean(bootstrapSampleResults$bootTrimmedMean)        
    
        thisIterationResults=data.frame(n,
                sampleMean = thisSampleMean,
                bootMean,
                bootMedian,
                bootTrimmedMean) 

        studyResults=rbind(studyResults, thisIterationResults)       
    }
}

# bootstrap-estimated standard errors for each sample size n
cat("\nEstimated standard errors using ",B," bootstrap samples\n",sep="")
for (nindex in seq(along=studySampleSizes)) {
    n = studySampleSizes[nindex]
    nStudyResults = studyResults[(studyResults$n == n),]
    cat("\nSamples of size n =",n)
    cat("\n  SE Mean from Central Limit Theorem (assuming no outliers):", round(mainPopSD/sqrt(n),digits=2))
    cat("\n  SE Mean from Samples (with outliers):",round(sd(nStudyResults$sampleMean),digits=2))
    cat("\n  SE Mean from Bootstrap Samples (with outliers):",round(sd(nStudyResults$bootMean),digits=2))
    cat("\n  SE Median from Bootstrap Samples (with outliers):",round(sd(nStudyResults$bootMedian),digits=2))
    cat("\n  SE Trimmed Mean from Bootstrap Samples (with outliers):",round(sd(nStudyResults$bootTrimmedMean),digits=2))
    cat("\n")
}

if (ROUTE_OUTPUT_TO_LISTING)
   sink()

cat("\n----- Run Complete -----\n")   




