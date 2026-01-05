#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "battery1", l: $E$)
  to((rel: (0,2)), "R", l: $R_1$, f: $i_1$)
  to((rel: (2,0)), "short", coordinate: "aux1")
  to((rel: (0,-4)), "potentiometer", l: $R_1$, l-modifier: "_", n: "mypot")
  to((rel: (-2,0)), "short")

  draw("mypot.wiber")
  to((rel: (0,-2)), "short")
  to((rel: (-1,0)), "short", node-right: "*")


})