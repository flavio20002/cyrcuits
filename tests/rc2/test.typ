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
      to[R,l=$R_1$] ++ (0,2)
      to[short,-*] ++ (2,0) coordinate (aux1)
      to[R,l_=$R_2$] ++(0,-4)
      to[short,*-] ++ (-2,0);
      \draw (aux1)
      to[short,*-] ++ (2,0)
      to[C,l_=$C$] ++(0,-4)
      to[short] ++(-2,0);
  \end{circuitikz}
```