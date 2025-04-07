#import "@preview/cetz:0.3.4"
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
          elements.push((name:"point", point: drawPoint))
        } else if line.contains(regex("node\[([0-9A-Za-z_ ]+),?\ ?(?:xscale=)?(-?\d)?,?\ ?(?:yscale=)?(-?\d)?,?\ ?(?:anchor=)?(.*)?\]\ ?\(?([0-9A-Za-z_]*)\)?\ ?\{([^,]*)\}")){
            let (type,xscale,yscale,anchor,component-name,caption) = line.match(regex("node\[([0-9A-Za-z_ ]+),?\ ?(?:xscale=)?(-?\d)?,?\ ?(?:yscale=)?(-?\d)?,?\ ?(?:anchor=)?([^,]*)?\ ?,?.*\]\ ?\(?([0-9A-Za-z_]*)\)?\ ?\{([^,]*)\}")).captures

            let non_inv_input_up = line.match(regex("noinv input up")) != none

            let show_voltage = line.match(regex("show voltage")) != none

            
            elements.push((name: "node",type:type, xscale:xscale,yscale:yscale, component-name: component-name, anchor:anchor,caption:eval(caption), non_inv_input_up: non_inv_input_up,
            show_voltage: show_voltage));
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
            
            elements.push((name: name,l-modifier: l-modifier, label: eval(label), flow: eval(flow),flow-config: flow-config,node-right:node-right,node-left:node-left, coordinate-name: coordinate-name, dest-point: dest-point, voltage: eval(voltage),invert:invert));
        }
      }
    }
    elements
}


#let draw-circuit(scaleFactor, elements, padding) =  {
  cetz.canvas(length: 1cm, padding: padding, {
    import cetz.draw: *
    scale(scaleFactor)
    get-ctx(ctx => {
      let start-point = none
      for element in elements{
        if (element.name == "point"){
          start-point = element.point
        } 
        else if (element.name == "point2"){
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
            if (element.node-left == "*"){
              node(st)
            }
            if (element.node-right == "*"){
              node(en)
            }
            if (element.node-left == "o"){
              node-empty(st)
            }
            if (element.node-right == "o"){
              node-empty(en)
            }
          })
          if (element.coordinate-name != none){
            get-ctx(ctx => {
              let (ctx, en) = cetz.coordinate.resolve(ctx, end)
              cetz.draw.anchor(element.coordinate-name, en) 
           })
          }
        }
      }
    })
  })
}

#let cyrcuits(scale:1, doc, text-size:none, font:"libertinus serif", padding: 0) = [
  #show raw.where(lang: "circuitkz") : it => {
    set text(size: text-size) if text-size != none
    set text(font: font)
    let elements = parse-circuit(it)
    draw-circuit(scale, elements, padding)
  }
  #doc
]

#let draw(start) = {
  cetz.draw.get-ctx(ctx => {
    let (ctx, st) = cetz.coordinate.resolve(ctx, start)
    cetz.draw.move-to(st)
  })
}


#let to(end, component, f: none, l: none, coordinate: none, node-right: none, node-left: none, invert: false, l-modifier: none) = {
  cetz.draw.get-ctx(ctx => {
    let st
    let en
    (ctx, st, en) = cetz.coordinate.resolve(ctx, (), end)
    components.at(component)(st, en, 
      (name: component,
        l-modifier: l-modifier,
        label: l,
        flow: f,
        flow-config: ">_",
        coordinate-name: "aux1",
        voltage: none,
        node-anchor: none,
        node: none,
        invert: invert
      )
    )
    if (node-left == "*"){
      node(st)
    }
    if (node-right == "*"){
      node(en)
    }
    if (node-left == "o"){
      node-empty(st)
    }
    if (node-right == "o"){
      node-empty(en)
    }
    cetz.draw.move-to(en)
      if (coordinate != none){
        cetz.draw.anchor(coordinate, en)
      }
  })
}

#let node(component, start: (), show-voltage: false, name:none, l: none, anchor: none, non_inv_input_up: false) = {
  cetz.draw.get-ctx(ctx => {
    let (ctx, st) = cetz.coordinate.resolve(ctx, start)
    nodes.at(component)(st, 
      ( type: component,
        xscale: none,
        yscale: none,
        component-name: name,
        anchor: anchor,
        caption: l,
        non_inv_input_up: non_inv_input_up,
        show_voltage: show-voltage,
      )
    )
    if (name!=none){
      cetz.draw.move-to(name+ ".end")
    }
  })
}

#let padding-state = state("cyrcuits-padding", 0)
#let font-size-state = state("cyrcuits-font-size", none)
#let scale-state = state("cyrcuits-scale", none)

#let cyrcuits2(scale: none, font-size: none, padding: none, elements ) = {
  context{
    let scale-to-use = scale-state.get()
    if (scale != none){
      scale-to-use = scale
    }
    let font-size-to-use = font-size-state.get()
    if (font-size != none){
      font-size-to-use = font-size
    }
    let pad-to-use = padding-state.get()
    if (padding != none){
      pad-to-use = padding
    }
    figure()[
      #set text(size: font-size-to-use) if font-size-to-use != none
      #if (scale-to-use!=none){
        set text(size: 0.8em)
        cetz.canvas(padding: pad-to-use, { cetz.draw.scale(scale-to-use)} + elements)
      } else{
        set text(size: 0.8em)
        cetz.canvas(padding: pad-to-use, elements)
      }
    ]
  }
}

#let configure-cyrcuits(scale: none, font-size: none, padding: none) = {
  scale-state.update(x => scale)
  font-size-state.update(x => font-size)
  padding-state.update(x => padding)
}

#let ladder-power-bars(width: 9, height: 10) = {
  draw((0,0))
  to((rel: (0,-height)), "short")
  draw((width,0))
  to((rel: (0,-height)), "short")
}
