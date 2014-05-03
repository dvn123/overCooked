<?php /* Smarty version Smarty-3.1.15, created on 2014-04-30 16:18:00
         compiled from "..\..\templates\common\menu_logged_out.tpl" */ ?>
<?php /*%%SmartyHeaderCode:177025356e4281e6461-73714194%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'acae1907105c7a0c84b045a69e07d6945519a97d' => 
    array (
      0 => '..\\..\\templates\\common\\menu_logged_out.tpl',
      1 => 1398867463,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '177025356e4281e6461-73714194',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5356e428388442_27438042',
  'variables' => 
  array (
    'BASE_URL' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5356e428388442_27438042')) {function content_5356e428388442_27438042($_smarty_tpl) {?><ul class="nav navbar-nav navbar-right pull-right">
    <li class="dropdown">
        <a class="dropdown-toggle" href="#" data-toggle="dropdown">Login <strong class="caret"></strong></a>
        <div class="dropdown-menu" style="width:300%;padding: 15px; padding-bottom: 15px;">
            <form action="../../actions/users/login.php" method="post" accept-charset="UTF-8">
                <input class="form-control" placeholder="Nome de utilizador" id="user_username" style="margin-bottom: 15px;" type="text" name="username" size="30" />
                <input class="form-control" placeholder="Password" id="user_password" style="margin-bottom: 15px;" type="password" name="password" size="30" />
                <input id="user_remember_me" style="float: left; margin-right: 10px;" type="checkbox" name="user[remember_me]" value="1" />
                <label class="string optional" for="user_remember_me"> Lembrar-me</label>

                <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" />
            </form>
        </div>
    </li>
    <li><a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/users/register.php">Registar</a></li>
</ul>

<?php }} ?>
