<?php
session_set_cookie_params(3600, '/~lbaw1315');

session_start();

$BASE_DIR = '../../';
$BASE_URL = 'http://overcooked.herokuapp.com/';

$conn = new PDO('pgsql:host=ec2-54-247-82-157.eu-west-1.compute.amazonaws.com;dbname=d73f5hc45fjaph', 'yvguauiyvpejti',
    'uFQEhznoHoeKP_n5hAvxndzc7L');
$conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$conn->exec('SET SCHEMA \'public\'');

include_once($BASE_DIR . 'lib/smarty/Smarty.class.php');

$smarty = new Smarty;
$smarty->template_dir = $BASE_DIR . 'templates/';
$smarty->compile_dir = $BASE_DIR . 'templates_c/';
$smarty->assign('BASE_URL', $BASE_URL);

$smarty->assign('ERROR_MESSAGES', $_SESSION['error_messages']);
$smarty->assign('FIELD_ERRORS', $_SESSION['field_errors']);
$smarty->assign('SUCCESS_MESSAGES', $_SESSION['success_messages']);
$smarty->assign('FORM_VALUES', $_SESSION['form_values']);
$smarty->assign('USERNAME', $_SESSION['username']);
$smarty->assign('PROFILE_PIC', $_SESSION['profile_pic']);
$smarty->assign('USERGROUP', $_SESSION['usergroup']);

unset($_SESSION['success_messages']);
unset($_SESSION['error_messages']);
unset($_SESSION['field_errors']);
unset($_SESSION['form_values']);

function getCurrentDate() {
    return date('Y-m-d H:i:s', time());
}

?>
