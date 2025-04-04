#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

#cyrcuits2({
  draw((0,0))
  to((rel: (0.5,0)), "short", node-left: "o")
  node("op amp", name: "oa", anchor: "-")

  draw("oa.in2")
  to((rel: (-0.5,0)), "short", node-right: "o")

  draw("oa.out")
  to((rel: (0.5,0)), "short", node-right: "o")
  node("above", l: $v_o$)
  to((rel: (0,-2)), "open", l: $v_o$, invert: true)
  to((rel: (0,-0.5)), "short", node-left: "o")
  node("ground")

  draw((0,0))
  to((rel: (0,-1)), "open", l: $v_i$, l-modifier: true)
})

/*

 ```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      to[short, o-] ++(0.5,0)
      node[op amp, anchor=-](oa){};
      \draw (oa.in2) 
      to [short,-o] ++ (-0.5,0);
      \draw (oa.out)
      to [short,-o] ++ (0.5,0)
      node[above]{$v_o$}
      to[open,l=$v_o$, invert] ++ (0,-2)
      to [short,o-] ++ (0,-0.5)
      node[ground]{};
      \draw (0,0)
      to[open,l_=$v_i$] ++ (0,-1);
    \end{circuitikz}
  ```
/*