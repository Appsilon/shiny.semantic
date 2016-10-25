# Download some data
getSymbols(Symbols = c("AAPL", "MSFT"))

traders <- data.frame(Date = index(AAPL), AAPL[,6], MSFT[,6]) %>%
  plot_ly(x = ~Date) %>%
  add_lines(y = ~AAPL.Adjusted, name = "Rice") %>%
  add_lines(y = ~MSFT.Adjusted, name = "Corn") %>%
  layout(
    title = "Stock Prices",
    xaxis = list(
      rangeselector = list(
        buttons = list(
          list(
            count = 3,
            label = "3 mo",
            step = "month",
            stepmode = "backward"),
          list(
            count = 6,
            label = "6 mo",
            step = "month",
            stepmode = "backward"),
          list(
            count = 1,
            label = "1 yr",
            step = "year",
            stepmode = "backward"),
          list(
            count = 1,
            label = "YTD",
            step = "year",
            stepmode = "todate"),
          list(step = "all"))),

      rangeslider = list(type = "date")),

    yaxis = list(title = "Price"))
