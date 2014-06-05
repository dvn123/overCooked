{include file='common/header.tpl'}

<script src="{$BASE_URL}lib/ckeditor/ckeditor.js"></script>

<div class="container">
    <div class="panel panel-green">
        <div class="panel-body">
            <form id="askquestion_form" class="form-horizontal" action="javascript:submit_question()" role="form">
                <div class="form-group">
                    <label for="inputTitle" class="col-sm-2 control-label">Título</label>
                    <div class="col-sm-9">
                        <input type="text" name="title" class="form-control" id="inputTitle" placeholder="Título">
                    </div>
                    <a class="col-sm-1 glyphicon glyphicon-question-sign helper text-muted" href="#" data-container="body" data-toggle="popover" data-placement="left" data-content="Insira o título. Recomendamos que seja uma questão. Termine-o com um ponto de interrogação."></a>
                </div>
                <div class="form-group voffset5">
                    <label for="inputText" class="col-sm-2 control-label">Pergunta</label>
                    <div class="col-sm-9">
                        <textarea class="form-control ckeditor" name="content" id="inputText" cols="80"  rows="10">
                        </textarea>
                    </div>
                    <a class="col-sm-1 glyphicon glyphicon-question-sign helper text-muted" href="#" data-container="body" data-toggle="popover" data-placement="left" data-content="O conteúdo da sua questão deve ser de fácil leitura. Não utilize abreviaturas. Se desejar pode tornar o texto mais rico e adicionar imagens usando o menu fornecido."></a>
                </div>
                <div class="form-group voffset5">
                    <label for="inputTags" class="col-sm-2 control-label">Tags</label>
                    <div class="col-sm-9">
                        <input type="text" name="tags" class="form-control" id="inputTags" placeholder="Tags">
                    </div>
                    <a class="col-sm-1 glyphicon glyphicon-question-sign helper text-muted" href="#" data-container="body" data-toggle="popover" data-placement="left" data-content="Indique até 10 palavras-chave para a pergunta."></a>
                </div>
                <div class="text-center">
                    <button class="btn btn-default">Colocar Pergunta</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script type="text/javascript">
    $( document ).ready(function() {
        $('#askquestion').addClass('active');
        $('.helper').popover();
        $('.helper').hover(function() {
        this.popover();
        });
    });

    var BASE_URL = "{$BASE_URL}";
    function submit_question() {
        var form = $("#askquestion_form").serializeArray();
        var tags = form[2].value.split(" ");
        var data = {};
        data["title"] = form[0].value;
        data["content"] = form[1].value;
        if(title.length > 25) {
            if(document.getElementById("title_error") == null)
                $("#error_messages").append("<div id=\"title_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Titulo demasiado comprido</div>")
            return;
        }
        if(form[1].value.length > 1000) {
            if(document.getElementById("content_error") == null)
                $("#error_messages").append("<div id=\"content_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Conteudo demasiado comprido</div>")
            return;
        }
        if(tags.length > 10) {
            if(document.getElementById("tag_error") == null)
                $("#error_messages").append("<div id=\"tag_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Demasiadas Tags</div>")
            return;
        }
        for(var i = 0; i < tags.length; i++) {
            if(tags[i].length > 25) {
                if(document.getElementById("tag_length_error") == null)
                    $("#error_messages").append("<div id=\"tag_length_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Tags demasiado compridas</div>")
                return;
            }
            data["tag"+i] = tags[i].toLowerCase();
        }
        $.ajax({
            url: BASE_URL + "api/questions/createquestion.php",
            type: "POST",
            data: data
        }).done(function(data) {
            if(data != "e400" && data != "e401" && data != "e300") {
                var url = BASE_URL + "pages/questions/question.php?idQuestion=" + data;
                window.location.href = url;
            } else {
                location.reload();
            }
        }).fail(function( jqXHR, textStatus ) {
            console.log( "Request failed: " + textStatus );
            location.reload();
        });
    }
</script>

{include file='common/footer.tpl'}