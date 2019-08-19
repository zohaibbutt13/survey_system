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
});