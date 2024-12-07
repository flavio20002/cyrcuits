#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
\begin{circuitikz}
    \draw(0,0)
    to[open,l=$v_i (t)$] ++ (0,4)
    to[R=$R$,,f>_=$i(t)$, o-*] ++ (4,0) coordinate(a) 
    to[C=$C$] ++ (0,-2)
    to[R=$2R$] ++ (0,-2) coordinate(b) 
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
    to[open,l_=$v_o (t)$] ++ (0,4)
\end{circuitikz}
```
