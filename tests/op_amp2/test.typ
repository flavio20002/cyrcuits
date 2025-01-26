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
      to[short, o-] ++(1,0)
      node[op amp, anchor=-](oa){};
      \draw (oa.in2) 
      to [short,-o] ++ (-1,0)
      node[above]{$v_+$};
    \end{circuitikz}
```
