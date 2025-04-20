for $album in doc("./albums.xml")/albums/album
    order by $album/titre
    return <album>{$album/titre}</album>
