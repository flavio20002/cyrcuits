#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
   \begin{circuitikz}
        \draw (0,0)
        to[battery1=$E_1$] ++ (0,2.5)
        to[R=$R_1$,f>_=$i_1$] ++ (0,2.5)
        to[R=$R_2$,-*] ++ (2.5,0) coordinate (aux1)
        to[R,l_=$R_3$] ++ (0,-2.5)
        to[R=$R_4$,-*,f>_=$i_2$] ++ (0,-2.5)
        to[short,*-] ++ (-2.5,0);
        \draw (aux1)
        to[short] ++ (2.5,0)
        to[battery1,l_=$E_2$,f>_=$i_3$,invert] ++ (0,-2.5) coordinate (aux2)
        to[R,l=$R_5$,f>_=$i_4$,invert] ++ (0,-2.5)
        to[short,f>_=$i_6$] ++ (-2.5,0);
        \draw (aux2)
        to[R,l=$R_6$,*-] ++ (2.5,0)
        to[battery1,l=$E_3$,f>_=$i_5$,invert] ++ (0,-2.5)
        to[short, -*] ++ (-2.5,0);
    \end{circuitikz}
```
