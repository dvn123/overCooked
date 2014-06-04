{include file='common/header.tpl'}
<div class="container voffset4">
    <div class="pull-right">
        <div id="param" class="btn-group" data-toggle="buttons">
            <label class="btn btn-default {$selection_name}">
                <input type="radio" name="param" id="name">Nome
            </label>
            <label class="btn btn-default {$selection_freq}">
                <input type="radio" name="param" id="freq">Frequência
            </label>
        </div>
        <div id="order" class="btn-group" data-toggle="buttons">
            <label class="btn btn-default {$selection_down}" id="desc1">
                <input type="radio" name="order" id="desc"><span class="glyphicon glyphicon-chevron-down"></span>
            </label>
            <label class="btn btn-default {$selection_up}" id="asc1">
                <input type="radio" name="order" id="asc"><span class="glyphicon glyphicon-chevron-up"></span>
            </label>
        </div>
        <div class="btn-group right-inner-addon">
            <i class="glyphicon glyphicon-search"></i>
            <input id="search" type="search" class="form-control" placeholder="Pesquisar" {if isset($search)} value="{$search}"{/if} autocomplete="off"/>
        </div>
    </div>
    <br/><br/>
    <div  class="voffset4">

        <div class="panel">
            <div class="panel-body">
                <!--{$rows = 10}-->
                {for $i = 0 to $tags.len}
                    <!-- {if $i % $rows eq 0}<tr>{/if} -->
                    <div tag="{$tags.$i.name}" class="panel panel-body col-md-2 mytag" style="text-align:center"><a href="#" style="text-decoration: none; text-align:center"><div class="tag label label-pink" style="text-align:center">{$tags.$i.name}</div><br/>{if isset($tags.$i.freq)}({$tags.$i.freq}){/if}</a></div>
                    <!-- {if $i % $rows eq $rows-1}</tr>{/if} -->
                {/for}
            </div>
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/tags.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script>

    $( document ).ready(function() {

    	$('#tags_tab').addClass('active');

        var location = "{$BASE_URL}pages/lists/tags.php";
        var order = "{$order}";
        var type = "{$type}";

        $('#asc, #desc').change(function(){
            order = $(this).attr("id");
            var srch = $("#search").val();
            var url = location + "?type=" + type + "&order=" + order;
            if(srch && srch!="")
                window.location = url + "&search=" + srch;
            else window.location = url;
        });

        $('#name, #freq').change(function(){
            type = $(this).attr("id");
            var srch = $("#search").val();
            var url = location + "?type=" + type + "&order=" + order;
            if(srch && srch!="")
                window.location = url + "&search=" + srch;
            else window.location = url;
        });

    });
</script>


