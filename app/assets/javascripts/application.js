// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery_ujs
//= require chosen-jquery
//= require_tree .
globalData = {};

function setGlobalData(key, value){
  globalData[key] = value;
}

function getGlobalData(key){
  return globalData[key];
}

$(document).ready( function () {
  $('.js-data-table').DataTable({
    fixedHeader: true, 
    scrollY: 400
  });
  var userId = getGlobalData('userId');
  if(userId) {
    $.ajax({
      type: 'GET',
      url: '/members/' + userId + '/calculate_surveys',
      data: {}
    });
  }

  // Override the default confirm dialog by rails
  $.rails.allowAction = function(link){
    if (link.data("confirm") == undefined){
      return true;
    }
    $.rails.showConfirmationDialog(link);
    return false;
  }

  // User click confirm button
  $.rails.confirmed = function(link){
    link.data("confirm", null);
    link.trigger("click.rails");
  }

  // Display the confirmation dialog
  $.rails.showConfirmationDialog = function(link){
    swal({
      title: "Are you sure to delete it?",
      text: "This will permanently remove data from system.",
      icon: "warning",
      dangerMode: true,
      buttons: ["Cancel", "Confirm"]
    })
    .then(willDelete => {
      if (willDelete) {
        $.rails.confirmed(link);
      }
    });
  }
});




