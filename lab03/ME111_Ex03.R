---
title: "ME111 - Turmas A e B - Exercício 3"
author: "Profa. Tatiana Benaglia"
output: html_document
---

## Sinestesia

No curso de ME110 vocês realizaram uma atividade para testar um fenômeno chamado **sinestesia**. 

Cada aluno realizou um teste de percepção de cores e textos online e repetiu o teste três vezes, reportando o resultado (idade mental e tempo total em segundos) das 3 primeiras tentativas consecutivas.

As respostas de todos os alunos estão nessa [planilha](https://www.dropbox.com/s/8wmprpvzwh2o4y0/dadosSinestesia.csv?dl=0). Faça download do arquivo e coloque na mesma pasta em que está este seu arquivo .Rmd. 

O comando a seguir importa os dados da planilha para o R:

```{r}
sinestesia <- read.csv("dadosSinestesia.csv", header=TRUE)
```

*1. Encontre os seus dados na planilha acima e preencha com seus resultados obtidos*
```{r}
meuTeste <- sinestesia[sinestesia$RA == 174471, ] ## Substitua xxxxxx pelo seu RA
```

* Tentativa 1: Idade mental `r meuTeste$Idade1` anos e tempo `r meuTeste$Tempo1` segundos
* Tentativa 2: Idade mental `r meuTeste$Idade2` anos e tempo `r meuTeste$Tempo2` segundos
* Tentativa 3: Idade mental `r meuTeste$Idade3` anos e tempo `r meuTeste$Tempo3` segundos


*2. Calcule a média, a mediana, o mínimo, o máximo do tempo para completar os testes usando os dados das suas 3 tentativas.*

```{r, echo=FALSE}
meustempos <- as.numeric(meuTeste[, c(4, 6, 8)])
minhasidades <- as.numeric(meuTeste[, c(3, 5, 7)])
media <- mean(meustempos) ## calcula a média dos tempos e armazena numa variável chamada media
mediana <- median (meustempos) ## preencha com o comando para calcular a mediana
minimo <- min (meustempos) ## preencha com o comando para calcular o mínimo
maximo <- max (meustempos) ## preencha com o comando para calcular o máximo
media.idades <- mean (minhasidades)
```

Dentre as minhas 3 tentativas, o tempo médio para completar o teste é `r round(media, 0)` segundos; a mediana é `r round(mediana, 0)`. O menor tempo foi foi `r minimo` segundos e o maior foi `r maximo` segundos. E minha idade mental média é `r round(media.idades, 0)` anos.

*3. Faça um gráfico usando os dados das suas 3 tentativas. No eixo x, coloque a tentativa, no eixo y, sua idade mental.  A idade mental vai diminuindo com o número de tentativas?*

```{r}
tentativas <- c("1", "2", "3")
plot (tentativas, minhasidades, pch = 20, xlim = c(0,4), xlab = "Tentativas", ylab = "Idade mental", main = "Idade mental por tentativa")
```

É possível concluir que, sim, a idade mental diminui conforme o tempo tende a ser menor. No meu caso, por exemplo, obtive a idade de 22 anos na minha segunda tentativa, sendo a qual realizei com menor tempo em todo o teste. A terceira tentativa, na qual demorei alguns segundos a mais para concluir do que a tentativa anterior, obtive uma idade mental ligeiramente maior.

*4. Cada aluno fez 3 tentativas. Para definir qual o aluno mais rápido, primeiro podemos resumir as medidas das 3 tentativas de cada aluno usando: a mediana, a média, o mínimo ou o máximo. Preencha as frases a seguir. Qual medida para resumir os dados você acha que é a melhor nesse caso e por quê?*

```{r}
## Por exemplo, vamos calcular o máximo dos tempos para todos os alunos usando a função 'apply'

max_tempos <- apply(sinestesia[, c(4, 6, 8)], MARGIN =  1, FUN = max)
min_tempos <- apply(sinestesia[,c(4, 6, 8)], MARGIN = 1, FUN = min)
media_tempos <- apply(sinestesia[,c(4, 6, 8)], MARGIN = 1, FUN = mean)
mediana_tempos <- apply(sinestesia[,c(4, 6, 8)], MARGIN = 1, FUN = median)
mediana_idades <- apply(sinestesia[,c(3, 5, 7)], MARGIN = 1, FUN = median)
```

Se usarmos o máximo, o menor tempo foi `r min(max_tempos)` do aluno RA `r sinestesia$RA[which.min(max_tempos)]`.

Se usarmos o mínimo, o menor tempo foi `r min(min_tempos)` do aluno com RA `r sinestesia$RA[which.min(max_tempos)]`.

Se usarmos a média, o menor tempo foi `r min(media_tempos)` do aluno com RA `r sinestesia$RA[which.min(media_tempos)]`.

Se usarmos a mediana, o menor tempo foi `r min(mediana_tempos)` do aluno com RA `r sinestesia$RA[which.min(mediana_tempos)]`.

Acredito que a melhor medida para resumir os dados de tempos nesse caso é a mediana, pois ela não é influenciada por pontos aberrantes gerados por algumas observações como o caso da média. Além disso, as funções que calculam o mínimo e máximo da distribuição apontam apenas as observações mais extremas, e não oferecem uma ideia completa de como ela realmente é.


*5. Escolha uma estatística para resumir os dados de cada aluno (média, mediana, mínimo ou máximo). Usando a estatística escolhida, qual o maior tempo entre todos os alunos? E qual a menor idade mental?*

```{r}
## Maior tempo
max (max_tempos)

## Menor idade mental
max_idades <- max (sinestesia$Idade1, sinestesia$Idade2, sinestesia$Idade3)
min (max_idades)
```

Se usarmos o máximo, o maior tempo foi `r max(max_tempos)` do aluno RA `r sinestesia$RA[which.max(max_tempos)]`. 

Se usarmos o máximo, a menor idade mental foi `r min (max_idades)` do aluno RA `r sinestesia$RA[which.min(max_idades)]`.

Nas questões a seguir, considere apenas a **mediana** dos tempos e das idades das 3 tentativas de cada aluno.

*6. Construa dois gráficos: uma para descrever a distribuição das medianas dos tempos e outro para a distribuição das medianas das idades.*

```{r}
## Distribuição das medianas dos tempos
median_tempo <- apply(sinestesia[, c(4, 6, 8)], MARGIN = 1, FUN = median)
plot(median_tempo, main = "Distribuição das medianas dos tempos", xlab = "Alunos", ylab = "Mediana dos tempos", col = "darkgrey", pch = 20)

## Distribuição das medianas das idades
median_idade <- apply(sinestesia[, c(3, 5, 7)], MARGIN = 1, FUN = median)
plot(median_idade, main = "Distribuição das medianas das idades", xlab = "Alunos", ylab = "Mediana das idades", col = "darkgrey", pch = 20)
```

*7. Indique a mediana dos tempos e das idades das **suas** 3 tentativas nos respectivos gráficos usando uma cor diferente.*

```{r}
sinestesia$col <- ifelse(sinestesia$RA == 174471, "blue", "darkgrey")

## Distribuição das medianas dos tempos
plot(median_tempo, main = "Distribuição das medianas dos tempos", xlab = "Mediana dos tempos", ylab = "Aluno", col = sinestesia$col, pch = 20)

## Distribuição das medianas das idades
plot(median_idade, main = "Distribuição das medianas das idades", col = sinestesia$col, pch = 20, xlab = "Mediana das idades", ylab = "Aluno")
```

*8. Quantos alunos têm tempo de teste maior do que o seu? E quantos têm tempo de teste maior do que o seu?*

```{r}
sum(median_tempo > mediana)
sum(median_tempo < mediana)
```

Existem `r sum(median_tempo > mediana)` alunos com o tempo maior que o meu, enquanto há apenas `r sum(median_tempo < mediana)` alunos com o tempo menor do que o meu.

*9. Quantos alunos têm idade mental maior do que a sua? E quantos têm idade mental menor que a sua?*

```{r}
sum(mediana_idades > median(minhasidades))
sum(mediana_idades < median(minhasidades))
```

Existem `r sum(mediana_idades > median(minhasidades))` alunos com a idade mental maior que a minha, enquanto há apenas `r sum(mediana_idades < median(minhasidades))` alunos com a idade mental inferior a minha.

*10. Se todos os alunos praticarem e melhorarem o tempo em 5 segundos, como isso afetaria a distribuição das medianas dos tempos?*

```{r}
tempomelhor <- (median_tempo-5)
mediantotal <- c(tempomelhor, median_tempo)
medianas <- data.frame(mediantotal)
medianas$col <- ifelse ((mediantotal == median_tempo), "blue", "darkgrey")
medianas$aluno <- as.numeric(c(1:81), (1:81))
```

```{r}
plot (medianas$aluno, medianas$mediantotal, col = medianas$col, pch = 20, main = "Mediana dos tempos e melhora em 5 segundos", xlab = "Aluno", ylab = "Tempo")
legend ("topleft", c("Tempo Melhorado", "Tempo Original"), fill=c("blue", "darkgrey"), cex = 0.6, bty="o")
```

Ao observar o gráfico é possível inferir que se cada aluno melhorasse a mesma quantidade de tempo (nesse caso, 5 segundos), a distribuição dos tempos não sofreria nenhuma alteração: ela manteria os seus valores do eixo x e teria 5 valores acima no eixo y, não alterando a forma da distribuição em questão.


