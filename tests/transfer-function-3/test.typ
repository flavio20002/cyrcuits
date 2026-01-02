#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,4)), "open", l: $v_i (t)$)
  to((rel: (2,0)), "short", f: $i(t)$, node-left: "o", node-right: "*", coordinate: "a")
  to((rel: (0,-2)), "R", l: $R$)
  to((rel: (0,-2)), "L", l: $L$, coordinate: "b")
  to((rel: (-2,0)), "short", node-left: "*", node-right: "o")

  draw("a")
  to((rel: (1,0)), "short", coordinate: "e")
  to((rel: (0,0.5)), "short")
  to((rel: (2,0)), "L", l: $L$)
  to((rel: (0,-0.5)), "short")
  to((rel: (1,0)), "short", coordinate: "c")

  draw("e")
  to((rel: (0,-0.5)), "short", node-left: "*")
  to((rel: (2,0)), "R", l: $2R$)
  to((rel: (0,0.5)), "short", node-right: "*")

  draw("c")
  to((rel: (2,0)), "short", node-right: "o")

  draw("c")
  to((rel: (0,-4)), "R", l: $R$, node-left: "*", node-right: "*")

  draw("b")
  to((rel: (4,0)), "short", coordinate: "d")

  draw("d")
  to((rel: (2,0)), "short", node-right: "o")
  to((rel: (0,4)), "open", l: $v_o (t)$, l-modifier: "_")
})

/*
```circuitkz
\begin{circuitikz}
    \draw(0,0)
    to[open,l=$v_i (t)$] ++ (0,4)
    to[short,f>_=$i(t)$, o-*] ++ (2,0) coordinate(a) 
    to[R=$R$] ++ (0,-2)
    to[L=$L$] ++ (0,-2) coordinate(b) 
    to[short, *-o] ++ (-2,0)
    \draw(a)
    to[short] ++ (1,0) coordinate(e)
    to[short] ++ (0,0.5)
    to[L=$L$] ++ (2,0)
    to[short] ++ (0,-0.5) 
    to[short] ++ (1,0) coordinate(c)
    \draw(e)
    to[short, *-] ++ (0,-0.5)
    to[R=$2R$] ++ (2,0)
    to[short, -*] ++ (0,0.5)
    \draw(c)
    to[short, -o] ++ (2,0)
    \draw(c)
    to[R=$R$, *-*] ++ (0,-4) 
    \draw(b)
    to[short] ++ (4,0) coordinate(d)
    \draw(d)
    to[short, -o] ++ (2,0)
    to[open,l_=$v_o (t)$] ++ (0,4)
\end{circuitikz}
```
*/