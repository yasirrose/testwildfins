$(document).ready(function () {

	// $('#data-table').DataTable({
	// 	dom: 'Bfritp',
	// 	buttons: [
	// 		{
	// 			extend: 'excelHtml5',
	// 			title: 'Friend Report',
	// 			autoFilter: true,
	// 			text: "Export Excel",
	// 			className: 'btn btn-success width-100 m-r-5 ml-auto' // Custom class
	// 		},
	// 	],
	// 	initComplete: function() {
			
	// 		$('.dt-button').removeClass('dt-button');
	// 	}
	// });

	$('#data-table').DataTable({
		dom: 'Bfritp',
		buttons: [
			{
				extend: 'excelHtml5',
				title: 'Friend Report',
				autoFilter: true,
				text: "Export Excel",
				className: 'btn btn-success width-100 m-r-5 ml-auto',
				customize: function (xlsx) {
					// Your existing Excel customization code
					var sheet = xlsx.xl.worksheets['sheet1.xml'];
					var col = $('col', sheet); 
					col.eq(3).attr('width', 150);
	
					$('row c', sheet).each(function () {
						var cell = $(this);
						var cellValue = cell.text();
						if (cellValue.length > 0) {
							cell.attr('s', '55');
						}
					});
	
					var stylesheet = xlsx.xl['styles.xml'];
					var styleDef = `
						<xf xfId="0" applyAlignment="1">
							<alignment wrapText="1"/>
						</xf>`;
					$('cellXfs', stylesheet).append(styleDef);
				}
			},
			{
				extend: 'csvHtml5',
				title: 'Friend Report',
				text: "Export CSV",
				className: 'btn btn-success width-100 m-r-5 ml-auto' // Custom class for CSV button
			}
		],
		initComplete: function () {
			$('.dt-button').removeClass('dt-button');
		}
	});
	
	

	$('input[name="date"]').daterangepicker({
		opens: "right",
		format: "MM/DD/YYYY",
		separator: " - ",
		startDate: "01/01/" + moment().format('YYYY'),
		endDate: moment(),
		minDate: "01/01/1990"
	});

});
function showdate(){
	$('#date').trigger('click');
}


function paginate(value){
	$("#pge").val(value);
	$("#searchAllReports").submit();
}
function clearAll(){
    $('#cetaceanSpecies').val(null).trigger('change');
	// $('select[name="cetaceanSpecies"]').val('');
	$('select[name="CetaceanId"]').val('');
	
}
function excel(exportFormat) {
    var form = document.getElementById('searchAllReports');
    form.action = 'http://test.wildfins.org/index.cfm?Module=Reporting&Page=ExportFriend&exportFormat=' + exportFormat;
    form.submit();
    form.action = '';
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

