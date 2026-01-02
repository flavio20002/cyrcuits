#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "battery1", l: $E$)
  to((rel: (0,2)), "R", l: $R_1$, f: $i_1$)
  to((rel: (2,0)), "short", node-right: "*", coordinate: "aux1")
  to((rel: (0,-4)), "R", l: $R_2$, l-modifier: "_", f: $i_2$)
  to((rel: (-2,0)), "short", node-left: "*")

  draw("aux1")
  to((rel: (2,0)), "short", coordinate: "aux2")
  to((rel: (0,-4)), "battery1", l: $V_C^0$, f: $i_C$, invert: true)
  to((rel: (-2,0)), "short")
})

/*
```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[battery1=$E$] ++ (0,2)
    to[R=$R_1$,f>_=$i_1$] ++ (0,2)
    to[short,-*] ++ (2,0) coordinate (aux1)
    to[R,l_=$R_2$,f>_=$i_2$] ++ (0,-4)
    to[short,*-] ++ (-2,0);
    \draw (aux1)
    to[short] ++ (2,0) coordinate (aux2)
    to[battery1,l=$V_C^0$,f>_=$i_C$,invert] ++ (0,-4)
    to[short] ++ (-2,0);
\end{circuitikz}
```
*/