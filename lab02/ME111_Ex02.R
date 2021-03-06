---
title: "ME111 - Turmas A e B - Exercício 2"
author: "Profa. Tatiana Benaglia"
output: html_document
---

Primeiramente, carregue os dados descritos no Laboratório 2 para responder às questões abaixo.

```{r}
source("http://www.openintro.org/stat/data/cdc.R")
```

**Exercício:** Completar esse arquivo .Rmd com os códigos do R e suas respostas para as perguntas abaixo.

1. Crie um gráfico de dispersão da variável peso (**weight**) em relação ao peso desejado (**wtdesire**). Descreva a relação entre essas duas variáveis.

```{r, echo=FALSE}
## Retire o 'echo=FALSE' para visualizar os comandos no arquivo final
## Gráfico de dispersão entre peso e peso desejado
plot (cdc$weight, cdc$wtdesire, col=c("blue", "green"), xlab = "Peso", ylab = "Peso desejado", main = "Relação entre peso e peso desejado")
```

É possível analisar um comportamento linear entre as variáveis peso e peso desejado, e que os dados começam a se dissipar a partir do valor 300 do eixo horizontal.

2. Vamos considerar uma nova variável: a diferença entre o peso desejado (**wtdesire**) e o peso atual (**weight**). Crie esta nova variável subtraindo as duas colunas na base de dados e atribuindo-as a um novo objeto chamado **wdiff**.

```{r, echo=FALSE}
## criar variável wdiff
wdiff <- (cdc$wtdesire - cdc$weight)

```


3. Que tipo de dado está contido na variável **wdiff**? Se uma observação de **wdiff** é 0, o que isso implica com relação ao peso atual e desejado de uma pessoas? E se o valor de **wdiff** for positivo ou negativo?

```{r, echo=FALSE}
## comandos para responder a pergunta 3.
str (wdiff)
```

A variável wdiff contém valores inteiros, sendo composta por uma matriz de dimensão [1:20000], exibindo uma correlação entre o peso efetivo e o peso desejado dos indivíduos no estudo realizado. Em outras palavras, tal variável contém dados que traçam uma relação entre o nível de felicidade entre cada indivíduo com seu peso.

Se uma observação for zero, isso significaria que a pessoa está contente com o seu peso (seu peso atual é igual ao seu peso desejado). Por sua vez, se o valor for negativo, o indivíduo em questão deseja emagrecer. Finalmente, se o valor for positivo, significa que a pessoa deseja ganhar massa.

4. Descreva a distribuição de **wdiff** em termos de seu centro, forma e variação, incluindo qualquer gráfico que você usar. O que isso nos diz sobre como as pessoas se sentem a respeito do seu peso atual?

``` {r, echo=FALSE}
boxplot (wdiff, horizontal = TRUE, col="lightblue", main = "Relação entre peso e peso desejado")

hist (wdiff, col="lightblue", main = "Relação entre peso atual e peso desejado", xlab = "Peso efetivo x Peso desejado", ylab = "Frequência")

summary (wdiff)
```

Mediante análise dos elementos gráficos é possível identificar um comportamento simétrico no qual a maioria das pessoas deseja perder peso, enquanto uma pequena taxa dos entrevistados deseja ganhar massa. 

5. Utilizando sumários numéricos separadamente para homens e mulheres e um boxplot lado-a-lado para cada sexo, determine se homens tendem a ver seu peso diferentemente das mulheres.

```{r, echo=FALSE}
## Sumários numéricos para homes e mulheres
summary (cdc$gender == 'm')
summary (cdc$gender == 'f')

homem <- subset(cdc, cdc$gender == 'm')

mulher <- subset(cdc, cdc$gender == 'f')

## Boxplot de wdiff para homens e mulheres
boxplot (wdiff~cdc$gender, col=c("lightblue", "lightpink"), main = "Relação entre peso efetivo e peso desejado")
```

Analisando os elementos gráficos e os sumários numéricos separados por gênero, é possível notar claramente que a maioria dos homens desejam ganhar massa, enquanto a maioria das mulheres deseja emagrecer.

6. Encontre a média e o desvio padrão da variável peso (**weight**) e determine qual a proporção de pesos que estão a um desvio padrão da média.

```{r, echo=FALSE}
## comandos para responder a pergunta 6.

media <- mean (cdc$weight)
dp <- sqrt (var(cdc$weight))

meanplusd <- (media + dp)
meanminusd <- (media - dp)

meanplusd <- sum(cdc$weight > meanplusd)+sum(cdc$weight < meanminusd)
meanplusd / length (cdc$weight)
```

Você pode utilizar os arquivos de ajuda ou o [cartão de referência do R](http://cran.r-project.org/doc/contrib/Short-refcard.pdf) para encontrar comandos úteis. 
