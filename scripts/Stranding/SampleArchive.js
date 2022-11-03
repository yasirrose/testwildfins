$(document).ready(function() {
    handleDateTimePicker = function () {
        $('#lasttable').DataTable({
            "pageLength": 100,
            "scrollX": true,
            "paging": false,
            "info":    false,
            responsive: true,
            dom: 'rtip',
        });
        "use strict";
       
        $('#datetimepicker_Date').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#date").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Date_sad').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#SampleAccessionDate").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Date2').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#necropsydate").formValidation('revalidateField', name);
        });
        
        $('#datetimepicker_Date_sample').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#Sample_Date").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Date_subsample').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#subsampleDate").formValidation('revalidateField', name);
        });
    
    }  
    $("#subsamplee").hide();
    $("#Thawedd").hide();
    $("#subsampleDatee").hide();
    handleDateTimePicker();
    
    $("#notify").hide();
    // $('#notify').text('The file was not an Excel file.');
    $("#notify").fadeTo(2000, 500).slideUp(900, function() {
        $("#notify").slideUp(900);
    });
     field=$("#fieldList option:selected").text().trim();
    console.log(field);
    $("#fielnumb").val(field);
})
const SampleAccessionDateArray = [];
const SampleLocationArray = [];
const DrugTimeArray = [];
const SampleTrackingArray = [];
const LabSenttoArray = [];
const SampleNoteArray = [];
const subsampleArray = [];
const SampleThawedArray = [];
const subsampleDateArray = [];





function AddNewDrug() {
    buttonname=$("#drugsNew").val();
    if(buttonname =='Add New'){

        SampleAccessionDate = $("#SampleAccessionDate").val().trim();
        SampleLocation = $("#SampleLocation option:selected").text().trim();
        SampleTracking = $("#SampleTracking option:selected").text().trim();
        SampleTrack = $("#SampleTracking option:selected").val().trim();
        LabSentto = $("#LabSentto option:selected").text().trim();
        SampleNote = $("#SampleNote").val().trim();
        SampleID = $("#SampleID").val().trim();
        Thawed = $("#Thawed option:selected").val().trim();
        subsample = $("#subsample option:selected").val().trim();
        subsampleDate= $("#subsampleDate").val().trim();
        

        if (SampleAccessionDate != '' && SampleLocation !='Select Sample Location' && SampleTracking != 'Select Sample Tracking' && LabSentto != 'Select Lab Sent to' ) {
            
            SampleAccessionDateArray.push(SampleAccessionDate);
            SampleLocationArray.push(SampleLocation);
            SampleTrackingArray.push(SampleTracking);
            LabSenttoArray.push(LabSentto);
            if(SampleNote != ''){
                SampleNoteArray.push(SampleNote);
            }else{
                SampleNoteArray.push(0);
                SampleNote ='';
            }
            if(SampleTracking == 'Subsampled' && subsample !='Select Availability' && Thawed !='Select Thawed' ){
                subsampleArray.push(subsample);
                SampleThawedArray.push(Thawed);
                subsampleDateArray.push(subsampleDate);
            }else{
                subsampleArray.push(0);
                SampleThawedArray.push(0);
                subsampleDateArray.push(0);
                subsample ='';
                Thawed='';
                subsampleDate='';
            }
            

            $("#sad").val(SampleAccessionDateArray);
            $("#SL").val(SampleLocationArray);
            $("#ST").val(SampleTrackingArray);
            $("#lsto").val(LabSenttoArray);
            $("#snotes").val(SampleNoteArray);
            $("#Thaw").val(SampleThawedArray);
            $("#Avail").val(subsampleArray);
            $("#sub").val(subsampleDateArray);
            $("#SampleAccessionDate").val("");
            $("#SampleLocation").val("");
            $("#LabSentto").val("");
            $("#SampleTracking").val("");
            $("#SampleNote").val("");
            $("#Thawed").val("");
            $("#subsample").val("");
            $("#subsampleDate").val("");

            $("#drugHistory").show(); 
            $("#drugHistory > tbody").append("<tr><td>" + SampleAccessionDate + "</td><td>" + SampleID + "</td><td>" + SampleLocation + "</td><td>" + SampleTracking + "</td><td>" + LabSentto + "</td><td>" + SampleNote + "</td><td>" + subsampleDate + "</td><td>" + subsample + "</td><td>" + Thawed +"</td><td>" + ''+ "</td></tr>");  
            
            $("#sampleDate").html('');
            $("#sampleLocation").html('');
            $("#sampleTracking").html('');
            $("#labsentto").html('');
            $("#sampleNote").html('');
        }else{
            if(SampleAccessionDate == ''){
                $("#sampleDate").html('Date Required');
            }else{
                $("#sampleDate").html('');
            }
            if(SampleLocation == 'Select Sample Location'){
                $("#sampleLocation").html('*Location Required');
            }else{
                $("#sampleLocation").html('');
            }
            if(SampleTracking == 'Select Sample Tracking'){
                $("#sampleTracking").html('*Select sample tracking');
            }else{
                $("#sampleTracking").html('');
            }
            if(LabSentto == 'Select Lab Sent to'){
                $("#labsentto").html('*Select Lab');
            }else{
                $("#labsentto").html('');
            }
            // if(SampleNote == ''){
            //     $("#sampleNote").html('*Write Note');
            // }else{
            //     $("#sampleNote").html('');
            // }
        }
    }else{
        SampleAccessionDate = $("#SampleAccessionDate").val().trim();
        SampleLocation = $("#SampleLocation option:selected").text().trim();
        SampleTracking = $("#SampleTracking option:selected").text().trim();
        LabSentto = $("#LabSentto option:selected").text().trim();
        SampleNote = $("#SampleNote").val().trim();
        Thawed = $("#Thawed option:selected").val().trim();
        subsample = $("#subsample option:selected").val().trim();
        subsampleDate= $("#subsampleDate").val().trim();
        // no=$("#idd").text();
        no= $("#idForUpdate").val();
        sampledetailID=no;
        if(SampleAccessionDate != ''){
            var ajaxData = new FormData();
            ajaxData.append('samplDate', SampleAccessionDate);
            ajaxData.append('locat', SampleLocation);
            ajaxData.append('track', SampleTracking);
            ajaxData.append('sent', LabSentto);
            ajaxData.append('note', SampleNote);
            ajaxData.append('ID', sampledetailID);
            if(subsample!='Select Availability'&& subsample!=''){
                ajaxData.append('subsample', subsample);
            }else{
                ajaxData.append('subsample', '0');
            }
            if(Thawed!= '' && Thawed!='Select Thawed'){
                ajaxData.append('Thawed', Thawed);
            }else{
                ajaxData.append('Thawed', '0');
            }
            ajaxData.append('subsampleDate', subsampleDate);
            $.ajax({
                url : application_root+"StaticData.cfc?method=updatesampleDetail",
                type: "POST",
                cache: false,
                contentType:false,
                processData: false,
                data : ajaxData,
               
            
                success: function (response)
                {                                     
                    // subsampleDate= $("#subsampleDate").val().trim();
                    // working
                    // var pageURL = $(location).attr("href");
                    // window.location.href= pageURL;
                    let id = $("#idForUpdate").val();
                    $("#date"+id).html(SampleAccessionDate);
                    $("#location"+id).html(SampleLocation);
                    $("#track"+id).html(SampleTracking);
                    $("#labsent"+id).html(LabSentto);
                    $("#samplenotes"+id).html(SampleNote);
                    $("#subdate"+id).html(subsampleDate);                    
                    
                    if(Thawed != "Select Thawed"){
                        $("#thawed"+id).html(Thawed);
                    }                    
                    if(subsample != "Select Availability"){
                        $("#availbility"+id).html(subsample);
                    }
                    $("#SampleAccessionDate").val(''); 
                    $("#SampleLocation").val('');
                    $("#SampleTracking").val('');
                    $("#LabSentto").val('');
                    $("#SampleNote").val('');
                    $("#Thawed").val('');
                    $("#subsample").val('');
                    $("#subsampleDate").val('');
                    $("#drugsNew").val("Add New");

                    Thawed = '';
                    subsample= '';
                    subsampleDate='';


                },
                error: function (response)
            {
            //    alert(response);
            }
               
            });
        }else{
            alert('Fill Sample Accession Date.');
            $("#SampleAccessionDate").focus();
        }
    }
}

function edit_row(no)
{
    $("#idForUpdate").val(no);
    $("#drugsNew").val("Update");
    $("#SampleAccessionDate").val($("#date"+no).text());

    if($("#location"+no).text() != ''){
        let c=$("#location"+no).text();
        $("#SampleLocation option:contains("+c+")").attr('selected', 'selected');
    }

    if($("#labsent"+no).text() != ''){
        let e=$("#labsent"+no).text();
        $("#LabSentto option:contains("+e+")").attr('selected', 'selected');
    }

    $("#SampleNote").val($("#samplenotes"+no).text());

    if($("#track"+no).text() != ''){
        let d=$("#track"+no).text();
        $("#SampleTracking option:contains("+d+")").attr('selected', 'selected');

        if(d == 'Subsampled'){
            $("#subsamplee").show();
            $("#Thawedd").show();
            $("#subsampleDatee").show();
            
        }else{
            $("#subsamplee").hide();
            $("#Thawedd").hide();
            $("#subsampleDatee").hide();
            $("#subdate"+no).text("");
            $("#availbility"+no).text("");
            $("#thawed"+no).text("");
            tttt=$("#Thawed").val("0");
            $("#subsample").val("0");
            $("#subsampleDate").val("");
        }
    }

    let g=$("#subdate"+no).text();
    let h=$("#availbility"+no).text();
    let i=$("#thawed"+no).text();
    if(g != '' && h!= 'Select Availability' && h!= '' && i!= 'Select Thawed' && i!= ''){
        $("#subsampleDate ").val(g);
        $("#subsample option:contains("+h+")").attr('selected', 'selected');
        $("#Thawed option:contains("+i+")").attr('selected', 'selected');
    }
   
}

function delete_row(no)
{
    sampledetailID=no;
    // console.log(sampledetailID);
    var ajaxData = new FormData();
    ajaxData.append('ID', sampledetailID);
    $.ajax({
        url : application_root+"Stranding.cfc?method=deletesampleDetail",
        type: "POST",
        cache: false,
        contentType:false,
        processData: false,
        data : ajaxData,
        success: function (response)
        {
            // var pageURL = $(location).attr("href");
            // window.location.href= pageURL;
            $('#'+'tr_'+no).remove();
        },
        error: function (response)
        {
            alert(response);
        }
    });
}

function check() {

    SampleTracking = $("#SampleTracking option:selected").val().trim();
    if(SampleTracking == 5){
        $("#subsamplee").show();
        $("#Thawedd").show();
        $("#subsampleDatee").show();
        
    }else{
        $("#subsamplee").hide();
        $("#Thawedd").hide();
        $("#subsampleDatee").hide();
    }
}


function chkreq(e){
    if($("#Fnumber").val().trim() == ""){
        $("#Fnumber").val('');
    }
    if($("#Date").val().trim() == ""){
        $("#Date").val('');
    }
}
function deleteit(){
    console.log("deleteee");
    $('#SampleID').prop('required',false);
}


let v = 2;
let u = 100;
function getData(){
    
    const selectedValue =$("#myList").val();
    const m = $("#date").val();
    console.log(m);
    $("#archivedate").val(m);
   if(selectedValue === 'load')
   {
        vale = v++;
        recod = u;
        $.ajax({
            url: application_root + "Stranding.cfc?method=getSampleArchiveID",
            type: "post",
            data: {
                a:vale,
                b:recod
            },
            success: function (data) {
                console.log(data);
                // append options
                var obj = JSON.parse(data);
                for (var i = 0; i < obj.DATA.length; i++) {
                    $(new Option(obj.DATA[i][0], obj.DATA[i][0])).insertBefore ("#loadMore");
                }
            }
        });
        document.getElementById('myList').size=10;
        var select = document.getElementsByTagName('select')[0];
                select.selectedIndex = select.options.length-2;
   }else{
        document.getElementById('myList').size=1
        text =$("#myList option:selected").text().trim();
        if(text != 'Select Sample')
        {
        $("#myform").submit();
        }
    }
       
    
    
}

let x = 2;
let y = 100;
function getdate(){
    
    const selectedValue =$("#listDate").val();
    
   if(selectedValue === 'loads')
   {
        vale = x++;
        recod = y;
        console.log(vale);
        console.log(recod);
        $.ajax({
            url: application_root + "Stranding.cfc?method=getSampleArchiveDate",
            type: "post",
            data: {
                a:vale,
                b:recod
            },
            success: function (data) {
                
                // append options
                var obj = JSON.parse(data);
                console.log(obj);
                // console.log(obj.ID);
                for (var i = 0; i < obj.DATA.length; i++) {
                    $(new Option(obj.DATA[i][1], obj.DATA[i][0])).insertBefore ("#loaddate");
                }
            }
        });
        document.getElementById('listDate').size=10;
        $('select[id=listDate] option:eq(2)').attr('selected', 'selected');
        
   }
   else
   {
        $(document).on('click','body *',function(){
            document.getElementById('listDate').size=1
        });
       text =$("#listDate option:selected").text().trim();
       if(text != 'Select Date')
       {
        date=$("#listDate option:selected").text().trim();
        $("#searchDate").val(date);
        $("#dateform").submit();
       }
   }
       
    
    
}

let m = 2;
let n = 100;
function getfield(){

    const selectedValue =$("#fieldList").val();
    
    if(selectedValue === 'loaded')
    {
         vale = m++;
         recod = n;
         console.log(vale);
         console.log(recod);
         $.ajax({
             url: application_root + "Stranding.cfc?method=getSampleArchiveFBNumber",
             type: "post",
             data: {
                 a:vale,
                 b:recod
             },
             success: function (data) {
                 
                 // append options
                 var obj = JSON.parse(data);
                 console.log(obj);
                 for (var i = 0; i < obj.DATA.length; i++) {
                     $(new Option(obj.DATA[i][1], obj.DATA[i][0])).insertBefore ("#loadfield");
                 }
             }
         });
         document.getElementById('fieldList').size=10;
         $('select[id=fieldList] option:eq(2)').attr('selected', 'selected');
         
    }
    else
    {
         $(document).on('click','body *',function(){
             document.getElementById('fieldList').size=1
         });
        text =$("#fieldList option:selected").text().trim();
        if(text != 'Select Filed Number')
        {
        
            field=$("#fieldList option:selected").text().trim();
            $("#searchField").val(field);
         $("#fieldform").submit();
        }
    }

}


$( "#loadMore" ).click(function( event ) {
  event.stopImmediatePropagation();
});

function fieldnum(){
    field=$("#fieldList option:selected").text().trim();
    console.log(field);
    $("#fielnumb").val(field);
    $("#fieldform").submit();
}

// $('#loadMore').click(function(e) {
//     e.stopPropagation();
// });
function addMoreRecords(event)
  {
 
    
    document.getElementById('listDate').size=10;
      value = $('#listDate option:selected').text();
  
        if(value == "Load More" ){;

            start = $('#startValue').val();
            end = Number(start) + 1000;
            // console.log(start)
            // console.log(end)

            $.ajax({
                url: application_root + "Stranding.cfc?method=getmaindate",
                type: "post",
                data: {
                    startvalue: start,
                    endValue:end
                },
                success: function (data) {
                    console.log(data);
                    // append options
                    var obj = JSON.parse(data);
                    console.log(obj);

                    for (var i = 0; i < obj.DATA.length; i++) {
                        $(new Option(obj.DATA[i][0], obj.DATA[i][1])).insertBefore ("#loadMore");
                                           
                    }
                    // $('#listDate').select2('open');
                    $('#listDate').val('');
                    $('#listDate').size=10;
                    $('#startValue').val(end);
     
                }
            });
        }else if(value == "Select Date"){
            // alert()
        }else if(value == "Search") {
            $('#search').show();
        }    
        
        else{
            $( "#dateform" ).submit();
            // $('#listDate').append(value).trigger('change');
        }
  }  
function searchData(){
    // document.getElementById('listDate').size=10;
   searchFeildValue = $('#search').val();
   $('#listDate').html('').select2({data: [{id: '', text: ''}]});
   $('#listDate').attr('size',6)

    $.ajax({
        url: application_root + "Stranding.cfc?method=searchData",
        type: "post",
        data: {
            value: searchFeildValue
        },
        success: function (data) {
            // console.log(data);
            // append options
            var obj = JSON.parse(data);
       
            if(obj.DATA.length > 0){
                $('#listDate').select2('destroy');
                for (var i = 0; i < obj.DATA.length; i++) {
                    // $(new Option(obj.DATA[i][0], obj.DATA[i][1])).insertBefore ("#loadMore");
                    $('#listDate').append(new Option(obj.DATA[i][0], obj.DATA[i][1])); 
                    console.log(obj.DATA[i][1]);                                                          
                }
                // $('#listDate').append(new Option('Load More', 'LoadMore'));
                $('#listDate').select2('open');
                document.getElementById("search").focus();
            }else{
                $('#listDate').select2('destroy');
                // $('#listDate').html('').select2({data: [{id: '', text: ''}]});
                   $('#listDate').append(`<option value="norecord">
                        No Record Found!
                       </option>`);
                       $('#listDate').select2('open');
            }
            // // $('#listDate').val('').trigger('change');
          

        }
    });
}

function getFocus() {
    document.getElementById("search").focus();
  }
function hidefeild(){
    // alert();
    // $('#search').hide();
}
$( "#deleteallSampleArchiveRecord" ).click(function() {
    $('#date').val('mm/dd/yyyy');
    $('#Fnumber').val(' ');
  });