
$(document).ready(function () {
    $("#datepicker").datepicker();
    $("#chatImageUpload").validate({
//specify the validation rules
        errorClass: "error-class",
        rules: {
            name: "required",
            email: {
                required: false,
                email: true //email is required AND must be in the form of a valid email address
            },
            // observedolphins:"required",
            waterbody:"required",
            addresss:"required",
            size1:"required",
            BestImage:"required"

        },
        errorPlacement: function(error, element) {
            if (element.attr("name") == "size1" )
                error.insertAfter("#size1_validate");
            else
                error.insertAfter(element);
        },
//specify validation error messages
        messages: {
            name: "Name field cannot be blank!",
            email: "Please enter a valid email address",
            observedolphins:"Dolphin observed are required",
            waterbody: "This field is required",
            addresss:"Address is required",
            size1: "Size is required",
            BestImage:"File is required"
        },
        submitHandler: function(){
            var formData = new FormData(document.getElementById("chatImageUpload"));
            $.ajax({
                url: '/classes/'+'Dolphin.cfc?method=dolphinwatching',
                type: "POST",
                data: formData,
                async: false,
                success: function (msg) {

                },
                cache: false,
                contentType: false,
                processData: false
            });
        }
    });
});




////





