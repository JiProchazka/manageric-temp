import Vue from 'vue'

var api = {
  get: function(path) {
    var csrf = getCsrf()
    var token = getToken()
    return Vue.http.get(path, { headers: {'X-CSRF-Token': csrf, 'Content-Type':'application/json', 'Authorization':'Token token=' + token } })
  },
  post: function(path, obj) {
    var csrf = getCsrf()
    var token = getToken()
    return Vue.http.post(path, obj, { headers: {'X-CSRF-Token': csrf, 'Content-Type':'application/json', 'Authorization':'Token token=' + token } })
  },
  error: function(response) {
    $.notify("Ooops! Something went wrong", {type: "alert", blur: 0.4, delay: 0, align:"center", verticalAlign:"top"})
    console.error(response)
  }
}

function getCsrf() {
  document.querySelector('meta[name="csrf-token"]').content
}

function getToken() {
  var token = document.getElementById('access_token')
  if (token == undefined) {
    console.error('Hidden input with user\'s access token is missing on the page')
  }
  return token.value
}

export default api;
