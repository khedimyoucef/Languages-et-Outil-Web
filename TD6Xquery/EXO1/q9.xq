for $auteur in distinct-values(doc("./albums.xml")//auteur)
let $series := distinct-values(doc("./albums.xml")//album[auteur = $auteur]/@serie)
where count($series) > 1
return <auteur nom="{$auteur}" series="{string-join($series, ', ')}"/>

