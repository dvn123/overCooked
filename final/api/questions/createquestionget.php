<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/tags.php');

/*
if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar uma pergunta';
    echo '401';
    exit;
}
*/
$idUser = 1;

if (!isset($_GET['title']) || !isset($_GET['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    $_SESSION['form_values'] = $_GET;
    echo '400';
    exit;
} else {
    if($_GET['title'] == "" || $_GET['content'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        $_SESSION['form_values'] = $_GET;
        echo '400';
        exit;
    }
}

if (addQuestion($_GET['title'], $idUser, $_GET['content'])) {
    $_SESSION['success_messages'][] = 'Criação de Pergunta bem sucedida!';
    $idQuestion = getQuestionByTitle($_GET['title'])['idquestion'];
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
