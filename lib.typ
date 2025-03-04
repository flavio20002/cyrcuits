#import "@preview/cetz:0.3.2"
#import "components.typ" : *

#let parse-circuit(raw_code) = {
    let code_str = raw_code.text.replace(regex("to\ *\["),"\n to[").replace(regex("node\ *\["),"\n node[");
    let lines = code_str.split("\n").filter(line => (line.trim().len()> 0));

    let elements = ()

    for line in lines {
        if not line.starts-with("\\begin") and not line.starts-with("\\end") {
        if line.contains(regex("\\\\draw\ ?\((-?\d+),(-?\d+)\)")){
          let drawPoint = line.match(regex("\\\\draw\ ?\((-?\d+),(-?\d+)\)")).captures.map((it) => {int(it)})
          elements.push((name:"point", point: drawPoint))
        }
        else if line.contains(regex("\\\\draw\ ?\(([0-9A-Za-z_]+)\)")){
          let drawPoint = line.match(regex("\\\\draw\ ?\(([0-9A-Za-z_]+)\)")).captures.at(0)
          elements.push((name:"point2", point: drawPoint))
        }
        else if line.contains(regex("\\\\draw\ ?\(([0-9A-Za-z_\.\ ]+)\)")){
          let drawPoint = line.match(regex("\\\\draw\ ?\(([0-9A-Za-z_\.\ ]+)\)")).captures.at(0)
          elements.push((name:"point3", point: drawPoint))
        } else if line.contains(regex("node\[([0-9A-Za-z_ ]+),?\ ?(?:xscale=)?(-?\d)?,?\ ?(?:yscale=)?(-?\d)?,?\ ?(?:anchor=)?(.*)?\]\ ?\(?([0-9A-Za-z_]*)\)?\ ?\{([^,]*)\}")){
            let (type,xscale,yscale,anchor,component-name,caption) = line.match(regex("node\[([0-9A-Za-z_ ]+),?\ ?(?:xscale=)?(-?\d)?,?\ ?(?:yscale=)?(-?\d)?,?\ ?(?:anchor=)?(.*)?\]\ ?\(?([0-9A-Za-z_]*)\)?\ ?\{([^,]*)\}")).captures
            elements.push((name: "node",type:type, xscale:xscale,yscale:yscale, component-name: component-name, anchor:anchor,caption:caption));
        } else if line.contains(regex("to\ *\[")) {
            // Parsing di elementi come resistori, sorgenti, ecc.
            let name = ""
            let l-modifier = ""
            let label = ""
            let voltage = ""
            let flow = ""
            let flow-config = ""
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

            if line.contains(regex("f[>_<^]*=([^,\]]*)")){
              (flow-config, flow) = line.match(regex("f([>_<^]*)=([^,\]]*)")).captures
            }

            if line.contains(regex("v[>_<^]*=([^,\]]*)")){
              voltage = line.match(regex("v[>_<^]*=([^,\]]*)")).captures.at(0)
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

            if line.contains(regex("node\[anchor=([0-9A-Za-z-]+)\]\{([^,\}]+)\}")){
              (node-anchor,node)= line.match(regex("node\[anchor=([0-9A-Za-z-]+)\]\{([^,\}]+)\}")).captures
            }

            if line.contains(regex(",\s*invert")){
               invert = true
            }
            
            let dest-point = line.match(regex("\+\+\s*\((-?\d+\.?\d*),(-?\d+\.?\d*)\)")).captures.map((it) => {float(it)})
            
            elements.push((name: name,l-modifier: l-modifier, label: label,flow: flow,flow-config: flow-config,node-right:node-right,node-left:node-left, coordinate-name: coordinate-name, dest-point: dest-point, voltage: voltage,node-anchor:node-anchor,node:node,invert:invert));
        }
      }
    }
    elements
}


#let draw-circuit(scaleFactor, elements) =  {
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
          get-ctx(ctx => {
            let (ctx, st) = cetz.coordinate.resolve(ctx, start-point)
            nodes.at(element.type)(st, element)
          })        
        }
        else {
          //let (ctx, start, end) = cetz.coordinate.resolve(ctx,start-point, (rel: element.dest-point,to: start-point))
          let start = start-point
          let end = (rel: element.dest-point,to: start-point)
          start-point = end
          get-ctx(ctx => {
            let (ctx, st, en) = cetz.coordinate.resolve(ctx, start, end)
            components.at(element.name)(st, en, element)
          })
          if (element.node-left == "*"){
            get-ctx(ctx => {
              let (ctx, st) = cetz.coordinate.resolve(ctx, start)
              node(start)
            })
          }

          if (element.node-right == "*"){
            get-ctx(ctx => {
              let (ctx, en) = cetz.coordinate.resolve(ctx, end)
              node(en)
            })
          }

          if (element.node-left == "o"){
            get-ctx(ctx => {
              let (ctx, st) = cetz.coordinate.resolve(ctx, start)
              node-empty(start)
            })
          }

          if (element.node-right == "o"){
            get-ctx(ctx => {
              let (ctx, en) = cetz.coordinate.resolve(ctx, end)
              node-empty(en)
            })
          }

          if (element.node != none){
            get-ctx(ctx => {
              let (ctx, en) = cetz.coordinate.resolve(ctx, end)
              node-content(en,element.node,element.node-anchor)
            })
          }
          
          if (element.coordinate-name != none){
            coordinates.insert(element.coordinate-name, end)
          }
        }
      }
    })
  })
}

#let cyrcuits(scale:1, doc, text-size:none, font:"libertinus serif") = [
  #show raw.where(lang: "circuitkz") : it => {
    set text(size: text-size) if text-size != none
    set text(font: font)
    let elements = parse-circuit(it)
    draw-circuit(scale, elements)
  }
  #doc
]
