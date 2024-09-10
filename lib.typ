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
            let (name,l-modifier,label,voltage,flow,node-right, node-left, coordinate-name) = line.match(regex("to\[([0-9A-Za-z_]+)(?:,l(_?)=)?([^,]*)?(?:,v\^?=)?([^,]*)?(?:,f>_=)?([^,]*)(,\-\*)?(,\*\-)?\]\s\+\+\s\(-?\d+,-?\d+\)(?: coordinate \()?([0-9A-Za-z_]+)?")).captures

            let dest-point = line.match(regex("\+\+\s\((-?\d+),(-?\d+)\)")).captures.map((it) => {int(it)})
            
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
