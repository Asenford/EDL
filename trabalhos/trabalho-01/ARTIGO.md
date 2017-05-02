
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

#### Replace em SNOBOL:

        str1 = 'Estrutura de Linguagens'
    l1  str1   'a' = '4' :s(l1)
        output = str1
    end

#### Replace em Python:

	str1= "Estrutura de Linguagens"
	str1 = str1.replace("a", "4")
	print str1

##### Output dos códigos:

Estrutur4 de Lingu4gens

#### Writeability:

Os códigos são iguais no quesito writeability, ambos foram iguais tanto em simplicidade quanto em velocidade de programação.

#### Readability:

Em Python fica mais visível a modificação que está sendo feita, pois a chamada do método “replace”(substituir) já deixa claro o que está sendo feito.

#### Expressividade:
Nos tratamentos de strings o SNOBOL se sobressai do python, pois as strings em SNOBOL são mutáveis, podendo assim fazer modificações diretamente na string, enquanto no python é necessário chamar um método “.replace()” que está copiando a string para fazer as modificações e retornando uma nova string modificada sendo necessário estabelecer o valor da string antiga pela nova “ str1 = str1 .replace("a", "4") “.

## Conclusão

SNOBOL é uma linguagem antiga então é possível ver que muitas de suas funcionalidades já estão presentes nas linguagens mais novas, mas ainda assim é possível obter um tratamento de strings aprimorado quando se usa SNOBOL.

Serviu de influencia para varias linguagens que são usadas hoje.

## Bibliografia
* Wikipedia: https://en.wikipedia.org/wiki/SNOBOL
* Hopl: http://hopl.info/showlanguage.prx?exp=171
* Site da linguagem: http://www.snobol4.org/
