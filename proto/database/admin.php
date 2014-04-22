<?php

function getUsersByName() {

    global $conn;
    $stmt = $conn->prepare("SELECT  username, imageLink,  registrationDate,
        about,  birthDate,  city,  email,  gender,  name,  numAnswers,  
        numComments,  numQuestions,  score,  idCountry,  userGroup
        FROM webUser
        ORDER BY username");
    
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();

    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }

    return json_encode($data);
}

function getUsersByScore() {

    global $conn;
    $stmt = $conn->prepare("SELECT  username, imageLink,  registrationDate,
        about,  birthDate,  city,  email,  gender,  name,  numAnswers,  
        numComments,  numQuestions,  score,  idCountry,  userGroup
        FROM webUser
        ORDER BY score");
    
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();

    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }

    return json_encode($data);
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