#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  node("above", l: $v_i$)
  to((rel: (1,0)), "short", node-left: "o")
  node("op amp", name: "oa", anchor: "+")

  draw("oa.out")
  to((rel: (0.5,0)), "short", coordinate: "aux1")

  draw("oa.out")
  to((rel: (0,1.5)), "short", node-left: "*")
  to((rel: (-2.6,0)), "short")
  to((rel: (0,-1)), "short")

  draw("aux1")
  to((rel: (2,0)), "R", l: $R_1$)
  node("op amp", name: "oa2", anchor: "-")

  draw("oa2.out")
  to((rel: (1,0)), "short", node-right: "o")
  node("above", l: $v_o$)

  draw("oa2.out")
  to((rel: (0,1.5)), "short", node-left: "*")
  to((rel: (-2.6,0)), "R", l: $R_2$)
  to((rel: (0,-1)), "short", node-right: "*")

  draw("oa2.in2")
  to((rel: (-0.5,0)), "short")
  to((rel: (0,-1)), "short")
  node("ground")
})


/*
 ```circuitkz
    \begin{circuitikz}
      \draw(0,0)
      node[above]{$v_i$} 
      to[short, o-] ++(1,0)
      node[op amp, anchor=+](oa){};
      \draw (oa.out)
      to [short] ++(0.5,0) coordinate(aux1);
      \draw (oa.out)
      to[short, *-] ++(0,1.5)
      to[short] ++(-2.6,0)
      to[short, -] ++(0,-1)
      \draw (aux1)
      to[R, l=$R_1$,] ++(2,0)
      node[op amp, anchor=-](oa2){};
      \draw (oa2.out)
      to [short,-o] ++(1,0)
      node[above]{$v_o$};
      \draw (oa2.out)
      to[short, *-] ++(0,1.5)
      to[R, l=$R_2$] ++(-2.6,0)
      to[short, -*] ++(0,-1);
      \draw (oa2.in2)
      to [short] ++ (-0.5,0)
      to [short] ++(0,-1)
      node[ground]{};
    \end{circuitikz}
  ```
*/
