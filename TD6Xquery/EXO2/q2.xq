(:query 2 : retrun all the roles played by Bruce Willis:)


(:in this query we first extract a template that contains all the ROLE nodes in the doc:)
(:then we only return the ROLES which the firstname and last name are equal to BRUCE WILLIS:)


for $roleIterator in doc("./Films.xml")/FILMS/FILM/ROLES/ROLE 
where ($roleIterator/PRENOM/text() = "Bruce") and ($roleIterator/NOM/text() = "Willis")
return
<ROLE>
    <PRENOM>{$roleIterator/PRENOM/text()}</PRENOM>
    <NOM>{$roleIterator/NOM/text()}</NOM>
    <INTITULE>{$roleIterator/INTITULE/text() }</INTITULE>


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
