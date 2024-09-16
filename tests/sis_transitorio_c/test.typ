#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)


#show: doc => cyrcuits(
  scale: 1,
  doc,
)

#align(center + horizon, 
  ```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[battery1=$E$] ++ (0,4)
    to[nos=$E$] ++ (2,0)
    to[R=$R$] ++ (2,0)
    to[C,l_=$C$,v^=$v_C$,f>_=$i_C$] ++ (0,-4)
    to[short] ++ (-4,0);
\end{circuitikz}
  ```
)
