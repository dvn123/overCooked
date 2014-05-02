<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');


$_SESSION['success_messages'][] = 'Utilizador registado com sucesso';
header("Location: $BASE_URL");

?>