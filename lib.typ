#import "@preview/cetz:0.2.2"
#import "components.typ" : *

#let parse-circuit(raw_code) = {
    let code_str = raw_code.text;
    let lines = code_str.split("\n").filter(line => (line.len()> 0));

    let elements = ()

    for line in lines {
        if not line.starts-with("\\begin") and not line.starts-with("\\end") {
        if line.contains(regex("\\\\draw \((\d+),(\d+)\)")){
          let drawPoint = raw_code.text.match(regex("\\\\draw \((\d+),(\d+)\)")).captures.map((it) => {int(it)})
          elements.push((name:"point", point: drawPoint))
        }
        else if line.contains(regex("\\\\draw \(([0-9A-Za-z_]+)\)")){
          let drawPoint = raw_code.text.match(regex("\\\\draw \(([0-9A-Za-z_]+)\)")).captures.at(0)
          elements.push((name:"point2", point: drawPoint))
        }
        else if line.contains("node[shape=ground]") {
            // Parsing nodo di massa
            let coords =  ((0,1),(0,1));
            elements.push(("ground", coords));
        } else if line.contains("to") {
            // Parsing di elementi come resistori, sorgenti, ecc.

            let name = ""
            let l-modifier = ""
            let label = ""
            let voltage = ""
            let flow = ""
            let node-right = none
            let node-left = none
            let coordinate-name = none
            
            if line.contains(regex("to\[([0-9A-Za-z_]+)=([^,]*)")){
              (name,label) = line.match(regex("to\[([0-9A-Za-z_]+)=([^,]*)")).captures
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

            if line.contains(regex("(,\-\*)")){
              node-right = line.match(regex("(,\-\*)")).captures.at(0)
            }

            if line.contains(regex("(,\*\-)")){
              node-left = line.match(regex("(,\*\-)")).captures.at(0)
            }
            
            if line.contains(regex("coordinate \(([0-9A-Za-z_]+)")){
               coordinate-name = line.match(regex("coordinate \(([0-9A-Za-z_]+)")).captures.at(0)
            }
            
            let dest-point = line.match(regex("\+\+\s*\((-?\d+),(-?\d+)\)")).captures.map((it) => {int(it)})
            
            elements.push((name: name,l-modifier: l-modifier, label: label,flow: flow,node-right:node-right,node-left:node-left, coordinate-name: coordinate-name, dest-point: dest-point, voltage: voltage));
        }
      }
    }
    elements
}


#let draw-circuit(scale, raw_code) =  {
  let elements = parse-circuit(raw_code)
  cetz.canvas(length: 1cm * scale, {
    import cetz.draw: *
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
        else {
          let (ctx, start, end) = cetz.coordinate.resolve(ctx,start-point, (rel: element.dest-point,to: start-point))
          start-point = end
          if (element.name == "R"){
            R(start, end, l-modifier: element.l-modifier, label: element.label, flow: element.flow,voltage: element.voltage)
          } else  if (element.name == "battery1"){
            battery1(start, end,l-modifier: element.l-modifier, label: element.label)
          } else  if (element.name == "short"){
            short(start, end,l-modifier: element.l-modifier, label: element.label)
          } else  if (element.name == "nos"){
            nos(start, end, l-modifier: element.l-modifier, label: element.label)
          } else  if (element.name == "C"){
            C(start, end, l-modifier: element.l-modifier, label: element.label, flow: element.flow, voltage: element.voltage)
          } else  if (element.name == "L"){
            L(start, end, l-modifier: element.l-modifier, label: element.label, flow: element.flow, voltage: element.voltage)
          }

          if (element.node-left != none){
            node(start)
          }

          if (element.node-right != none){
            node(end)
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
    #set text(scale * 1em)
    #draw-circuit(scale, it)
  ]
  #doc
]
