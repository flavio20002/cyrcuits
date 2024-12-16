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
      to[R=$R$,,f>_=$I(s)$, o-*] ++ (4,0) coordinate(a) 
      to[generic=$Z_s$] ++ (0,-4) coordinate(b) 
      to[short, *-o] ++ (-4,0)
      \draw(a)
      to[short] ++ (2,0) coordinate(c)
      \draw(c)
      to[short, -o] ++ (2,0)
      \draw(c)
      to[C=$2C$, *-*] ++ (0,-4) 
      \draw(b)
      to[short] ++ (2,0) coordinate(d)
      \draw(d)
      to[short, -o] ++ (2,0)
      to[open,l_=$V_o (s)$] ++ (0,4)
  \end{circuitikz}
```
