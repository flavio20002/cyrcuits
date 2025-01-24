#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      node[spdt] (sw) {}
      \draw (sw.in) to [R=$2R$] ++ (2,0) 
    \end{circuitikz}
```
