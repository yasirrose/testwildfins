$(document).ready(function(){
		

handleDateTimePicker = function() {
        "use strict";
        $(".datepicker_addDol").datetimepicker({
            format: 'MM/DD/YYYY'
        }).on('dp.change', function(e) {
         // Revalidate the date field
		var name=$(this).attr('name');
		$('#add_dolphinto_dolhpin').formValidation('revalidateField',name);
	
        });
		}
	
handleDateTimePicker();


});