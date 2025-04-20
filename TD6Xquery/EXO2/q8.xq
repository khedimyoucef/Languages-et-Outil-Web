(:~ 8. Les artistes ayant joué dans un film qu’ils ont mis en scène. Pour chaque artiste on produit un élément artiste
avec pour attribut le nom complet (prénom suivi de nom de famille) et des sous-éléments film contenant le titre
du film en question, avec pour attribut l’année du film. ~:)



let $docFilms := doc("./Films.xml")
let $docArtistes := doc("./Artistes.xml")

(: Loop through all artists in Artistes.xml :)
for $artist in $docArtistes/ARTISTES/ARTISTE
    let $fullName := concat($artist/ARTPNOM, " ", $artist/ARTNOM)
    let $artistId := $artist/@id

    (: Loop through all films and check if the artist is both the director and actor in the same film :)
    for $film in $docFilms/FILMS/FILM
        let $directorId := $film/MES/@idref
        where $directorId = $artistId and
              ($film/ROLES/ROLE/PRENOM = $artist/ARTPNOM and $film/ROLES/ROLE/NOM = $artist/ARTNOM)
        return
        <ARTISTE nom_complet="{$fullName}">
            <FILM annee="{$film/@annee}">
                <TITRE>{$film/TITRE/text()}</TITRE>
            </FILM>
        </ARTISTE>
