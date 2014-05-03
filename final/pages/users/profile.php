<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php'); //dados pessoais
include_once($BASE_DIR .'database/questions.php'); //perguntas pessoais

if (!$_GET['username']) {
    $_SESSION['error_messages'][] = 'Undefined username';
    header("Location: $BASE_URL");
    exit;
}

$idUser=getIdUser($_GET['username']);

if($idUser==null) {
    $_SESSION['error_messages'][] = 'Invalid username';
    header("Location: $BASE_URL");
    exit;
}

$profile_data=getUserProfile($idUser);
$questions_asked=getQuestionsAsked($idUser);
//var_dump(1,$questions_asked);
$questions_answered=getQuestionsAnswered($idUser);
//var_dump(2,$questions_answered);
$questions_subscribed=getQuestionsSubscribed($idUser);
//var_dump(3,$questions_subscribed);

foreach($questions_asked as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions_asked[$key]['tags'] = $tags;
}

foreach($questions_answered as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions_answered[$key]['tags'] = $tags;
}

foreach($questions_subscribed as $key => $question) {
    $tags3= getQuestionTags($question['idquestion']);
    $questions_subscribed[$key]['tags'] = $tags;
}

$smarty->assign('profile_data', $profile_data);
$smarty->assign('questions_asked', $questions_asked);
$smarty->assign('questions_answered', $questions_answered);
$smarty->assign('questions_subscribed', $questions_subscribed);
$smarty->display('users/profile.tpl');

?>