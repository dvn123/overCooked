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

    return $stmt->execute();
}

function relegateUser($idUser) {

    global $conn;

    $stmt = $conn->prepare("UPDATE webUser
        SET userGroup = 'user' WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);

    return $stmt->execute();
}

function banUser($idUser) {
    
    global $conn;

    $stmt = $conn->prepare("UPDATE webUser
        SET banned = 'true' WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);

    return $stmt->execute();
}

function acceptUser($idUser) {

    global $conn;

    $stmt = $conn->prepare("UPDATE webUser
        SET banned = 'false' WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);

    return $stmt->execute();
}


?>