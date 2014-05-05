<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/questions.php');


/*
if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar uma pergunta';
    echo '401';
    exit;
}*/

//$idUser = getIdUser($_SESSION['username']);
$idUser = 1;
if (!isset($_GET['title']) || !isset($_GET['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    //$_SESSION['form_values'] = $_GET;
    echo '400';
    exit;
} else {
    if($_GET['title'] == "" || $_GET['content'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        //$_SESSION['form_values'] = $_GET;
        echo '400';
        exit;
    }
}


if (addQuestion($_GET['title'], $idUser, $_GET['content'])) {
    $_SESSION['success_messages'][] = 'Login bem sucedido!';
    $idQuestion = getQuestionByTitle($_GET['title']);
    $i = 0;
    while(isset($_GET['tag'.$i])) {
        createQuestionTag($_GET['tag'.$i],$idQuestion);
        $i = $i + 1;
    }
    echo $idQuestion;
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de pergunta falhou!';
    echo '400';
    exit;
}
?>
