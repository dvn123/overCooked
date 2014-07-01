<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

if (!isset($_POST['idQuestion']) || !isset($_POST['content']) || !isset($_POST['title'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idQuestion'] == "" || $_POST['content'] == "" || $_POST['title'] == "" || strlen($_POST['title']) > 100 || strlen($_POST['content']) > 10000) {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Faça login para editar a pergunta';
    echo '401';
    exit;
}
$idUser = getIdUser($_SESSION['username']);

$question = getQuestion($_POST['idQuestion']);

$profile = getUserProfile($idUser);
if($profile['usergroup'] == 'user' && $question['iduser'] != $idUser) {

    $_SESSION['error_messages'][] = 'Não tem permissões para editar a pergunta';
    echo '403';
    exit;
}

if (changeQuestionContent($idUser, $_POST['idQuestion'], $_POST['content']) && changeQuestionTitle($_POST['idQuestion'], $_POST['title'])) {
    $_SESSION['success_messages'][] = 'Edição de pergunta bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A edição de pergunta falhou!';
    echo '400';
    exit;
}
?>
