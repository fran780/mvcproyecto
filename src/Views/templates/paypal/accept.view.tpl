<section class="container-l">
  <section class="depth-4">
    <h1>Factura</h1>
    <p>Resumen de tu pago realizado en PayPal.</p>
  </section>

  {{if hasOrder}}
  <section class="depth-1" style="border:1px solid #d7d7d7;border-radius:8px;padding:1rem;">
    <h3>Detalles de la orden</h3>
    <div class="grid">
      <div class="row border-b" style="padding:0.35rem 0;">
        <span class="col-4"><strong>ID de Orden</strong></span>
        <span class="col-8 right">{{orderId}}</span>
      </div>
      <div class="row border-b" style="padding:0.35rem 0;">
        <span class="col-4"><strong>Fecha</strong></span>
        <span class="col-8 right">{{formattedDate}}</span>
      </div>
      <div class="row border-b" style="padding:0.35rem 0;">
        <span class="col-4"><strong>Cliente</strong></span>
        <span class="col-8 right">{{customerName}}</span>
      </div>
      <div class="row border-b" style="padding:0.35rem 0;">
        <span class="col-4"><strong>Correo</strong></span>
        <span class="col-8 right">{{customerEmail}}</span>
      </div>
      <div class="row border-b" style="padding:0.35rem 0;">
        <span class="col-4"><strong>Comisión PayPal</strong></span>
        <span class="col-8 right">{{paypalFee}}</span>
      </div>
      <div class="row border-b" style="padding:0.35rem 0;">
        <span class="col-4"><strong>Monto Neto</strong></span>
        <span class="col-8 right">{{netAmount}}</span>
      </div>
      <div class="row" style="padding:0.35rem 0;">
        <span class="col-4"><strong>Total</strong></span>
        <span class="col-8 right">{{grossAmount}}</span>
      </div>
    </div>
  </section>

  <section class="depth-1" style="margin-top:1rem;border:1px solid #d7d7d7;border-radius:8px;padding:1rem;">
    <h3>Productos</h3>
    <div class="row border-b" style="padding: 0.5rem 0;align-items:center;">
      <span class="col-1">#</span>
      <span class="col-5">Producto</span>
      <span class="col-2 right">Precio</span>
      <span class="col-2 center">Cantidad</span>
      <span class="col-2 right">Subtotal</span>
    </div>
    {{foreach items}}
    <div class="row border-b" style="padding: 0.5rem 0;align-items:center;">
      <span class="col-1">{{row}}</span>
      <span class="col-5">{{itemName}}</span>
      <span class="col-2 right">{{unitAmount}}</span>
      <span class="col-2 center">{{quantity}}</span>
      <span class="col-2 right">{{total}}</span>
    </div>
    {{endfor items}}
    <div class="row" style="padding: 0.5rem 0;align-items:center;">
      <span class="col-3 offset-7 center">Total</span>
      <span class="col-2 right">{{grossAmount}}</span>
    </div>
  </section>
  {{endif hasOrder}}
  {{ifnot hasOrder}}
  <section class="depth-1" style="border:1px solid #f0ad4e;background:#fff5e5;border-radius:8px;padding:1rem;">
    <p>No Order Available!!!</p>
  </section>
  {{endifnot hasOrder}}

  <section style="margin-top:1rem;">
    <details>
      <summary>Ver respuesta completa (JSON)</summary>
      <pre style="margin-top:0.5rem;">{{orderjson}}</pre>
    </details>
  </section>
</section>