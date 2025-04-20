let $years := distinct-values(doc("./albums.xml")//annee)
let $year-counts :=
  for $year in $years
  let $count := count(doc("./albums.xml")//album[date/annee = $year])
  return <year val="{$year}" count="{$count}"/>
let $max := max($year-counts/@count/xs:integer(.))
return $year-counts[@count = $max]

