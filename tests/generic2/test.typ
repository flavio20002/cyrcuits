#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,4)), "open", l: $V_i (s)$)
  to((rel: (2,0)), "short", f: $I(s)$, node-left: "o", node-right: "*", coordinate: "a")
  to((rel: (0,-4)), "generic", l: $Z_s$, f: $I_1(s)$, flow-config: ">=", coordinate: "b")
  to((rel: (-2,0)), "short", node-left: "*", node-right: "o")

  draw("a")
  to((rel: (2,0)), "short", coordinate: "c")

  draw("c")
  to((rel: (0,-2)), "generic", l: $Z_p$)
  to((rel: (0,-2)), "R", l: $R$, f: $I_2(s)$, flow-config: ">=")

  draw("b")
  to((rel: (2,0)), "short")
})

/*

```circuitkz
    \begin{circuitikz}
        \draw(0,0)
        to[open,l=$V_i (s)$] ++ (0,4)
        to[short,f>_=$I(s)$, o-*] ++ (2,0) coordinate(a) 
        to[generic=$Z_s$,f>=$I_1(s)$] ++ (0,-4) coordinate(b) 
        to[short, *-o] ++ (-2,0)
        \draw(a)
        to[short] ++ (2,0) coordinate(c) 
        \draw(c)
        to[generic=$Z_p$] ++ (0,-2)
        to[R=$R$,f>=$I_2(s)$] ++ (0,-2) 
        \draw(b)
        to[short] ++ (2,0)
    \end{circuitikz}
```
*/