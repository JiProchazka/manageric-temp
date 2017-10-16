<template>
  <div>
    <div class="inline-editable text-muted" v-if="isContentEmpty && !showTextbox" @click="onClick">Type description here..</div>
    <div class="inline-editable" v-if="!isContentEmpty && !showTextbox" @click="onClick"><nl2br tag="div" :text="this.content" /></div>
    <textarea ref="contentTextArea" class="form-control" rows="6" placeholder="Type description here.." v-if="showTextbox" @blur="onBlurTextbox" v-model="content"></textarea>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VueResource from 'vue-resource'
  import Api from '../../helpers/api'
  import ProjectHelper from '../../helpers/project_helper'
  import Nl2br from 'vue-nl2br'
  Vue.use(VueResource)

  export default {
    props: ['description'],
    components: {
      Nl2br,
    },
    data() {
      return {
        showTextbox: false,
        content: ''
      }
    },
    computed: {
      isContentEmpty: function () {
        return this.content == ''
      }
    },
    methods: {
      onClick: function() {
        this.showTextbox = true
        setTimeout(() => {
          this.$refs.contentTextArea.focus()
        })
      },
      onBlurTextbox: function() {
        this.showTextbox = false
        Api.post('/api/project_items/save-description', { project: ProjectHelper.getProjectId(), description: this.content }).then(response => {
          // NOOP
        }, response => {
          Api.error(response)
        })
      }
    },
    created() {
      this.content = this.description
    }
  }
</script>
