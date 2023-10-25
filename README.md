# CD Lab Assignment 5

#### Kaushik Dey(20CS01043)

## Q1:
For the following grammar with non-terminals {S, B, A}, start symbol S, terminal symbols { n, +, ×}:

```
S -> n B
B -> n B A B | ε
A -> + | ×
```


We have to design a top-down predictive parser by calculating first and follow sets.

### How to use it?
Inside the zip file, there are two folders, each for one of the two questions.

Inside each folder, there are the following files:
- `parser.cpp`
- `input.txt`
- `parsing_table.txt`
- `grammerLL.txt`
- `First-Follow.txt`

You can change the input string in `input.txt`. If you want to change the grammar, you need to modify `grammarLL.txt` and `First-Follow.txt` files accordingly.

To use the program:
1. Compile the `Parser.cpp` program using `g++ Parser.cpp`.
2. Run the program using `./a.out`.

It will provide the output based on the input string and the input grammar.

Sample Input:

```
nn*
```

## Q2:


For the following grammar, the non-terminals are

```
N = { AE, BE, D, DL, E, F, ES, IOS, IS, NE, P, PE, RE, S, SL, T, TY, VL, WS }
```



The terminals are

```
T = { + , −, , /, =, <, >, (, ), {, }, :=, ; , and, else, end, ic, id, if, int, do, fc, ∗ float, not, or, print, prog, scan, str, then, while }
```

The production rules are:

```
P → prog DL SL end
DL → D DL | ε
D → TY VL ;
TY → int | float
VL → id VL | id
SL → S SL | ε
S → ES | IS | WS | IOS
ES → id := E ;
IS → if BE then SL end | if BE then SL else SL end
WS → while BE do SL end
IOS → print PE | scan id
PE → E | str
BE → BE or AE | AE
AE → AE and NE | NE
NE → not NE | { BE } | RE
RE → E = E | E < E | E > E
E → E+T | E−T | T
T → T F | T/F | F ∗
F → ( E ) | id | ic | fc
```

File structure is the same as Grammar 1. Give the input in `input.txt` inside `Q2_A5` folder.

Sample Input:

```
prog
int i;
int j;
int sum;
int count;
sum:=0;
count:=5;
scan count
print sum
if count=3
then sum:=2;else
if count < 4
then sum:=2.3;
end
while count>2.3
do sum:=sum-1;
end
end
while sum > 0
do
count:=count+1;
i := 1.2345;
if count=3
then sum:=2;
end
end
end
```