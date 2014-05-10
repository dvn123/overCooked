<?php

function getUsersByName() {

    global $conn;
    $stmt = $conn->prepare("SELECT  username, imageLink,  registrationDate,
        about,  birthDate,  city,  email,  gender,  name,  numAnswers,
        numComments,  numQuestions,  score,  idCountry,  userGroup
        FROM webUser
        ORDER BY username");
    
    $stmt->execute();
    return $stmt->fetchAll();

/*    $data = array();

    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }

    return json_encode($data);*/
}

function getUsersByScore() {

    global $conn;
    $stmt = $conn->prepare("SELECT  username, imageLink,  registrationDate,
        about,  birthDate,  city,  email,  gender,  name,  numAnswers,  
        numComments,  numQuestions,  score,  idCountry,  userGroup
        FROM webUser
        ORDER BY score");
    
    $stmt->execute();
    return $stmt->fetchAll();
}

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


//TODO: SQL008 - Obter valores de estatísticas

function promoteUser($idUser) {

    global $conn;

    $stmt = $conn->prepare("UPDATE webUser
        SET userGroup = 'moderator' WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);

    $stmt->execute();
}

function deleteUser($idUser) {
    
    global $conn;

    $stmt = $conn->prepare("DELETE FROM webUser
        WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);

    $stmt->execute();
}

?>