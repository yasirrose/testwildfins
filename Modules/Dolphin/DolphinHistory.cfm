<cfparam name='qgetdolphin.NAME' default =''>
<cfparam name='qgetdolphin.DOB' default =''>
<cfparam name='qgetdolphin.DOD' default =''>
<cfparam name='qgetdolphin.recordcount' default =''>
<cfparam name='qgetdolphin.MOTHERS' default =''>
<cfparam name='qgetdolphin.GRANDMOTHER' default =''>
<cfparam name='qgetdolphin.BIOPSY_NO' default =''>
<cfparam name='qgetdolphin.SEX' default =''>
<cfparam name='qgetdolphin.YearOfBirth' default =''>
<cfparam name='qgetdolphin.First_Sighting_Date' default =''>
<cfparam name='qgetdolphin.DistinctDate' default =''>
<cfparam name='arr' default =''>

<cfset  Fin  = '#Application.CloudRoot#no-image.jpg'>   
<cfif isdefined('FORM.DOLPHINID')>
  <cfset qgetdolphin 		 = Application.Dolphin.getdolphin(argumentCollection="#Form#")>
  <cfset qgetcalfs           = Application.Dolphin.getCalfs(qgetdolphin.code)>
  <cfset qgetSightingHistory = Application.Dolphin.getSightingHistory(argumentCollection="#Form#")>
<cfif qgetdolphin.ImageName NEQ '' and FileExists('#Application.CloudRoot##qgetdolphin.ImageName#')>
	<cfset  Fin = '#Application.CloudRoot##qgetdolphin.ImageName#'>
<cfelse>
    <cfloop query='qgetdolphin'>
		<cfif qgetdolphin.DATESEEN NEQ ''>
            <cfif DAY(DATESEEN) lt 10 >
                <cfset dayy = '0#DAY(DATESEEN)#'>
            <cfelse>
                <cfset dayy  = DAY(DATESEEN)>  
            </cfif>
            
            <cfif MONTH(DATESEEN) lt 10 >
                <cfset monthh = '0#MONTH(DATESEEN)#'>
            <cfelse>
                <cfset monthh  = MONTH(DATESEEN)>  
            </cfif>
            
           <!--- <cfoutput>#dayy#</cfoutput>--->
            <cfset Fin_Left = '#qgetdolphin.Code#(L) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
            <cfset Fin_Right = '#qgetdolphin.Code#(R) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
        <!---    <cfoutput>#Application.CloudDirectory##Fin_Left#</cfoutput> <br>
            <cfoutput>#Application.CloudDirectory##Fin_Right#</cfoutput>--->
            
            <cfif FileExists('#Application.CloudDirectory##Fin_Left#')>
                <cfset  Fin = '#Application.CloudRoot##Fin_Left#'>
                <cfbreak>
            <cfelseif FileExists('#Application.CloudDirectory##Fin_Right#')>
                <cfset  Fin  = '#Application.CloudRoot##Fin_Right#'>
                <cfbreak>
            </cfif>	
         </cfif>                       
    </cfloop>
</cfif>


  <!--- create array --->
<cfset Arr = ArrayNew(1)>
<cfset segments   = ["1A","1B","1C","2","3","4"]>
<cfset segmentVal = ArrayNew(1)>
<cfset segment_1A = 0>
<cfset segment_1B = 0>
<cfset segment_1C = 0>
<cfset segment_2  = 0>
<cfset segment_3  = 0>
<cfset segment_4  = 0>
<cfset home_range = 0>
<!--- loop through query --->
<cfloop query="qgetdolphin">
	<cfset structofdolphin = StructNew() />
	<cfset structofdolphin["Easting_X"] = qgetdolphin.Easting_X>
	<cfset structofdolphin["Northing_Y"] = qgetdolphin.Northing_Y>
	<cfset structofdolphin["Begin_LAT_Dec"] = qgetdolphin.Begin_LAT_Dec>
	<cfset structofdolphin["Begin_LON_Dec"] = qgetdolphin.Begin_LON_Dec>
    <cfset structofdolphin["SightingNo"] = qgetdolphin.SightingNo>
    <cfset structofdolphin["DateSeen"] = qgetdolphin.DateSeen>
	<cfset ArrayAppend(Arr,structofdolphin)>
    
    <cfif ZSEGMENT EQ "1A">
        <cfset segment_1A ++>
    </cfif>
    <cfif ZSEGMENT EQ "1B">
        <cfset segment_1B ++>
    </cfif>
    <cfif ZSEGMENT EQ "1C">
        <cfset segment_1C ++>
    </cfif>
    <cfif ZSEGMENT EQ "2">
        <cfset segment_2 ++>
    </cfif>
    <cfif ZSEGMENT EQ "3">
        <cfset segment_3 ++>
    </cfif>
    <cfif ZSEGMENT EQ "4">
        <cfset segment_4 ++>
    </cfif>
</cfloop>

<cfif qgetdolphin.recordcount GT 0>
 <cfloop array="#segments#" index="i">
	<cfset "segment_#i#" = NumberFormat((evaluate('segment_#i#')/qgetdolphin.recordcount)*100,'0')>
    <cfset ArrayAppend(segmentVal,evaluate('segment_#i#'))>
    <cfif evaluate('segment_#i#') GT 50>
    	<cfset home_range = '<span class="segment_#i#">#i#</span>'>
        
    </cfif>
 </cfloop>
 <cfif home_range eq 0>
    <cfset isbreak = false >
    <cfloop from="1" to="#arrayLen(segmentVal)#" index="i">
        <cfloop from="1" to="5" index="j">
            <cfset currentSegment  = segmentVal[i]>
            <cfif ArrayIsDefined(segmentVal,i+j)>
                <cfset k = i+j>
            <cfelse>
                <cfset k = (i+j)-6>
            </cfif>
            <cfset comparedSegment = segmentVal[k]>
            <cfif (currentSegment + comparedSegment) GT 75>
                <cfset home_range = '<span class="segment_#segments[i]#">#segments[i]#</span><span class="seperator"> - </span><span class="segment_#segments[k]# right_segment">#segments[k]#</span>'>
                <cfset isbreak = true >
                <cfbreak>
            </cfif>
            <cfif isbreak>
                <cfbreak>
            </cfif>                
        </cfloop>
    </cfloop>
 </cfif>
</cfif>

<!---SerializeJSON --->
<cfset Arr = SerializeJSON(Arr)>
   
  <cfset SightingNo = ValueList(qgetdolphin.SightingNo,",")>
  <cfset code = qgetdolphin.Code>
  <cfif SightingNo NEQ ''>
  	<cfset qgetdolphinFriends = Application.Dolphin.getdolphinFriends(#SightingNo#,#code#)>
  </cfif>

</cfif>
<cfset getDolphinsCode = Application.Sighting.getDolphinsCode()>
<cfparam name="FORM.DolphinID_fetch" default="">

<cfoutput>
<script>
var obj = [] ;
arr = '<cfoutput>#Arr#</cfoutput>';
if (arr != '') {
 obj = JSON.parse(arr);
 }
</script>

  <div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">#URL.Module#</a></li>
      <li><a href="javascript:;" class="active">#URL.Page#</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Dolphin History</h1>

    <!-- end page-header -->
    <div class="section-container section-with-top-border p-b-10">
      <!-- begin row -->
      <div class="panel main-form-section p-t-10">
      <div class="row">
          <cfif isdefined('qinsertDolphin') and qinsertDolphin.recordcount eq 1 >
            <div class="alert alert-success fade in m-b-10" id="sucess-div">
                <strong>Successfully Inserted!</strong>
                <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
            </div>
        </cfif>
          <div  class="pull-right col-lg-12" style="margin-bottom:10px">
            <div class="col-lg-7 col-md-12">
			<div class='row'>
                <div class="col-md-5">
                    <form id="myform" action="#Application.siteroot#?Module=Dolphin&Page=DolphinHistory" method="post" >
                        <label for="sel1">Select Dolphin</label>
                        <select class="form-control search-box" required id="dolphin_dscore" name="DOLPHINID" onchange="this.form.submit()" >
                          <option value="">Select Dolphin</option>
                          <cfloop query="getDolphinsCode">
                            <option value="#getDolphinsCode.id#" <cfif isdefined('FORM.DOLPHINID') and FORM.DOLPHINID eq getDolphinsCode.id>selected</cfif>> #getDolphinsCode.Name# | #getDolphinsCode.code#</option>
                          </cfloop>
                        </select>
                    </form>
                </div>
                <div class="col-md-2 col-md-offset-1 m-t-25">
                    <form id="detailform" action="#Application.siteroot#?Module=Dolphin&Page=EditDolphin" method="post" >
                        <input type= 'hidden' name='id'  value='' id=dolphin_id>
                        <button  class="btn btn-primary pull-right" onclick='return sendForm()'>View Details</button>
                    </form>
                </div>
                <div class="col-md-4"> 
                    <a href="##" id="image">
                    <img src='#Fin#' width="200" height="200" id="imageresource"/>
                    </a>
                </div>
                <cfif isdefined("home_range") and home_range NEQ 0>
                    <div class="home_range"> 
                        <label>Home Range : </label>#home_range#
                    </div>
                </cfif>
            </div>
        
              <div class="">
               <div class="row">
               <div class="col-lg-4">
                  <div class="form-group">
                    <label for="email">Dolphin Name:</label>
                    <input type="text" class="form-control" name="DolphinName" id="dolphin_name"  readonly="readonly" value='#qgetdolphin.NAME#'>
                  </div>
                  </div>
                  </div>
                 <div class="row">
               <div class="col-lg-4">
                  <div class="form-group">
                    <label for="email">DOB:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="DOB"  readonly="readonly" value="#qgetdolphin.DOB#" >
                  </div>
                 </div>
                 <div class="col-lg-4">
                  <div class="form-group">
                    <label for="email">DOD:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="DOD"  readonly="readonly"  value="#DateFormat(qgetdolphin.DOD,'mm/dd/yyyy')#">
                  </div>
                </div>
                 <div class="col-lg-2">
                  <div class="form-group">
                    <label for="email">Total Sightings</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="total_sightings"  readonly="readonly" value='#qgetdolphin.recordcount#'>
                  </div>
                </div>
                 <div class="col-lg-2">
                  <div class="form-group">
                    <label for="email">Sex</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="total_sightings"  readonly="readonly" value='#qgetdolphin.SEX#'>
                  </div>
                </div>
                </div>
                
                <div class="row">
               <div class="col-lg-4">
                  <div class="form-group">
                    <label for="email">Year of Birth:</label>
                    <input type="text" class="form-control" readonly="readonly" value="#qgetdolphin.YearOfBirth#" >
                  </div>
                 </div>
                 <div class="col-lg-4">
                  <div class="form-group">
                    <label for="email">Distinct Date :</label>
                    <input type="text" class="form-control"   readonly="readonly"  value="#DateFormat(qgetdolphin.DistinctDate,'mm/dd/yyyy')#">
                  </div>
                </div>
                 <div class="col-lg-4">
                  <div class="form-group">
                    <label for="email">First Sighting Date :</label>
                    <input type="text" class="form-control" id="total_sightings"  readonly="readonly" value="#DateFormat(qgetdolphin.First_Sighting_Date,'mm/dd/yyyy')#">
                  </div>
                </div>
                </div>

              </div>
              <br>
              <div class="row dolphin-history-table">
              <div class="col-md-8" >
				    <div class="dataTables_scroll">
				      <div class="dataTables_scrollHead" >
				        <div class="dataTables_scrollHeadInner" >
				          <table class="table table-striped table-bordered dataTable no-footer" role="grid">
				            <thead>
				              <tr role="row">
				                <th  rowspan="1" colspan="1" >Date Seen</th>
                                <th  rowspan="1" colspan="1" >Project ID</th>
                                <th  rowspan="1" colspan="1" >Sighting ID</th>
				              </tr>
				            </thead>
				          </table>
				        </div>
				      </div>
				      <div class="dataTables_scrollBody" style="position: relative; overflow: auto; max-height: 200px; width: 100%;">
				        <table class="table table-striped table-bordered dataTable no-footer dtr-inline" >
				          <tbody id="DateSeen">
						<cfif isdefined('FORM.DOLPHINID')>	
							<cfloop query='qgetdolphin'>
								<tr role="row" class="odd">
									<td class="sorting_1">#DateFormat(DATESEEN,'mm/dd/yyyy')#</td>
                                    <td class="sorting_1">#PROJECT_ID#</td>
                                    <td class="sorting_1">#SIGHTINGNO#</td>
								</tr>
							</cfloop>	
						</cfif>		
				          </tbody>
				        </table>
				        <!--<div style="position: relative; top: 0px; left: 0px; width: 1px; height: 100000px;"></div>-->
				      </div>
				    </div>
				</div>
               <div class="col-md-4">
                   <div class="dataTables_scroll">
                          <div class="dataTables_scrollHead" >
                            <div class="dataTables_scrollHeadInner" >
                              <table class="table table-striped table-bordered dataTable no-footer" role="grid" >
                                <thead>
                                  <tr role="row">
                                    <th >Calves</th>
                                    <th >DOB</th>
                                  </tr>
                                </thead>
                              </table>
                            </div>
                          </div>
                          <div class="dataTables_scrollBody" style="position: relative; overflow: auto; max-height: 200px; width: 100%;">
                            <table class="table table-striped table-bordered dataTable no-footer dtr-inline" >
                              <tbody >
                            <cfif isdefined('FORM.DOLPHINID')>
                                <cfloop query='qgetcalfs'>
                                    <tr role="row" class="odd">
                                        <td class="sorting_1">#Code#</td>
                                        <td class="sorting_1">#Expr1#</td>
                                    </tr>
                                </cfloop>	
                            </cfif>		
                              </tbody>
                            </table>
                            <div style="position: relative; top: 0px; left: 0px; width: 1px; height: 100000px;"></div>
                          </div>
                        </div>
                </div>
                <div class="col-md-12">
                   <div class="dataTables_scroll">
                          <div class="dataTables_scrollHead" style="overflow: hidden; position: relative; border: 0px none; width: 100%;">
                            <div class="dataTables_scrollHeadInner" style="box-sizing: content-box; width: 100%;">
                              <table class="table table-striped table-bordered dataTable no-footer ">
                                <thead>
                                  <tr>
                                    <th style='width:28%'>Friends</th>
                                    <th style='width:21%'>Sex</th>
                                     <th style='width:25%'>Times</th>
                                     <th style='width:25%'>Action</th>
                                  </tr>
                                </thead>
                              </table>
                            </div>
                          </div>
                          <div class="dataTables_scrollBody" style="position: relative; overflow: auto; max-height: 200px; width: 100%;">
                            <table class="table table-striped table-bordered dataTable no-footer ">
                              <tbody id='dolphin_friends'>
                              
                              <cfif isdefined('FORM.DOLPHINID') and isdefined("qgetdolphinFriends")>	
                                <cfloop query='qgetdolphinFriends'>
                                     <tr >
                                         <td style='width:25%'>#qgetdolphinFriends.Dolphin_Name#</td>
                                         <td style='width:25%'>#qgetdolphinFriends.Sex#</td>
                                          <td style='width:25%'>#qgetdolphinFriends.times#</td>
                                           <td style='width:25%' align="center">
                                            <form  action="#Application.siteroot#?Module=Dolphin&Page=DolphinHistory" method="post" >
                                            <input type= 'hidden' name='DOLPHINID'  value='#qgetdolphinFriends.ID#' id=dolphin_id>
                                            <button  class="btn btn-primary">View</button>
                                            </form>
                                           </td>
                                     </tr>
                                </cfloop>	
                            </cfif>		
                              
                             
    
                              </tbody>
                            </table>
                           <!-- <div style="position: relative; top: 0px; left: 0px; width: 1px; height: 100000px;"></div>-->
                          </div>
                        </div>
              	</div>
                <div class="col-md-12">
                   <div class="dataTables_scroll">
                          <div class="dataTables_scrollHead" style="overflow: hidden; position: relative; border: 0px none; width: 100%;">
                            <div class="dataTables_scrollHeadInner" style="box-sizing: content-box; width: 100%;">
                              <table class="table table-striped table-bordered dataTable no-footer ">
                                <thead>
                                  <tr>
                                    <th style='width:28%'>Date</th>
                                    <th style='width:21%'>Body Condition</th>
                                     <th style='width:25%'>Region</th>
                                     <th style='width:25%'>Area</th>
                                  </tr>
                                </thead>
                              </table>
                            </div>
                          </div>
                          <div class="dataTables_scrollBody" style="position: relative; overflow: auto; max-height: 200px; width: 100%;">
                            <table class="table table-striped table-bordered dataTable no-footer ">
                              <tbody id='dolphin_sighting_history'>
                              
                              <cfif isdefined('FORM.DOLPHINID') and isdefined("qgetSightingHistory")>	
                                <cfloop query='qgetSightingHistory'>
                                     <tr >
                                         <td style='width:28%'>#DateFormat(Dolphin_Sighting_Date,'mm/dd/yyyy')#</td>
                                         <td style='width:21%'>#BodyCondition#</td>
                                         <td style='width:25%'>#Region#</td>
                                         <td style='width:25%'>#Area#</td>
                                     </tr>
                                </cfloop>	
                            </cfif>		
                              
                             
    
                              </tbody>
                            </table>
                            <!--<div style="position: relative; top: 0px; left: 0px; width: 1px; height: 100000px;"></div>-->
                          </div>
                        </div>
              	</div>
              </div>
              
              <!--- <div class="form-group">
                    <label for="email">Mother:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="Mother"  readonly="readonly"  value='#qgetdolphin.Mothers#'>
               </div>
                 <div class="form-group">
                    <label for="email">Grandmother:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="Grandmother"  readonly="readonly"  value='#qgetdolphin.GRANDMOTHER#'>
               </div>
                 <div class="form-group">
                    <label for="email">Great Grandmother:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="GreatGrandmother"  readonly="readonly">
               </div>
               <div class="form-group">
                    <label for="email">HERA:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="HERA"  readonly="readonly">
               </div>
               <div class="form-group">
                    <label for="email">BIOPSY:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="BIOPSY"  readonly="readonly"  value='#qgetdolphin.BIOPSY_NO#'>
               </div>--->


            </div>
            <div class="col-lg-5 col-md-12" id="dolphin-map">
              <h5 class="m-t-0">Sightings</h5>
                   <div id="google-map-cobalt" class="height-sm"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
</cfoutput>

<!-- Creates the bootstrap modal where the image will appear -->
<div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:48%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Fin preview</h4>
      </div>
      <div class="modal-body">
        <img src="" id="imagepreview" style="width: auto; height: auto;" >
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>






