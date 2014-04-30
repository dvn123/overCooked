<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['username'] || !$_POST['realname'] || !$_POST['password']
    || !$_POST['email'] || !$_POST['idCountry'])
{
    $_SESSION['error_messages'][] = 'Todos os campos são obrigatórios';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL");
    echo 'exit';
    exit;
}

$username = strip_tags($_POST['username']);
$password = strip_tags($_POST['password']);
$email = $_POST['email'];
$realname = $_POST['realname'];
$idCountry = $_POST['idCountry'];

try {
    createUser($username, $password, $email, $realname, $idCountry);
} catch (PDOException $e) {

if (strpos($e->getMessage(), 'users_pkey') !== false) {
    $_SESSION['error_messages'][] = 'Nome de utilizador duplicado';
    $_SESSION['field_errors']['username'] = 'O nome de utilizador já existe';
}
else $_SESSION['error_messages'][] = 'Erro ao criar utilizador';

$_SESSION['form_values'] = $_POST;
header("Location: $BASE_URL");
exit;
}
$_SESSION['success_messages'][] = 'Utilizador registado com sucesso';
header("Location: $BASE_URL");
?>
