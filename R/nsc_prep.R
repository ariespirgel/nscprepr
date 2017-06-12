#' Prepares and writes files to submit to the National Student Clearinghouse.
#'
#' @importFrom dplyr lubridate stringr
#'
#' @param data A data frame containing the following columns (the definitions
#'   of the columns are provided in parentheses after the column names):
#'   first (student's first name), middle (student's middle name or inititial),
#'   last (student's last name), suffix (suffix to student's name), dob
#'   (student's date-of-birth, in the format mm/dd/yyyy), id (identifier
#'   information), search_date (search begin date, in the format mm/dd/yyyy).
#'   For the date columns, single digit months and days can be provided as
#'   either one digit (e.g., 9) or two digits (e.g., 09).
#' @param institution_code Six digit school code.
#' @param branch_code Two digit branch code.
#' @param institution_name Institution name.
#' @param inquiry_type "SE", "DA", "PA", "SB", "CO". More details can be found
#'   here: http://www.studentclearinghouse.org/colleges/files/ST_ExcelInstructions.pdf
#'
globalVariables(c("dob", "search_date", "middle", "record_type", "ssn", "suffix", "blank_1"))


nsc_prep <- function(data = NULL, institution_code = NULL, branch_code = NULL,
                      institution_name = NULL, inquiry_type = NULL) {

  date_today <- today()

  date_today <- paste0(year(date_today),
                       str_pad(month(date_today), 2, pad = "0"),
                       str_pad(day(date_today), 2, pad = "0"))

  data <- data %>%
    mutate(record_type = "D1",
           dob = mdy(dob),
           dob = paste0(year(dob),
                        str_pad(month(dob), 2, pad = "0"),
                        str_pad(day(dob), 2, pad = "0")),
           search_date = mdy(search_date),
           search_date = paste0(year(search_date),
                                str_pad(month(search_date), 2, pad = "0"),
                                str_pad(day(search_date), 2, pad = "0")),
           middle = str_sub(middle, start = 1, end = 1),
           record_type = record_type,
           ssn         = "",
           blank_1     = " ",
           institution_code = institution_code,
           branch_code = branch_code,
           search_date  = as.character(search_date),
           id          = as.character(id))

  data[is.na(data)] <- ""

  header <- tibble(record_type = "H1",
                   ssn = institution_code,
                   first = branch_code,
                   middle = institution_name,
                   last = date_today,
                   suffix = inquiry_type,
                   dob = "I",
                   search_date = "",
                   blank_1 = " ",
                   branch_code = "",
                   id = "",
                   institution_code = "")

  data <- bind_rows(header, data)


  trailer <- tibble(ssn = nrow(data) + 1,
                    record_type = "T1") %>%
    mutate(ssn = as.character(ssn),
           first = "",
           middle = "",
           last = "",
           suffix = "",
           dob = "",
           search_date = "",
           blank_1 = " ",
           branch_code = "",
           id = "",
           institution_code = "")

  data <- bind_rows(data, trailer)  %>%
    select(record_type, ssn, first, middle, last,  suffix,
           dob, search_date, blank_1, institution_code, branch_code, id)

  data <- unique(data)

  file_name <- paste0(institution_code, institution_name, date_today)

  write.table(data, paste0(file_name, ".txt"), col.names = FALSE, quote = FALSE, row.names = FALSE, sep =  "\t")

  return(data)

}


