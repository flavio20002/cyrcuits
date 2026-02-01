#!/bin/bash

# Definizione della funzione draw-file
scriptContent=$(cat <<EOF
#set page("a3", flipped:true, margin: 0.5cm)

#let draw-file(file)={
  heading(level: 1, file)
  let text = read(file)  
  table(
    columns: (1fr,1fr),
    inset: 1cm,
    align: horizon,
    figure(include file),
    raw(text, lang: "typst")
  )
}
EOF
)

# Dichiarazione del percorso della cartella
folderPath="./"

# Elenco di tutti i file .typ nelle sottocartelle contenenti "pictures"
typFiles=$(find "$folderPath" -type f -name "*.typ" | grep '/tests/' | sort)

# Creazione dell'array per contenere i comandi draw-file
drawFileCommands=()

# Iterazione sui file .typ e creazione dei comandi draw-file
for typFile in $typFiles; do
    drawFileCommands+=("#draw-file(\"$(realpath --relative-to=. "$typFile")\")")
done

# Aggiunta dei comandi draw-file allo script
scriptContent+="\n$(IFS=$'\n'; echo "${drawFileCommands[*]}")"

# Salvataggio dello script in un file
echo -e "$scriptContent" > "showcase.typ"