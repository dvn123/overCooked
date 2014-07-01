<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');


if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Faça login para criar um comentário';
    echo '401';
    exit;
}

$idUser = getIdUser($_SESSION['username']);

if (!isset($_POST['idQuestion']) || !isset($_POST['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idQuestion'] == "" || $_POST['content'] == "" || strlen($_POST['content']) > 1000) {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if(strlen($_POST['content']) > 200) {
    $_SESSION['error_messages'][] = 'Limite de caracteres excedido';
    echo '400';
    exit;
}

if (addCommentToQuestion($_POST['idQuestion'], $idUser, $_POST['content'])) {
    $_SESSION['success_messages'][] = 'Criação de comentário bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de comentário falhou!';
    echo '400';
    exit;
}
?>
