library(jsonlite)
library(glue)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(xts)

# create a function to retrieve daily data
retreive_daily_data <- function(pair, periodo = "d") {
  case_periodo <- c("m","h","d")
  value_periodo <- c(60,3600,86400)
  value_periodo <- value_periodo[which(case_periodo==periodo)]
  url = glue("https://api.pro.coinbase.com/products/{pair}-USD/candles?granularity={value_periodo}")
  columnNames <- c('unix', 'low', 'high', 'open', 'close', 'volume')
  mydata <- fromJSON(url)
  df <- as.data.frame(mydata)
  colnames(df) <- columnNames  # rename the columns
  df <- df %>% mutate(fecha = as.Date(as.POSIXct(unix, origin = "1970-01-01"))) %>% arrange(fecha)
  df <- df %>% mutate(pct_var = round(100 * (close / dplyr::lag(close) - 1), 4))
  return(df)
}

# Create a function to retrieve real time (lag10 sec)
get_crypto_realtime <- function(crypto){
  url <- glue("https://min-api.cryptocompare.com/data/price?fsym={crypto}&tsyms=USD")
  price <- as.data.frame(fromJSON(url))
  return(as.numeric(price))
}

# Funcion para calcular los retornos o variaciones
convertir_dataframe <- function(df, names_crypto){
  return(invisible(lapply(seq_along(df),
                   function(i,x) {assign(paste(names_crypto[i]),x[[i]], envir=.GlobalEnv)},
                   x=df)))
}

# Histograma de retorno aritmetico
histograma_variacion <- function(df, title){
  df <- df %>% dplyr::filter(!is.na(pct_var))
  promedio <- round(mean(df$pct_var),2)
  desv <- round(sd(df$pct_var),2)
  prob_ganar <- round(100*nrow(df[df$pct_var > 0,])/nrow(df),2)
  ret_posi <-  round(mean(df$pct_var[df$pct_var > 0]),2)
  ret_neg <-  round(mean(df$pct_var[df$pct_var < 0]),2)
  var99 <- round(quantile(df$pct_var,0.01),2)
  var95 <- round(quantile(df$pct_var,0.05),2)
  tvar95 <- df %>% dplyr::filter(pct_var<quantile(pct_var,0.05, na.rm=T)) %>% select(pct_var) %>% summarise(round(mean(pct_var),2))
  tvar99 <- df %>% dplyr::filter(pct_var<quantile(pct_var,0.01, na.rm=T)) %>% select(pct_var) %>% summarise(round(mean(pct_var),2))
  plot <- ggplot(df, aes(x = pct_var)) +
            geom_histogram(binwidth = 1, col='black', fill='green', alpha=0.4) +
            geom_vline(xintercept = quantile(df$pct_var,0.01), col = "red") +
            labs(x= "Retorno Diario",
                 title = glue('Distribucion {title}'),subtitle = glue("Probabilidad ganar:{prob_ganar}% \n Retorno promedio:{promedio}%\n Volatilidad:{desv}% \n Retorno Positivo:{ret_posi}% \n Retorno Negativo:{ret_neg}%")) +
            theme_minimal()+
            theme(panel.grid.major.x = element_blank(),
              plot.title = element_text(size = 14,
                                    face = "bold",
                                    hjust = 0.5),
              plot.subtitle = element_text(size=9,
                                       face = "plain",
                                       hjust = 0.5))

  VaR <- data.frame(Metrica = c("VaR 99%","VaR 95%","TVaR 99%", "TVaR 95%"),
                    Valor_pct = as.numeric(c(var99,var95,tvar99,tvar95)))

  r_r <- data.frame(crypto = title, Ret_Esperado = promedio, Riesgo_sd = desv)

  return(list(plot = plot,
              VaR = VaR,
              r_r = r_r))
}

# histograma_retorno_log
histograma_variacion_log <- function(df, title){
  df$pct_var <- 100*Delt(as.data.frame(df[,title])[,1], type = "log")
  df <- df %>% dplyr::filter(!is.na(pct_var))
  promedio <- round(mean(df$pct_var),2)
  desv <- round(sd(df$pct_var),2)
  prob_ganar <- round(100*nrow(df[df$pct_var > 0,])/nrow(df),2)
  ret_posi <-  round(mean(df$pct_var[df$pct_var > 0]),2)
  ret_neg <-  round(mean(df$pct_var[df$pct_var < 0]),2)
  var99 <- round(quantile(df$pct_var,0.01),2)
  var95 <- round(quantile(df$pct_var,0.05),2)
  tvar95 <- df %>% dplyr::filter(pct_var<quantile(pct_var,0.05, na.rm=T)) %>% select(pct_var) %>% summarise(round(mean(pct_var),2))
  tvar99 <- df %>% dplyr::filter(pct_var<quantile(pct_var,0.01, na.rm=T)) %>% select(pct_var) %>% summarise(round(mean(pct_var),2))
  plot <- ggplot(df, aes(x = pct_var)) +
    geom_histogram(binwidth = 1, col='black', fill='green', alpha=0.4) +
    geom_vline(xintercept = quantile(df$pct_var,0.01), col = "red") +
    labs(x= "Retorno Diario",
         title = glue('Distribucion {title}'),subtitle = glue("Probabilidad ganar:{prob_ganar}% \n Retorno promedio:{promedio}%\n Volatilidad:{desv}% \n Retorno Positivo:{ret_posi}% \n Retorno Negativo:{ret_neg}%")) +
    theme_minimal()+
    theme(panel.grid.major.x = element_blank(),
          plot.title = element_text(size = 14,
                                    face = "bold",
                                    hjust = 0.5),
          plot.subtitle = element_text(size=9,
                                       face = "plain",
                                       hjust = 0.5))

  VaR <- data.frame(Metrica = c("VaR 99%","VaR 95%","TVaR 99%", "TVaR 95%"),
                    Valor_pct = as.numeric(c(var99,var95,tvar99,tvar95)))

  r_r <- data.frame(crypto = title, Ret_Esperado = promedio, Riesgo_sd = desv)

  return(list(plot = plot,
              VaR = VaR,
              r_r = r_r))
}

# Convertir retornos en series
convertir_retorno_series <- function(df, title){
  df <- df %>% dplyr::filter(!is.na(pct_var))
  serie <- xts(df$pct_var, order.by= df$fecha)
  colnames(serie) <- title
  return(serie)
}

# Convertir precios en series
convertir_precio_series <- function(df, title){
  df <- df %>% dplyr::filter(!is.na(pct_var))
  serie <- xts(df$close, order.by= df$fecha)
  colnames(serie) <- title
  return(serie)
}

# Backtest Long position Portfolio
backtest_portafolio <- function(bt,res_sum) {
res_sum$performance_summary[1:9, 1:3] %>%
  data.frame() %>%
  mutate(Metric = row.names(.)) %>%
  mutate_if(is.numeric, function(x) {round(x, 3)}) %>%
  select(Metric, everything()) -> df_compare

rownames(df_compare) <- NULL

library(kableExtra) # For presenting table.

# Compare performance:

df_compare %>%
  kbl(caption = "Table 1: Desarrollo Portafolio", escape = TRUE) %>%
  kable_classic(full_width = FALSE, html_font = "Cambria") -> indicadores

# Cumulative weath:

library(lubridate)

bt$Portfolio1$data1$wealth %>%
  as.data.frame() %>%
  mutate(Date = row.names(.)) %>%
  mutate(Date = ymd(Date)) %>%
  rename(Weath = NAV) %>%
  mutate(Approach = "Equitativo") -> df1

bt$Portfolio2$data1$wealth %>%
  as.data.frame() %>%
  mutate(Date = row.names(.)) %>%
  mutate(Date = ymd(Date)) %>%
  rename(Weath = NAV) %>%
  mutate(Approach = "Tangente") -> df2

bt$Portfolio3$data1$wealth %>%
  as.data.frame() %>%
  mutate(Date = row.names(.)) %>%
  mutate(Date = ymd(Date)) %>%
  rename(Weath = NAV) %>%
  mutate(Approach = "Eficiente") -> df3

bt$index$data1$wealth %>%
  as.data.frame() %>%
  mutate(Date = row.names(.)) %>%
  mutate(Date = ymd(Date)) %>%
  rename(Weath = NAV) %>%
  mutate(Approach = "Indice") -> df4

bind_rows(df1, df2, df3, df4) -> df

df %>%
  mutate(Weath = round(Weath, 3)) %>%
  ggplot(aes(Date, Weath, color = Approach)) +
  geom_line() +
  theme(legend.title = element_blank()) +
  labs(title = "Compare Daily-Portfolio Cumulative Return") -> p

# https://rstudio.github.io/dygraphs/
library(dygraphs)

df %>%
  mutate(Weath = round(100*Weath, 2)) %>%
  pivot_wider(names_from = Approach, values_from = Weath) -> df_wider

xts(df_wider %>% select(2:5), order.by = df_wider$Date) -> df_wider_xts

from_date <- min(df_wider$Date)
to_date <- max(df_wider$Date)

df_wider_xts %>%
  dygraph(main = "Daily Portfolio Weath") %>%
  dyAxis(name = "y",
         # label = "Weath ($)",
         axisLabelFormatter = 'function(d){return Math.round(d) + "$"}') %>%
  dyRangeSelector(dateWindow = c(from_date, to_date)) -> plot_backtest

return(list(indicadores = indicadores,
            plot_backtest = plot_backtest))
}

# Backtest Long position Portfolio
backtest_portafolio_seleccion <- function(bt,res_sum) {
  res_sum$performance_summary[1:9, 1:2] %>%
    data.frame() %>%
    mutate(Metric = row.names(.)) %>%
    mutate_if(is.numeric, function(x) {round(x, 3)}) %>%
    select(Metric, everything()) -> df_compare

  rownames(df_compare) <- NULL

  library(kableExtra) # For presenting table.

  # Compare performance:

  df_compare %>%
    kbl(caption = "Table 1: Desarrollo Portafolio", escape = TRUE) %>%
    kable_classic(full_width = FALSE, html_font = "Cambria") -> indicadores

  # Cumulative weath:

  library(lubridate)

  bt$Portfolio_Seleccion$data1$wealth %>%
    as.data.frame() %>%
    mutate(Date = row.names(.)) %>%
    mutate(Date = ymd(Date)) %>%
    rename(Weath = NAV) %>%
    mutate(Approach = "Seleccion") -> df1

  bt$index$data1$wealth %>%
    as.data.frame() %>%
    mutate(Date = row.names(.)) %>%
    mutate(Date = ymd(Date)) %>%
    rename(Weath = NAV) %>%
    mutate(Approach = "Indice") -> df2

  bind_rows(df1, df2) -> df

  df %>%
    mutate(Weath = round(Weath, 3)) %>%
    ggplot(aes(Date, Weath, color = Approach)) +
    geom_line() +
    theme(legend.title = element_blank()) +
    labs(title = "Compare Daily-Portfolio Cumulative Return") -> p

  # https://rstudio.github.io/dygraphs/
  library(dygraphs)

  df %>%
    mutate(Weath = round(100*Weath, 2)) %>%
    pivot_wider(names_from = Approach, values_from = Weath) -> df_wider

  xts(df_wider %>% select(2:3), order.by = df_wider$Date) -> df_wider_xts

  from_date <- min(df_wider$Date)
  to_date <- max(df_wider$Date)

  df_wider_xts %>%
    dygraph(main = "Daily Portfolio Weath") %>%
    dyAxis(name = "y",
           # label = "Weath ($)",
           axisLabelFormatter = 'function(d){return Math.round(d) + "$"}') %>%
    dyRangeSelector(dateWindow = c(from_date, to_date)) -> plot_backtest

  return(list(indicadores = indicadores,
              plot_backtest = plot_backtest))
}

# Graficar online P&L
grafica_P_L <- function(df){
  PL_portafolio_D <- round(sum(df$P_L[1:4]),2)
  PL_portafolio_D_MC <- round(sum(df$P_L[8:11]),2)
  PL_portafolio_L <- round(sum(df$P_L[5:7]),2)
  pct_PL_portafolio_D <- round(100*PL_portafolio_D/sum(df$precio_compra[1:4]*df$unidades[1:4]),2)
  pct_PL_portafolio_L <- round(100*PL_portafolio_L/sum(df$precio_compra[5:7]*df$unidades[5:7]),2)
  pct_PL_portafolio_DMC <- round(100*PL_portafolio_D_MC/sum(df$precio_compra[8:11]*df$unidades[8:11]),2)
  plot_P_L <- df %>%
  ggplot(aes(x = label,
             y = P_L,
             fill= label )) +
  geom_bar(stat= "identity",
           color = "white",
           show.legend = FALSE,width = 0.07) +
  geom_text(aes(label = round(as.numeric(P_L),2)),
            position = position_dodge(0.9),
            vjust= 1.2,
            size = 4,
            color = "red")+
  #scale_fill_manual(values = df$label) +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal()+
  labs(x= "Criptomonedas", y = "Profit & Loss (USD)",
         title = glue('P&L actual:D {PL_portafolio_D} ({pct_PL_portafolio_D}%) | MC {PL_portafolio_D_MC} ({pct_PL_portafolio_DMC}%) | L {PL_portafolio_L} ({pct_PL_portafolio_L}%)'),
         subtitle = glue("Cripto {df$label[1]}: {round(df$P_L[1],2)} ({round(df$pct_PL[1],2)})% |Cripto {df$label[2]}: {round(df$P_L[2],2)} ({round(df$pct_PL[2],2)})% |Cripto {df$label[3]}: {round(df$P_L[3],2)} ({round(df$pct_PL[3],2)})% |Cripto {df$label[4]}: {round(df$P_L[4],2)} ({round(df$pct_PL[4],2)})% \n
         Cripto {df$label[8]}: {round(df$P_L[8],2)} ({round(df$pct_PL[8],2)})% |Cripto {df$label[9]}: {round(df$P_L[9],2)} ({round(df$pct_PL[9],2)})% |Cripto {df$label[10]}: {round(df$P_L[10],2)} ({round(df$pct_PL[10],2)})% |Cripto {df$label[11]}: {round(df$P_L[11],2)} ({round(df$pct_PL[11],2)})% \n
         Cripto {df$label[5]}: {round(df$P_L[5],2)} ({round(df$pct_PL[5],2)})% |Cripto {df$label[6]}: {round(df$P_L[6],2)} ({round(df$pct_PL[6],2)})% |Cripto {df$label[7]}: {round(df$P_L[7],2)} ({round(df$pct_PL[7],2)})%"),
       caption = glue("{date()}")) +
    theme(
          plot.title = element_text(size = 14,
                                    face = "bold",
                                    hjust = 0.5),
          plot.subtitle = element_text(size=7,
                                       face = "plain",
                                       hjust = 0.5))
    #enter_appear()

  return(plot_P_L)
}
