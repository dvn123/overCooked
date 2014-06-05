<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

if (!isset($_POST['idComment'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idComment'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para apagar o comentário';
    echo '401';
    exit;
}
$idUser = getIdUser($_SESSION['username']);

if(getUserProfile($idUser)['usergroup'] == 'user' && !(getAnswerComment($_POST['idComment'])['iduser'] == $idUser)) {
    $_SESSION['error_messages'][] = 'Não tem permissões para apagar o comentário';
    echo '403';
    exit;
}

if (deleteAnswerComment($_POST['idComment'])) {
    $_SESSION['success_messages'][] = 'Remoção de comentário bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A remoção de comentário falhou!';
    echo '400';
    exit;
}
?>
