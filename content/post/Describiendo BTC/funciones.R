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

