
(*
 *  execute "coolc bad.cl" to see the error messages that the coolc parser
 *  generates
 *
 *  execute "myparser bad.cl" to see the error messages that your parser
 *  generates
 *)

(* no error *)
class A {
};

(* error:  b is not a type identifier *)
Class b inherits A {
};

(* error:  a is not a type identifier *)
Class C inherits a {
};

(*Erro em feature mas ele se recupera e o parser não para*)
Class V{
    a : Int <- ;
    b : Int <- 9;
};


(*Dois erros: -> Uma declaração com erro no let que é recuperada pois existe
                outra declaração sem erro logo em seguida
              -> Uso de uma variável j não declarada dentro de um bloco que é recuperada
                    pois a próxima expressão não contém erros *)
Class Main{
    main() : Int{
        let 
            a : Int <- , 
            b : Int <- 6 
        in 
            {j; a;}
    };
}; 

(* Sem erros para que recuperemos do erro da classe anterior e o parser não pare *)
Class F {};

(* error:  opening brace is missing *)
Class E inherits A 
    teste_of(var : B) :  Int {
       case var of
            a : A => var.teste();
            b : B => var.teste();
        esac 
   };
};

(* Sem erros para que recuperemos do erro da classe anterior e o parser não pare *)
Class J {};

(* error:  keyword inherits is misspelled *)
Class D inherts A {
};