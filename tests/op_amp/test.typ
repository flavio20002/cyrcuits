#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      node[op amp] (oa) {}
      \draw (oa.vcc1) to [R,l_=$2R$] ++ (0,2)
      \draw (oa.vcc2) to [R=$2R$] ++ (0,-2)
      \draw (oa.in1) to [R,l_=$2R$] ++ (-2,0)
      \draw (oa.in2) to [R,l=$2R$] ++ (-2,0)
      \draw (oa.out) to [R,l=$2R$] ++ (2,0)
      \draw (6,0)
      node[op amp] (o) {}
    \end{circuitikz}
```
