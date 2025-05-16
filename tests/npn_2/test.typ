#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

  #cyrcuits2({
    draw((0,0))
    to((rel: (0,3)), "R", l: $R_2$, coordinate: "aux1")
    to((rel: (2,0)), "short")
    node("npn", name: "Q", show-voltage: false, anchor: "B")
    to((rel: (0,-2)), "R", l: $R_E$)
    to((rel: (-3,0)), "short")
    to((rel: (0,-0.5)), "short", node-left: "*")
    node("ground")
    draw("aux1")
    to((rel: (0,3)), "R", l: $R_1$, node-left: "*")
    to((rel: (3,0)), "short",  coordinate: "aux2")
    to((rel: (0,-2)), "R", l: $R_C$, flow-config: "_>")
    draw("aux2")
    to((rel: (3,0)), "short", node-left: "*")
    to((rel: (0,-6)), "battery1", l: $V_"CC"$, invert: true)
    to((rel: (-3,0)), "short", node-right: "*")
  })
