(function(root){
  var _job_postings = [];
  root.BenchStore = $.extend({}, EventEmitter.prototype, {
    all: function () {
      return _benches.slice(0);
    }
  })
})(this);
