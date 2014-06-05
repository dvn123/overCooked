<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/tags.php');

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar uma pergunta';
    echo 'e401';
    exit;
}

$idUser = getIdUser($_SESSION['username']);

if (!isset($_POST['title']) || !isset($_POST['content'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    $_SESSION['form_values'] = $_POST;
    echo 'e400';
    exit;
} else {
    if($_POST['title'] == "" || $_POST['content'] == "" || strlen($_POST['title']) > 25 || strlen($_POST['content']) > 1000) {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        $_SESSION['form_values'] = $_POST;
        echo 'e400';
        exit;
    }
}

if (addQuestion($_POST['title'], $idUser, $_POST['content'])) {
    $_SESSION['success_messages'][] = 'Criação de Pergunta bem sucedida!';
    $question = getQuestionByTitle($_POST['title']);
    $idQuestion = $question['idquestion'];
    $i = 0;
    while(isset($_POST['tag'.$i])) {
        if($i > 10) {
            $_SESSION['error_messages'][] = 'Algumas tags foram ignoradas porque o limite foi excedido';
            echo $idQuestion;
            exit;
        }
        if(strlen($_POST['tag'.$i]) > 25) {
            $_SESSION['error_messages'][] = 'Algumas tags foram ignoradas porque o excidiam o limite de tamanho';
            echo $idQuestion;
            exit;
        }
        createQuestionTag($_POST['tag'.$i],$idQuestion);
        $i = $i + 1;
    }
    echo $idQuestion;
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de pergunta falhou!';
    echo 'e400';
    exit;
}
?>
