#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  ladder-power-bars(height: 28, width: 15)
  draw((0,-1))
  to((rel: (3,0)), "NCContact", l: "PBE")
  to((rel: (9,0)), "short")
  to((rel: (3,0)), "Coil", l: "Emergency")
  
  draw((0,-3))
  to((rel: (3,0)), "NOContact", l: "PB1")
  to((rel: (3,0)), "NCContact", l: "StopRichiesto")
  to((rel: (3,0)), "NCContact", l: "Anomalia")
  to((rel: (3,0)), "NCContact", l: "Emergenza")
  to((rel: (3,0)), "Coil", l: "Funzione")
  
  draw((0,-5))
  to((rel: (3,0)), "NOContact", l: "Funzione")
  to((rel: (0,2)), "short")

  draw((0,-7))
  to((rel: (3,0)), "NOContact", l: "Smistamento")
  to((rel: (3,0)), "short")
  to((rel: (0,4)), "short")

  draw((0,-9))
  to((rel: (3,0)), "NCContact", l: "PB2")
  to((rel: (3,0)), "NOContact", l: "Funzione")
  to((rel: (6,0)), "short")
  to((rel: (3,0)), "Coil", l: "StopRichiesto")

  draw((0,-11))
  to((rel: (3,0)), "NOContact", l: "FS1")
  to((rel: (0,2)), "short")

  draw((0,-13))
  to((rel: (3,0)), "NOContact", l: "FS2")
  to((rel: (0,2)), "short")

  draw((0,-15))
  to((rel: (3,0)), "NOContact", l: "StopRichiesto")
  to((rel: (0,2)), "short")

  draw((0,-17))
  to((rel: (12,0)), "short")
  to((rel: (3,0)), "Coil", l: "L1")

  draw((0,-19))
  to((rel: (3,0)), "NOContact", l: "Funzione")
  to((rel: (9,0)), "short")
  to((rel: (3,0)), "Coil", l: "L2")

  draw((0,-21))
  to((rel: (3,0)), "NOContact", l: "FS1")
  to((rel: (9,0)), "short")
  to((rel: (3,0)), "Coil", l: "L3")

  draw((0,-23))
  to((rel: (3,0)), "NOContact", l: "FS2")
  to((rel: (0,2)), "short")

  draw((0,-25))
  to((rel: (3,0)), "NOContact", l: "Anomalia")
  to((rel: (9,0)), "short")
  to((rel: (3,0)), "Coil", l: "L4")

  draw((0,-27))
  to((rel: (3,0)), "NOContact", l: "Emergenza")
  to((rel: (9,0)), "short")
  to((rel: (3,0)), "Coil", l: "L5")
})



/*
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
  \begin{circuitikz}
      \draw (0,0)
      to[short] ++ (0,-28);
      \draw (15,0)
      to[short] ++ (0,-28);
      \draw (0,-1)
      to[NCContact="PBE"] ++ (3,0)
      to[short] ++ (9,0)
      to[Coil="Emergency"] ++ (3,0);
      \draw (0,-3)
      to[NOContact="PB1"] ++ (3,0)
      to[NCContact="StopRichiesto"] ++ (3,0)
      to[NCContact="Anomalia"] ++ (3,0)
      to[NCContact="Emergenza"] ++ (3,0)
      to[Coil="Funzione"] ++ (3,0);
      \draw (0,-5)
      to[NOContact="Funzione"] ++ (3,0)
      to[short] ++ (0,2);
      \draw (0,-7)
      to[NOContact="Smistamento"] ++ (3,0)
      to[short] ++ (3,0)
      to[short] ++ (0,4);
      \draw (0,-9)
      to[NCContact="PB2"] ++ (3,0)
      to[NOContact="Funzione"] ++ (3,0)
      to[short] ++ (6,0)
      to[Coil="StopRichiesto"] ++ (3,0);
      \draw (0,-11)
      to[NOContact="FS1"] ++ (3,0)
      to[short] ++ (0,2);
      \draw (0,-13)
      to[NOContact="FS2"] ++ (3,0)
      to[short] ++ (0,2);
      \draw (0,-15)
      to[NOContact="StopRichiesto"] ++ (3,0)
      to[short] ++ (0,2);
      \draw (0,-17)
      to[short] ++ (12,0)
      to[Coil="L1"] ++ (3,0);
      \draw (0,-19)
      to[NOContact="Funzione"] ++ (3,0)
      to[short] ++ (9,0)
      to[Coil="L2"] ++ (3,0);
      \draw (0,-21)
      to[NOContact="FS1"] ++ (3,0)
      to[short] ++ (9,0)
      to[Coil="L3"] ++ (3,0);
      \draw (0,-23)
      to[NOContact="FS2"] ++ (3,0)
      to[short] ++ (0,2);
      \draw (0,-25)
      to[NOContact="Anomalia"] ++ (3,0)
      to[short] ++ (9,0)
      to[Coil="L4"] ++ (3,0);
      \draw (0,-27)
      to[NOContact="Emergenza"] ++ (3,0)
      to[short] ++ (9,0)
      to[Coil="L5"] ++ (3,0);
  \end{circuitikz}
```
*/
