{include file='common/header.tpl'}

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

{literal}
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
        google.load("visualization", "1", {packages: ["corechart"]});
        function drawChart(JSONdata) {
            var tmparray = [['País', 'Número de Visitas']];
            for(var i = 0; i < JSONdata[2].length; i++) {
                tmparray.push([JSONdata[2][i]["name"], parseInt(JSONdata[2][i]["counter"])]);
            }
            var data = google.visualization.arrayToDataTable(tmparray);

            var options = {
                title: 'Número de Visitas por País',
                pieHole: 0.4
            };
            var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
            chart.draw(data, options);

            var tmparray = [['País', 'Número de Posts']];
            for(var i = 0; i < JSONdata[1].length; i++) {
                tmparray.push([JSONdata[1][i]["name"], parseInt(JSONdata[1][i]["counter"])]);
            }
            var data = google.visualization.arrayToDataTable(tmparray);

            var options = {
                title: 'Número de Posts por País',
                pieHole: 0.4
            };

            var chart = new google.visualization.PieChart(document.getElementById('donutchart2'));
            chart.draw(data, options);

            var tmparray = [['Idade', 'Número de Visitas']];
            for(var i = 0; i < JSONdata[0].length; i++) {
                tmparray.push([JSONdata[0][i]["age"], parseInt(JSONdata[0][i]["n"])]);
            }
            var data = google.visualization.arrayToDataTable(tmparray);

            var options = {
                title: 'Número de Visitas por Idade',
                pieHole: 0.4
            };

            var chart = new google.visualization.PieChart(document.getElementById('donutchart3'));
            chart.draw(data, options);
        }

        $( document ).ready(function() {
            $('#admin').addClass('active');
            var request = $.ajax({
                url: "../../api/admin/getStatistics.php?num=10"
            });
            request.done(function(data) {
                if(data != 400 && data !=401 && data != 300) {
                    var jsonList = JSON.parse(data, null);
                    google.setOnLoadCallback(drawChart(jsonList));
                }
            });
            request.fail(function( jqXHR, textStatus ) {
                console.log( "Request failed: " + textStatus );
            });
        });
    </script>
{/literal}

<div class="container col-md-4">
    <div id="donutchart" style="width: 550px; height: 500px;"></div>
</div>

<div class="container  col-md-4">
    <div id="donutchart2" style="width: 550px; height: 500px;"></div>
</div>

<div class="container  col-md-4">
    <div id="donutchart3" style="width: 550px; height: 500px;"></div>
</div>


<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

{include file='common/footer.tpl'}