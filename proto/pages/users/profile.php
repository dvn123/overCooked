<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php'); //dados pessoais
include_once($BASE_DIR .'database/questions.php'); //perguntas pessoais

if (!$_GET['username']) {
    $_SESSION['error_messages'][] = 'Undefined username';
    header("Location: $BASE_URL");
    exit;
}

$idUser= getIdUser($_GET['username']); //TODO: assim ou adicionar as variaveis de sessao?

$profile_data=getUserProfile($idUser);

?>