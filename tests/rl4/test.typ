#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "battery1", l: $E$)
  to((rel: (0,2)), "R", l: $R_1$, f: $i_1$)
  to((rel: (2,0)), "short", node-right: "*", coordinate: "aux1")
  node("above", l: $A$)
  to((rel: (0,-4)), "R", l: $R_2$, l-modifier: "_", f: $i_2$)
  to((rel: (-2,0)), "short")

  draw("aux1")
  to((rel: (2,0)), "nos", l: $T$, node-left: "*")
  to((rel: (0,-2)), "R", l: $R_3$)
  to((rel: (0,-2)), "L", l: $L$, l-modifier: "_", v: $v_L$, f: $i_L$)
  to((rel: (-2,0)), "short", node-right: "*")
  node("below", l: $B$)
})

/*
```circuitkz
  \begin{circuitikz}
      \draw (0,0)
      to[battery1,l=$E$] ++ (0,2)
      to[R=$R_1$,f>_=$i_1$] ++ (0,2)
      to[short, -*] ++ (2,0) coordinate (aux1)
      node[above]{$A$} 
      to[R,l_=$R_2$, f>_=$i_2$] ++(0,-4)
      to[short] ++ (-2,0);
      \draw (aux1)
      to[nos,l=$T$,*-] ++ (2,0)
      to[R=$R_3$] ++ (0,-2)
      to[L,l_=$L$,v^=$v_L$,f>_=$i_L$] ++ (0,-2)
      to[short,-*] ++ (-2,0)
      node[below]{$B$};
  \end{circuitikz}
```
*/