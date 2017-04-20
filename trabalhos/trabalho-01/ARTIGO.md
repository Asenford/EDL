
# SNOBOL

## Introdução

A linguagem escolhida para este artigo foi **SNOBOL(StriNg Oriented symBOlic Language)**, originalmente e
não oficialmente chamada de **SEXI** e **SCL7**, é uma linguagem destinada para manipulação de strings
desenvolvida por *David J. Farber, Ralph E. Griswold e Ivan P. Polonsky*, que se destaca da maioria das
linguagens de programação por prover operadores padronizados de alternação e concatenação e ter
como padrão a entidade do tipo *“first-class data type”* (que significa um tipo de dado que pode ser
manipulado de todas as formas possíveis para qualquer outro tipo de dado na lingaguem) .

Alguns exemplos de operações básicas dessa linguagem são : Formação de uma string, procura de padrões e substituição.

## Origens e Influências

A linguagem foi desenvolvida entre os anos de 1962 e  1967.

### Teve influência das linguagens:

**COMIT** que foi a primeira linguagem de processamento de strings.

**SCL(Symbolic Communication Language)** linguagem desenvolvida para manipulação de fórmulas simbólicas, tendo como destaque a busca por padrões que serviu de inspiração para a SNOBOL.

**SHADOW** que é um compilador dirigido pela sintaxe(Syntax-directed compiler), que antecipou alguns padrões sistemáticos da SNOBOL e foi usada por David J. Farber nos experimentos de padrões iniciais. 

### Essa linguagem também influenciou diversas linguagens como: 

**Icon** que é uma linguagem de programação de alto nível destinada a facilitar as tarefas de programação envolvendo strings e estruturas.

**Lua** que é uma linguagem de programação projetada principalmente para sistemas embutidos e clients.

**SL5** que é uma linguagem de processamento de listas e strings com sintaxe orientada à expressão.

## Classificação

- Sintaxe padronizada:
	- Todas as linhas de comando do SNOBOL são na seguinte forma:
		> label subject pattern = object : transfer
	
- Armazenamento:
	- SNOBOL armazena variáveis, strings e estruturas de dados em uma única pilha do tipo Garbage-collected.

- Portabilidade:
	- Pode ser utilizada em diversos sistemas operacionais.
	

## Avaliação Comparativa

#### Torre de hanói em SNOBOL:

                define('hanoi(n,ns,nd,ni)')  :(hanoi.end)
    hanoi  eq(N,0)                           :s(return)
       hanoi(n - 1,ns,ni,nd)
       output = 'Move disc ' n ' from ' ns ' to ' nd
       hanoi(n - 1,ni,nd,ns)                 :(return)
    hanoi.end


#### Torre de Hanói em Python:

    def hanoi(n, source, helper, target):
      if n > 0:
        hanoi(n - 1, source, target, helper)
        if source[0]:
            disk = source[0].pop()
            print "moving " + str(disk) + " from " + source[1] + " to " + target[1]
            target[0].append(disk)
        hanoi(n - 1, helper, source, target)
    source = ([5,4,3,2,1], "source")
    target = ([], "target")
    helper = ([], "helper")
    hanoi(len(source[0]),source,helper,target)
    print source, helper, target

##### Writeability:

Analisando a writeability, **SNOBOL** é bem mais direta, necessitando de menos linhas de código.

##### Readability:

Ambas são bem similares no quesito de readability, é possível perceber facilmente o uso da recursividade nas duas linguagens, mas por possuir menos linhas de código a **SNOBOL** se torna mais simples de entender.

##### Expressividade:
  Tanto o código em **Python** quanto em **SNOBOL** possuem a mesma expressividade, ambas executam o código usando recursividade e obtém o mesmo resultado.

## Conclusão

Mesmo sendo uma linguagem antiga ela acaba se saindo um pouco melhor tanto em writeability quanto em readability em alguns códigos.

Serviu de influencia para varias linguagens que são usadas hoje.

## Bibliografia
* Wikipedia: https://en.wikipedia.org/wiki/SNOBOL
* Hopl: http://hopl.info/showlanguage.prx?exp=171
* Site da linguagem: http://www.snobol4.org/
