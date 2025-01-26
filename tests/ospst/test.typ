#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      to[battery1,l=$E$] ++ (0,2)
      to[R=$R$] ++ (0,2)
      to[short,-*] ++ (2,0) coordinate (aux1)
      node[above]{$A$} 
      to[ospst,l=$T$,*-] ++ (0,-4)
      to[short] ++ (-2,0);
      \draw (aux1)
      to[short,*-] ++ (2,0)
      to[L,l_=$L$,v^=$v_L$,f>_=$i_L$] ++(0,-4)
      to[short,-*] ++ (-2,0)
      node[below]{$B$};
  \end{circuitikz}
```
