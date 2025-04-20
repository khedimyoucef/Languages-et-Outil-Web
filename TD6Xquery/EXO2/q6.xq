(:6. Pour chaque film, l’âge de son metteur en scène lors de la sortie du film.:)

let $docFilms := doc("./Films.xml")
let $docArtistes := doc("./Artistes.xml")

(: Loop through all films :)
for $film in $docFilms/FILMS/FILM
    (: Find the director of each film by matching MES/idref with artist's id :)
    let $artist := $docArtistes/ARTISTES/ARTISTE[@id = $film/MES/@idref]
    
    (: Calculate the age of the director at the time of the film's release :)
    let $age := xs:integer($film/@annee) - xs:integer($artist/ANNEENAISS/text())
    
    (: Return the film title and the director's age at the time of release :)
    return
    <FILM>
        <TITRE>{$film/TITRE/text()}</TITRE>
        <AGEMES>{$age}</AGEMES>
    </FILM>





(:example from the Artist.xml:)
(:~ <ARTISTES>
  <ARTISTE id="6">
    <ARTNOM>Cameron</ARTNOM>
    <ARTPNOM>James</ARTPNOM>
    <ANNEENAISS>1954</ANNEENAISS>
  </ARTISTE>
  <ARTISTE id="3">
    <ARTNOM>Hitchcock</ARTNOM>
    <ARTPNOM>Alfred</ARTPNOM>
    <ANNEENAISS>1899</ANNEENAISS>
  </ARTISTE>
  <ARTISTE id="4">
    <ARTNOM>Scott</ARTNOM>
    <ARTPNOM>Ridley</ARTPNOM>
    <ANNEENAISS>1937</ANNEENAISS>
  </ARTISTE>
  <ARTISTE id="5">
    <ARTNOM>Weaver</ARTNOM>
    <ARTPNOM>Sigourney</ARTPNOM>
  </ARTISTE>
 ~:)


(:example FILM NODE:)
(:~ <FILMS>
  <FILM annee="1958">
    <TITRE>Vertigo</TITRE>
    <GENRE>Drame</GENRE>
    <PAYS>USA</PAYS>
    <MES idref="3"/>
    <ROLES>
      <ROLE>
        <PRENOM>James</PRENOM>
        <NOM>Stewart</NOM>
        <INTITULE>John Ferguson</INTITULE>
      </ROLE>
      <ROLE>
        <PRENOM>Kim</PRENOM>
        <NOM>Novak</NOM>
        <INTITULE>Madeleine Elster</INTITULE>
      </ROLE>
    </ROLES>
    <RESUME>Scottie Ferguson, ancien inspecteur de police, est sujet
au vertige depuis qu'il a vu mourir son
 coll�gue. Elster, son ami, le charge de surveiller sa femme, Madeleine, ayant des tendances
 suicidaires. Amoureux de la jeune femme Scottie ne remarque pas le pi�ge qui se trame autour
 de lui et dont il va �tre la victime... </RESUME>
  </FILM> ~:)
