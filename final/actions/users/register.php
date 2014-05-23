<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['username'] || !$_POST['realname'] || !$_POST['password']
    || !$_POST['email'] || !$_POST['idCountry'])
{
    $_SESSION['error_messages'][] = 'Todos os campos são obrigatórios';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/users/register.php');
    echo 'exit';
    exit;
}

$username = strip_tags($_POST['username']);

if(strlen(utf8_decode($username))>15) {
    $_SESSION['error_messages'][] = 'Nome de utilizador muito comprido. Tamanho máximo permitido: 15 carateres';
    $_SESSION['field_errors']['username'] = 'O nome de utilizador muito comprido';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/users/register.php');
    exit;
}


$password = strip_tags($_POST['password']);
$email = $_POST['email'];
$realname = $_POST['realname'];
$idCountry = $_POST['idCountry'];

try {
    createUser($username, $password, $email, $realname, $idCountry);
} catch (PDOException $e) {

if (strpos($e->getMessage(), 'webuser_username_key') !== false) {
    $_SESSION['error_messages'][] = 'O nome de utilizador já existe';
    $_SESSION['field_errors']['username'] = 'O nome de utilizador já existe';
}
else if (strpos($e->getMessage(), 'webuser_email_key') !== false) {
    $_SESSION['error_messages'][] = 'Esse email já está registado!';
    $_SESSION['field_errors']['mail'] = 'Esse email já está registado!';
}
else $_SESSION['error_messages'][] = 'Erro ao criar utilizador';

$_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/users/register.php');
exit;
}
$_SESSION['success_messages'][] = 'Utilizador registado com sucesso';
header("Location: $BASE_URL");
?>