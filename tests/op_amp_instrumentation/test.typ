#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  node("above", l: $v_1$)
  to((rel: (1,0)), "short", node-left: "o")
  node("op amp", name: "oa", anchor: "+", non_inv_input_up: true)

  draw("oa.in2")
  to((rel: (0,-1.5)), "short")
  
  draw("oa.out")
  to((rel: (0,-2)), "short")
  to((rel: (-2.6,0)), "R", l: $R_1$, node-right: "*")
  to((rel: (0,-2)), "R", l: $R_G$, node-right: "*", l-modifier: true)
  to((rel: (0,-1.5)), "short")
  node("op amp", name: "oa2", anchor: "-")
  
  draw("oa2.out")
  to((rel: (0,2)), "short")
  to((rel: (-2.6,0)), "R", l: $R_1$, node-right: "*")
  
  draw("oa2.in2")
  to((rel: (-1,0)), "short", node-right: "o")
  node("above", l: $v_2$)
  
  draw("oa.out")
  to((rel: (2.6,0)), "R", l: $R_2$, node-left: "*", node-right: "*")
  to((rel: (0,-2.5)), "short")
  node("op amp", name: "oa3", anchor: "-")
  
  draw("oa3.out")
  to((rel: (0,3)), "short")
  to((rel: (-2.6,0)), "R", l: $R_3$, node-right: "*")
  
  draw("oa3.out")
  to((rel: (1,0)), "short", node-left: "*", node-right: "o")
  to((rel: (0,-2)), "open", l: $v_o$, invert: true)
  to((rel: (0,-0.5)), "short", node-left: "o")
  node("ground")
  
  draw("oa3.in2")
  to((rel: (0,-2.5)), "short")
  
  draw("oa2.out")
  to((rel: (2.6,0)), "R", l: $R_2$, node-left: "*", node-right: "*")
  to((rel: (2.6,0)), "R", l: $R_3$, node-left: "*")
  to((rel: (0,-1)), "short")
  node("ground")
})

/*
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
*/