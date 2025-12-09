<section class="container-m row px-4 py-4">
  <h1>{{modeDsc}}</h1>
</section>

<section class="container-m row px-4 py-4">
  <form action="index.php?page=Novedades-Novedad&mode={{mode}}&id={{highlightId}}" method="POST" class="col-12 col-m-8 offset-m-2">
    
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="highlightId">ID Novedad</label>
      <input class="col-12 col-m-9" readonly disabled type="text" name="highlightId" id="highlightId" value="{{highlightId}}" {{readonly}} />
      <input type="hidden" name="mode" value="{{mode}}" />
      <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
      {{if error_highlightId}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_highlightId}}</div>
      {{endif error_highlightId}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productId">Producto (ID)</label>
      <input class="col-12 col-m-9" {{readonly}} type="number" name="productId" id="productId" value="{{productId}}" />
      {{if error_productId}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productId}}</div>
      {{endif error_productId}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="highlightStart">Fecha Inicio</label>
      <input class="col-12 col-m-9" {{readonly}} type="datetime-local" name="highlightStart" id="highlightStart" value="{{highlightStart}}" />
      {{if error_highlightStart}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_highlightStart}}</div>
      {{endif error_highlightStart}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="highlightEnd">Fecha Fin</label>
      <input class="col-12 col-m-9" {{readonly}} type="datetime-local" name="highlightEnd" id="highlightEnd" value="{{highlightEnd}}" />
      {{if error_highlightEnd}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_highlightEnd}}</div>
      {{endif error_highlightEnd}}
    </div>

    <div class="row my-4 align-center flex-end">
      {{if showAction}}
      <button class="primary col-12 col-m-2" type="submit" name="btnConfirmar">Confirmar</button>
      &nbsp;
      {{endif showAction}}
      <button class="col-12 col-m-2" type="button" id="btnCancelar">
        {{if showAction}}Cancelar{{endif showAction}}
         {{ifnot showAction}}Regresar{{endifnot showAction}}
      </button>
    </div>

  </form>
</section>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const btnCancelar = document.getElementById("btnCancelar");
    btnCancelar.addEventListener("click", (e) => {
      e.preventDefault();
      e.stopPropagation();
      window.location.assign("index.php?page=Novedades-Novedades");
    });
  });
</script>