#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,3)), "battery1", l: $E_"Th"$)
  to((rel: (3,0)), "R", l: $R_"Th"$)
  to((rel: (0,-3)), "C", l: $C$, l-modifier: "_", v: $v_C$, f: $i_C$)
  to((rel: (-3,0)), "short")
})

/*
```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[battery1,l=$E_"Th"$] ++ (0,3)
    to[R=$R_"Th"$] ++ (3,0)
    to[C,l_=$C$,v^=$v_C$,f>_=$i_C$] ++ (0,-3)
    to[short] ++ (-3,0);
\end{circuitikz}
```
*/