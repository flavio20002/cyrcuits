#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
  \begin{circuitikz}
    \draw (0,0)
    to[battery1,l=$E$] ++(0,4) % The voltage source
    to[R,l=$R_1$] ++ (3,0) coordinate (aux1)
    to[R,l=$R_2$] ++ (0,-2)
    to[L,l=$L$] ++ (0,-2)
    to[short] ++(-3,0);
    \draw (aux1)
    to[short,*-] ++(2,0)
    to[R,l=$R_3$] ++(0,-4) 
    to[short,-*] ++(-2,0);
```
