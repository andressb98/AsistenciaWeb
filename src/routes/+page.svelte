<script lang="ts">
  import { goto } from '$app/navigation';
  
  const planes = [
    {
      codigo: 'FREE',
      nombre: 'Gratis',
      precio: '$0',
      features: ['1 sucursal', '5 categorías', '20 empleados', 'Historial 3 meses'],
      cta: 'Comenzar',
      destacado: false
    },
    {
      codigo: 'PLUS', 
      nombre: 'Plus',
      precio: '$29/mes',
      features: ['3 sucursales', '20 categorías', '100 empleados', 'Alertas + Portal empleado', 'Historial 12 meses'],
      cta: 'Próximamente',
      destacado: true
    },
    {
      codigo: 'PREMIUM',
      nombre: 'Premium', 
      precio: '$99/mes',
      features: ['Sucursales ilimitadas', 'Todo ilimitado', 'Reportes avanzados', 'Historial completo'],
      cta: 'Próximamente',
      destacado: false
    }
  ];
</script>

<div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
  <!-- Hero -->
  <header class="container mx-auto px-4 py-8">
    <nav class="flex justify-between items-center mb-12">
      <div class="text-2xl font-bold text-indigo-800">QR Attendance SaaS</div>
      <div class="space-x-4">
        <a href="/login" class="text-indigo-700 hover:text-indigo-900">Iniciar Sesión</a>
        <a href="/register" class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700">Registrarse</a>
      </div>
    </nav>
    
    <div class="text-center py-16">
      <h1 class="text-5xl font-bold text-gray-900 mb-4">
        Control de Asistencia con QR
      </h1>
      <p class="text-xl text-gray-600 mb-8">
        Gestiona empleados y registra asistencias en tiempo real para tu negocio
      </p>
      <div class="flex gap-4 justify-center">
        <a href="/register" class="bg-indigo-600 text-white px-8 py-3 rounded-lg text-lg hover:bg-indigo-700">
          Empieza Gratis
        </a>
        <a href="#como-funciona" class="border border-indigo-600 text-indigo-600 px-8 py-3 rounded-lg text-lg hover:bg-indigo-50">
          Saber Más
        </a>
      </div>
    </div>
  </header>

  <!-- Cómo funciona -->
  <section id="como-funciona" class="bg-white py-16">
    <div class="container mx-auto px-4">
      <h2 class="text-3xl font-bold text-center mb-12">Cómo funciona</h2>
      <div class="grid md:grid-cols-3 gap-8">
        <div class="text-center">
          <div class="bg-indigo-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4 text-2xl">1</div>
          <h3 class="font-semibold mb-2">Configura tu empresa</h3>
          <p class="text-gray-600">Crea sucursales, categorías y empleados en minutos</p>
        </div>
        <div class="text-center">
          <div class="bg-indigo-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4 text-2xl">2</div>
          <h3 class="font-semibold mb-2">Escanea QR</h3>
          <p class="text-gray-600">El gerente escanea el código QR del empleado</p>
        </div>
        <div class="text-center">
          <div class="bg-indigo-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4 text-2xl">3</div>
          <h3 class="font-semibold mb-2">Registro automático</h3>
          <p class="text-gray-600">Asistencia registrada en tiempo real con fecha y hora</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Planes -->
  <section class="py-16">
    <div class="container mx-auto px-4">
      <h2 class="text-3xl font-bold text-center mb-12">Elige tu plan</h2>
      <div class="grid md:grid-cols-3 gap-8 max-w-6xl mx-auto">
        {#each planes as plan}
          <div class={`bg-white rounded-xl shadow-lg p-8 ${plan.destacado ? 'ring-2 ring-indigo-600 scale-105' : ''}`}>
            <h3 class="text-xl font-bold mb-2">{plan.nombre}</h3>
            <div class="text-3xl font-bold text-indigo-600 mb-4">{plan.precio}</div>
            <ul class="space-y-2 mb-6">
              {#each plan.features as feature}
                <li class="flex items-center text-gray-600">
                  <svg class="w-5 h-5 text-green-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                  </svg>
                  {feature}
                </li>
              {/each}
            </ul>
            <button 
              on:click={() => plan.codigo === 'FREE' ? goto('/register') : null}
              class={`w-full py-2 rounded-lg font-semibold ${
                plan.destacado 
                  ? 'bg-indigo-600 text-white hover:bg-indigo-700' 
                  : 'border border-indigo-600 text-indigo-600 hover:bg-indigo-50'
              }`}>
              {plan.cta}
            </button>
          </div>
        {/each}
      </div>
    </div>
  </section>
</div>