\name{nsc_prep}
\alias{nsc_prep}
\title{Prepares and writes files for the National Student Clearinghouse.}
\usage{
nsc_prep(data = NULL, institution_code = NULL, branch_code = NULL,
  institution_name = NULL, inquiry_type = NULL)
}
\description{
Prepares and writes files for submission to the National Student Clearinghouse's
  StudentTracker service. For more details on the fields (and what they mean)
  required by the service, please visit
  < http://www.studentclearinghouse.org/colleges/files/ST_ExcelInstructions.pdf>
}
\arguments{
\item{data}{A data frame containing the following columns (the definitions
   of the columns are provided in parentheses after the column names):
   first (student's first name), middle (student's middle name or initial),
   last (student's last name), suffix (suffix to student's name), dob
   (student's date-of-birth, in the format mm/dd/yyyy), id (identifier
   information), search_date (search begin date, in the format mm/dd/yyyy).
   For the date columns, single digit months and day can be provided as
   either one digit (e.g., 9) or two digits (e.g., 09).}

\item{institution_code}{Six digit school code}

\item{branch_code}{Two digit branch code}

\item{institution_name}{Institution name}

\item{inquiry_type}{"SE", "DA", "PA", "SB", "CO"}


}

\examples{

# create a data frame
df <- data.frame(first = c("Ruth", "William", "Sandra"),
             middle = c("Bader", "J.", "D"),
             last = c("Ginsburg", "Brennan", "O'Connor"),
             suffix = c("", "Jr.", ""),
             dob = c("3/15/1933", "5/25/1906", "03/26/1930"),
             id = c(1, 2, 3),
             search_date = c("1/1/1952", "6/01/1930", "8/5/1971"))

# prepare and write a file to the working directory that is ready for
# submission to the Clearinghouse's StudentTracker service
nsc <- nsc_prep(data = df, institution_code = "001509", branch_code = "00",
                institution_name = "Nova Southeastern University",
                inquiry_type = "SE")

}



