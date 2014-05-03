<?php /* Smarty version Smarty-3.1.15, created on 2014-05-03 17:10:18
         compiled from "..\..\templates\common\menu_logged_in.tpl" */ ?>
<?php /*%%SmartyHeaderCode:245375356e138e88c98-57457801%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9b1b2b950061f8b347f5cad1c268237db3682dff' => 
    array (
      0 => '..\\..\\templates\\common\\menu_logged_in.tpl',
      1 => 1399129598,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '245375356e138e88c98-57457801',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5356e138e9c523_93898067',
  'variables' => 
  array (
    'BASE_URL' => 0,
    'USERNAME' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5356e138e9c523_93898067')) {function content_5356e138e9c523_93898067($_smarty_tpl) {?><ul class="nav navbar-nav navbar-right pull-right">
    <li> <span><a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/users/profile.php?username=<?php echo $_smarty_tpl->tpl_vars['USERNAME']->value;?>
"><img src="../../images/default.png" style="width:50px;height:50px;margin-top:0px;"> </img> <span class="text-pink"><b><?php echo $_smarty_tpl->tpl_vars['USERNAME']->value;?>
</b></span></a></span></li>
    <li> </li>
    <li> <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
actions/users/logout.php">Logout</a> </li>
</ul><?php }} ?>
