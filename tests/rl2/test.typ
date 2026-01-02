#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,4)), "battery1", l: $E$)
  to((rel: (3,0)), "R", l: $R_1$, coordinate: "aux1")
  to((rel: (0,-2)), "R", l: $R_2$)
  to((rel: (0,-2)), "L", l: $L$)
  to((rel: (-3,0)), "short")

  draw("aux1")
  to((rel: (2,0)), "short", node-left: "*")
  to((rel: (0,-4)), "R", l: $R_3$)
  to((rel: (-2,0)), "short", node-right: "*")
})

/*
```circuitkz
  \begin{circuitikz}
    \draw (0,0)
    to[battery1,l=$E$] ++(0,4) % The voltage source
    to[R,l=$R_1$] ++ (3,0) coordinate (aux1)
    to[R,l=$R_2$] ++ (0,-2)
    to[L,l=$L$] ++ (0,-2)
    to[short] ++(-3,0);
    \draw (aux1)
    to[short,*-] ++(2,0)
    to[R,l=$R_3$] ++(0,-4) 
    to[short,-*] ++(-2,0);
  \end{circuitikz}
```
*/
