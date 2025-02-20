#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
  \begin{circuitikz}
    \draw (0,0)
    to[short, o-] ++(1,0)
    node[op amp, anchor=+](oa){};
    \draw (oa.out)
    to [short,-o] ++(1,0)
    to[open,l=$v_o (t)$, invert] ++ (0,-2.5)
    to [short,o-] ++ (0,-0.5)
    node[ground]{};
    \draw (oa.out)
    to[short, *-] ++(0,1.5)
    to[R, l=$R_f$] ++(-2.6,0)
    to[short, -] ++(0,-1)
    to[R, l=$R$, *-] ++(-2,0)
    to [short] ++(0,-0.5)
    node[ground]{};
    \draw (0,0)
    to[open,l=$v_i (t)$, invert] ++ (0,-2)
    to [short,o-] ++(0,-0.5)
    node[ground]{};
  \end{circuitikz}
```
