#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  to((rel: (0,2)), "open", l: $v_i (t)$)
  to((rel: (2,0)), "R", node-left: "o", node-right: "*", coordinate: "a", l: $R$)
  to((rel: (0,-2)), "L", l: $L$, coordinate: "b")
  to((rel: (-2,0)), "short", node-left: "*", node-right: "o")
  draw("a")
  to((rel: (2,0)), "short", node-right: "o")
  to((rel: (0,-2)), "open", l: $v_o (t)$, l-modifier: "", invert: true)
  to((rel: (-2,0)), "short", node-left: "o")
})
