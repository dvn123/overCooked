{include file='common/header.tpl'}

<div class="container">
    <div class="panel panel-green">
        <div class="panel-heading">
            <h3 class="panel-title">Alterar password</h3>
        </div>
        <div class="panel-body">
            <form class="form-horizontal " action="{$BASE_URL}actions/users/change_password.php?username={$username_edit}" method="post" accept-charset="UTF-8" role="form">
                <div class="form-group">
                    <label for="inputName" class="col-sm-2 control-label">Nome utilizador</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputName" name="username" placeholder="Nome de utilizador" value="{$profile_data.username}" disabled required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 control-label">Atual</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword1" name="password1" placeholder="Password atual" value="{$FORM_VALUES.pass_old}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 control-label">Nova</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword2" name="password2" placeholder="Password nova" value="{$FORM_VALUES.pass_new}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 control-label">Reescrever nova</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" name="password3" placeholder="Password nova" value="{$FORM_VALUES.pass_new_conf}" required>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-8"></div>
                    <div class="col-sm-1 col-sm-offset-1">
                        <button type="submit" class="btn btn-success text-center"><span class="glyphicon glyphicon-floppy-saved"></span> Guardar</button>
                    </div>
                    <div class="col-sm-1">
                        <a href="{$BASE_URL}pages/users/profile.php?username={$USERNAME}" class="col-sm-offset-3 btn btn-danger text-center"><span class="glyphicon glyphicon-floppy-remove"></span> Cancelar</a>
                    </div>
            </form>
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

{include file='common/footer.tpl'}