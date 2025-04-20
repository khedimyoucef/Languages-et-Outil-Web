(:4. Le nom du metteur en scène du film Vertigo :)
(:assuming the name of the MES persons is in another document which is Artistes.xml:)

let $docFilms := doc("./Films.xml")
let $docArtistes := doc("./Artistes.xml")

(: Match the film "Vertigo" in the Films.xml file :)
let $film := $docFilms/FILMS/FILM[TITRE = "Vertigo"]
(: Retrieve the idref of the director (MES) :)
let $idref := $film/MES/@idref
(: Find the director in Artistes.xml using the idref :)
let $director := $docArtistes/ARTISTES/ARTISTE[@id = $idref]

(: Return the director's name :)
return 
<REALISATEUR>
  <PRENOM>{ $director/ARTPNOM/text() }</PRENOM>
  <NOM>{ $director/ARTNOM/text() }</NOM>
</REALISATEUR>


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
