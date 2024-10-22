#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[battery1,l=$E_"Th"$] ++ (0,3)
    to[R=$R_"Th"$] ++ (3,0)
    to[C,l_=$C$,v^=$v_C$,f>_=$i_C$] ++ (0,-3)
    to[short] ++ (-3,0);
\end{circuitikz}
```
