import Vue from 'vue'
import Description from './components/project_items/description.vue'
import Title from './components/project_items/title.vue'
import Comment from './components/comments/content.vue'
var element = document.getElementById('project_item')
if (element != null) {
  var test = new Vue({
    el: element,
    components: {
      manDescription: Description,
      manTitle: Title,
      manComment: Comment
    }
  })
}

// changing project item state buttons handler
$("[data-behavior='submit-on-change']").change(function() {
  var form = $(this).closest('form');
  form.submit();
});
