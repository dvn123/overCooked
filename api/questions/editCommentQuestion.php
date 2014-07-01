<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

if (!isset($_POST['idComment']) || !isset($_POST['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idComment'] == "" || $_POST['content'] == "" || strlen($_POST['content']) > 1000) {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Faça login para editar o comentário';
    echo '401';
    exit;
}
$idUser = getIdUser($_SESSION['username']);

$comment = getQuestionComment($_POST['idComment']);

$profile = getUserProfile($idUser);
if($profile['usergroup'] == 'user' && $comment['iduser'] != $idUser) {

    $_SESSION['error_messages'][] = 'Não tem permissões para editar o comentário';
    echo '403';
    exit;
}

if (changeCommentToQuestionContent($idUser, $_POST['idComment'], $_POST['content'])) {
    $_SESSION['success_messages'][] = 'Edição de comentário bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A edição de comentário falhou!';
    echo '400';
    exit;
}
?>
