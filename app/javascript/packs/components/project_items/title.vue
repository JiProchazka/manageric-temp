<template>
  <span class="inline-block">
    <span class="inline-editable inline-block" v-if="!showTextbox" @click="onClick">{{this.content}}</span>
    <input ref="titleTextbox" type="text" class="form-control" placeholder="Type title here.." v-if="showTextbox" @blur="onBlurTextbox" @keyup="keyUp" v-model="content" />
  </span>
</template>
<script>
  import Vue from 'vue'
  import VueResource from 'vue-resource'
  import Api from '../../helpers/api'
  import ProjectHelper from '../../helpers/project_helper'
  Vue.use(VueResource)

  export default {
    props: ['title'],
    data() {
      return {
        showTextbox: false,
        content: ''
      }
    },
    methods: {
      onClick: function() {
        this.showTextbox = true
        setTimeout(() => {
          this.$refs.titleTextbox.focus()
        })
      },
      onBlurTextbox: function() {
        if (this.content != '') {
          this.showTextbox = false
          Api.post('/api/project_items/save-title', { project: ProjectHelper.getProjectId(), title: this.content }).then(response => {
            // NOOP
          }, response => {
            Api.error(response)
          })
        }
      },
      keyUp: function(event) {
        if(event.key == "Enter")
        {
          this.$refs.titleTextbox.blur()
        }
      }
    },
    created() {
      this.content = this.title
    }
  }
</script>
