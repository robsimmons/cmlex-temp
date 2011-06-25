

structure Lexer
   :> LEXER 
   =
   struct

      open Token

      structure Table =
         HashTable (structure Key = StringHashable)
         
      val keywords : token option Table.table = Table.table 60

      (* Illegal identifiers (most are SML reserved words). *)
      val () =
         List.app
         (fn str => Table.insert keywords str NONE)
         [
         "abstype",
         "andalso",
         "as",
         "case",
         "datatype",
         "do",
         "else",
         "end",
         "exception",
         "Fail",
         "fn",
         "fun",
         "functor",
         "handle",
         "if",
         "in",
         "infix",
         "infixr",
         "include",
         "let",
         "LexEngine",
         "local",
         "nonfix",
         "of",
         "op",
         "open",
         "ord",
         "orelse",
         "raise",
         "sharing",
         "sig",
         "signature",
         "struct",
         "structure",
         "symbol",
         "then",
         "val",
         "where",
         "while",
         "withtype"
         ]


      (* Reserved words in clex. *)
      val () =
         List.app
         (fn (str, token) => Table.insert keywords str (SOME token))
         [
         ("action", Action),
         ("alphabet", Alphabet),
         ("and", And),
         ("any", Any),
         ("empty", Empt),
         ("eos", Eos),
         ("epsilon", Epsilon),
         ("function", Function),
         ("name", Name),
         ("or", Or),
         ("range", Range),
         ("regexp", Regexp),
         ("seq", Seq),
         ("set", Set),
         ("type", Type)
         ]

        

      open Stream

      type arg = { str : char list,
                   len : int, 
                   start : char stream, 
                   follow : char stream, 
                   self : { lexmain : char stream -> int -> token front,
                            skipcomment : char stream -> int -> char stream * int} }

      exception LexicalError of int
      exception IllegalIdentifier of int
      exception IllegalConstant of int

      fun action f ({ str, len, follow, self, ... }:arg) pos =
          Cons (f (str, len, pos), lazy (fn () => #lexmain self follow (pos+len)))

      fun simple token ({ len, follow, self, ... }:arg) pos =
          Cons (token, lazy (fn () => #lexmain self follow (pos+len)))

      structure LexMain =
         LexMainFun
         (type symbol = char
          val ord = Char.ord

          type t = int -> token front
          type u = int -> char stream * int

          fun eof _ _ = Nil

          val ident = 
             action
             (fn (chars, _, pos) => 
                    let
                       val str = implode chars
                    in
                       (case Table.find keywords str of
                           NONE =>
                              Ident str
                         | SOME NONE =>
                              raise (IllegalIdentifier pos)
                         | SOME (SOME token) =>
                              token)
                    end)

          val number = 
             action 
             (fn (chars, _, pos) =>
                    ((case Int.fromString (implode chars) of
                         SOME n => 
                            Number n
                       | NONE =>
                            raise (Fail "invariant"))
                     handle Overflow => raise (IllegalConstant pos)))

          fun skip ({ len, follow, self, ... }:arg) pos = #lexmain self follow (pos+len)

          val char = 
             action
             (fn (chars, _, _) =>
                    (* By construction, chars should be '<ch> . *)
                    (case chars of
                        [_, ch] =>
                           Number (Char.ord ch)
                      | _ =>
                           raise (Fail "invariant")))

          fun lcomment ({ len, follow, self, ...}:arg) pos =
              let
                 val (follow', pos') = #skipcomment self follow (pos+len)
              in
                 #lexmain self follow' pos'
              end

          val string =
             action
             (fn (chars, len, _) =>
                    (* By construction, chars should begin and end with ". *)
                    String (List.map ord (List.take (List.tl chars, len-2))))

          fun error _ pos =
              raise (LexicalError pos)
                 
          val ampersand = simple And
          val arrow = simple Arrow
          val bar = simple Or
          val colon = simple Colon
          val equal = simple Equal
          val lparen = simple LParen
          val minus = simple Minus
          val plus = simple Plus
          val question = simple Question
          val rparen = simple RParen
          val slash = simple Range
          val star = simple Star
          val tilde = simple Tilde

          fun comment_open ({ len, follow, self, ... }:arg) pos =
              let
                 val (follow', pos') = #skipcomment self follow (pos+len)
              in
                 #skipcomment self follow' pos'
              end

          fun comment_close ({ len, follow, ...}:arg) pos = 
              (follow, pos+len)

          fun comment_skip ({ len, follow, self, ... }:arg) pos =
              #skipcomment self follow (pos+len)

          fun comment_error _ pos =
              raise (LexicalError pos)
                 
         )


      fun lex s = lazy (fn () => LexMain.lexmain s 0)

   end
