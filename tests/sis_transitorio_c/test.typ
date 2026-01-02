#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,4)), "battery1", l: $E$)
  to((rel: (2,0)), "nos", l: $E$)
  to((rel: (2,0)), "R", l: $R$)
  to((rel: (0,-4)), "C", l: $C$, l-modifier: "_", v: $v_C$, f: $i_C$)
  to((rel: (-4,0)), "short")
})

/*
```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[battery1=$E$] ++ (0,4)
    to[nos=$E$] ++ (2,0)
    to[R=$R$] ++ (2,0)
    to[C,l_=$C$,v^=$v_C$,f>_=$i_C$] ++ (0,-4)
    to[short] ++ (-4,0);
\end{circuitikz}
  ```
*/