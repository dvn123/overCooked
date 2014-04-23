<?php 
	$conn = new PDO('pgsql:host=vdbm.fe.up.pt;dbname=lbaw1315', 'lbaw1315','oA667ld4');
  $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  $conn->exec('SET SCHEMA \'public\'');

	global $conn; 

	$username = $_GET['username'];
  	$password = $_GET['password'];
    $stmt = $conn->prepare("SELECT * 
                            FROM webUser
                            WHERE username = ? AND password = ?");
    $stmt->execute(array($username, $password));
    echo $stmt->rowCount() != 0;
    echo $stmt->fetch() == true;
    return $stmt->fetch() == true;
?>