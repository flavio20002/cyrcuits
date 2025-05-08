#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0.5,0)), "short")
  node("op amp", name: "oa", anchor: "+")

  draw("oa.out")
  to((rel: (1,0)), "short", node-right: "o")
  to((rel: (0,-2.5)), "open", l: $v_o$, invert: true, node-right: "o")
  to((rel: (0,-0.5)), "short")
  node("ground")

  draw("oa.out")
  to((rel: (0,1.5)), "short", node-left: "*")
  to((rel: (-2.6,0)), "R", l: $R_2$)
  to((rel: (0,-1)), "short")
  to((rel: (-2.6,0)), "R", l: $R_1$, node-left: "*", node-right: "o")
  to((rel: (0,-3)), "open", l: $v_i$, invert: true)
  to((rel: (0,-0.5)), "short", node-left: "o")
  node("ground")

  draw((0,0))
  to((rel: (0,-1)), "short")
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
      to[short] ++(0.5,0)
      node[op amp, anchor=+](oa){};
      \draw (oa.out)
      to [short,-o] ++(1,0)
      to[open,l=$v_o$, invert] ++ (0,-2.5)
      to [short,o-] ++ (0,-0.5)
      node[ground]{};
      \draw (oa.out)
      to[short, *-] ++(0,1.5)
      to[R, l=$R_2$] ++(-2.6,0)
      to[short, -] ++(0,-1)
      node[below]{$v_-$} 
      to[R, l=$R_1$,,f<=$i$, *-o] ++(-2.6,0)
      to[open,l=$v_i$, invert] ++ (0,-3)
      to [short,o-] ++(0,-0.5)
      node[ground]{};
      \draw (0,0)
      to [short] ++(0,-1)
      node[ground]{};
    \end{circuitikz}
  ```
*/