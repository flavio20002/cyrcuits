#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "battery1", l: $V_"CC"$, coordinate: "aux1")
  to((rel: (2,0)), "nos", l: $T$)
  to((rel: (2,0)), "R", l: $R_B$, f: $I_B$)
  node("darlington", name: "Q1", show-voltage: true, anchor: "B")
  to((rel: (0,-1)), "short")
  to((rel: (-5,0)), "short")
  to((rel: (0,-0.5)), "short", node-left: "*")
  node("ground")
  draw("aux1")
  to((rel: (0,3)), "short", node-left: "*")
  to((rel: (5,0)), "R", l: $R_C$, f: $I_C$)
  to("Q1.C", "led", l: $D$)
})
