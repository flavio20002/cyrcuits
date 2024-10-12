#import "@preview/cetz:0.2.2"
#import "components.typ" : *

#let parse-circuit(raw_code) = {
    let code_str = raw_code.text.replace(regex("to\ *\["),"\n to[");
    let lines = code_str.split("\n").filter(line => (line.trim().len()> 0));

    let elements = ()

    for line in lines {
        if not line.starts-with("\\begin") and not line.starts-with("\\end") {
        if line.contains(regex("\\\\draw\ ?\((\d+),(\d+)\)")){
          let drawPoint = line.match(regex("\\\\draw\ ?\((\d+),(\d+)\)")).captures.map((it) => {int(it)})
          elements.push((name:"point", point: drawPoint))
        }
        else if line.contains(regex("\\\\draw\ ?\(([0-9A-Za-z_]+)\)")){
          let drawPoint = line.match(regex("\\\\draw\ ?\(([0-9A-Za-z_]+)\)")).captures.at(0)
          elements.push((name:"point2", point: drawPoint))
        }
        else if line.contains(regex("\\\\draw\ ?\(([0-9A-Za-z_\.\ ]+)\)")){
          let drawPoint = line.match(regex("\\\\draw\ ?\(([0-9A-Za-z_\.\ ]+)\)")).captures.at(0)
          elements.push((name:"point3", point: drawPoint))
        }
        else if line.contains("node[shape=ground]") {
            // Parsing nodo di massa
            let coords =  ((0,1),(0,1));
            elements.push(("ground", coords));
        } else if line.contains(regex("node\[([0-9A-Za-z_]+),\ ?(?:xscale=)?(-?\d),\ ?(?:yscale=)?(-?\d)\]\ ?\(([0-9A-Za-z_]+)\)")){
            let (type,xscale,yscale,component-name) = line.match(regex("node\[([0-9A-Za-z_]+),\ ?(?:xscale=)?(-?\d),\ ?(?:yscale=)?(-?\d)\]\ ?\(([0-9A-Za-z_]+)\)")).captures
            elements.push((name: "node",type:type, xscale:xscale,yscale:yscale, component-name: component-name));
        }
        else if line.contains("to") {
            // Parsing di elementi come resistori, sorgenti, ecc.

            let name = ""
            let l-modifier = ""
            let label = ""
            let voltage = ""
            let flow = ""
            let node-right = none
            let node-left = none
            let coordinate-name = none
            let node-anchor = none
            let node = none
            let invert = false
            
            if line.contains(regex("to\[([0-9A-Za-z_]+)=([^,\]]*)")){
              (name,label) = line.match(regex("to\[([0-9A-Za-z_]+)=([^,\]]*)")).captures
            }
            else{
              name = line.match(regex("to\[([0-9A-Za-z_]+)")).captures.at(0)
            }

            if line.contains(regex("f(?:>_)?=([^,\]]*)")){
              flow = line.match(regex("f(?:>_)?=([^,\]]*)")).captures.at(0)
            }

            if line.contains(regex("v(?:\^)?=([^,\]]*)")){
              voltage = line.match(regex("v(?:\^)?=([^,\]]*)")).captures.at(0)
            }

            if line.contains(regex("l(_?)=([^,\]]*)?")){
              (l-modifier,label) = line.match(regex("l(_?)=([^,\]]*)?")).captures
            }

            if line.contains(regex("(,\s*\-[\*o])")){
              node-right = line.match(regex(",\s*\-([\*o]?)")).captures.at(0)
            }

            if line.contains(regex("(,\s*[\*o]\-)")){
              node-left = line.match(regex(",\s*([\*o])\-")).captures.at(0)
            }

            if line.contains(regex("(,\s*[\*o]\-*[\*o])")){
              node-left = line.match(regex("([\*o])\-")).captures.at(0)
               node-right = line.match(regex("\-([\*o]?)")).captures.at(0)
            }
            
            if line.contains(regex("coordinate\ ?\(([0-9A-Za-z_]+)")){
               coordinate-name = line.match(regex("coordinate\ ?\(([0-9A-Za-z_]+)")).captures.at(0)
            }

            if line.contains(regex("node\[anchor=([0-9A-Za-z]+)\]\{([^,\}]+)\}")){
              (node-anchor,node)= line.match(regex("node\[anchor=([0-9A-Za-z]+)\]\{([^,\}]+)\}")).captures
            }

            if line.contains(regex(",\s*invert")){
               invert = true
            }
            
            let dest-point = line.match(regex("\+\+\s*\((-?\d+\.?\d?),(-?\d+\.?\d?)\)")).captures.map((it) => {float(it)})
            
            elements.push((name: name,l-modifier: l-modifier, label: label,flow: flow,node-right:node-right,node-left:node-left, coordinate-name: coordinate-name, dest-point: dest-point, voltage: voltage,node-anchor:node-anchor,node:node,invert:invert));
        }
      }
    }
    elements
}


#let draw-circuit(scaleFactor, raw_code) =  {
  let elements = parse-circuit(raw_code)
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    scale(scaleFactor)
    get-ctx(ctx => {
      let start-point = none
      let coordinates = ("origin" : (0,0))
      for element in elements{
        if (element.name == "point"){
          start-point = element.point
        } 
        else if (element.name == "point2"){
          start-point = coordinates.at(element.point)
        }
        else if (element.name == "point3"){
          start-point = element.point
        }
        else if (element.name == "node"){
          let (ctx, start) = cetz.coordinate.resolve(ctx,start-point)
          if (element.type == "spdt"){
            spdt(start,xscale:element.xscale, yscale:element.yscale,name: element.component-name)
          } 
        }
        else {
          let (ctx, start, end) = cetz.coordinate.resolve(ctx,start-point, (rel: element.dest-point,to: start-point))
          start-point = end
          if (element.name == "R"){
            R(start, end, l-modifier: element.l-modifier, label: element.label, flow: element.flow,voltage: element.voltage)
          } else  if (element.name == "battery1"){
            battery1(start, end,l-modifier: element.l-modifier, label: element.label,flow: element.flow,invert:element.invert)
          } else  if (element.name == "short"){
            short(start, end,l-modifier: element.l-modifier, label: element.label)
          } 
          else  if (element.name == "open"){
            open(start, end,l-modifier: element.l-modifier, label: element.label)
          } else  if (element.name == "nos"){
            nos(start, end, l-modifier: element.l-modifier, label: element.label,flow: element.flow)
          } else  if (element.name == "ospst"){
            ospst(start, end, l-modifier: element.l-modifier, label: element.label)
          } else  if (element.name == "C"){
            C(start, end, l-modifier: element.l-modifier, label: element.label, flow: element.flow, voltage: element.voltage)
          } else  if (element.name == "L"){
            L(start, end, l-modifier: element.l-modifier, label: element.label, flow: element.flow, voltage: element.voltage)
          }

          if (element.node-left == "*"){
            node(start)
          }

          if (element.node-right == "*"){
            node(end)
          }

          if (element.node-left == "o"){
            node-empty(start)
          }

          if (element.node-right == "o"){
            node-empty(end)
          }

          if (element.node != none){
            node-content(end,element.node,element.node-anchor)
          }
          
          if (element.coordinate-name != none){
            let (ctx, coordinate) = cetz.coordinate.resolve(ctx,())
            coordinates.insert(element.coordinate-name, coordinate)
          }
        }
      }
    })
  })
}

#let cyrcuits(scale:1, doc) = [
  #show raw.where(lang: "circuitkz") : it => [
    #draw-circuit(scale, it)
  ]
  #doc
]
