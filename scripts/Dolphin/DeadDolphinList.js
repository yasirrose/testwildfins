$(document).ready(function(){
	
	$(".getYear").change(function(){
	var deadDate = $(this).val();
	if(deadDate.length > 0){
	var birthDate = $(".getYearBirth").val();
	var diff = parseInt(deadDate) - parseInt(birthDate);
	}else{
	var diff = 0;
	}
	
	$(".ageOfDead").val(diff);
	
	});
	
	$("#body_length").keyup(function(){
            
			 var value = $(this).val();
			 var sex = $('#gensex').val();
			 if(sex =='M' && value >= 246){
				 $('#agCohort').val('Adult');
				 }
				 else if(sex=='M'&& value==161&& value<246){
					 $('#agCohort').val('Juvenile');
					 }
					 else if(sex=='F'&&value>=231){
						 $('#agCohort').val('Adult');
						 }
						 else if(sex=='F'&& value==161 && value<231){
							 $('#agCohort').val('Juvenile');
							 }
        });

		
			
			
			
		

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