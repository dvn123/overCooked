<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
$num_questions = 10;
$questions = getQuestionsByDate($num_questions);
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

    $question['tags'] = $tags;
}

$smarty->assign('questions', $questions);
$smarty->display('questions/home.tpl');
?>