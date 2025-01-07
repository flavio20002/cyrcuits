#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
    \begin{circuitikz}
        \draw(0,0)
        to[open,l=$V_i (s)$] ++ (0,4)
        to[short,f>_=$I(s)$, o-*] ++ (2,0) coordinate(a) 
        to[generic=$Z_s$,f>=$I_1(s)$] ++ (0,-4) coordinate(b) 
        to[short, *-o] ++ (-2,0)
        \draw(a)
        to[short] ++ (2,0) coordinate(c) 
        \draw(c)
        to[generic=$Z_p$] ++ (0,-2)
        to[R=$R$,f>=$I_2(s)$] ++ (0,-2) 
        \draw(b)
        to[short] ++ (2,0)
    \end{circuitikz}
```
