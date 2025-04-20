(:5. Pour chaque artiste, son nom et les titres des films qu’il a dirigés.:)

let $docFilms := doc("./Films.xml")
let $docArtistes := doc("./Artistes.xml")
(: For each artist, get the name and the titles of the films they directed :)
for $artist in $docArtistes/ARTISTES/ARTISTE
(: Find all films directed by this artist using the idref to match :)
let $films := $docFilms/FILMS/FILM[MES/@idref = $artist/@id]
(:here the for loop conatines the films template so each iteration of the artist the films change based on that artist:)
(: Return the artist's name and the titles of the films directed by them :)
return
<ARTISTE>
  <NOM>{$artist/ARTNOM/text()}</NOM>
  <PRENOM>{$artist/ARTPNOM/text()}</PRENOM>
  <FILMS>
    {
      for $film in $films
      return <TITRE>{$film/TITRE/text()}</TITRE>
    }
  </FILMS>
</ARTISTE>


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
