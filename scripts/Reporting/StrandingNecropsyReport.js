var STORAGE_PREFIX = 'stranding_necropsy_report_';

$(document).ready(function () {
	var $reportTable = $('#allReport');
	if ($reportTable.length) {
		$reportTable.DataTable({
			pageLength: 100,
			scrollX: true,
			paging: false,
			messageTop: null,
			info: false,
			responsive: true,
			title: false,
			dom: 'Brtip',
			buttons: [
				{
					extend: 'copy'
				},
				{
					extend: 'excelHtml5',
					title: null
				},
				{
					extend: 'csv'
				}
			]
		});
	}

	var datePickerOptions = {
		opens: 'right',
		format: 'MM/DD/YYYY',
		separator: ' - ',
		locale: {
			format: 'MM/DD/YYYY',
			separator: ' - '
		},
		startDate: '01/01/' + moment().format('YYYY'),
		endDate: moment(),
		minDate: '01/01/1990'
	};

	$('input[name="date"]').daterangepicker(datePickerOptions);
	restoreFormState();

	$('#searchAllReports').on('submit', function () {
		saveFormState();
	});
});
function showdate(){

	$('#date').trigger('click');
}
function paginate(value){
	$("#pge").val(value);
	saveFormState();
	$("#searchAllReports").submit();
}
function excel(){
	var dataTableExcelButton = $('.buttons-excel');
	if (dataTableExcelButton.length) {
		dataTableExcelButton.trigger('click');
	}
}
function clearAll(){
	removeSavedFormState();

	var $form = $('#searchAllReports');
	if (!$form.length) {
		return;
	}

	$form.find('input[type="checkbox"], input[type="radio"]').prop('checked', false);
	$form.find('input[type="text"], input[type="number"], input[type="hidden"], textarea').val('');
	$form.find('select').val(null);
	triggerSelectUpdates($form.find('select'));
}
window.onbeforeunload = function()
{
	saveFormState();
};

function getcode(){
	var v = $('select[name="cetaceanSpecies"]').val();
	
	$.ajax({
		url: application_root + 'StaticDataNew.cfc?method=getCetaceancode',
		type: 'post',
		data: {
			codes:v
		},
		success: function (data) {
			var obj = JSON.parse(data);
			var $code = $('select[name="code"]');

			$code.empty();
			$code.append('<option value="">Select Code</option>');
			for (var i = 0; i < obj.DATA.length; i++) {
				$code.append('<option value="'+obj.DATA[i][1]+'">'+obj.DATA[i][1]+'</option>');
			}
			
		}
	});
}

function saveFormState(){
	var $form = $('#searchAllReports');
	if (!$form.length) return;

	$form.find('input[type="checkbox"]').each(function(){
		var key = getStorageKey('cb', getFieldKey(this));
		try{ localStorage.setItem(key, $(this).is(':checked')); }catch(e){}
	});

	$form.find('select').each(function(){
		var key = getStorageKey('sel', getFieldKey(this));
		try{
			var v = $(this).val();
			localStorage.setItem(key, JSON.stringify(v));
		}catch(e){}
	});

	$form.find('input[type="text"], input[type="number"], input[type="hidden"], textarea').each(function(){
		var key = getStorageKey('in', getFieldKey(this));
		try{ localStorage.setItem(key, $(this).val()); }catch(e){}
	});

	var radioGroups = {};
	$form.find('input[type="radio"]').each(function(){
		var name = $(this).attr('name');
		if (!name || radioGroups[name]) {
			return;
		}

		radioGroups[name] = true;
		var checked = $form.find('input[type="radio"][name="'+name+'"]:checked').val();
		try{ localStorage.setItem(getStorageKey('radio', name), checked===undefined?'':checked); }catch(e){}
	});
}

function restoreFormState(){
	var $form = $('#searchAllReports');
	if (!$form.length) return;

	$form.find('input[type="checkbox"]').each(function(){
		var key = getStorageKey('cb', getFieldKey(this));
		var v = localStorage.getItem(key);
		if (v === 'true'){
			$(this).prop('checked', true);
			var n = $(this).attr('name'); if (n) $('.'+n).removeClass('hidden');
		} else if (v === 'false'){
			$(this).prop('checked', false);
		}
	});

	$form.find('select').each(function(){
		var key = getStorageKey('sel', getFieldKey(this));
		var v = localStorage.getItem(key);
		if (v !== null){
			try{
				var parsed = JSON.parse(v);
				$(this).val(parsed);
			}catch(e){
				$(this).val(v);
			}
		}
	});
	triggerSelectUpdates($form.find('select'));

	$form.find('input[type="text"], input[type="number"], input[type="hidden"], textarea').each(function(){
		var key = getStorageKey('in', getFieldKey(this));
		var v = localStorage.getItem(key);
		if (v !== null) $(this).val(v);
	});

	var radioGroups = {};
	$form.find('input[type="radio"]').each(function(){
		var name = $(this).attr('name');
		if (!name) return;
		if (radioGroups[name]) return;
		radioGroups[name] = true;
		var key = getStorageKey('radio', name);
		var v = localStorage.getItem(key);
		if (v !== null){
			$form.find('input[type="radio"][name="'+name+'"]').prop('checked', false);
			if (v !== '') {
				var $to = $form.find('input[type="radio"][name="'+name+'"][value="'+v+'"]');
				if ($to.length) $to.prop('checked', true);
			}
		}
	});
}

function removeSavedFormState() {
	try {
		for (var i = localStorage.length - 1; i >= 0; i--) {
			var key = localStorage.key(i);
			if (key && key.indexOf(STORAGE_PREFIX) === 0) {
				localStorage.removeItem(key);
			}
		}
	} catch (e) {}
}

function getFieldKey(field) {
	var $field = $(field);
	return $field.attr('name') || $field.attr('id') || $field.attr('value');
}

function getStorageKey(type, key) {
	return STORAGE_PREFIX + type + '_' + key;
}

function triggerSelectUpdates($selects) {
	$selects.each(function () {
		try {
			$(this).trigger('change');
			if ($(this).data('select2')) {
				$(this).trigger('change.select2');
			}
		} catch (e) {}
	});
}
