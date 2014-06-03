<?php
$conn = new PDO('pgsql:host=vdbm.fe.up.pt;dbname=lbaw1315', 'lbaw1315',
	'oA667ld4');
$conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$conn->exec('SET SCHEMA \'overCooked\'');

$stmt = $conn->prepare("UPDATE Question SET hot = false");
$stmt->execute();

$query = "(select nobest.idquestion as idqqq,newanswers.mdate from
	(select idquestion from question where not exists
		(select null from answer where bestanswer=true and idquestion = question.idquestion)
		and date_part('days', now()-date)<=10.0) as nobest
		left join (select max(date) as mdate, idquestion from answer group by idquestion)
		as newanswers using(idquestion) order by
		case when mdate is NULL then 1 else 0 end, mdate desc limit 20) as selectedquestions";
$qcomplete = "Update Question set hot = true where idquestion in (select selectedquestions.idqqq from ".$query.")";
$stmt2 = $conn->prepare($qcomplete);
$stmt2->execute();

?>
