$(document).ready(function(){
  $('#mm').on('change', function(){
    var total = $('#total-nominal').data('value');
    var new_total = $(this).val() * total;
    var new_total_str = new_total.formatMoney(0,'.',',');
    $('#total-nominal').html(new_total_str);
    $('#hidden_total').val(new_total);
  });

  Number.prototype.formatMoney = function(c, d, t){
    var n = this, 
    c = isNaN(c = Math.abs(c)) ? 2 : c, 
    d = d == undefined ? "." : d, 
    t = t == undefined ? "," : t, 
    s = n < 0 ? "-" : "", 
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };

 // date picker
 $('.datepicker').datepicker();
})