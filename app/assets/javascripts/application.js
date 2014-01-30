// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require js/jquery.min
//= require jquery_ujs
//= require plugins/jquery-ui/jquery-ui-1.10.2.custom.min
//= require plugins/bootstrap/js/bootstrap.min
//= require plugins/blockUI/jquery.blockUI
//= require plugins/iCheck/jquery.icheck.min
//= require plugins/perfect-scrollbar/src/jquery.mousewheel
//= require plugins/perfect-scrollbar/src/perfect-scrollbar
//= require js/main
//= require plugins/flot/jquery.flot
//= require plugins/flot/jquery.flot.pie
//= require plugins/flot/jquery.flot.resize.min
//= require plugins/jquery.sparkline/jquery.sparkline
//= require plugins/jquery-easy-pie-chart/jquery.easy-pie-chart
//= require plugins/jquery-ui-touch-punch/jquery.ui.touch-punch.min

//= require cocoon
//= require plugins/fullcalendar/fullcalendar/fullcalendar

//= require plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min
//= require plugins/autosize/jquery.autosize.min
//= require plugins/select2/select2.min
//= require plugins/jquery.maskedinput/src/jquery.maskedinput
//= require plugins/bootstrap-datepicker/js/bootstrap-datepicker
//= require plugins/bootstrap-timepicker/js/bootstrap-timepicker.min
//= require plugins/bootstrap-daterangepicker/moment.min
//= require plugins/bootstrap-daterangepicker/daterangepicker
//= require plugins/bootstrap-colorpicker/js/bootstrap-colorpicker
//= require plugins/bootstrap-colorpicker/js/commits
//= require plugins/jQuery-Tags-Input/jquery.tagsinput
//= require plugins/bootstrap-fileupload/bootstrap-fileupload.min
//= require plugins/summernote/build/summernote.min
//= require plugins/ckeditor/ckeditor
//= require plugins/ckeditor/adapters/jquery
//= require js/form-elements

//= require js/index
//= require customize
//= require plugins/bootstrap-datepicker/bootstrap-datepicker_new

jQuery(document).ready(function() {
 Main.init();
 FormElements.init();
});


$(document).ready(function(){
  $.each($(".side_table_right"),function( index, value ){
    var color = $(value).data('color');
    var _parent = $(value).parents('.parrent_table').first();
    _parent.find(".head_pack").attr("style","background:"+color+"");
  });
});


