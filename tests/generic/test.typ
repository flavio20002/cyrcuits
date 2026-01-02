#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,4)), "open", l: $V_i (s)$)
  to((rel: (4,0)), "R", l: $R$, f: $I(s)$, node-left: "o", node-right: "*", coordinate: "a")
  to((rel: (0,-4)), "generic", l: $Z_s$, coordinate: "b")
  to((rel: (-4,0)), "short", node-left: "*", node-right: "o")

  draw("a")
  to((rel: (2,0)), "short", coordinate: "c")

  draw("c")
  to((rel: (2,0)), "short", node-right: "o")

  draw("c")
  to((rel: (0,-4)), "C", l: $2C$, node-left: "*", node-right: "*")

  draw("b")
  to((rel: (2,0)), "short", coordinate: "d")

  draw("d")
  to((rel: (2,0)), "short", node-right: "o")
  to((rel: (0,4)), "open", l: $V_o (s)$, l-modifier: "_")
})

/*

```circuitkz
    \begin{circuitikz}
      \draw(0,0)
      to[open,l=$V_i (s)$] ++ (0,4)
      to[R=$R$,,f>_=$I(s)$, o-*] ++ (4,0) coordinate(a) 
      to[generic=$Z_s$] ++ (0,-4) coordinate(b) 
      to[short, *-o] ++ (-4,0)
      \draw(a)
      to[short] ++ (2,0) coordinate(c)
      \draw(c)
      to[short, -o] ++ (2,0)
      \draw(c)
      to[C=$2C$, *-*] ++ (0,-4) 
      \draw(b)
      to[short] ++ (2,0) coordinate(d)
      \draw(d)
      to[short, -o] ++ (2,0)
      to[open,l_=$V_o (s)$] ++ (0,4)
  \end{circuitikz}
```
*/