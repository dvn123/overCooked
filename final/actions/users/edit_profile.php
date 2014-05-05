<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['email'] ||  !$_POST['idCountry']) {
    $_SESSION['error_messages'][] = 'Campos obrigatórios não preenchidos!';
    header("Location: $BASE_URL" . 'pages/users/edit_profile.php?username='.$_SESSION['username']);
    exit;
}

$idUser=getIdUser($_GET['username']);
if($idUser==null) {
    $_SESSION['error_messages'][] = 'Nome de utilizador inválido';
    header("Location: $BASE_URL");
    exit;
}

$realname = strip_tags($_POST['realname']);
$email = $_POST['email'];
$birthdate = $_POST['birthdate'];
$gender = $_POST['gender'];
$city = strip_tags($_POST['city']);
$idCountry = $_POST['idCountry'];
$about = strip_tags($_POST['about']);
$imagelink=$_POST['image'];

//TODO: store profile pic

try {
    updateUserProfile($idUser, $imagelink, $about, $birthdate, $city, $email, $gender, $realname, $idCountry);

} catch (PDOException $e) {

    if (strpos($e->getMessage(), 'webuser_email_key') !== false) {
        $_SESSION['error_messages'][] = 'Email já registado!';
        $_SESSION['field_errors']['mail'] = 'Email já registado!';
    }
    else $_SESSION['error_messages'][] = 'Erro ao guardar alterações. Tente outra vez';

    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/users/edit_profile.php?username='.$_SESSION['username']);
    exit;
}

$_SESSION['success_messages'][] = 'Alterações registadas com sucesso!';
header("Location: $BASE_URL" . 'pages/users/profile.php?username='.$_SESSION['username']);

?>