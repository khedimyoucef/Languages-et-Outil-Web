(:~ 7. Pour chaque genre de film, produire un élément genre avec le nom du genre en attribut et contenant les titres
des films du genre en question. ~:)


let $docFilms := doc("./Films.xml")

(: Create a distinct list of all genres in the film database :)
let $genres := distinct-values($docFilms/FILMS/FILM/GENRE/text())

(: Loop through each genre and retrieve the titles of films in that genre :)
for $genre in $genres
return
<GENRE nom="{$genre}">
    {
        (: Loop through films and select only those with the current genre :)
        for $film in $docFilms/FILMS/FILM[GENRE = $genre]
        return
        <TITRE>{$film/TITRE/text()}</TITRE>
    }
</GENRE>
