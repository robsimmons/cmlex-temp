
functor ParseMainFunHs
   (structure Streamable : STREAMABLE
    structure Arg :
       sig
          type string
          type int
          type intlist
          type numpairs
          type charset
          type charsets
          type regexp
          type regexps
          type arm
          type arms
          type qident
          type directive
          type directives

          val cons_directives : directive * directives -> directives
          val nil_directives : unit -> directives
          val function_directive : string * string * arms -> directive
          val set_directive : string * charset -> directive
          val regexp_directive : string * regexp -> directive
          val alphabet_directive : int -> directive
          val monadic_directive : unit -> directive
          val name_directive : qident -> directive
          val cons_qident : string * qident -> qident
          val sing_qident : string -> qident
          val cons_arms : arm * arms -> arms
          val sing_arms : arm -> arms
          val sole_arm : regexp * string -> arm
          val cons_regexps : regexp * regexps -> regexps
          val nil_regexps : unit -> regexps
          val eos_regexp : unit -> regexp
          val repeat_regexp : regexp * int * int -> regexp
          val geq_regexp : regexp * int -> regexp
          val equal_regexp : regexp * int -> regexp
          val plus_regexp : regexp -> regexp
          val closure_regexp : regexp -> regexp
          val option_regexp : regexp -> regexp
          val union_regexp : regexps -> regexp
          val seq_regexp : regexps -> regexp
          val concat_regexp : regexps -> regexp
          val empty_regexp : unit -> regexp
          val epsilon_regexp : unit -> regexp
          val any_regexp : unit -> regexp
          val string_regexp : intlist -> regexp
          val number_regexp : int -> regexp
          val ident_regexp : string -> regexp
          val cons_charsets : charset * charsets -> charsets
          val nil_charsets : unit -> charsets
          val any_charset : unit -> charset
          val comp_charset : charsets -> charset
          val diff_charset : charset * charsets -> charset
          val intersect_charset : charsets -> charset
          val union_charset : charsets -> charset
          val empty_charset : unit -> charset
          val range_charset : numpairs -> charset
          val number_charset : int -> charset
          val ident_charset : string -> charset
          val cons_numpairs : int * int * numpairs -> numpairs
          val nil_numpairs : unit -> numpairs
          val number : int -> int
          val ident : string -> string

          datatype terminal =
             LIDENT of string
           | UIDENT of string
           | NUMBER of int
           | STRING of intlist
           | ALPHABET
           | AND
           | ANY
           | ARROW
           | COLON
           | DOT
           | EOS
           | EMPT
           | EPSILON
           | EQUAL
           | FUNCTION
           | GEQ
           | LPAREN
           | MINUS
           | MONADIC
           | NAME
           | OR
           | PLUS
           | QUESTION
           | RANGE
           | REGEXP
           | REPEAT
           | RPAREN
           | SEQ
           | SET
           | STAR
           | TILDE

          val error : terminal Streamable.t -> exn
       end)
   :>
   sig
      val parse : Arg.terminal Streamable.t -> Arg.directives * Arg.terminal Streamable.t
   end
=

(*

State 0:

start -> . Directives  / 0
38 : Directive -> . NAME QIdent  / 1
39 : Directive -> . MONADIC  / 1
40 : Directive -> . ALPHABET Number  / 1
41 : Directive -> . REGEXP Ident EQUAL Regexp  / 1
42 : Directive -> . SET Ident EQUAL Charset  / 1
43 : Directive -> . FUNCTION Ident COLON Ident EQUAL Arms  / 1
44 : Directives -> .  / 0
45 : Directives -> . Directive Directives  / 0

$ => reduce 44
ALPHABET => shift 4
FUNCTION => shift 3
MONADIC => shift 2
NAME => shift 7
REGEXP => shift 6
SET => shift 5
Directive => goto 1
Directives => goto 8

-----

State 1:

38 : Directive -> . NAME QIdent  / 1
39 : Directive -> . MONADIC  / 1
40 : Directive -> . ALPHABET Number  / 1
41 : Directive -> . REGEXP Ident EQUAL Regexp  / 1
42 : Directive -> . SET Ident EQUAL Charset  / 1
43 : Directive -> . FUNCTION Ident COLON Ident EQUAL Arms  / 1
44 : Directives -> .  / 0
45 : Directives -> . Directive Directives  / 0
45 : Directives -> Directive . Directives  / 0

$ => reduce 44
ALPHABET => shift 4
FUNCTION => shift 3
MONADIC => shift 2
NAME => shift 7
REGEXP => shift 6
SET => shift 5
Directive => goto 1
Directives => goto 9

-----

State 2:

39 : Directive -> MONADIC .  / 1

$ => reduce 39
ALPHABET => reduce 39
FUNCTION => reduce 39
MONADIC => reduce 39
NAME => reduce 39
REGEXP => reduce 39
SET => reduce 39

-----

State 3:

0 : Ident -> . LIDENT  / 2
43 : Directive -> FUNCTION . Ident COLON Ident EQUAL Arms  / 1

LIDENT => shift 11
Ident => goto 10

-----

State 4:

1 : Number -> . NUMBER  / 1
40 : Directive -> ALPHABET . Number  / 1

NUMBER => shift 13
Number => goto 12

-----

State 5:

0 : Ident -> . LIDENT  / 3
42 : Directive -> SET . Ident EQUAL Charset  / 1

LIDENT => shift 11
Ident => goto 14

-----

State 6:

0 : Ident -> . LIDENT  / 3
41 : Directive -> REGEXP . Ident EQUAL Regexp  / 1

LIDENT => shift 11
Ident => goto 15

-----

State 7:

36 : QIdent -> . UIDENT  / 1
37 : QIdent -> . UIDENT DOT QIdent  / 1
38 : Directive -> NAME . QIdent  / 1

UIDENT => shift 17
QIdent => goto 16

-----

State 8:

start -> Directives .  / 0

$ => accept

-----

State 9:

45 : Directives -> Directive Directives .  / 0

$ => reduce 45

-----

State 10:

43 : Directive -> FUNCTION Ident . COLON Ident EQUAL Arms  / 1

COLON => shift 18

-----

State 11:

0 : Ident -> LIDENT .  / 4

$ => reduce 0
LIDENT => reduce 0
NUMBER => reduce 0
STRING => reduce 0
ALPHABET => reduce 0
ANY => reduce 0
ARROW => reduce 0
COLON => reduce 0
EOS => reduce 0
EMPT => reduce 0
EPSILON => reduce 0
EQUAL => reduce 0
FUNCTION => reduce 0
LPAREN => reduce 0
MONADIC => reduce 0
NAME => reduce 0
REGEXP => reduce 0
RPAREN => reduce 0
SET => reduce 0

-----

State 12:

40 : Directive -> ALPHABET Number .  / 1

$ => reduce 40
ALPHABET => reduce 40
FUNCTION => reduce 40
MONADIC => reduce 40
NAME => reduce 40
REGEXP => reduce 40
SET => reduce 40

-----

State 13:

1 : Number -> NUMBER .  / 5

$ => reduce 1
LIDENT => reduce 1
NUMBER => reduce 1
STRING => reduce 1
ALPHABET => reduce 1
ANY => reduce 1
ARROW => reduce 1
EOS => reduce 1
EMPT => reduce 1
EPSILON => reduce 1
FUNCTION => reduce 1
LPAREN => reduce 1
MONADIC => reduce 1
NAME => reduce 1
REGEXP => reduce 1
RPAREN => reduce 1
SET => reduce 1

-----

State 14:

42 : Directive -> SET Ident . EQUAL Charset  / 1

EQUAL => shift 19

-----

State 15:

41 : Directive -> REGEXP Ident . EQUAL Regexp  / 1

EQUAL => shift 20

-----

State 16:

38 : Directive -> NAME QIdent .  / 1

$ => reduce 38
ALPHABET => reduce 38
FUNCTION => reduce 38
MONADIC => reduce 38
NAME => reduce 38
REGEXP => reduce 38
SET => reduce 38

-----

State 17:

36 : QIdent -> UIDENT .  / 1
37 : QIdent -> UIDENT . DOT QIdent  / 1

$ => reduce 36
ALPHABET => reduce 36
DOT => shift 21
FUNCTION => reduce 36
MONADIC => reduce 36
NAME => reduce 36
REGEXP => reduce 36
SET => reduce 36

-----

State 18:

0 : Ident -> . LIDENT  / 3
43 : Directive -> FUNCTION Ident COLON . Ident EQUAL Arms  / 1

LIDENT => shift 11
Ident => goto 22

-----

State 19:

0 : Ident -> . LIDENT  / 1
1 : Number -> . NUMBER  / 1
4 : Charset -> . Ident  / 1
5 : Charset -> . Number  / 1
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 1
7 : Charset -> . EMPT  / 1
8 : Charset -> . LPAREN OR Charsets RPAREN  / 1
9 : Charset -> . LPAREN AND Charsets RPAREN  / 1
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 1
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 1
12 : Charset -> . ANY  / 1
42 : Directive -> SET Ident EQUAL . Charset  / 1

LIDENT => shift 11
NUMBER => shift 13
ANY => shift 26
EMPT => shift 25
LPAREN => shift 28
Ident => goto 27
Number => goto 24
Charset => goto 23

-----

State 20:

0 : Ident -> . LIDENT  / 1
1 : Number -> . NUMBER  / 1
15 : Regexp -> . Ident  / 1
16 : Regexp -> . Number  / 1
17 : Regexp -> . STRING  / 1
18 : Regexp -> . ANY  / 1
19 : Regexp -> . EPSILON  / 1
20 : Regexp -> . EMPT  / 1
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 1
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 1
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 1
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 1
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 1
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 1
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 1
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 1
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 1
30 : Regexp -> . EOS  / 1
41 : Directive -> REGEXP Ident EQUAL . Regexp  / 1

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 29

-----

State 21:

36 : QIdent -> . UIDENT  / 1
37 : QIdent -> . UIDENT DOT QIdent  / 1
37 : QIdent -> UIDENT DOT . QIdent  / 1

UIDENT => shift 17
QIdent => goto 38

-----

State 22:

43 : Directive -> FUNCTION Ident COLON Ident . EQUAL Arms  / 1

EQUAL => shift 39

-----

State 23:

42 : Directive -> SET Ident EQUAL Charset .  / 1

$ => reduce 42
ALPHABET => reduce 42
FUNCTION => reduce 42
MONADIC => reduce 42
NAME => reduce 42
REGEXP => reduce 42
SET => reduce 42

-----

State 24:

5 : Charset -> Number .  / 6

$ => reduce 5
LIDENT => reduce 5
NUMBER => reduce 5
ALPHABET => reduce 5
ANY => reduce 5
EMPT => reduce 5
FUNCTION => reduce 5
LPAREN => reduce 5
MONADIC => reduce 5
NAME => reduce 5
REGEXP => reduce 5
RPAREN => reduce 5
SET => reduce 5

-----

State 25:

7 : Charset -> EMPT .  / 6

$ => reduce 7
LIDENT => reduce 7
NUMBER => reduce 7
ALPHABET => reduce 7
ANY => reduce 7
EMPT => reduce 7
FUNCTION => reduce 7
LPAREN => reduce 7
MONADIC => reduce 7
NAME => reduce 7
REGEXP => reduce 7
RPAREN => reduce 7
SET => reduce 7

-----

State 26:

12 : Charset -> ANY .  / 6

$ => reduce 12
LIDENT => reduce 12
NUMBER => reduce 12
ALPHABET => reduce 12
ANY => reduce 12
EMPT => reduce 12
FUNCTION => reduce 12
LPAREN => reduce 12
MONADIC => reduce 12
NAME => reduce 12
REGEXP => reduce 12
RPAREN => reduce 12
SET => reduce 12

-----

State 27:

4 : Charset -> Ident .  / 6

$ => reduce 4
LIDENT => reduce 4
NUMBER => reduce 4
ALPHABET => reduce 4
ANY => reduce 4
EMPT => reduce 4
FUNCTION => reduce 4
LPAREN => reduce 4
MONADIC => reduce 4
NAME => reduce 4
REGEXP => reduce 4
RPAREN => reduce 4
SET => reduce 4

-----

State 28:

6 : Charset -> LPAREN . RANGE NumPairs RPAREN  / 6
8 : Charset -> LPAREN . OR Charsets RPAREN  / 6
9 : Charset -> LPAREN . AND Charsets RPAREN  / 6
10 : Charset -> LPAREN . MINUS Charset Charsets RPAREN  / 6
11 : Charset -> LPAREN . TILDE Charsets RPAREN  / 6

AND => shift 44
MINUS => shift 43
OR => shift 42
RANGE => shift 41
TILDE => shift 40

-----

State 29:

41 : Directive -> REGEXP Ident EQUAL Regexp .  / 1

$ => reduce 41
ALPHABET => reduce 41
FUNCTION => reduce 41
MONADIC => reduce 41
NAME => reduce 41
REGEXP => reduce 41
SET => reduce 41

-----

State 30:

16 : Regexp -> Number .  / 5

$ => reduce 16
LIDENT => reduce 16
NUMBER => reduce 16
STRING => reduce 16
ALPHABET => reduce 16
ANY => reduce 16
ARROW => reduce 16
EOS => reduce 16
EMPT => reduce 16
EPSILON => reduce 16
FUNCTION => reduce 16
LPAREN => reduce 16
MONADIC => reduce 16
NAME => reduce 16
REGEXP => reduce 16
RPAREN => reduce 16
SET => reduce 16

-----

State 31:

30 : Regexp -> EOS .  / 5

$ => reduce 30
LIDENT => reduce 30
NUMBER => reduce 30
STRING => reduce 30
ALPHABET => reduce 30
ANY => reduce 30
ARROW => reduce 30
EOS => reduce 30
EMPT => reduce 30
EPSILON => reduce 30
FUNCTION => reduce 30
LPAREN => reduce 30
MONADIC => reduce 30
NAME => reduce 30
REGEXP => reduce 30
RPAREN => reduce 30
SET => reduce 30

-----

State 32:

18 : Regexp -> ANY .  / 5

$ => reduce 18
LIDENT => reduce 18
NUMBER => reduce 18
STRING => reduce 18
ALPHABET => reduce 18
ANY => reduce 18
ARROW => reduce 18
EOS => reduce 18
EMPT => reduce 18
EPSILON => reduce 18
FUNCTION => reduce 18
LPAREN => reduce 18
MONADIC => reduce 18
NAME => reduce 18
REGEXP => reduce 18
RPAREN => reduce 18
SET => reduce 18

-----

State 33:

17 : Regexp -> STRING .  / 5

$ => reduce 17
LIDENT => reduce 17
NUMBER => reduce 17
STRING => reduce 17
ALPHABET => reduce 17
ANY => reduce 17
ARROW => reduce 17
EOS => reduce 17
EMPT => reduce 17
EPSILON => reduce 17
FUNCTION => reduce 17
LPAREN => reduce 17
MONADIC => reduce 17
NAME => reduce 17
REGEXP => reduce 17
RPAREN => reduce 17
SET => reduce 17

-----

State 34:

15 : Regexp -> Ident .  / 5

$ => reduce 15
LIDENT => reduce 15
NUMBER => reduce 15
STRING => reduce 15
ALPHABET => reduce 15
ANY => reduce 15
ARROW => reduce 15
EOS => reduce 15
EMPT => reduce 15
EPSILON => reduce 15
FUNCTION => reduce 15
LPAREN => reduce 15
MONADIC => reduce 15
NAME => reduce 15
REGEXP => reduce 15
RPAREN => reduce 15
SET => reduce 15

-----

State 35:

21 : Regexp -> LPAREN . COLON Regexps RPAREN  / 5
22 : Regexp -> LPAREN . SEQ Regexps RPAREN  / 5
23 : Regexp -> LPAREN . OR Regexps RPAREN  / 5
24 : Regexp -> LPAREN . QUESTION Regexp RPAREN  / 5
25 : Regexp -> LPAREN . STAR Regexp RPAREN  / 5
26 : Regexp -> LPAREN . PLUS Regexp RPAREN  / 5
27 : Regexp -> LPAREN . EQUAL Number Regexp RPAREN  / 5
28 : Regexp -> LPAREN . GEQ Number Regexp RPAREN  / 5
29 : Regexp -> LPAREN . REPEAT Number Number Regexp RPAREN  / 5

COLON => shift 48
EQUAL => shift 47
GEQ => shift 46
OR => shift 50
PLUS => shift 49
QUESTION => shift 51
REPEAT => shift 45
SEQ => shift 52
STAR => shift 53

-----

State 36:

20 : Regexp -> EMPT .  / 5

$ => reduce 20
LIDENT => reduce 20
NUMBER => reduce 20
STRING => reduce 20
ALPHABET => reduce 20
ANY => reduce 20
ARROW => reduce 20
EOS => reduce 20
EMPT => reduce 20
EPSILON => reduce 20
FUNCTION => reduce 20
LPAREN => reduce 20
MONADIC => reduce 20
NAME => reduce 20
REGEXP => reduce 20
RPAREN => reduce 20
SET => reduce 20

-----

State 37:

19 : Regexp -> EPSILON .  / 5

$ => reduce 19
LIDENT => reduce 19
NUMBER => reduce 19
STRING => reduce 19
ALPHABET => reduce 19
ANY => reduce 19
ARROW => reduce 19
EOS => reduce 19
EMPT => reduce 19
EPSILON => reduce 19
FUNCTION => reduce 19
LPAREN => reduce 19
MONADIC => reduce 19
NAME => reduce 19
REGEXP => reduce 19
RPAREN => reduce 19
SET => reduce 19

-----

State 38:

37 : QIdent -> UIDENT DOT QIdent .  / 1

$ => reduce 37
ALPHABET => reduce 37
FUNCTION => reduce 37
MONADIC => reduce 37
NAME => reduce 37
REGEXP => reduce 37
SET => reduce 37

-----

State 39:

0 : Ident -> . LIDENT  / 7
1 : Number -> . NUMBER  / 7
15 : Regexp -> . Ident  / 7
16 : Regexp -> . Number  / 7
17 : Regexp -> . STRING  / 7
18 : Regexp -> . ANY  / 7
19 : Regexp -> . EPSILON  / 7
20 : Regexp -> . EMPT  / 7
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 7
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 7
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 7
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 7
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 7
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 7
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 7
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 7
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 7
30 : Regexp -> . EOS  / 7
33 : Arm -> . Regexp ARROW Ident  / 8
34 : Arms -> . Arm  / 1
35 : Arms -> . Arm Arms  / 1
43 : Directive -> FUNCTION Ident COLON Ident EQUAL . Arms  / 1

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 56
Arm => goto 55
Arms => goto 54

-----

State 40:

0 : Ident -> . LIDENT  / 9
1 : Number -> . NUMBER  / 9
4 : Charset -> . Ident  / 9
5 : Charset -> . Number  / 9
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 9
7 : Charset -> . EMPT  / 9
8 : Charset -> . LPAREN OR Charsets RPAREN  / 9
9 : Charset -> . LPAREN AND Charsets RPAREN  / 9
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 9
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 9
11 : Charset -> LPAREN TILDE . Charsets RPAREN  / 6
12 : Charset -> . ANY  / 9
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

LIDENT => shift 11
NUMBER => shift 13
ANY => shift 26
EMPT => shift 25
LPAREN => shift 28
RPAREN => reduce 13
Ident => goto 27
Number => goto 24
Charset => goto 57
Charsets => goto 58

-----

State 41:

1 : Number -> . NUMBER  / 11
2 : NumPairs -> .  / 10
3 : NumPairs -> . Number Number NumPairs  / 10
6 : Charset -> LPAREN RANGE . NumPairs RPAREN  / 6

NUMBER => shift 13
RPAREN => reduce 2
Number => goto 60
NumPairs => goto 59

-----

State 42:

0 : Ident -> . LIDENT  / 9
1 : Number -> . NUMBER  / 9
4 : Charset -> . Ident  / 9
5 : Charset -> . Number  / 9
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 9
7 : Charset -> . EMPT  / 9
8 : Charset -> . LPAREN OR Charsets RPAREN  / 9
8 : Charset -> LPAREN OR . Charsets RPAREN  / 6
9 : Charset -> . LPAREN AND Charsets RPAREN  / 9
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 9
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 9
12 : Charset -> . ANY  / 9
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

LIDENT => shift 11
NUMBER => shift 13
ANY => shift 26
EMPT => shift 25
LPAREN => shift 28
RPAREN => reduce 13
Ident => goto 27
Number => goto 24
Charset => goto 57
Charsets => goto 61

-----

State 43:

0 : Ident -> . LIDENT  / 9
1 : Number -> . NUMBER  / 9
4 : Charset -> . Ident  / 9
5 : Charset -> . Number  / 9
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 9
7 : Charset -> . EMPT  / 9
8 : Charset -> . LPAREN OR Charsets RPAREN  / 9
9 : Charset -> . LPAREN AND Charsets RPAREN  / 9
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 9
10 : Charset -> LPAREN MINUS . Charset Charsets RPAREN  / 6
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 9
12 : Charset -> . ANY  / 9

LIDENT => shift 11
NUMBER => shift 13
ANY => shift 26
EMPT => shift 25
LPAREN => shift 28
Ident => goto 27
Number => goto 24
Charset => goto 62

-----

State 44:

0 : Ident -> . LIDENT  / 9
1 : Number -> . NUMBER  / 9
4 : Charset -> . Ident  / 9
5 : Charset -> . Number  / 9
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 9
7 : Charset -> . EMPT  / 9
8 : Charset -> . LPAREN OR Charsets RPAREN  / 9
9 : Charset -> . LPAREN AND Charsets RPAREN  / 9
9 : Charset -> LPAREN AND . Charsets RPAREN  / 6
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 9
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 9
12 : Charset -> . ANY  / 9
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

LIDENT => shift 11
NUMBER => shift 13
ANY => shift 26
EMPT => shift 25
LPAREN => shift 28
RPAREN => reduce 13
Ident => goto 27
Number => goto 24
Charset => goto 57
Charsets => goto 63

-----

State 45:

1 : Number -> . NUMBER  / 11
29 : Regexp -> LPAREN REPEAT . Number Number Regexp RPAREN  / 5

NUMBER => shift 13
Number => goto 64

-----

State 46:

1 : Number -> . NUMBER  / 12
28 : Regexp -> LPAREN GEQ . Number Regexp RPAREN  / 5

NUMBER => shift 13
Number => goto 65

-----

State 47:

1 : Number -> . NUMBER  / 12
27 : Regexp -> LPAREN EQUAL . Number Regexp RPAREN  / 5

NUMBER => shift 13
Number => goto 66

-----

State 48:

0 : Ident -> . LIDENT  / 13
1 : Number -> . NUMBER  / 13
15 : Regexp -> . Ident  / 13
16 : Regexp -> . Number  / 13
17 : Regexp -> . STRING  / 13
18 : Regexp -> . ANY  / 13
19 : Regexp -> . EPSILON  / 13
20 : Regexp -> . EMPT  / 13
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 13
21 : Regexp -> LPAREN COLON . Regexps RPAREN  / 5
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 13
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 13
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 13
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 13
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 13
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 13
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 13
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 13
30 : Regexp -> . EOS  / 13
31 : Regexps -> .  / 10
32 : Regexps -> . Regexp Regexps  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
RPAREN => reduce 31
Ident => goto 34
Number => goto 30
Regexp => goto 67
Regexps => goto 68

-----

State 49:

0 : Ident -> . LIDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
26 : Regexp -> LPAREN PLUS . Regexp RPAREN  / 5
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 10
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 10
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 10
30 : Regexp -> . EOS  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 69

-----

State 50:

0 : Ident -> . LIDENT  / 13
1 : Number -> . NUMBER  / 13
15 : Regexp -> . Ident  / 13
16 : Regexp -> . Number  / 13
17 : Regexp -> . STRING  / 13
18 : Regexp -> . ANY  / 13
19 : Regexp -> . EPSILON  / 13
20 : Regexp -> . EMPT  / 13
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 13
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 13
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 13
23 : Regexp -> LPAREN OR . Regexps RPAREN  / 5
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 13
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 13
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 13
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 13
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 13
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 13
30 : Regexp -> . EOS  / 13
31 : Regexps -> .  / 10
32 : Regexps -> . Regexp Regexps  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
RPAREN => reduce 31
Ident => goto 34
Number => goto 30
Regexp => goto 67
Regexps => goto 70

-----

State 51:

0 : Ident -> . LIDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
24 : Regexp -> LPAREN QUESTION . Regexp RPAREN  / 5
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 10
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 10
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 10
30 : Regexp -> . EOS  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 71

-----

State 52:

0 : Ident -> . LIDENT  / 13
1 : Number -> . NUMBER  / 13
15 : Regexp -> . Ident  / 13
16 : Regexp -> . Number  / 13
17 : Regexp -> . STRING  / 13
18 : Regexp -> . ANY  / 13
19 : Regexp -> . EPSILON  / 13
20 : Regexp -> . EMPT  / 13
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 13
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 13
22 : Regexp -> LPAREN SEQ . Regexps RPAREN  / 5
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 13
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 13
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 13
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 13
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 13
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 13
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 13
30 : Regexp -> . EOS  / 13
31 : Regexps -> .  / 10
32 : Regexps -> . Regexp Regexps  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
RPAREN => reduce 31
Ident => goto 34
Number => goto 30
Regexp => goto 67
Regexps => goto 72

-----

State 53:

0 : Ident -> . LIDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
25 : Regexp -> LPAREN STAR . Regexp RPAREN  / 5
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 10
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 10
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 10
30 : Regexp -> . EOS  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 73

-----

State 54:

43 : Directive -> FUNCTION Ident COLON Ident EQUAL Arms .  / 1

$ => reduce 43
ALPHABET => reduce 43
FUNCTION => reduce 43
MONADIC => reduce 43
NAME => reduce 43
REGEXP => reduce 43
SET => reduce 43

-----

State 55:

0 : Ident -> . LIDENT  / 7
1 : Number -> . NUMBER  / 7
15 : Regexp -> . Ident  / 7
16 : Regexp -> . Number  / 7
17 : Regexp -> . STRING  / 7
18 : Regexp -> . ANY  / 7
19 : Regexp -> . EPSILON  / 7
20 : Regexp -> . EMPT  / 7
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 7
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 7
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 7
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 7
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 7
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 7
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 7
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 7
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 7
30 : Regexp -> . EOS  / 7
33 : Arm -> . Regexp ARROW Ident  / 8
34 : Arms -> . Arm  / 1
34 : Arms -> Arm .  / 1
35 : Arms -> . Arm Arms  / 1
35 : Arms -> Arm . Arms  / 1

$ => reduce 34
LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ALPHABET => reduce 34
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
FUNCTION => reduce 34
LPAREN => shift 35
MONADIC => reduce 34
NAME => reduce 34
REGEXP => reduce 34
SET => reduce 34
Ident => goto 34
Number => goto 30
Regexp => goto 56
Arm => goto 55
Arms => goto 74

-----

State 56:

33 : Arm -> Regexp . ARROW Ident  / 8

ARROW => shift 75

-----

State 57:

0 : Ident -> . LIDENT  / 9
1 : Number -> . NUMBER  / 9
4 : Charset -> . Ident  / 9
5 : Charset -> . Number  / 9
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 9
7 : Charset -> . EMPT  / 9
8 : Charset -> . LPAREN OR Charsets RPAREN  / 9
9 : Charset -> . LPAREN AND Charsets RPAREN  / 9
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 9
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 9
12 : Charset -> . ANY  / 9
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10
14 : Charsets -> Charset . Charsets  / 10

LIDENT => shift 11
NUMBER => shift 13
ANY => shift 26
EMPT => shift 25
LPAREN => shift 28
RPAREN => reduce 13
Ident => goto 27
Number => goto 24
Charset => goto 57
Charsets => goto 76

-----

State 58:

11 : Charset -> LPAREN TILDE Charsets . RPAREN  / 6

RPAREN => shift 77

-----

State 59:

6 : Charset -> LPAREN RANGE NumPairs . RPAREN  / 6

RPAREN => shift 78

-----

State 60:

1 : Number -> . NUMBER  / 14
3 : NumPairs -> Number . Number NumPairs  / 10

NUMBER => shift 13
Number => goto 79

-----

State 61:

8 : Charset -> LPAREN OR Charsets . RPAREN  / 6

RPAREN => shift 80

-----

State 62:

0 : Ident -> . LIDENT  / 9
1 : Number -> . NUMBER  / 9
4 : Charset -> . Ident  / 9
5 : Charset -> . Number  / 9
6 : Charset -> . LPAREN RANGE NumPairs RPAREN  / 9
7 : Charset -> . EMPT  / 9
8 : Charset -> . LPAREN OR Charsets RPAREN  / 9
9 : Charset -> . LPAREN AND Charsets RPAREN  / 9
10 : Charset -> . LPAREN MINUS Charset Charsets RPAREN  / 9
10 : Charset -> LPAREN MINUS Charset . Charsets RPAREN  / 6
11 : Charset -> . LPAREN TILDE Charsets RPAREN  / 9
12 : Charset -> . ANY  / 9
13 : Charsets -> .  / 10
14 : Charsets -> . Charset Charsets  / 10

LIDENT => shift 11
NUMBER => shift 13
ANY => shift 26
EMPT => shift 25
LPAREN => shift 28
RPAREN => reduce 13
Ident => goto 27
Number => goto 24
Charset => goto 57
Charsets => goto 81

-----

State 63:

9 : Charset -> LPAREN AND Charsets . RPAREN  / 6

RPAREN => shift 82

-----

State 64:

1 : Number -> . NUMBER  / 12
29 : Regexp -> LPAREN REPEAT Number . Number Regexp RPAREN  / 5

NUMBER => shift 13
Number => goto 83

-----

State 65:

0 : Ident -> . LIDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 10
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 10
28 : Regexp -> LPAREN GEQ Number . Regexp RPAREN  / 5
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 10
30 : Regexp -> . EOS  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 84

-----

State 66:

0 : Ident -> . LIDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 10
27 : Regexp -> LPAREN EQUAL Number . Regexp RPAREN  / 5
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 10
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 10
30 : Regexp -> . EOS  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 85

-----

State 67:

0 : Ident -> . LIDENT  / 13
1 : Number -> . NUMBER  / 13
15 : Regexp -> . Ident  / 13
16 : Regexp -> . Number  / 13
17 : Regexp -> . STRING  / 13
18 : Regexp -> . ANY  / 13
19 : Regexp -> . EPSILON  / 13
20 : Regexp -> . EMPT  / 13
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 13
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 13
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 13
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 13
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 13
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 13
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 13
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 13
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 13
30 : Regexp -> . EOS  / 13
31 : Regexps -> .  / 10
32 : Regexps -> . Regexp Regexps  / 10
32 : Regexps -> Regexp . Regexps  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
RPAREN => reduce 31
Ident => goto 34
Number => goto 30
Regexp => goto 67
Regexps => goto 86

-----

State 68:

21 : Regexp -> LPAREN COLON Regexps . RPAREN  / 5

RPAREN => shift 87

-----

State 69:

26 : Regexp -> LPAREN PLUS Regexp . RPAREN  / 5

RPAREN => shift 88

-----

State 70:

23 : Regexp -> LPAREN OR Regexps . RPAREN  / 5

RPAREN => shift 89

-----

State 71:

24 : Regexp -> LPAREN QUESTION Regexp . RPAREN  / 5

RPAREN => shift 90

-----

State 72:

22 : Regexp -> LPAREN SEQ Regexps . RPAREN  / 5

RPAREN => shift 91

-----

State 73:

25 : Regexp -> LPAREN STAR Regexp . RPAREN  / 5

RPAREN => shift 92

-----

State 74:

35 : Arms -> Arm Arms .  / 1

$ => reduce 35
ALPHABET => reduce 35
FUNCTION => reduce 35
MONADIC => reduce 35
NAME => reduce 35
REGEXP => reduce 35
SET => reduce 35

-----

State 75:

0 : Ident -> . LIDENT  / 8
33 : Arm -> Regexp ARROW . Ident  / 8

LIDENT => shift 11
Ident => goto 93

-----

State 76:

14 : Charsets -> Charset Charsets .  / 10

RPAREN => reduce 14

-----

State 77:

11 : Charset -> LPAREN TILDE Charsets RPAREN .  / 6

$ => reduce 11
LIDENT => reduce 11
NUMBER => reduce 11
ALPHABET => reduce 11
ANY => reduce 11
EMPT => reduce 11
FUNCTION => reduce 11
LPAREN => reduce 11
MONADIC => reduce 11
NAME => reduce 11
REGEXP => reduce 11
RPAREN => reduce 11
SET => reduce 11

-----

State 78:

6 : Charset -> LPAREN RANGE NumPairs RPAREN .  / 6

$ => reduce 6
LIDENT => reduce 6
NUMBER => reduce 6
ALPHABET => reduce 6
ANY => reduce 6
EMPT => reduce 6
FUNCTION => reduce 6
LPAREN => reduce 6
MONADIC => reduce 6
NAME => reduce 6
REGEXP => reduce 6
RPAREN => reduce 6
SET => reduce 6

-----

State 79:

1 : Number -> . NUMBER  / 11
2 : NumPairs -> .  / 10
3 : NumPairs -> . Number Number NumPairs  / 10
3 : NumPairs -> Number Number . NumPairs  / 10

NUMBER => shift 13
RPAREN => reduce 2
Number => goto 60
NumPairs => goto 94

-----

State 80:

8 : Charset -> LPAREN OR Charsets RPAREN .  / 6

$ => reduce 8
LIDENT => reduce 8
NUMBER => reduce 8
ALPHABET => reduce 8
ANY => reduce 8
EMPT => reduce 8
FUNCTION => reduce 8
LPAREN => reduce 8
MONADIC => reduce 8
NAME => reduce 8
REGEXP => reduce 8
RPAREN => reduce 8
SET => reduce 8

-----

State 81:

10 : Charset -> LPAREN MINUS Charset Charsets . RPAREN  / 6

RPAREN => shift 95

-----

State 82:

9 : Charset -> LPAREN AND Charsets RPAREN .  / 6

$ => reduce 9
LIDENT => reduce 9
NUMBER => reduce 9
ALPHABET => reduce 9
ANY => reduce 9
EMPT => reduce 9
FUNCTION => reduce 9
LPAREN => reduce 9
MONADIC => reduce 9
NAME => reduce 9
REGEXP => reduce 9
RPAREN => reduce 9
SET => reduce 9

-----

State 83:

0 : Ident -> . LIDENT  / 10
1 : Number -> . NUMBER  / 10
15 : Regexp -> . Ident  / 10
16 : Regexp -> . Number  / 10
17 : Regexp -> . STRING  / 10
18 : Regexp -> . ANY  / 10
19 : Regexp -> . EPSILON  / 10
20 : Regexp -> . EMPT  / 10
21 : Regexp -> . LPAREN COLON Regexps RPAREN  / 10
22 : Regexp -> . LPAREN SEQ Regexps RPAREN  / 10
23 : Regexp -> . LPAREN OR Regexps RPAREN  / 10
24 : Regexp -> . LPAREN QUESTION Regexp RPAREN  / 10
25 : Regexp -> . LPAREN STAR Regexp RPAREN  / 10
26 : Regexp -> . LPAREN PLUS Regexp RPAREN  / 10
27 : Regexp -> . LPAREN EQUAL Number Regexp RPAREN  / 10
28 : Regexp -> . LPAREN GEQ Number Regexp RPAREN  / 10
29 : Regexp -> . LPAREN REPEAT Number Number Regexp RPAREN  / 10
29 : Regexp -> LPAREN REPEAT Number Number . Regexp RPAREN  / 5
30 : Regexp -> . EOS  / 10

LIDENT => shift 11
NUMBER => shift 13
STRING => shift 33
ANY => shift 32
EOS => shift 31
EMPT => shift 36
EPSILON => shift 37
LPAREN => shift 35
Ident => goto 34
Number => goto 30
Regexp => goto 96

-----

State 84:

28 : Regexp -> LPAREN GEQ Number Regexp . RPAREN  / 5

RPAREN => shift 97

-----

State 85:

27 : Regexp -> LPAREN EQUAL Number Regexp . RPAREN  / 5

RPAREN => shift 98

-----

State 86:

32 : Regexps -> Regexp Regexps .  / 10

RPAREN => reduce 32

-----

State 87:

21 : Regexp -> LPAREN COLON Regexps RPAREN .  / 5

$ => reduce 21
LIDENT => reduce 21
NUMBER => reduce 21
STRING => reduce 21
ALPHABET => reduce 21
ANY => reduce 21
ARROW => reduce 21
EOS => reduce 21
EMPT => reduce 21
EPSILON => reduce 21
FUNCTION => reduce 21
LPAREN => reduce 21
MONADIC => reduce 21
NAME => reduce 21
REGEXP => reduce 21
RPAREN => reduce 21
SET => reduce 21

-----

State 88:

26 : Regexp -> LPAREN PLUS Regexp RPAREN .  / 5

$ => reduce 26
LIDENT => reduce 26
NUMBER => reduce 26
STRING => reduce 26
ALPHABET => reduce 26
ANY => reduce 26
ARROW => reduce 26
EOS => reduce 26
EMPT => reduce 26
EPSILON => reduce 26
FUNCTION => reduce 26
LPAREN => reduce 26
MONADIC => reduce 26
NAME => reduce 26
REGEXP => reduce 26
RPAREN => reduce 26
SET => reduce 26

-----

State 89:

23 : Regexp -> LPAREN OR Regexps RPAREN .  / 5

$ => reduce 23
LIDENT => reduce 23
NUMBER => reduce 23
STRING => reduce 23
ALPHABET => reduce 23
ANY => reduce 23
ARROW => reduce 23
EOS => reduce 23
EMPT => reduce 23
EPSILON => reduce 23
FUNCTION => reduce 23
LPAREN => reduce 23
MONADIC => reduce 23
NAME => reduce 23
REGEXP => reduce 23
RPAREN => reduce 23
SET => reduce 23

-----

State 90:

24 : Regexp -> LPAREN QUESTION Regexp RPAREN .  / 5

$ => reduce 24
LIDENT => reduce 24
NUMBER => reduce 24
STRING => reduce 24
ALPHABET => reduce 24
ANY => reduce 24
ARROW => reduce 24
EOS => reduce 24
EMPT => reduce 24
EPSILON => reduce 24
FUNCTION => reduce 24
LPAREN => reduce 24
MONADIC => reduce 24
NAME => reduce 24
REGEXP => reduce 24
RPAREN => reduce 24
SET => reduce 24

-----

State 91:

22 : Regexp -> LPAREN SEQ Regexps RPAREN .  / 5

$ => reduce 22
LIDENT => reduce 22
NUMBER => reduce 22
STRING => reduce 22
ALPHABET => reduce 22
ANY => reduce 22
ARROW => reduce 22
EOS => reduce 22
EMPT => reduce 22
EPSILON => reduce 22
FUNCTION => reduce 22
LPAREN => reduce 22
MONADIC => reduce 22
NAME => reduce 22
REGEXP => reduce 22
RPAREN => reduce 22
SET => reduce 22

-----

State 92:

25 : Regexp -> LPAREN STAR Regexp RPAREN .  / 5

$ => reduce 25
LIDENT => reduce 25
NUMBER => reduce 25
STRING => reduce 25
ALPHABET => reduce 25
ANY => reduce 25
ARROW => reduce 25
EOS => reduce 25
EMPT => reduce 25
EPSILON => reduce 25
FUNCTION => reduce 25
LPAREN => reduce 25
MONADIC => reduce 25
NAME => reduce 25
REGEXP => reduce 25
RPAREN => reduce 25
SET => reduce 25

-----

State 93:

33 : Arm -> Regexp ARROW Ident .  / 8

$ => reduce 33
LIDENT => reduce 33
NUMBER => reduce 33
STRING => reduce 33
ALPHABET => reduce 33
ANY => reduce 33
EOS => reduce 33
EMPT => reduce 33
EPSILON => reduce 33
FUNCTION => reduce 33
LPAREN => reduce 33
MONADIC => reduce 33
NAME => reduce 33
REGEXP => reduce 33
SET => reduce 33

-----

State 94:

3 : NumPairs -> Number Number NumPairs .  / 10

RPAREN => reduce 3

-----

State 95:

10 : Charset -> LPAREN MINUS Charset Charsets RPAREN .  / 6

$ => reduce 10
LIDENT => reduce 10
NUMBER => reduce 10
ALPHABET => reduce 10
ANY => reduce 10
EMPT => reduce 10
FUNCTION => reduce 10
LPAREN => reduce 10
MONADIC => reduce 10
NAME => reduce 10
REGEXP => reduce 10
RPAREN => reduce 10
SET => reduce 10

-----

State 96:

29 : Regexp -> LPAREN REPEAT Number Number Regexp . RPAREN  / 5

RPAREN => shift 99

-----

State 97:

28 : Regexp -> LPAREN GEQ Number Regexp RPAREN .  / 5

$ => reduce 28
LIDENT => reduce 28
NUMBER => reduce 28
STRING => reduce 28
ALPHABET => reduce 28
ANY => reduce 28
ARROW => reduce 28
EOS => reduce 28
EMPT => reduce 28
EPSILON => reduce 28
FUNCTION => reduce 28
LPAREN => reduce 28
MONADIC => reduce 28
NAME => reduce 28
REGEXP => reduce 28
RPAREN => reduce 28
SET => reduce 28

-----

State 98:

27 : Regexp -> LPAREN EQUAL Number Regexp RPAREN .  / 5

$ => reduce 27
LIDENT => reduce 27
NUMBER => reduce 27
STRING => reduce 27
ALPHABET => reduce 27
ANY => reduce 27
ARROW => reduce 27
EOS => reduce 27
EMPT => reduce 27
EPSILON => reduce 27
FUNCTION => reduce 27
LPAREN => reduce 27
MONADIC => reduce 27
NAME => reduce 27
REGEXP => reduce 27
RPAREN => reduce 27
SET => reduce 27

-----

State 99:

29 : Regexp -> LPAREN REPEAT Number Number Regexp RPAREN .  / 5

$ => reduce 29
LIDENT => reduce 29
NUMBER => reduce 29
STRING => reduce 29
ALPHABET => reduce 29
ANY => reduce 29
ARROW => reduce 29
EOS => reduce 29
EMPT => reduce 29
EPSILON => reduce 29
FUNCTION => reduce 29
LPAREN => reduce 29
MONADIC => reduce 29
NAME => reduce 29
REGEXP => reduce 29
RPAREN => reduce 29
SET => reduce 29

-----

lookahead 0 = $ 
lookahead 1 = $ ALPHABET FUNCTION MONADIC NAME REGEXP SET 
lookahead 2 = COLON 
lookahead 3 = EQUAL 
lookahead 4 = $ LIDENT NUMBER STRING ALPHABET ANY ARROW COLON EOS EMPT EPSILON EQUAL FUNCTION LPAREN MONADIC NAME REGEXP RPAREN SET 
lookahead 5 = $ LIDENT NUMBER STRING ALPHABET ANY ARROW EOS EMPT EPSILON FUNCTION LPAREN MONADIC NAME REGEXP RPAREN SET 
lookahead 6 = $ LIDENT NUMBER ALPHABET ANY EMPT FUNCTION LPAREN MONADIC NAME REGEXP RPAREN SET 
lookahead 7 = ARROW 
lookahead 8 = $ LIDENT NUMBER STRING ALPHABET ANY EOS EMPT EPSILON FUNCTION LPAREN MONADIC NAME REGEXP SET 
lookahead 9 = LIDENT NUMBER ANY EMPT LPAREN RPAREN 
lookahead 10 = RPAREN 
lookahead 11 = NUMBER 
lookahead 12 = LIDENT NUMBER STRING ANY EOS EMPT EPSILON LPAREN 
lookahead 13 = LIDENT NUMBER STRING ANY EOS EMPT EPSILON LPAREN RPAREN 
lookahead 14 = NUMBER RPAREN 

*)

struct
local
structure Value = struct
datatype nonterminal =
nonterminal
| string of Arg.string
| int of Arg.int
| intlist of Arg.intlist
| numpairs of Arg.numpairs
| charset of Arg.charset
| charsets of Arg.charsets
| regexp of Arg.regexp
| regexps of Arg.regexps
| arm of Arg.arm
| arms of Arg.arms
| qident of Arg.qident
| directive of Arg.directive
| directives of Arg.directives
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = Arg.terminal
type value = Value.nonterminal
val dummy = Value.nonterminal
fun read terminal =
(case terminal of
Arg.LIDENT x => (1, Value.string x)
| Arg.UIDENT x => (2, Value.string x)
| Arg.NUMBER x => (3, Value.int x)
| Arg.STRING x => (4, Value.intlist x)
| Arg.ALPHABET => (5, Value.nonterminal)
| Arg.AND => (6, Value.nonterminal)
| Arg.ANY => (7, Value.nonterminal)
| Arg.ARROW => (8, Value.nonterminal)
| Arg.COLON => (9, Value.nonterminal)
| Arg.DOT => (10, Value.nonterminal)
| Arg.EOS => (11, Value.nonterminal)
| Arg.EMPT => (12, Value.nonterminal)
| Arg.EPSILON => (13, Value.nonterminal)
| Arg.EQUAL => (14, Value.nonterminal)
| Arg.FUNCTION => (15, Value.nonterminal)
| Arg.GEQ => (16, Value.nonterminal)
| Arg.LPAREN => (17, Value.nonterminal)
| Arg.MINUS => (18, Value.nonterminal)
| Arg.MONADIC => (19, Value.nonterminal)
| Arg.NAME => (20, Value.nonterminal)
| Arg.OR => (21, Value.nonterminal)
| Arg.PLUS => (22, Value.nonterminal)
| Arg.QUESTION => (23, Value.nonterminal)
| Arg.RANGE => (24, Value.nonterminal)
| Arg.REGEXP => (25, Value.nonterminal)
| Arg.REPEAT => (26, Value.nonterminal)
| Arg.RPAREN => (27, Value.nonterminal)
| Arg.SEQ => (28, Value.nonterminal)
| Arg.SET => (29, Value.nonterminal)
| Arg.STAR => (30, Value.nonterminal)
| Arg.TILDE => (31, Value.nonterminal)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "R\128\128\128\128\133\128\128\128\128\128\128\128\128\128\132\128\128\128\131\136\128\128\128\128\135\128\128\128\134\128\128R\128\128\128\128\133\128\128\128\128\128\128\128\128\128\132\128\128\128\131\136\128\128\128\128\135\128\128\128\134\128\128W\128\128\128\128W\128\128\128\128\128\128\128\128\128W\128\128\128WW\128\128\128\128W\128\128\128W\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\127\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128Q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\147\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~\128~~~\128~~~\128~~~~~\128~\128~~\128\128\128\128~\128~\128~\128\128V\128\128\128\128V\128\128\128\128\128\128\128\128\128V\128\128\128VV\128\128\128\128V\128\128\128V\128\128}}\128}}}\128}}\128\128}}}\128}\128}\128}}\128\128\128\128}\128}\128}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\149\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128X\128\128\128\128X\128\128\128\128\128\128\128\128\128X\128\128\128XX\128\128\128\128X\128\128\128X\128\128Z\128\128\128\128Z\128\128\128\128\150\128\128\128\128Z\128\128\128ZZ\128\128\128\128Z\128\128\128Z\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\128\128\128\155\128\128\128\128\154\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\146\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\168\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128T\128\128\128\128T\128\128\128\128\128\128\128\128\128T\128\128\128TT\128\128\128\128T\128\128\128T\128\128yy\128y\128y\128y\128\128\128\128y\128\128y\128y\128yy\128\128\128\128y\128y\128y\128\128ww\128w\128w\128w\128\128\128\128w\128\128w\128w\128ww\128\128\128\128w\128w\128w\128\128rr\128r\128r\128r\128\128\128\128r\128\128r\128r\128rr\128\128\128\128r\128r\128r\128\128zz\128z\128z\128z\128\128\128\128z\128\128z\128z\128zz\128\128\128\128z\128z\128z\128\128\128\128\128\128\128\128\173\128\128\128\128\128\128\128\128\128\128\128\172\128\128\171\128\128\170\128\128\128\128\128\128\169U\128\128\128\128U\128\128\128\128\128\128\128\128\128U\128\128\128UU\128\128\128\128U\128\128\128U\128\128nn\128nnn\128nn\128\128nnn\128n\128n\128nn\128\128\128\128n\128n\128n\128\128``\128```\128``\128\128```\128`\128`\128``\128\128\128\128`\128`\128`\128\128ll\128lll\128ll\128\128lll\128l\128l\128ll\128\128\128\128l\128l\128l\128\128mm\128mmm\128mm\128\128mmm\128m\128m\128mm\128\128\128\128m\128m\128m\128\128oo\128ooo\128oo\128\128ooo\128o\128o\128oo\128\128\128\128o\128o\128o\128\128\128\128\128\128\128\128\128\128\128\177\128\128\128\128\176\128\175\128\128\128\128\179\178\180\128\128\174\128\181\128\182\128jj\128jjj\128jj\128\128jjj\128j\128j\128jj\128\128\128\128j\128j\128j\128\128kk\128kkk\128kk\128\128kkk\128k\128k\128kk\128\128\128\128k\128k\128k\128\128Y\128\128\128\128Y\128\128\128\128\128\128\128\128\128Y\128\128\128YY\128\128\128\128Y\128\128\128Y\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\128\128\128\155\128\128\128\128\154\128\128\128\128\157\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128|\128\128\128\128\128\140\128\142\128\128\128\155\128\128\128\128\154\128\128\128\128\157\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\140\128\142\128\128\128\155\128\128\128\128\154\128\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\128\128\128\155\128\128\128\128\154\128\128\128\128\157\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128_\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128_\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128_\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128S\128\128\128\128S\128\128\128\128\128\128\128\128\128S\128\128\128SS\128\128\128\128S\128\128\128S\128\128\\\140\128\142\162\\\128\161\128\128\128\160\165\166\128\\\128\164\128\\\\\128\128\128\128\\\128\128\128\\\128\128\128\128\128\128\128\128\128\128\204\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\128\128\128\155\128\128\128\128\154\128\128\128\128\157\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\206\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\207\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\209\128\128\128\128\128\140\128\142\128\128\128\155\128\128\128\128\154\128\128\128\128\157\128\128\128\128\128\128\128\128\128q\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\211\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128_\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\216\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\217\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\218\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\219\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\220\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\221\128\128\128\128[\128\128\128\128[\128\128\128\128\128\128\128\128\128[\128\128\128[[\128\128\128\128[\128\128\128[\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128p\128\128\128\128ss\128s\128s\128s\128\128\128\128s\128\128s\128s\128ss\128\128\128\128s\128s\128s\128\128xx\128x\128x\128x\128\128\128\128x\128\128x\128x\128xx\128\128\128\128x\128x\128x\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128|\128\128\128\128vv\128v\128v\128v\128\128\128\128v\128\128v\128v\128vv\128\128\128\128v\128v\128v\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\224\128\128\128\128uu\128u\128u\128u\128\128\128\128u\128\128u\128u\128uu\128\128\128\128u\128u\128u\128\128\128\140\128\142\162\128\128\161\128\128\128\160\165\166\128\128\128\164\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\226\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\227\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128^\128\128\128\128ii\128iii\128ii\128\128iii\128i\128i\128ii\128\128\128\128i\128i\128i\128\128dd\128ddd\128dd\128\128ddd\128d\128d\128dd\128\128\128\128d\128d\128d\128\128gg\128ggg\128gg\128\128ggg\128g\128g\128gg\128\128\128\128g\128g\128g\128\128ff\128fff\128ff\128\128fff\128f\128f\128ff\128\128\128\128f\128f\128f\128\128hh\128hhh\128hh\128\128hhh\128h\128h\128hh\128\128\128\128h\128h\128h\128\128ee\128eee\128ee\128\128eee\128e\128e\128ee\128\128\128\128e\128e\128e\128\128]]\128]]]\128]\128\128\128]]]\128]\128]\128]]\128\128\128\128]\128\128\128]\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{\128\128\128\128tt\128t\128t\128t\128\128\128\128t\128\128t\128t\128tt\128\128\128\128t\128t\128t\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\228\128\128\128\128bb\128bbb\128bb\128\128bbb\128b\128b\128bb\128\128\128\128b\128b\128b\128\128cc\128ccc\128cc\128\128ccc\128c\128c\128cc\128\128\128\128c\128c\128c\128\128aa\128aaa\128aa\128\128aaa\128a\128a\128aa\128\128\128\128a\128a\128a\128\128",
ParseEngine.next5x1 "\128\128\128\128\128\128\128\128\128\128\129\136\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\129\137\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\138\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\143\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\152\128\151\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\157\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\184\128\183\182\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\152\128\185\186\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\188\187\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\152\128\185\189\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\152\128\190\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\152\128\185\191\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\192\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\193\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\194\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\195\196\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\197\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\195\198\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\199\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\195\200\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\201\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\184\128\183\202\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\152\128\185\204\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\207\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\155\152\128\185\209\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\211\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\212\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\213\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\195\214\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\221\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\188\222\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\162\158\128\128\128\224\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn Value.string(arg0)::rest => Value.string(Arg.ident arg0)::rest|_=>raise (Fail "bad parser"))),
(1,1,(fn Value.int(arg0)::rest => Value.int(Arg.number arg0)::rest|_=>raise (Fail "bad parser"))),
(2,0,(fn rest => Value.numpairs(Arg.nil_numpairs {})::rest)),
(2,3,(fn Value.numpairs(arg0)::Value.int(arg1)::Value.int(arg2)::rest => Value.numpairs(Arg.cons_numpairs {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn Value.string(arg0)::rest => Value.charset(Arg.ident_charset arg0)::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn Value.int(arg0)::rest => Value.charset(Arg.number_charset arg0)::rest|_=>raise (Fail "bad parser"))),
(3,4,(fn _::Value.numpairs(arg0)::_::_::rest => Value.charset(Arg.range_charset arg0)::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn _::rest => Value.charset(Arg.empty_charset {})::rest|_=>raise (Fail "bad parser"))),
(3,4,(fn _::Value.charsets(arg0)::_::_::rest => Value.charset(Arg.union_charset arg0)::rest|_=>raise (Fail "bad parser"))),
(3,4,(fn _::Value.charsets(arg0)::_::_::rest => Value.charset(Arg.intersect_charset arg0)::rest|_=>raise (Fail "bad parser"))),
(3,5,(fn _::Value.charsets(arg0)::Value.charset(arg1)::_::_::rest => Value.charset(Arg.diff_charset {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(3,4,(fn _::Value.charsets(arg0)::_::_::rest => Value.charset(Arg.comp_charset arg0)::rest|_=>raise (Fail "bad parser"))),
(3,1,(fn _::rest => Value.charset(Arg.any_charset {})::rest|_=>raise (Fail "bad parser"))),
(4,0,(fn rest => Value.charsets(Arg.nil_charsets {})::rest)),
(4,2,(fn Value.charsets(arg0)::Value.charset(arg1)::rest => Value.charsets(Arg.cons_charsets {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn Value.string(arg0)::rest => Value.regexp(Arg.ident_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn Value.int(arg0)::rest => Value.regexp(Arg.number_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn Value.intlist(arg0)::rest => Value.regexp(Arg.string_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn _::rest => Value.regexp(Arg.any_regexp {})::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn _::rest => Value.regexp(Arg.epsilon_regexp {})::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn _::rest => Value.regexp(Arg.empty_regexp {})::rest|_=>raise (Fail "bad parser"))),
(5,4,(fn _::Value.regexps(arg0)::_::_::rest => Value.regexp(Arg.concat_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,4,(fn _::Value.regexps(arg0)::_::_::rest => Value.regexp(Arg.seq_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,4,(fn _::Value.regexps(arg0)::_::_::rest => Value.regexp(Arg.union_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,4,(fn _::Value.regexp(arg0)::_::_::rest => Value.regexp(Arg.option_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,4,(fn _::Value.regexp(arg0)::_::_::rest => Value.regexp(Arg.closure_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,4,(fn _::Value.regexp(arg0)::_::_::rest => Value.regexp(Arg.plus_regexp arg0)::rest|_=>raise (Fail "bad parser"))),
(5,5,(fn _::Value.regexp(arg0)::Value.int(arg1)::_::_::rest => Value.regexp(Arg.equal_regexp {1=arg0,2=arg1})::rest|_=>raise (Fail "bad parser"))),
(5,5,(fn _::Value.regexp(arg0)::Value.int(arg1)::_::_::rest => Value.regexp(Arg.geq_regexp {1=arg0,2=arg1})::rest|_=>raise (Fail "bad parser"))),
(5,6,(fn _::Value.regexp(arg0)::Value.int(arg1)::Value.int(arg2)::_::_::rest => Value.regexp(Arg.repeat_regexp {1=arg0,3=arg1,2=arg2})::rest|_=>raise (Fail "bad parser"))),
(5,1,(fn _::rest => Value.regexp(Arg.eos_regexp {})::rest|_=>raise (Fail "bad parser"))),
(6,0,(fn rest => Value.regexps(Arg.nil_regexps {})::rest)),
(6,2,(fn Value.regexps(arg0)::Value.regexp(arg1)::rest => Value.regexps(Arg.cons_regexps {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(7,3,(fn Value.string(arg0)::_::Value.regexp(arg1)::rest => Value.arm(Arg.sole_arm {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(8,1,(fn Value.arm(arg0)::rest => Value.arms(Arg.sing_arms arg0)::rest|_=>raise (Fail "bad parser"))),
(8,2,(fn Value.arms(arg0)::Value.arm(arg1)::rest => Value.arms(Arg.cons_arms {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(9,1,(fn Value.string(arg0)::rest => Value.qident(Arg.sing_qident arg0)::rest|_=>raise (Fail "bad parser"))),
(9,3,(fn Value.qident(arg0)::_::Value.string(arg1)::rest => Value.qident(Arg.cons_qident {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(10,2,(fn Value.qident(arg0)::_::rest => Value.directive(Arg.name_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(10,1,(fn _::rest => Value.directive(Arg.monadic_directive {})::rest|_=>raise (Fail "bad parser"))),
(10,2,(fn Value.int(arg0)::_::rest => Value.directive(Arg.alphabet_directive arg0)::rest|_=>raise (Fail "bad parser"))),
(10,4,(fn Value.regexp(arg0)::_::Value.string(arg1)::_::rest => Value.directive(Arg.regexp_directive {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(10,4,(fn Value.charset(arg0)::_::Value.string(arg1)::_::rest => Value.directive(Arg.set_directive {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(10,6,(fn Value.arms(arg0)::_::Value.string(arg1)::_::Value.string(arg2)::_::rest => Value.directive(Arg.function_directive {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(11,0,(fn rest => Value.directives(Arg.nil_directives {})::rest)),
(11,2,(fn Value.directives(arg0)::Value.directive(arg1)::rest => Value.directives(Arg.cons_directives {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser")))],
(fn Value.directives x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
