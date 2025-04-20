(:query : regroup the album by sereis and count the number of albums for each series:)

for $serie in distinct-values(doc("./albums.xml")//album/@serie)
(:we first fetch all albums :)
(:then we match only the albums for that series :)
let $albumsForThisSeries :=doc("./albums.xml")//album/[@serie =$serie]

let $count := count(doc("./albums.xml")//album[@serie = $serie])
return <serie nom="{$serie}" nombreAlbums="{$count}">
{$albumsForThisSeries}
</serie>

