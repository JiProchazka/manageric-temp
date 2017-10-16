<template>
  <span>
    <span class="inline-editable inline-block" v-if="!showTextbox" @click="onClick">{{this.comment}}</span>
    <input ref="contentTextbox" type="text" class="form-control" placeholder="Type comment here.." v-if="showTextbox" @blur="onBlurTextbox" @keyup="keyUp" v-model="comment" />
  </span>
</template>
<script>
  import Vue from 'vue'
  import VueResource from 'vue-resource'
  import Api from '../../helpers/api'
  import ProjectHelper from '../../helpers/project_helper'
  Vue.use(VueResource)

  export default {
    props: ['content', 'commentId', 'projectItemId'],
    data() {
      return {
        showTextbox: false,
        comment: ''
      }
    },
    methods: {
      onClick: function() {
        this.showTextbox = true
        setTimeout(() => {
          this.$refs.contentTextbox.focus()
        })
      },
      onBlurTextbox: function() {
        if (this.comment != '') {
          this.showTextbox = false
          Api.post('/api/comments/save-content', { project_item_id: this.projectItemId, comment_id: this.commentId, content: this.comment }).then(response => {
            // NOOP
          }, response => {
            Api.error(response)
          })
        }
      },
      keyUp: function(event) {
        if(event.key == "Enter")
        {
          this.$refs.contentTextbox.blur()
        }
      }
    },
    created() {
      this.comment = this.content
    }
  }
</script>
