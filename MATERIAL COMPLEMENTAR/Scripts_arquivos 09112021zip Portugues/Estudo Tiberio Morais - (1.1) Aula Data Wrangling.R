# Data Wrangling R

# Introdução ao pacote dplyr (https://dplyr.tidyverse.org/)

# O pacote dplyr está contido no tidyverse
# dplyr: contém muitas funções comuns na manipulação de dados

# Se for a primeira vez que utiliza o tidyverse, instale-o

install.packages("tidyverse")

# Se já instalou para análises anteriores, basta carregar o pacote

library(tidyverse) #importando biblioteca

library(readxl)   # importando o pacote readxl. Tambem existem outros.


##################################################################

#                             EXTRAS
# O R aceita aspas duplas "Oi", simples 'oi' e o sinal indicativo de crase `oi`

Sys.localeconv() #exibe as config padrões decimal, moeda etc do R

# Sitaxa rename: rename(dataset, novo_nome = antigo_nome)

#################################################################



dataset_inicial <- read_excel("(1.2) Dataset Aula Data Wrangling.xls")

View(dataset_inicial) #projetando o dataset no editor de script (tela 1)

head(dataset_inicial,3) #projetando as primeiras 3 linhas

str(dataset_inicial) #projetando a estrutura do dataset

glimpse(dataset_inicial) #Outra forma de projetar a estrutura do dataset

print(dataset_inicial) #projeta o dataset no R prompt (tela 3)

dim(dataset_inicial) #projeta as dimensões (qt linhas e colunas) do dataset

names(dataset_inicial) #projeta o nome das variáveis (colunas) do dataset


#Projetando varíaveis (colunas) específicas
dataset_inicial$Estudante #projeta apenas a var especificada depois do $
dataset_inicial$`Perfil ao volante` #utilizando o sinal ind de crase
dataset_inicial$"Período do dia" #utilizando aspas duplas
dataset_inicial$'Período do dia' #utilizando aspas simples



#                 ALTERANDO O NOME DE VARIÁVEIS

names(dataset_inicial) #verifificando os nomes originais

#criando um vetor c contendo os novos nomes
novos_nomes <- c("Observações",
                 "Tempo para Chegar",
                 "Distância Percorrida",
                 "Semáforos",
                 "Período",
                 "Perfil")


print(novos_nomes) #conferindo

names(dataset_inicial) <- novos_nomes #atribuindo o vetor de nomes ao dataset

names(dataset_inicial) #projetando os nomes das vars do dataset ja alterados

View(dataset_inicial)


#        ALTERANDO O NOME DAS VARIVÁVEIS BASE DE DADOS COM RENAME

#sitaxa rename: rename(dataset, novo_nome = antigo_nome)

print(dataset_inicial) #conferindo os nomes das variáveis (colunas)

nova_base <- rename(dataset_inicial,
                    observacoes = "Observações",
                    tempo = "Tempo para Chegar",
                    distancia = "Distância Percorrida",
                    semaforos = "Semáforos",
                    periodo = "Período",
                    perfil = "Perfil")


#conferindo a crição do novo dataset (nova_base) com os nomes das vars alterados
names(nova_base) 

names(dataset_inicial) #dataset original não sofreu alteração

#conferindo os nomes das vars
names(nova_base)

#projetando o dataset com os nomes das vars alterados, utilizando PIPE ( %>% )
#ainda assim, o nome original das vars não foi alterado
nova_base %>%  rename(obs = observacoes,
                      temp = tempo,
                      dist = distancia,
                      sem = semaforos,
                      per = periodo,
                      perf = perfil)

#verificando que o nome original das vars nao sofreu alteração
names(nova_base)

#nova base criada com base em nova_base com os nomes das vars alteradas
nova_base_pipe <- nova_base %>% rename(obs = observacoes,
                                       temp = tempo,
                                       dist = distancia,
                                       sem = semaforos,
                                       per = periodo,
                                       perf = perfil)

#conferindo
names(nova_base_pipe)
head(nova_base_pipe,3)


#editando os nomes das vars no proprio dataset.
#nesse caso, o dataset original foi alterado
nova_base_pipe <- nova_base_pipe %>% rename(ob = obs,
                                            te = temp,
                                            di = dist,
                                            se = sem,
                                            pe = per,
                                            pf = perf) 

#conferindo
names(nova_base_pipe)



#                           REMOVENDO UM OBJETO (rm)


rm(nova_base_pipe) #removendo o objeto nova_base_pipe




#verificando o nome da var original
names(nova_base)

#substituino o nome_original pelo indice da coluna
nova_base %>% rename(obs = 1,
                     temp = 2,
                     dist = 3,
                     sem = 4,
                     per = 5,
                     perf = 6)

#certificando que o nome original da var não foi alterado
names(nova_base)





###############################################################################

#                                 FUNÇÃO MUTATE   

###############################################################################

# Função "mutate": apresenta duas utilidades principais
# 1. Inclui variáveis no dataset, mantendo as existentes
# 2. Transforma o conteúdo das variáveis

# Numa primeira situação, são adicionados duas variáveis a um dataset existente 
# As observações no dataset e nas variáveis devem estar igualmente ordenadas


var_1 <- c(1,2,3,4,5,6,7,8,9,10) #nessa estrutura seq o tipo gerado será dbl
print(var_1)

var_2 <- c(11:20) #nesse estrutura de intervalos o tipo gerado será int
print(var_2)

var_3 <- c(11)

length(var_1) #calcula o tamanho da var
length(var_2)

#confirindo o objeto que iremos incluir as duas vars criadas
print(nova_base)


#add as novas vars ao objeto 
#as vars add precisam ter o mesmo tamanho do objeto ou == 1.
base_inclui <- mutate(nova_base,
                      var_1,
                      var_2,
                      var_3)

print(base_inclui)


#criando a var sobrenome
sobrenome <- c("Santos", "Souza", "Luz", "Silva", "Pereira",
               "Amaral","Lima", "Belfort", "Galvao", "Duarte")

#projetando a base_inclui com a add da var sobrenome
base_inclui %>% mutate(sobrenome) 


#verificando que o objeto original nao foi modifiado
names(base_inclui)


base_inclui <- base_inclui %>% mutate(sobrenome)

names(base_inclui)
print(base_inclui)



#exercitando
# add uma nova var e alterar o nome de outras vars ao mesmo tempo


idade <- c(32, 41, 29, 55, 62, 34, 56, 36, 47, 50)

#relembrando o objeto
names(base_inclui)


#checando os tamanhos
length(base_inclui)
length(idade)

#projetanto a var idade junto com o a alteração do nome das vars com PIPE
base_inclui %>% mutate(idade) %>% 
                rename(Nome = 1,
                       Tempo = 2,
                       Distancia = 3,
                       Semaforos = 4,
                       Periodo = 5,
                       Perfil = 6,
                       Var1 = 7,
                       Var2 = 8,
                       Var3 = 9,
                       Sobrenome = 10,
                       Idade = 11)


base_x <-  base_inclui %>% mutate(idade) %>% 
                           rename(Nome = 1,
                                 Tempo = 2,
                                 Distancia = 3,
                                 Semaforos = 4,
                                 Periodo = 5,
                                 Perfil = 6,
                                 Var1 = 7,
                                 Var2 = 8,
                                 Var3 = 9,
                                 Sobrenome = 10,
                                 Idade = 11)


print(base_x)


###############################################################################

#                                REPLACE

###############################################################################

#a funcao replace substitui o valor contido numa var por outro
#sintaxe 1: replace(var,"teste",novo_valor)
#sintaxe 2: replace(var,indice, novo_valor)



#projetando o objeto utilizando a func mutate para alterar os dados da var
#Semaforos onde a a func replace compara o valor da var e substiui por uma string
#utilizei sintaxe 1

base_x %>% mutate(Semaforos = replace(Semaforos, Semaforos==0,"Zero"),
                  Semaforos = replace(Semaforos, Semaforos==1,"Um"),
                  Semaforos = replace(Semaforos, Semaforos==2,"Dois"),
                  Semaforos = replace(Semaforos,Semaforos==3,"Tres")
                  )


#testando a sintaxe 2
base_x %>% mutate(Semaforos = replace(Semaforos,1, "AAAAAAA"))





###############################################################################

#                                RECODE

###############################################################################

head(base_x)


# Praticando o recode - add uma var com base nos valores de outra var

mutate(base_x, Num_Perfil = recode(Perfil,
                                    "calmo"=0,
                                    "moderado"=1,
                                    "agressivo"=2))



mutate(base_x,Turno = recode(Periodo,
                              "Manhã"=1,
                              "Tarde"=2,
                              "Noite"=3))




###############################################################################

#                                TRANSMUTE

###############################################################################

#permite add var e especificar quais vars existentes serão mantidas no obj 

base_teste <- nova_base

head(base_teste)

inicial <- c("GS","DS","GL","LS","LP","LA","AL","AB","JG","MD")

base_teste <- transmute(base_teste,inicial, observacoes, distancia)

head(base_teste)



###############################################################################

#                                CUT

###############################################################################

#cut: cria uma 

median(base_teste$distancia)


mutate(base_teste,distancia_m = cut(distancia,
                                    c(0,median(distancia),32),
                                    c("abaixo","acima")
                                    )
       )




# Novo exemplo
head(nova_base)


mutate(nova_base, tempo_m = cut(tempo,
                                c(0,median(tempo),55),
                                c("T_inferior","T_superior")
                                )
      )





#mais uma prática
head(base_x)

mutate(base_x, idade_m = cut(idade,
                             c(0,median(idade),62),
                             c("I_Inferior","I_Superior")
                             )
       )
median(base_x$Idade)






#mais um exemplo utilizando labels para dar nome aos intervalos
mutate(base_x, idade_m = cut(idade,
                             c(0,median(idade),62),
                             labels = c("Jovem","Adulto")
                             )
       )




