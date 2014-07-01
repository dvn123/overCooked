<?php

function getUsers($type, $order) {

    global $conn;
    $query="SELECT idUser, username, imageLink, score, userGroup, banned, country.name AS country
                   FROM webUser, country WHERE webUser.idCountry = country.idCountry
                   ORDER BY " . $type . " " . $order;
    $stmt = $conn->prepare($query);

    $stmt->execute();
    return $stmt->fetchAll();
}



function getUsersModerator($order) {

    global $conn;
    $query="SELECT idUser, username, imageLink, score, country.name AS country, userGroup, banned
                   FROM webUser, country WHERE webUser.idCountry = country.idCountry
                   AND userGroup='moderator'
                   ORDER BY username " . $order;
    $stmt = $conn->prepare($query);

    $stmt->execute();
    return $stmt->fetchAll();
}

function getUsersBanned($order) {

    global $conn;
    $query="SELECT idUser, username, score, userGroup, banned
                   FROM webUser
                   WHERE banned='true'
                   ORDER BY username " . $order;
    $stmt = $conn->prepare($query);

    $stmt->execute();
    return $stmt->fetchAll();
}

function searchUsers($type, $order, $name) {

    global $conn;
    $query="SELECT  idUser, username, imageLink, score, userGroup, banned, country.name AS country
        FROM webUser, country WHERE webUser.idCountry = country.idCountry
        AND username LIKE " . "'%".$name."%'" .
        " ORDER BY "  . $type . " " . $order;

    $stmt = $conn->prepare($query);

    $stmt->execute();
    return $stmt->fetchAll();
}

?>