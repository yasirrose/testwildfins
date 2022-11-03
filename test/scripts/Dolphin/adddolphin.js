$(document).ready(function(){
		

handleDateTimePicker = function() {
        "use strict";
        $(".datepicker_addDol").datetimepicker({
            format: 'YYYY-MM-DD'
        }).on('dp.change', function(e) {
         // Revalidate the date field
		var name=$(this).attr('name');
		$('#add_dolphinto_dolhpin').formValidation('revalidateField',name);
	
        });
		}
	
handleDateTimePicker();


 $('#changesex').change(function () {
     $('#sourcedsex').show();
 })
});