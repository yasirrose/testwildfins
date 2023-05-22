var CloudRoot = "http://cloud.wildfins.org/";
$(document).ready(function () {
    var imagePath = "http://test.wildfins.org/resources/assets/img/";
    isSightingFill = false;
    $(document).on("click", ".sighting-detail", function () {
        var form = $(this).closest("form");
        form.submit();
    });

    var isOpenCS = $('#open_cetacean_sighting').val();
    if ($('#open_cetacean_sighting').length > 0 && isOpenCS == 1) {
        openCSModal();
    }

    if ($('#open_cetacean_sighting').length > 0 && isOpenCS == 0) {
        customResetElement();
    }

    $(".closeLesionUpdateModal").on('click', function (e) {
        $('#update_lesion').removeClass('in');
        $('#update_lesion').hide();
    });

    $(".sighting_required").click(function () {
        var Sid = $("#sightid").val();
        var Pid = $("#project_val").val();
        if (Sid == 0 || Pid == 0) {
            bootbox.alert('Please Select Sightings');
        }
    });

    $("#btn_dolphin_img").click(function () {
        $('.cetacean-name').html('Dolphin');
        $('.breakdown-image').attr('src', imagePath + 'dolphin-breakdown-diagram.png');
    });
    $("#btn_whale_img").click(function () {
        $('.cetacean-name').html('whale');
        $('.breakdown-image').attr('src', imagePath + 'whale-breakdown.png');
    });



    $(window).keydown(function (event) {
        if (event.target.tagName != 'TEXTAREA') {
            if (event.keyCode == 13) {
                event.preventDefault();
                return false;
            }
        }
    });

    $(".search-box").select2();


    $("#mybiopsy").click(function (event) {
        $('#cetacean_modal_close').trigger('click');
        $('#biopsylist').modal('hide');
        setTimeout(function () {
            $('#biopsyid').modal('show');
        }, 2000);
        event.stopPropagation();
    });

    $('#first_blist').click(function () {
        $('#biopsylist').modal('show');
    })

    $('.dolphin-modal').click(function () {
        $('#biopsyid').modal('hide');
        setTimeout(function () {
            $('#cetacean').modal('show');
        }, 2000);

    });

    $('.biopsy-list').click(function () {
        $('#biopsyid').modal('hide');
        setTimeout(function () {
            $('#biopsylist').modal('show');
        }, 2000);
    });


    $('#Viewbiopsy').click(function (event) {
        event.stopPropagation();
    });

    $("#upload-utility-4").fileinput({
        showCaption: false
    });
    $("#dscore_assign").click(function () {

        $(".display_data").slideUp();
        $(this).hide();
        $("#goback-block").show();
        $("#goback").show();
        $("#dolhphinadd").show();
        $(".add_new").slideDown();
        $("#dolhphinassign").show();
    });

    $("#goback").click(function () {
        $(".add_new").slideUp();
        $(this).hide();
        $("#goback-block").hide();
        $(".display_data").slideDown();
        $("#dscore_assign").show();
        $("#dolhphinadd").hide();
        $("#dolhphinassign").hide();
        $(".add_new_dolphin_form").hide();

    });

    $("#dolhphinassign").click(function () {
        $(".add_new_dolphin_form").slideUp();
        $(".add_new").slideDown();
        $(".add_new_dolphin_form").show();
    });

    $("#Cetacean_code").change(function () {
        var cetacean_ID = $(this).val();
        var cetacean_Code = $( "#Cetacean_code option:selected" ).text().split("|")[1].trim();
        if (cetacean_ID != '') {
            $("#cl_cs_Id").val(cetacean_ID);
            $("#cl_cs_code").val($( "#Cetacean_code option:selected" ).text().split("|")[1].trim());
            $("#set_cetacean_code").val(cetacean_ID);
            $.ajax({
                type: "post",
                Datatype: "json",
                data: {
                    cetacean_ID: cetacean_ID
                },
                url: application_root + "Cetaceans.cfc?method=getCetaceanById",
                success: function (data) {
                    //$("#btn_whale_img").trigger("click");
                    // $(".customLesionRadio").attr("checked", false);
                    $('.selected-region').val('').change();
                    $('.customLesionSelect').val(0).change();
                    var obj = JSON.parse(data);
                    $("#add_dscore").val(obj.DScore);
                    $("#add_species").val(obj.CetaceanSpeciesName);
                    $("#add_sex").val(obj.Sex);
                    $("#FB_Number").val(obj.FB_Number);
                },
                error: function (err) {
                    console.log("error:", err);
                }
            });
            $.ajax({
                type: "post",
                Datatype: "json",
                data: {
                    cetacean_Code: cetacean_Code
                },
                url: application_root + "Cetaceans.cfc?method=getCetacean_Lesions",
                success: function (data) {
                    $('#lesion_table').empty();
                    var obj = JSON.parse(data);
                    // console.log(data);
                    // console.log(obj);
                    for (i = 0; i <=obj.DATA.length; ++i) {
                        $('#lesion_table').append('<tr><td class="tddate">' +moment(obj.DATA[i][2]).format("MM/DD/YYYY")+'</td><td class="sno">' +obj.DATA[i][0]+'</td><td class="ltype">' +obj.DATA[i][3]+'</td><td class="lside">' +obj.DATA[i][5]+'</td><td class="lstatus">' +obj.DATA[i][6]+'</td><td class="lregion">' +obj.DATA[i][4]+'</td></tr>');
                    }
                },
                error: function (err) {
                    console.log("error:", err);
                }
            });
            $.ajax({
                type: "post",
                Datatype: "json",
                data: {
                    cetacean_Code: cetacean_Code
                },
                url: application_root + "Cetaceans.cfc?method=getCetacean_Lesions_unique",
                success: function (data) {
                    $('#updtaedata').empty();
                    $('#save_button').empty();
                    var obj = JSON.parse(data);
                    if(obj.DATA.length){

                        // $('#updtaedata').append('<select id="unqueLesions"></select><select id="lesionsSideSelect"><option value="">Select Side</option></select><select id="lesionsStatusSelect"><option value="">Select Status</option></select><select id="lesionsRegionSelect"><option value="">Select Region</option></select><select id="sel"><option value="YES">YES</option><option value="NO">NO</option><option value="CBD">CBD</option></select>');
                        $('#updtaedata').append('<select id="unqueLesions"></select><select id="lesionsSideSelect"><option value="">Side</option><option value="L">L</option><option value="R">R</option><option value="L/R">L/R</option></select><select id="lesionsStatusSelect"><option value="">Status</option><option value="Fresh">Fresh</option><option value="Healing">Healing</option><option value="Healed">Healed</option></select><select id="lesionsRegionSelect"><option value="">Region</option><option value="1">Head</option><option value="2">Cranial Ventral</option><option value="3">Thorax</option><option value="4">Flipper</option><option value="5">Dorsal Fin</option><option value="6">Lateral Abdomen</option><option value="7">Caudel Ventral</option><option value="8">Peduncle</option><option value="9">Flukes</option></select><select id="sel"><option value="YES">YES</option><option value="NO">NO</option><option value="CBD">CBD</option></select>');

                        $('#save_button').append('<button type="button" class="btn btn-success" onClick="save_exis_lesion()">Save</button>');
                        let lregion= "";
                        let lrname= "";
                        let lside= "";
                        for (i = 0; i <=obj.DATA.length; ++i) {
                            if(obj.DATA[i][1] != ""){
                                // lregion = ' - '+obj.DATA[i][1];
                                // lrname = ' - '+obj.DATA[i][3];
                                lregion = obj.DATA[i][1];
                                lrname = obj.DATA[i][3];
                                
                            }
                            if(obj.DATA[i][2] != ""){
                                lside = obj.DATA[i][2];
                            }                        

                            // if(obj.DATA[i][0] != "" && obj.DATA[i][0] != "0"){
                            //     $('#unqueLesions').append('<option value="'+obj.DATA[i][0]+'='+obj.DATA[i][1]+'='+obj.DATA[i][2]+'">'+obj.DATA[i][0]+lrname+lside+'</option>');
                            // }
                            if(obj.DATA[i][0] != "" && obj.DATA[i][0] != "0"){
                                $('#unqueLesions').append('<option value="'+obj.DATA[i][0]+'='+obj.DATA[i][1]+'='+obj.DATA[i][2]+'">'+obj.DATA[i][0]+'</option>');
                            }
                            // if(obj.DATA[i][0] != "" && obj.DATA[i][0] != "0"){
                            //     $('#lesionsSideSelect').append('<option value="'+obj.DATA[i][0]+'='+obj.DATA[i][1]+'='+obj.DATA[i][2]+'">'+lside+'</option>');
                            // }
                            // if(obj.DATA[i][0] != "" && obj.DATA[i][0] != "0"){
                            //     $('#lesionsStatusSelect').append('<option value="'+obj.DATA[i][0]+'='+obj.DATA[i][1]+'='+obj.DATA[i][2]+'">'+lrname+'</option>');
                            // }
                            // if(obj.DATA[i][0] != "" && obj.DATA[i][0] != "0"){
                            //     $('#lesionsRegionSelect').append('<option value="'+obj.DATA[i][0]+'='+obj.DATA[i][1]+'='+obj.DATA[i][2]+'">'+lregion+'</option>');
                            // }
                        }
                    }

                },
                error: function (err) {
                    console.log("error:", err);
                }
            });
        }
    });

    $("#dolphin_code").change(function () {
        var dolphin_ID = $(this).val();
        if (dolphin_ID != '') {
            $.ajax({
                type: "post",
                Datatype: "json",
                data: {
                    dolphin_ID: dolphin_ID
                },
                url: application_root + "SightingNew.cfc?method=getdolphin",
                success: function (data) {
                    var obj = JSON.parse(data);

                    $("#add_dscore").val(obj[0].DScore);
                    $("#add_distictdate").val(obj[0].DistinctDate);
                    $("#dscore_date").val(obj[0].DScoreDate);
                    $('#dolphnname').val(obj[0].Code);
                    if (obj[0].Distinct == 1) {
                        $("#add_distict").attr("checked", "checked");
                    } else {
                        $('#add_distict').attr('checked', false);
                    }
                    $("#add_sex").val(obj[0].Sex);
                    $("#add_Lineage").val(obj[0].Lineage);
                    $("#add_FB_No").val(obj[0].FB_No);
                }
            });

        }

    });

    $("#dolphin_up_code").change(function () {
        var dolphin_ID = $(this).val();
        if (dolphin_ID != '') {
            $.ajax({
                type: "post",
                Datatype: "json",
                data: {
                    dolphin_ID: dolphin_ID
                },
                url: application_root + "SightingNew.cfc?method=getdolphin",
                success: function (data) {
                    var obj = JSON.parse(data);

                    $("#update_dscore").val(obj[0].DScore);
                    $("#update_distictdate").val(obj[0].DScoreDate);
                    if (obj[0].Distinct == 1) {

                        $("#update_distict").attr("checked", "checked");
                    } else {
                        $('#update_distict').attr('checked', false);
                    }
                    $("#update_sex").val(obj[0].Sex);
                    $("#update_Lineage").val(obj[0].Lineage);
                    $("#update_FB_No").val(obj[0].FB_No);
                    var xeno = obj[0].xeno;
                    if (xeno == 0) {
                        $('#xenozero').prop("checked", true);
                    } else if (xeno == 1) {
                        $('#xnone').prop("checked", true);
                    }
                    var rds = obj[0].RDS;
                    if (rds == 0) {
                        $('#rdszero').prop("checked", true);
                    } else if (rds == 1) {
                        $('#rdsone').prop("checked", true);
                    }

                    var rem = obj[0].rem;
                    if (rem == 0) {
                        $('#remzero').prop("checked", true);
                    } else if (rem == 1) {
                        $('#remone').prop("checked", true);
                    }
                    var wound = obj[0].Freshwound;
                    if (wound == 0) {
                        $('#freshzero').prop("checked", true);
                    } else if (wound == 1) {
                        $('#freshone').prop("checked", true);
                    }

                    var tiger = obj[0].tiger;
                    if (tiger == 1) {
                        $('#tgr').prop("checked", true);
                    }

                    $('#Tiger_Description').val(obj[0].Tiger_Description);

                    var shark = obj[0].shark;
                    if (shark == 1) {
                        $('#shrk').prop("checked", true);
                    }

                    $('#shark_Description').val(obj[0].shark_Description);
                }
            });

        }

    });



    /*******   Value insert into  Field  ******************/
    $(".get_val").click(function () {
        var value = $(this).attr("val");
        var id = $(this).attr("id").split("_");
        $("#" + id[0] + "_" + id[1]).val(value);
    });


    function sumcalculate() {

        add_pqf = parseInt($("#add_pqf").val());
        add_pqa = parseInt($("#add_pqa").val());
        add_pqc = parseInt($("#add_pqc").val());
        add_pqpro = parseInt($("#add_pqpro").val());
        add_pqpar = parseInt($("#add_pqpar").val());
        var vals = '';

        var sum = add_pqf + add_pqa + add_pqc + add_pqpro + add_pqpar

        if (sum > 0 && sum <= 5) {
            vals = sum;
        } else if (sum >= 6 && sum <= 9) {
            vals = "Q-1";
        } else if (sum >= 10 && sum < 12) {
            vals = "Q-2"
        } else if (sum >= 12) {
            vals = "Q-3";
        }
        $("#add_pqsum").val(sum);
        $("#add_qscoresum").val(vals);
    }



    $(".sum_calculate").keyup(function () {
        sumcalculate();
    });
    $(".sum_calculate").blur(function () {
        sumcalculate();
    });
    $(".sum_calculate").click(function () {
        sumcalculate();
    });

    function sumcalculate_update(index) {
        add_pqf = parseInt($("#update_pqf" + index).val());
        add_pqa = parseInt($("#update_pqa" + index).val());
        add_pqc = parseInt($("#update_pqc" + index).val());
        add_pqpro = parseInt($("#update_pqpro" + index).val());
        add_pqpar = parseInt($("#update_pqpar" + index).val());

        var sum = add_pqf + add_pqa + add_pqc + add_pqpro + add_pqpar

        if (sum > 0 && sum <= 5) {
            vals = sum;
        } else if (sum >= 6 && sum <= 9) {
            vals = "Q-1";
        } else if (sum >= 10 && sum < 12) {
            vals = "Q-2"
        } else if (sum >= 12) {
            vals = "Q-3";
        }
        $("#update_pqsum_" + index).val(sum);
        $("#qscore_" + index).val(vals);
    }

    $(".sum_calculate_update").keyup(function () {
        var index = $(this).attr("index");
        alert(index);
        sumcalculate_update(index);
    });
    $(".sum_calculate_update").blur(function () {
        var index = $(this).attr("index");
        sumcalculate_update(index);
    });
    $(".sum_calculate_update").click(function () {
        var index = $(this).attr("index");
        sumcalculate_update(index);
    });


    $(".getvals").click(function () {
        text = $(this).text();
        val = $(this).attr("val");
        id = $(this).attr("id").split("_");
        $("#" + id[0] + "_" + id[1]).val(text);
        $("#" + id[0] + "_" + id[1] + "_ID").val(val);

    });
    $('.getvals_update').on('click', function () {
        var sdo_val = $(this).text().trim();
        var sdo_id = $(this).text().split(' | ')[0].trim();
        var input_id = $(this).attr('id').split('_');
        var sdo_val_input_id = input_id[0] + '_' + input_id[1] + '_val_' + input_id[3];
        var sdo_id_input_id = input_id[0] + '_' + input_id[1] + '_id_' + input_id[3];
        $('#' + sdo_val_input_id).val(sdo_val);
        $('#' + sdo_id_input_id).val(sdo_id);
    });

    /*   ///form submit
    $("#add_dolphin_form").submit(function(){
    data=$( "#add_dolphin_form" ).serialize();

    $.ajax({
    type:"post",
    data:data,
    url:application_root+"Sighting.cfc?method=add_dolphin",
    success:function(res){
    $(".message").show();
    $(".reset").trigger("click");
    $(".message").html(res);
    setTimeout(function(){$(".message").hide();},4000);
    }
    });


    $.ajax({
    type:"post",
    data:{Sightningid:$("#getsight_ID").val()},
    url:application_root+"Sighting.cfc?method=getlist_dolphinsight",
    success:function(res){
    $(".display_data").html(res);

    }
    });

    return false;
    });
    */
    /////Delete Dolphin

    $("#add_pqf").on("focusout", function () {
        var number = $('#add_pqf').val();
        if (parseInt(number) < 2) {
            alert('PQ F must be greater then 1');
            $('#add_pqf').val(2);
        }
    });



    $(".delete_dolphin").click(function () {
        var conf = confirm("Are you sure to Delete this Dolphin?");
        if (conf == true) {
            var id = $(this).attr("id").split('_');
            SightingID = $(this).attr("Sighting_ID");
            DolphinID = $(this).attr("Dolphin_ID");

            $.ajax({
                type: "post",
                data: {
                    SightingID: SightingID,
                    DolphinID: DolphinID
                },
                url: application_root + "SightingNew.cfc?method=del_dolphinsight",
                success: function (res) {
                    $("#dolphindetail_" + id[1]).remove();
                    if ($("#sightingHistory_" + id[1]).length > 0) {
                        $("#sightingHistory_" + id[1]).remove();
                    }
                    alert(res);
                }
            });
        } else {
            return false;
        }
    });

    $(".delete_cetacean").click(function () {
        var conf = confirm("Are you sure to Delete this Cetacean Sighting ?");
        if (conf == true) {
            var id = $(this).attr("id").split('_');
            SightingID = $(this).attr("Sighting_ID");
            CetaceanID = $(this).attr("Cetaceans_ID");
            $.ajax({
                type: "post",
                data: {
                    SightingID: SightingID,
                    CetaceanID: CetaceanID
                },
                url: application_root + "Cetaceans.cfc?method=del_cetaceansight",
                success: function (res) {
                    $("#dolphindetail_" + id[1]).remove();
                    if ($("#sightingHistory_" + id[1]).length > 0) {
                        $("#sightingHistory_" + id[1]).remove();
                    }
                    alert(res);
                }
            });

        } else {
            return false;
        }
    });

    $(".input-5").fileinput({
        showCaption: false
    });
    // App.init();



    $(".input-5").change(function () {
        var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
        if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
            alert("Only formats are allowed : " + fileExtension.join(', '));
            $(".input-5").val('');
        }

    });
    ///form submit

    $('.update_dolphin').click(function () {
        form_id = $(this).attr("data_id");
        var formData = new FormData(document.getElementById(form_id));
        $.ajax({
            type: "POST",
            data: formData,
            url: application_root + "SightingNew.cfc?method=update_dolphinsight",
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            success: function (res) {
                $(".message").show();
                $(".reset").trigger("click");
                $(".message").html(res);
                setTimeout(function () {
                    $(".message").hide();
                }, 4000);
            }

        });
    });



    $('#login_form').formValidation({
        framework: 'bootstrap',
        err: {
            container: 'tooltip'
        },
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            Email: {
                validators: {
                    notEmpty: {
                        message: 'Please Enter email'
                    },
                    emailAddress: {
                        message: 'This email address is not valid Emial Address'
                    }
                }
            },
            Password: {
                validators: {
                    notEmpty: {
                        message: 'Please Enter email'
                    }
                }
            }

        }

    });

    $('#add_dolphinto_dolhpin').formValidation({
        framework: 'bootstrap',
        err: {
            container: 'tooltip'
        },
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            Name: {
                validators: {
                    notEmpty: {
                        message: 'Please Enter name'
                    }
                }
            }

        }

    }).on('success.form.fv', function (e) {
        // Prevent form submission
        e.preventDefault();
        data = $("#add_dolphinto_dolhpin").serialize();
        var fd = new FormData(document.getElementById("add_dolphinto_dolhpin"));
        $.ajax({
            url: application_root + "Dolphin.cfc?method=add_New_dolphin",
            type: "POST",
            data: fd,
            enctype: 'multipart/form-data',
            processData: false, // tell jQuery not to process the data
            contentType: false, // tell jQuery not to set contentType
            success: function (res) {
                $(".reset").trigger("click");
                $('#add_dolphinto_dolhpin').formValidation('resetForm', true);
                $(".message").show();
                $(".reset").trigger("click");
                $(".message").html(res);
                setTimeout(function () {
                    $(".message").hide();
                }, 4000);

            }
        });
    });

    $("#add_cetaceansSighting_from").submit(function (e) {
        e.preventDefault();
        $('#Cetacean_code').removeAttr('onchange');
        var isSetaceanSelected = $("#Cetacean_code option:selected").val();
        if (isSetaceanSelected != "") {
            var formData = new FormData(document.getElementById('add_cetaceansSighting_from'));

            $.ajax({
                url: application_root + "Cetaceans.cfc?method=add_cetaceans_sighting",
                type: "post",
                data: formData,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                success: function (res) {
                    $("#condition_lesions_form_1").html("");
                    $(".on_update_disabled").removeAttr("disabled");
                    $(".message").show();
                    $(".reset").trigger("click");
                    $(".fileinput-remove").trigger("click");
                    $("#reset_lesion_history").trigger("click");
                    $('.selected-region').val('').change();
                    $("#Cetacean_code").select2({
                        placeholder: "Select a Cetacean Name/Code",
                        value: ""
                    });
                    $('#cl_cs_Id').val(0);
                    $("#set_cetacean_code").val(0);
                    $('#condition_lesions_form').removeClass('is-lesion-form');
                    $('#Cetacean_Sighting_Form_Text').html('Cetacean Sighting Form');
                    // $('#add_cetaceansSighting_btn').html('Submit');
                    $("#alt_images").html("");

                    $(".message").html(res);
                    setTimeout(function () {
                        $(".message").hide();
                    }, 4000);
                    $("#update_cs_Id").val(0);

                    // here we fechted the latest CS list
                    $.ajax({
                        type: "post",
                        data: { Sightningid: $("#getsight_ID").val() },
                        url: application_root + "Cetaceans.cfc?method=getlist_cetaceansight",
                        success: function (res) {
                            $(".CS_history").html(res);
                        }
                    });
                }
            });
        } else {
            alert("Please select Cetacean Name/Code");
        }

        return false;
    });

    $("#add_lesions_form").submit(function (e) {
        var cl_cs_code = $( "#Cetacean_code option:selected" ).text().split("|")[1].trim();
        if (cl_cs_code != "") {
            $('#addNewLesionAndClearTxt').html('Adding New Lesion');
            $('#addNewLesionAndClearTxt').prop('disabled', true);
            e.preventDefault();
            data = $("#add_lesions_form").serialize();
            $.ajax({
                type: "post",
                data: data,
                url: application_root + "ConditionLesions.cfc?method=add_lesions",
                success: function (res) {
                    $('#addNewLesionAndClearTxt').html('Add New Lesion And Clear');
                    $('#addNewLesionAndClearTxt').prop('disabled', false);

                    $(".lesion-message").show();
                    $(".lesion-message").html(res);
                    getlesionsListHistory();
                    // $("#btn_whale_img").trigger("click");
                    // $(".customLesionRadio").attr("checked", false);
                    $("#PhotoNumber").val('');
                    $("#Comments").val('');
                    $('.selected-region').val('').change();
                    $('.customLesionSelect').val(0).change();

                    setTimeout(function () {
                        $(".lesion-message").hide();
                    }, 4000);
                    // Get the list if CL records
                    getlesionsList(false);
                }
            });
            return false;
        } else {
            alert("Please select Cetacean Name/Code");
            return false;
        }
    });




    $("#update_lesions_form").submit(function (e) {
        e.preventDefault();
        data = $("#update_lesions_form").serialize();
        var Lesion_ID = $("#lesion_Id").val();
        $.ajax({
            type: "post",
            data: data,
            url: application_root + "ConditionLesions.cfc?method=update_lesions",
            success: function (res) {
                $(".update-lesion-message").show();
                $(".update-lesion-message").html(res);
                getlesionsListHistory();
                setTimeout(function () {
                    $(".update-lesion-message").hide();
                    // Hide Update modal
                    setTimeout(function () {
                        $('#update_lesion').removeClass('in');
                        $('#update_lesion').hide();
                    }, 200);
                }, 4000);
                // Get the updated records
                // $.ajax({
                //     type: "get",
                //     url: application_root + "ConditionLesions.cfc?method=getLesionById",
                //     data: { Lesion_ID },
                //     success: function (res) {
                //         var obj = JSON.parse(res);
                //         $('#LesionPresent_' + Lesion_ID).html(obj.LesionPresent);
                //         $('#LesionType_' + Lesion_ID).html(obj.LesionType);
                //         var RegionID = obj.Region;
                //         $('#Side_L_R_' + Lesion_ID).html(obj.Side_L_R);
                //         $('#Status_' + Lesion_ID).html(obj.Status);
                //         $.ajax({
                //             type: "get",
                //             url: application_root + "ConditionLesions.cfc?method=getRegionNamebyIdJSON",
                //             data: { RegionID },
                //             success: function (res) {
                //                 $('#Region_' + Lesion_ID).html(res);
                //             },
                //         });
                //     },
                //     error: function (err) {
                //         console.log("err:", err);
                //     }
                // });
            }
        });
        return false;
    });

    $(".FB_Side").click(function () {
        text = $(this).text();

        $("#FB_Side").val(text);
    });


    //////login form Js:
    $("#go_forget").click(function () {
        $("#login_form").slideUp("slow");
        $("#forget_form").slideDown("slow");
    });
    $("#back").click(function () {
        $("#login_form").slideDown("slow");
        $("#forget_form").slideUp("slow");
    });

    //////////////////////////////////Biopsy form submit
    $(document).on('submit', '#biopsyform', function () {
        data = $(this).serialize();

        $.ajax({
            type: "post",
            data: data,
            url: application_root + "Dolphin.cfc?method=Add_Biopsy",
            success: function (res) {
                if (res == "error") {
                    $(".message").show().html('<strong>Alert</strong> Error occurred.');
                    setTimeout(function () {
                        $(".message").hide();
                    }, 5000);
                }

                //resetform
                //  $('#BiopsyReset').trigger('click');
                else {
                    $('#totalFormWrap').animate({
                        scrollTop: 0
                    }, 800);
                    $(".message").show().html('<strong style="margin-left: 100px">Success</strong> Record Added.');
                    setTimeout(function () {
                        $(".message").hide();
                    }, 5000);
                    location.reload();
                }
            },
            error: function (error) {
                $(".message").show().html('<strong>Alert</strong> Error occurred.');
                setTimeout(function () {
                    $(".message").hide();
                }, 5000);
            }

        });


        return false;
    });

    $(document).on('click', '.btnShowSurvey', function (e) {
        var IDs = $(this).data("id").split(",");
        $('input[name=Project_ID]').val(IDs[0]);
        $('input[name=Sight_ID]').val(IDs[1]);
        $('#showSurvey').submit();
    });
    $(document).on('change', '#LesionPresent', function (e) {
        if($('#LesionPresent').val()== "NO")
        {
            $("#LesionType").prop('disabled', 'disabled');
            $("#Side").prop('disabled', 'disabled');
            $("#Status").prop('disabled', 'disabled');
            $("#Region").prop('disabled', 'disabled');

        }
        else{
            $("#LesionType").removeAttr("disabled");
            $("#Side").removeAttr("disabled");
            $("#Status").removeAttr("disabled");
            $("#Region").removeAttr("disabled");
        }
    });
});
function save_exis_lesion() {
    var les = $('#unqueLesions').val();
    const marray = les.split("=");
    var lesion = marray[0];
    // var region = marray[1];
    // var side = marray[2];
    var region = $('#lesionsRegionSelect').val();
    var side =$('#lesionsSideSelect').val();
    var status =$('#lesionsStatusSelect').val();
    var sel = $('#sel').val();
    var cl_cs_code = $("#cl_cs_code").val();
    var sight = $("#getsight_ID").val();
    var Cetacean_code = $('#Cetacean_code').val();

    $.ajax({
        type: "post",
        Datatype: "json",
        data: {
            lesion: lesion,
            region: region,
            status: status,
            side: side,
            sel: sel,
            cl_cs_code:cl_cs_code,
            sight:sight,
            Cetacean_code:Cetacean_code
        },
        url: application_root + "Cetaceans.cfc?method=save_existingLesion",
        success: function (data) {
            $(".lesion-message-exist").show();
            $(".lesion-message-exist").html('<div class="alert alert-success"><strong>Success!</strong> Lesion Status Saved.</div>');
            getlesionsListHistory();
            setTimeout(function () {
                $(".lesion-message-exist").hide();
                }, 4000);
            },
        error: function (err) {
            console.log("error:", err);
        }
    });
}

function getlesionsList(is_history) {
    var cl_cs_Id = $('#cl_cs_Id').val();
    // alert(cl_cs_Id)
    if (cl_cs_Id != "" && cl_cs_Id != 0) {
        $.ajax({
            type: "post",
            data: { cl_cs_Id: cl_cs_Id, Sightningid: $("#getsight_ID").val() },
            url: application_root + "ConditionLesions.cfc?method=getlesionsList",
            success: function (res) {
                $(".lesion_history").html(res);
                if (is_history) {
                    $('#lesion_history').addClass('in');
                    $('#lesion_history').show();
                }
            },
            error: function (err) {
                console.log("err:", err);
            }
        });
    } else {
        alert("Please select Cetacean Name/Code");
        return false;
    }
}



function deleteLesion_Record(Lesion_ID, row) {
    var conf = confirm("Are you sure to Delete this Condition Lesion?");
    if (conf == true) {
        $.ajax({
            type: "post",
            data: { Lesion_ID },
            url: application_root + "ConditionLesions.cfc?method=del_conditionLesion",
            success: function (res) {
                $("#lesionHistory_" + row).remove();
                //getlesionsListHistory();
                alert(res);
            }
        });

    } else {
        return false;
    }
}

$("#btn_CS_history").click(function () {
    $('body').addClass('modal-open');
    $(".on_update_disabled").attr("disabled", "disabled");
});

$(".closeCSHistoryModal").click(function () {
    $("body").removeClass("modal-open");
    $(".on_update_disabled").removeAttr("disabled");
});

$(".cetacean_modal_close").click(function () {
    $("body").removeClass("modal-open");
});


function deleteLesion_Record_New(Lesion_ID, row) {
    var conf = confirm("Are you sure to Delete this Condition Lesion?");
    if (conf == true) {
        $.ajax({
            type: "post",
            data: { Lesion_ID },
            url: application_root + "ConditionLesions.cfc?method=del_conditionLesion",
            success: function (res) {
                //$("#lesionHistoryNew_" + row).remove();
                getlesionsListHistory();
                alert(res);

            }
        });

    } else {
        return false;
    }
}

function deleteCS_Record(cs_ID, row) {
    var conf = confirm("Are you sure to Delete?");
    if (conf == true) {
        $.ajax({
            type: "post",
            data: { cs_ID },
            url: application_root + "Cetaceans.cfc?method=deleteCS_Record",
            success: function (res) {
                $("#CSHistory_" + row).remove();
                alert(res);
            }
        });
    } else {
        return false;
    }
}

function getSingleLesion_Record(Lesion_ID) {
    $.ajax({
        type: "post",
        data: { Lesion_ID },
        url: application_root + "ConditionLesions.cfc?method=getLesionById",
        success: function (data) {
            $('#lesion_history').removeClass('in');
            $('#lesion_history').hide();
            $('#update_lesion').addClass('in');
            $('#update_lesion').show();
            var obj = JSON.parse(data);
            $('#lesion_Id').val(obj.ID);
            // if (obj.LesionPresent == 'Yes') {
            //     $("#update_lesions_form #LPyes").prop("checked", true);
            // } else {
            //     $("#update_lesions_form #LPno").prop("checked", true);
            // }
            $('#update_lesions_form #LesionPresent option[value="' + (obj.LesionPresent).trim() + '"]').prop('selected', true);
            $('#update_lesions_form #LesionType option[value="' + (obj.LesionType).trim() + '"]').prop('selected', true);
            if (obj.Region) {
                var setRegion = obj.Region.split(',');
                if (setRegion.length > 0) {
                    $('#update_lesions_form #Region').val(setRegion).change();
                }
            } else {
                $('#update_lesions_form #Region').val(0).change();
            }
            $('#update_lesions_form #Side option[value="' + (obj.Side_L_R).trim() + '"]').prop('selected', true);
            $('#update_lesions_form #Status option[value="' + (obj.Status).trim() + '"]').prop('selected', true);
            $('#update_lesions_form #PhotoNumber').val(obj.PhotoNumber);
            $('#update_lesions_form #Comments').val(obj.Comments);


        }, error: function (err) {
            console.log("err:", err);
        }
    });
}


function getlesionsListHistory() {
    var cl_cs_code = $( "#Cetacean_code option:selected" ).text().split("|")[1].trim();

    if (cl_cs_code != "") {
        $.ajax({
            type: "post",
            data: { cl_cs_code: cl_cs_code, Sightningid: $("#getsight_ID").val() },
            url: application_root + "ConditionLesions.cfc?method=getlesionsListHistory",
            success: function (res) {
                $("#condition_lesions_form_1").html(res);
                $('#condition_lesions_form').removeClass('is-lesion-form');
                // if ($("#condition_lesions_form_1 h2").html() == "There is no Lesions added yet!") {
                //     // $('#condition_lesions_form').removeClass('is-lesion-form');
                // }
                $('.cetacean-name').html('Dolphin');
                $('.breakdown-image').attr('src', 'http://test.wildfins.org/resources/assets/img/' + 'dolphin-breakdown-diagram.png');
            },
            error: function (err) {
                console.log("err:", err);
            }
        });
    } else {
        alert("Please select Cetacean Name/Code");
        return false;
    }
}

function empty_Lesions_history() {
    //emtpy the lisions list on the cetacean update page.
    $("#add_lesions_form")[0].reset();
    $("#replace-btn").hide();
    $("#condition_lesions_form_1").html("");
    $(".customLesionRadio").attr("checked", false);
    $(".on_update_disabled").removeAttr("disabled");
}

function getSingleCS_Record(cs_ID) {
    $.ajax({
        type: "post",
        data: { cs_ID },
        url: application_root + "Cetaceans.cfc?method=getCSById",
        success: function (data) {
            $('#condition_lesions_form').addClass('is-lesion-form');
            $('#Cetacean_Sighting_Form_Text').html('Update Cetacean Sighting Form');
            // $('#add_cetaceansSighting_btn').html('Update Cetacean Sighting');
            $('#update_cetaceansSighting_btn').css("display", "inline");
            $('#add_cetaceansSighting_btn').css("display", "none");
            $('#CS_history').removeClass('in');
            $('#CS_history').hide();
            $('#replace-btn').show();
            openCSModal();
            var obj = JSON.parse(data);

            if (obj.SDR == 'on') {
                $("#SDR").prop("checked", true);
            }
            if (obj.bestSighting == 'on') {
                $("#bestSighting").prop("checked", true);
            }
            if (obj.Fetals == 'on') {
                $("#Fetals").prop("checked", true);
            }
            if (obj.Calf == 'on') {
                $("#Calf").prop("checked", true);
            }
            if (obj.Yoy == 'on') {
                $("#Yoy").prop("checked", true);
            }
            $("#update_cs_Id").val(obj.ID);
            $('#Cetacean_code').val(obj.Cetaceans_ID).change();
            $("#set_cetacean_code").val(obj.Cetaceans_ID);
            $("#add_dscore").val(obj.DScore);
            $("#add_species").val(obj.Species);
            $("#add_sex").val(obj.Sex);
            $("#FB_Number").val(obj.FB_Number);
            $('#Note').val(obj.Note);
            $('#BestShot').val(obj.BestShot);
            $('#EnteredBy option[value="' + (obj.EnteredBy) + '"]').prop('selected', 'selected');
            $('#wMomDropDown option[value="' + (obj.wMomDropDown) + '"]').prop('selected', 'selected');
            $('#PhotoAnalysisInitial option[value="' + (obj.PhotoAnalysisInitial) + '"]').prop('selected', 'selected');
            $('#PhotoAnalysisFinal option[value="' + (obj.PhotoAnalysisFinal) + '"]').prop('selected', 'selected');
            $("#add_pqf").val(obj.pq_focus && obj.pq_focus != "" ? obj.pq_focus : 0);
            $("#add_pqa").val(obj.pq_Angle && obj.pq_Angle != "" ? obj.pq_Angle : 0);
            $("#add_pqc").val(obj.pq_Contrast && obj.pq_Contrast != "" ? obj.pq_Contrast : 0);
            $("#add_pqpar").val(obj.pq_Partial && obj.pq_Partial != "" ? obj.pq_Partial : 0);
            $("#add_pqpro").val(obj.pq_Proportion && obj.pq_Proportion != "" ? obj.pq_Proportion : 0);
            $("#add_pqsum").val(obj.pqSum && obj.pqSum != "" ? obj.pqSum : 0);
            $("#add_qscoresum").val(obj.Qscore);

            $('#BodyCondition option[value="' + (obj.BodyCondition).trim() + '"]').prop('selected', true);
            $('#Head_NuchalCrest').val(obj.Head_NuchalCrest).change();
            $('#Head_LateralCervicalReg').val(obj.Head_LateralCervicalReg).change();
            $('#Head_FacialBones').val(obj.Head_FacialBones).change();
            $('#Head_EarOS').val(obj.Head_EarOS).change();
            $('#Head_ChinSkinFolds').val(obj.Head_ChinSkinFolds).change();
            $('#Body_EpaxialMuscle').val(obj.Body_EpaxialMuscle).change();
            $('#Body_DorsalRidgeScapula').val(obj.Body_DorsalRidgeScapula).change();
            $('#Body_Ribs').val(obj.Body_Ribs).change();
            $('#Tail_TransversePro').val(obj.Tail_TransversePro).change();

            if (obj.BestImage && obj.BestImage != "") {
                $('#alt_images').show();
                var setPrimaryImage = CloudRoot + (obj.BestImage);
                var setImages = `
                        <li id="cetaceans_sighting_img_1">
                            <P>Cetacean Primary Photo</P>
                            <a href="javascript:void(0);" data-url="${setPrimaryImage}" class="preview viewCetaceanImage" title="Cetacean Primary Photo">
                                <img src="${setPrimaryImage}" alt="PrimaryImage" />
                            </a>
                            <span class="removeCetacean" onClick="deleteCetaceanSightingImage(1,${cs_ID},'${(obj.BestImage)}');">x</span>
                        </li>
                    `;
                $('#alt_images').append(setImages);

                $('#primaryOldImage').val(setPrimaryImage);
            }
            if (obj.SecondaryImage && obj.SecondaryImage != "") {
                $('#alt_images').show();
                var setSecondaryImage = CloudRoot + (obj.SecondaryImage);
                var setImages = `
                        <li id="cetaceans_sighting_img_2">
                            <P>Cetacean Secondary Photo</P>
                            <a href="javascript:void(0);" data-url="${setSecondaryImage}" class="preview viewCetaceanImage" title="Cetacean Secondary Photo">
                                <img src="${setSecondaryImage}" alt="PrimaryImage" />
                            </a>
                            <span class="removeCetacean" onClick="deleteCetaceanSightingImage(2,${cs_ID},'${(obj.SecondaryImage)}');">x</span>
                        </li>
                    `;
                $('#alt_images').append(setImages);

                $('#SecondaryOldImage').val(setSecondaryImage);
            }
            getlesionsListHistory();
        },
        error: function (err) {
            console.log("err:", err);
        }
    });
}

function replaceAnimal() {
    old_cetacean_ID = $( "#Cetacean_code option:selected" ).text().split("|")[1].trim();
    $('#Cetacean_code').attr('onchange', 'getCetaceanChangedValue("' + old_cetacean_ID + '")');
    bootbox.confirm({
        title: "Replace Animal",
        message: "<b><p style='background: gainsboro; padding: 10px;'>Are You Sure?</p></b>",
        buttons: {
            confirm: {
                label: 'Yes',
                className: 'btn-success'
            },
            cancel: {
                label: 'No',
                className: 'btn-danger'
            }
        },
        callback: function (result) {
            if (result) {
                $('#Cetacean_code').select2('open');

            } else {
                $('#Cetacean_code').removeAttr('onchange');
            }
        }
    });

}

function getCetaceanChangedValue(old_cetacean_ID) {
    var new_cetacean_ID = $( "#Cetacean_code option:selected" ).text().split("|")[1].trim();
    var sighting_ID = $("#getsight_ID").val();
    $.ajax({
        type: "post",
        data: { old_cetacean_ID, new_cetacean_ID, sighting_ID },
        url: application_root + "Cetaceans.cfc?method=replaceCetaceanSighting",
        success: function (response) {

        }, error: function (err) {
            console.log("err:", err);
        }
    });
}

function openCSModal() {
    $('#cetacean').addClass('in');
    $('#cetacean').show();
    $("#cetacean").css("overflow", "auto");
    $("#update_cs_Id").val(0);
}


function customResetElement() {
    $("input:text[class^=inputCustomReset]").each(function (i) {
        this.val('');
    });

    $('.selectCustomReset').val('0').change();

    var element = document.getElementsByClassName('textareaCustomReset');
    for (var i = 0; i < element.length; i++) {
        element[i].value = "";
    }

    $("input:radio[class^=radioCustomReset]").each(function (i) {
        this.checked = false;
    });
}

function checkSightingformFill() {
    $("input:text[class^=inputCustomReset]").each(function (i) {
        if (this.val() != "") {
            isSightingFill = true;
        }
    });

    if ($('.selectCustomReset').val() != "" || $('.selectCustomReset').val() != 0) {
        isSightingFill = true;
    }

    var element = document.getElementsByClassName('textareaCustomReset');
    for (var i = 0; i < element.length; i++) {
        element[i].value = "";
    }

    $("input:radio").attr("checked", false);
}


function deleteCetaceanSightingImage(isPrimaryImage, ID, bestImageName) {
    bootbox.confirm("Are you sure?", function (result) {
        if (result == true) {
            $.ajax({
                type: "post",
                data: { isPrimaryImage, ID, bestImageName },
                url: application_root + "Cetaceans.cfc?method=deleteCetaceanSightingImage",
                success: function (data) {
                    $(".cs_img_message").html(data);
                    $("#cetaceans_sighting_img_" + isPrimaryImage).remove();

                    if ($('#cetaceans_sighting_img_1').length == 0 && $('#cetaceans_sighting_img_2').length == 0) {
                        $('#alt_images').hide();
                    }

                    if (isPrimaryImage == 1) {
                        $("#primaryOldImage").val("");
                    } else {
                        $("#SecondaryOldImage").val("");
                    }

                    setTimeout(function () {
                        $(".cs_img_message").hide();
                    }, 5000);
                }, error: function (err) {
                    console.log("err:", err);
                }
            });
        }
    });
}

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#profile_image').attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
        $("#profile_image").show();
        $("#current_profile_image").hide();
    }
}



