<template>
  <div id="app">
    <aside>
      <header>upcoming</header>
      <ol>
        <li v-for="item in upcoming">
          <clock-icon />
          <span class="menu-entry">{{ item.title }}</span>
        </li>
      </ol>

      <header>boards</header>
      <ol>
        <li v-for="board in boards">
          <clipboard-icon />
          <span class="menu-entry">{{ board.name }}</span>
        </li>
      </ol>
    </aside>

    <main>
      <loader-icon class="spin" />
    </main>

  </div>
</template>

<script>
import { ClockIcon, ClipboardIcon, LoaderIcon } from 'vue-feather-icons'

export default {
  components: { ClockIcon, ClipboardIcon, LoaderIcon },
  data: () => ({
    loaded: false,
    boards: []
  }),
  computed: {
    upcoming () {
      return []
    }
  },
  mounted () {
    const urlBase = 'https://my.api.mockaroo.com'
    const options = {headers: {'X-API-Key': '22bb4ab0'}}
    fetch(`${urlBase}/boards`, options).then(r => r.json()).then(boards => {
      boards.forEach(board => {
        boards.tasks = []
        boards.loaded = false

        const url =`${urlBase}/boards/${board.id}/tasks`
        fetch(url, options).then(r => r.json()).then(tasks => {
          board.tasks = tasks
          board.loaded = true
        })
      })
      this.boards = boards
    })
  }
}
</script>

<style>
  body {
    background: #FAFAFA;
    margin: 0;
    padding: 0;
  }
  #app {
    display: flex;
    min-height: 100vh;
  }

  #app > aside {
    flex: 0 0 20vw;
    background: #F1F5FF;
  }
  #app > main {
    flex: 1 1 auto;
  }

  aside > header {
    font-variant: small-caps;
    font-weight: bold;
    font-size: 1.5em;
    color: #555;
    padding: 1em 0 0 1em;
  }
  aside > ol {
    list-style: none;
    padding: 0;
  }
  aside > ol > li {
    line-height: 2em;
    padding: .2em 1.5em;
  }
  aside > ol > li:hover {
    background: #FAFAFA;
    cursor: pointer;
  }
  .feather, .menu-entry {
    line-height: 24px;
    vertical-align: middle;
  }

  .spin {
    animation: spin 4s infinite linear;
  }
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
</style>
