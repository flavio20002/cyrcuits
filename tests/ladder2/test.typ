#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  ladder-power-bars(height: 15, width: 15)
  draw((0,-1))
  to((rel: (3,0)), "NOContact", l: "PS1")
  node("ton", name: "TON_PS1")
  to((rel: (3,0)), "NOContact", l: "Funzione")
  to((rel: (3,0)), "NCContact", l: "FineSmistamento")
  to((rel: (3,0)), "Coil", l: "Smistamento")
  draw("TON_PS1.pt")
  node("left", l: "T#200ms")
  draw((0,-3))
  to((rel: (3,0)), "NOContact", l: "Smistamento")
  to((rel: (3,0)), "short")
  to((rel: (0,2)), "short")
  draw((0,-5))
  to((rel: (3,0)), "NOContact", l: "Smistamento")
  node("ton", name: "TON_PESATURA")
  to((rel: (6,0)), "short")
  to((rel: (3,0)), "Coil", l: "FinePesatura")
  draw("TON_PESATURA.pt")
  node("left", l: "T#5s")
  draw((0,-8))
  to((rel: (3,0)), "NOContact", l: "FinePesatura")
  node("compare", name: "LT_PESO_MIN5", l: "LT")
  to((rel: (6,0)), "short")
  to((rel: (3,0)), "Coil", l: "PesoMin5")
  draw("LT_PESO_MIN5.a")
  node("left", l: "LC1")
  draw("LT_PESO_MIN5.b")
  node("left", l: "3.33")
  draw((0,-11))
  to((rel: (3,0)), "NOContact", l: "FinePesatura")
  node("compare", name: "GT_PESO_MAG10", l: "GT")
  to((rel: (6,0)), "short")
  to((rel: (3,0)), "Coil", l: "PesoMag10")
  draw("GT_PESO_MAG10.a")
  node("left", l: "LC1")
  draw("GT_PESO_MAG10.b")
  node("left", l: "6.66")
  draw((0,-14))
  to((rel: (3,0)), "NOContact", l: "FinePesatura")
  node("compare", name: "GE", l: "GE")
  node("compare", name: "LE", l: "LE")
  to((rel: (3,0)), "short")
  to((rel: (3,0)), "Coil", l: "PesoIntermedio")
  draw("LE.a")
  node("left", l: "LC1")
  draw("LE.b")
  node("left", l: "6.66")
  draw("GE.a")
  node("left", l: "LC1")
  draw("GE.b")
  node("left", l: "3.33")
})

/* #show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[short] ++ (0,-15);
    \draw (15,0)
    to[short] ++ (0,-15);
    \draw (0,-1)
    to[NOContact="PS1"] ++ (3,0)
    node[ton](TON_PS1){};
    \draw (TON_PS1.q)
    to[NOContact="Funzione"] ++ (3,0)
    to[NCContact="FineSmistamento"] ++ (3,0)
    to[Coil="Smistamento"] ++ (3,0);
    \draw (TON_PS1.pt)
    node[left](){"T#200ms"}
    \draw (0,-3)
    to[NOContact="Smistamento"] ++ (3,0)
    to[short] ++ (3,0)
    to[short] ++ (0,2);
    \draw (0,-5)
    to[NOContact="Smistamento"] ++ (3,0)
    node[ton](TON_PESATURA){};
    \draw (TON_PESATURA.q)
    to[short] ++ (6,0)
    to[Coil="FinePesatura"] ++ (3,0);
    \draw (TON_PESATURA.pt)
    node[left](){"T#5s"};
    \draw (0,-8)
    to[NOContact="FinePesatura"] ++ (3,0)
    node[compare](LT_PESO_MIN5){"LT"};
    \draw (LT_PESO_MIN5.out)
    to[short] ++ (6,0)
    to[Coil="PesoMin5"] ++ (3,0);
    \draw (LT_PESO_MIN5.a)
    node[left](){"LC1"};
    \draw (LT_PESO_MIN5.b)
    node[left](){"3.33"};
    \draw (0,-11)
    to[NOContact="FinePesatura"] ++ (3,0)
    node[compare](GT_PESO_MAG10){"GT"};
    \draw (GT_PESO_MAG10.out)
    to[short] ++ (6,0)
    to[Coil="PesoMag10"] ++ (3,0);
    \draw (GT_PESO_MAG10.a)
    node[left](){"LC1"};
    \draw (GT_PESO_MAG10.b)
    node[left](){"6.66"};
    \draw (0,-14)
    to[NOContact="FinePesatura"] ++ (3,0)
    node[compare](GE){"GE"};
    \draw (GE.out)
    node[compare](LE){"LE"};
    \draw (LE.out)
    to[short] ++ (3,0)
    to[Coil="PesoIntermedio"] ++ (3,0);
    \draw (LE.a)
    node[left](){"LC1"};
    \draw (LE.b)
    node[left](){"6.66"};
\end{circuitikz}
``` */