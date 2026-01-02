#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (2,0)), "R", l: $R_1$, node-left: "o", l-modifier: true, coordinate: "aux1")
  node("above", l: $v_+$)
  node("op amp", name: "oa", anchor: "+")

  draw("oa.out")
  to((rel: (1,0)), "short", node-right: "o")
  to((rel: (0,-2.5)), "open", l: $v_o$, invert: true)
  to((rel: (0,-0.5)), "short", node-left: "o")
  node("ground")

  draw("oa.out")
  to((rel: (0,1.5)), "short", node-left: "*")
  to((rel: (-2.6,0)), "R", l: $R_2$)
  to((rel: (0,-1)), "short")
  to((rel: (-3,0)), "R", l: $R_1$, node-left: "*")
  to((rel: (0,-0.5)), "short")
  node("ground")

  draw((0,0))
  to((rel: (0,-2)), "open", l: $v_i$, invert: true)
  to((rel: (0,-0.5)), "short", node-left: "o")
  node("ground")

  draw("aux1")
  to((rel: (0,-2)), "R", l: $R_2$, node-left: "*")
  to((rel: (0,-0.5)), "short")
  node("ground")
})

/*
```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      to[R,l_=$R_1$, o-] ++(2,0) coordinate (aux1)
      node[above]{$v_+$} 
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
      to[R, l=$R_1$, *-] ++(-3,0)
      to [short] ++(0,-0.5)
      node[ground]{};
      \draw (0,0)
      to[open,l=$v_i$, invert] ++ (0,-2)
      to [short,o-] ++(0,-0.5)
      node[ground]{};
      \draw (aux1)
      to[R,l=$R_2$, *-] ++(0,-2)
      to [short] ++(0,-0.5)
      node[ground]{};
    \end{circuitikz}
```
*/