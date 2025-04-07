#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  node("above", l: $v_-$)
  to((rel: (0.5,0)), "short", node-left: "o")
  node("op amp", name: "oa", anchor: "-")

  draw("oa.in2")
  to((rel: (-0.5,0)), "short", node-right: "o")
  node("above", l: $v_+$)

  draw("oa.vcc1")
  to((rel: (0,1)), "short", node-right: "o")
  node("above", l: $+ V_"CC"$)

  draw("oa.vcc2")
  to((rel: (0,-1)), "short", node-right: "o")
  node("below", l: $-V_"CC"$)

  draw("oa.out")
  to((rel: (0.5,0)), "short", node-right: "o")
  node("above", l: $v_o$)
})


/*

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

*/