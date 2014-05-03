<?php /* Smarty version Smarty-3.1.15, created on 2014-05-02 11:25:50
         compiled from "..\..\templates\users\profile.tpl" */ ?>
<?php /*%%SmartyHeaderCode:226975358448bca8673-18365545%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ac92dfa3a3ad4d3eadb3bd4a39de7e5725ee1656' => 
    array (
      0 => '..\\..\\templates\\users\\profile.tpl',
      1 => 1399022643,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '226975358448bca8673-18365545',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5358448c01d819_68685828',
  'variables' => 
  array (
    'profile_data' => 0,
    'BASE_URL' => 0,
    'USERNAME' => 0,
    'questions_subscribed' => 0,
    'question_subscribed' => 0,
    'tag' => 0,
    'questions_asked' => 0,
    'question_asked' => 0,
    'questions_answered' => 0,
    'question_answered' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5358448c01d819_68685828')) {function content_5358448c01d819_68685828($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div class="container">
    <div class="panel panel-green">
        <div class="panel-heading">
            <h3 class="panel-title">Informação pessoal</h3>
        </div>
        <div class="panel-body">
            <h2 class="col-lg-12"><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['username'];?>
</h2>
            <div class="col-lg-4 ">
                <div class="text-center" >
                    <img src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
images/default.png" style="width:100px;height:100px; margin: auto auto;">
                </div>

                <div class="text-center">
                     <p class="text-danger"><b>Pontuação:</b> <?php echo $_smarty_tpl->tpl_vars['profile_data']->value['score'];?>
 </p>
                    <table class="table-responsive table text-center">
                        <tr>
                            <td><b>Perguntas</b></td>
                            <td><b>Respostas</b></td>
                            <td><b>Comentários</b></td>
                        </tr>
                        <tr>
                            <td><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['numquestions'];?>
 </td>
                            <td><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['numanswers'];?>
</td>
                            <td><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['numcomments'];?>
</td>
                        </tr>

                    </table>
                </div>
            </div>

            <?php if ($_smarty_tpl->tpl_vars['USERNAME']->value==$_smarty_tpl->tpl_vars['profile_data']->value['username']) {?>
                <?php echo $_smarty_tpl->getSubTemplate ('users/private_profile.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

            <?php }?>

            <div class="col-lg-4">
                <div id="public"> <!--class="voffset4"-->
                    <p><b>Data de registo: </b><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['registrationdate'];?>
 </p>
                    <p><b>País: </b><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['country'];?>
</p>
                    <p><b>Sobre: </b></p>
                    <p class="text-justify"><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['about'];?>
</p>
                </div>
            </div>

            <?php if ($_smarty_tpl->tpl_vars['USERNAME']->value==$_smarty_tpl->tpl_vars['profile_data']->value['username']) {?>
                <?php echo $_smarty_tpl->getSubTemplate ('users/edit_button.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

            <?php }?>

            </div>
        </div>
    </div>
</div>

<div class="container" >
    <div class="panel panel-green">
        <div class="panel-heading">
            <h3 class="panel-title">Perguntas & Respostas</h3>
        </div>
        <div class="panel-body">
            <ul class="nav nav-tabs ">
                <li><a href="#subscribed" data-toggle="tab"><b>Subscritas</b></a></li>
                <li class="active"><a href="#asked" data-toggle="tab"><b>Colocadas</b></a></li>
                <li><a href="#answered" data-toggle="tab"><b>Participadas</b></a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane " id="subscribed">
                    <table class="table table-hover table-responsive ">
                        <?php  $_smarty_tpl->tpl_vars['question_subscribed'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['question_subscribed']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['questions_subscribed']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['question_subscribed']->key => $_smarty_tpl->tpl_vars['question_subscribed']->value) {
$_smarty_tpl->tpl_vars['question_subscribed']->_loop = true;
?>
                        <tr>
                            <td class="col-md-1 text-center">
                                <div class="row text-danger"><?php echo $_smarty_tpl->tpl_vars['question_subscribed']->value['score'];?>
</div>
                                <div class="row text-danger">votos</div>
                            </td>
                            <td class="col-md-2 text-center text-muted">
                                <div class="row"><?php echo $_smarty_tpl->tpl_vars['question_subscribed']->value['numanswers'];?>
</div>
                                <div class="row">respostas</div>
                            </td>
                            <td>
                                <div class="row"><b><?php echo $_smarty_tpl->tpl_vars['question_subscribed']->value['title'];?>
</b></div>
                                <div class="row">
                                    <?php  $_smarty_tpl->tpl_vars['tag'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tag']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['question_subscribed']->value['tags']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->key => $_smarty_tpl->tpl_vars['tag']->value) {
$_smarty_tpl->tpl_vars['tag']->_loop = true;
?>
                                        <a href="#" style="text-decoration: none"><span class="tag label label-pink"><?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
</span></a>
                                    <?php } ?>
                                </div>
                            </td>
                        </tr>
                        <?php } ?>
                    </table>
                    <!--<div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>-->
                </div>
                <div class="tab-pane active" id="asked">
                    <table class="table table-hover table-responsive ">
                     <?php  $_smarty_tpl->tpl_vars['question_asked'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['question_asked']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['questions_asked']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['question_asked']->key => $_smarty_tpl->tpl_vars['question_asked']->value) {
$_smarty_tpl->tpl_vars['question_asked']->_loop = true;
?>
                            <tr>
                                <td class="col-md-1 text-center">
                                    <div class="row text-danger"><?php echo $_smarty_tpl->tpl_vars['question_asked']->value['score'];?>
</div>
                                    <div class="row text-danger">votos</div>
                                </td>
                                <td class="col-md-2 text-center text-muted">
                                    <div class="row"><?php echo $_smarty_tpl->tpl_vars['question_asked']->value['numanswers'];?>
</div>
                                    <div class="row">respostas</div>
                                </td>
                                <td>
                                    <div class="row"><b><?php echo $_smarty_tpl->tpl_vars['question_asked']->value['title'];?>
</b></div>
                                    <div class="row">
                                        <?php  $_smarty_tpl->tpl_vars['tag'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tag']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['question_asked']->value['tags']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->key => $_smarty_tpl->tpl_vars['tag']->value) {
$_smarty_tpl->tpl_vars['tag']->_loop = true;
?>
                                            <a href="#" style="text-decoration: none"><span class="tag label label-pink"><?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
</span></a>
                                        <?php } ?>
                                    </div>
                                </td>
                            </tr>
                        <?php } ?>
                    </table>
                    <!--<div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>-->
                </div>
                <div class="tab-pane " id="answered">
                    <table class="table table-hover table-responsive ">
                        <?php  $_smarty_tpl->tpl_vars['question_answered'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['question_answered']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['questions_answered']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['question_answered']->key => $_smarty_tpl->tpl_vars['question_answered']->value) {
$_smarty_tpl->tpl_vars['question_answered']->_loop = true;
?>
                            <tr>
                                <td class="col-md-1 text-center">
                                    <div class="row text-danger"><?php echo $_smarty_tpl->tpl_vars['question_answered']->value['score'];?>
</div>
                                    <div class="row text-danger">votos</div>
                                </td>
                                <td class="col-md-2 text-center text-muted">
                                    <div class="row"><?php echo $_smarty_tpl->tpl_vars['question_answered']->value['numanswers'];?>
</div>
                                    <div class="row">respostas</div>
                                </td>
                                <td>
                                    <div class="row"><b><?php echo $_smarty_tpl->tpl_vars['question_answered']->value['title'];?>
</b></div>
                                    <div class="row">
                                        <?php  $_smarty_tpl->tpl_vars['tag'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tag']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['question_answered']->value['tags']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->key => $_smarty_tpl->tpl_vars['tag']->value) {
$_smarty_tpl->tpl_vars['tag']->_loop = true;
?>
                                            <a href="#" style="text-decoration: none"><span class="tag label label-pink"><?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
</span></a>
                                        <?php } ?>
                                    </div>
                                </td>
                            </tr>
                        <?php } ?>
                    </table>
                    <!--<div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>-->
                </div>
            </div>
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/libs/bootstrap/bootstrap.js"></script>

<?php echo $_smarty_tpl->getSubTemplate ('common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
