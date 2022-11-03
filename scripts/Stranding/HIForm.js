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
                console.log(data);
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
            PDFArray = PDFArray.filter(e => e !== pdffile); 
            $('#pdfFiles').val(PDFArray);
            element.parentNode.remove();
        }
    });    
}
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
// working start
const TypeofHIArray = [];
const LocationofHIArray = [];
const GearCollectedArray = [];
const TypeofGearCollectedArray = [];
const GearDepositionArray = [];
var PDFArray = [];
// if($('#pdfFiles').val() != ''){
//     PDFArray.push($('#pdfFiles').val());

// }
function AddNewHiExam(){
    
    buttonname=$("#addNewHiExam").val();

    data = $("#TypeofHI").select2("val");
    // console.log(data)
    // TypeofHI1 = $("#TypeofHI option:selected").text();
    if($("#TypeofHI").select2("val") != null){
        if($("#TypeofHI").select2("val").length > 1){
            TypeofHI1 = $("#TypeofHI").select2("val").toString();
            TypeofHI = TypeofHI1.replaceAll(',', '-');
        }else{
            TypeofHI = $("#TypeofHI").select2("val");
            TypeofHI1= $("#TypeofHI").select2("val");
        }
    }else{
        TypeofHI = $("#TypeofHI").select2("val");
        TypeofHI1= '';
    }
    if($("#LocationofHI").select2("val") != null){
        if($("#LocationofHI").select2("val").length > 1){
            LocationofHI1 = $("#LocationofHI").select2("val").toString();
            LocationofHI = LocationofHI1.replaceAll(',', '-');
        }
        else{
            LocationofHI = $("#LocationofHI").select2("val");
            LocationofHI1= $("#LocationofHI").select2("val");
        }
    }else{
        LocationofHI = $("#LocationofHI").select2("val");
        LocationofHI1= '';
    }
    if($("#TypeofGearCollected").select2("val") != null){
        if($("#TypeofGearCollected").select2("val").length > 1){
            TypeofGearCollected1 = $("#TypeofGearCollected").select2("val").toString();
            TypeofGearCollected = TypeofGearCollected1.replaceAll(',', '-');
        }else{
            TypeofGearCollected = $("#TypeofGearCollected").select2("val");
            TypeofGearCollected1= $("#TypeofGearCollected").select2("val");
        }
    }else{
        TypeofGearCollected = $("#TypeofGearCollected").select2("val");
        TypeofGearCollected1= '';
    }

    GearDeposition = $("#GearDeposition option:selected").text();
    if(GearDeposition == "Select Type of Gear Collected"){
        GearDeposition= '';
    }else{
        GearDeposition = $("#GearDeposition option:selected").text();
    }
    
    if ($('#GearCollected').is(":checked"))
        {
        GearCollected = "Yes";
    }else{
        GearCollected = "No";        
        }
    // working


    if(buttonname == "Add New"){
        // if($("#TypeofHI").select2("val") != null){
            // }
        // if($("#LocationofHI").select2("val") != null){
            // }
        // if($("#TypeofGearCollected").select2("val") != null){
        //     }

            if(TypeofHI != null){
                TypeofHIArray.push(TypeofHI);
            }else{
                TypeofHIArray.push(0);
                TypeofHI ='';
            }  
            if(LocationofHI != null){
                LocationofHIArray.push(LocationofHI);
            }else{
                LocationofHIArray.push(0);
                LocationofHI ='';
            }  
            if(TypeofGearCollected != null){
                TypeofGearCollectedArray.push(TypeofGearCollected);
            }else{
                TypeofGearCollectedArray.push(0);
                TypeofGearCollected ='';
            }  
            console.log(TypeofHIArray);

            if(GearDeposition == ""){
                GearDepositionArray.push(0);
                }else{
                GearDepositionArray.push(GearDeposition);
                }
        // TypeofHIArray.push(TypeofHI);
        // LocationofHIArray.push(LocationofHI);
        // TypeofGearCollectedArray.push(TypeofGearCollected);
        GearDepositionArray.push(GearDeposition);
        GearCollectedArray.push(GearCollected);
    //   console.log(TypeofHIArray);

        $("#HiType").val(TypeofHIArray);
        $("#HiLocation").val(LocationofHIArray);
        $("#typeOfGearCollected").val(TypeofGearCollectedArray);
        $("#gearDeposition").val(GearDepositionArray);
        $("#gearCollected").val(GearCollectedArray);        
        
        
        // TypeofGearCollected
        $('#TypeofHI').val(null).trigger('change');
        $('#LocationofHI').val(null).trigger('change');
        $('#TypeofGearCollected').val(null).trigger('change');
        $("#GearDeposition").val("");
        $('#GearCollected').prop('checked', false);
            
        $("#HiForm").show();   
        $("#HiForm > tbody").append("<tr><td>" + TypeofHI1 + "</td><td>" + LocationofHI1 + "</td><td>" + GearCollected + "</td><td>" + TypeofGearCollected1 + "</td><td>" + GearDeposition + "</td></tr>");
    
        // // set empty error msgs
        // $("#Lesion_present").html('');
        // $("#Lesion_type").html('');
        // $("#Lesion_region").html('');
        // $("#Lesion_side").html('');
        // $("#Lesion_status").html('');
    }else{
        LessionId= $("#idForUpdateHiExam").val();

        var ajaxData = new FormData();
        ajaxData.append('TypeofHI', TypeofHI);
        ajaxData.append('LocationofHI', LocationofHI);
        ajaxData.append('TypeofGearCollected', TypeofGearCollected);
        ajaxData.append('GearDeposition', GearDeposition);
        ajaxData.append('GearCollected', GearCollected);
        ajaxData.append('ID', LessionId);
        $.ajax({
            url : application_root+"Stranding.cfc?method=updateHiExam",
            type: "POST",
            cache: false,
            contentType:false,
            processData: false,
            data : ajaxData,
           
        
            success: function (response)
            {
                // console.log('nouman');
                let id = $("#idForUpdateHiExam").val();


                $("#TYPEOFHI_"+id).html(TypeofHI);
                $("#LocationofHI_"+id).html(LocationofHI);
                $("#TypeofGearCollected_"+id).html(TypeofGearCollected);
                $("#GearDeposition_"+id).html(GearDeposition);
                $("#GearCollected_"+id).html(GearCollected);
                
                $('#TypeofHI').val(null).trigger('change');
                $('#LocationofHI').val(null).trigger('change');
                $('#TypeofGearCollected').val(null).trigger('change');
                $("#GearDeposition").val("");
                $('#GearCollected').prop('checked', false);
            },
            error: function (response)
        {
        //    alert(response);
        }
           
        });
        $("#addNewHiExam").val("Add New");

    }
    
}

function edit_row(id){
    // alert();
    $("#idForUpdateHiExam").val(id);
    $("#addNewHiExam").val("Update");


    dara = $("#TYPEOFHI_"+id).text();
    console.log(dara);
    if($("#TYPEOFHI_"+id).text() != ''){
        let c=$("#TYPEOFHI_"+id).text();
        // str = c.replace('-', ',');    
        hitype = c.split(",")
        $('#TypeofHI').val(hitype).trigger('change');
        // $("#TypeofHI option:contains("+hitype+")").attr('selected', 'selected');
    }else{
        let c=$("#TYPEOFHI_"+id).text();
        // str = c.replace('-', ',');    
        hitype = c.split(",")
        $('#TypeofHI').val(hitype).trigger('change');
    }
  
    if($("#LocationofHI_"+id).text() != ''){
        let c=$("#LocationofHI_"+id).text();
        hilocation = c.split(",")
        $('#LocationofHI').val(hilocation).trigger('change');
    }else{
        let c=$("#LocationofHI_"+id).text();
        hilocation = c.split(",")
        $('#LocationofHI').val(hilocation).trigger('change');
    }
    if($("#TypeofGearCollected_"+id).text() != ''){
        let c=$("#TypeofGearCollected_"+id).text();
        geartype = c.split(",")
        $('#TypeofGearCollected').val(geartype).trigger('change');
    }else{
        let c=$("#TypeofGearCollected_"+id).text();
        geartype = c.split(",")
        $('#TypeofGearCollected').val(geartype).trigger('change');
    }

    if($("#GearCollected_"+id).text() == "Yes"){
        $('#GearCollected').prop('checked', true);
    }else{
        $('#GearCollected').prop('checked', false);
    }
    if($("#GearDeposition_"+id).text() != ''){
        let c=$("#GearDeposition_"+id).text();
        $("#GearDeposition option:contains("+c+")").attr('selected', 'selected');
    }else{
        $('#GearDeposition').val('');
    }
}
function delete_row(id){
    LesionID=id;
    var ajaxData = new FormData();
    ajaxData.append('ID', LesionID);
    $.ajax({
        url : application_root+"Stranding.cfc?method=deleteHiExam",
        type: "POST",
        cache: false,
        contentType:false,
        processData: false,
        data : ajaxData,
        success: function (response)
        {
            // var pageURL = $(location).attr("href");
            // window.location.href= pageURL;
            $('#'+'tr_'+id).remove();
            
        },
        error: function (response)
        {
            alert(response);
        }
    });
}

// working end

$( "#deleteAllHiFormRecord" ).click(function() {
    // alert( "Handler for .click() called." );
    $('#date').val('mm/dd/yyyy');
    $('#Fnumber').val(' ');
  });