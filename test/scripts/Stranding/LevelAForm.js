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
        $('#datetimepicker_Date').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#date").formValidation('revalidateField', name);
        });
    
    }  
    handleDateTimePicker();
    handleJqueryTagIt(); 
    // getCode(); 
})

function getCode() {
    species = $("#species option:selected").val();
    sp = $("#species option:selected").text();
    $("#speciesee").val(sp);
    $('#code').empty();
    $('#code').append(new Option('Select Code', '0'));
    if (species != 0) {
        $.ajax({
            url: application_root +
                "SightingNew.cfc?method=getCetaceansCodeForTracking",
            Datatype: "json",
            type: "get",
            data: {
                Cetacean_Species: species,
            },
            success: function (data) {
                var obj = JSON.parse(data);
                for (var i = 0; i < obj.DATA.length; i++) {
                    $('#code').append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
                }
            }
        });
    }
}
function getFbAndSex() {
    $("#sex").val("");
    code = $("#code option:selected").val();
    if (code != 0) {
        $.ajax({
            url: application_root +
                "Stranding.cfc?method=getFbAndSexOfCode",
            Datatype: "json",
            type: "get",
            data: {
                Code_ID: code,
            },
            success: function (data) {
                var obj = JSON.parse(data);
                $('#hera').val(obj.DATA[0][1]);
                // if(obj.DATA[0][0] == 'F')
                // $('#sex').val('female');
                // else if(obj.DATA[0][0] == 'M')
                // $('#sex').val('male');
                // else if(obj.DATA[0][0] == 'U')
                // $('#sex').val('cbd');
                let F = 'Female';
                let M = 'Male';
                let C = 'CBD';
                if(obj.DATA[0][0] == 'F')
                $("#sex option:contains("+F+")").attr('selected', 'selected');
                // $('#sex').val('female');
                else if(obj.DATA[0][0] == 'M')
                $("#sex option:contains("+M+")").attr('selected', 'selected');
                else if(obj.DATA[0][0] == 'U')
                $("#sex option:contains("+C+")").attr('selected', 'selected');
                
            }
        });
    }
}
var cn=1;
var PDFArray = [];
if($('#pdfFiles').val() != ''){
    PDFArray.push($('#pdfFiles').val());

}
function img(){
    cn = ++cn;
    pr = cn - 1;
    var files = $('#files').prop('files');
    var f = files[0];
    console.log(f.size);
    if(f.size < 10000000){
        if(f.type == 'application/pdf'){    
            $('#start').after('<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>');
            $('#files').prop('disabled', true);
            var pdffile = new FormData();
            pdffile.append('pdf', f);
            $.ajax({
                url: application_root +"Stranding.cfc?method=uploadpdf",
                type: "POST",
                data: pdffile,
                enctype: 'multipart/form-data',
                processData: false, // tell jQuery not to process the data
                contentType: false, // tell jQuery not to set contentType
                success: function (data) {
                    if(data != ""){
                    PDFArray.push(data);
                    $('#pdfFiles').val(PDFArray);
                    $('.spi').remove();
                    $('#previousimages').append('<span class="pip"><a data-toggle="modal" data-target="#myModal" href="#" title="http://cloud.wildfins.org/'+data+'" target="blank"><img id="select'+pr+'" class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="'+f.name+'" onclick="selected(this)"/></a><br/><span class="remove" id="'+data+'" onclick="remov(this)">Remove image</span></span>');
                    $('#files').prop('disabled', false);
                    }else{
                        alert('Selected file corrupted PDF');
                        $('.spi').remove();
                        $('#files').prop('disabled', false);
                    }
                    // $('#remove'+pr).click(function(){
                    //     $(this).parent(".pip").remove();
                    //     $('#files'+pr).remove();

                    // });

                    // $('#select'+pr).click(function(){
                    //     we = $(this).parent().attr('title');
                    //     $('#emb').attr('src', we);
                    //     $('#pdfname').html($(this).attr('title'));
                    // });
                }
            });
        }else{
            alert('Selected file is not PDF');
            $('#files').val("");
        }
    }else{
        alert('Selected file is Large than 10MB');
        $('#files').val("");
    }        
}
function remov(el){
    var element = el;
    pdffile = element.id
    console.log(pdffile);
    $.ajax({
        url: application_root +"Stranding.cfc?method=removepdf",
        type: "POST",
        data: {pdf: pdffile},
        success: function (data) {
            PDFArray = PDFArray.filter(e => e != pdffile); 
            $('#pdfFiles').val(PDFArray);
            element.parentNode.remove();
        }
    });    
}
jQuery('#noOfAnimals').keyup(function () { 
    this.value = this.value.replace(/[^0-9\.]/g,'');
    oldvalue = this.value;
    if(this.value.length > 3)
    this.value = this.value.substr(0, 3)
});
function selected(elem) {
    var element = elem;
    $('#emb').attr('src', element.parentNode.title);
    $('#pdfname').html($(this).attr('title'));
    
}
function chkreq(e){
    if($("#Fnumber").val().trim() == ""){
        $("#Fnumber").val('');
    }
    if($("#Date").val().trim() == ""){
        $("#Date").val('');
    }
}

$( "#deleteAllLevelAFormRecord" ).click(function() {
    // alert( "Handler for .click() called." );
    $('#date').val('YYYY-MM-DD');
    $('#Fnumber').val(' ');
  });