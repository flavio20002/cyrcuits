#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

 ```circuitkz
    \begin{circuitikz}
      \draw(0,0)
      node[above]{$v_i$} 
      to[short, o-] ++(1,0)
      node[op amp, anchor=+](oa){};
      \draw (oa.out)
      to [short] ++(0.5,0) coordinate(aux1);
      \draw (oa.out)
      to[short, *-] ++(0,1.5)
      to[short] ++(-2.6,0)
      to[short, -] ++(0,-1)
      \draw (aux1)
      to[R, l=$R_1$,] ++(2,0)
      node[op amp, anchor=-](oa2){};
      \draw (oa2.out)
      to [short,-o] ++(1,0)
      node[above]{$v_o$};
      \draw (oa2.out)
      to[short, *-] ++(0,1.5)
      to[R, l=$R_2$] ++(-2.6,0)
      to[short, -*] ++(0,-1);
      \draw (oa2.in2)
      to [short] ++ (-0.5,0)
      to [short] ++(0,-1)
      node[ground]{};
    \end{circuitikz}
  ```
