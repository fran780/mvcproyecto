<section class="container-m row px-4 py-4">
  <h1>{{modeDsc}}</h1>
</section>

<section class="container-m row px-4 py-4">
  <form action="index.php?page=Sales-Sal&mode={{mode}}&id={{saleId}}" method="POST" class="col-12 col-m-8 offset-m-2">
    
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="saleId">ID Venta</label>
      <input class="col-12 col-m-9" readonly disabled type="text" name="saleId" id="saleId" value="{{saleId}}" {{readonly}} />
      <input type="hidden" name="mode" value="{{mode}}" />
      <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
      {{if error_saleId}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_saleId}}</div>
      {{endif error_saleId}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productId">Producto (ID)</label>
      <input class="col-12 col-m-9" {{readonly}} type="number" name="productId" id="productId" value="{{productId}}" />
      {{if error_productId}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productId}}</div>
      {{endif error_productId}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="salePrice">Precio de Venta</label>
      <input class="col-12 col-m-9" {{readonly}} type="number" step="0.01" min="0" name="salePrice" id="salePrice" value="{{salePrice}}" />
      {{if error_salePrice}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_salePrice}}</div>
      {{endif error_salePrice}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="saleStart">Fecha Inicio</label>
      <input class="col-12 col-m-9" {{readonly}} type="datetime-local" name="saleStart" id="saleStart" value="{{saleStart}}" />
      {{if error_saleStart}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_saleStart}}</div>
      {{endif error_saleStart}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="saleEnd">Fecha Fin</label>
      <input class="col-12 col-m-9" {{readonly}} type="datetime-local" name="saleEnd" id="saleEnd" value="{{saleEnd}}" />
      {{if error_saleEnd}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_saleEnd}}</div>
      {{endif error_saleEnd}}
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
      window.location.assign("index.php?page=Sales-Sales");
    });
  });
</script>