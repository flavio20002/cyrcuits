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
    to[short,f>_=$i(t)$, o-*] ++ (2,0) coordinate(a) 
    to[R=$R$] ++ (0,-2)
    to[L=$L$] ++ (0,-2) coordinate(b) 
    to[short, *-o] ++ (-2,0)
    \draw(a)
    to[short] ++ (1,0) coordinate(e)
    to[short] ++ (0,0.5)
    to[L=$L$] ++ (2,0)
    to[short] ++ (0,-0.5) 
    to[short] ++ (1,0) coordinate(c)
    \draw(e)
    to[short, *-] ++ (0,-0.5)
    to[R=$2R$] ++ (2,0)
    to[short, -*] ++ (0,0.5)
    \draw(c)
    to[short, -o] ++ (2,0)
    \draw(c)
    to[R=$R$, *-*] ++ (0,-4) 
    \draw(b)
    to[short] ++ (4,0) coordinate(d)
    \draw(d)
    to[short, -o] ++ (2,0)
    to[open,l_=$v_o (t)$] ++ (0,4)
\end{circuitikz}
```
