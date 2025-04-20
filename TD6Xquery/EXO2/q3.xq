(:query 3 : Les rôles joués par Bruce Willis sous forme d’élément rôle contenant comme sous éléments le titre du film le
nom du personnage.:)

(:almost same as previous query except we need to match higher level nodes because we can't crawl up the node tree in xq:)
(:so we have to match the FILM NODE here and update the paths accordignly :)

for $filmIterator in doc("./Films.xml")/FILMS/FILM
where ($filmIterator/ROLES/ROLE/PRENOM/text() = "Bruce") and ($filmIterator/ROLES/ROLE/NOM/text() = "Willis")
return
<ROLE>
    <TITREFILM>{$filmIterator/TITRE/text()}</TITREFILM>
    <PRENOM>{$filmIterator/ROLES/ROLE/PRENOM/text()}</PRENOM>
    <NOM>{$filmIterator/ROLES/ROLES/NOM/text()}</NOM>
    <INTITULE>{$filmIterator/ROLES/ROLE/INTITULE/text() }</INTITULE>


</ROLE>


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
