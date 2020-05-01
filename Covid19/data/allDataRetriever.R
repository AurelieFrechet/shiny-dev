# # Take all the data from January 2020
# TOTAL_DAYS <- as.Date("2020/05/01") - as.Date("2020/01/01")
# TOTAL_DAYS <- as.numeric(TOTAL_DAYS)
# for (day in seq_len(TOTAL_DAYS)){
#   retrieveTodayData(day) %>%
#     saveRDS(
#       paste0("data/", dateFormat(day), ".RDS")
#     )
# }
# 
# 
# 
