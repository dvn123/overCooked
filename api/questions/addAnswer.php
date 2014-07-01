<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');


if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Faça login para criar uma resposta';
    echo '401';
    exit;
}

$idUser = getIdUser($_SESSION['username']);

if (!isset($_POST['idQuestion']) || !isset($_POST['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idQuestion'] == "" || $_POST['content'] == "" || strlen($_POST['content']) > 10000) {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if (addAnswerToQuestion($_POST['idQuestion'], $idUser, $_POST['content'])) {
    $_SESSION['success_messages'][] = 'Criação de resposta bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de resposta falhou!';
    echo '400';
    exit;
}
?>
