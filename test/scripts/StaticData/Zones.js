function deleteRecord(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticData.cfc?method=DeleteZones",
		type : "get",
		data : {id : id},
		success:function(data) {
			$('html, body').animate({scrollTop : 0},800);
			$(".message").show();
			$("#remov_"+id).remove();
			setTimeout(function(){$(".message").hide();},3000);
		}
	});
	}
	}); 
}

function updateRecord(id) {
	$("html, body").animate({ scrollTop: 0 }, 600);
	$('#ZONE').val($('#ZONE-'+id).text());
	$('#GRIDNUM').val($('#GRIDNUM-'+id).text());
	$('#LAT_DD').val($('#LAT_DD-'+id).text());
	$('#LONG_DD').val($('#LONG_DD-'+id).text());
	$('#EASTING').val($('#EASTING-'+id).text());
	$('#NORTHING').val($('#NORTHING-'+id).text());
	$('#ZSEGMENT').val($('#ZSEGMENT-'+id).text());
	$("#add").attr('name', 'editZones');
	$("#add").text('Edit');
	$("#zones_id").val(id);
}


$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			ZONE  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter ZONE'
                    }
                }
            },
			GRIDNUM  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter GRIDNUM'
                    }
                }
            },
			LAT_DD  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter LAT_DD'
                    }
                }
            },
			LONG_DD : {
                validators: {
                    selectionNotFirst: {
                    	message: 'Please do LONG_DD'
                    }
                }
            },
			EASTING  : {
                validators: {
                	notEmpty: {
                        message: 'Please enter EASTING'
                    }
                }
            },
			NORTHING  : {
                validators: {
                	notEmpty: {
                        message: 'Please enter NORTHING'
                    }
                }
            },
			ZSEGMENT  : {
                validators: {
                	notEmpty: {
                        message: 'Please enter ZSEGMENT'
                    }
                }
            }
        }
    });

function ApplyPagination(startmeup)
{
	document.paginationform.startHereIndex.value = startmeup;
	document.paginationform.submit();
}