import Vue from 'vue'
import VueResource from 'vue-resource'
import Api from './helpers/api'
Vue.use(VueResource)

var storiesElement = document.getElementById('userstories')
if (storiesElement != null) {
  var stories = new Vue({
    el: storiesElement,
    data: {
      app: {
        showHelp: false
      }
    },
    methods: {
      showHelp: function(val) {
        this.app.showHelp = val
      }
    }
  })
}

var usersElement = document.getElementById('users')
if (usersElement != null) {
  var users = new Vue({
    el: usersElement,
    data: {
      owner: {},
      users: [],
      foundUsers: [],
      term: ''
    },
    watch: {
      term: function (val) {
        this.searchForUser(val)
      }
    },
    methods: {
      searchForUser: function(val) {
        if (val.length >= 3) {
          this.foundUsers = []
          Api.get('/api/users/search/' + val).then(response => {
            // inserting only if not already in the list of users an clients or is not the owner
            response.body.forEach((user) => {
              if (this.owner._id === user._id) {
                return;
              }
              for (var i = 0; i < this.users.length; i++) {
                if (this.users[i]._id === user._id) {
                  return;
                }
              }
              if (this.foundUsers == null) {
                this.foundUsers = []
              }
              this.foundUsers.push(user)
            })
          }, response => {
            Api.error(response)
          });
        } else {
          this.foundUsers = null
        }
      },
      loadProjectUsers: function(val) {
        Api.get('/api/users/get-for-project/' + val).then(response => {
          this.users = []
          response.body.users.forEach((user) => {
            this.users.push(user)
          })
          this.owner = response.body.owner
        }, response => {
          Api.error(response)
        })
      },
      addUserToProject: function(user) {
        Api.post('/api/users/add-to-project', { project: this.getProjectId(), user: user._id }).then(response => {
          this.users.push(user)
          this.foundUsers = null
          this.term = ''
          $.notify('User was added to the project', {type: 'success', blur: 0, delay: 0, align:"center", verticalAlign:"top"})
        }, response => {
          Api.error(response)
        })
      },
      removeUserFromProject: function(user) {
        Api.post('/api/users/remove-from-project', { project: this.getProjectId(), user: user._id }).then(response => {
          var index = this.users.indexOf(user)
          if (index >= 0) {
            this.users.splice(index, 1)
            $.notify('User was removed from the project', {type: 'success', blur: 0, delay: 0, align:"center", verticalAlign:"top"})
          }
        }, response => {
          Api.error(response)
        })
      },
      getProjectId: function() {
        var arr = window.location.href.split('/')
        return arr[arr.length - 1].replace('#', '')
      }
    },
    created() {
      this.loadProjectUsers(this.getProjectId())
    }
  });
}
