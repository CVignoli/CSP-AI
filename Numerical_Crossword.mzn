include "Numerical_Crossword_Data3.dzn";

int: rows;
int: columns;
int: r;
int: s;
int: max_length_seg;
int: sol_card;
array [1..sol_card] of var int: solutions_vector; %solutions given in input
array [1..(rows* columns)] of var r..s union {0, r} : board;
array [1..sol_card, 1..max_length_seg] of var int: segments; 

constraint forall(i in 1..sol_card, j in 1..max_length_seg)(if segments[i,j]!=0 then board[segments[i, j]] <= solutions_vector[i] /\ board[segments[i, j]]>=1 endif);

constraint forall( [board[segments[i,j]]==solutions_vector[i] \/ board[segments[i,j+1]]==solutions_vector[i] | i in 1..sol_card, j in 1..max_length_seg-1 where segments[i,j]!=0 /\ segments[i,j+1]!=0]);

solve satisfy;

output [show(board[i]) ++ if i mod columns == 0 then "\n" else " " endif | i in 1..rows* columns] ++ ["\n"] ++ [show(solutions_vector)]