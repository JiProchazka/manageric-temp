var projectHelper = {
  getProjectId: function() {
    var arr = window.location.href.split('/')
    return arr[arr.length - 1].replace('#', '')
  }
}

export default projectHelper;
