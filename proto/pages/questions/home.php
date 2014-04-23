<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');

$num_questions = 10;

$questions = getQuestionsByDate($num_questions,1);
$questions_hot = getQuestionsHot($num_questions,1);

/*
foreach ($tweets as $key => $tweet) {
    unset($photo);
    if (file_exists($BASE_DIR.'images/users/'.$tweet['username'].'.png'))
        $photo = 'images/users/'.$tweet['username'].'.png';
    if (file_exists($BASE_DIR.'images/users/'.$tweet['username'].'.jpg'))
        $photo = 'images/users/'.$tweet['username'].'.jpg';
    if (!$photo) $photo = 'images/assets/default.png';
    $tweets[$key]['photo'] = $photo;
}*/

foreach($questions as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions[$key]['tags'] = $tags;
}

foreach($questions_hot as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions_hot[$key]['tags'] = $tags;
}

$smarty->assign('questions', $questions);
$smarty->assign('questions_hot', $questions_hot);
$smarty->display('questions/home.tpl');
?>