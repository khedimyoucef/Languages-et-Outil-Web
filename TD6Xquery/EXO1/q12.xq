(: 12. decalre and invoke a function that takes and author as a parameter and returns the most ancient album :)
(:NOTE : the return type of a function must be specified even though it is specified in the return statment:)
(:COMPLEX types are defined as element(myComplexType):)
declare function local:albums-plus-ancien($auteur as xs:string) as element(album)* {
  let $albums := doc("./albums.xml")//album[auteur = $auteur]
  let $mostAncientYear := min($albums/date/annee/xs:integer(.))
  (: the dot (.) is to match the current element's value :)
  return $albums[date/annee = $mostAncientYear]
};

local:albums-plus-ancien("Uderzo")

