<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['username'] || !$_POST['password']) {
    $_SESSION['error_messages'][] = 'Login inválido!';
    $_SESSION['form_values'] = $_POST;
    header('Location: ' . $_SERVER['HTTP_REFERER']);
    exit;
}

$username = $_POST['username'];
$password = $_POST['password'];

if (isLoginCorrect($username, $password)) {

    $_SESSION['username'] = $username;
    $_SESSION['success_messages'][] = 'Login bem sucedido!';

    $picture=getProfilePic($username);
    $_SESSION['profile_pic'] = $picture['imagelink'];

} else {
    $_SESSION['error_messages'][] = 'O login falhou!';
}

header('Location: ' . $_SERVER['HTTP_REFERER']);

?>
