<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!(isset($_POST['username']) && isset($_POST['realname']) && isset($_POST['password']) && isset($_POST['email']) && isset($_POST['idCountry']))) {
    $_SESSION['error_messages'][] = 'All fields are mandatory';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/users/register.php');
    echo 'exit';
    exit;
}

$username = strip_tags($_POST['username']);
$password = strip_tags($_POST['password']);
$email = $_POST['email'];
$realname = $_POST['realname'];
$idCountry = $_POST['idCountry'];

if(!createUser($username, $password, $email, $realname, $idCountry)) {
    $_SESSION['error_messages'][] = 'Error creating user';
   header("Location: $BASE_URL");
    exit;
}
/*
$photo = $_FILES['photo'];
$extension = end(explode(".", $photo["name"]));
try {
    move_uploaded_file($photo["tmp_name"], $BASE_DIR . "images/users/" . $username . '.' . $extension); // this is dangerous
    chmod($BASE_DIR . "images/users/" . $username . '.' . $extension, 0644);
} catch (PDOException $e) {

if (strpos($e->getMessage(), 'users_pkey') !== false) {
    $_SESSION['error_messages'][] = 'Duplicate username';
    $_SESSION['field_errors']['username'] = 'Username already exists';
}
else $_SESSION['error_messages'][] = 'Error creating user';

$_SESSION['form_values'] = $_POST;
header("Location: $BASE_URL" . 'pages/users/register.php');
exit;
}*/
$_SESSION['success_messages'][] = 'User registered successfully';
header("Location: $BASE_URL");
?>
