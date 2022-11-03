
<!--- <cfdump var= "#session["userdetails"]#" abort="true"> --->
<cfif session["userdetails"]["userType"] eq "Super Admin" || (session["userdetails"]["userType"] eq "admin" && session["userdetails"]["email"] eq "sburto10@fau.edu") || (session["userdetails"]["userType"] eq "admin" && session["userdetails"]["email"] eq "sburto10@fau.edu") || (session["userdetails"]["userType"] eq "administrators" && session["userdetails"]["email"] eq "cpagekarjian@fau.edu") || (session["userdetails"]["userType"] eq "administrators" && session["userdetails"]["email"] eq "annesleeman@gmail.com")>
  <style type="text/css">
    .imag_main_dev{

      display: flex;
      width: 100%;

    }
    table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;

  }

  td, th {
    /*border: 1px solid #dddddd;*/
    text-align: left;
    padding: 8px;
  }

  tr:nth-child(even) {
  }
  .text_center{
    text-align: center;
  }
  .height_tr{
    height:35px;
  }
  .checkbox_button{
    height: 30px;
    width: 25px;
  }
  .security_section{
      padding: 0px 20px;
      background:#fff;
  }
  </style>
  <cfoutput>
    <cfif isdefined('FORM.save')>
      <!--- <cfdump var="#form#" abort="true"> --->
      <cfset UpdateSecuritySetting = Application.Sighting.UpdateSecuritySetting(argumentCollection="#Form#")>

      <cfset msg="Successfully Saved!">
    </cfif>  
    <cfset qget = Application.Sighting.getSecuritySetting()>
    <div id="content" class="content"> 
      <!-- begin breadcrumb -->
      <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Home</a></li>
        <li><a href="javascript:;" class="active">Security Settings</a></li>
      </ol>
      <!-- end breadcrumb --> 
      <!-- begin page-header -->
      <h1 class="page-header">Security Settings 
      <!--- <cfinclude template="SightingMenu.cfm"> --->
      </h1>
      <!-- end page-header -->
      <div class="section-container section-with-top-border p-b-10"> 
        <!-- begin row -->
        <div class="main-form-section">
          <div class="row">
            <cfif isdefined('msg')>
              <div class="alert alert-success fade in m-b-10" id="sucess-div">
                <strong>#msg#</strong>
                <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
              </div>
            </cfif> 
            <div  class="pull-right col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-bottom:10px">
              <form role="form"  method="post" action="">
                <div class="security_section">  
                  <table>
                    <tr>
                      <th><h4 style="width: 55%;font-size: 24px;background: ##1abc9c;font-weight: 900;">Master Data</h4></th>
                      <th class="text_center"><h4>Administrators</h4></th>
                      <th class="text_center"><h4>Team Members</h4></th>
                      <th class="text_center"><h4>Vet Assistant</h4></th>
                      <th class="text_center"><h4>Volunteer</h4></th>
                    </tr>
                    <cfloop query="qget">
                      <cfoutput>
                        <cfif #qget.module# eq "master">
                          <tr>
                            <td><h4>#qget.Name#</h4></td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.administrators neq 0> checked</cfif> value="#qget.ID#" name="administrators">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.team_members neq 0> checked</cfif> value="#qget.ID#" name="team_members">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.vet_assistant neq 0> checked</cfif> value="#qget.ID#" name="vet_assistant">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.volunteers neq 0> checked</cfif> value="#qget.ID#" name="volunteers">
                            </td>
                          </tr>
                        </cfif>
                      </cfoutput>
                    </cfloop>
                    <tr>
                      <th><h4 style="width: 55%;font-size: 24px;background: ##1abc9c;font-weight: 900;">Photo ID</h4></th>
                    </tr>
                    <cfloop query="qget">
                      <cfoutput>
                        <cfif #qget.module# eq "photoID">
                          <tr>
                            <td><h4>#qget.Name#</h4></td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.administrators neq 0> checked</cfif> value="#qget.ID#" name="administrators">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.team_members neq 0> checked</cfif> value="#qget.ID#" name="team_members">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.vet_assistant neq 0> checked</cfif> value="#qget.ID#" name="vet_assistant">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.volunteers neq 0> checked</cfif> value="#qget.ID#" name="volunteers">
                            </td>
                          </tr>
                        </cfif>
                      </cfoutput>
                    </cfloop>
                    <tr>
                    <th><h4 style="width: 55%;font-size: 24px;background: ##1abc9c;font-weight: 900;">Stranding and Veterinary</h4></th>
                    <!--- <th><h4 style="width: 55%;font-size: 24px;background: ##1abc9c;font-weight: 900;">Stranding Module</h4></th>
                    <tr>
                    <th><h4 style="width: 55%;font-size: 24px;background: ##1abc9c;font-weight: 900;">Cetaecen Exam</h4></th> --->
                    </tr>
                    <cfloop query="qget">
                      <cfoutput>
                        <cfif #qget.module# eq "stranding">
                          <tr>
                            <td><h4>#qget.Name#</h4></td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.administrators neq 0> checked</cfif> value="#qget.ID#" name="administrators">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.team_members neq 0> checked</cfif> value="#qget.ID#" name="team_members">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.vet_assistant neq 0> checked</cfif> value="#qget.ID#" name="vet_assistant">
                            </td>
                            <td class="text_center">
                              <input type="checkbox" class="checkbox_button" <cfif qget.volunteers neq 0> checked</cfif> value="#qget.ID#" name="volunteers">
                            </td>
                          </tr>
                        </cfif>
                      </cfoutput>
                    </cfloop>
                    <!--- <th><h4 style="width: 55%;font-size: 24px;background: ##1abc9c;font-weight: 900;">Hi Form</h4></th>
                  </tr>
                  <cfloop query="qget">
                    <cfoutput>
                      <cfif #qget.module# eq "stranding">
                        <tr>
                          <td><h4>#qget.Name#</h4></td>
                          <td class="text_center">
                            <input type="checkbox" class="checkbox_button" <cfif qget.administrators neq 0> checked</cfif> value="#qget.ID#" name="administrators">
                          </td>
                          <td class="text_center">
                            <input type="checkbox" class="checkbox_button" <cfif qget.team_members neq 0> checked</cfif> value="#qget.ID#" name="team_members">
                          </td>
                          <td class="text_center">
                            <input type="checkbox" class="checkbox_button" <cfif qget.vet_assistant neq 0> checked</cfif> value="#qget.ID#" name="vet_assistant">
                          </td>
                          <td class="text_center">
                            <input type="checkbox" class="checkbox_button" <cfif qget.volunteers neq 0> checked</cfif> value="#qget.ID#" name="volunteers">
                          </td>
                        </tr>
                      </cfif>
                    </cfoutput>
                  </cfloop>
                  <th><h4 style="width: 55%;font-size: 24px;background: ##1abc9c;font-weight: 900;">Level A Form</h4></th>
                </tr>
                <cfloop query="qget">
                  <cfoutput>
                    <cfif #qget.module# eq "stranding">
                      <tr>
                        <td><h4>#qget.Name#</h4></td>
                        <td class="text_center">
                          <input type="checkbox" class="checkbox_button" <cfif qget.administrators neq 0> checked</cfif> value="#qget.ID#" name="administrators">
                        </td>
                        <td class="text_center">
                          <input type="checkbox" class="checkbox_button" <cfif qget.team_members neq 0> checked</cfif> value="#qget.ID#" name="team_members">
                        </td>
                        <td class="text_center">
                          <input type="checkbox" class="checkbox_button" <cfif qget.vet_assistant neq 0> checked</cfif> value="#qget.ID#" name="vet_assistant">
                        </td>
                        <td class="text_center">
                          <input type="checkbox" class="checkbox_button" <cfif qget.volunteers neq 0> checked</cfif> value="#qget.ID#" name="volunteers">
                        </td>
                      </tr>
                    </cfif>
                  </cfoutput>
                </cfloop> --->
                    <tr>
                      <td><button type="submit" class="btn btn-success" name="save">Save</button></td>
                    </tr>
                  </table>
                </div>          
              </form>         
            </div>
          </div>
        </div>
      </div>
    </div>
  </cfoutput>
<cfelse>
  <cflocation addtoken="no" url="#Application.siteroot#?Module=Security&Page=index" >
</cfif> 





