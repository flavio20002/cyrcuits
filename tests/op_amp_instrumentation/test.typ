#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
  \begin{circuitikz}
    \draw(0,0)
    node[above]{$v_1$} 
    to[short, o-] ++(1,0)
    node[op amp, anchor=+, noinv input up](oa){};
    \draw (oa.in2)
    to [short] ++(0,-1.5);
    \draw (oa.out)
    to [short] ++(0,-2);
    to[R, l=$R_1$, -*] ++(-2.6,0)
    to[R, l_=$R_G$, -*] ++(0,-2)
    to [short] ++(0,-1.5)
    node[op amp, anchor=-](oa2){};
    \draw (oa2.out)
    to [short] ++(0,2)
    to[R, l=$R_1$, -*] ++(-2.6,0);
    \draw (oa2.in2)
    to[short, -o] ++(-1,0)
    node[above]{$v_2$};
    \draw (oa.out)
    to[R, l=$R_2$, *-*] ++(2.6,0)
    to [short] ++(0,-2.5)
    node[op amp, anchor=-](oa3){};
    \draw (oa3.out)
    to [short] ++(0,3)
    to[R, l=$R_3$, -*] ++(-2.6,0);
    \draw (oa3.out)
    to[short, *-o] ++(1,0)
    to[open,l=$v_o$, invert] ++ (0,-2)
    to [short,o-] ++ (0,-0.5)
    node[ground]{};
    \draw (oa3.in2)
    to [short] ++(0,-2.5)
    \draw (oa2.out)
    to[R, l=$R_2$, *-*] ++(2.6,0)
    to[R, l=$R_3$, *-] ++(2.6,0)
    to [short] ++(0,-1)
    node[ground]{};
  \end{circuitikz}
```