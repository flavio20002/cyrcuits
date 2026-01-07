#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,4)), "battery1", l: $V_"CC"$)
  to((rel: (2,0)), "short", coordinate: "aux1")
  to((rel: (0,-4)), "potentiometer", l: $R_1$, l-modifier: "_", n: "mypot")
  to((rel: (-2,0)), "short")

  draw("mypot.wiber")
  to((rel: (1,0)), "short", node-right: "o")
  to((rel: (0,-2)), l: $v_"RIF" (t)$, "open", node-right: "o", invert: true)
  to((rel: (-2,0)), "short", node-right: "*")
})