<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

if (!isset($_POST['idQuestion']) || !isset($_POST['content']) || !isset($_POST['title'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idQuestion'] == "" || $_POST['content'] == "" || $_POST['title'] == "" || strlen($_POST['title']) > 25 || strlen($_POST['content']) > 1000) {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para editar a pergunta';
    echo '401';
    exit;
}
$idUser = getIdUser($_SESSION['username']);

if(getUserProfile($idUser)['usergroup'] == 'user' && !(getQuestion($_POST['idQuestion'])['iduser'] == $idUser)) {
    $_SESSION['error_messages'][] = 'Não tem permissões para editar a pergunta';
    echo '403';
    exit;
}

if (changeQuestionContent($idUser, $_POST['idQuestion'], $_POST['content']) && changeQuestionTitle($idUser, $_POST['idQuestion'], $_POST['title'])) {
    $_SESSION['success_messages'][] = 'Edição de pergunta bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A edição de pergunta falhou!';
    echo '400';
    exit;
}
?>
