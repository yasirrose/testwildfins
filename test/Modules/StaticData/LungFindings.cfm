<cfparam name="form.searchword" default="">
<cfif isdefined('FORM.addFinding')>
    <cfset qinsertLungFinding = Application.StaticDataNew.LungFindingInsert(argumentCollection="#Form#")>
</cfif>
<cfif isdefined('FORM.editFinding')>
    <cfset qEditLungFinding = Application.StaticDataNew.EditLungFinding(argumentCollection="#Form#")>
</cfif>
<cfset qLungFinding= Application.StaticDataNew.getLungFinding()>
<!-- begin #content -->
<div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Home</a></li>
        <li><a href="javascript:;">Lung Findings</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Lung Findings</h1>
    <!-- end page-header -->
    <cfif isdefined('qEditLungFinding')>
        <div class="alert alert-success fade in m-b-10" id="sucess-div">
            <strong>Successfully Updated!</strong>
            <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
            </div>
            </cfif> 
            <cfif isdefined('qinsertLungFinding')>
            <div class="alert alert-success fade in m-b-10" id="sucess-div">
            <strong>Successfully Added!</strong>
            <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
        </div>
    </cfif>

    <div class="section-container section-with-top-border p-b-10">
    <div class="row">
            <!-- begin col-6 -->
            <div class="col-md-10">
                <h5 class="m-t-0">Create Lung Findings Record</h5>
            
                <cfoutput>
                <form class="form-horizontal" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="add-type" method="post">
                    <div class="form-group m-b-10">
                        <label class="col-md-3 control-label">Finding</label>
                        <div class="col-md-7">
                            <input type="hidden" name="ID" value='' id="Finding_id" />
                            <input type="text" class="form-control" name="finding" id="finding" placeholder="Please Input Finding" required/>
                        </div>
                    </div>
                    <div class="form-group m-b-10">
                        <label class="col-md-3 control-label">Status</label>
                        <div class="col-md-7">
                        <select class="form-control" name="status" id="status">
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>

                        </select>
                    </div>
                    </div>
                    <div class="col-md-7 col-md-offset-3">
                        <button type="submit" name="addFinding" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
                        <button class="btn btn-default width-100" type='reset'>Reset</button>
                    </div>
                </form>
            </cfoutput>
            </div>
            <!-- end col-6 -->
            <!-- begin col-6 -->

        </div>
        <!-- end row -->
</div>      
<div class="form-group">
    <div class="alert alert-success message" style="display:none">
        <strong>Success!</strong> Lung Finding Deleted.
    </div>
</div>
<!-- begin section-container -->
<div class="section-container section-with-top-border">
    <div class="form-group m-b-10" style="overflow: hidden;">
        <!-- begin panel -->
        <div class="panel pagination-inverse m-b-0 clearfix">
            <table id="example"  class="table table-bordered table-hover">
                <thead>
                    <tr class="inverse">
                        <th>Sr#</th>
                        <th>Lung Finding</th>
                        <th>Status</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="qLungFinding">
                        <tr class="inverse" id="remov_#ID#">
                            <td>#qLungFinding.currentRow#</td>
                            <td id='finding-#id#'>#finding#</td>
                            <td>
                                <cfif status eq 1 >
                                Active
                                <cfelse>
                                Inactive
                                </cfif>
                                <input type="hidden" name="seletecActiveValue-#id#" id="seletecActiveValue-#id#" value="#status#">
                            </td>
                            <td class="text-center">
                                <button class="btn btn-xs btn-primary update" onclick="updateRecord(#ID#)"><i class="fa fa-pencil-square-o"></i></button> 
                                &nbsp; &nbsp;&nbsp;&nbsp; 
                                <button class="btn btn-xs btn-primary" onclick="return deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
        <!-- end panel -->
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