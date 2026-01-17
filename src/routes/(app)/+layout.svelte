<script lang="ts">
  import Sidebar from '$lib/components/layout/Sidebar.svelte';
  import TopNav from '$lib/components/layout/TopNav.svelte';
  import Footer from '$lib/components/layout/Footer.svelte';

  export let data;
</script>

<div class="app">
  <aside class="app__sidebar">
    <Sidebar user={data.user} />
  </aside>

  <div class="app__main">
    <TopNav user={data.user} />

    <main class="app__content">
      <slot />
    </main>

    <Footer />
  </div>
</div>

<style>
  .app {
    min-height: 100vh;
    display: grid;
    grid-template-columns: 280px 1fr;
  }

  .app__sidebar {
    border-right: 1px solid rgba(255, 255, 255, 0.08);
    background: rgba(255, 255, 255, 0.02);
  }

  .app__main {
    display: grid;
    grid-template-rows: auto 1fr auto;
    min-width: 0;
  }

  .app__content {
    min-width: 0;
    padding: 0.75rem;
  }

  @media (max-width: 980px) {
    .app {
      grid-template-columns: 1fr;
    }
    .app__sidebar {
      display: none; /* luego hacemos versión móvil (drawer) */
    }
    .app__content {
      padding: 0.75rem;
    }
  }
</style>
