#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (1,0)), "short", node-left: "o")
  node("op amp", name: "oa", anchor: "+")
  to((rel: (1,0)), "short", node-right: "o")
  to((rel: (0,-2.5)), l: $v_o (t)$, "open", node-right: "o", invert: true)
  to((rel: (0,-0.5)), "short")
  node("ground")
  draw("oa.out")
  to((rel: (0,1.5)), "short", node-left: "*")
  to((rel: (-2.6,0)), "R", l: $R_f$)
  to((rel: (0,-1)), "short")
  to((rel: (-2,0)), "R", l: $R$, node-left: "*")
  to((rel: (0,-0.5)), "short")
  node("ground")
  draw((0,0))
  to((rel: (0,-2)), l: $v_i (t)$, "open", invert: true)
  to((rel: (0,-0.5)), "short", node-left: "o")
  node("ground")
})

/*
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
*/