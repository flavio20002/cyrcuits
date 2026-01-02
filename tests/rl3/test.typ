#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "battery1", l: $E$)
  to((rel: (0,2)), "R", l: $R_1$)
  to((rel: (2,0)), "short", node-right: "*", coordinate: "aux1")
  to((rel: (0,-4)), "R", l: $R_2$, l-modifier: "_")
  to((rel: (-2,0)), "short")

  draw("aux1")
  to((rel: (2,0)), "R", l: $R_3$)
  to((rel: (0,-4)), "L", l: $L$, l-modifier: "_")
  to((rel: (-2,0)), "short", node-right: "*")
})

/*
```circuitkz
  \begin{circuitikz}
      \draw (0,0)
      to[battery1,l=$E$] ++ (0,2)
      to[R,l=$R_1$] ++ (0,2)
      to[short,-*] ++ (2,0) coordinate (aux1)
      to[R,l_=$R_2$] ++(0,-4)
      to[short] ++ (-2,0);
      \draw (aux1)
      to[R,l=$R_3$] ++(2,0)
      to[L,l_=$L$] ++(0,-4)
      to[short,-*] ++(-2,0);
  \end{circuitikz}
```
*/