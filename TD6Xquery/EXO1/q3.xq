(:listing all the authors that atlease have one participation in an allbum (one occurence):)

(: Load all authors from the XML document :)
(:in our case they're well structured:)
let $auteurs := doc("./albums.xml")//auteur

(: Iterate over distinct authors :)
for $auteur in distinct-values($auteurs)
let $count := count($auteurs[. = $auteur]) (: Count the number of albums for each author :)
where $count > 1 (: Filter authors with more than one album :)
return 
    <auteur nom="{$auteur}" albums="{$count}"/> 
(:returning the authors as attributes:)