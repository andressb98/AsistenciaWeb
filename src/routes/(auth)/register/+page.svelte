<script lang="ts">
	import { enhance } from '$app/forms';
	import type { ActionData } from './$types';
	import { slide } from 'svelte/transition';
	import { registroPaso1Schema, registroPaso2Schema } from '$lib/schemas/auth.schema';

	export let form: ActionData;

	let step = 1;
	let valores = {
		nombre: '',
		correo: '',
		password: '',
		confirmPassword: '',
		nombreComercial: '',
		razonSocial: ''
	};

	let errores: Record<string, string> = {};
	let serverError = '';

	$: if ((form as any)?.errores) {
		const fe = (form as any).errores as Record<string, string[]>;
		errores = Object.fromEntries(Object.entries(fe).map(([k, v]) => [k, v?.[0] ?? '']));
	}

	// Restaurar valores si hay error del servidor
	$: if (form?.valores) {
		valores = { ...valores, ...form.valores };
	}

	// Si tu action regresa { error: '...' }
	$: serverError = (form as any)?.error ?? '';

	function validarPaso1() {
		const result = registroPaso1Schema.safeParse(valores);
		if (result.success) {
			errores = {};
			return true;
		}
		errores = Object.fromEntries(
			result.error.issues.map((err) => [String(err.path[0] ?? 'form'), err.message])
		);
		return false;
	}

	function validarPaso2() {
		const result = registroPaso2Schema.safeParse(valores);
		if (result.success) {
			errores = {};
			return true;
		}
		errores = Object.fromEntries(
			result.error.issues.map((err) => [String(err.path[0] ?? 'form'), err.message])
		);
		return false;
	}

	function nextStep() {
		if (step === 1 && validarPaso1()) step = 2;
		else if (step === 2 && validarPaso2()) step = 3;
	}

	function prevStep() {
		if (step > 1) step--;
	}
</script>

<div
	class="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100 p-4"
>
	<div class="bg-white rounded-xl shadow-lg p-8 w-full max-w-lg">
		<h1 class="text-xl font-semibold text-gray-900 mb-2">Crear cuenta</h1>
		<p class="text-sm text-gray-600 mb-6">Completa lo esencial. Lo demás es opcional.</p>

		{#if serverError}
			<div class="mb-4 rounded-lg border border-red-200 bg-red-50 p-3 text-sm text-red-700">
				{serverError}
			</div>
		{/if}

		<form method="POST" use:enhance>
			<!-- PASO 1: Identidad / cuenta -->
			{#if step === 1}
				<div in:slide={{ duration: 300 }}>
					<div class="mb-4">
						<label class="block text-sm font-medium text-gray-700 mb-1">Nombre completo *</label>
						<input
							bind:value={valores.nombre}
							name="nombre"
							autocomplete="name"
							class="w-full px-3 py-2 border rounded-lg {errores.nombre
								? 'border-red-500'
								: 'border-gray-300'}"
						/>
						{#if errores.nombre}<p class="text-red-500 text-xs mt-1">{errores.nombre}</p>{/if}
					</div>

					<div class="mb-4">
						<label class="block text-sm font-medium text-gray-700 mb-1">Correo *</label>
						<input
							bind:value={valores.correo}
							name="correo"
							type="email"
							autocomplete="email"
							class="w-full px-3 py-2 border rounded-lg {errores.correo
								? 'border-red-500'
								: 'border-gray-300'}"
						/>
						{#if errores.correo}<p class="text-red-500 text-xs mt-1">{errores.correo}</p>{/if}
					</div>

					<div class="mb-4">
						<label class="block text-sm font-medium text-gray-700 mb-1">Contraseña *</label>
						<input
							bind:value={valores.password}
							name="password"
							type="password"
							autocomplete="new-password"
							class="w-full px-3 py-2 border rounded-lg {errores.password
								? 'border-red-500'
								: 'border-gray-300'}"
						/>
						{#if errores.password}<p class="text-red-500 text-xs mt-1">{errores.password}</p>{/if}
					</div>

					<div class="mb-6">
						<label class="block text-sm font-medium text-gray-700 mb-1"
							>Confirmar contraseña *</label
						>
						<input
							bind:value={valores.confirmPassword}
							name="confirmPassword"
							type="password"
							autocomplete="new-password"
							class="w-full px-3 py-2 border rounded-lg {errores.confirmPassword
								? 'border-red-500'
								: 'border-gray-300'}"
						/>
						{#if errores.confirmPassword}
							<p class="text-red-500 text-xs mt-1">{errores.confirmPassword}</p>
						{/if}
					</div>

					<button
						type="button"
						on:click={nextStep}
						class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-2 rounded-lg"
					>
						Siguiente
					</button>
				</div>
			{/if}

			<!-- PASO 2: Empresa (esencial + opcional) -->
			{#if step === 2}
				<div in:slide={{ duration: 300 }}>
					<div class="mb-4">
						<label class="block text-sm font-medium text-gray-700 mb-1">Nombre comercial *</label>
						<input
							bind:value={valores.nombreComercial}
							name="nombreComercial"
							autocomplete="organization"
							class="w-full px-3 py-2 border rounded-lg {errores.nombreComercial
								? 'border-red-500'
								: 'border-gray-300'}"
						/>
						{#if errores.nombreComercial}
							<p class="text-red-500 text-xs mt-1">{errores.nombreComercial}</p>
						{/if}
					</div>

					<div class="mb-6">
						<label class="block text-sm font-medium text-gray-700 mb-1">
							Razón social <span class="text-gray-400">(opcional)</span>
						</label>
						<input
							bind:value={valores.razonSocial}
							name="razonSocial"
							class="w-full px-3 py-2 border rounded-lg {errores.razonSocial
								? 'border-red-500'
								: 'border-gray-300'}"
						/>
						{#if errores.razonSocial}<p class="text-red-500 text-xs mt-1">
								{errores.razonSocial}
							</p>{/if}
					</div>

					<div class="flex gap-3">
						<button
							type="button"
							on:click={prevStep}
							class="w-full border border-gray-300 text-gray-700 py-2 rounded-lg"
						>
							Anterior
						</button>
						<button
							type="button"
							on:click={nextStep}
							class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-2 rounded-lg"
						>
							Siguiente
						</button>
					</div>
				</div>
			{/if}

			<!-- PASO 3: Confirmación + Submit -->
			{#if step === 3}
				<div in:slide={{ duration: 300 }}>
					<h2 class="text-base font-semibold text-gray-900 mb-2">Confirmar</h2>
					<div class="text-sm text-gray-700 space-y-1 mb-6">
						<p><span class="font-medium">Nombre:</span> {valores.nombre}</p>
						<p><span class="font-medium">Correo:</span> {valores.correo}</p>
						<p><span class="font-medium">Empresa:</span> {valores.nombreComercial}</p>
						{#if valores.razonSocial}
							<p><span class="font-medium">Razón social:</span> {valores.razonSocial}</p>
						{/if}
					</div>

					<div class="flex gap-3">
						<button
							type="button"
							on:click={prevStep}
							class="w-full border border-gray-300 text-gray-700 py-2 rounded-lg"
						>
							Anterior
						</button>

						<button
							type="submit"
							class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-2 rounded-lg"
						>
							Crear cuenta
						</button>
					</div>
				</div>
			{/if}

			<!-- Hidden: asegura que siempre se envíen TODOS los campos al server -->
			<input type="hidden" name="nombre" value={valores.nombre} />
			<input type="hidden" name="correo" value={valores.correo} />
			<input type="hidden" name="password" value={valores.password} />
			<input type="hidden" name="confirmPassword" value={valores.confirmPassword} />
			<input type="hidden" name="nombreComercial" value={valores.nombreComercial} />
			<input type="hidden" name="razonSocial" value={valores.razonSocial} />
		</form>
	</div>
</div>
