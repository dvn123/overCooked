<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar uma pergunta';
    return '401';
}

$idUser = getIdUser($_SESSION['username']);

if (!isset($_POST['title']) || !isset($_POST['content']) || !isset($_POST['tags'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    //$_SESSION['form_values'] = $_POST;
    return '400';
} else {
    if($_POST['title'] == "" || $_POST['content'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        //$_SESSION['form_values'] = $_POST;
        return '400';
    }
}

if (addQuestion($_POST['title'], $idUser, $_POST['content'])) {
    $_SESSION['success_messages'][] = 'Login bem sucedido!';
    return '200';
} else {
    $_SESSION['error_messages'][] = 'A criação de pergunta falhou!';
    return '400';
}
?>
