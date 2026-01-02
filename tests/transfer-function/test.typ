#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,4)), "open", l: $v_i(t)$)
  to((rel: (2,0)), "short", node-left: "*", coordinate: "a")
  to((rel: (0,-2)), "R", l: $R$)
  to((rel: (0,-2)), "C", l: $C$, node-right: "*")
  to((rel: (-2,0)), "short", node-right: "*")

  draw("a")
  to((rel: (1,0)), "short", node-left: "*", coordinate: "b")
  to((rel: (0,0.5)), "short", node-left: "*")
  to((rel: (2,0)), "C", l: $C$)
  to((rel: (0,-0.5)), "short")
  to((rel: (1,0)), "short", node-left: "*", node-right: "*", coordinate: "c")
  to((rel: (0,-4)), "R", l: $R$, coordinate: "d")
  to((rel: (-4,0)), "short", node-left: "*")

  draw("b")
  to((rel: (0,-0.5)), "short", node-left: "*")
  to((rel: (2,0)), "R", l: $2R$, l-modifier: "_")
  to((rel: (0,1)), "short")

  draw("c")
  to((rel: (2,0)), "short", node-right: "*")

  draw("d")
  to((rel: (2,0)), "short", node-right: "*")
  to((rel: (0,4)), "open", l: $v_o(t)$, l-modifier: "_")
})

/*
```circuitkz
\begin{circuitikz}
    \draw(0,0)
    to[open,l=$v_i(t)$] ++ (0,4)
    to[short, *-] ++ (2,0) coordinate(a) 
    to[R=$R$] ++ (0,-2)
    to[C=$C$,-*] ++ (0,-2) 
    to[short, -*] ++ (-2,0);
    \draw(a)
    to[short, *-] ++ (1,0) coordinate(b) 
    to[short, *-] ++ (0,0.5)
    to[C=$C$] ++ (2,0)
    to[short] ++ (0,-0.5)
    to[short, -*, *-] ++ (1,0) coordinate(c)
    to[R=$R$] ++ (0,-4) coordinate(d)
    to[short, *-] ++ (-4,0);
    \draw(b)
    to[short, *-] ++ (0,-0.5)
    to[R,l_=$2R$] ++ (2,0)
    to[short] ++ (0,1);
    \draw(c)
    to[short, -*] ++ (2,0)
    \draw(d)
    to[short, -*] ++ (2,0)
    to[open,l_=$v_o(t)$] ++ (0,4)
\end{circuitikz}
```
*/