#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "sV", l: $v_s$)
  to((rel: (0,2)), "R", l: $R_s$)
  to((rel: (2,0)), "short", node-right: "o", coordinate: "aux1")
  to((rel: (0,-4)), "open", l: $v_s^'$, l-modifier: "_", invert: true)
  to((rel: (-2,0)), "short", node-left: "o")

  draw("aux1")
  to((rel: (2,0)), "short", coordinate: "aux2")
  to((rel: (0,-4)), "R", l: $R_l$, l-modifier: "_")
  to((rel: (-2,0)), "short")
})

/*
```circuitkz
  \begin{circuitikz}
    \draw (0,0)
    to[sV,l=$v_s$] ++ (0,2)
    to[R=$R_s$] ++ (0,2)
    to[short,-o] ++ (2,0) coordinate (aux1)
    to[open,l_=$v_s^'$,invert] ++ (0,-4)
    to[short,o-] ++ (-2,0);
    \draw (aux1)
    to[short] ++ (2,0) coordinate (aux2)
    to[R,l_=$R_l$] ++ (0,-4)
    to[short] ++ (-2,0);
  \end{circuitikz}
```
*/