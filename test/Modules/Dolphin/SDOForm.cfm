<cfparam name="message" default="">
<cfif isdefined('form.addsdo') >
<cfset insertsdo = Application.Dolphin.add_SDOdolphin(argumentCollection="#Form#")>
<cfif insertsdo.RECORDCOUNT EQ 1>
<cfset message=" SDO Inserted">
</cfif>
</cfif>
<cfset getDolphinsCode = Application.Sighting.getDolphinsCode()>		
        <div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">SDO </li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">SDO Form </h1>
			<!-- end page-header -->
			<div class="section-container section-with-top-border p-b-10">
			<div class="row  p-t-10">
                    <!-- begin col-6 -->
            <div class="col-md-12">
            
			<cfoutput>
            <cfif len(trim(message)) GT 0>
            <div class="alert alert-success">
              <strong>Success!</strong> #message#.
            </div>

			</cfif>
			 <form role="form" method="post" id="sdoform">	 
			<div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                    
               <div class="form-group">      
               <label for="sel1">Select Dolphin</label>
                <select class="form-control search-box" required name="DOLPHINID" >
                  <option value="">Select Dolphin</option>
                  <cfloop query="getDolphinsCode">
                    <option value="#getDolphinsCode.id#" <cfif isdefined('FORM.DolphinID_fetch') and FORM.DolphinID_fetch eq getDolphinsCode.id>selected</cfif>> #getDolphinsCode.Name# | #getDolphinsCode.code#</option>
                  </cfloop>
                </select>
                 </div>   
                    
                <div class="form-group">
                 <label for="email">PRES LOBO DATE:</label>
                <input type="text" class="form-control datepicker-sdo" name="PRES_LOBO_DATE" placeholder="YYYY-MM-DD" required >
                </div>
                
                <div class="form-group">
                <label for="email">Lobo Confirmed:</label>
                <input type="text" class="form-control " name="Lobo_Confirmed" required >
                </div>
                
                 <div class="form-group">
                        <label for="email">Recapture Date 1:</label>
                        <input type="text" class="form-control datepicker-sdo" name="Recapture_Date_1" placeholder="YYYY-MM-DD" required >
                 </div>
                 
				<div class="form-group">
					<label for="email">Recapture Date 2:</label>
					<input type="text" class="form-control datepicker-sdo" name="Recapture_Date_2" placeholder="YYYY-MM-DD" required >
                </div>
                
                <div class="form-group">
                        <label for="email">Recapture Date 3:</label>
                        <input type="text" class="form-control datepicker-sdo" name="Recapture_Date_3" placeholder="YYYY-MM-DD" required ></div>
    
                
                
              </div>
              <!-------- Leftside end----->
              	
                
               <!-------- LeftSide----->
            <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                
                    <div class="form-group">
                    <label for="email">HERA Error:</label>
                    <input type="text" class="form-control" name="HERAError" required maxlength="10" >
                    </div>
            
                   <div class="form-group">
                    <label for="email">Fin Change 1:</label>
                    <input type="text" class="form-control datepicker-sdo" name="FinChange1" required >
                    </div>
                    
                    <div class="form-group">
                    <label for="email">Fin Change 2:</label>
                    <input type="text" class="form-control datepicker-sdo" name="FinChange2" required >
                    </div>
                    <div class="form-group">
                    <label for="email">Fin Change 3:</label>
                    <input type="text" class="form-control datepicker-sdo" name="FinChange3" required >
                    </div>
                   
                    <div class="form-group">
                    <label for="email">Fin Change 4:</label>
                    <input type="text" class="form-control " name="FinChange4" required >
                    </div>
                    
                    
                   <div class="form-group">
                    <label for="email">FB on Date:</label>
                    <input type="text" class="form-control datepicker-sdo" name="FB_on_Date" placeholder="YYYY-MM-DD" required >
                   </div>
                    
                
             </div>
                
              <!-------- RightSide----->
              <div class="col-md-4">
              
                       
                     <div class="form-group">
                        <div class="input-group">
                          <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">FB Side</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false"> <span class="caret"></span> </button>
                            <ul class="dropdown-menu">
                                <li><a  class="FB_Side" value="Left">Left</a></li>
                                <li><a class="FB_Side" value="Right">Right</a></li>
                                <li><a  class="FB_Side" value="Both">Both</a></li>
                                <li><a  class="FB_Side" value="None">None</a></li>
                            </ul>
                          </div>
                          <input type="text" id="FB_Side" class="form-control"  name="FB_Side" required>
                        </div>
                      </div>
                       
                      <div class="form-group">
                          <input type="checkbox" class="checkbox-inline"  name="Dead" value="1"  >
                          <label for="email">Dead?</label>
                     </div>
                          
                      <div class="form-group">
                        <input type="checkbox" class="checkbox-inline"  name="Distinct" value="1"  >
                        <label for="email">Distict</label>
                      </div>
                      
                        <div class="form-group">
                            <input type="checkbox" class="checkbox-inline" name="PRES_LOBO"  value="1" >
                            <label for="email">PRES LOBO</label>
                        </div>
        
                        <div class="form-group">
                            <input type="checkbox" class="checkbox-inline" name="HERARescueFinChange1" value="1">
                            <label for="email">HERA/Rescue Fin Change 1</label>
                        </div>
                        
                        <div class="form-group">
                            <input type="checkbox" class="checkbox-inline" name="HERARescueFinChange2" value="1">
                            <label for="email">HERA/Rescue Fin Change 2</label>
                        </div>
                        
                         <div class="form-group">
                            <input type="checkbox" class="checkbox-inline" name="HERARescueFinChange3" value="1">
                            <label for="email">HERA/Rescue Fin Change 3</label>
                        </div>
                        
                        <div class="form-group">
                            <input type="checkbox" class="checkbox-inline" name="HERARescue" value="1">
                            <label for="email" >HERA/Rescue</label>
                        </div>
                      
               </div>
                 
               <div class="col-md-12 m-10">
                 <input type="submit" class="btn btn-success" name="addsdo" value="Add SDO">
               </div>   
                 
                </form>
                </cfoutput>  
			</div>
        
         </div>
         </div>
