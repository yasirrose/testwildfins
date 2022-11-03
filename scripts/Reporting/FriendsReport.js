$(document).ready(function () {
	$('#allReport').DataTable({
		"pageLength": 100,
		"scrollX": true,
		"paging": false,
		"info":    false,
		responsive: true,
		dom: 'rtip',
	});
	
});
function paginate(value){
	$("#pge").val(value);
	$("#searchAllReports").submit();
}
function clearAll(){

	$('select[name="cetaceanSpecies"]').val('');
	$('select[name="CetaceanId"]').val('');
	
}
function excel(){
	form=document.getElementById('searchAllReports');
	form.action='http://test.wildfins.org/index.cfm?Module=Reporting&Page=ExportFriend';
	form.submit();
	form.action='';
}
function getcode(){
	const v = $('select[name="cetaceanSpecies"]').val();
	
	console.log(v);
	$.ajax({
		url: application_root + "StaticDataNew.cfc?method=getCetaceancodebyID",
		type: "post",
		data: {
			codes:v
		},
		success: function (data) {
			var obj = JSON.parse(data);
			console.log(obj);			
			$('select[name="CetaceanId"]').empty();
			$('select[name="CetaceanId"]').append('<option value="">Select Code</option>');
			for (var i = 0; i < obj.DATA.length; i++) {
				$('select[name="CetaceanId"]').append('<option value="'+obj.DATA[i][0]+'">'+obj.DATA[i][1]+'</option>');
			}
			
		}
	});
}

