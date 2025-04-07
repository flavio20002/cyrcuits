#import "../../lib.typ": *

#set page(width: auto, height: auto, margin: 0.5cm)

#cyrcuits2({
  draw((0,0))
  node("above", l: $v_-$)
  to((rel: (0.5,0)), "short", node-left: "o")
  node("op amp", name: "oa", anchor: "-")

  draw("oa.in2")
  to((rel: (-0.5,0)), "short", node-right: "o")
  node("above", l: $v_+$)

  draw("oa.out")
  to((rel: (0.5,0)), "short", node-right: "o")
  node("above", l: $v_o$)
})