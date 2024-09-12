#import "@preview/cetz:0.2.2"

#import cetz.draw: *

#let anchors(anchors) = {
  for (k, v) in anchors {
    anchor(k, v)
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
  content((a: center-point, b: start, number: padding, angle: 90deg), angle:content-angle, text(size: 1.7em,eval(label)), anchor: anchor)
}

#let component-flow(start,end,angle, flow) = {
  let center-point-a = (start,10%,end)
  let center-point-b = (a: center-point-a, b: start, number: 0.4, angle: 90deg)
  let center-point-c = (rel: (angle,0.75), to: center-point-b)
  let center-point = (center-point-b,50%, center-point-c)
  let content-angle = angle
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  set-style(mark: (fill: black))
  line(center-point-b, center-point-c, mark: (end: ">"), name: "line")
  let anchor = "east"
  if (angle == 0deg or angle == 90deg or angle == -90deg){
    content-angle = 0deg
  }

  if (angle == -90deg){
    anchor = "east"
  } else {
    anchor = "west"
  }
  content((a: center-point, b: center-point-b, number: 0.2, angle: 90deg), angle:content-angle, text(size: 1.4em,eval(flow)), anchor: anchor)
}

#let component-voltage(start,end,angle, flow,padding:1.5) = {
  let center-point-a = (start,50%,end)
  let center-point-a1 = (start,20%,end)
  let center-point-a2 = (start,80%,end)
  let center-point-b = (a: center-point-a, b: start, number: -1*padding, angle: 90deg)
  let center-point-b1 = (a: center-point-a1, b: start, number: -1*(padding - 0.25)/2, angle: 90deg)
  let center-point-b2 = (a: center-point-a2, b: start, number: -1*(padding - 0.25)/2, angle: 90deg)
  let center-point-c = (rel: (angle,-1), to: center-point-b)
  let center-point-d = (rel: (angle,1), to: center-point-b)
  let center-point = (center-point-b1,50%, center-point-b2)
  let content-angle = angle
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  set-style(mark: (fill: black))
  bezier(center-point-b2, center-point-b1, center-point-b, mark: (end: ">"), )
  let anchor = "east"
  if (angle == 0deg or angle == 90deg or angle == -90deg){
    content-angle = 0deg
  }

  if (angle == -90deg){
    anchor = "west"
  } else {
    anchor = "east"
  }
  content((a: center-point, b: center-point-b2, number: padding/2, angle: 90deg), angle:content-angle, text(size: 1.4em,eval(flow)), anchor: anchor)
}

#let R(start, end, l-modifier:"", label:none, flow: "", name: none, voltage: "", ..style) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  component-content(start,end, l-modifier, label, angle)
  if (flow != ""){
    component-flow(start,end,angle, flow)
  }
  if (voltage != ""){
    component-voltage(start,end,angle,voltage)
  }
  group(name: name, ctx => {
    rotate(angle, origin: start)
    let component-length = 2
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    line(
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
    anchors((
      north: (0, height/2),
      south: (0, -height/2),
      label: (0, height + 0.1),
      annotation: "south"
    ))
  })
}

#let battery1(start, end, l-modifier:"", label:none, name: none, ..style) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  component-content(start,end, l-modifier, label, angle,pad:1)
  group(name: name, ctx => {
    rotate(angle, origin: start)
    let component-length = 0.25
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
    line((rel: (0, -0.3)), (rel: (0, 0.6)),)
    line((rel: (0.25, 0.3)), (rel: (0, -1.2)),)
    line(
      (rel: (0.25+(total-length - component-length)/2, 0), to: start),
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
    anchors((
      north: (0, height/2),
      south: (0, -height/2),
      label: (0, height + 0.1),
      annotation: "south"
    ))
  })
}

#let short(start, end, label:none, name: none, ..style) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  content( (a: center-point, b: start, number: -0.75, angle: 90deg), angle:content-angle, text(size: 14pt,eval(label)))
  group(name: name, ctx => {
    rotate(angle, origin: start)
    let component-length = 0
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    line(
      start,
      (rel: ((total-length - component-length), 0)),
      fill: none
    )
    anchors((
      north: (0, height/2),
      south: (0, -height/2),
      label: (0, height + 0.1),
      annotation: "south"
    ))
  })
}

#let nos(start, end, label:none, name: none, ..style) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  let center-point = (start,50%,end)
  let content-angle = angle
  if (angle == 0deg or angle == 90deg){
    content-angle = 0deg
  }
  content( (a: center-point, b: start, number: -0.75, angle: 90deg), angle:content-angle, text(size: 14pt,eval(label)))
  group(name: name, ctx => {
    rotate(angle, origin: start)
    let component-length = 0.5
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      (rel: (0.5, 0.25)),
      fill: none
    )
    line((rel: (0.5 + (total-length - component-length)/2, 0), to: start), (rel: ((total-length - component-length)/2, 0)))
    anchors((
      north: (0, height/2),
      south: (0, -height/2),
      label: (0, height + 0.1),
      annotation: "south"
    ))
  })
}

#let C(start, end, l-modifier:"", label:none, flow: "", voltage: "", name: none, ..style) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  component-content(start,end, l-modifier, label, angle,pad:1)
  if (flow != ""){
    component-flow(start,end,angle,flow)
  }
  if (voltage != ""){
    component-voltage(start,end,angle,voltage)
  }
  group(name: name, ctx => {
    rotate(angle, origin: start)
    let component-length = 0.5
    let step = 1/6
    let height = 5/14
    let sgn = -1
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    line(
      start,
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
    line((rel: (0, -0.6)), (rel: (0, 1.2)),)
    line((rel: (0.5, 0)), (rel: (0, -1.2)),)
    line(
      (rel: (0.5+(total-length - component-length)/2, 0), to: start),
      (rel: ((total-length - component-length)/2, 0)),
      fill: none
    )
    anchors((
      north: (0, height/2),
      south: (0, -height/2),
      label: (0, height + 0.1),
      annotation: "south"
    ))
  })
}

#let L(start, end, l-modifier:"", label:none, flow: "", voltage: "", name: none, ..style) = {
  let (x1,y1,..) = start
  let (x2,y2,..) = end
  let angle = calc.atan2(x2 - x1, y2 - y1)
  component-content(start,end, l-modifier, label, angle,pad:0.5)
  if (flow != ""){
    component-flow(start,end,angle,flow)
  }
  if (voltage != ""){
    component-voltage(start,end,angle,voltage,padding:1)
  }
  group(name: name, ctx => {
    rotate(angle, origin: start)
    let component-length = 1
    let radius = 0.14
    let height = 5/14
    let start-angle = 230deg
    let stop-angle = -50deg
    let total-length = calc.sqrt(calc.pow(y2 - y1,2) + calc.pow((x2 - x1),2))
    merge-path({
      line(
        start,
        (rel: ((total-length - component-length)/2, 0)),
        fill: none
      )
      arc((), start: 180deg, stop: stop-angle, radius: radius, name: "arc1")
      arc("arc1.end", start: start-angle, stop: stop-angle, radius: radius, name: "arc2")
      arc("arc2.end", start: start-angle, stop: stop-angle, radius: radius, name: "arc3")
      arc("arc3.end", start: start-angle, stop: stop-angle, radius: radius, name: "arc4")
      arc("arc4.end", start: start-angle, stop: 0deg, radius: radius, name: "arc5")
      line(
        (rel: (1+(total-length - component-length)/2, 0), to: start),
        (rel: ((total-length - component-length)/2, 0)),
        fill: none
      )
    })
    anchors((
      north: (0, height/2),
      south: (0, -height/2),
      label: (0, height + 0.1),
      annotation: "south"
    ))
  })
}

#let node(start) = {
  circle(start, radius: 0.075, stroke: black, fill: black)
}