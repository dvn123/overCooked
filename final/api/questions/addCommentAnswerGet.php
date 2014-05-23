<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
/*
if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar um comentário';
    echo '401';
    exit;
}
*/
$idUser = 1;

if (!isset($_GET['idAnswer']) || !isset($_GET['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_GET['idAnswer'] == "" || $_GET['content'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if (addCommentToAnswer($_GET['idAnswer'], $idUser, $_GET['content'])) {
    $_SESSION['success_messages'][] = 'Criação de comentário bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de comentário falhou!';
    echo '400';
    exit;
}
?>
