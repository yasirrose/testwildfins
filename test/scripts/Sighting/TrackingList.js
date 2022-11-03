$(document).ready(function() {
    $('#example').DataTable({
		"pageLength": 10,
		"paging": true,
		"info":    true,
		responsive: true,
	});
} );
function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticDataNew.cfc?method=DeleteTrackingList",
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
	
	value = $('#species-'+id).text();
	$('#species option:contains(' + value + ')').each(function(){
		if ($(this).text() == value) {
			$(this).attr('selected', 'selected').change();
			return false;
		}
		return true;
	});
	setTimeout(function(){ 
		cd = $('#code-'+id).text();
	$('#code option:contains(' + cd + ')').each(function(){
		if ($(this).text() == cd) {
			$(this).attr('selected', 'selected').change();
			return false;
		}
		return true;
	});
	cda = $('#code1-'+id).text();
	$('#code1 option:contains(' + cda + ')').each(function(){
		if ($(this).text() == cda) {
			$(this).attr('selected', 'selected').change();
			return false;
		}
		return true;
	});
	cdaa = $('#code2-'+id).text();
	$('#code2 option:contains(' + cdaa + ')').each(function(){
		if ($(this).text() == cdaa) {
			$(this).attr('selected', 'selected').change();
			return false;
		}
		return true;
	});
	}, 1000);

	// $('#species').val($('#species-'+id).text());
	// $('#code').val($('#code-'+id).text()).change();
	console.log($('#categories-'+id).text());
	$('#cetaceanName').val($('#cetaceanName-'+id).text());
	$('#trackingDate').val($('#trackingDate-'+id).text());
	$('#categories').val($('#categories-'+id).text());
	$('#comments').val($('#comments-'+id).text());
	$("#add").attr('name', 'editTracking');
	$("#add").text('UPDATE');
	$("#Track_id").val(id);
	var ss = $("#seletecActiveValue-"+id).text();
	if(ss == "Active"){
		$("#active").attr('checked', 'checked');
	}else{
		$("#inactive").attr('checked', 'checked');
	}
	$("html, body").animate({ scrollTop: 0 }, 600);
	
}

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			trackingDate  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Tracking Date'
                    }
                }
            },
        }
    });
function ApplyPagination(startmeup)
{
	document.paginationform.startHereIndex.value = startmeup;
	document.paginationform.submit();
}

$("button[type='reset']").on("click", function(event){
	// $("#add").attr('name', 'add'+pagename);
	$("#add").text('Submit');
	$("#alt_img").attr('src', 'http://cloud.wildfins.org/no-image.jpg');
	$("#Track_id").val('');
	$("#inactive").prop('checked', false);
	$("#active").prop('checked', false);
	$("#code").val('');

});