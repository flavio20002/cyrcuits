#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)
#show: doc => cyrcuits(
  scale: 1,
  doc,
)

```circuitkz
\begin{circuitikz}
    \draw (0,0)
    to[short] ++ (0,-15);
    \draw (14,0)
    to[short] ++ (0,-15);
    \draw (0,-1)
    to[NOContact="TRUE"] ++ (4,0)
    node[operation](ADD_1){"ADD"};
    \draw (ADD_1.in1)
    node[left](){"CTU_Min5.CV"};
    \draw (ADD_1.in2)
    node[left](){"CTU_Mag10.CV"};
    \draw (ADD_1.res)
    node[right](){"ProsciuttiTotali"};
    \draw (0,-4)
    to[NOContact="TRUE"] ++ (4,0)
    node[operation](ADD_2){"ADD"};
    \draw (ADD_2.in1)
    node[left](){"ProsciuttiTotali"};
    \draw (ADD_2.in2)
    node[left](){"CTU_Intermedi.CV"};
    \draw (ADD_2.res)
    node[right](){"ProsciuttiTotali"};
    \draw (0,-7)
    to[NOContact="TRUE"] ++ (4,0)
    node[operation](ADD_3){"ADD"};
    \draw (ADD_3.in1)
    node[left](){"CTU_Mag10.CV"};
    \draw (ADD_3.in2)
    node[left](){"CTU_Intermedi.CV"};
    \draw (ADD_3.res)
    node[right](){"ProsciuttiCommerciabili"};
    \draw (0,-10)
    to[NOContact="TRUE"] ++ (4,0)
    node[operation](MUL_1){"MUL"};
    \draw (MUL_1.in1)
    node[left](){"ProsciuttiCommerciabili"};
    \draw (MUL_1.in2)
    node[left](){"100"};
    \draw (MUL_1.res)
    node[right](){"ProsciuttiCommerciabili"};
    \draw (0,-13)
    to[NOContact="TRUE"] ++ (4,0)
    node[operation](DIV_1){"DIV"};
    \draw (DIV_1.in1)
    node[left](){"ProsciuttiCommerciabili"};
    \draw (DIV_1.in2)
    node[left](){"ProsciuttiTotali"};
    \draw (DIV_1.res)
    node[right](){"PercentualeProsciuttiCommerciabili"};
\end{circuitikz}
```