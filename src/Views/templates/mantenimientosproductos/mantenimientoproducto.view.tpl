<section class="container-m row px-4 py-4">
  <h1>{{modeDsc}}</h1>
</section>

<section class="container-m row px-4 py-4">
  <form action="index.php?page=MantenimientosProductos-MantenimientoProducto&mode={{mode}}&id={{productId}}" method="POST" class="col-12 col-m-8 offset-m-2">
    
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productId">Código</label>
      <input class="col-12 col-m-9" readonly disabled type="text" name="productId" id="productId" value="{{productId}}" {{readonly}} />
      <input type="hidden" name="mode" value="{{mode}}" />
      <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
      {{if error_productId}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productId}}</div>
      {{endif error_productId}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productName">Nombre</label>
      <input class="col-12 col-m-9" {{readonly}} type="text" name="productName" id="productName" value="{{productName}}" />
      {{if error_productName}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productName}}</div>
      {{endif error_productName}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productDescription">Descripción</label>
      <textarea class="col-12 col-m-9" {{readonly}} name="productDescription" id="productDescription">{{productDescription}}</textarea>
      {{if error_productDescription}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productDescription}}</div>
      {{endif error_productDescription}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productPrice">Precio</label>
      <input class="col-12 col-m-9" {{readonly}} type="number" step="0.01" min="0" name="productPrice" id="productPrice" value="{{productPrice}}" />
      {{if error_productPrice}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productPrice}}</div>
      {{endif error_productPrice}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productStock">Stock</label>
      <input class="col-12 col-m-9" {{readonly}} type="number" min="0" name="productStock" id="productStock" value="{{productStock}}" />
      {{if error_productStock}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productStock}}</div>
      {{endif error_productStock}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productImgUrl">URL Imagen</label>
      <input class="col-12 col-m-9" {{readonly}} type="text" name="productImgUrl" id="productImgUrl" value="{{productImgUrl}}" />
      {{if error_productImgUrl}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productImgUrl}}</div>
      {{endif error_productImgUrl}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productStatus">Estado</label>
      <select class="col-12 col-m-9" name="productStatus" id="productStatus" {{readonly}}>
        <option value="ACT" {{estadoACT}}>Activo</option>
        <option value="INA" {{estadoINA}}>Inactivo</option>
        <option value="BLQ" {{estadoBLQ}}>Bloqueado</option>
      </select>
      {{if error_productStatus}}
      <div class="col-12 col-m-9 offset-m-3 error">{{error_productStatus}}</div>
      {{endif error_productStatus}}
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
      window.location.assign("index.php?page=MantenimientosProductos-MantenimientosProductos");
    });
  });
</script>