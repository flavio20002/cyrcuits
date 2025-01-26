#import "@preview/cetz:0.3.1"

#let anchors(anchors) = {
  for (k, v) in anchors {
    cetz.draw.anchor(k, v)
  }
}

#let component-content(start,end, l-modifier, label, angle,pad: 0.5) = {
  let center-point = (start,50%,end)
  let content-angle = angle
  let padding = -1*pad
  let anchor = "east"
  if (angle == 0deg or angle == 90deg or angle == -90deg){
    content-angle = 0deg
  }

  if (angle == -90deg){
    anchor = "west"
    if (l-modifier != ""){
      padding = pad
      anchor = "east"
    }
  } else if (angle == 0deg){ 
    anchor = "south"
    if (l-modifier != ""){
      padding = pad
      anchor = "north"
    }
  }else {
    anchor = "east"
    if (l-modifier != ""){
      padding = pad
      anchor = "west"
    }
  }
  cetz.draw.content((a: center-point, b: start, number: padding, angle: 90deg), angle:content-angle, text(eval(label)), anchor: anchor)
}

#let component-flow(start,end,angle,flow,flow-config:"",center:false) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2)) - 0.7
  let angle-arrow = 90deg
  if ((angle == -90deg or angle == 90deg) and flow-config.contains("_")){
    angle-arrow = -90deg
  }
  let center-point-a-temp1 = (start,50%,end)
  let center-point-a-temp = (rel: (angle,- 1.1), to: center-point-a-temp1)
  let center-point-a
  if (center){
    center-point-a = (rel: (angle,total-length/2), to: center-point-a-temp)
  }
  else{
    center-point-a = (rel: (-angle, 0.01), to: center-point-a-temp)
  }
  let center-point-b = (a: center-point-a, b: center-point-a-temp, number: 0.3, angle: angle-arrow)
  let center-point-c = (rel: (angle,0.7), to: center-point-b)
  let center-point = (center-point-b,50%, center-point-c)
  let content-angle = angle
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  cetz.draw.set-style(mark: (fill: black))
  cetz.draw.line(center-point-b, center-point-c, mark: (end: ">"), name: "line")
  let anchor = "east"
  let distance = 0.2
  if (angle == 0deg or angle == 90deg or angle == -90deg or angle == 180deg){
    content-angle = 0deg
  }

  if (angle == -90deg){
     if (flow-config.contains("_")){
      anchor = "east"
      distance = 0.2
    }
    else{
      anchor = "west"
      distance = -0.2
    }
  } else if (angle == 0deg){
    if (flow-config.contains("_")){
      anchor = "north"
      distance = 0.3
    }
    else{
      anchor = "south"
      distance = -0.3
    }
  }  else if (angle == 180deg){
      anchor = "south"
      distance = 0.2
  } else {
    anchor = "west"
  }
  cetz.draw.content((a: center-point, b: center-point-b, number: distance, angle: 90deg), angle:content-angle, text(eval(flow)), anchor: anchor)
}

#let component-voltage(start,end,angle,voltage,padding:1.5) = {
  let center-point-a = (start,50%,end)
  let center-point-a1 = (start,20%,end)
  let center-point-a1 = (rel: (-angle,0.75), to: center-point-a)
  let center-point-a2 = (start,80%,end)
  let center-point-a2 = (rel: (angle,0.75), to: center-point-a)
  let center-point-b = (a: center-point-a, b: start, number: -1*padding, angle: 90deg)
  let center-point-b1 = (a: center-point-a1, b: start, number: -1*(padding - 0.25)/2, angle: 90deg)
  let center-point-b2 = (a: center-point-a2, b: start, number: -1*(padding - 0.25)/2, angle: 90deg)
  let center-point-c = (rel: (angle,-1), to: center-point-b)
  let center-point-d = (rel: (angle,1), to: center-point-b)
  let center-point = (center-point-b1,50%, center-point-b2)
  let content-angle = angle
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  cetz.draw.set-style(mark: (fill: black))
  cetz.draw.bezier(center-point-b2, center-point-b1, center-point-b, mark: (end: ">"), )
  let anchor = "east"
  if (angle == 0deg or angle == 90deg or angle == -90deg){
    content-angle = 0deg
  }

  if (angle == -90deg){
    anchor = "west"
  } else {
    anchor = "east"
  }
  cetz.draw.content((a: center-point, b: center-point-b2, number: padding/2, angle: 90deg), angle:content-angle, text(eval(voltage)), anchor: anchor)
}

#let R(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != ""){
    component-content(start,end, element.l-modifier, element.label, angle,pad: 0.4)
  }
  if (element.flow != ""){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != ""){
    component-voltage(start,end,angle,element.voltage)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 2
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      (rel: (0.5, 0)),
      (rel: (step/2, height/2)),
      ..for _ in range(5) {
        ((rel: (step, height * sgn)),)
        sgn *= -1
      },
      (rel: (step/2, height/2)),
      (rel: (0.5, 0)),
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
  })
}


#let generic(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != ""){
    component-content(start,end, element.l-modifier, element.label, angle,pad: 0.4)
  }
  if (element.flow != ""){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != ""){
    component-voltage(start,end,angle,element.voltage)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 2
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      (rel: (0.5, 0)),
      (rel: (0,0.2)),
      (rel: (1,0)),
      (rel: (0,-0.4)),
      (rel: (-1,0)),
      (rel: (0,0.2)),
      fill: none
    )
    cetz.draw.line(
      (rel: (1,0)),
      (rel: (0.5, 0)),
      (rel: ((total-length - component-length)/2, 0)),
    )
  })
}


#let battery1(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != ""){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.75)
  }
  if (element.flow != ""){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0.25
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
    if (element.invert){
      cetz.draw.line((rel: (0, -0.6)), (rel: (0, 1.2)),)
      cetz.draw.line((rel: (0.25, -0.3)), (rel: (0, -0.6)),) 
    }
    else{
      cetz.draw.line((rel: (0, -0.3)), (rel: (0, 0.6)),)
      cetz.draw.line((rel: (0.25, 0.3)), (rel: (0, -1.2)),)
    }
    cetz.draw.line(
      (rel: (0.25+(total-length - component-length)/2, 0), to: start),
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
  })
}

#let isource(start, end, element) = {
  cetz.draw.set-style(mark: (fill: black))
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != ""){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.75)
  }
  if (element.flow != ""){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
    if (element.invert){
     cetz.draw.line((rel: (0.9+(total-length - component-length)/2, 0), to: start),(rel: (-0.8,0)), mark: (end: ">"))
    }
    else{
     cetz.draw.line((rel: (0.1+(total-length - component-length)/2, 0), to: start),(rel: (0.8,0)), mark: (end: ">"))
    }
    cetz.draw.circle((rel: (0.5+(total-length - component-length)/2, 0), to: start), radius: 0.5,
      fill: none
    )
    cetz.draw.line(
      (rel: (component-length + (total-length - component-length)/2, 0), to: start),
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
  })
}

#let short(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  if (element.flow != ""){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config, center: true)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length), 0)),
      fill: none
    )
  })
}

#let open(start, end, l-modifier:"", label:"", name: none, ..style) = {
  cetz.draw.set-style(mark: (fill: black))
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  if (label!=""){
    component-content(start,end, l-modifier, label, angle,pad:0.25)
  }
  cetz.draw.group(name: name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0.5
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      (rel: (angle:0, radius: 0.25), to: start),
      (rel: ((total-length - component-length), 0)),
      fill: none,
      mark: (end: ">")
    )
  })
}

#let nos(start, end, l-modifier:"", label:none, name: none,flow: "", ..style) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  if (label != ""){
    component-content(start,end, l-modifier, label, angle,pad:0.5)
  }
  if (flow != ""){
    component-flow(start,end,angle, flow)
  }
  cetz.draw.group(name: name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0.5
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      (rel: (0.5, 0.25)),
      fill: none
    )
    cetz.draw.line((rel: (0.5 + (total-length - component-length)/2, 0), to: start), (rel: ((total-length - component-length)/2, 0)))
  })
}

#let ospst(start, end, l-modifier:"", label:none, name: none, ..style) = {
  cetz.draw.set-style(mark: (fill: black))
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  if (label != ""){
    component-content(start,end, l-modifier, label, angle,pad:0.5)
  }
  cetz.draw.group(name: name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0.5
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      (rel: (0.5, 0.35)),
      fill: none
    )
    cetz.draw.line((rel: (0.5 + (total-length - component-length)/2, 0), to: start), (rel: ((total-length - component-length)/2, 0)))
    cetz.draw.arc((rel: ((total-length - component-length)/2 + component-length/2, 0), to: start), radius: 0.4,start: 0deg, stop: 90deg, mark: (end: ">"))
  })
}

#let C(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != ""){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.7)
  }
  if (element.flow != ""){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != ""){
    component-voltage(start,end,angle,element.voltage)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0.4
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
    cetz.draw.line((rel: (0, -0.5)), (rel: (0, 1)),)
    cetz.draw.line((rel: (0.4, 0)), (rel: (0, -1)),)
    cetz.draw.line(
      (rel: (0.4+(total-length - component-length)/2, 0), to: start),
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
  })
}

#let L(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != ""){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.4)
  }
  if (element.flow != ""){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != ""){
    component-voltage(start,end,angle,element.voltage,padding:1)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 1
    let radius = 0.14
    let height = 5/14
    let start-angle = 230deg
    let stop-angle = -50deg
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    cetz.draw.merge-path({
      cetz.draw.line(
        start,
        (rel: ((total-length - component-length)/2, 0)),
        fill: none
      )
      cetz.draw.arc((), start: 180deg, stop: stop-angle, radius: radius, name: "arc1")
      cetz.draw.arc("arc1.end", start: start-angle, stop: stop-angle, radius: radius, name: "arc2")
      cetz.draw.arc("arc2.end", start: start-angle, stop: stop-angle, radius: radius, name: "arc3")
      cetz.draw.arc("arc3.end", start: start-angle, stop: stop-angle, radius: radius, name: "arc4")
      cetz.draw.arc("arc4.end", start: start-angle, stop: 0deg, radius: radius, name: "arc5")
      cetz.draw.line(
        (rel: (1+(total-length - component-length)/2, 0), to: start),
        (rel: ((total-length - component-length)/2, 0)),
        fill: none
      )
    })    
  })
}

#let node(start) = {
  cetz.draw.circle(start, radius: 0.075, stroke: black, fill: black)
}

#let node-empty(start) = {
  cetz.draw.on-layer(1, {
    cetz.draw.circle(start, radius: 0.075, stroke: black, fill: white)
  })
}

#let node-content(start,node,node-anchor) = {
  let angle = 90deg
  if (node-anchor.contains("north")){
    angle = -90deg
  }
  cetz.draw.content((rel: (angle: angle, radius: 0.25), to: start),text(eval(node)),anchor: node-anchor)
}

#let spdt(start,element) = {
  let in-point = (rel: (0.5, 0.25),to: start)
  let out-1-point = start
  let out-2-point = (rel: (0, 0.5),to: start)
  cetz.draw.group(name: element.component-name, ctx => {
    cetz.draw.line(
      start,
      in-point,
      fill: none
    )
    node-empty(in-point)
    node-empty(out-1-point)
    node-empty(out-2-point)
    anchors((
      "in": in-point,
      "out 1": out-1-point,
      "out 2": out-2-point,
    ))
  })
}

#let op-amp(start,element) = {
  let in-point = start
  if (element.anchor == "+") {
    in-point = (rel: (1.5, 0.4),to: start)
  }
  if (element.anchor == "-") {
    in-point = (rel: (1.5, -0.4),to: start)
  }
  cetz.draw.group(name: element.component-name, ctx => {
    cetz.draw.line((rel: (-1.5,0.4),to: in-point), (rel:(0.7,0)))
    cetz.draw.line((rel: (-1.5,-0.4),to: in-point), (rel:(0.7,-0)))
    cetz.draw.line((rel: (0.8,0),to: in-point), (rel:(0.7,0)))
    cetz.draw.line(
      (rel: (0.8,0),to: in-point),
      (rel: (-1.6, -1)),
      (rel: (0, 2)),
      close: true
    )
    cetz.draw.content((rel:(-0.55, 0.45),to: in-point), text(size: 1em, [*--*]))
    cetz.draw.content((rel:(-0.55, -0.4),to: in-point), text(size: 1em, [*+*]))
    anchors((
      "in1": (rel:(-1.5, 0.4), to:in-point),
      "in2": (rel:(-1.5, -0.4), to:in-point),
      "out": (rel:(1.5, 0), to:in-point),
      "vcc1": (rel:(0, 0.5), to:in-point),
      "vcc2": (rel:(0, -0.5), to:in-point),
    ))
  })
}

#let above(start,element) = {
  let in-point = start
   cetz.draw.content((rel:(0, 0.25),to: start), text(eval(element.caption)), anchor: "south")
}

#let below(start,element) = {
  let in-point = start
   cetz.draw.content((rel:(0, -0.25),to: start), text(eval(element.caption)), anchor: "north")
}