var STORAGE_PREFIX = 'stranding_necropsy_report_';

$(document).ready(function () {
	var $reportTable = $('#allReport');
	if ($reportTable.length) {
		var initSortCol = parseInt($('#sort_col').val(), 10) || 0;
		var initSortDir = ($('#sort_dir').val() === 'desc') ? 'desc' : 'asc';

		$reportTable.DataTable({
			pageLength: 100,
			scrollX: true,
			paging: false,
			messageTop: null,
			info: false,
			responsive: true,
			title: false,
			order: [[ initSortCol, initSortDir ]],
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

		$reportTable.on('order.dt', function () {
			updateSortInputs();
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

	var $reportForm = $('#searchAllReports');
	var resetReportPage = function () {
		$('#pge').val(1);
		$('#is_pagination_click').val('0');
		$('#exportAll').val('0');
		try { sessionStorage.removeItem('stranding_report_scroll_to_results'); } catch(e) {}
	};

	$('#add').on('click', function () {
		resetReportPage();
	});

	$reportForm.on('change', 'select, input, textarea', function () {
		if (this.name !== 'pge' && this.name !== 'is_pagination_click' && this.name !== 'exportAll' && this.name !== 'exportFormat') {
			resetReportPage();
		}
	});

	$(document).on('click', '.stranding-report-page-link', function (event) {
		event.preventDefault();
		paginate($(this).data('report-page'));
	});

	$('#searchAllReports').on('submit', function () {
		saveFormState();
	});

	var shouldScroll = false;
	try {
		if (sessionStorage.getItem('stranding_report_scroll_to_results') === '1') {
			shouldScroll = true;
			sessionStorage.removeItem('stranding_report_scroll_to_results');
		}
	} catch(e) {}

	if (shouldScroll) {
		if ('scrollRestoration' in history) {
			try { history.scrollRestoration = 'manual'; } catch(e) {}
		}
		scrollToReportResults(false);
		setTimeout(function () {
			scrollToReportResults(true);
		}, 150);
		setTimeout(function () {
			scrollToReportResults(false);
		}, 400);
	}
});

function scrollToReportResults(smooth) {
	var $target = $('#report-results');
	if (!$target.length) {
		$target = $('#allReport');
	}
	if (!$target.length) return;

	var headerHeight = $('#header').outerHeight() || 60;
	var targetTop = $target.offset().top - headerHeight - 15;
	if (targetTop < 0) targetTop = 0;

	if (smooth) {
		$('html, body').stop().animate({
			scrollTop: targetTop
		}, 300);
	} else {
		window.scrollTo(0, targetTop);
	}
}

function showdate(){

	$('#date').trigger('click');
}
function updateSortInputs() {
	if (!window.jQuery) return;
	var $ = window.jQuery;
	var $table = $('#allReport');
	if (!$table.length || !$.fn.DataTable || !$.fn.DataTable.isDataTable('#allReport')) return;

	var dt = $table.DataTable();
	var order = dt.order();
	if (order && order.length && order[0].length >= 2) {
		var colIdx = parseInt(order[0][0], 10) || 0;
		var colDir = order[0][1] === 'desc' ? 'desc' : 'asc';
		var $th = $table.find('thead th').eq(colIdx);
		var headerText = $th.text().trim();
		var colName = headerText;
		if (headerText === 'Tab Name') {
			colName = 'SourceTable';
		} else if (headerText === 'Fnumber') {
			colName = 'Fnumber';
		} else if (headerText === 'Date') {
			colName = 'Date';
		}

		$('#sort_col').val(colIdx);
		$('#sort_dir').val(colDir);
		$('#sort_name').val(colName);
	}
}

function paginate(value){
	var pageNumber = parseInt(value, 10);
	var form = document.getElementById('searchAllReports');
	var pageInput = document.getElementById('pge');

	if (isNaN(pageNumber) || pageNumber < 1 || !form || !pageInput) {
		return false;
	}

	updateSortInputs();
	pageInput.value = pageNumber;
	var isPaginationInput = document.getElementById('is_pagination_click');
	if (isPaginationInput) {
		isPaginationInput.value = '1';
	}

	try {
		sessionStorage.setItem('stranding_report_scroll_to_results', '1');
	} catch(e) {}

	if (typeof saveFormState === 'function') {
		try { saveFormState(); } catch(e) {}
	}

	if (form.action) {
		form.action = form.action.split('#')[0] + '#report-results';
	}

	form.submit();
	return false;
}
function excel(){
	var form = document.getElementById('searchAllReports');
	if (!form) return;

	updateSortInputs();

	var $btn = $('button[name="excelExport"]');
	var originalBtnHtml = $btn.length ? $btn.html() : '';
	if ($btn.length) {
		$btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Exporting...');
	}

	function restoreButton() {
		if ($btn.length) {
			$btn.prop('disabled', false).html(originalBtnHtml);
		}
	}

	function doXlsxExport() {
		var $form = $(form);
		var $exportAll = $('#exportAll');
		if (!$exportAll.length) {
			$exportAll = $('<input type="hidden" name="exportAll" id="exportAll" value="0">').appendTo(form);
		}
		var $exportFormat = $('#exportFormat');
		if (!$exportFormat.length) {
			$exportFormat = $('<input type="hidden" name="exportFormat" id="exportFormat" value="">').appendTo(form);
		}

		$exportAll.val('1');
		$exportFormat.val('raw_table');

		var serializedData = $form.serialize();

		$exportAll.val('0');
		$exportFormat.val('');

		var url = form.action ? form.action.split('#')[0] : window.location.href.split('#')[0];

		$.ajax({
			url: url,
			type: 'POST',
			data: serializedData,
			dataType: 'html',
			success: function(responseHtml) {
				try {
					if (!responseHtml || responseHtml.indexOf('<table') === -1) {
						alert('No records found to export.');
						restoreButton();
						return;
					}

					var wb = XLSX.read(responseHtml, { type: 'string', raw: true });
					if (!wb || !wb.SheetNames || !wb.SheetNames.length) {
						alert('No records found to export.');
						restoreButton();
						return;
					}

					var firstSheetName = wb.SheetNames[0];
					var ws = wb.Sheets[firstSheetName];
					wb.Sheets['Stranding & Necropsy'] = ws;
					if (firstSheetName !== 'Stranding & Necropsy') {
						delete wb.Sheets[firstSheetName];
					}
					wb.SheetNames[0] = 'Stranding & Necropsy';

					if (ws && ws['!ref']) {
						var range = XLSX.utils.decode_range(ws['!ref']);
						var colWidths = [];
						for (var C = range.s.c; C <= range.e.c; ++C) {
							var maxLen = 10;
							for (var R = range.s.r; R <= range.e.r; ++R) {
								var cell = ws[XLSX.utils.encode_cell({ r: R, c: C })];
								if (cell && cell.v !== undefined && cell.v !== null) {
									var len = String(cell.v).length;
									if (len > maxLen) maxLen = Math.min(len, 50);
								}
							}
							colWidths.push({ wch: maxLen + 2 });
						}
						ws['!cols'] = colWidths;
					}

					var today = new Date();
					var yyyy = today.getFullYear();
					var mm = String(today.getMonth() + 1);
					if (mm.length < 2) mm = '0' + mm;
					var dd = String(today.getDate());
					if (dd.length < 2) dd = '0' + dd;
					var fileName = 'StrandingNecropsyReport_' + yyyy + '-' + mm + '-' + dd + '.xlsx';

					XLSX.writeFile(wb, fileName);
				} catch(err) {
					console.error('XLSX export error:', err);
					fallbackIframeExport();
				} finally {
					restoreButton();
				}
			},
			error: function(xhr, status, error) {
				console.error('Export request failed:', error);
				fallbackIframeExport();
				restoreButton();
			}
		});
	}

	if (typeof XLSX !== 'undefined') {
		doXlsxExport();
	} else {
		var script = document.createElement('script');
		script.src = 'https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js';
		script.onload = function() {
			doXlsxExport();
		};
		script.onerror = function() {
			fallbackIframeExport();
			restoreButton();
		};
		document.head.appendChild(script);
	}
}

function fallbackIframeExport() {
	var form = document.getElementById('searchAllReports');
	if (!form) return;

	var exportInput = document.getElementById('exportAll');
	if (!exportInput) {
		exportInput = document.createElement('input');
		exportInput.type = 'hidden';
		exportInput.name = 'exportAll';
		exportInput.id = 'exportAll';
		form.appendChild(exportInput);
	}

	var formatInput = document.getElementById('exportFormat');
	if (formatInput) {
		formatInput.value = '';
	}

	var iframe = document.getElementById('export_iframe');
	if (!iframe) {
		iframe = document.createElement('iframe');
		iframe.id = 'export_iframe';
		iframe.name = 'export_iframe';
		iframe.style.display = 'none';
		document.body.appendChild(iframe);
	}

	var originalTarget = form.target || '';
	var originalAction = form.action || '';

	exportInput.value = '1';
	form.target = 'export_iframe';
	form.action = form.action.split('#')[0];

	form.submit();

	setTimeout(function() {
		form.target = originalTarget;
		form.action = originalAction;
		exportInput.value = '0';
		if (formatInput) {
			formatInput.value = '';
		}
	}, 1000);
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
		if ($(this).attr('name') === 'pge' || $(this).attr('name') === 'is_pagination_click' || $(this).attr('name') === 'exportAll' || $(this).attr('name') === 'exportFormat' || $(this).attr('name') === 'sort_col' || $(this).attr('name') === 'sort_dir' || $(this).attr('name') === 'sort_name') return;
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
		if ($(this).attr('name') === 'pge' || $(this).attr('name') === 'is_pagination_click' || $(this).attr('name') === 'exportAll' || $(this).attr('name') === 'exportFormat' || $(this).attr('name') === 'sort_col' || $(this).attr('name') === 'sort_dir' || $(this).attr('name') === 'sort_name') return;
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
