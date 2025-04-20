let $auteurs := distinct-values(doc("./albums.xml")//auteur)
let $result :=
  for $auteur in $auteurs
  let $count := count(doc("./albums.xml")//album[auteur = $auteur])
  return <auteur nom="{$auteur}" albums="{$count}"/>
let $max := max($result/@albums/xs:integer(.))
return $result[@albums = $max]

