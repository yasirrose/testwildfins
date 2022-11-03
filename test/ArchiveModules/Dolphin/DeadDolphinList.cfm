<cfparam name="startHereIndex" default="1">
<cfparam name="form.deadid" default="">
<cfif isdefined('form.search') and len(trim(form.ID)) GT 0 >
    <cfset GetDolphin = Application.Dolphin.getDeadDolphinDetail(argumentCollection="#Form#")>
</cfif>

<cfif isdefined('form.update_dead_dolphin')>
    <cfset updateDolphin = Application.Dolphin.updateDeadDolphin(argumentCollection="#Form#")>
    <cfif updateDolphin.recordcount GT 0>
        <cfset message = 1>
    </cfif>
</cfif>
<cfset getYOBSource=Application.Dolphin.get_YOB_Source()>
<cfset getcatalog=Application.Dolphin.getCatalog()>
<cfset getSourceSex = Application.Dolphin.getSourceSex()>
<cfset getDeadDolphins = Application.Dolphin.getDeadDolphinList()>
<cfset getDscoreCode = Application.Dolphin.getDscoreDropdown()>
<cfif isdefined('form.update_dead_dolphin') and len(trim(form.ID)) GT 0 >
    <cfset GetDolphin = Application.Dolphin.getDeadDolphinDetail(argumentCollection="#Form#")>
</cfif>



<!-- begin #content -->
<div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Home</a></li>
        <li><a href="javascript:;">Dolphin List</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">MMHSRP</h1>
    <!-- begin section-container -->
<div class="section-container section-with-top-border">
<div class="row col-md-12">
<form role="form" method="post" action="" class="form-inline" id="deadDolphinSearch">
<div class="form-group">
<select class="form-control search-box" required name="ID" >
    <option value="">Select Dolphin</option>
<cfoutput query="getDeadDolphins">
        <option value="#getDeadDolphins.id#" <cfif isdefined('FORM.ID') and FORM.ID eq getDeadDolphins.id>selected</cfif>> #getDeadDolphins.Name# | #getDeadDolphins.code#</option>
</cfoutput>
</select>
</div>
    <div class="form-group">
        <input type="submit" class="btn btn-success" name="search" value="Submit">
    </div>
</form>
</div>



    <div style="float:right"></div>
    <!-- begin panel -->
    <div class="clearfix m-b-10"></div>

<cfif isdefined('message') and message eq 1>
        <div class="form-group">
            <div class="alert alert-success message">
                <strong>Success!</strong> Dolphin Updated successfully.
            </div>
        </div>
</cfif>
<cfif isdefined('form.ID') >
    <div class="panel pagination-inverse m-b-0 clearfix">
    <div class="col-md-12"  style="padding-top:10px;">



<!---<cfif isdefined('form.ID')> --->
    <div  class="row col-lg-12">
    <div class="col-lg-12">
    <span class="pull-right">
        <label style="font-weight: 600;" for="ProjectID">Project   ID: </label> <cfoutput>#GetDolphin.PROJECT_ID# </cfoutput>
        <label style="font-weight: 600;" for="SgightingID">Sighting ID:</label><cfoutput> #GetDolphin.SIGHTING_ID#</cfoutput>
        <label style="font-weight: 600;"  for="ProjectID">Sighting Number: </label> <cfoutput>#GetDolphin.SightingNumber# </cfoutput>
        <label  style="font-weight: 600;" for="ProjectID">Sighting Date: </label> <cfoutput>  #DateFormat(GetDolphin.Last_Sighting_date , "yyyy-mm-dd")#</cfoutput>
    </span>
    </div>
    </div>
        <br>
<!--- </cfif>--->







    <cfoutput>
            <form role="form" action="" method="post">
                    <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                <input type="hidden" value="#GetDolphin.ID#" name="ID">
        <div class="form-group">
            <label style="margin-top:15px;" for="dead">Dead?:</label>
                <input type="checkbox"
                       name="dead" id="dead" <cfif GetDolphin.dead eq 1>checked="checked" disabled</cfif>>
        </div>
        <div class="form-group">
            <label for="email">Water Body:</label>
                <input type="text" class="form-control" value="#GetDolphin.waterBody#" name="waterBody" placeholder="year">
        </div>
        <div class="form-group">
            <label for="email">Field Id:</label>
                <input type="text" class="form-control" value="#GetDolphin.FiledID#" name="Field_ID">
        </div>

        <div class="form-group">
            <label for="email">Year Of Death:</label>
            <cfset Date = DateFormat(GetDolphin.deathDeate, "yyyy") >
            <input type="text" class="form-control getYear" value="#Date#" name="Year">
        </div>

        <div class="form-group">
            <label for="email">Body condition Code:</label>
                <input type="text" class="form-control" value="#GetDolphin.bodyConditionCode#" name="bodyConditionCode">
        </div>
        <div class="form-group">
            <label for="email">Code:</label>
                <input type="text" class="form-control" value="#GetDolphin.Code#" name="Code">
        </div>
        <div class="form-group">
            <label for="email">FB No:</label>
                <input type="text" class="form-control" value="#GetDolphin.FB_No#" name="FB_No">
        </div>
        <div class="form-group">
            <label for="email">Sex:</label>
        <select class="form-control" name="sex" id="gensex">
            <option value="">Select sex</option>
                <option value="F" <cfif GetDolphin.Sex eq "F">selected</cfif>>F</option>
                <option value="M" <cfif GetDolphin.Sex eq "M">selected</cfif>>M</option>
        </select>
        </div>
        <div class="form-group">
            <label for="email">Source Sex:</label>
        <select class="form-control" name="sourcesex" >
<!---<cfloop query="getSourceSex">--->
<!---<option value="#getSourceSex.Ssex#"> #getSourceSex.Ssex#</option>--->
<!---</cfloop>--->
            <option value="#GetDolphin.ssexed#">#GetDolphin.ssexed#</option>

        </select>
        </div>

        <div class="form-group">
            <label for="email">Source YOB:</label>
        <div class="input-group">
        <div class="input-group-btn">
            <button class="btn btn-inverse" type="button">Source YOB</button>
            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                <span class="caret"></span> </button>
        <ul class="dropdown-menu">

            <cfloop query="getYOBSource">
                    <li><a  class="Source_YOB" value="#getYOBSource.ID#">#getYOBSource.YOBSource#</a></li>
            </cfloop>
            </ul>
            </div>
            <cfset empty = 0>
            <cfloop query="getYOBSource">
                <cfif getYOBSource.ID eq GetDolphin.SourceYOB>
                    <cfset empty = 1>
                        <input type="text" id="Source_YOB" class="form-control" value="#getYOBSource.YOBSource#" name="Source_YOB">
                </cfif>
            </cfloop>
            <cfif empty eq 0>
                    <input type="text" id="Source_YOB" class="form-control" name="Source_YOB">
            </cfif>
                <input type="hidden" id="Source_YOB_ID" class="form-control"  name="Source_YOB_ID" >
            </div>


            </div>


<!-------left end------->
            </div>

                    <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
<!-------Middel strt------->
            <div class="form-group">
                <label for="email">Dscore:</label>
            <select class="form-control" name="Dscore">
                    <option value="#GetDolphin.DScore#" selected>#GetDolphin.score#</option>
            <cfloop query="getDscoreCode">
                    <option value="#getDscoreCode.Dscore#">#getDscoreCode.Dscore#</option>
            </cfloop>
            </select>

            </div>

            <div class="form-group">
                <label for="email">Year Of Birth:</label>
                    <input type="text" class="form-control getYearBirth" value="#GetDolphin.YearOfBirth#" name="YearOfBirth" placeholder="year">
        </div>


        <div class="form-group">
            <cfset deadDate = DateFormat(GetDolphin.deathDeate, "yyyy") >

            <cfset dethAge = val(deadDate) - val(GetDolphin.YearOfBirth) >
                <label for="email">Age at death:</label>
                    <input type="text" class="form-control ageOfDead" value="#dethAge#" name="ageAtDeath">
        </div>

        <div class="form-group">
            <label for="email">Dorsal decomposed or scavenged:</label>
        <select class="form-control"  name="dorsalDecomposed" >
                <option value="1" <cfif GetDolphin.dorsalDecomposed eq 1>selected</cfif>>Yes</option>
                <option value="0" <cfif GetDolphin.dorsalDecomposed eq 0>selected</cfif>>No</option>
        </select>
        </div>
        <div class="form-group">
            <label for="email">Poor quality photo or No photo:</label>
        <select class="form-control"  name="poorQualityPhoto" >
                <option value="1" <cfif GetDolphin.poorQualityPhoto eq 1>selected</cfif>>Yes</option>
                <option value="0" <cfif GetDolphin.poorQualityPhoto eq 0>selected</cfif>>No</option>
        </select>
        </div>
        <div class="form-group">
            <label for="email">Typo:</label>
        <select class="form-control"  name="Unrecoveredo" >
                <option value="1" <cfif GetDolphin.Unrecoveredo eq 1>selected</cfif>>Yes</option>
                <option value="0" <cfif GetDolphin.Unrecoveredo eq 0>selected</cfif>>No</option>
        </select>
        </div>
        <div class="form-group">
            <label for="email">Mom pushing dead calf:</label>
        <select class="form-control"  name="momPushingDeadCalf" >
                <option value="1" <cfif GetDolphin.momPushingDeadCalf eq 1>selected</cfif>>Yes</option>
                <option value="0" <cfif GetDolphin.momPushingDeadCalf eq 0>selected</cfif>>No</option>
        </select>
        </div>
        <div class="form-group">
            <label for="email">Dead dorsal photo on file:</label>
        <select class="form-control"  name="deadDorsalPhoto" >
                <option value="1" <cfif GetDolphin.deadDorsalPhoto eq 1>selected</cfif>>Yes</option>
                <option value="0" <cfif GetDolphin.deadDorsalPhoto eq 0>selected</cfif>>No</option>
        </select>
        </div>

<!-------- middl end----------------->

            </div>



<!-------- Right Side----------------->
            <div class="col-md-4">




            <div class="form-group">
                <label for="email">Body length (cm):</label>
                    <input type="text" class="form-control" id="body_length"  value="#GetDolphin.bodyLenght#" name="bodyLenght">
        </div>
            <cfparam name="agsex" default="">
            <div class="form-group">

            <cfif GetDolphin.Sex eq "F" AND GetDolphin.bodyLenght gte 231>
                <cfset agsex ="Adult">
                <cfelseif  GetDolphin.Sex eq "F" AND GetDolphin.bodyLenght eq 161 AND GetDolphin.bodyLenght lte  230>
                <cfset agsex="Juvenile">
                <cfelseif GetDolphin.Sex eq "F" AND GetDolphin.bodyLenght lt 161>
                <cfset agsex="Calf">
                <cfelseif GetDolphin.Sex eq "M" AND GetDolphin.bodyLenght gte 246>
                <cfset agsex="Adult">
                <cfelseif  GetDolphin.Sex eq "M" AND GetDolphin.bodyLenght eq 161 AND GetDolphin.bodyLenght lte 245>
                <cfset agsex="Juvenile">
            </cfif>


                <label for="email">Age cohort (Adult, Juvenile, Calf):</label>
                    <input type="text" class="form-control" value="#agsex#" name="ageCohort" id="agCohort">
        </div>

        <div class="form-group">
            <label for="email">Other accession numbers:</label>
                <input type="text" class="form-control" value="#GetDolphin.otherAccessionNumbers#" name="otherAccessionNumbers">
        </div>


        <div class="form-group">
            <label for="email">Photo type:</label>
                <input type="text" class="form-control" value="#GetDolphin.photoType#" name="photoType">
        </div>
        <div class="form-group">
            <label for="email">IRL segment -AUTOMATED WITH GPS:</label>
                <input type="text" class="form-control" value="#GetDolphin.irlSegment#" name="irlSegment">
        </div>
        <div class="form-group">
            <label for="email">UTM Easting (X) coordinates:</label>
                <input type="text" class="form-control" value="#GetDolphin.utmEsting#" name="utmEsting">
        </div>
        <div class="form-group">
            <label for="email">UTM Northing (Y) coordinates:</label>
                <input type="text" class="form-control" value="#GetDolphin.utmNorting#" name="utmNorting">
        </div>
        <div class="form-group">
            <label for="email">Details:</label>
        <textarea class="form-control" name="Details">#GetDolphin.Details#</textarea>
        </div>


<!-------- newdolhpin right side end------>
            </div>


                <div class="col-md-12">
                    <div class="message">
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-success" name="update_dead_dolphin" >Add Dolphin</button>
                        <input type="reset" class="btn btn-defualt reset" />
                    </div>
                </div>

            </form>
    </cfoutput>
    </div>
    </div>
        <!-- end panel -->
<cfelse>

</cfif>
</div>
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
