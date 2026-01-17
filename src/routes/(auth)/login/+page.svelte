<script lang="ts">
  import { enhance } from '$app/forms';
  import type { ActionData } from './$types';
  
  export let form: ActionData;
</script>

<div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100 p-4">
  <div class="bg-white rounded-xl shadow-lg p-8 w-full max-w-md">
    <div class="text-center mb-8">
      <h1 class="text-2xl font-bold text-gray-900">Iniciar Sesión</h1>
      <p class="text-gray-600">Gestiona tu negocio con QR</p>
    </div>

    {#if form?.error}
      <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-4">
        {form.error}
      </div>
    {/if}

    <form method="POST" use:enhance>
      <div class="mb-4">
        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
        <input 
          type="email" 
          id="email" 
          name="email"
          required 
          class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
          value={form?.email || ''}
        />
      </div>

      <div class="mb-6">
        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
        <input 
          type="password" 
          id="password" 
          name="password"
          required 
          class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
        />
      </div>

      <div class="flex items-center justify-between mb-6">
        <label class="flex items-center">
          <input type="checkbox" name="remember" class="mr-2" />
          <span class="text-sm text-gray-600">Recordarme</span>
        </label>
        <a href="/forgot-password" class="text-sm text-indigo-600 hover:underline">¿Olvidaste tu contraseña?</a>
      </div>

      <button 
        type="submit" 
        class="w-full bg-indigo-600 text-white py-2 rounded-lg hover:bg-indigo-700 transition duration-200">
        Iniciar Sesión
      </button>
    </form>

    <div class="text-center mt-6">
      <p class="text-sm text-gray-600">
        ¿Nuevo aquí? 
        <a href="/register" class="text-indigo-600 hover:underline font-medium">Crear cuenta</a>
      </p>
    </div>
  </div>
</div>