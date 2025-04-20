(: qeuery 1 : extraire le titre , le genre , et le pay pour tous les film avant 1970:)
(:for this query we only need the Films.xml:)

(:to access a sub element in a stored variable for example :)
(:we use $variable/subElement:)
(:we can specify attributes using the @ sign :)
(:@annee ---> attribute:)
(:annee ---> value of the node:)
(:to extract the entire element as it is in the source file we can use :)
    (:value-of($currentFilm):)
    (:to extract only the text from the node (no attributes) we can use :)
    (: currentFilm/TITRE/text():)
    (:value-of() is an xslt exclusive:)
    

    (:we must enclose variables using {}:)
for $currentFilm in doc("./Films.xml")/FILMS/FILM
where xs:integer($currentFilm/@annee)  < 1970
(:comments inside the return statement are also printed:)
return <FILM annee="{$currentFilm/@annee}">
    
    <TITRE>{ $currentFilm/TITRE/text() }</TITRE>
    <GENRE>{ $currentFilm/GENRE/text() }</GENRE>
    <PAYS>{ $currentFilm/PAYS/text() }</PAYS>
    

</FILM>
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
