#import "@preview/cetz:0.3.4"

#let anchors(anchors) = {
  for (k, v) in anchors {
    cetz.draw.anchor(k, v)
  }
}

#let component-content(start,end, l-modifier, label, angle,pad: 0.5) = {
  let center-point = (start,50%,end)
  let content-angle = angle
  let pad-angle = 90deg
  let padding = -1*pad
  let anchor = "east"
  if (angle == 0deg or angle == 180deg or angle == 90deg or angle == -90deg){
    content-angle = 0deg
  }

  if (angle == -90deg){
    anchor = "west"
    if (l-modifier != "" and l-modifier != none){
      padding = pad
      anchor = "east"
    }
  } else if (angle == 0deg){ 
    anchor = "south"
    if (l-modifier != "" and l-modifier != none){
      padding = pad
      anchor = "north"
    }
  } else if (angle == 180deg){ 
    anchor = "south"
    pad-angle = -90deg
    if (l-modifier != "" and l-modifier != none){
      padding = pad
      anchor = "north"
    }
  
  }
  else {
    anchor = "east"
    if (l-modifier != "" and l-modifier != none){
      padding = pad
      anchor = "west"
    }
  }
  cetz.draw.content((a: center-point, b: start, number: padding, angle: pad-angle), angle:content-angle, text(label), anchor: anchor)
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
  if (flow-config.contains("<")){
    cetz.draw.line(center-point-c, center-point-b, mark: (end: ">"), name: "line")
  }
  else{
  cetz.draw.line(center-point-b, center-point-c, mark: (end: ">"), name: "line")
  }
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
  cetz.draw.content((a: center-point, b: center-point-b, number: distance, angle: 90deg), angle:content-angle, text(flow), anchor: anchor)
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
  cetz.draw.content((a: center-point, b: center-point-b2, number: padding/2, angle: 90deg), angle:content-angle, text(voltage), anchor: anchor)
}

#let R(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad: 0.4)
  }
  if (element.flow != none){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != none){
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
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad: 0.4)
  }
  if (element.flow != none){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != none){
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
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.75)
  }
  if (element.flow != none){
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
      cetz.draw.line((rel: (0, -0.5)), (rel: (0, 1)),)
      cetz.draw.line((rel: (0.25, -0.25)), (rel: (0, -0.5)),) 
    }
    else{
      cetz.draw.line((rel: (0, -0.25)), (rel: (0, 0.5)),)
      cetz.draw.line((rel: (0.25, 0.25)), (rel: (0, -1)),)
    }
    cetz.draw.line(
      (rel: (0.25+(total-length - component-length)/2, 0), to: start),
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
  })
}

#let sV(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.75)
  }
  if (element.flow != none){
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
    cetz.draw.circle((rel: (0.5, 0)), radius: 0.5, stroke: black)
    let start-sin = (rel: (1,-0.22), to: start)
    cetz.draw.catmull((rel: (0, 0), to: start-sin), (rel: (-0.1, 0.15), to: start-sin), (rel: (0.1, 0.3), to: start-sin), (rel: (0, 0.45), to: start-sin), tension: .5)
    cetz.draw.line(
      (rel: (1+(total-length - component-length)/2, 0), to: start),
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
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.75)
  }
  if (element.flow != none){
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
  if (element.flow != none){
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

#let open(start, end, element) = {
  cetz.draw.set-style(mark: (fill: black))
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle, pad:0.25)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0.5
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    if (element.invert){
      cetz.draw.line(
        (rel: (angle:0, radius: (total-length - component-length) + 0.25), to: start),
        (rel: (-total-length + component-length, 0)),
        fill: none,
        mark: (end: ">")
      )
    }
    else{
    cetz.draw.line(
      (rel: (angle:0, radius: 0.25), to: start),
      (rel: ((total-length - component-length), 0)),
      fill: none,
      mark: (end: ">")
    )
}
  })
}

#let nos(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.5)
  }
  if (element.flow != none){
    component-flow(start,end,angle,element.flow)
  }
  cetz.draw.group(name: element.name, ctx => {
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

#let ospst(start, end, element) = {
  cetz.draw.set-style(mark: (fill: black))
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.5)
  }
  cetz.draw.group(name: element.name, ctx => {
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
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.7)
  }
  if (element.flow != none){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != none){
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
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.4)
  }
  if (element.flow != none){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != none){
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

#let led(start, end, element) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  if (element.label != none){
    component-content(start,end, element.l-modifier, element.label, angle,pad:0.5)
  }
  if (element.flow != none){
    component-flow(start,end,angle, element.flow, flow-config: element.flow-config)
  }
  if (element.voltage != none){
    component-voltage(start,end,angle,element.voltage,padding:1)
  }
  cetz.draw.group(name: element.name, ctx => {
    cetz.draw.rotate(angle, origin: start)
    let component-length = 0
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
      cetz.draw.line(
        start,
        (rel: ((total-length - component-length)/2, 0)),
      )
      cetz.draw.polygon((), 3, angle: 0deg, radius: 0.25, fill:black, name: "triangle")
      cetz.draw.line(
        (rel: (component-length+(total-length - component-length)/2, 0), to: start),
        (rel: ((total-length - component-length)/2, 0)),
      )
      cetz.draw.line((rel: (0, -0.25), to: "triangle.east"),
        (rel: (0, .5)),
      )
      cetz.draw.line((rel: (-0.25, 0.25), to: "triangle.east"),(rel: (0.2, 0.2)), stroke: 0.5pt, mark: (scale: 0.5, end: ">"))
      cetz.draw.line((rel: (-0.1, 0.25), to: "triangle.east"),(rel: (0.2, 0.2)), stroke: 0.5pt, mark: (scale: 0.5, end: ">"))
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
  cetz.draw.content((rel: (angle: angle, radius: 0.25), to: start),text(node),anchor: node-anchor)
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
  if (element.non_inv_input_up){
    if (element.anchor == "-") {
      in-point = (rel: (1.3, 0.5),to: start)
    }
    if (element.anchor == "+") {
      in-point = (rel: (1.3, -0.5),to: start)
    }
  }
  else{
    if (element.anchor == "+") {
      in-point = (rel: (1.3, 0.5),to: start)
    }
    if (element.anchor == "-") {
      in-point = (rel: (1.3, -0.5),to: start)
    } 
  }
  cetz.draw.group(name: element.component-name, ctx => {
    cetz.draw.line((rel: (-1.3,0.5),to: in-point), (rel:(0.5,0)))
    cetz.draw.line((rel: (-1.3,-0.5),to: in-point), (rel:(0.5,-0)))
    cetz.draw.line((rel: (0.8,0),to: in-point), (rel:(0.5,0)))
    cetz.draw.line(
      (rel: (0.8,0),to: in-point),
      (rel: (-1.6, -1)),
      (rel: (0, 2)),
      close: true
    )
    if (element.non_inv_input_up){
    cetz.draw.content((rel:(-0.55, 0.5),to: in-point), text(size: 1.25em, [+]))
    cetz.draw.content((rel:(-0.55, -0.5),to: in-point), text(size: 1.25em, [--]))
    }
    else{
      cetz.draw.content((rel:(-0.55, 0.5),to: in-point), text(size: 1.25em, [--]))
      cetz.draw.content((rel:(-0.55, -0.5),to: in-point), text(size: 1.25em, [+]))
    }
    anchors((
      "in1": (rel:(-1.3, 0.5), to:in-point),
      "in2": (rel:(-1.3, -0.5), to:in-point),
      "out": (rel:(1.3, 0), to:in-point),
      "vcc1": (rel:(0, 0.5), to:in-point),
      "vcc2": (rel:(0, -0.5), to:in-point),
      "end": (rel:(1.3, 0), to:in-point),
    ))
  })
}

#let npn(start,element) = {
  cetz.draw.set-style(mark: (fill: black))
  let in-point = start
  cetz.draw.group(name: element.component-name, ctx => {
    cetz.draw.line((rel: (0,0),to: in-point), (rel:(0.5,0)))
    cetz.draw.line((rel: (0.5,-0.5),to: in-point), (rel:(0,1)),stroke: 2pt)
    cetz.draw.line((rel: (0.5,0.25),to: in-point), (rel:(0.5,0.25)), (rel:(0,0.5)))
    cetz.draw.line((rel: (0.5,-0.25),to: in-point), (rel:(0.5,-0.25)), (rel:(0,-0.5)))
    cetz.draw.line((rel: (0.5,-0.25),to: in-point), (rel:(0.5,-0.25)), mark: (end: ">", offset: 0.1))
    if (element.show_voltage){
      cetz.draw.bezier( (rel:(1.25, -1), to:in-point),  (rel:(1.25, 1), to:in-point),  (rel:(2, 0), to:in-point), mark: (end: ">"), )
      cetz.draw.content((rel:(1.75, 0), to:in-point), angle:0deg, text($V_"CE"$), anchor: "west")

      cetz.draw.bezier((rel:(0.75, -1.25), to:in-point),  (rel:(0, -0.25), to:in-point),  (rel:(0, -1), to:in-point), mark: (end: ">"), )
      cetz.draw.content((rel:(0.125, -1), to:in-point), angle:0deg, text($V_"BE"$), anchor: "north-east")
    }
    anchors((
      "B": (rel:(0, 0), to:in-point),
      "C": (rel:(1, 1), to:in-point),
      "E": (rel:(1, -1), to:in-point),
      "end": (rel:(1, -1), to:in-point),
    ))
  })
}


#let abovenode(start,element) = {
  let in-point = start
   cetz.draw.content((rel:(0, 0.25),to: start), text(size: 0.75em, element.caption), anchor: "south")
  anchors((
    "end": start,
  ))
}

#let belownode(start,element) = {
  let in-point = start
   cetz.draw.content((rel:(0, -0.25),to: start), text(size: 0.75em, element.caption), anchor: "north")
  anchors((
    "end": start,
  ))
}

#let rightnode(start,element) = {
  let in-point = start
   cetz.draw.content((rel:(0.25, 0),to: start), text(size: 0.75em, element.caption), anchor: "west")
  anchors((
    "end": start,
  ))
}

#let leftnode(start,element) = {
  let in-point = start
   cetz.draw.content((rel:(-0.25, 0),to: start), text(size: 0.75em, element.caption), anchor: "east")
  anchors((
    "end": start,
  ))
}

#let ground(start,element) = {
  let in-point = start
  cetz.draw.line((rel:(-0.3,0), to: start), (rel:(0.3,0), to: start))
  cetz.draw.line((rel:(-0.2,-0.1), to: start), (rel:(0.2,-0.1), to: start))
  cetz.draw.line((rel:(-0.1,-0.2), to: start), (rel:(0.1,-0.2), to: start))
}

#let components = (
  "short": short,
  "open": open,
  "generic": generic,
  "sV": sV,
  "battery1": battery1,
  "isource": isource,
  "nos": nos,
  "ospst": ospst,
  "R": R,
  "C": C,
  "L": L,
  "led": led,
)

#let nodes = (
  "spdt": spdt,
  "op amp": op-amp,
  "npn": npn,
  "ground": ground,
  "above": abovenode,
  "below": belownode,
  "right": rightnode,
  "left": leftnode,
)