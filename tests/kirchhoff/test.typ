#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2.5)), "battery1", l: $E_1$)
  to((rel: (0,2.5)), "R", l: $R_1$, f: $i_1$)
  to((rel: (2.5,0)), "R", l: $R_2$, node-right: "*", coordinate: "aux1")
  to((rel: (0,-2.5)), "R", l: $R_3$, l-modifier: "_")
  to((rel: (0,-2.5)), "R", l: $R_4$, f: $i_2$, node-right: "*")
  to((rel: (-2.5,0)), "short", node-left: "*")

  draw("aux1")
  to((rel: (2.5,0)), "short")
  to((rel: (0,-2.5)), "battery1", l: $E_2$, l-modifier: "_", f: $i_3$, invert: true, coordinate: "aux2")
  to((rel: (0,-2.5)), "R", l: $R_5$, f: $i_4$, invert: true)
  to((rel: (-2.5,0)), "short", f: $i_6$)

  draw("aux2")
  to((rel: (2.5,0)), "R", l: $R_6$, node-left: "*")
  to((rel: (0,-2.5)), "battery1", l: $E_3$, f: $i_5$, invert: true)
  to((rel: (-2.5,0)), "short", node-right: "*")
})

/*
```circuitkz
   \begin{circuitikz}
        \draw (0,0)
        to[battery1=$E_1$] ++ (0,2.5)
        to[R=$R_1$,f>_=$i_1$] ++ (0,2.5)
        to[R=$R_2$,-*] ++ (2.5,0) coordinate (aux1)
        to[R,l_=$R_3$] ++ (0,-2.5)
        to[R=$R_4$,-*,f>_=$i_2$] ++ (0,-2.5)
        to[short,*-] ++ (-2.5,0);
        \draw (aux1)
        to[short] ++ (2.5,0)
        to[battery1,l_=$E_2$,f>_=$i_3$,invert] ++ (0,-2.5) coordinate (aux2)
        to[R,l=$R_5$,f>_=$i_4$,invert] ++ (0,-2.5)
        to[short,f>_=$i_6$] ++ (-2.5,0);
        \draw (aux2)
        to[R,l=$R_6$,*-] ++ (2.5,0)
        to[battery1,l=$E_3$,f>_=$i_5$,invert] ++ (0,-2.5)
        to[short, -*] ++ (-2.5,0);
    \end{circuitikz}
```
*/