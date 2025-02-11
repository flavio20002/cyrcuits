#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
  \begin{circuitikz}
    \draw (0,0)
    to[sV,l=$v_s$] ++ (0,2)
    to[R=$R_s$] ++ (0,2)
    to[short,-o] ++ (2,0) coordinate (aux1)
    to[open,l_=$v_s^'$,invert] ++ (0,-4)
    to[short,o-] ++ (-2,0);
    \draw (aux1)
    to[short] ++ (2,0) coordinate (aux2)
    to[R,l_=$R_l$] ++ (0,-4)
    to[short] ++ (-2,0);
  \end{circuitikz}
```
