{include file='common/header.tpl'}

<script src="{$BASE_URL}lib/ckeditor/ckeditor.js"></script>

<div class="container">
    <div class="panel panel-green">
        <div class="panel-body">
            <form id="askquestion_form" class="form-horizontal" action="javascript:submit_question()" role="form">
                <div class="form-group">
                    <label for="inputTitle" class="col-sm-2 control-label">Título</label>
                    <div class="col-sm-10">
                        <input type="text" name="title" class="form-control" id="inputTitle" placeholder="Título">
                    </div>
                </div>
                <div class="form-group voffset5">
                    <label for="inputText" class="col-sm-2 control-label">Pergunta</label>
                    <div class="col-sm-10">
                        <textarea class="form-control ckeditor" name="content" id="inputText" cols="80"  rows="10">
                        </textarea>
                    </div>
                </div>
                <div class="form-group voffset5">
                    <label for="inputTags" class="col-sm-2 control-label">Tags</label>
                    <div class="col-sm-10">
                        <input type="text" name="tags" class="form-control" id="inputTags" placeholder="Tags">
                    </div>
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
    });

    var BASE_URL = "{$BASE_URL}";
    function submit_question() {
        var form = $("#askquestion_form").serializeArray();
        var tags = form[2].value.split(" ");
        var data = {};
        data["title"] = form[0].value;
        data["content"] = form[1].value;
        for(var i = 0; i < tags.length; i++) {
            data["tags"+i] = tags[i];
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