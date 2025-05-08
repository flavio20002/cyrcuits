#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "R", l: $R_1$)
  to((rel: (0,2)), "battery1", l: $E$)
  to((rel: (2,0)), "short", node-right: "*", coordinate: "aux1")
  node("above", l: $A$)
  to((rel: (0,-4)), "isource", l: $I_G$, invert: true)
  node("below", l: $B$)
  to((rel: (-2,0)), "short", node-left: "*")

  draw("aux1")
  to((rel: (2,0)), "R", l: $R_2$)
  to((rel: (1,0)), "nos", l: $T$)
  to((rel: (0,-2)), "R", l: $R_3$)
  to((rel: (0,-2)), "L", l: $L$, l-modifier: "_", v: $v_L$, f: $i_L$)
  to((rel: (-3,0)), "short")
})


/*
```circuitkz
  \begin{circuitikz}
     \draw (0,0)
      to[R=$R_1$] ++ (0,2)
      to[battery1,l=$E$] ++ (0,2)
      to[short,-*] ++ (2,0) coordinate (aux1)
      node[above]{$A$} 
      to[isource=$I_G$,invert] ++ (0,-4)
      node[below]{$B$}
      to[short,*-] ++ (-2,0);
      \draw (aux1)
      to[R=$R_2$] ++ (2,0)
      to[nos,l=$T$] ++ (1,0) coordinate (aux2)
      to[R=$R_3$] ++ (0,-2)
      to[L,l_=$L$,v^=$v_L$,f>_=$i_L$] ++ (0,-2)
      to[short] ++ (-3,0);
  \end{circuitikz}
```
*/