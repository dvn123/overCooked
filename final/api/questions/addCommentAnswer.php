<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar um comentário';
    echo '401';
    exit;
}

$idUser = getIdUser($_SESSION['username']);

if (!isset($_POST['idAnswer']) || !isset($_POST['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idAnswer'] == "" || $_POST['content'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if (addCommentToAnswer($_POST['idAnswer'], $idUser, $_POST['content'])) {
    $_SESSION['success_messages'][] = 'Criação de comentário bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de comentário falhou!';
    echo '400';
    exit;
}
?>
