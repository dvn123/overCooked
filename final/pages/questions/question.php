<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

	try{
		if(!isset($_GET['idQuestion']))
			throw new Exception("Error Processing Request", 1);
		$idQuestion = $_GET['idQuestion'];
		$question = getQuestion($idQuestion);
		if(!$question)
			throw new Exception("Error Processing Request", 1);
		$user = getUserProfile($question['iduser']);
		$question['username'] = $user['username'];
		$question['userlink'] = $BASE_URL . "pages/users/profile.php?username=" . $user['username'];
		if($user['imagelink'] == NULL)	
			$question['userphoto'] =$BASE_URL . "images/users/default.png";
		else $question['userphoto'] =$BASE_URL . "images/users/" . $user['imagelink'];
		$question['userpoints'] = $user['score'];
		$question['tags'] = getQuestionTags($idQuestion);
		$question['comments'] = getQuestionComments($idQuestion);
		foreach ($question['comments'] as &$comment) {
			$comment['username'] = getUserName($comment['iduser']);
			$comment['userlink'] = $BASE_URL . "pages/users/profile.php?username=" . $comment['username'];
		}
		$question['answers'] = getQuestionAnswers($idQuestion);
		$question['numanswers'] = count($question['answers']);
		foreach($question['answers'] as &$answer)
		{
			$user_answer = getUserProfile($answer['iduser']);
			$answer['username'] = $user_answer['username'];
			$answer['userlink'] = $BASE_URL . "pages/users/profile.php?username=" . $user_answer['username'];
			if($user_answer['imagelink'] == NULL)	
				$answer['userphoto'] =$BASE_URL . "images/users/default.png";
			else $answer['userphoto'] =$BASE_URL . "images/users/" . $user_answer['imagelink'];
			$answer['userpoints'] = $user_answer['score'];
			$answer['comments'] = getAnswerComments($answer['idanswer']);
			foreach($answer['comments'] as &$acomment)
			{
				$acomment['username'] = getUserName($acomment['iduser']);
				$acomment['userlink'] = $BASE_URL . "pages/users/profile.php?username=" . $acomment['username'];
			}
		}//------------
		if(isset($_SESSION['username']))
		{
			$idMyUser = getIdUser($_SESSION['username']);
			if($question['iduser']==$idMyUser)
				$question['owner']=true;
			$question['subscribed'] = isQuestionSubscribed($idMyUser,$idQuestion);
			$question['vote'] = getQuestionVote($idQuestion, $idMyUser);
			foreach($question['answers'] as &$answer)
			{
				$answer['vote'] = getAnswerVote($answer['idanswer'], $idMyUser);
			}
		}
		//------------
		$smarty->assign('question', $question);
		$smarty->display('questions/question.tpl');	
	} catch(Exception $e)
	{
        var_dump($e);
	//	header("Location: $BASE_URL");
	}
?>