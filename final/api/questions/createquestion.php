<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/questions.php');

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar uma pergunta';
    echo '401';
    exit;
}

$idUser = getIdUser($_SESSION['username']);

if (!isset($_POST['title']) || !isset($_POST['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    $_SESSION['form_values'] = $_POST;
    echo '400';
    exit;
} else {
    if($_POST['title'] == "" || $_POST['content'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        $_SESSION['form_values'] = $_POST;
        echo '400';
        exit;
    }
}

if (addQuestion($_POST['title'], $idUser, $_POST['content'])) {
    $_SESSION['success_messages'][] = 'Login bem sucedido!';
    $idQuestion = getQuestionByTitle($_POST['title'])['idquestion'];
    //$i = 0;
    /*while(isset($_POST['tag'.$i])) {
        echo $_POST['tag'.$i];
        createQuestionTag($_POST['tag'.$i],$idQuestion);
        $i = $i + 1;
    }*/
    echo $idQuestion;
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de pergunta falhou!';
    echo '400';
    exit;
}
?>
