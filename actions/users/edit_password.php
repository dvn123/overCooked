<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['pass_old'] ||  !$_POST['pass_new'] ||  !$_POST['pass_new_conf']) {
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

$username = $_GET['username'];
$passwordOld = $_POST['pass_old'];
$passwordNew = $_POST['pass_new'];
$passwordNewConf = $_POST['pass_new_conf'];

try {
    if(isLoginCorrect($username, $passwordOld)) {
        if($passwordNew==$passwordNewConf) {
            changePassword($idUser, $passwordNew);
        } else {
            $_SESSION['error_messages'][] = 'Confirmação password incorreta';
            $_SESSION['form_values'] = $_POST;
            $_SESSION['form_values']['pass_new_conf'] = "";
            header("Location: $BASE_URL" .'pages/users/edit_password.php?username='.$_SESSION['username']);
            exit;
        }
    } else {
        $_SESSION['error_messages'][] = 'Password atual incorreta';
        $_SESSION['form_values'] = $_POST;
        $_SESSION['form_values']['pass_old'] = "";
        header("Location: $BASE_URL" .'pages/users/edit_password.php?username='.$_SESSION['username']);

        exit;
    }

} catch (PDOException $e) {

    $_SESSION['error_messages'][] = 'Erro ao guardar alterações. Tente outra vez';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/users/edit_password.php?username='.$_SESSION['username']);
    exit;
}

$_SESSION['success_messages'][] = 'Password alterada com sucesso!!';
header("Location: $BASE_URL" . 'pages/users/profile.php?username='.$_SESSION['username']);

?>