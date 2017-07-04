import Html exposing (text)

type alias Ambiente = (String -> Int)
inicial : Ambiente
inicial = \i -> 0

--Definindo os tipos de Expressões
type Exp = Add Exp Exp | Sub Exp Exp | Mult Exp Exp | Div Exp Exp | Num Int | Var String | Const String
--Definindo os tipos de Comandos
type Comando = Attr String Exp | If Exp Comando Comando | While Exp Comando | Seq Comando Comando

avaliaExp : Exp -> Ambiente -> Int
avaliaExp exp amb =
    case exp of
        Const const -> (amb const)
        Var var        -> (amb var)
        Num v          -> v
        
        Add exp1 exp2  -> (avaliaExp exp1 amb) + (avaliaExp exp2 amb)
        Sub exp1 exp2 -> (avaliaExp exp1 amb) - (avaliaExp exp2 amb)
        Mult exp1 exp2 -> (avaliaExp exp1 amb) * (avaliaExp exp2 amb)
        Div exp1 exp2 -> (avaliaExp exp1 amb) // (avaliaExp exp2 amb)

avaliaProg : Comando -> Ambiente -> Ambiente
avaliaProg s amb =
    case s of
        Attr var exp ->
            let
                val = (avaliaExp exp amb)
            in
                \i -> if i==var then val else (amb i)
        
        Seq s1 s2 -> (avaliaProg s2 (avaliaProg s1 amb))
        
        If cond true false -> 
            if (avaliaExp cond amb) /= 0 
            then (avaliaProg true amb)
            else (avaliaProg false amb)
        While cond prog ->
            if (avaliaExp cond amb) /= 0
            then 
                (avaliaProg (While cond prog) (avaliaProg prog amb))
            else amb
        

lang : Comando -> Int
lang p = ((avaliaProg p inicial) "ret")

attr : Comando
attr = (Attr "ret" (Add (Num 11) (Num 9)))--Faz a soma de dois valores que no caso são 11 e 9 = 20

seq : Comando
seq =  (Seq (Attr "x"   (Num 11))(Attr "ret" (Sub (Var "x") (Num 9))))--Sequencia de numeros entre 9 e 11

cond : Comando
cond =   (Seq
            (Attr "x" (Num 1))--valor a ser testado, caso seja dirente de 0 retornara o valor de true, caso seja igual a 0 retornara o valor de false
            (If (Var "x")
                (Attr "ret" (Div (Num 11) (Num 9)))--true
                (Attr "ret" (Mult (Num 11) (Num 9)))--false
                )
        )

while: Comando
while =    (Seq
                (Seq
                    (Attr "i" (Num 20))--inicio a variavel i com um valor maior que zero qualquer para que o while seja executado
                    (While (Var "i")--o while ira se repertir enquanto o valor da variavel "i" for maior que 0
                        (Seq
                            (Attr "i" (Sub (Var "i") (Num 1)))--diminuo 1 da variavel i para que ela chegue ao valor 0 e possa terminar o loop
                            (Attr "x" (Add (Var "x") (Num 2)))--somo 2 a variavel x que será retornada ao final da execução
                        )
                    )
                )
                (Attr "ret" (Var "x"))--atribuo ao retorno o valor obtido em x
            )

main = text (toString (lang while))
