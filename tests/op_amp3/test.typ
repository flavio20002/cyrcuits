#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

 ```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      to[short, o-] ++(0.5,0)
      node[op amp, anchor=-](oa){};
      \draw (oa.in2) 
      to [short,-o] ++ (-0.5,0);
      \draw (oa.out)
      to [short,-o] ++ (0.5,0)
      node[above]{$v_o$}
      to[open,l=$v_o$, invert] ++ (0,-2)
      to [short,o-] ++ (0,-0.5)
      node[ground]{};
      \draw (0,0)
      to[open,l_=$v_i$] ++ (0,-1);
    \end{circuitikz}
  ```
