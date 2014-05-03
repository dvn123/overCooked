<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');

if (!$_GET['content']) {
    $_SESSION['error_messages'][] = 'Pesquisa inválida';
    header("Location: $BASE_URL");
    exit;
}
$content = str_replace(' ', '&', $_GET['content']);

$questions = searchQuestions($content);

foreach($questions as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions[$key]['tags'] = $tags;
}

$smarty->assign("questions", $questions);

$smarty->display('questions/search.tpl');
?>