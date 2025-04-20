for $album in doc("./albums.xml")//album
where xs:integer($album/date/annee) > 1970
return $album

