#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
  \begin{circuitikz}
    \draw (0,0)
    node[above]{$v_-$} 
    to[short, o-] ++(0.5,0)
    node[op amp, anchor=-](oa){};
    \draw (oa.in2) 
    to [short,-o] ++ (-0.5,0)
    node[above]{$v_+$};
    \draw (oa.vcc1) to [short,-o] ++ (0,1)
    node[above]{$+ V_"CC"$};
    \draw (oa.vcc2) to [short,-o] ++ (0,-1)
    node[below]{$-V_"CC"$};
    \draw (oa.out) 
    to [short,-o] ++ (0.5,0)
    node[above]{$v_o$};
  \end{circuitikz}
```
