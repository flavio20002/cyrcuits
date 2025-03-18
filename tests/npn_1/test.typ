#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

 ```circuitkz
    \begin{circuitikz}
      \draw (0,0)
      to[battery1,l=$V_"CC"$] ++ (0,2) coordinate (aux1)
      to[nos="T"] ++ (2,0)
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
  ```
