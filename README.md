# nscprepr

This package contains one function - `nsc_prep` - which prepares and writes a file that is ready for submission to the National Student Clearinghouse's StudentTracker service. 

Begin with a data frame containing (at minimum) the columns in the example `df` below and executing the `nsc_prep` function (substituting your institution's information and desired search type). For more information on search dates and inquiry types, please visit http://www.studentclearinghouse.org/colleges/files/ST_ExcelInstructions.pdf.

You can install the package from CRAN:

```r
install.packages("nscprepr")

```

Begin with a data frame:

```r
library(nscprepr)

# create example data frame
# notice how single digit months and days can be included as one digut (e.g., `3`) 
# or two (e.g., `03`)
df <- data.frame(first = c("Ruth", "William", "Sandra"),
             middle = c("Bader", "J.", "D"),
             last = c("Ginsburg", "Brennan", "O'Connor"),
             suffix = c("", "Jr.", ""),
             dob = c("3/15/1933", "5/25/1906", "03/26/1930"),
             id = c(1, 2, 3),
             search_date = c("1/1/1952", "6/01/1930", "8/5/1971"))

```
Run `nsc_prep()`:

```r
# nsc_prep() prepares and writes a file to the working directory that is ready for 
# submission to the National Student Clearinghouse's StudentTracker service. The file 
# that is written will be ready to upload to the Clearinghouse (e.g., it will not 
# include the column names that are printed in the data frame below).
nsc_prep(data = df, institution_code = "001509", branch_code = "00",
                institution_name = "Nova Southeastern University",
                inquiry_type = "SE") 



## # A tibble: 5 × 12
##   record_type    ssn   first                       middle     last suffix
##         <chr>  <chr>   <chr>                        <chr>    <chr>  <chr>
## 1          H1 001509      00 Nova Southeastern University 20170612     SE
## 2          D1           Ruth                            B Ginsburg       
## 3          D1        William                            J  Brennan    Jr.
## 4          D1         Sandra                            D O'Connor       
## 5          T1      5                                                     
## # ... with 6 more variables: dob <chr>, search_date <chr>, blank_1 <chr>,
## #   institution_code <chr>, branch_code <chr>, id <chr>
```

