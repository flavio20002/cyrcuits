#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
  \begin{circuitikz}
      \draw (0,0)
      to[R=$R_1$] ++ (0,2)
      to[battery1,l=$E$] ++ (0,2)
      to[short,-*] ++ (2,0) node[anchor=north-east]{$A quad$} coordinate (aux1)
      to[isource=$I_G$,invert] ++ (0,-4) node[anchor=south-east]{$B quad$}
      to[short,*-] ++ (-2,0);
      \draw (aux1)
      to[R=$R_2$] ++ (2,0)
      to[nos,l=$T$] ++ (1,0) coordinate (aux2)
      to[R=$R_3$] ++ (0,-2)
      to[L,l_=$L$,v^=$v_L$,f>_=$i_L$] ++ (0,-2)
      to[short] ++ (-3,0);
  \end{circuitikz}
```
