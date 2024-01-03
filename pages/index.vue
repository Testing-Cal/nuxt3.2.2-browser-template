<template>
  <div>
     Start editing to see some magic happen :)
  </div>
</template>

<script>
  export default {
    data() {
      return {
        title: 'Nuxt Js'
      }
    },
    head() {
      return {
        title: this.title,
        meta: [
          // hid is used as unique identifier. Do not use `vmid` for it as it will not work
          {
            hid: 'Nuxt Js',
            name: 'Nuxt Js'
          }
        ],
        link: [
          { rel: 'icon', type: 'image/png', href: 'static/favicon.png' }
        ]
      }
    }
  }
</script>