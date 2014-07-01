<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

if (!isset($_POST['idQuestion'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idQuestion'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Faça login para apagar a pergunta';
    echo '401';
    exit;
}
$idUser = getIdUser($_SESSION['username']);

$question = getQuestion($_POST['idQuestion']);
$user = getUserProfile($idUser);
if($user['usergroup'] == 'user' && !($question['iduser'] == $idUser)) {
    $_SESSION['error_messages'][] = 'Não tem permissões para editar a pergunta';
    echo '403';
    exit;
}

if (deleteQuestion($_POST['idQuestion'])) {
    $_SESSION['success_messages'][] = 'Remoção de pergunta bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A remoção de pergunta falhou!';
    echo '400';
    exit;
}
?>
