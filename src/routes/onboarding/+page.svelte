<script lang="ts">
  import { enhance } from '$app/forms';
  import { goto } from '$app/navigation';
  import type { PageData, ActionData } from './$types';
  import { slide } from 'svelte/transition';
  
  export let data: PageData;
  export let form: ActionData;
  
  // Control de pasos
  let step = data.onboardingComplete ? 5 : 1;
  
  // Reactividad: Si el formulario es exitoso, avanzar de paso
  $: if (form?.success) {
    if (step < 4) step++;
  }

  const prevStep = () => step--;
</script>

<div class="min-h-screen bg-gray-50">
  <header class="bg-white shadow-sm">
    <div class="container mx-auto px-4 py-4">
      <div class="flex items-center justify-between">
        <div class="text-xl font-bold text-indigo-800">Configuración Inicial</div>
        <div class="text-sm text-gray-600">Paso {step > 4 ? 4 : step} de 4</div>
      </div>
      <div class="mt-2 bg-gray-200 rounded-full h-1">
        <div class="bg-indigo-600 h-1 rounded-full transition-all duration-300" style="width: {(step / 4) * 100}%"></div>
      </div>
    </div>
  </header>

  <main class="container mx-auto px-4 py-8">
    {#if step === 1}
      <div class="max-w-2xl mx-auto" in:slide>
        <div class="bg-white rounded-xl shadow p-8">
          <h2 class="text-2xl font-bold mb-2">Crea tu primera sucursal</h2>
          <p class="text-gray-600 mb-6">Comienza configurando el lugar donde registrarás asistencias</p>
          
          <form method="POST" action="?/createSucursal" use:enhance>
            <input type="hidden" name="empresaId" value={data.empresaId} />
            <div class="mb-4">
              <label for="nombre" class="block text-sm font-medium text-gray-700 mb-1">Nombre de sucursal *</label>
              <input type="text" name="nombre" placeholder="Ej: Sucursal Centro" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500" />
            </div>
            <div class="mb-4">
              <label for="direccion" class="block text-sm font-medium text-gray-700 mb-1">Dirección *</label>
              <textarea name="direccion" rows="2" placeholder="Calle, número, colonia" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"></textarea>
            </div>
            <div class="flex gap-4">
              <button type="button" on:click={() => goto('/dashboard')} class="flex-1 border border-gray-300 py-2 rounded-lg">Omitir</button>
              <button type="submit" class="flex-1 bg-indigo-600 text-white py-2 rounded-lg hover:bg-indigo-700">Continuar</button>
            </div>
          </form>
        </div>
      </div>

    {:else if step === 2}
      <div class="max-w-2xl mx-auto" in:slide>
        <div class="bg-white rounded-xl shadow p-8">
          <h2 class="text-2xl font-bold mb-2">Define tu primer puesto</h2>
          <form method="POST" action="?/createCategoria" use:enhance>
            <input type="hidden" name="sucursalId" value={form?.sucursalId || data.sucursalId} />
            <div class="mb-4">
              <label for="nombre" class="block text-sm font-medium text-gray-700 mb-1">Nombre del puesto *</label>
              <input type="text" name="nombre" placeholder="Ej: Meseros" required class="w-full px-3 py-2 border border-gray-300 rounded-lg" />
            </div>
            <div class="grid grid-cols-2 gap-4 mb-6">
              <input type="time" name="horaEntrada" value="09:00" class="border p-2 rounded-lg" />
              <input type="time" name="horaSalida" value="18:00" class="border p-2 rounded-lg" />
            </div>
            <div class="flex gap-4">
              <button type="button" on:click={prevStep} class="flex-1 border py-2 rounded-lg">Atrás</button>
              <button type="submit" class="flex-1 bg-indigo-600 text-white py-2 rounded-lg">Continuar</button>
            </div>
          </form>
        </div>
      </div>

    {:else if step === 3}
      <div class="max-w-2xl mx-auto" in:slide>
        <div class="bg-white rounded-xl shadow p-8">
          <h2 class="text-2xl font-bold mb-2">Registra tu primer empleado</h2>
          <form method="POST" action="?/createEmpleado" use:enhance>
            <input type="hidden" name="sucursalId" value={form?.sucursalId} />
            <input type="hidden" name="categoriaId" value={form?.categoriaId} />
            <div class="grid md:grid-cols-2 gap-4 mb-4">
              <input type="text" name="nombre" placeholder="Nombre" required class="border p-2 rounded-lg" />
              <input type="text" name="apellido" placeholder="Apellido" required class="border p-2 rounded-lg" />
            </div>
            <div class="flex gap-4">
              <button type="button" on:click={prevStep} class="flex-1 border py-2 rounded-lg">Atrás</button>
              <button type="submit" class="flex-1 bg-green-600 text-white py-2 rounded-lg">Finalizar</button>
            </div>
          </form>
        </div>
      </div>

    {:else}
      <div class="max-w-2xl mx-auto text-center" in:slide>
        <div class="bg-white rounded-xl shadow p-12">
          <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6 text-green-600 text-4xl">✓</div>
          <h2 class="text-3xl font-bold mb-4">¡Todo listo! 🎉</h2>
          <p class="mb-8 text-gray-600">Configuración completada exitosamente.</p>
          <button on:click={() => goto('/dashboard')} class="bg-indigo-600 text-white px-8 py-3 rounded-lg text-lg">Ir al Dashboard</button>
        </div>
      </div>
    {/if}
  </main>
</div>