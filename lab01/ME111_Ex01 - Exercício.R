---
title: "ME111 - Turmas A e B - Exercício 1"
author: "Profa. Tatiana Benaglia"
output: html_document
---


No Laboratório 1, você recriou algumas das análises preliminares dos dados de batismo de Arbuthnot. Neste exercício, sua tarefa consiste em repetir alguns passos, mas para os registros de nascimento dos Estados Unidos. 

**Exercício:** Completar esse arquivo .Rmd com as suas respostas para as perguntas abaixo e submeter pelo Moodle até dia 24/03 às 23:50.

Para começar, se você ainda não o fez, faça o download da planilha contendo os dados usando o link abaixo 

[https://www.dropbox.com/s/64orsjpykl5pym0/NascimentosEUA.csv?dl=0](https://www.dropbox.com/s/64orsjpykl5pym0/NascimentosEUA.csv?dl=0)

Salve esse arquivo .csv na mesma pasta que contém o arquivo .Rmd deste relatório.

Para importar os dados da planilha para o R, execute o comando a seguir:

```{r}
dados <- read.csv("NascimentosEUA.csv", header=TRUE)
```


1. Quais anos estão incluídos neste conjunto de dados? Quais são as dimensões da base de dados e quais são os nomes das colunas ou variáveis?

```{r}
# Quantidade de anos 
dim(dados)[1]

#Dimensões da base de dados
dim(dados)

#Nomes das colunas
names(dados)
```

Texto respondendo a pergunta 1. Por exemplo, se eu quiser saber por quantos anos os nascimentos foram registrados, eu posso colocar comandos diretamente no meio do texto. Nesse caso, os nascimentos foram registrados por `r dim(dados)[1]` anos.

2. Como estas contagens se comparam aos dados de Arbuthnot? Eles estão numa escala similar?

```{r, echo=FALSE}
##Variável somando quantidade de nascimentos
dados$meninos + dados$meninas -> total

##Gráfico do total de nascimentos
plot(x = dados$ano, y = total,main = "Quantidade de nascimentos nos EUA por ano", xlab = "Ano", ylab = "Quantidade de nascimentos", type = "l", lwd = 1.5)
```

Texto respondendo a pergunta 2. Em ambos bancos de dados é possível visualizar certa tendência de cresimento na taxa de nascimentos, mas, no entanto, a quantidade de nascimentos registrados nos Estados Unidos é muito superior se comparado com a observada no período estudado por Arbuthnot na Inglaterra. Partindo de tais observações, é correto afirmar que as contagem não partilham de uma escala similar.

3. A observação de Arbuthnot de que os meninos nascem numa proporção maior que as meninas se mantém nos EUA?

```{r, echo=FALSE}
##Testando afirmação quantidade de meninos > quantidade de meninas
dados$meninos > dados$meninas
```

Texto respondendo a pergunta 3. Segundo o banco de dados analisado - composto por dados de nascimentos de meninas e meninos nos Estados Unidos entre os anos de 1940 e 2002 -, é possível identificar que a observaçãoo de Arbuthnot se mantém, uma vez que a proporção de nascimentos de meninos foi maior em todos os períodos em relação ao gênero oposto.

4. Crie um gráfico que mostre a razão de meninos para meninas para cada ano do conjunto de dados. O que você pode verificar?

```{r, echo=FALSE}
##Variáveis referentes à proporção de meninos e meninas
propmeninos <- dados$meninos / total
propmeninas <- dados$meninas / total

prop <- propmeninos / propmeninas

## Gráfico da razão meninos / meninas
plot(x = dados$ano, y = prop, main = "Razão de nascimentos entre meninos e meninas nos EUA por ano", xlab = "Ano", ylab = "Razão de nascimentos", type = "l", lwd = 1.5)
```

Texto respondendo a pergunta 4. Mediante análise do elemento gráfico é possível perceber que a tendência da taxa de fecundida no país é cair progressivamente, e um dos principais fatores para tal feito pode ser a condição econômica e desenvolvimento industrial em seu território.

O gráfico revela também a taxa de fecundidade em momentos históricos muito distintos. Por exemplo, podemos supor que o decaimento da razão de nascimentos observado a partir do final da década de 1940 tem como fator influenciador o desfecho da Segunda Guerra Mundial, bem como o avanço econômico e tecnológico dos Estados Unidos. Por sua vez, os picos observados durante a década de 1970 poderiam ter como principal influência o movimento Woodstock, que impôs um estilo de vida mais natural à população americana.

Para finalizar, o constante decrescimento percebido desde então dita a tendência de poucos filhos por casal. Essa observação pode ser afirmada a partir dos movimentos de êxodo rural, ora o fato de viver em cidades de grande porte é caro e impossibilita a criação de muitos filhos por casal.


5. Em qual ano se verifica o maior número de nascimentos nos EUA? 

```{r, echo=FALSE}
##Utilizando função which:
dados$ano [which (total == max(total))]
```

O ano com maior taxa de nascimentos registrados nos Estados durante o período compreendido no banco de dados é 1961.

Você pode utilizar os arquivos de ajuda ou o [cartão de referência do R](http://cran.r-project.org/doc/contrib/Short-refcard.pdf) para encontrar comandos úteis. 

Esses dados são provenientes de uma pesquisa realizada pelo [Center For Disease Control (CDC)](http://www.cdc.gov/nchs/data/nvsr/nvsr53/nvsr53_20.pdf). Confira-o se você desejar ler mais sobre a análise da razão entre os sexos nos nascimentos nos Estados Unidos.
