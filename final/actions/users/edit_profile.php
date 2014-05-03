<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['username'] || !$_POST['realname'] || !$_POST['email'] || !$_POST['birthdate'] || !$_POST['gender']
    || !$_POST['city'] || !$_POST['idCountry'] || !$_POST['about'])
{
    header("Location: $BASE_URL" . 'pages/users/profile.php?username='.$_SESSION['username']);
    echo 'exit';
    exit;
}

$username = strip_tags($_POST['username']);
$realname = strip_tags($_POST['realname']);
$email = $_POST['email'];
$birthdate = $_POST['birthdate'];
$gender = $_POST['gender'];
$city = strip_tags($_POST['city']);
$idCountry = $_POST['idCountry'];
$about = strip_tags($_POST['about']);

try{
    updateUserProfile();
} catch (PDOException $e) {

}

$_SESSION['success_messages'][] = 'Utilizador registado com sucesso';
header("Location: $BASE_URL");

?>