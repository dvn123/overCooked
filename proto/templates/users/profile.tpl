{include file='common/header.tpl'}

<div class="container">
    <div class="panel panel-green">
        <div class="panel-heading">
            <h3 class="panel-title">Área pessoal</h3>
        </div>
        <div class="panel-body">
            <h2 class="col-lg-12">ei11054</h2>
            <div class="col-lg-4 ">
                <div class="text-center" >
                    <img src="images/default.png" style="width:100px;height:100px; margin: auto auto;">
                </div>

                <div class="text-center">
                    <p><b>Data de registo</b>: 04-03-2013 </p>
                    <p class="text-danger"><b>Pontuação:</b> 11,000</p>
                    <table class="table-responsive table text-center">
                        <tr>
                            <td><b>Perguntas</b></td>
                            <td><b>Respostas</b></td>
                            <td><b>Comentários</b></td>
                        </tr>
                        <tr>
                            <td>50</td>
                            <td>5,000</td>
                            <td>987</td>
                        </tr>

                    </table>
                </div>
            </div>

            <div class="col-lg-4">
                <h4 class="text-center text-pink">Privado</h4>
                <div class="voffset4">
                    <p><b>Nome:</b> Tiago Fernandes</p>
                    <p><b>Data de nascimento:</b> 22-03-1993</p>

                    <p><b>Cidade:</b> Chaves</p>
                    <p><b>Email:</b> ei11054@fe.up.pt</p>
                </div>
                <br>
            </div>

            <div class="col-lg-4">
                <h4 class="text-center text-pink">Público</h4>
                <div id="about" class="voffset4">

                    <p><b>País:</b> Portugal</p>
                    <p><b>Sobre:</b></p>
                    <p class="text-justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse arcu arcu, tempor
                        scelerisque arcu eu, hendrerit venenatis turpis. Nam congue sem eget velit dictum, et
                        consectetur ipsum feugiat. Nullam dignissim pellentesque urna, quis ullamcorper dui viverra
                        eget.
                    </p>
                </div>

            </div>
            <div class="text-center row col-lg-12">
                <a href="#" class="btn btn-default">Editar</a>
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
                <li><a href="#home" data-toggle="tab"><b>Subscritas</b></a></li>
                <li><a href="#profile" data-toggle="tab"><b>Colocadas</b></a></li>
                <li><a href="#profile" data-toggle="tab"><b>Participei</b></a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="home">
                    <table class="table table-hover table-responsive ">
                        <tr>
                            <td class="col-md-1 text-center">
                                <div class="row text-danger">8</div>
                                <div class="row text-danger">votos</div>
                            </td>
                            <td class="col-md-2 text-center text-muted">
                                <div class="row">0</div>
                                <div class="row">respostas</div>
                            </td>
                            <td>
                                <div class="row"><b>Como se faz arroz?</b></div>
                                <div class="row"><a href="#" style="text-decoration: none"><span class="tag label label-pink">arroz</span></a></div>


                            </td>
                        </tr>
                        <tr>
                            <td class="text-center">votos</td><td class="text-center">respostas</td><td>Como se faz arroz?</td>
                        </tr> <tr>
                            <td class="text-center">votos</td><td class="text-center">respostas</td><td>Como se faz arroz?</td>
                        </tr> <tr>
                            <td class="text-center">votos</td><td class="text-center">respostas</td><td>Como se faz arroz?</td>
                        </tr>


                    </table>
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane" id="profile">...</div>
            </div>
        </div>
    </div>
</div>

{include file='common/footer.tpl'}