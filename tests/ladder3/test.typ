#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[short] ++ (0,-17);
    \draw (12,0)
    to[short] ++ (0,-17);
    \draw (0,-1)
    to[NOContact="PS3"] ++ (4,0)
    node[ton](TON_PS3){};
    \draw (TON_PS3.q)
    node[ctu](CTU_Min5){};
    \draw (TON_PS3.pt)
    node[left](){"T#200ms"}
    \draw (0,-4)
    to[NOContact="False"] ++ (4,0)
    to[short] ++ (3.5,0);
    \draw (CTU_Min5.pv)
    node[left](){"65535"};
    \draw (0,-7)
    to[NOContact="PS4"] ++ (4,0)
    node[ton](TON_PS4){};
    \draw (TON_PS4.q)
    node[ctu](CTU_Mag10){};
    \draw (TON_PS4.pt)
    node[left](){"T#200ms"}
    \draw (0,-10)
    to[NOContact="False"] ++ (4,0)
    to[short] ++ (3.5,0);
    \draw (CTU_Mag10.pv)
    node[left](){"65535"};
    \draw (0,-13)
    to[NOContact="PS2"] ++ (4,0)
    node[ton](TON_PS2){};
    \draw (TON_PS2.q)
    node[ctu](CTU_Intermedi){};
    \draw (TON_PS2.pt)
    node[left](){"T#200ms"}
    \draw (0,-16)
    to[NOContact="False"] ++ (4,0)
    to[short] ++ (3.5,0);
    \draw (CTU_Intermedi.pv)
    node[left](){"65535"};
\end{circuitikz}
```