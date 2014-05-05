<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['password1'] ||  !$_POST['password2'] ||  !$_POST['password3']) {
    $_SESSION['error_messages'][] = 'Campos obrigatórios não preenchidos!';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/users/edit_password.php?username='.$_SESSION['username']);
    exit;
}

$idUser=getIdUser($_GET['username']);
if($idUser==null) {
    $_SESSION['error_messages'][] = 'Nome de utilizador inválido';
    header("Location: $BASE_URL");
    exit;
}

$username = strip_tags($_POST['username']);
$passwordOld = strip_tags($_POST['password']);
$passwordNew = strip_tags($_POST['password2']);
$passwordNewConf = strip_tags($_POST['password3']);

try {
    changePassword($idUser, $passwordNew);
    //TODO: mudar funçao, verificar se old é igual, new e newconf
} catch (PDOException $e) {

    $_SESSION['error_messages'][] = 'Erro ao guardar alterações. Tente outra vez';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . . 'pages/users/edit_password.php?username='.$_SESSION['username']);
    exit;
}

$_SESSION['success_messages'][] = 'Alterações registadas com sucesso!';
header("Location: $BASE_URL" . 'pages/users/profile.php?username='.$_SESSION['username']);

?>