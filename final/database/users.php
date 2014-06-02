<?php

/*
function createUser($realname, $username, $password)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO users VALUES (?, ?, ?)");
    $stmt->execute(array($username, $realname, sha1($password)));
}
*/
function getUserName($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT username FROM webUser
          WHERE webUser.iduser = :id;");

    $stmt->bindParam(":id", $idUser);
    $stmt->execute();

    $tmp = $stmt->fetch();
    $tmp2 = $tmp['username'];
    return $tmp2;
}


function getIdUser($username) {

    global $conn;
    $stmt = $conn->prepare("SELECT idUser FROM webUser
          WHERE webUser.username LIKE :name;");

    $stmt->bindParam(":name", $username);
    $stmt->execute();

    //return   $stmt->fetch()['iduser'];
    $tmp = $stmt->fetch();
    $tmp2 = $tmp['iduser'];
    return $tmp2;
}

function createUser($username, $password, $email, $name, $idCountry)
{
    global $conn;

    $stmt = $conn->prepare(
        "INSERT INTO webUser (username, password, salt, registrationDate, birthDate, city, email, gender, name, idCountry, userGroup)
        VALUES (:username,:password, :salt, :registrationDate,NULL,NULL,:email,NULL,:name,:idCountry,'user');"
    );

    $salt = base64_encode(mcrypt_create_iv(22, MCRYPT_DEV_URANDOM));
    $hashed_password = hash(sha256, $salt . $password);
    $stmt->bindParam(":username", $username);
    $stmt->bindParam(":password", $hashed_password);
    $stmt->bindParam(":salt", $salt);
    $stmt->bindParam(":registrationDate",date('Y-m-d', time()) );
    $stmt->bindParam(":email", $email);
    $stmt->bindParam(":name", $name);
    $stmt->bindParam(":idCountry", $idCountry);
    return $stmt->execute();

}

// Compares two strings $a and $b in length-constant time.
function slow_equals($a, $b)
{
    $diff = strlen($a) ^ strlen($b);
    for($i = 0; $i < strlen($a) && $i < strlen($b); $i++)
    {
        $diff |= ord($a[$i]) ^ ord($b[$i]);
    }
    return $diff === 0;
}

function isLoginCorrect($username, $password)
{
    global $conn;
    $stmt = $conn->prepare("SELECT * 
                            FROM webUser
                            WHERE username = :user");
    $stmt->bindParam(":user", $username);
    $stmt->execute();
    $data = $stmt->fetch();

    $hashed_password = hash(sha256,$data['salt'] . $password);


    return slow_equals($data['password'], $hashed_password);
}

function isBanned($username) {
    global $conn;
    $stmt = $conn->prepare("SELECT banned
                            FROM webUser
                            WHERE username = :user");
    $stmt->bindParam(":user", $username);
    $stmt->execute();
    return $stmt->fetch()['banned'];
}

function getProfilePic($username)
{
    global $conn;
    $stmt = $conn->prepare("SELECT imageLink
                            FROM webUser
                            WHERE username = :user");
    $stmt->bindParam(":user", $username);
    $stmt->execute();

    return $stmt->fetch();
}

function getUserProfile($idUser)
{

    global $conn;
    $stmt = $conn->prepare("SELECT username, imageLink,  registrationDate,  about,  birthDate,
      city,  email,  gender,  webUser.name,  numAnswers,  numComments,  numQuestions,
	  score,  country.name AS country,  userGroup, webUser.idCountry
      FROM webUser, country WHERE idUser = :id AND webUser.idCountry = country.idCountry;");

    $stmt->bindParam(":id", $idUser);
    $stmt->execute();

    return  $stmt->fetch();

    /* $data = array();

     if ($stmt->num_rows() > 0) {
         foreach ($stmt->result() as $row) {
             $data[$row->id] = $row->name;
         }
     }

     return json_encode($data);*/
}

function updateUserProfile($idUser, $imageLink, $about, $birthDate, $city, $email, $gender, $name, $idCountry)
{
    global $conn;

    $stmt = $conn->prepare("UPDATE webUser SET imageLink = :imageLink,
                        about = :about,birthDate = :birthDate,city = :city,email = :email,
                        gender = :gender,name = :name,idCountry = :idCountry
                        WHERE idUser = :idUser;");

    $stmt->bindParam(":idUser", $idUser);
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
        SET password = :password, salt=:salt WHERE idUser = :idUser;");

    $salt = base64_encode(mcrypt_create_iv(22, MCRYPT_DEV_URANDOM));
    $hashed_password = hash(sha256, $salt . $password);
    $stmt->bindParam(":password", $hashed_password);
    $stmt->bindParam(":salt", $salt);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->execute();
}

?>
