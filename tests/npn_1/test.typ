#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "battery1", l: $V_"CC"$, coordinate: "aux1")
  to((rel: (2,0)), "nos", l: $T$)
  to((rel: (2,0)), "R", l: $R_B$, flow: $I_B$)
  node("npn", name: "Q", show-voltage: true)
  draw("Q.E")
  to((rel: (0,-1)), "short")
  to((rel: (-5,0)), "short")
  to((rel: (0,-0.5)), "short", node-left: "*")
  node("ground")
  draw("aux1")
  to((rel: (0,3)), "short", node-left: "*")
  to((rel: (5,0)), "R", l: $R_C$, flow: $I_C$)
  to((rel: (0,-2)), "led", l: $D$)
})

/* #show: doc => cyrcuits(
  scale: 1,
  doc,
)

 ```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      to[battery1,l=$V_"CC"$] ++ (0,2) coordinate (aux1)
      to[nos=$T$] ++ (2,0)
      to[R=$R_B$,f>_=$I_B$] ++ (2,0)
      node[npn, anchor=B, show voltage](Q){};
      \draw (Q.E)
      to[short] ++ (0,-1)
      to[short] ++ (-5.,0);
      \draw (0,0)
      to[short, *-] ++ (0,-0.5)
      node[ground]{};
      \draw (aux1)
      to[short,*-] ++ (0,3)
      to[R=$R_C$,f>_=$I_C$] ++ (5,0)
      to[led=$D$] ++ (0,-2)
    \end{circuitikz}
  ``` */
