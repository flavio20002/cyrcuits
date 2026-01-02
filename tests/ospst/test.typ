#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "battery1", l: $E$)
  to((rel: (0,2)), "R", l: $R$)
  to((rel: (2,0)), "short", node-right: "*", coordinate: "aux1")
  node("above", l: $A$)
  to((rel: (0,-4)), "ospst", l: $T$, node-left: "*")
  to((rel: (-2,0)), "short")

  draw("aux1")
  to((rel: (2,0)), "short", node-left: "*")
  to((rel: (0,-4)), "L", l: $L$, l-modifier: "_", v: $v_L$, f: $i_L$)
  to((rel: (-2,0)), "short", node-right: "*")
  node("below", l: $B$)
})

/*
```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      to[battery1,l=$E$] ++ (0,2)
      to[R=$R$] ++ (0,2)
      to[short,-*] ++ (2,0) coordinate (aux1)
      node[above]{$A$} 
      to[ospst,l=$T$,*-] ++ (0,-4)
      to[short] ++ (-2,0);
      \draw (aux1)
      to[short,*-] ++ (2,0)
      to[L,l_=$L$,v^=$v_L$,f>_=$i_L$] ++(0,-4)
      to[short,-*] ++ (-2,0)
      node[below]{$B$};
  \end{circuitikz}
```
*/