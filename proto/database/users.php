<?php

/*
function createUser($realname, $username, $password)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO users VALUES (?, ?, ?)");
    $stmt->execute(array($username, $realname, sha1($password)));
}
*/

function createUser($username, $password, $birthDate, $city, $email, $gender, $name, $idCountry, $userGroup)
{
    global $conn;
    $stmt = $conn->prepare(
        "INSERT INTO webUser (username,password, registrationDate, birthDate, city, email, gender, name, idCountry, userGroup)
        VALUES (:username,:password,:registrationDate,:birthDate,:city,:email,:gender,:name,:idCountry,'user');"
    );

    $stmt->bindParam(":username", $username);
    $stmt->bindParam(":password", sha1($password));
    $stmt->bindParam(":registrationDate",date('d-m-Y h:i:s', time()) );
    $stmt->bindParam(":birthDate", $birthDate);
    $stmt->bindParam(":city", $city);
    $stmt->bindParam(":email", $email);
    $stmt->bindParam(":gender", $gender);
    $stmt->bindParam(":name", $name);
    $stmt->bindParam(":idCountry", $idCountry);
    $stmt->bindParam(":userGroup", $userGroup);

    $stmt->execute();
}

function isLoginCorrect($username, $password)
{
    global $conn;
    $stmt = $conn->prepare("SELECT * 
                            FROM webUser
                            WHERE username = ? AND password = ?");
    $stmt->execute(array($username, $password));
    return $stmt->fetch() == true;
}

function getUserProfile($idUser)
{
    global $conn;
    $stmt = $conn->prepare("SELECT username, imageLink,  registrationDate,  about,  birthDate,
      city,  email,  gender,  webUser.name,  numAnswers,  numComments,  numQuestions,
	  score,  country.name AS country,  userGroup
      FROM webUser, country WHERE idUser = :id AND webUser.idCountry = country.idCountry;");
    $stmt->bindParam(":id", $idUser);
    $stmt->execute();

    $stmt->fetch();

    $data = array();

    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }

    return json_encode($data);
}

function updateUserProfile($idUser, $imageLink, $about, $birthDate, $city, $email, $gender, $name, $idCountry)
{
    global $conn;

    $stmt = $conn->prepare("UPDATE webUser SET username = :username,imageLink = :imageLink,
                        about = :about,birthDate = :birthDate,city = :city,email = :email,
                        gender = :gender,name = :name,idCountry = :idCountry
                        WHERE idUser = :idUser;");

    $stmt->bindParam(":id", $idUser);
    $stmt->bindParam(":imageLink", $imageLink);
    $stmt->bindParam(":about", $about);
    $stmt->bindParam(":birthDate", $birthDate);
    $stmt->bindParam(":city", $city);
    $stmt->bindParam(":email", $email);
    $stmt->bindParam(":gender", $gender);
    $stmt->bindParam(":name", $name);
    $stmt->bindParam(":idCountry", $idCountry);

    $stmt->execute();
}

//alterar password
function changePassword($idUser, $password)
{
    global $conn;

    $stmt = $conn->prepare("UPDATE webUser
        SET password = :password WHERE idUser = :idUser;");

    $stmt->bindParam(":password", sha1($password));
    $stmt->bindParam(":idUser", $idUser);

    $stmt->execute();
}

?>
