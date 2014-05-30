<?php

function getMostActiveCountries($num) {
    global $conn;
    $stmt = $conn->prepare("SELECT country.name, COUNT(*) AS counter
                            FROM webuser, country
                            WHERE webuser.idcountry = country.idcountry
                            GROUP BY country.name
                            ORDER BY counter DESC
                            LIMIT :num;");

    $stmt->bindParam(":num", $num);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getCountriesWithMostUsers($num) {
    global $conn;
    $stmt = $conn->prepare("SELECT country.name, COUNT(*) AS counter
                            FROM webuser, country
                            WHERE webuser.idcountry = country.idcountry
                            GROUP BY country.name
                            ORDER BY counter DESC
                            LIMIT :num;");

    $stmt->bindParam(":num", $num);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getAgeDistribution() {
    global $conn;
    $stmt = $conn->prepare("SELECT CASE
                                     WHEN date_part('year',age(birthdate)) <= 10 THEN '0-10'
                                     WHEN date_part('year',age(birthdate)) <= 20 THEN '11-20'
                                     WHEN date_part('year',age(birthdate)) <= 35 THEN '21-35'
                                     WHEN date_part('year',age(birthdate)) <= 50 THEN '36-50'
                                     ELSE '50+'
                                   END AS age,
                                   COUNT(*) AS n
                            FROM webuser
                            GROUP BY CASE
                                     WHEN date_part('year',age(birthdate)) <= 10 THEN '0-10'
                                     WHEN date_part('year',age(birthdate)) <= 20 THEN '11-20'
                                     WHEN date_part('year',age(birthdate)) <= 35 THEN '21-35'
                                     WHEN date_part('year',age(birthdate)) <= 50 THEN '36-50'
                                     ELSE '50+'
                                     END
                            ORDER BY age;");
    $stmt->execute();
    return $stmt->fetchAll();
}

function promoteUser($idUser) {

    global $conn;

    $stmt = $conn->prepare("UPDATE webUser
        SET userGroup = 'moderator' WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);

    $stmt->execute();
}

function banUser($idUser) {
    
    global $conn;

    $stmt = $conn->prepare("DELETE FROM webUser
        WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);

    $stmt->execute();
}

function getUsers($type, $order) {

    global $conn;
    $query="SELECT username, score, userGroup, banned
                   FROM webUser
                   ORDER BY " . $type . " " . $order;
    $stmt = $conn->prepare($query);

    $stmt->execute();
    return $stmt->fetchAll();
}

function getUsersModerator($order) {

    global $conn;
    $query="SELECT username, score, userGroup, banned
                   FROM webUser
                   AND userGroup='moderator'
                   ORDER BY username " . $order;
    $stmt = $conn->prepare($query);

    $stmt->execute();
    return $stmt->fetchAll();
}

function searchUsers($type, $order, $name) {

    global $conn;
    $query="SELECT  username, score, userGroup, banned
        FROM webUser
        AND username LIKE " . "'%".$name."%'" .
        " ORDER BY "  . $type . " " . $order;

    $stmt = $conn->prepare($query);

    $stmt->execute();
    return $stmt->fetchAll();
}


?>