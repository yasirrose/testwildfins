<cfset   getuserwatching=Application.Reporting.getWatchingReport()>

<!---<cfdump var="#getuserwatching#">--->
<cfparam default="0" name="FORM.user">
<!---<cfparam default="0" name="FORM.user_id">--->

<cfif isdefined('form.user') and form.user GT 0>
    <cfset getSingleObserver = Application.Reporting.getSingleObserverDetails("#Form.user#")>
</cfif>

<!-- begin ##content -->
<div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Reporting</a></li>
        <li><a href="javascript:;">Dolphin Watch Report</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Dolphin Watch Report </h1>
    <!-- end page-header -->

    <!-- begin row -->
<div class="row">


    <!-- begin row col-6-->
<div class="row col-lg-12">
    <!-- begin panel -->
<div class="panel panel-inverse">
    <div class="panel-heading">
        <div class="panel-heading-btn">
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
        </div>
        <h4 class="panel-title">Filters</h4>
    </div>
<div class="panel-body">

    <!-- start col-md-6 -->
<div class="col-md-6">
    <div class="row">
        <h3>Select Observer</h3>
    <br>

        <form method="POST" action="">
            <div class="row col-md-8">
                <select class="form-control" name="user">
                    <option value="0">Select Observer</option>
                     <cfoutput query="getuserwatching" >
                     <cfset timee="#dateTimeformat(getuserwatching.DATETIME, "YYYY-MM-DD")#">
                    <option value="#getuserwatching.observation_id#">#getuserwatching.name#   
                    #dateTimeformat(getuserwatching.DATETIME, "short")#
                     
                    </option>
                    </cfoutput>
                </select>
            </div>
            <div class="row col-md-4">
                <input type="submit" class="btn btn-success" value="Submit">
            </div>
        </form>
    </div>
</div>
    <!-- end col-md-6 -->

 <cfoutput>   <!-- start col-md-12 -->
<div class="col-md-12 m-t-30">

<cfif isdefined('form') and form.user GT 0>
    <div class="reportWrap">
       <div class="row">
           <div class="col-sm-3">
               <label for="">Observer's Name</label>
               <span>#getSingleObserver.name#</span>
           </div>
           <div class="col-sm-3">
               <label for="">E-mail</label>
               <span>#getSingleObserver.email#</span>
           </div>
           <div class="col-sm-3">
               <label for="">Description</label>
               <span>
                   <ul class="detail_list_info">
                    <cfif isdefined('getSingleObserver.is_HBOIVolunteer') and getSingleObserver.is_HBOIVolunteer eq 1>
                          <li>HBOI Volunteer</li>
                    </cfif>
                    <cfif isdefined('getSingleObserver.is_MRCVolunteer') and getSingleObserver.is_MRCVolunteer eq 1>
                          <li>MRC Volunteer</li>
                    </cfif>
                    <cfif isdefined('getSingleObserver.pmember') and getSingleObserver.pmember eq 0>
                          <li>member of the public</li>
                    </cfif>
                    <cfif isdefined('getSingleObserver.naturalgrapher') and getSingleObserver.naturalgrapher eq 0>
                          <li>nature photographer or naturalist</li>
                    </cfif>
                    
                    
                </ul>
               </span>
           </div>
           <div class="col-sm-3">
               <label for="">Phone Number</label>
               <span>#getSingleObserver.phone#</span>
           </div>
       </div>
        <h3>
            Dolphins Observation Information
        </h3>
        <div class="row mtop20">
            <div class="col-sm-4">
                <label for="">Observation type</label>
                <span>
                    <ul class="detail_list_info">
                        <cfif isdefined('getSingleObserver.livedsight') and getSingleObserver.livedsight eq 1>
                                <li>sighting of live Dolphins(s)</li>
                        </cfif>
                       <cfif isdefined('getSingleObserver.othrtype') and getSingleObserver.othrtype neq ''>
                              <li> <b>Other: </b>#getSingleObserver.othrtype# </li>
                                
                        </cfif>
                    </ul>
                </span>
            </div>
            <div class="col-sm-4">
                <label for="">Total Dolphinss</label>
                <span>
                    <ul class="detail_list_info">
                             <cfif isdefined('getSingleObserver.TOTALDOLPHINS') and getSingleObserver.TOTALDOLPHINS gte 0>
                                     <li> #getSingleObserver.TOTALDOLPHINS#</li>
                             </cfif>
                    </ul>
                </span>
            </div>
            <div class="col-sm-4">
                <label for="">Date</label>
               <cfif isdefined('getSingleObserver.Datetime') and getSingleObserver.datetime neq ''>
                       <span>
                        #dateTimeformat(getuserwatching.DATETIME, "short")#</span>
               </cfif>
            </div>
        </div>
        <br>
       <!--- <h4>Body size</h4>
        <br>
        <div class="row mtop20">
            <div class="col-sm-3">
                <label for="">Dolphins ## 1 </label>
            <cfif isdefined('getSingleObserver.size1') and getSingleObserver.size1 gte 0>
                <span>#getSingleObserver.size1#</span>
            </cfif>
            </div>
            <div class="col-sm-3">
                <label for="">Dolphins ## 2 </label>
                <cfif isdefined('getSingleObserver.size2') and getSingleObserver.size2 gte 0>
                        <span>#getSingleObserver.size2#</span>
                </cfif>
            </div>
            <div class="col-sm-3">
                <label for="">Dolphins ## 3 </label>
                <cfif isdefined('getSingleObserver.size3') and getSingleObserver.size3 gte 0>
                        <span>#getSingleObserver.size3#</span>
                </cfif>
            </div>
            <div class="col-sm-3">
                <label for="">Additional</label>
                <cfif isdefined('getSingleObserver.additionsize') and getSingleObserver.additionsize neq ''>
                    <span>#getSingleObserver.additionsize#</span>
                </cfif>
                </div>
        </div>
        --->
        
        
        
        <div class="row mtop20">
            <div class="col-sm-6">
                <label for="">City and water body</label>
                <cfif isdefined('getSingleObserver.waterbody') and getSingleObserver.waterbody neq ''>
                    <span>#getSingleObserver.waterbody#</span>
                </cfif>
        </div>
            <div class="col-sm-3">
                <label for="">Latitude</label>

        <cfif isdefined('getSingleObserver.Latitude')>
                <span>#getSingleObserver.Latitude#</span>
        </cfif>

            </div>
            <div class="col-sm-3">
                <label for="">Longitude</label>
        <cfif isdefined('getSingleObserver.Longitude')>
                  <span>#getSingleObserver.Longitude#</span>
          </cfif>
            </div>
        </div>
        <div class="row mtop20">
            <div class="col-sm-3">
                <label for="">Address </label>
               <cfif isdefined('getSingleObserver.addresss') and getSingleObserver.addresss neq ''>
                   <span>#getSingleObserver.addresss#</span>
               </cfif>
            </div>
            <div class="col-sm-3">
                <label for="">Sighting Confidence</label>
               <cfif isdefined('getSingleObserver.confidence') and getSingleObserver.confidence neq ''>
                   <span>#getSingleObserver.confidence#</span>
               </cfif>
            </div>
            
            <div class="col-sm-3">
                <label for="">Dolphins behavior</label>
                <span>swimming</span>
            </div>
            <div class="col-sm-3">
                <label for="">more behavior details</label>
                <cfif isdefined('getSingleObserver.behavdetails') and getSingleObserver.behavdetails neq ''>
                    <span>#getSingleObserver.behavdetails#</span>
                </cfif>
         </div>
        </div>
         <div class="row mtop20">
             <div class="col-md-3">
                 <label for="">Source</label>
            <cfif isdefined('getSingleObserver.hearingsource')>
                    <span>#getSingleObserver.hearingsource#</span>
            </cfif>
            </div>
        </div>
        <h3>Photos or Videos</h3>
        <br>
        <div class="row mtop20">
            <div class="row">
                <div class="col-md-12">
						<cfif isdefined('getSingleObserver.image') and getSingleObserver.image neq ''>
                        	<cfif getSingleObserver.is_photos EQ 'Yes'>
                            	<cfset tempp = LISTTOARRAY(getSingleObserver.image , ',')>
                                <cfloop array='#tempp#' index="i">
                                    <div class="col-md-4">
                        			    <img class="myImg" src="#Application.CloudRoot##i#" alt="Dolphin Sight" width="300" height="200">
                                    </div>
                                </cfloop>
                            </cfif>
                            <cfif getSingleObserver.is_videos EQ 'Yes'>
                            	<cfset tempp = LISTTOARRAY(getSingleObserver.image , ',')>
                                <cfloop array='#tempp#' index="i">
                                    <div class="col-md-4">
                                        <video width="400" controls>
                                            <source src="#Application.CloudRoot##i#" width="300" height="200">
                                        </video>
                                    </div>
                                </cfloop>
                                
                            </cfif>
                        <cfelse>
                            <div class="col-md-4">
                                <img src="#application.CloudRoot#no-image.jpg" alt="">
                            </div>
                        </cfif>
                    <!---<div class="col-md-4">--->
                        <!---<img class="myImg" src="/assets/dolphin/2.jpg" alt="Dolphin Sight" width="300" height="200">--->
                    <!---</div>--->
                    <!---<div class="col-md-4">--->
                        <!---<img class="myImg" src="/assets/dolphin/3.jpg" alt="Dolphin Sight" width="300" height="200">--->
                    <!---</div>--->
                </div>
            </div>
            <!-- The Modal -->
            <div id="myModal" class="modal" style="display: none;">

                <!-- The Close Button -->
                <span class="close" onclick="document.getElementById('myModal').style.display='none'">×</span>

                <!-- Modal Content (The Image) -->
                <img class="modal-content" id="img01" src="http://dev.wildfins.org/assets/dolphin/1.jpg">

                <!-- Modal Caption (Image Text) -->
                <div id="caption">Dolphin Sight</div>
            </div>
        </div>
        <div class="row mtop20">
            <div class="col-sm-4">
                <label for="">Photo / Video Release</label>
                <cfif isdefined('getSingleObserver.autmedia') and getSingleObserver.authmedia>
                           <span>#getSingleObserver.authmedia#</span>
                </cfif>
            </div>
            <div class="col-sm-4">

             </div>
        </div>
    </div>
</cfif>
</div>
 </cfoutput>
    <!-- end col-md-12-->

</div>
    <!-- end panel -->
</div>
    <!-- end row col-6 -->

</div>
    <!-- end row -->

    <!-- begin ##footer -->
<div id="footer" class="footer">
    <span class="pull-right">
                    <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top">
                        <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                    </a>
                </span>
    &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
</div>
    <!-- end ##footer -->
</div>
    <!-- end ##content -->
