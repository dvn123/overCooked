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

    $timeFirst  = strtotime($question['date']);
    $timeSecond = time();
    $difference = $timeSecond - $timeFirst;

    if ($difference < 60) {
        $seconds = ' segundos';
        if($difference == 1)
            $seconds = ' segundo';
        $questions[$key]['date2'] = 'há ' . $difference . $seconds;
    }
    elseif($difference < 3600) {
        $minutes = ' minutos';
        if($difference >= 60 && $difference <= 120)
            $minutes = ' minuto';
        $questions[$key]['date2'] = 'há ' . $difference / 60 . $minutes;
    }
    else if ($difference < 86400) {
        $hours = ' horas';
        if($difference >= 60 && $difference <= 120)
            $hours = ' hora';
        $questions[$key]['date2'] = 'há ' . $difference / 3600 . $hours;
    }
    else if ($difference < 86400 * 7) {
        $hours = ' dias';
        if($difference >= 60 && $difference <= 120)
            $hours = ' dia';
        $questions[$key]['date2'] = 'há ' . $difference / 86400 . $hours;
    }
    else {
        $date = new DateTime($question['date']);
        $questions[$key]['date2'] = $date->format('d-m-Y');
    }

}

foreach($questions_hot as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions_hot[$key]['tags'] = $tags;
}

$smarty->assign('questions', $questions);
$smarty->assign('questions_hot', $questions_hot);
$smarty->display('questions/home.tpl');
?>