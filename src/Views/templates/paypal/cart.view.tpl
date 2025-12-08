<section class="container-l">
  <section class="depth-4">
    <h1>Carrito de Compras</h1>
  </section>
  <section class="grid">
    <div class="row border-b" style="padding: 0.5rem 1rem;align-items:center;">
      <span class="col-1">#</span>
      <span class="col-4">Item</span>
      <span class="col-2 right">Precio</span>
      <span class="col-3 center">Cantidad</span>
      <span class="col-2 right">Subtotal</span>
    </div>
    {{foreach carretilla}}
    <div class="row border-b" style="padding: 0.5rem 1rem;align-items:center;">
      <span class="col-1">{{row}}</span>
      <span class="col-4">{{productName}}</span>
      <span class="col-2 right">{{crrprc}}</span>
      <span class="col-3 center">
        <form action="index.php?page=Checkout_Cart" method="post">
          <input type="hidden" name="productId" value="{{productId}}" />
          <button type="submit" name="removeOne" class="circle" aria-label="Disminuir uno">
            <i class="fa-solid fa-minus"></i>
          </button>
          <span style="padding: 0.25rem 0.5rem;">{{crrctd}}</span>
          <button type="submit" name="addOne" class="circle" aria-label="Aumentar uno" {{ifnot canAddMore}}disabled{{endifnot canAddMore}}>
            <i class="fa-solid fa-plus"></i>
          </button>
        </form>
        {{ifnot canAddMore}}
        <small class="warning">No hay más unidades disponibles.</small>
        {{endifnot canAddMore}}
      </span>
      <span class="col-2 right">
        {{subtotal}}
      </span>
    </div>
    {{endfor carretilla}}
    {{if isEmpty}}
    <div class="row" style="padding: 1rem;">
      <div class="col-12 center">Tu carrito está vacío. Agrega productos para comenzar tu compra.</div>
    </div>
    {{endif isEmpty}}
    <div class="row" style="padding: 0.5rem 1rem;align-items:center;">
      <span class="col-3 offset-7 center">Total</span>
      <span class="col-2 right">{{total}}</span>
    </div>
    <div class="row">
      <form action="index.php?page=Checkout_Cart" method="post" class="col-12 right">
        <button type="submit" name="proceedToCheckout">{{checkoutLabel}}</button>
      </form>
    </div>
  </section>
</section>
