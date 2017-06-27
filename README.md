# nscprepr

This package contains one function - `nsc_prep()` - which prepares and writes a file that is ready for submission to the National Student Clearinghouse's StudentTracker service. 

Begin by installing the package from CRAN:

```r
install.packages("nscprepr")

```

Store a data frame containing (at minimum) the columns in the example `df` below and executing the `nsc_prep()` function (substituting your institution's information and desired search type); the column names must be included (in any order) exactly as they are below (case sensitive). For more details on the columns (and what they mean) required by the StudentTracker service, please visit <http://www.studentclearinghouse.org/colleges/files/ST_ExcelInstructions.pdf>

The chunk below creates an example data frame. Notice that it is OK to violate some Clearinghouse requirements in your data frame because `nsc_prep()` will eventually resolve the issues (e.g., single digit days can be one (e.g., `3`) or two (e.g., `03`) digits;  you can include the full middle name as opposed to just a single character for the middle initial).

```r

df <- data.frame(first = c("Ruth", "William", "Sandra"),
             middle = c("Bader", "J.", "D"),
             last = c("Ginsburg", "Brennan", "O'Connor"),
             suffix = c("", "Jr.", ""),
             dob = c("3/15/1933", "5/25/1906", "03/26/1930"),
             id = c(1, 2, 3),
             search_date = c("1/1/1952", "6/01/1930", "8/5/1971"))

```

The `nsc_prep()` functions prepares and writes a file to the working directory that is ready for submission to the National Student Clearinghouse's StudentTracker service;  the file that is written will be ready to upload to the Clearinghouse (e.g., it will not
include the column names that are printed in the data frame below).

```r
library(nscprepr)

# substitute your institution's information
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

