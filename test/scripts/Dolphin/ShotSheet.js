/**
 * Created by mawais on 9/20/2017.
 */
function sendForm() {
    var id =document.getElementById('project_val').value;

    document.getElementById("myform").submit();

}
$.ajax({
    url: application_root + "Dolphin.cfc?method=countdailyshot",
    type: "get",
    success:function (data){

        if(data==0){
            $('#shcount').val(0);
        }
        else {
            document.getElementById("shcount").value = data;
        }
    }
});
function submitsightForm() {
    var id=document.getElementById('sightid').value;
    if(id==0){
        document.getElementById("myform").submit();
    }else{
        document.getElementById("sightform").submit();
    }
    var sght = $('#sightid').val();
    $('#sighting_hiddeid').val(sght)
}

$('.shotdolph').click(function(){

    $('#shotdisplay').show();

});

$("#hitOutcome").click(function(){
    $("#missHeight").css('display','none');
    $("#missWidth").css('display','none');
    $("#missDistance").css('display','none');
    $("#missDescriptor").css('display','block');
    $("#hitDescriptor").css('display','block');
    $('#hitlocati').css('display','block');
});
$("#missOutcome").click(function(){
    $("#missHeight").css('display','block');
    $("#missWidth").css('display','block');
    $("#missDistance").css('display','block');
    $("#missDescriptor").css('display','none');
    $("#hitDescriptor").css('display','block');
    $('#hitlocati').css('display','none');
});

$('#bhv1').change(function () {
    var value  = $( "#bhv1 option:selected" ).text();
    if(value == 'Quiver'|| value == 'Startle reaction' || value =='Deep dive'||value=='Reposition on bow'||value=='Slowly submerge' ){
        $('#tgtr1').val('Low');
    }
    else if(value == 'Roll'|| value == 'Defecate' || value =='Forceful breath'||value=='Accelerate quickly'||value=='Arched back'||value=='Tail kick'||value=='Hesitation' ){
        $('#tgtr1').val('Low Moderate');
    }
    else if(value == 'Change swim direction'|| value == 'Tail slap' || value =='Fast dive'||value=='Sharking'||value=='Tense' ){
        $('#tgtr1').val('Moderate');
    }
    else if(value == 'Target animal left bow'|| value == 'Entire group left bow' || value =='Breach and leave bow'||value=='Breach and remain on bow'||value=='Startle reaction' ){
        $('#tgtr1').val('Moderate Strong');
    }
    else if(value=='Multiple breaches'){
        $('#tgtr1').val('Strong');
    }
    else if(value=='Reaction not observed'){
        $('#tgtr1').val('N/A');
    }
    else if(value==null){
        $('#tgtr1').val('');
    }

})

$('#bhv2').change(function () {
    var value  = $( "#bhv2 option:selected" ).text();
    if(value == 'Quiver'|| value == 'Startle reaction' || value =='Deep dive'||value=='Reposition on bow'||value=='Slowly submerge' ){
        $('#tgtr2').val('Low');
    }
    else if(value == 'Roll'|| value == 'Defecate' || value =='Forceful breath'||value=='Accelerate quickly'||value=='Arched back'||value=='Tail kick'||value=='Hesitation' ){
        $('#tgtr2').val('Low Moderate');
    }
    else if(value == 'Change swim direction'|| value == 'Tail slap' || value =='Fast dive'||value=='Sharking'||value=='Tense' ){
        $('#tgtr2').val('Moderate');
    }
    else if(value == 'Target animal left bow'|| value == 'Entire group left bow' || value =='Breach and leave bow'||value=='Breach and remain on bow'||value=='Startle reaction' ){
        $('#tgtr2').val('Moderate Strong');
    }
    else if(value=='Multiple breaches'){
        $('#tgtr2').val('Strong');
    }
    else if(value=='Reaction not observed'){
        $('#tgtr2').val('N/A');
    }
    else if(value==null){
        $('#tgtr2').val('');
    }

})

$('#bhv3').change(function () {
    var value  = $( "#bhv3 option:selected" ).text();
    if(value == 'Quiver'|| value == 'Startle reaction' || value =='Deep dive'||value=='Reposition on bow'||value=='Slowly submerge' ){
        $('#tgtr3').val('Low');
    }
    else if(value == 'Roll'|| value == 'Defecate' || value =='Forceful breath'||value=='Accelerate quickly'||value=='Arched back'||value=='Tail kick'||value=='Hesitation' ){
        $('#tgtr3').val('Low Moderate');
    }
    else if(value == 'Change swim direction'|| value == 'Tail slap' || value =='Fast dive'||value=='Sharking'||value=='Tense' ){
        $('#tgtr3').val('Moderate');
    }
    else if(value == 'Target animal left bow'|| value == 'Entire group left bow' || value =='Breach and leave bow'||value=='Breach and remain on bow'||value=='Startle reaction' ){
        $('#tgtr3').val('Moderate Strong');
    }
    else if(value=='Multiple breaches'){
        $('#tgtr3').val('Strong');
    }
    else if(value=='Reaction not observed'){
        $('#tgtr3').val('N/A');
    }
    else if(value==null){
        $('#tgtr3').val('');
    }

})

$('#grprp1').change(function () {
    var value  = $( "#grprp1 option:selected" ).text();
    if(value == 'Quiver'|| value == 'Startle reaction' || value =='Deep dive'||value=='Reposition on bow'||value=='Slowly submerge' ){
        $('#grp1').val('Low');
    }
    else if(value == 'Roll'|| value == 'Defecate' || value =='Forceful breath'||value=='Accelerate quickly'||value=='Arched back'||value=='Tail kick'||value=='Hesitation' ){
        $('#grp1').val('Low Moderate');
    }
    else if(value == 'Change swim direction'|| value == 'Tail slap' || value =='Fast dive'||value=='Sharking'||value=='Tense' ){
        $('#grp1').val('Moderate');
    }
    else if(value == 'Target animal left bow'|| value == 'Entire group left bow' || value =='Breach and leave bow'||value=='Breach and remain on bow'||value=='Startle reaction' ){
        $('#grp1').val('Moderate Strong');
    }
    else if(value=='Multiple breaches'){
        $('#grp1').val('Strong');
    }
    else if(value=='Reaction not observed'){
        $('#grp1').val('N/A');
    }
    else if(value==null){
        $('#grp1').val('');
    }

})

$('#grprp2').change(function () {
    var value  = $( "#grprp2 option:selected" ).text();
    if(value == 'Quiver'|| value == 'Startle reaction' || value =='Deep dive'||value=='Reposition on bow'||value=='Slowly submerge' ){
        $('#grp2').val('Low');
    }
    else if(value == 'Roll'|| value == 'Defecate' || value =='Forceful breath'||value=='Accelerate quickly'||value=='Arched back'||value=='Tail kick'||value=='Hesitation' ){
        $('#grp2').val('Low Moderate');
    }
    else if(value == 'Change swim direction'|| value == 'Tail slap' || value =='Fast dive'||value=='Sharking'||value=='Tense' ){
        $('#grp2').val('Moderate');
    }
    else if(value == 'Target animal left bow'|| value == 'Entire group left bow' || value =='Breach and leave bow'||value=='Breach and remain on bow'||value=='Startle reaction' ){
        $('#grp2').val('Moderate Strong');
    }
    else if(value=='Multiple breaches'){
        $('#grp2').val('Strong');
    }
    else if(value=='Reaction not observed'){
        $('#grp2').val('N/A');
    }
    else if(value==null){
        $('#grp2').val('');
    }

})
$('#grprp3').change(function () {
    var value  = $( "#grprp3 option:selected" ).text();
    if(value == 'Quiver'|| value == 'Startle reaction' || value =='Deep dive'||value=='Reposition on bow'||value=='Slowly submerge' ){
        $('#grp3').val('Low');
    }
    else if(value == 'Roll'|| value == 'Defecate' || value =='Forceful breath'||value=='Accelerate quickly'||value=='Arched back'||value=='Tail kick'||value=='Hesitation' ){
        $('#grp3').val('Low Moderate');
    }
    else if(value == 'Change swim direction'|| value == 'Tail slap' || value =='Fast dive'||value=='Sharking'||value=='Tense' ){
        $('#grp3').val('Moderate');
    }
    else if(value == 'Target animal left bow'|| value == 'Entire group left bow' || value =='Breach and leave bow'||value=='Breach and remain on bow'||value=='Startle reaction' ){
        $('#grp3').val('Moderate Strong');
    }
    else if(value=='Multiple breaches'){
        $('#grp3').val('Strong');
    }
    else if(value=='Reaction not observed'){
        $('#grp3').val('N/A');
    }
    else if(value==null){
        $('#grp3').val('');
    }

})


    $('#shot').val(1);
        $('#door').change(function () {
            var dolphin_id = $('#door').val();

            //$('#door option').prop('disabled', true);

            var ShotNum = $('#shot').val();
            if(ShotNum == 1) {

                firstshotdata(1, dolphin_id);
            }
            if(ShotNum == 2){
                secondshotdata(2, dolphin_id);
            }
            if(ShotNum == 3){
                thirdshotdata(3, dolphin_id);
            }

        });
   $('#shotnumber1').click(function(){

       var id = $('#door option:selected').val();
       if(id==""){
           alert("select dolphin first");
       }
       else {
           firstshotdata(1, id);
           $('#shot').show();
           $('#shot').val(1);
       }
   });
$('#shotnumber2').click(function(){
    var id = $('#door option:selected').val();
    if(id==""){
        alert("select dolphin first");
    }
    else {
        secondshotdata(2, id);
        $('#shot').show();
        $('#shot').val(2);
    }
    });
$('#shotnumber3').click(function(){
    var id = $('#door option:selected').val();
    if(id==""){
        alert("select dolphin first");
    }
    else {
        thirdshotdata(3, id);
        $('#shot').show();
        $('#shot').val(3);
    }
    });


function firstshotdata(ShotNum,id){

    var sights_id = $('#sightid').val();
    $.ajax({
        url: application_root + "Dolphin.cfc?method=firstShotData",
        type: "POST",
        data: {
            "dolphin_id": id,
            "sight_id": sights_id,
            "shotNumber": ShotNum
        },
        success: function (response) {
            var rep = JSON.parse(response)
            $('#shotcount').val(rep[0]["biopsycount"]);

            $('#bhv1').val(rep[0]["TargetResponseBehavior1"]);
            $('#shttm').val(rep[0]["ShotTime"]);
            $('#bhv2').val(rep[0]["TargetResponseBehavior2"]);
            $('#arba').val(rep[0]["Arbalester"]);
            $('#bhv3').val(rep[0]["TargetResponseBehavior3"]);
            $('#tgtr1').val(rep[0]["TargetLevel"]);
            $('#tgtr2').val(rep[0]["TargetLevel2"]);
            $('#tgtr3').val(rep[0]["TargetLevel3"]);
            $('#grp1').val(rep[0]["GroupLevel1"]);
            $('#shotdist').val(rep[0]["ShotDistance"]);
            $('#smplnbr').val(rep[0]["SampleNumber"]);
            $('#grprp1').val(rep[0]["GroupResponseBehavior"]);
            $('#subsmpl').val(rep[0]["SubSample"]);
            $('#smplngth').val(rep[0]["SampleLength"]);
            $('#htdscrp').val(rep[0]["HitDescriptor"]);
            $('#hitloc').val(rep[0]["HitLocation"]);
            var hitlocation = rep[0]["HitLocation"];
            $('#process').val(rep[0]["Processor"]);
            $('#grpsz').val(rep[0]["GroupSize"]);
            var  SampleTaken = rep[0]["SampleTaken"];
            if(SampleTaken==1){
                $('#smpl1').prop("checked", true);
            }

            else if(SampleTaken==0){
                $('#smpl2').prop("checked", true);
            }
            var Samplehead = rep[0]["Samplehead"];
            if(Samplehead==1){
                $('#smplhead1').prop("checked", true);
            }
            else if (Samplehead==0){
                $('#smplhead2').prop("checked", true);
            }
            var SampleCollected = rep[0]["SampleCollected"];
            if(SampleCollected==1){
                $('#collected1').prop("checked", true);
            }
            else if(SampleCollected==0){
                $('#collected2').prop("checked", true);
            }
            var blubberteflon = rep[0]["BlubberTeflonVial"];
            if(blubberteflon==1){
                $('#blubber1').prop("checked", true);
            }
            var BlubberCryovialRed = rep[0]["BlubberCryovialRed"];
            if(BlubberCryovialRed==1){
                $('#blubbercry').prop("checked", true);
            }
            var SkinDCryovial = rep[0]["SkinDCryovial"];
            if(SkinDCryovial==1){
                $('#skindcry').prop("checked", true);
            }
            var SkinDMSO = rep[0]["SkinDMSO"];
            if(SkinDMSO==1){
                $('#skindms').prop("checked",true);
            }
            var SkinRNAlater = rep[0]["SkinRNAlater"];
            if(SkinRNAlater==1){
                $('#rna').prop("checked", true);
            }
             var probable_Dolphin =  rep[0]["probable_dolphin"];
            if(probable_Dolphin==1){
                $('#prbbldol').prop("checked", true);
            }
             if(hitlocation >=1){
                $('#hitloc').prop("selected", true);
            }
            var rad = rep[0]["Outcome"];
            if(rad == 0){
                $('#missOutcome').prop("checked", true);
                $('#shotnumber3').css("background-color", "");
                $('#shotnumber2').css("background-color", "");
                $('#shotnumber1').css("background-color", "");
            }
            else if(rad==1){
                $('#hitOutcome').prop("checked", true);
                $('#shotnumber1').css('background-color','green');
                $('#shotnumber3').css("background-color", "");
                $('#shotnumber2').css("background-color", "");


            }
            $('#smplnbr').val(rep[0]["SampleNumber"]);
            $('#subsmpl').val(rep[0]["SubSample"])
        }


    });

}
function secondshotdata(ShotNum,id) {

    var sights_id = $('#sightid').val();
    $.ajax({
        url: application_root + "Dolphin.cfc?method=secondShotData",
        type: "POST",
        data: {
            "dolphin_id": id,
            "sight_id": sights_id,
            "shotNumber": ShotNum
        },
        success: function (response) {
            var rep = JSON.parse(response)
            $('#bhv1').val(rep[0]["TargetResponseBehavior1"]);
            $('#shttm').val(rep[0]["ShotTime"]);
            $('#bhv2').val(rep[0]["TargetResponseBehavior2"]);
            $('#arba').val(rep[0]["Arbalester"]);
            $('#bhv3').val(rep[0]["TargetResponseBehavior3"]);
            $('#tgtr1').val(rep[0]["TargetLevel"]);
            $('#tgtr2').val(rep[0]["TargetLevel2"]);
            $('#tgtr3').val(rep[0]["TargetLevel3"]);
            $('#grp1').val(rep[0]["GroupLevel1"]);
            $('#shotdist').val(rep[0]["ShotDistance"]);
            $('#smplnbr').val(rep[0]["SampleNumber"]);
            $('#grprp1').val(rep[0]["GroupResponseBehavior"]);
            $('#hitloc').val(rep[0]["HitLocation"]);
            $('#grpsz').val(rep[0]["GroupSize"]);
            $('#subsmpl').val(rep[0]["SubSample"]);
            $('#smplngth').val(rep[0]["SampleLength"]);
            var hitlocation = rep[0]["HitLocation"];
            $('#process').val(rep[0]["Processor"]);
            var  SampleTaken = rep[0]["SampleTaken"];
            if(SampleTaken==1){
                $('#smpl1').prop("checked", true);
            }
            else if(SampleTaken==0){
                $('#smpl2').prop("checked", true);
            }
            var Samplehead = rep[0]["Samplehead"];
            if(Samplehead==1){
                $('#smplhead1').prop("checked", true);
            }
            else if (Samplehead==0){
                $('#smplhead2').prop("checked", true);
            }
            var SampleCollected = rep[0]["SampleCollected"];
            if(SampleCollected==1){
                $('#collected1').prop("checked", true);
            }
            else if(SampleCollected==0){
                $('#collected2').prop("checked", true);
            }
            var blubberteflon = rep[0]["BlubberTeflonVial"];
            if(blubberteflon==1){
                $('#blubber1').prop("checked", true);
            }
            var BlubberCryovialRed = rep[0]["BlubberCryovialRed"];
            if(BlubberCryovialRed==1){
                $('#blubbercry').prop("checked", true);
            }
            var SkinDCryovial = rep[0]["SkinDCryovial"];
            if(SkinDCryovial==1){
                $('#skindcry').prop("checked", true);
            }
            var SkinDMSO = rep[0]["SkinDMSO"];
            if(SkinDMSO==1){
                $('#skindms').prop("checked",true);
            }
            var SkinRNAlater = rep[0]["SkinRNAlater"];
            if(SkinRNAlater==1){
                $('#rna').prop("checked", true);
            }
            var probable_Dolphin =  rep[0]["probable_dolphin"];
            if(probable_Dolphin==1){
                $('#prbbldol').prop("checked", true);
            }
            if(hitlocation >=1){
                $('#hitloc').prop("selected", true);
            }
            var rad = rep[0]["Outcome"];
            if(rad == 0){
                $('#missOutcome').prop("checked", true);
                $('#shotnumber3').css("background-color", "");
                $('#shotnumber2').css("background-color", "");
                $('#shotnumber1').css("background-color", "");
            }
            else if(rad==1){
                $('#hitOutcome').prop("checked", true);
                $('#shotnumber2').css('background-color','green');
                $('#shotnumber1').css("background-color", "");
                $('#shotnumber3').css("background-color", "");
            }
            $('#smplnbr').val(rep[0]["SampleNumber"]);
            $('#subsmpl').val(rep[0]["SubSample"])
        }
    });

}

function thirdshotdata(ShotNum,dolphin_id){

    var sight_id = $('#sightid').val();
    $.ajax({
        url: application_root + "Dolphin.cfc?method=thirdShotData",
        type: "POST",
        data: {
            "dolphin_id": dolphin_id,
            "sight_id": sight_id,
            "shotNumber": ShotNum
        },
        success: function (response) {
            var rep = JSON.parse(response)
            $('#bhv1').val(rep[0]["TargetResponseBehavior1"]);
            $('#shttm').val(rep[0]["ShotTime"]);
            $('#bhv2').val(rep[0]["TargetResponseBehavior2"]);
            $('#arba').val(rep[0]["Arbalester"]);
            $('#bhv3').val(rep[0]["TargetResponseBehavior3"]);
            $('#tgtr1').val(rep[0]["TargetLevel"]);
            $('#tgtr2').val(rep[0]["TargetLevel2"]);
            $('#tgtr3').val(rep[0]["TargetLevel3"]);
            $('#shotdist').val(rep[0]["ShotDistance"]);
            $('#grp1').val(rep[0]["GroupLevel1"]);
            $('#smplnbr').val(rep[0]["SampleNumber"]);
            $('#grprp1').val(rep[0]["GroupResponseBehavior"]);
            $('#hitloc').val(rep[0]["HitLocation"]);
            $('#grpsz').val(rep[0]["GroupSize"]);
            $('#process').val(rep[0]["Processor"]);
            $('#subsmpl').val(rep[0]["SubSample"]);
            $('#smplngth').val(rep[0]["SampleLength"]);
            var  SampleTaken = rep[0]["SampleTaken"];
            if(SampleTaken==1){
                $('#smpl1').prop("checked", true);
            }
            else if(SampleTaken==0){
                $('#smpl2').prop("checked", true);
            }
            var Samplehead = rep[0]["Samplehead"];
            if(Samplehead==1){
                $('#smplhead1').prop("checked", true);
            }
            else if (Samplehead==0){
                $('#smplhead2').prop("checked", true);
            }
            var SampleCollected = rep[0]["SampleCollected"];
            if(SampleCollected==1){
                $('#collected1').prop("checked", true);
            }
            else if(SampleCollected==0){
                $('#collected2').prop("checked", true);
            }

            var blubberteflon = rep[0]["BlubberTeflonVial"];
            if(blubberteflon==1){
                $('#blubber1').prop("checked", true);
            }
            var BlubberCryovialRed = rep[0]["BlubberCryovialRed"];
            if(BlubberCryovialRed==1){
                $('#blubbercry').prop("checked", true);
            }
            var probable_Dolphin =  rep[0]["probable_dolphin"];
            if(probable_Dolphin==1){
                $('#prbbldol').prop("checked", true);
            }
            var SkinDCryovial = rep[0]["SkinDCryovial"];
            if(SkinDCryovial==1){
                $('#skindcry').prop("checked", true);
            }
            var SkinDMSO = rep[0]["SkinDMSO"];
            if(SkinDMSO==1){
                $('#skindms').prop("checked",true);
            }
            var SkinRNAlater = rep[0]["SkinRNAlater"];
            if(SkinRNAlater==1){
                $('#rna').prop("checked", true);
            }
            var hitlocation = rep[0]["HitLocation"];

            if(hitlocation >=1){
                $('#hitloc').prop("selected", true);
            }
            var rad = rep[0]["Outcome"];
            if(rad == 0){
                $('#missOutcome').prop("checked", true);
                $('#shotnumber3').css("background-color", "");
                $('#shotnumber2').css("background-color", "");
                $('#shotnumber1').css("background-color", "");
            }
            else if(rad==1){
                $('#hitOutcome').prop("checked", true);
                $('#shotnumber3').css('background-color','green');
                $('#shotnumber1').css("background-color", "");
                $('#shotnumber2').css("background-color", "");
            }
            $('#smplnbr').val(rep[0]["SampleNumber"]);
            $('#subsmpl').val(rep[0]["SubSample"])
        }


    });

}


var xaz =[];
var cfa = 0;
var data = [];
$('.Pre-Biopsy1').change(function () {
    if(cfa < 5){
        var set = 0;
        for(var i=0; i < xaz.length; i++){
            if($(this).val() == xaz[i] &&  $(this).val() != -1){
                set = 1;
            }
            if($(this).attr("name") == data[i] &&  $(this).attr("name") != ''){
                if( $(this).val() == -1){
                    xaz.splice(i, 1);
                    data.splice(i, 1);
                    set = 3;
                    cfa = cfa -1;
                }else{
                    xaz[i]= $(this).val();
                    set = 2;
                }
            }
        }
        if(set == 0){
            xaz.push($(this).val());
            data.push($(this).attr("name"));
            cfa = cfa +1;
        } else{
            if(set == 2) {

            }else{
                $(this).val('-1');
            }
        }
    } else {
        if($(this).val() == -1){
            for(var j=0; j < data.length; j++){
                if($(this).attr("name") == data[j] &&  $(this).attr("name") != ''){
                    xaz.splice(j, 1);
                    data.splice(j, 1);
                    set = 3;
                    cfa = cfa -1;
                }
            }
        }else{
            var al = -1;
            for(var k=0; k < data.length; k++){
                if($(this).attr("name") == data[k] &&  $(this).attr("name") != ''){
                    var al = k;
                    break;
                }
            }
            if(al > -1){
                var va = -1;
                for(var t = 0; t < data.length; t++){
                    if($(this).val() == xaz[t] &&  $(this).val() != -1){
                        va = t;
                    }
                }
                if(va > -1){
                    $(this).val(xaz[al]);
                }else{
                    xaz[al] = $(this).val();
                }

            }else{
                $(this).val('-1');
                alert('You have alreday selected 5 values');
            }
        }
    }
    //console.log('value----'+xaz);
    //console.log('data-----'+data);
});

var sa =[]; //xa
var sf = 0; //cf
var sat = []; // dat
$('.Pre-BiopsyG1').change(function () {
    if(sf < 5){
        var set = 0;
        for(var i=0; i < sa.length; i++){
            if($(this).val() == sa[i] &&  $(this).val() != -1){
                set = 1;
            }
            if($(this).attr("name") == sat[i] &&  $(this).attr("name") != ''){
                if( $(this).val() == -1){
                    sa.splice(i, 1);
                    sat.splice(i, 1);
                    set = 3;
                    sf = sf -1;
                }else{
                    sa[i]= $(this).val();
                    set = 2;
                }
            }
        }
        if(set == 0){
            sa.push($(this).val());
            sat.push($(this).attr("name"));
            sf = sf +1;
        } else{
            if(set == 2) {

            }else{
                $(this).val('-1');
            }
        }
    } else {
        if($(this).val() == -1){
            for(var j=0; j <sat.length; j++){
                if($(this).attr("name") == sat[j] &&  $(this).attr("name") != ''){
                    sa.splice(j, 1);
                    sat.splice(j, 1);
                    set = 3;
                    sf = sf -1;
                }
            }
        }else{
            var al = -1;
            for(var k=0; k < sat.length; k++){
                if($(this).attr("name") == sat[k] &&  $(this).attr("name") != ''){
                    var al = k;
                    break;
                }
            }
            if(al > -1){
                var va = -1;
                for(var t = 0; t < sat.length; t++){
                    if($(this).val() == sa[t] &&  $(this).val() != -1){
                        va = t;
                    }
                }
                if(va > -1){
                    $(this).val(sa[al]);
                }else{
                    sa[al] = $(this).val();
                }

            }else{
                $(this).val('-1');
                alert('You have alreday selected 5 values');
            }
        }
    }
    //console.log('value----'+xaz);
    //console.log('data-----'+data);
});



var zaaxa =[];  //zax
var aafca = 0;   //afc
var aataa = [];  //atad
$('.Post-Biopsy1').change(function () {
    if(aafca < 5){
        var set = 0;
        for(var i=0; i < zaaxa.length; i++){
            if($(this).val() == zaaxa[i] &&  $(this).val() != -1){
                set = 1;
            }
            if($(this).attr("name") == aataa[i] &&  $(this).attr("name") != ''){
                if( $(this).val() == -1){
                    zaaxa.splice(i, 1);
                    aataa.splice(i, 1);
                    set = 3;
                    aafca = aafca -1;
                }else{
                    zaaxa[i]= $(this).val();
                    set = 2;
                }
            }
        }
        if(set == 0){
            zaaxa.push($(this).val());
            aataa.push($(this).attr("name"));
            aafca = aafca +1;
        } else{
            if(set == 2) {

            }else{
                $(this).val('-1');
            }
        }
    } else {
        if($(this).val() == -1){
            for(var j=0; j < aataa.length; j++){
                if($(this).attr("name") == aataa[j] &&  $(this).attr("name") != ''){
                    zaaxa.splice(j, 1);
                    aataa.splice(j, 1);
                    set = 3;
                    aafca = aafca -1;
                }
            }
        }else{
            var al = -1;
            for(var k=0; k < aataa.length; k++){
                if($(this).attr("name") == aataa[k] &&  $(this).attr("name") != ''){
                    var al = k;
                    break;
                }
            }
            if(al > -1){
                var va = -1;
                for(var t = 0; t < aataa.length; t++){
                    if($(this).val() == zaaxa[t] &&  $(this).val() != -1){
                        va = t;
                    }
                }
                if(va > -1){
                    $(this).val(zaaxa[al]);
                }else{
                    zaaxa[al] = $(this).val();
                }

            }else{
                $(this).val('-1');
                alert('You have alreday selected 5 values');
            }
        }
    }
    //console.log('value----'+xaz);
    //console.log('data-----'+data);
});

//

var paz =[];
var pfa = 0;
var pata = [];
$('.Post-BiopsyG1').change(function () {
    if(pfa < 5){
        var set = 0;
        for(var i=0; i < paz.length; i++){
            if($(this).val() == paz[i] &&  $(this).val() != -1){
                set = 1;
            }
            if($(this).attr("name") == pata[i] &&  $(this).attr("name") != ''){
                if( $(this).val() == -1){
                    paz.splice(i, 1);
                    pata.splice(i, 1);
                    set = 3;
                    pfa = pfa -1;
                }else{
                    paz[i]= $(this).val();
                    set = 2;
                }
            }
        }
        if(set == 0){
            paz.push($(this).val());
            pata.push($(this).attr("name"));
            pfa = pfa +1;
        } else{
            if(set == 2) {

            }else{
                $(this).val('-1');
            }
        }
    } else {
        if($(this).val() == -1){
            for(var j=0; j < pata.length; j++){
                if($(this).attr("name") == pata[j] &&  $(this).attr("name") != ''){
                    paz.splice(j, 1);
                    pata.splice(j, 1);
                    set = 3;
                    pfa = pfa -1;
                }
            }
        }else{
            var al = -1;
            for(var k=0; k < pata.length; k++){
                if($(this).attr("name") == pata[k] &&  $(this).attr("name") != ''){
                    var al = k;
                    break;
                }
            }
            if(al > -1){
                var va = -1;
                for(var t = 0; t < pata.length; t++){
                    if($(this).val() == paz[t] &&  $(this).val() != -1){
                        va = t;
                    }
                }
                if(va > -1){
                    $(this).val(paz[al]);
                }else{
                    paz[al] = $(this).val();
                }

            }else{
                $(this).val('-1');
                alert('You have alreday selected 5 values');
            }
        }
    }
    //console.log('value----'+xaz);
    //console.log('data-----'+data);
});

