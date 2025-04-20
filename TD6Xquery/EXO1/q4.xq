(:query : search for the most recent album for each series:)

(:we loop through the entire series to get their names :)
(:we use distinct to ignore duplicates:)
for $serie in distinct-values(doc("./albums.xml")//album/@serie)
(:we then fetch all the attributes serie and assign them to the variable $serie iteration by iteration:)
(:the variable serie contains only one serie at a time:)
let $albums := doc("./albums.xml")//album[@serie = $serie]
(:matching the albums for the current iteration serie:)
let $mostRecentYear := max($albums/date/annee/xs:integer(.))
(:here we calculate the max among all the albums of the current serie:)

return 

<serie nom="{$serie}">
  { $albums[date/annee = $mostRecentYear]/titre }
  {$mostRecentYear}
</serie>

