$(document).ready(function() {
    handleDateTimePicker = function () {
        "use strict";
        $('#datetimepicker_StartTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#StartTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_EndTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#EndTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Date').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#date").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Date_TD').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#date").formValidation('revalidateField', name);
        });
    
    }  
    handleDateTimePicker();
    handleJqueryTagIt(); 
})
const DiagnosticTestArray = [];
const TestResultsArray = [];
const DiagnosticLabArray = [];
const TestingDateArray = [];

function AddNewTest() {
    DiagnosticTest = $("#DiagnosticTest").val();
    TestResults = $("#TestResults").val();
    DiagnosticLab = $("#DiagnosticLab").val();
    TestingDate = $("#TestingDate").val();
    if (DiagnosticTest != '' && TestResults !='') {
        DiagnosticTestArray.push(DiagnosticTest);
        TestResultsArray.push(TestResults);
        if(DiagnosticLab == ""){
            DiagnosticLabArray.push(0);
        }else{
            DiagnosticLabArray.push(DiagnosticLab);
        }
        if(TestingDate == ""){
            TestingDateArray.push(0);
        }else{
            TestingDateArray.push(TestingDate);
        }
        $("#DT").val(DiagnosticTestArray);
        $("#TR").val(TestResultsArray);
        $("#DLAB").val(DiagnosticLabArray);
        $("#TD").val(TestingDateArray);
        $("#drugHistory").show();
        $("#drugHistory > tbody").append('<tr><td>' +  DiagnosticTest + '</td><td>' + TestResults +'</td><td>' + DiagnosticLab + '</td><td>' + TestingDate + '</td><td></td></tr>'); 
        $("#DiagnosticTest").val('');
        $("#TestResults").val('');
        $("#DiagnosticLab").val('');
        $("#TestingDate").val('');
        img();
        // $("#files").val('');

    }
}
var PDFArray = [];
function img(){
    if($('#files').val() != ''){
        var files = $('#files').prop('files');
        var f = files[0];
        if(f.size < 10000000){
            if(f.type == 'application/pdf'){ 
                $('#files').hide();
                $('#files').attr('name','pdf');   
                $('#files').attr('id','fi');   
                src= URL.createObjectURL(f);
                PDFArray.push(f.name);
                $('#files').hide();
                $('#filediv').append('<input class="input-style xl-width" type="file"  name="emptypdf" id="files" accept="application/pdf">')

                $('#drugHistory').find('td:last').append('<span><a data-toggle="modal" data-target="#myModal" href="#" title="'+src+'" target="blank"><img class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="'+f.name+'" onclick="selected(this)"/></a><br/></span>');
            }else{
                alert('Selected file is not PDF');
                PDFArray.push(0);
            }
        }else{
            alert('Selected file is Large than 10MB');
            PDFArray.push(0);
        }
    }else{
        PDFArray.push(0);
    }    
    $('#pdfFiles').val(PDFArray);

}

function selected(elem) {
    var element = elem;
    $('#emb').attr('src', element.parentNode.title);
    $('#pdfname').html(element.title);
    
}
function chkreq(e){
    if($("#Fnumber").val().trim() == ""){
        $("#Fnumber").val('');
    }
    if($("#Date").val().trim() == ""){
        $("#Date").val('');
    }
}


$( "#deleteAncillaryAllRecord" ).click(function() {
    $('#date').val('mm/dd/yyyy');
    $('#Fnumber').val(' ');
  });