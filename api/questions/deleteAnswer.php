<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

if (!isset($_POST['idAnswer'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    echo '400';
    exit;
} else {
    if($_POST['idAnswer'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        echo '400';
        exit;
    }
}

if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Faça login para apagar a resposta';
    echo '401';
    exit;
}
$idUser = getIdUser($_SESSION['username']);

$answer = getAnswer($_POST['idAnswer']);
$user = getUserProfile($idUser);
if($user['usergroup'] == 'user' && !($answer['iduser'] == $idUser)) {
    $_SESSION['error_messages'][] = 'Não tem permissões para editar a resposta';
    echo '403';
    exit;
}
if (deleteAnswer($_POST['idAnswer'])) {
    $_SESSION['success_messages'][] = 'Remoção de resposta bem sucedida!';
    echo '200';
    exit;
} else {
    $_SESSION['error_messages'][] = 'A remoção de resposta falhou!';
    echo '400';
    exit;
}
?>
