<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfparam name="form.id" default="10">
<cfset Application.record_per_page = 5>
<cfset qgetCetaceanSpecies = Application.Cetaceans.get_CetaceanList()>
<cfset getCetaceanSpeciesData = Application.StaticDataNew.getCetaceanSpecies()>
<cfset getCetacean=Application.Cetaceans.getsingl_Cetacean(argumentCollection="#Form#")>
<cfset qgetCategory= Application.StaticDataNew.getCategory()>
<cfif isdefined('FORM.addTracking')>
    <cfset qTrackinInsert = Application.StaticDataNew.TrackinInsert(argumentCollection="#Form#")>   
</cfif>

<cfif isdefined('FORM.editTracking')>
    <cfset qeditTrackingList = Application.StaticDataNew.editTrackingList(argumentCollection="#Form#")>
</cfif>

 <cfset qgetTrackingList= Application.StaticDataNew.getTrackingList()>

 
<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset   qgetTrackingList=Application.StaticDataNew.getTrackingListByword(form.searchword)>
</cfif>
		<!-- begin #content -->
		<div id="content" class="content content-padding">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">Tracking Lists</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Tracking Lists</h1>
			<!-- end page-header -->
			<cfif isdefined('qeditTrackingList') and qeditTrackingList.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Updated!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif> 
				   <cfif isdefined('qTrackinInsert') and qTrackinInsert.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Added!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif>

            <div class="section-container section-with-top-border p-b-10 custom-form">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <!-- <h5 class="m-t-0">Tracking List</h5> -->
                     <cfoutput>
                        <form class="form-horizontal" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="add-stranding" method="post">
                            <div class="row">
                               <div class="col-md-9 mob-p">
                                   <div class="row m-0">
                                    <div class="col-md-6">
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label">Species</label>
                                            <div class="col-md-7 p-0">
                                                <select class="form-control" name="species" id="species" onChange="getCode()">
                                                <option value="">Select Species</option>
                                                    <cfloop query="getCetaceanSpeciesData">
                                                     <option value="#id#">#CetaceanSpeciesName#</option>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                        <input type="hidden" value="" name="codee" id="codee"/>
                                        <input type="hidden" value="" name="codee1" id="codee1"/>
                                        <input type="hidden" value="" name="codee2" id="codee2"/>
                                        <input type="hidden" value="" name="speciesee" id="speciesee"/>
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label">Code</label>
                                            <div class="col-md-7 p-0">                                                
                                                <select class="form-control" name="code" id="code" onChange="getImage()">
                                                    <option value="">Select Code</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label">Code</label>
                                            <div class="col-md-7 p-0">
                                                <select class="form-control" name="code1" id="code1" onChange="getImage1()" >
                                                    <option value="">Select Code</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label">Code</label>
                                            <div class="col-md-7 p-0">
                                                <select class="form-control" name="code2" id="code2"  onChange="getImage2()">
                                                    <option value="">Select Code</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label">Cetacean Name</label>
                                            <div class="col-md-7 p-0">
                                                <input type="text" class="form-control" name="cetaceanName" id="cetaceanName" />
                                            </div>
                                        </div>
                                        
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label"></label>
                                            <!--- <div class="col-md-7 p-0 upload-img">
                                               <img src="#Application.CloudRoot#no-image.jpg" id="alt_img" alt="" width="200">
                                            </div> --->
                                            <input type="hidden" value="" name="Track_id" id="Track_id"/>
                                            <input type="hidden" value="" name="image" id="image"/>
                                        </div> 
                                    </div>
                                    <div class="col-md-6">
                                        
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label">Tracking Date</label>
                                            <div class="col-md-7 p-0">
                                                <input type="date" class="form-control prr-0" name="trackingDate" id="trackingDate" />
                                            </div>
                                        </div>
                                        <div class="form-group m-b-10">
                                            <label class="col-md-5 control-label">Categories</label>
                                            <div class="col-md-7 p-0">
                                                <select class="form-control" name="categories" id="categories">
                                                    <option value="">Select Category</option>
                                                    <cfloop query="qgetCategory">
                                                        <cfif qgetCategory.status eq 1>
                                                            <option value="#qgetCategory.CategoryName#">#qgetCategory.CategoryName#</option>
                                                        </cfif>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group m-b-10">  
                                            <label class="col-md-5 control-label"></label>
                                            <div class="col-md-7 p-0">
                                                <div class="rado-bg">
                                                    <div class="radio-item">
                                                        <input type="radio" id="active" name="status" value="1"/>
                                                        <label class="control-label">Active</label>
                                                    </div>
                                                    <div class="radio-item">
                                                        <input type="radio" id="inactive" checked="checked" name="status" value="0"/>
                                                        <label  class="control-label">Inactive</label>
                                                    </div>
                                                </div>
                                               
                                            </div> 
                                        </div> 
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group m-b-10 col-md-12 text-area">
                                            <label class="col-md-2 control-label"></label>
                                            <div class="col-md-10 prr-0">
                                                <textarea class="form-control" name="comments" id="comments" placeholder="Comments" rows="8"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-9 col-md-offset-3 action-button-wrap">
                                            <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
                                                <button type="submit" name="addTracking" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
                                            </cfif>
                                            <button class="btn btn-default width-100" type='reset'>Cancel</button>
                                        </div>
                                    </div>
                                   </div> 
                               </div>
                               <div class="col-md-3"> 
                               </div>
                            </div>  
                        </form>
                    </cfoutput>
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->

                </div>
                <!-- end row -->
		</div>
            <!-- begin section-container -->
            <div class="section-container section-with-top-border">
            
            <div class="form-group m-b-10" style="overflow: hidden;">
               	<div class="row col-md-3">
                   <form class="navbar-form form-input-flat" method="post" name="paginationform">
                   <div class="form-group">
                   <input type="text" name="searchword" class="form-control" 
                  value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0><cfoutput>#form.searchword#</cfoutput></cfif>" placeholder="search...">
                   <input type="hidden" name="startHereIndex" value="1" />
                   <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
                   </div>
                   </form>
                   </div>
                 </div>
                 
                <!-- begin panel -->
                <div class="panel pagination-inverse m-b-0 clearfix table-overflow">
                    <table id="example" class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Sr#</th>
                                <th>Species</th>
								<th>Code</th>
								<th>Code</th>
								<th>Code</th>
                                <th hidden>Cetacean Name</th>
                                <th>Tracking Date</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                      	<tbody>
                         <cfoutput query="qgetTrackingList">
                         	<tr class="inverse" id="remov_#ID#">
                                <td>#qgetTrackingList.currentRow#</td>
                                <td id='species-#id#'>#species#</td>
                                <td id='code-#id#'>#code#</td>
                                <td id='code1-#id#'>#code1#</td>
                                <td id='code2-#id#'>#code2#</td>
                                <!--- <td id='cetaceanName-#id#'>#cetaceanName#</td> --->
                                <td id='trackingDate-#id#'>#trackingDate#</td>
                                <td id='categories-#id#'>#categories#</td>
                                <!--- <td id='categories-#id#'>#categories#
                                    <span id="comments-#id#" hidden>#comments#</span>
                                </td> --->
                                <td hidden>
                                    <span id="comments-#id#" hidden>#comments#</span>
                                    <span id="cetaceanName-#id#" hidden>#cetaceanName#</span>
                                </td>
                                
                                <cfif #status# eq 1 >
                                    <td  id="seletecActiveValue-#id#">Active</td>
                                <cfelse>
                                    <td  id="seletecActiveValue-#id#">Inactive</td>
                                </cfif>
                               
                                <td>
                                    <button class="btn btn-xs btn-primary update"<cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0 >
                                         onclick="updateRecord(#ID#)"</cfif>><i class="fa fa-pencil-square-o"></i>
                                    </button>
                                    &nbsp; &nbsp;&nbsp;&nbsp; 
                                    <button class="btn btn-xs btn-primary"<cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0 >
                                         onclick="return deleteRecord(#ID#)"</cfif>><i class="glyphicon glyphicon-trash"></i>
                                    </button>
                                </td>
                            </tr>
                         </cfoutput>
                        </tbody>
                    </table>
                </div>
                <!-- end panel -->
            </div>
            <script>
                function getImage1(){
                    codee = $("#code1 option:selected").text();
                    $("#codee1").val(codee); 
                }
                function getImage2(){
                    codee = $("#code2 option:selected").text();
                    $("#codee2").val(codee); 
                }

                function getImage(){
                    ID = $("#code option:selected").val();
                    codee = $("#code option:selected").text();
                    $("#codee").val(codee);

                    // if(code != 0){
                    //     $.ajax({
                    //         url: application_root + "Cetaceans.cfc?method=getCetaceanById",
                    //         Datatype: "json",
                    //         type: "get",
                    //         data: {
                    //             cetacean_ID: ID,
                    //         },
                    //         success: function (data) {
                    //             var obj = JSON.parse(data);
                    //             $('#alt_img').attr('src', "<cfoutput>#Application.CloudRoot#</cfoutput>" + obj.ImageName);
                    //             $('#cetaceanName').val(obj.Name);
                    //         }
                    //     });
                    // }
                }
                function getCode(){
                    species = $("#species option:selected").val();
                    sp = $("#species option:selected").text();
                    $("#speciesee").val(sp);
                    $('#code').empty();
                    $('#code').append(new Option('Select Code','0'));
                    if(species != 0){
                        $.ajax({
                            url: application_root + "SightingNew.cfc?method=getCetaceansCodeForTracking",
                            Datatype: "json",
                            type: "get",
                            data: {
                                Cetacean_Species: species,
                            },
                            success: function (data) {
                                var obj = JSON.parse(data);
                                for (var i = 0; i < obj.DATA.length; i++) {
                                        console.log(obj.DATA[i][0]);
                                        $('#code').append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
                                        $('#code1').append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
                                        $('#code2').append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
                                }
                            }
                        });
                    }
                }
            </script>
            <!-- end section-container -->
			<div class="footer" id="footer">
                <span class="pull-right">
                    <a data-click="scroll-top" class="btn-scroll-to-top" href="javascript:;">
                    	<i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                    </a>	
                    </span>
                &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
            </div>

		</div>		
		<!-- end #content -->