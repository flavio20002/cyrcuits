#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[battery1=$E$] ++ (0,2)
    to[R=$R_1$,f>_=$i_1$] ++ (0,2)
    to[short,-*] ++ (2,0) coordinate (aux1)
    to[R,l_=$R_2$,f>_=$i_2$] ++ (0,-4)
    to[short,*-] ++ (-2,0);
    \draw (aux1)
    to[short] ++ (2,0) coordinate (aux2)
    to[battery1,l=$V_C^0$,v^=$v_C$,f>_=$i_C$,invert] ++ (0,-4)
    to[short] ++ (-2,0);
\end{circuitikz}
```
