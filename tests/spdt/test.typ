#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  node("spdt", name: "sw")
  draw("sw.in")
  to((rel: (2,0)), "R", l: $2R$)
})

/*
```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      node[spdt] (sw) {}
      \draw (sw.in) to [R=$2R$] ++ (2,0) 
    \end{circuitikz}
```
*/