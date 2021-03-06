---
title: "ME111 - Turmas A e B - Laboratório 4"
author: "Profa. Tatiana Benaglia"
output: html_document
---

## Implantação de Produtos Cash

No curso de ME110 vocês tiveram a participação do Roberto Colacioppo que apresentou uma análise de dados. Nesse exercício vocês irão reproduzir no R a análise que ele fez usando Excel.

Para relembrar o contexto do problema:

* No ano de 2005, um executivo da área comercial de uma instituição financeira recebeu relatórios mostrando reclamações crescentes sobre os novos produtos de *Cash Management* destinados a empresas de grande porte.

* São produtos de gestão como, por exemplo, Cobrança e Contas a Pagar. Os resultados financeiros também não andam bem e, desde que foram lançados, houve muitas desistências.

* Ele desconfia de problemas no pós-venda, pois a implantação desses produtos é bem complexa e demorada, e pede um diagnóstico à sua equipe.

* Sugere que eles estudem as desistências dos clientes e o tempo total de implementação.

* A equipe conseguiu uma base contendo todas as implementações desde Set/2004. 

Os dados utilizados estão disponíveis no seguinte link:

[https://www.dropbox.com/s/v56b874sef44l88/dadosRoberto.csv?dl=0](https://www.dropbox.com/s/v56b874sef44l88/dadosRoberto.csv?dl=0) 

Faça download desse arquivo e salve em uma pasta. Crie um arquivo .Rmd onde vocês escreverão as respostas a essas perguntas. Dica: Coloque o arquivo .Rmd e a planilha de dados na mesma pasta.

O comando a seguir importa os dados da planilha salva para o R:

```{r}
dados <- read.csv("dadosRoberto.csv", header=TRUE)
attach (dados)
```

**Responda as seguintes perguntas:**

1. Qual o percentual de desistência? Faça um gráfico de pizza para ilustrar esse percentual (use a função *pie()*).

```{r}
tab.status <- table(dados$STATUS)/nrow(dados)
##Para arredondar: round (nome, casas decimais)
round(tab.status, 2)

rotulos <- paste (names(tab.status), " ", round(tab.status, 2)*100, "%", sep="")
pie(tab.status, main = "Gráfico de pizza para Status", col = c("2","lightblue"), labels = rotulos, border = FALSE)
```

  O percentual de desistência é `r round(tab.status, 2)[1]*100`\%

2. Dentre os casos que desisitiram, quais foram os motivos? Faça um gráfico de barras com os motivos das desistências.
```{r}
desistencias <- subset (dados, STATUS == "Desistiu")
head (desistencias$MOTIVO)

tab.motivos <- round(table(desistencias$MOTIVO)[-1]/nrow(desistencias), 2)
par(mar=c(5, 14, 4, 2))
tab.motivos <- sort(tab.motivos)

barplot (tab.motivos, horiz = TRUE, las = 1, col = rainbow(10), main = "Motivos de Desistência", xlim = c(0, 0.6), border = FALSE)
```

3. Construa uma tabela 2x2 com a linhas sendo STATUS e as colunas sendo MEIO. Calcule o percentual de desistência por meio e faça um gráfico de barras para representar os percentuais da tabela.
```{r}
statusmeio <- table (STATUS, MEIO)
ptable <- prop.table(statusmeio, 2)
statusmeio

par(mar=c(5, 4, 4, 2))
barplot(ptable, beside = TRUE, col = c("red", "lightblue"), main = "Desistência por Meio", legend.text = TRUE, ylim = c(0, 1.1), border = FALSE)
```

4. Vamos agora estudar o tempo de implementação dos produtos. 

    a. Adicione ao banco de dados uma variável chamada "Tempo" que conta o tempo de implementação, ou seja, o número de dias entre a data do pedido e a data de entrega.

```{r}
dados$PEDIDO <- as.Date(DATA.PEDIDO, format="%d/%m/%Y")
dados$ENTREGA <- as.Date(DATA.ENTREGA, format="%d/%m/%Y")

Tempo <- as.numeric(dados$ENTREGA - dados$PEDIDO)
```

    b. Calcule as estatísticas sumárias para o tempo de implementação. Quantos dias em média tem demorado a implementação dos produtos? 

```{r}
summary(Tempo)
```
 
  A média da implementação do serviço  é de, aproximadamente, `r round (mean(Tempo))` dias.

    c. Faça um histograma do tempo de implementação. Existe um limite de 30 dias para implementação dos produtos. Mostrar esse limite no histograma com uma linha vermelha. 
```{r}
hist (c(Tempo), col = "lightblue", xlab = "Tempo de implementação", ylab = "Frequência", main = "Histograma do tempo de implementação", border = FALSE)
abline (v = 30,  col = "red")
```

    d. Quantos casos ultrapassaram o tempo limite (perderam o prazo)? Qual a porcentagem de casos fora do prazo?
```{r}
atrasados <- sum(Tempo > 30)
```

  A quantidade de casos de ultrapassaram o tempo limite estipulado pela empresa à sua época foi `r sum(Tempo > 30)`, e sua porcentagem representa `r round((atrasados/length(DATA.PEDIDO)), 2)*100`\% do total.

    e. Faça um boxplot do tempo de implementação por tipo de PRODUTO. O tempo varia de acordo com o produto?
```{r}
par(mar=c(5, 14, 4, 2))
boxplot(Tempo ~ PRODUTO, las=1, xlab="Tempo de Implementação", main="Boxplot do Tempo de Implementação por Produto", col = rainbow (3), outcol = "red", horizontal=TRUE, pch = 16)
```

  Ao observar o boxplot criado é possível notar que, sim, o tempo de implementação varia mediante o produto solicitado.
  
  O serviço "contas a pagar" possui mediana de tempo para ser implementado maior do que 40 dias, diferente do serviço "cobrança sem registro", cuja mediana está em, aproximadamente, 30 dias. É possível identificar alguns outliers nos produtos "contas a pagar" e "cobrança com registro", cuja implementação ultrapassou dos 100 dias de espera.
    
    f. Faça um boxplot do tempo de implementação por MEIO. O meio influencia no tempo de implementação?
```{r}
par(mar=c(5, 14, 4, 2))
boxplot(Tempo ~ MEIO, las=1, xlab="Tempo de Implementação", main="Boxplot do Tempo de Implementação por Meio", col = rainbow (3), outcol = "red", horizontal=TRUE, pch = 16)
```

  Sim, o meio influencia o tempo de implementação: é possível identificar que através da utilização do serviço de CNAB a espera é muito superior ao tempo de implementação do serviço realizado pela internet.

5. Vamos construir agora alguns indicadores ao longo tempo. Para isso, temos que criar uma nova variável que chamaremos de "Calendario", que conterá o ano e o mês da data do pedido (nessa ordem). 
```{r, echo=FALSE}
dados$Calendario <- format(dados$PEDIDO, "%Y/%m")
```

    a. Faça um gráfico de barras com o número de pedidos ao longo do tempo. O eixo x será o tempo e o eixo y será o total de casos naquele mês/ano.
```{r}
par(mar=c(5, 4, 4, 2))
barplot(table(dados$Calendario), las = 2, border = FALSE, col = "lightblue", ylab = "Pedidos", main = "Pedidos ao longo do tempo")
```

    b. Calcule o tempo médio de implementação ao longo do tempo. A funçaão *tapply()* vai te ajudar a fazer esse cálculo.
```{r}
Tempo_med <- tapply(Tempo, dados$Calendario, mean)
```

    c. No gráfico feito no item a), adicione uma linha representando o tempo médio de implentação por mês/ano.
```{r}
par(mar=c(5, 4, 4, 2))
graficolinha <- barplot(table(dados$Calendario), las = 2, border = FALSE, col = "lightblue", ylab = "Pedidos", main = "Pedidos ao longo do tempo")

par(new=T)
plot(Tempo_med, axes = F, ylim = c(0, 60), lwd=2, type = "l", col="red", yaxt="n", xlab = "", ylab = "")
axis(4, ylim=c(0,55),lwd=1)
mtext(4, text = "Tempo médio de implementação", line = 2)

legend("topleft", legend = "Tempo médio de implentação", fill = "red", cex = 0.8)
```

    d. Construa uma tabela 2x2 com a função *table()* para verificar o número de desistências por mês/ano. As linhas devem ser o tempo e as colunas o status. Calcule o percentual de desistência ao longo do tempo. 
```{r}
tabelastatus <- table(dados$Calendario, STATUS)
porcentstatus <- prop.table(tabelastatus, 1)

porcentstatus
```

    e. Faça uma gráfico representando a variável STATUS (Desistiu ou Operando) por mês/ano. Cada linha no gráfico deve representar uma das categorias da variável STATUS. Comente.
```{r}
par(mar=c(5, 4, 4, 2))

plot(porcentstatus[, 1], type = "l", col = "red", xaxt = "n", main = "Status por mês", xlab = "", ylab = "Taxa de Status", lwd = 2, ylim = c(0, 1))
lines(porcentstatus[, 2], type = "l", col = "lightblue", lwd = 2)

axis(1, at = 1:9, labels = row.names(tabelastatus))

legend("topleft", c("Operando", "Desistiu"), fill = c("lightblue", "red"), cex = 0.8, bty = "o")
```

  Ao analisar o gráfico criado é possível identificar que no período compreendido entre 09/2004 a 01/2005, a quantidade de desistência entre os consumidores era maior do que a quantidade que utilizava o serviço prestado pela empresa. Entretanto, o cenário se inverte a partir desse período e a quantidade de usuários com o status operando aumenta ligeiramente.
  
  É interessante analisar a natureza do gráfico: partindo da porcentagem do status, é possível concluir que o valor da quantidade de indivíduos com o serviço operando em determinado momento será a quantidade de consumidores que desistiram descontado de seu total. Em outras palavras, eles são complementares: enquanto a quantidade de implementação aumenta, a quantidade de desistências cai proporcionalmente e vice-versa.
  
  O ponto no qual as duas retas se cruzam pode ser considerado o "ponto de equilíbrio" entre as quantidades de desistência e implementação dos serviços, uma vez que nesse período ambas são iguais (50% para cada status).

    f. Vamos agora analisar as falhas ao longo do tempo. Faça um boxplot do número de FALHAS por mês/ano.
```{r}
boxplot(dados$FALHAS ~ dados$Calendario, col = rainbow(10), outcol = "red", pch = 16, main = "Boxplot de Falhas por Mês", ylab = "Falhas")
```

    g. Calcule o percentual de desistência ao longo do tempo por MEIO. Faça um gráfico para representar esses dados.
```{r}
cal.sta.meio <- table(dados$Calendario, dados$STATUS, dados$MEIO)
desist.tempo <- apply(cal.sta.meio, 3, function(x) prop.table(x,1) [,1])

matplot(desist.tempo, lwd=2, pch = 20, ylim=c(0,1), xaxt="n", type="b", col = rainbow(2), ylab = "Taxa de desistência", main = "Desistência ao longo do tempo por meio")
axis(1, at=1:9, labels=row.names(cal.sta.meio))
legend("topright", legend = c("CNAB", "INTERNET"), fill = rainbow(2), cex = 0.8)
```
    
