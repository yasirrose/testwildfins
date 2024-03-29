<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <cfset getTeams=Application.SightingNew.getTeams()>

    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>

    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>

    <cfset qgetIR_CountyLocation=Application.StaticDataNew.getIR_CountyLocation()>

    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset qgetVeterinarianss= Application.StaticDataNew.getVeterinarianss()>
    <cfset qgetBiopsyType= Application.StaticDataNew.getBiopsyType()>
    <cfset qgetBiopsyLocation= Application.StaticDataNew.getBiopsyLocation()>
    <cfset qgetDrugType= Application.StaticDataNew.getDrugType()>
    <cfset qgetDrugMethod = Application.StaticDataNew.getDrugMethod()>
    <cfset getHeadNuchalCrest = Application.ConditionLesions.getHeadNuchalCrest()>
    <!---  Head Condition   --->
    <cfset getHeadLateralCervicalReg = Application.ConditionLesions.getHeadLateralCervicalReg()>
    <cfset getHeadFacialBones = Application.ConditionLesions.getHeadFacialBones()>
    <cfset getHeadEarOS = Application.ConditionLesions.getHeadEarOS()>
    <cfset getHeadChinSkinFolds = Application.ConditionLesions.getHeadChinSkinFolds()>
    <!---  Body Condition   --->
    <cfset getBodyEpaxialMuscle = Application.ConditionLesions.getBodyEpaxialMuscle()>
    <cfset getBodyDorsalRidgeScapula = Application.ConditionLesions.getBodyDorsalRidgeScapula()>
    <cfset getBodyRibs = Application.ConditionLesions.getBodyRibs()>
    <!---  Tail Condition   --->
    <cfset getTailTransversePro = Application.ConditionLesions.getTailTransversePro()>
    <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
    <!---  Static data   --->
    <cfset getRegions = Application.ConditionLesions.getRegions()>
    <cfset qgetDiagnosticLab=Application.StaticDataNew.getDiagnosticLab()>
    <cfset qgetSampleType=Application.StaticDataNew.getSampleType()>
    <cfset bodyConditions = ['Emaciated','Underweight/Thin','Ideal','Overweight','Obese']>
    <cfset MucusMembraneColor = ['Dark Pink','Pink','Light Pink','Yellow','Pale (no color)','Blue','CBD']>
    <cfset sides = ['L','R','L/R','N/A']>
    <cfset sex = ['Male','Female','CBD']>
    <cfset ageClass = ['Neonate','YOY','Calf','Juvenile','Adult','CBD/Unknown','Pup','Fetus']>
    <cfset SSCollectedFor = ['Clinical Pathology', 'Infectious Disease', 'Toxicology' ,'Other']>
    <cfset SLCollectedFor = ['Infections Disease', 'Histopathology', 'Toxicology' ,'Other']>
    <cfset BSCollectedFor = ['Clinical Pathology', 'Infectious Disease', 'Histopathology' ,'Toxicology','Other']>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Alive/Fresh Dead','Moderate Decomposition' ,'Advanced Decomposition','Mummified']>
    <cfset ConditionsValue = ['1', '2', '1/2','3' ,'4','5']>
    <cfparam  name="url.LCEID" DEFAULT="0">
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfparam  name="url.LCE_HID" DEFAULT="0"> 


    <cfif isDefined('SaveAndNew') OR isDefined('SaveAndClose') OR isDefined('SaveandgotoHIForm') OR isDefined('SaveandgotoAForm')>
        <!--- <cfdump var="#form#" abort="true"> --->
     
        <cfif isDefined('form.ID') and form.ID neq "">
            <!--- <cfdump var="#form.Drugtype#" abort="true"> --->
            <cfset form.LCE_ID = "#form.ID#">
            <cfset form.LCEID = "#form.ID#">
            <cfset Application.Stranding.CetaceanExamUpdate(argumentCollection="#Form#")>
            <cfif form.count neq "">
                <cfset Application.Stranding.UpdateNotesData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.heartRate neq "" and form.heartRateTime neq "">
                <cfset Application.Stranding.InsertHeartData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.respRate neq "">
                <cfset Application.Stranding.InsertRespData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.Drugtype neq "">
                <!--- <cfdump var="#form.Drugtype#" abort="true"> --->
                <cfset Application.Stranding.InsertDrugData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.BiopsyType neq "">
                <cfset Application.Stranding.InsertBiopsyData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.LesionPresent neq "">
                <cfset Application.Stranding.InsertLesionData(argumentCollection="#Form#")>
            </cfif>
            <cfif isDefined('SaveandgotoHIForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=HIForm&LCE_ID=#form.ID#" >
            </cfif>
            <cfif isDefined('SaveandgotoAForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=LevelAForm&LCE_ID=#form.ID#" >
            </cfif>
        <cfelse>
            <!--- <cfdump var="#form.Drugtype#" abort="true"> --->
            <cfset LCE = Application.Stranding.LiveCetaceanExamInsert(argumentCollection="#Form#")>
            <cfset Session.CeteacenExam = #LCE#>
            <cfset form.LCEID = "#LCE#">
            <cfset form.LCE_ID = "#LCE#">
            <cfif form.heartRate neq "" and form.heartRateTime neq "">
                <cfset Application.Stranding.InsertHeartData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.respRate neq "">
                <cfset Application.Stranding.InsertRespData(argumentCollection="#Form#")>
            </cfif>
        
            <cfif form.Drugtype neq "">
                <cfset Application.Stranding.InsertDrugData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.BiopsyType neq "">
                <cfset Application.Stranding.InsertBiopsyData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.LesionPresent neq "">
                <cfset Application.Stranding.InsertLesionData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.maxNotes neq "">
                <cfset Application.Stranding.InsertNotesData(argumentCollection="#Form#")>
            </cfif>
            <cfif isDefined('SaveandgotoHIForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=HIForm&LCE_ID=#LCE#" >
            </cfif>
            <cfif isDefined('SaveandgotoAForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=LevelAForm&LCE_ID=#LCE#" >
            </cfif>
        </cfif>
    <cfelseif isDefined('delete')>
        <!--- <cfdump var="#form.ID#" abort="true"> --->
        <cfset form.LCE_ID = "#form.ID#">
        <cfset Application.Stranding.deleteCE("#form#")>
    
    <cfelseif isDefined('deleteAllRecord')>
        <!--- <cfset form.LCE_ID = "#form.ID#"> --->
        <cfset Application.Stranding.deleteCetaceanExamAllrecord()>
    </cfif>

    <cfif isDefined('cgi.REQUEST_METHOD') and cgi.REQUEST_METHOD EQ 'GET'>
        <!--- <cfdump var="#cgi.REQUEST_METHOD#" abort="true"> --->
        <cfset Session.CeteacenExam = ''>
        <cfset Session.HIForm = ''> 
        <cfset Session.LevelAForm = ''>
        <cfset Session.Histo = ''>
        <cfset Session.bloodValue = ''>
        <cfset Session.Toxicology = ''>
        <cfset Session.Ancillary = ''>
        <cfset Session.SampleArchive = ''>
        <cfset Session.CetaceanNecropsy = ''>
        <cfset Session.Morphometrics = ''>


    </cfif>

    <cfset qgetLCEID=Application.Stranding.getLCEID()>
    <cfset qgetLCEDate=Application.Stranding.getLCEDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetLCEFBNumber=Application.Stranding.getLCEFBNumber()>
    <cfif url.LCEID neq 0>
        <cfset form.LCEID = url.LCEID>
        <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <cfset qLCEDataa=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <cfif #qLCEData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qLCEData.species#")>
        </cfif>
        <cfset qgetHeartData = Application.Stranding.getHeartData(LCEID="#form.LCEID#")>
        <cfset qgetRespData = Application.Stranding.getRespData(LCEID="#form.LCEID#")>
        <cfset qgetDrugData = Application.Stranding.getDrugData(LCEID="#form.LCEID#")>
        <cfset qgetBiopsyData = Application.Stranding.getBiopsyData(LCEID="#form.LCEID#")>
        <cfset qgetLesionData = Application.Stranding.getLesionData(LCEID="#form.LCEID#")>
        <cfset qgetNewSectionData = Application.Stranding.getNewSectionData(LCEID="#form.LCEID#")>
    </cfif>
    
    <cfif (isDefined('form.LCEID') and form.LCEID neq "")>
        <!--- <cfdump var="#Session.CeteacenExam#" abort="true"> --->
        <cfif Session.CeteacenExam NEQ form.LCEID>
        <cfset Session.CeteacenExam = ''>
        </cfif>
        <!--- <cfdump var="#Session.CeteacenExam#" abort="true">
        <cfset Session.CeteacenExam = ''> --->
        <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <cfset qLCEDataa=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <!--- <cfdump var="#form.LCEID#" abort="true"> --->
        <!--- <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate(argumentCollection="#Form#")> --->
        <!--- <cfset form.NRD = qLCEDataa.Fnumber> --->
        <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate(#form.LCEID#)>
        <!--- <cfdump var="#qgetcetaceanDate.CNRDATE#" abort="true"> --->
        <cfif #qLCEData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qLCEData.species#")>
        </cfif>
        <cfset qgetHeartData = Application.Stranding.getHeartData(LCEID="#form.LCEID#")>
        <cfset qgetRespData = Application.Stranding.getRespData(LCEID="#form.LCEID#")>
        <cfset qgetDrugData = Application.Stranding.getDrugData(LCEID="#form.LCEID#")>
        <cfset qgetBiopsyData = Application.Stranding.getBiopsyData(LCEID="#form.LCEID#")>
        <cfset qgetLesionData = Application.Stranding.getLesionData(LCEID="#form.LCEID#")>
        <cfset qgetNewSectionData = Application.Stranding.getNewSectionData(LCEID="#form.LCEID#")>
    <cfelse>
        <!--- <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate_ten()> --->
        <cfset qLCEData=Application.Stranding.getLCE_ten()>
        <cfset qLCEDataa=Application.Stranding.getLCE_ten()>
    </cfif>

    <!--- <cfdump var="#Session.CeteacenExam#" abort="true"> --->
       <!--- <cflock timeout=20 scope="Session" type="Exclusive">
    </cflock> --->
    <!--- <cfif isDefined('form.ID') and form.ID neq "">
        <cfset Session.CeteacenExam = #form.ID#>
    </cfif> --->
        <!--- form.LCEID --->
        <cfif isDefined('Session.CeteacenExam') and Session.CeteacenExam NEQ ''>
            <cfset form.LCEID = #Session.CeteacenExam#>
          
            <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
            <!--- <cfset qLCEDataa=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")> --->
            <!--- <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate(argumentCollection="#Form#")> --->
            <!--- <cfset form.NRD = qLCEDataa.Fnumber> --->
            <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate(#form.LCEID#)>
            <!--- <cfdump var="#qgetcetaceanDate.CNRDATE#" abort="true"> --->
            <cfif #qLCEData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qLCEData.species#")>
            </cfif>
            <cfset qgetHeartData = Application.Stranding.getHeartData(LCEID="#form.LCEID#")>
            <cfset qgetRespData = Application.Stranding.getRespData(LCEID="#form.LCEID#")>
            <cfset qgetDrugData = Application.Stranding.getDrugData(LCEID="#form.LCEID#")>
            <cfset qgetBiopsyData = Application.Stranding.getBiopsyData(LCEID="#form.LCEID#")>
            <cfset qgetLesionData = Application.Stranding.getLesionData(LCEID="#form.LCEID#")>
            <cfset qgetNewSectionData = Application.Stranding.getNewSectionData(LCEID="#form.LCEID#")>          
        
        </cfif>
    <!--- end for ceteacean Exam --->

<!---start For HIForm --->

<cfif isDefined('SaveAndNewHI') OR isDefined('SaveandgotoAForm') OR isDefined('SaveAndClose')>
    <!--- If updating existing data --->
    
    <cfif  isDefined('form.HIForm_ID') and form.HIForm_ID neq "">
        <cfset LCE = Application.Stranding.HIFormUpdate(argumentCollection="#Form#")>

            <cfset form.HI_ID = form.HIForm_ID>
    
            <cfset form.LCE= form.HIForm_ID>
            <cfset Application.Stranding.InsertHiExampData(argumentCollection="#Form#")>
        
        <cfelse>
            <!--- If inserting new data --->
            <cfset form.LCE_ID = url.LCE_ID>
          
            <cfset LCE = Application.Stranding.HIFormInsert(argumentCollection="#Form#")>

            <cfset Session.HIForm = #LCE#>

            <cfset form.HI_ID = LCE>
           
            <cfif form.HiType neq "">
                <cfset form.LCE= LCE>
                <cfset Application.Stranding.InsertHiExampData(argumentCollection="#Form#")>
            </cfif>

            <cfif isDefined('SaveandgotoAForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=LevelAForm&LCE_ID=#url.LCE_ID#" >
            </cfif>
        </cfif>

<cfelseif isDefined('hiRecordDelete')>
    <cfset Application.Stranding.deleteHI("#form#")>
<cfelseif isDefined('deleteAllHiFormRecord')>
    <cfset Application.Stranding.deleteHiFormAllRecord()>
</cfif>

    <cfset sex = ['Male','Female','CBD']>
    <cfset ageClass = ['Neonate','YOY','Yearling','Calf','Juvenile','Subadult','Adult','CBD/Unknown','Pup','Fetus']>
    <cfset Examtype = ['Photos Only','External Exam','Partial Internal Exam','Complete Internal Exam (necropsy)'] >
    <cfset TypeofHI = ['Entanglement','Hooking','Ingestion','Vessel Trauma','Gunshot','Harassment','Mutilation','CBD/Other'] >
    <cfset LocationofHI = ['Rostrum','Mandible','Head/Neck','L Flipper','R Flipper','Dorsum/Dorsal Fin','Ventrum','Peduncle','Flukes','Abdomen','Thorax','Maxilla','Stomach','Forestomach','Fundus','Pylorus','Esophagus','Inside of Mouth','Tongue','Intestine'] >
    <cfset ContributedtoStrandingEvent = ['Uncertain/CBD','Improbable','Suspect','Probable']>
    <cfset TypeofGearCollected = ['Hook','Monofilament Line','Braided Line','Crab Pot','Crab Pot Line','Crab Pot Buoy','Debris','Net','Weight','Lure'] >
    <cfset GearDeposition =  ['NMFS','FAU Harbor Branch','FAU Ocean Discovery Visitor’s Center','Disposed of']>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderate Decomposition' ,'Advanced Decomposition','Mummified']>

        <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
        <cfif url.LCE_ID neq 0>
            <cfset form.LCEID = url.LCE_ID>
            <cfset neworexist=Application.Stranding.getHIDataByLCE("#form.LCEID#")>
            <cfset qgetHIData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")> 
            <cfif #qgetHIData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
            </cfif>
            <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
                <cfset form.HI_ID = neworexist.ID>
            </cfif>
        </cfif>

        <!---   getting data on the basis of HI_ID  --->
        <!--- <cfif  isDefined('form.HI_ID') and form.HI_ID neq ""> --->
    <cfif (isDefined('form.HI_ID') and form.HI_ID neq "") or (isDefined('form.LCE_HIID') and form.LCE_HIID neq '0')>
                <!--- <cfset Session.HIForm = #form.HI_ID#> --->
        <!--- <cfdump var="#Session.HIForm#" abort="true"> --->
        <cfif Session.HIForm NEQ form.HI_ID>
            <cfset Session.HIForm = ''> 
        </cfif> 
        <cfset form.LCEID = form.HI_ID>
        <!--- <cfset form.HI_ID = form.LCE_HIID> --->        
        <cfset qgetHIData=Application.Stranding.getHIData("#form.LCEID#")>
        <cfset qLCEDataa=Application.Stranding.getHIData("#form.LCEID#")>
        <cfset qgetcetaceanDate=Application.Stranding.getHIFormNecropsyDate(#form.LCEID#)>

        <cfif #qgetHIData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
        </cfif>

        <cfset qgetHiExamData = Application.Stranding.getHiExamData(LCEID="#form.LCEID#")>
        
    </cfif>

            <!--- <cfset SiteURl = #cgi.QUERY_STRING#>
<cfset arr = ListToArray(SiteURl,"&","false")/>
<cfif arr[3] eq 'HIForm'> --->
    <cfif isDefined('Session.HIForm') and Session.HIForm NEQ ''>        
        <!--- <cfset form.LCEID = ''> --->
        <cfset form.LCEID = #Session.HIForm#>
        <cfset form.HI_ID = #Session.HIForm#>
         <!--- <cfdump var="#Session.HIForm#" abort="true"> --->
        <cfset qgetHIData=Application.Stranding.getHIData("#form.LCEID#")>
        <!--- <cfset qLCEDataa=Application.Stranding.getHIData("#form.LCEID#")> --->
        <cfset qgetcetaceanDate=Application.Stranding.getHIFormNecropsyDate(#form.LCEID#)>

        <cfif #qgetHIData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
        </cfif>

        <cfset qgetHiExamData = Application.Stranding.getHiExamData(LCEID="#form.LCEID#")>
    </cfif>
<!--- </cfif> --->

        <!---  setup empty form when directly clicked the HI link from side bar --->
        <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
            <cfset qgetHIData=Application.Stranding.getHI_ten()>
            <!---  setup empty form when when entering new record --->
        <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
            <cfset qgetHIData=Application.Stranding.getHI_ten()>
        </cfif>


      <!---  get all records order by ID DESC--->
      <cfset getHIID=Application.Stranding.getHIID()>
      <!---  get all records order by Date Desc --->
      <cfset qgetHIDate=Application.Stranding.getHIDate()>
      <!---  get all records order by Field Numbert Desc --->
      <cfset qgetHIFBNumber=Application.Stranding.getHIFBNumber()>


    <!--- End of HIForm --->

    <!--- Start for Level A form --->
    <cfset ageClass = ['Neonate','YOY','Yearling','Calf','Juvenile','Subadult','Adult','CBD/Unknown']>
    <cfset ILAD = ['Left at Site','Immediate Release at Site','Relocated and Released','Disentangled','Died at Site','Died During Transport','Euthanized','Transferred to Rehab','Other'] >
    <cfset CarcassStatus = ['Frozen for Later','Exam/Necropsy Pending','Left at Site','Landfill','Towed','Buried','Incinerated','Sunk','Rendered','Composted','Unknown/Other'] >
    <cfset GroupEventType = ['Cow/Calf Pair','Mass Stranding','UME','Unknown'] >
    <cfset LAGroupEventType = ['Cow/Calf Pair','Mass Stranding','UME'] >
    <cfset TagsWere = ['Present at time of Stranding','Applied During Stranding','Absent but Suspect Prior Tag']>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderate Decomposition' ,'Advanced Decomposition','Mummified']>
    <!--- <cfparam  name="url.LCE_ID" DEFAULT="0"> --->

    <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
    
    <cfif isDefined('SaveAndNewLA') OR isDefined('SaveAndClose') OR isDefined('SaveandgotoHistopathology')> 
        <!--- If updating existing data --->
        <!--- <cfdump var="#form#" abort="true"> --->
       <!--- <cfdump var="#form.level_A_ID#" abort="true">
       <cfif  isDefined('form.ID') and form.ID neq "">
           <cfset isformID = Application.Stranding.getIdOfLevelA(argumentCollection="#form.ID#")>
       </cfif> --->
        <cfif  isDefined('form.level_A_ID') and form.level_A_ID neq "">
            <cfset form.LA_ID = form.level_A_ID>
            <cfset LCE = Application.Stranding.LevelAFormUpdate(argumentCollection="#Form#")>
            
            <cfif isDefined('SaveandgotoHistopathology') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Histopathology&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoHistopathology') and url.LCE_ID neq 0 >
                <!--- <cfset form.LCE_ID = url.LCE_ID>
                <cfset LCE = Application.Stranding.LevelAFormInsert(argumentCollection="#Form#")> --->
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Histopathology" >
            </cfif>
        <cfelse>
            <!--- If inserting new data --->
         
            <cfset form.LCE_ID = url.LCE_ID>
            <cfset LCE = Application.Stranding.LevelAFormInsert(argumentCollection="#Form#")>
            <cfset Session.LevelAForm = #LCE#>
            <cfset form.LA_ID = LCE>

            <!--- <cfif isDefined('SaveandgotoHistopathology')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Histopathology&LCE_ID=#url.LCE_ID#" >
            </cfif> --->
        </cfif>
    <cfelseif isDefined('levelAformDelete')>
        <cfset Application.Stranding.deleteLA("#form.ID#")>
    <cfelseif isDefined('deleteAllLevelAFormRecord')>
        <cfset Application.Stranding.deleteAllLevelAFormRecord()>
    </cfif>
   <!--- if user directed from the Cetacean form, here get first 4 forms data of Cetacean form --->
   <!--- <cfif url.LCE_ID neq 0>
    <cfset form.LCEID = url.LCE_ID>
    <cfset neworexist=Application.Stranding.getLevelADataByLCE("#form.LCEID#")>
    <cfset qgetLevelAData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
    <cfif #qgetLevelAData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetLevelAData.species#")>
    </cfif>
    <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
        <cfset form.HI_ID = neworexist.ID>
    </cfif>
</cfif> --->
<!---   getting data on the basis of LevelA ID  --->

<cfif  isDefined('form.LA_ID') and form.LA_ID neq "">

    <!--- <cfset Session.LevelAForm = #form.LA_ID#> --->
<cfif Session.LevelAForm NEQ form.LA_ID>
    <cfset Session.LevelAForm = ''>
</cfif>
    <cfset form.LCEID = form.LA_ID>
    <cfset qgetLevelAData=Application.Stranding.getLevelAData("#form.LCEID#")>
    <cfset qLCEDataa=Application.Stranding.getLevelAData("#form.LCEID#")>
    <cfset qgetcetaceanDate=Application.Stranding.getLevelAFormNecropsyDate(#form.LA_ID#)>
    <!--- <cfdump var="#qgetLevelAData#" abort="true"> --->
    <cfif #qgetLevelAData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetLevelAData.species#")>
    </cfif>
</cfif>

<cfif isDefined('Session.LevelAForm') and Session.LevelAForm NEQ ''> 
    <cfset form.LCEID = #Session.LevelAForm#>
    <cfset form.LA_ID = #Session.LevelAForm#>
    <cfset qgetLevelAData=Application.Stranding.getLevelAData("#form.LCEID#")>
    <!--- <cfset qLCEDataa=Application.Stranding.getLevelAData("#form.LCEID#")> --->
    <cfset qgetcetaceanDate=Application.Stranding.getLevelAFormNecropsyDate(#form.LA_ID#)>
    <!--- <cfdump var="#qgetLevelAData#" abort="true"> --->
    <cfif #qgetLevelAData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetLevelAData.species#")>
    </cfif>
</cfif>


       <!---  get all records order by ID DESC--->
       <cfset qgetLevelAID=Application.Stranding.getLevelAID()>
       <!---  get all records order by Date Desc --->
       <cfset qgetLevelADate=Application.Stranding.getLevelADate()>
       <!---  get all records order by Field Numbert Desc --->
       <cfset qgetLevelAFBNumber=Application.Stranding.getLevelAFBNumber()>
        
    <!--- End for Level A form --->


    <!--- start f   or Histo --->
        <!---  setup empty form when directly clicked the HI link from side bar --->
        <cfset qgetHIDataa=Application.Stranding.getHisto_ten()>
   
    <!--- if user directed from the Cetacean form, here get first 4 forms data of Cetacean form ---> 

    <cfif url.LCE_ID neq 0 and url.LCE_ID neq " ">
        <!--- below storing LCE_ID in "form.LCEID" which catched from URL and getting data from tables against that id  --->
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getHistoDataByLCE("#form.LCEID#")>
        <cfset qgetHIData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>
        <cfset qgetHistoSampleData = Application.Stranding.getHistoSampleData(HI_ID="#form.LCEID#")>    
        <cfif #qgetHIData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
        </cfif>
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.HI_ID = neworexist.ID>
        </cfif>
    </cfif>
    
    <cfif isDefined('url.LCE_HID') and url.LCE_HID neq 0>
        
        <cfset form.LCEID = url.LCE_HID>
        <cfset form.His_ID = url.LCE_HID>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetHIDataa=Application.Stranding.getHistoData("#form.LCEID#")>
        <cfset qLCEDataa=Application.Stranding.getHistoData("#form.LCEID#")>
        <cfset qgetcetaceanDate=Application.Stranding.getHistopathologyNecropsyDate(#form.His_ID#)>
        <!--- <cfdump var="#qgetcetaceanDate#" abort="true"> --->
        <cfset qgetHistoSampleData = Application.Stranding.getHistoSampleData(HI_ID="#form.LCEID#")>
        <cfif #qgetHIDataa.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIDataa.species#")>
        </cfif>
    </cfif>



    <cfif isDefined('HistoSaveAndNew') OR isDefined('SaveandgotoBloodForm') OR isDefined('SaveAndClose')>
        <cfset form.check = "1">
           <!--- <cfdump var="#form#" abort="true"> --->
        <!--- If updating existing data --->
        <cfif  isDefined('form.Histo_ID') and form.Histo_ID neq "">
            <!--- if sampletype field is not empty then insert Histo sample form's data which can be multiple at single time --->
            <cfset form.His_ID = "#form.Histo_ID#">
            <cfif form.SampleType neq "" and form.SampleNote neq "">
                <cfset form.HI_ID = "#form.Histo_ID#">
                <cfset Application.Stranding.InsertHistopathologySampleData(argumentCollection="#Form#")>
            </cfif>
              <cfset LCE = Application.Stranding.HistoFormUpdate(argumentCollection="#Form#")>
            <!--- <cfif isDefined('SaveandgotoBloodForm') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=BloodValues&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoBloodForm') and url.LCE_ID eq 0 >
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=BloodValues" >
            </cfif> --->
        <cfelse>
            <!--- If inserting new data --->
            <cfset form.LCE_ID = url.LCE_ID>
            <!--- here LCE is catching ID against the latest form/data inserted --->
            <cfset LCE = Application.Stranding.HistoFormInsert(argumentCollection="#Form#")>
            <cfset Session.Histo = #LCE#>
            <cfset form.His_ID = "#LCE#">
            <cfset form.HI_ID  = "#LCE#">
            <cfif form.SampleType neq "" and form.SampleNote neq "">
                <!--- <cfdump var="#form#" abort="true"> --->
                <cfset Application.Stranding.InsertHistopathologySampleData(argumentCollection="#Form#")>
            </cfif>
            <!--- <cfif isDefined('SaveandgotoBloodForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=BloodValues&LCE_ID=#url.LCE_ID#" >
            </cfif> --->
        </cfif>
    <cfelseif isDefined('histoDelete')>
        <cfset Application.Stranding.deleteHisto("#form#")>
    <cfelseif isDefined('deleteHIstoRecord')>
        <cfset Application.Stranding.deleteHIstoRecord()>
    </cfif>

    <!---   getting data on the basis of HI_ID  --->
    <cfif  isDefined('form.His_ID') and form.His_ID neq "">
        <!--- <cfset Session.Histo = #form.LCE_HID#> --->
        <cfif Session.Histo NEQ form.His_ID>
            <cfset Session.Histo = ''>
        </cfif>
        <cfset form.LCEID = form.His_ID>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetHIDataa=Application.Stranding.getHistoData("#form.LCEID#")>
        <cfset qLCEDataa=Application.Stranding.getHistoData("#form.LCEID#")>
        <cfset qgetcetaceanDate=Application.Stranding.getHistopathologyNecropsyDate(#form.His_ID#)>
        <!--- <cfdump var="#qgetHIDataa#" abort="true"> --->
        <cfset qgetHistoSampleData = Application.Stranding.getHistoSampleData(HI_ID="#form.LCEID#")>
        <cfif #qgetHIDataa.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIDataa.species#")>
        </cfif>
    </cfif>

    <cfif isDefined('Session.Histo') and Session.Histo NEQ ''> 
        <cfset form.LCEID = #Session.Histo#>
        <cfset form.His_ID = #Session.Histo#>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetHIDataa=Application.Stranding.getHistoData("#form.LCEID#")>
        <!--- <cfset qLCEDataa=Application.Stranding.getHistoData("#form.LCEID#")> --->
        <cfset qgetcetaceanDate=Application.Stranding.getHistopathologyNecropsyDate(#form.His_ID#)>
        <!--- <cfdump var="#qgetcetaceanDate#" abort="true"> --->
        <cfset qgetHistoSampleData = Application.Stranding.getHistoSampleData(HI_ID="#form.LCEID#")>
        <cfif #qgetHIDataa.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIDataa.species#")>
        </cfif>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset getHistoID=Application.Stranding.getHistoID()>
    <!---  get all records order by Date Desc --->
    <cfset qgetHistoDate=Application.Stranding.getHistoDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetHistoFBNumber=Application.Stranding.getHistoFBNumber()>

    <!--- end for Histo --->

    <!--- start for blood value --->
    
    <cfset Selectoptions = ['Normal','Abnormal','N/A']>
    <cfset qgetRBCMorphology=Application.StaticDataNew.getRbcMorphology()>
    <cfset qgetPlateletMorphology=Application.StaticDataNew.getPlateletMorphology()>
    <cfset qgetWbcMorphology=Application.StaticDataNew.getWbcMorphology()>
    <cfset qgetHemolysisIndex=Application.StaticDataNew.getHemolysisIndex()>
    <cfset qgetLipemiaIndex=Application.StaticDataNew.getLipemiaIndex()>
    <cfset qgetTissueType=Application.StaticDataNew.getTissueType()>

    <cfif isDefined('SaveAndNewBloodvalue') OR isDefined('SaveandgotoToxicology') OR isDefined('SaveAndClose')>
        <!--- If updating existing data --->
       
        <cfif  isDefined('form.bloodValues_ID') and form.bloodValues_ID neq "">
            <cfset form.ID = form.bloodValues_ID>
            <cfset form.bloodValue_ID = "#form.bloodValues_ID#">
            <!--- <cfdump var="#form#" abort="true"> --->
            <!--- awan --->
            <cfset CBCUpdate = Application.Stranding.CBCUpdate(argumentCollection="#Form#")>
            
            <cfset Application.Stranding.FibrinogenUpdate(argumentCollection="#Form#")>
            <!--- <cfdump var="#CBCUpdate#" abort="true"> --->
            <cfset Application.Stranding.ChemisteryUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.CapillaryUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.DolphinUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.iSTAT_ChemUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.CG4Update(argumentCollection="#Form#")>
            <cfset LCE = Application.Stranding.Blood_VFormUpdate(argumentCollection="#Form#")>
            <!--- <cfif isDefined('SaveandgotoToxicology') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Toxicology&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoToxicology') and url.LCE_ID eq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Toxicology" >
            </cfif> --->
        <cfelse>        
            <!--- If inserting new data --->
            <!--- <cfset form.LCE_ID = url.LCE_ID> --->
            <cfset BV_ID = Application.Stranding.Blood_VFormInsert(argumentCollection="#Form#")>
            <cfset Session.bloodValue = #BV_ID#>
            <cfset form.BV_ID = "#BV_ID#">
            <cfset form.bloodValue_ID = "#BV_ID#">
            <!--- inserting CBC form --->
            <cfset CBC_ID = Application.stranding.CBCInsert(argumentcollection="#Form#")> 
            <!--- Inserting Fibrinogen Form --->
            <cfset Fib_ID = Application.stranding.Fibrinogeninsert(argumentcollection="#Form#")>
            <cfset Chem_ID = Application.stranding.Chemistryinsert(argumentcollection="#Form#")>
            <cfset Chap_ID = Application.stranding.Capillaryinsert(argumentcollection="#Form#")>
            <cfset Dol_ID = Application.stranding.Dolphininsert(argumentcollection="#Form#")>
            <cfset iSTAT_ID = Application.stranding.iSTAT_Cheminsert(argumentcollection="#Form#")>
            <cfset CG4_ID = Application.stranding.CG4_Cheminsert(argumentcollection="#Form#")>
            <cfif isDefined('SaveandgotoToxicology')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Toxicology&LCE_ID=#url.LCE_ID#" >
            </cfif>
        </cfif>
    <cfelseif isDefined('bloodValueDelete')>
        <cfset Application.Stranding.deletBlood_V("#form#")>
    <cfelseif isDefined('deleteBloodValuesRecord')>
        <cfset Application.Stranding.deleteBloodValuesRecord()>
    </cfif>

    <cfif  isDefined('form.bloodValue_ID') and form.bloodValue_ID neq "">
        <cfif Session.bloodValue NEQ form.bloodValue_ID>
        <cfset Session.bloodValue = ''>
        </cfif>
        <cfset form.LCEID = form.bloodValue_ID>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetBloodValueData=Application.Stranding.getBlood_VData("#form.LCEID#")>
        <!--- <cfdump var="#qgetBloodValueData.species#" abort="true"> --->
        <cfset qLCEDataa=Application.Stranding.getBlood_VData("#form.LCEID#")>
        <cfset qgetcetaceanDate=Application.Stranding.getBloodValueNecropsyDate(#form.bloodValue_ID#)>

        <cfif #qgetBloodValueData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetBloodValueData.species#")>       
        </cfif>

        <cfset form.bloodID = form.bloodValue_ID>
        <cfset qgetCBC_Data=Application.Stranding.getCBC_Data("#form.bloodID#")>
        <cfset qgetFibrinogen=Application.Stranding.getFibrinogen("#form.bloodID#")>
        <cfset qgetchemistry=Application.Stranding.getchemistry("#form.bloodID#")>
        <cfset qgetCapillary=Application.Stranding.getCapillary("#form.bloodID#")>
        <cfset qgetDolphin=Application.Stranding.getDolphin("#form.bloodID#")>
        <cfset qgetiSTAT_Chem=Application.Stranding.getiSTAT_Chem("#form.bloodID#")>
        <cfset qgetiSTAT_CG4=Application.Stranding.getiSTAT_CG4("#form.bloodID#")>
       
    <cfelse>
        <cfset qgetCBC_Data=Application.Stranding.getCBC_Data_ten()>
        <cfset qgetFibrinogen=Application.Stranding.getFibrinogen_ten()>
        <cfset qgetchemistry=Application.Stranding.getchemistry_ten()>
        <cfset qgetCapillary=Application.Stranding.getCapillary_ten()>
        <cfset qgetDolphin=Application.Stranding.getDolphin_ten()>
        <cfset qgetiSTAT_Chem=Application.Stranding.getiSTAT_Chem_ten()>
        <cfset qgetiSTAT_CG4=Application.Stranding.getiSTAT_CG4_ten()>
        <cfset qgetBloodValueData=Application.Stranding.getBlood_V_ten()>
    </cfif>
    <cfif isDefined('Session.bloodValue') and Session.bloodValue NEQ ''> 
        <cfset form.LCEID = #Session.bloodValue#>
        <cfset form.bloodValue_ID = #Session.bloodValue#>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetBloodValueData=Application.Stranding.getBlood_VData("#form.LCEID#")>
        <!--- <cfdump var="#qgetBloodValueData.species#" abort="true"> --->
        <!--- <cfset qLCEDataa=Application.Stranding.getBlood_VData("#form.LCEID#")> --->
        <cfset qgetcetaceanDate=Application.Stranding.getBloodValueNecropsyDate(#form.bloodValue_ID#)>

        <cfif #qgetBloodValueData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetBloodValueData.species#")>       
        </cfif>

        <cfset form.bloodID = #Session.bloodValue#>
        <cfset qgetCBC_Data=Application.Stranding.getCBC_Data("#form.bloodID#")>
        <cfset qgetFibrinogen=Application.Stranding.getFibrinogen("#form.bloodID#")>
        <cfset qgetchemistry=Application.Stranding.getchemistry("#form.bloodID#")>
        <cfset qgetCapillary=Application.Stranding.getCapillary("#form.bloodID#")>
        <cfset qgetDolphin=Application.Stranding.getDolphin("#form.bloodID#")>
        <cfset qgetiSTAT_Chem=Application.Stranding.getiSTAT_Chem("#form.bloodID#")>
        <cfset qgetiSTAT_CG4=Application.Stranding.getiSTAT_CG4("#form.bloodID#")>
    </cfif>

        <!---  setup empty form when directly clicked the HI link from side bar --->
        <!--- <cfset qgetHIData=Application.Stranding.getBlood_V_ten()> --->
        <!--- <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
            <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
            <!---  setup empty form when when entering new record --->
        <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
            <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
        </cfif> --->
        <!---  get all records order by ID DESC--->
        <cfset getBloodValueID=Application.Stranding.getBlood_VID()>
        <!---  get all records order by Date Desc --->
        <cfset qgetBloodValueDate=Application.Stranding.getBlood_VDate()>
        <!---  get all records order by Field Numbert Desc --->
        <cfset qgetBloodValueFBNumber=Application.Stranding.getBlood_VBNumber()>
    
    
  
    <!--- end for blood value --->


        <!--- start for Toxicology --->
        <cfset ToxicologySelectoptions = ['High','Low','Critical Result','Corrected Result','None']>
        <cfif isDefined('SaveAndNewToxicology') OR isDefined('SaveandgotoAncillaryDiagnostics') OR isDefined('SaveAndClose') OR isdefined('Add_new') >
            <!--- If updating existing data --->

            <cfif  isDefined('form.TX_ID') and form.TX_ID neq "">
                <cfset form.Toxi_ID = "#form.TX_ID#">
                <cfset form.Toxicology_ID = "#TX_ID#">
                <cfif form.tisu_type neq "" and form.tisu_type neq "0">
                    <!--- <cfdump var="#form#" abort="true"> --->
                    
                    <cfset Application.Stranding.ToxiType_FormUpdate(argumentCollection="#Form#")>
                    <cfset Application.Stranding.Update_DynamicToxiType(argumentCollection="#Form#")>
                    <cfset Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
                <cfelse>
                    <!--- <cfdump var="#form#" abort="true"> --->
                    <cfset TT_ID =Application.Stranding.ToxiType_Insert(argumentCollection="#Form#")>
                    <cfset Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
                </cfif>
                <!--- <cfdump var="#form#" abort="true"> --->
                <cfset Application.Stranding.Toxicology_FormUpdate(argumentCollection="#Form#")>
                <!--- <cfset form.HI_ID = ""> --->
                <cfset form.Tissue_type = "">
                <!--- <cfif isDefined('SaveandgotoAncillaryDiagnostics') and url.LCE_ID neq 0>
                    <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=AncillaryDiagnostics&LCE_ID=#url.LCE_ID#" >
                <cfelseif isDefined('SaveandgotoAncillaryDiagnostics') and url.LCE_ID eq 0>
                    <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=AncillaryDiagnostics" >
                </cfif> --->
            <cfelse>     
                <!--- If inserting new data --->
               
                <cfset form.LCE_ID = url.LCE_ID>
                <cfset Toxi_ID = Application.Stranding.Toxicology_FormInsert(argumentCollection="#Form#")>
                <cfset Session.Toxicology = #Toxi_ID#>

                <cfset form.Toxi_ID = "#Toxi_ID#">
                <cfset form.Toxicology_ID = "#Toxi_ID#">

                <cfset TT_ID = Application.Stranding.ToxiType_Insert(argumentCollection="#Form#")>
                <!--- DT is Dynamic toxi --->
                 <!--- <cfdump var="#form#" abort="true">  --->
                <cfset DT_ID = Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
                <cfset form.HI_ID = "">
                <cfset form.Tissue_type = "">
                <!--- <cfif isDefined('SaveandgotoAncillaryDiagnostics')>
                    <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=AncillaryDiagnostics&LCE_ID=#url.LCE_ID#" >
                </cfif> --->
            </cfif>
    
        <cfelseif isDefined('deleteToxicology')>
            <cfset Application.Stranding.deletToxicology("#form#")>
            <cfset form.Toxicology_ID = "">
        <cfelseif isDefined('deleteToxicologyAllRecord')>
            <cfset Application.Stranding.deleteToxicologyAllRecord()>
            <cfset form.Toxicology_ID = "">
        </cfif>
        <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
        <!--- <cfif url.LCE_ID neq 0>
            <cfset form.LCEID = url.LCE_ID>
            <cfset neworexist=Application.Stranding.gettoxiByLCE("#form.LCEID#")>
            <cfset qgetHIDataCetacean=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>
            <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
                <cfset form.HI_ID = neworexist.ID>
            </cfif>
        </cfif> --->
        <!---   getting data on the basis of HI_ID  --->
        <cfif  isDefined('form.Toxicology_ID') and form.Toxicology_ID neq "">
            <cfif Session.Toxicology NEQ form.Toxicology_ID>
            <cfset Session.Toxicology = ''>
            </cfif>
            <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
            <cfset qgetToxicologyData=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qLCEDataa=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qgetcetaceanDate=Application.Stranding.getToxicologyNecropsyDate(#form.Toxicology_ID#)>
            <cfif #qgetToxicologyData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetToxicologyData.species#")>
                
                </cfif>
            <cfif isdefined('form.Tissue_type') and form.Tissue_type neq "">
                <cfset qgetToxitype=Application.Stranding.getToxitype("#form.Tissue_type#,#form.TX_ID#")>
                <!--- <cfdump var="#qgetToxitype#" abort="true"> --->
                <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype("#form.Tissue_type#")>
                <!--- <cfdump var="#qgetDynamicToxitype#" abort="true"> --->
            <cfelse>
                <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
                <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype_ten()>
            </cfif>
        <cfelse>
            <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
            <cfset qgetToxicologyData=Application.Stranding.gettoxiform_ten()>
            
        </cfif>


        <!--- <cfif isDefined('Session.Toxicology') and Session.Toxicology NEQ ''>
            <cfset form.Toxicology_ID = #Session.Toxicology#>
            <cfset qgetToxicologyData=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qgetcetaceanDate=Application.Stranding.getToxicologyNecropsyDate(#form.Toxicology_ID#)>
            <cfif #qgetToxicologyData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetToxicologyData.species#")>
                
                </cfif>
            <cfif isdefined('form.Tissue_type') and form.Tissue_type neq "">
                <cfset qgetToxitype=Application.Stranding.getToxitype("#form.Tissue_type#,#form.TX_ID#")>
                <!--- <cfdump var="#qgetToxitype#" abort="true"> --->
                <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype("#form.Tissue_type#")>
                <!--- <cfdump var="#qgetDynamicToxitype#" abort="true"> --->      
            </cfif>        
            <!--- <cfset qLCEDataa=Application.Stranding.gettoxiform_ten()> --->
        </cfif> --->


        
        <!---  setup empty form when directly clicked the HI link from side bar --->
        <!--- <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
            <cfset qgetHIData=Application.Stranding.gettoxiform_ten()>
            <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
            <!---  setup empty form when when entering new record --->
        <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
            <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
        </cfif> --->
        <!--- <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype_ten()> --->
        <!--- <cfset qgetToxitype=Application.Stranding.getToxitype_ten()> --->
        <!---  get all records order by ID DESC--->
        <cfset getToxicologyID=Application.Stranding.gettoxiform_ID()>
        <!---  get all records order by Date Desc --->
        <cfset qgetToxicologyDate=Application.Stranding.gettoxiformDate()>
        <!--- <cfdump var="#qgetToxicologyDate#" abort="true"> --->
        <!---  get all records order by Field Numbert Desc --->
        <cfset qgetToxicologyFBNumber=Application.Stranding.gettoxifNumber()>
         

        <!--- end for Toxicology --->


        <!--- start for AncillaryDiagnostics --->
        <cfset qgetDiagnosticTest=Application.StaticDataNew.getDiagnosticTest()>
        <cfset testResult = ['Positive','Negative','Inconclusive','Normal','Abnormal','N/A']>


        <cfif isDefined('SaveAndNewAncillaryDiagnostics') OR isDefined('SaveandgotoSampleArchive') OR isDefined('SaveAndClose')>
            <!--- If updating existing data --->
            <cfif  isDefined('form.ADID') and form.ADID neq "">
                <cfset form.AD_ID = "#form.ADID#">
                <cfset Application.Stranding.AncillaryFormUpdate(argumentCollection="#Form#")>
                <cfif form.TestingDate neq "">
                    <cfset Application.Stranding.AncillaryReportInsert(argumentCollection="#Form#")>
                </cfif>
                <cfif isDefined('SaveandgotoSampleArchive') and url.LCE_ID neq 0>
                    <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=SampleArchive&LCE_ID=#url.LCE_ID#" >
                <cfelseif isDefined('SaveandgotoSampleArchive') and url.LCE_ID eq 0>
                    <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=SampleArchive">
                </cfif>
            <cfelse>
                <!--- If inserting new data --->
                <cfset form.LCE_ID = url.LCE_ID>
                <cfset NEWADID = Application.Stranding.AncillaryFormInsert(argumentCollection="#Form#")>
                <cfset Session.Ancillary = #NEWADID#>
                <cfset form.AD_ID = "#NEWADID#">

                <cfif form.TestingDate neq "">
                    <cfset form.ADID = #NEWADID#>
                    <cfset Application.Stranding.AncillaryReportInsert(argumentCollection="#Form#")>
                </cfif>
                <cfif isDefined('SaveandgotoSampleArchive')>
                    <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=SampleArchive&LCE_ID=#url.LCE_ID#" >            
                </cfif>
            </cfif>
        <cfelseif isDefined('deleteAncillary')>
            <cfset Application.Stranding.deleteAncillary("#form#")>
        <cfelseif isDefined('deleteAncillaryAllRecord')>
            <cfset Application.Stranding.deleteAncillaryAllRecord()>
        </cfif>

        <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
        <!--- <cfif url.LCE_ID neq 0>
            <cfset form.LCEID = url.LCE_ID>
            <cfset neworexist=Application.Stranding.getAncillaryDataByLCE("#form.LCEID#")>
            <cfset qgetHIData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
            <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
                <cfset form.AD_ID = neworexist.ID>
                <cfset qAncillaryReportGet=Application.Stranding.AncillaryReportGet(ADID="#form.AD_ID#")>
            </cfif>
        </cfif> --->
        <!---   getting data on the basis of HI_ID  --->
        <cfif  isDefined('form.AD_ID') and form.AD_ID neq "">
            <cfif Session.Ancillary NEQ form.AD_ID>
            <cfset Session.Ancillary = ''>
            </cfif>
            <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
            <cfset qgetAncillaryData=Application.Stranding.getAncillaryData("#form.AD_ID#")>
            <cfset qLCEDataa=Application.Stranding.getAncillaryData("#form.AD_ID#")>
            <cfset qgetcetaceanDate=Application.Stranding.getAncillaryDiagnosticsNecropsyDate(#form.AD_ID#)>
            <cfif #qgetAncillaryData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetAncillaryData.species#")>
            </cfif>
            <cfset qAncillaryReportGet=Application.Stranding.AncillaryReportGet("#form.AD_ID#")>
        </cfif>

        <cfif isDefined('Session.Ancillary') and Session.Ancillary NEQ ''> 
            <cfset form.AD_ID = #Session.Ancillary#>
            <cfset qgetAncillaryData=Application.Stranding.getAncillaryData("#form.AD_ID#")>
            <!--- <cfset qLCEDataa=Application.Stranding.getAncillaryData("#form.AD_ID#")> --->
            <cfset qgetcetaceanDate=Application.Stranding.getAncillaryDiagnosticsNecropsyDate(#form.AD_ID#)>
            <cfif #qgetAncillaryData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetAncillaryData.species#")>
            </cfif>
            <cfset qAncillaryReportGet=Application.Stranding.AncillaryReportGet("#form.AD_ID#")>
        </cfif>
        <!---  setup empty form when directly clicked the HI link from side bar --->
        <!--- <cfif url.LCE_ID eq 0 AND Not isDefined('form.AD_ID')>
            <cfset qgetHIData=Application.Stranding.getAncillary_ten()>
            <!---  setup empty form when when entering new record --->
        <cfelseif  isDefined('form.AD_ID') AND form.AD_ID eq "">
            <cfset qgetHIData=Application.Stranding.getAncillary_ten()>
        </cfif> --->
        <!---  get all records order by ID DESC--->
        <cfset getAnclillaryID=Application.Stranding.getAncillaryID()>
        <!---  get all records order by Date Desc --->
        <cfset qgetAnclillaryDate=Application.Stranding.getAncillaryDate()>
        <!---  get all records order by Field Numbert Desc --->
        <cfset qgetAnclillaryFBNumber=Application.Stranding.getAncillaryBNumber()>


        

        <!--- end for AncillaryDiagnostics --->

    <!--- start for SampleArchive --->
    <cfset StorageTypeArray = ['Room Temperature','-80 C','-20 C','-20 F','Refrigerated']>
    <cfset ThawedArray = ['Yes','No','Partial']>
    <cfset Availbility = ['Full Sample','Partial Sample','No Sample','No Sample Available']>
    <!--- <cfset qgetSampleType=Application.StaticDataNew.getSampleType()> --->
    <cfset qgetSampleLocation=Application.StaticDataNew.getSampleLocation()>
    <cfset qgetSampleTracking=Application.StaticDataNew.getSampleTracking()>
    <cfset qgetBinNumber=Application.StaticDataNew.getBinNumber()>
    <cfset qgetUnitofsample=Application.StaticDataNew.getUnitofsample()>
    <cfset qgetPreservationMethod=Application.StaticDataNew.getPreservationMethod()>

    <cfif isDefined('SaveAndNewSampleArchive') OR isDefined('SaveAndClose')>
        <!--- <cfset form.check = "1"> --->
        <!--- <cfdump var="#form#" abort="true"> --->
        <cfif isDefined('form.SEID') and form.SEID neq "">
            <!--- <cfset form.SEID = "#SA_ID#"> --->
            <cfset Application.Stranding.SampleArchiveUpdate(argumentCollection="#Form#")>
            <cfset form.SA_ID = "#form.SEID#">
            <cfif form.ST_ID neq "" AND form.ST_ID neq "0">
                <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")>
                <cfif form.SADate neq "">
                    <cfset Application.Stranding.InsertSampleData(argumentCollection="#Form#")>
                </cfif>
            <cfelse>
                <cfset ST_ID = Application.Stranding.SampleTypeInsert(argumentCollection="#Form#")>
                <cfset form.ST_ID = "#ST_ID#">
                <cfif form.SADate neq "">
                    <cfset Application.Stranding.InsertSampleData(argumentCollection="#Form#")>
                </cfif>
            </cfif>
        <cfelse>
            <cfset SA_ID = Application.Stranding.SampleArchiveInsert(argumentCollection="#Form#")>
            <cfset Session.SampleArchive = #SA_ID#>
            <!--- <cfdump var="#SA_ID#" abort="true"> --->
            <cfset form.SA_ID = "#SA_ID#">
            <cfset form.SEID = "#SA_ID#">
            <cfif form.SampleID neq "">
                <cfset ST_ID = Application.Stranding.SampleTypeInsert(argumentCollection="#Form#")>
                <cfset form.ST_ID = "#ST_ID#">
                <cfif form.SADate neq "">
                    <cfset Application.Stranding.InsertSampleData(argumentCollection="#Form#")>
                </cfif>
            </cfif>
           
        </cfif>
    <cfelseif isDefined('deleteSampleAechive')>
        <!--- <cfdump var="#form.SEID#" abort="true"> --->
        <cfset Application.Stranding.DeleteSampleType("#form.SEID#")>
        <!--- <cfset form.STID = ""> --->
    <cfelseif isDefined('deleteallSampleArchiveRecord')>
        <cfset Application.Stranding.deleteallSampleArchiveRecord()>
        <!--- <cfset form.STID = ""> --->
    </cfif>

    <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->   
    <!--- <cfif url.LCE_ID neq 0>
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getSampleDataByLCE("#form.LCEID#")>
        <cfset qgetSampleData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
        <cfset qgetSampleDetailData = Application.Stranding.getSampleDetailDataSingle(STID="#form.LCEID#")>
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.SEID = neworexist.ID>
        </cfif>
    </cfif> --->


    <!---   getting data on the basis of LCEID  --->
    <cfif  isDefined('form.SEID') and form.SEID neq "">
        <cfif Session.SampleArchive NEQ form.SEID>
        <cfset Session.SampleArchive = ''>
        </cfif>
        <cfset qgetSampleData=Application.Stranding.getSampleArchiveData("#form.SEID#")>
        <cfset qLCEDataa=Application.Stranding.getSampleArchiveData("#form.SEID#")>
        <cfif #qgetSampleData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetSampleData.species#")>
        </cfif>
        <cfset qgetSampleList=Application.Stranding.getSampleList("#form.SEID#")>
        <cfset qgetSampleFBNumberList=Application.Stranding.getSampleFBNumberList("#form.SEID#")>
        
        <!---  get all records order by ID  Desc of SampleType agianst SEID--->
        <cfset qgetSampleTypeIByID=Application.Stranding.getSampleTypeIByID("#form.SEID#")>
        <cfif  isDefined('form.STID') and form.STID neq "">
            
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleTypeDataSingle("#form.STID#")>
            <cfset qgetSampleDetailData = Application.Stranding.getSampleDetailDataSingle("#form.STID#")>
        <cfelse>
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleType_ten()>
        </cfif>
        <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate(#form.SEID#)>
        <!--- <cfdump var="#qgetcetaceanDate.CNRDATE#" abort="true">/ --->
    <cfelse>
        <cfset qgetSampleTypeIByID=Application.Stranding.getSampleType_ten()>
        <cfset qgetSampleTypeDataSingle = #qgetSampleTypeIByID#>
    </cfif>
    
    <cfif isDefined('Session.SampleArchive') and Session.SampleArchive NEQ ''> 
        <cfset form.SEID = #Session.SampleArchive#>

        <cfset qgetSampleData=Application.Stranding.getSampleArchiveData("#form.SEID#")>
        <!--- <cfset qLCEDataa=Application.Stranding.getSampleArchiveData("#form.SEID#")> --->
        <cfif #qgetSampleData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetSampleData.species#")>
        </cfif>
        <cfset qgetSampleList=Application.Stranding.getSampleList("#form.SEID#")>
        <cfset qgetSampleFBNumberList=Application.Stranding.getSampleFBNumberList("#form.SEID#")>
        
        <!---  get all records order by ID  Desc of SampleType agianst SEID--->
        <cfset qgetSampleTypeIByID=Application.Stranding.getSampleTypeIByID("#form.SEID#")>
        <cfif  isDefined('form.STID') and form.STID neq "">
            
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleTypeDataSingle("#form.STID#")>
            <cfset qgetSampleDetailData = Application.Stranding.getSampleDetailDataSingle("#form.STID#")>
        <cfelse>
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleType_ten()>
        </cfif>
        <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate(#form.SEID#)>
    </cfif>


    <!---  setup empty form when directly clicked the HI link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.SEID')>
        <cfset qgetSampleData=Application.Stranding.getSampleArchive_ten()>
        <!--- <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate_ten()> --->
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.SEID') AND form.SEID eq "">
        <cfset qgetSampleData=Application.Stranding.getSampleArchive_ten()>
    </cfif>

           <!---  get all records order by ID DESC--->
    <cfset getSampleID=Application.Stranding.getSampleArchiveID()>
    <cfset getmaindate=Application.Stranding.getmaindate()>
    <!---  get all records order by Date Desc --->
    <cfset qgetSampleDate=Application.Stranding.getSampleArchiveDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetSampleFBNumber=Application.Stranding.getSampleArchiveFBNumber()>


   
    <!--- end for SampleArchive --->
   

    <cfif structKeyExists(form, "CetaceansampleFile") and len(form.CetaceansampleFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="CetaceansampleFile" result="upload" nameconflict="makeunique">
        <!--- <cfdump var="#upload#"><cfabort> --->
        <cfif upload.fileWasSaved>
            <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
            <cfif isSpreadsheetFile(theFile)>
                <cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
                <cfset showForm = false>
            <cfelse>
                <cfset errors = "The file was not an Excel file.">
                <cfset showForm = true>
            </cfif>
        <cfelse>
            <cfset errors = "The file was not properly uploaded.">	
        </cfif>
        <cfif showForm>
            <div  class="container"  role="alert" id="notify">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <cfif structKeyExists(variables, "errors")>
                            <cfoutput>
                            <h3 style="padding-left: 111px;">
                            <b>Error: #variables.errors#</b>
                            </h3>
                            </cfoutput>
                        </cfif>  
                    </div>
                </div>
            </div>
        <cfelse>
        
            <cfif data.recordCount is 1>
                <p>
                This spreadsheet appeared to have no data.
                </p>
            <cfelse>
                
                <!--- <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")> --->
                <cfset colNameArray = data.getColumnNames() />
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'NMFS Regional ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "NMFS Regional #" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'National Database ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "National Database ##" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Species') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Species" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Veterinarian') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Veterinarian" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Team Members') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Team Members" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Stranding Agreement or Authority') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Stranding Agreement or Authority" ');
                    </script>
                <!--- <cfelseif arrayContains(colNameArray, 'Restrand') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Restrand" ');
                    </script>
                 <cfelseif arrayContains(colNameArray, 'Group Event') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Group Event" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Number of Animals') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Number of Animals" ');
                    </script> --->
                 <cfelseif arrayContains(colNameArray, 'Sex') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sex" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Age Class') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Age Class" ');
                    </script>  
                <cfelseif arrayContains(colNameArray, 'County') eq false>
                    <script>
                        alert('The Column name in the sheet should be "County" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lat') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lat" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lon') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lon" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Body of Water') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Body of Water" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Brief History') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Brief History" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('##','') />
                    </cfloop>
                    <cfset data.setColumnNames(colNameArray) />


                    <cfoutput query="data" startRow="2">
                        <!--- for Veterinarian --->
                       <cfset myarray=[] >
                        <cfloop from="1" to="#ListLen(data.Veterinarian)#" index="i">
                            <cfset VeterinarianDat = '#data.Veterinarian#'>
                            <cfset VeterinarianData = VeterinarianDat.replaceAll(', ',',') />
                        <!--- store query for insert data in master table --->
                            <cfset convertedData =listToArray(VeterinarianData,",",false,true) >

                            <cfquery name="qgetdata1" datasource="#Application.dsn#" result="getData">
                                SELECT Veterinarians FROM TLU_Veterinarians
                                WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                            </cfquery> 
                            <cfset veterian = '#qgetdata1.Veterinarians#' >
                        <!--- <cfdump var="#veterian#" abort="true"> --->
                            <cfif veterian eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_Veterinarians
                                        (
                                        Veterinarians
                                        ,status
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetdata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_Veterinarians
                            WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(myarray, qgetdata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedList=myarray.toList() >

                        <!--- for teamMember --->

                        <cfset teamMemberArray=[] >
                        <cfloop from="1" to="#ListLen(data.TeamMembers)#" index="i">
                            <cfset TeamMemberDat = '#data.TeamMembers#'>
                            <cfset TeamMemberData = TeamMemberDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedTeamData =listToArray(TeamMemberData,",",false,true) >

                            <cfquery name="qgetTeamData" datasource="#Application.dsn#" result="getData">
                                SELECT RT_MemberName FROM TLU_ResearchTeamMembers
                                WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                            </cfquery> 
                            <cfset team = '#qgetTeamData.RT_MemberName#' >
                        <!--- <cfdump var="#team#" abort="true"> --->
                            <cfif team eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_ResearchTeamMembers
                                        (
                                        RT_MemberName
                                        ,active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedTeamData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetTeamdata" datasource="#Application.dsn#" >
                            SELECT RT_ID FROM TLU_ResearchTeamMembers
                            WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(teamMemberArray, qgetTeamdata.RT_ID ,"true") >
                        </cfloop>
                        <cfset myConvertedTeamList=teamMemberArray.toList() >

                        <!--- for Water of body --->
                        
                        <cfset waterOfBodyArray=[] >
                        <cfloop from="1" to="#ListLen(data.BodyofWater)#" index="i">
                            <cfset BodyofWaterDat = '#data.BodyofWater#'>
                            <cfset BodyofWaterData = BodyofWaterDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedWaterOfBodyData =listToArray(BodyofWaterData,",",false,true) >

                            <cfquery name="qgetWaterBodydata" datasource="#Application.dsn#" result="getData">
                                SELECT AreaName FROM TLU_SurveyArea
                                WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                            </cfquery> 
                            <cfset waterOFBody = '#qgetWaterBodydata.AreaName#' >
                        <!--- <cfdump var="#waterOFBody#" abort="true"> --->
                            <cfif waterOFBody eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_SurveyArea
                                        (
                                        AreaName
                                        ,Active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedWaterOfBodyData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetWaterOfBodydata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_SurveyArea
                            WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(waterOfBodyArray, qgetWaterOfBodydata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedWatarList=waterOfBodyArray.toList() >
                        <!--- teamMember end --->
            <!--- for species --->

                        <cfset speciesData = '#data.Species#'> 
    
                        <cfquery name="qgetSpeciesData" datasource="#Application.dsn#" result="getData">
                            SELECT CetaceanSpeciesName FROM TLU_CetaceanSpecies
                            WHERE CetaceanSpeciesName ='#speciesData#'                         
                        </cfquery> 
                        <cfset team = '#qgetSpeciesData.CetaceanSpeciesName#'>
                    <!--- <cfdump var="#team#" abort="true"> --->
                        <cfif team eq ''>
                            <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                INSERT INTO TLU_CetaceanSpecies
                                    (
                                    CetaceanSpeciesName
                                    ,Active
                                    ) 
                                    VALUES
                                    (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#speciesData#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                    )
                            </cfquery>
                        </cfif>
                    <cfquery name="qgetSpeciesdata" datasource="#Application.dsn#" >
                        SELECT ID FROM TLU_CetaceanSpecies
                        WHERE CetaceanSpeciesName ='#speciesData#'                         
                    </cfquery> 
                                    
            <!--- end for species --->

                        <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_LiveCetaceanExam
                            (
                            Fnumber
                            ,date
                            ,NMFS
                            ,NDB
                            ,species
                            ,Veterinarian
                            ,ResearchTeam
                            ,NAA
                            ,sex
                            ,ageClass
                            ,county
                            ,lat
                            ,lon
                            ,BodyOfWater
                            ,Location
                            ,BriefHistory                            
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NMFSRegional#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NationalDatabase#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qgetSpeciesdata.ID#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedTeamList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.StrandingAgreementorAuthority#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Sex#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AgeClass#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.County#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lat#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lon#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedWatarList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.BriefHistory#'>
                                                       
                            )
                        </cfquery>

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
     <!--- import for HI --->
     <cfif structKeyExists(form, "HIsampleFile") and len(form.HIsampleFile)>
        <cfset dest = getTempDirectory()>
        <!--- <cfdump var="#isSpreadsheetFile(sampleFile)#"><cfabort> --->
        <cffile action="upload" destination="#dest#" filefield="HIsampleFile" result="upload" nameconflict="makeunique">
        <!--- <cfdump var="#upload#"><cfabort> --->
        <cfif upload.fileWasSaved>
            <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
            <cfif isSpreadsheetFile(theFile)>
                <cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
                <cfset showForm = false>
            <cfelse>
                <cfset errors = "The file was not an Excel file.">
                <cfset showForm = true>
            </cfif>
        <cfelse>
            <cfset errors = "The file was not properly uploaded.">	
        </cfif>
        <cfif showForm>
            <div  class="container"  role="alert" id="notify">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <cfif structKeyExists(variables, "errors")>
                            <cfoutput>
                            <h3 style="padding-left: 111px;">
                            <b>Error: #variables.errors#</b>
                            </h3>
                            </cfoutput>
                        </cfif>  
                    </div>
                </div>
            </div>
        <cfelse>
        
            <cfif data.recordCount is 1>
                <p>
                This spreadsheet appeared to have no data.
                </p>
            <cfelse>
                
                <!--- <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")> --->
                <cfset colNameArray = data.getColumnNames() />
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'NMFS Regional ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "NMFS Regional #" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'National Database ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "National Database ##" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Species') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Species" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Veterinarian') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Veterinarian" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Team Members') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Team Members" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Stranding Agreement or Authority') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Stranding Agreement or Authority" ');
                    </script>
                <!--- <cfelseif arrayContains(colNameArray, 'Restrand') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Restrand" ');
                    </script>
                 <cfelseif arrayContains(colNameArray, 'Group Event') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Group Event" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Number of Animals') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Number of Animals" ');
                    </script> --->
                 <cfelseif arrayContains(colNameArray, 'Sex') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sex" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Age Class') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Age Class" ');
                    </script>  
                <cfelseif arrayContains(colNameArray, 'County') eq false>
                    <script>
                        alert('The Column name in the sheet should be "County" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lat') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lat" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lon') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lon" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Body of Water') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Body of Water" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Brief History') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Brief History" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('##','') />
                    </cfloop>
                    <cfset data.setColumnNames(colNameArray) />

                    <!--- <cfdump var="#data#"abort="true"> --->

                    <cfoutput query="data" startRow="2">
                        <!--- for Veterinarian --->
                       <cfset myarray=[] >
                        <cfloop from="1" to="#ListLen(data.Veterinarian)#" index="i">
                            <cfset VeterinarianDat = '#data.Veterinarian#'>
                            <cfset VeterinarianData = VeterinarianDat.replaceAll(', ',',') />
                        <!--- store query for insert data in master table --->
                            <cfset convertedData =listToArray(VeterinarianData,",",false,true) >

                            <cfquery name="qgetdata1" datasource="#Application.dsn#" result="getData">
                                SELECT Veterinarians FROM TLU_Veterinarians
                                WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                            </cfquery> 
                            <cfset veterian = '#qgetdata1.Veterinarians#' >
                        <!--- <cfdump var="#veterian#" abort="true"> --->
                            <cfif veterian eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_Veterinarians
                                        (
                                        Veterinarians
                                        ,status
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetdata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_Veterinarians
                            WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(myarray, qgetdata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedList=myarray.toList() >

                        <!--- for teamMember --->

                        <cfset teamMemberArray=[] >
                        <cfloop from="1" to="#ListLen(data.TeamMembers)#" index="i">
                            <cfset TeamMemberDat = '#data.TeamMembers#'>
                            <cfset TeamMemberData = TeamMemberDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedTeamData =listToArray(TeamMemberData,",",false,true) >

                            <cfquery name="qgetTeamData" datasource="#Application.dsn#" result="getData">
                                SELECT RT_MemberName FROM TLU_ResearchTeamMembers
                                WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                            </cfquery> 
                            <cfset team = '#qgetTeamData.RT_MemberName#' >
                        <!--- <cfdump var="#team#" abort="true"> --->
                            <cfif team eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_ResearchTeamMembers
                                        (
                                        RT_MemberName
                                        ,active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedTeamData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetTeamdata" datasource="#Application.dsn#" >
                            SELECT RT_ID FROM TLU_ResearchTeamMembers
                            WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(teamMemberArray, qgetTeamdata.RT_ID ,"true") >
                        </cfloop>
                        <cfset myConvertedTeamList=teamMemberArray.toList() >

                        <!--- for Water of body --->
                        
                        <cfset waterOfBodyArray=[] >
                        <cfloop from="1" to="#ListLen(data.BodyofWater)#" index="i">
                            <cfset BodyofWaterDat = '#data.BodyofWater#'>
                            <cfset BodyofWaterData = BodyofWaterDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedWaterOfBodyData =listToArray(BodyofWaterData,",",false,true) >

                            <cfquery name="qgetWaterBodydata" datasource="#Application.dsn#" result="getData">
                                SELECT AreaName FROM TLU_SurveyArea
                                WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                            </cfquery> 
                            <cfset waterOFBody = '#qgetWaterBodydata.AreaName#' >
                        <!--- <cfdump var="#waterOFBody#" abort="true"> --->
                            <cfif waterOFBody eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_SurveyArea
                                        (
                                        AreaName
                                        ,Active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedWaterOfBodyData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetWaterOfBodydata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_SurveyArea
                            WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(waterOfBodyArray, qgetWaterOfBodydata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedWatarList=waterOfBodyArray.toList() >
                        <!--- teamMember end --->
            <!--- for species --->

                        <cfset speciesData = '#data.Species#'> 
    
                        <cfquery name="qgetSpeciesData" datasource="#Application.dsn#" result="getData">
                            SELECT CetaceanSpeciesName FROM TLU_CetaceanSpecies
                            WHERE CetaceanSpeciesName ='#speciesData#'                         
                        </cfquery> 
                        <cfset team = '#qgetSpeciesData.CetaceanSpeciesName#'>
                    <!--- <cfdump var="#team#" abort="true"> --->
                        <cfif team eq ''>
                            <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                INSERT INTO TLU_CetaceanSpecies
                                    (
                                    CetaceanSpeciesName
                                    ,Active
                                    ) 
                                    VALUES
                                    (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#speciesData#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                    )
                            </cfquery>
                        </cfif>
                    <cfquery name="qgetSpeciesdata" datasource="#Application.dsn#" >
                        SELECT ID FROM TLU_CetaceanSpecies
                        WHERE CetaceanSpeciesName ='#speciesData#'                         
                    </cfquery> 
                                    
            <!--- end for species --->

                        <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_HIForm
                            (
                            Fnumber
                            ,date
                            ,NMFS
                            ,NDB
                            ,species
                            ,Veterinarian
                            ,ResearchTeam
                            ,NAA
                            ,sex
                            ,ageClass
                            ,county
                            ,lat
                            ,lon
                            ,BodyOfWater
                            ,Location
                            ,BriefHistory
                            ,LCE_ID                            
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NMFSRegional#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NationalDatabase#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qgetSpeciesdata.ID#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedTeamList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.StrandingAgreementorAuthority#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Sex#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AgeClass#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.County#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lat#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lon#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedWatarList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.BriefHistory#'>
                            ,<cfqueryparam  value='0'>                           
                            )
                        </cfquery>

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
    <!--- end --->
     <!--- import for Level A Form --->
     <cfif structKeyExists(form, "LevelAsampleFile") and len(form.LevelAsampleFile)>
        <cfset dest = getTempDirectory()>
        <!--- <cfdump var="#isSpreadsheetFile(sampleFile)#"><cfabort> --->
        <cffile action="upload" destination="#dest#" filefield="LevelAsampleFile" result="upload" nameconflict="makeunique">
        <!--- <cfdump var="#upload#"><cfabort> --->
        <cfif upload.fileWasSaved>
            <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
            <cfif isSpreadsheetFile(theFile)>
                <cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
                <cfset showForm = false>
            <cfelse>
                <cfset errors = "The file was not an Excel file.">
                <cfset showForm = true>
            </cfif>
        <cfelse>
            <cfset errors = "The file was not properly uploaded.">	
        </cfif>
        <cfif showForm>
            <div  class="container"  role="alert" id="notify">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <cfif structKeyExists(variables, "errors")>
                            <cfoutput>
                            <h3 style="padding-left: 111px;">
                            <b>Error: #variables.errors#</b>
                            </h3>
                            </cfoutput>
                        </cfif>  
                    </div>
                </div>
            </div>
        <cfelse>
        
            <cfif data.recordCount is 1>
                <p>
                This spreadsheet appeared to have no data.
                </p>
            <cfelse>
                
                <!--- <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")> --->
                <cfset colNameArray = data.getColumnNames() />
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'NMFS Regional ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "NMFS Regional #" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'National Database ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "National Database ##" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Species') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Species" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Veterinarian') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Veterinarian" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Team Members') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Team Members" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Stranding Agreement or Authority') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Stranding Agreement or Authority" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Restrand') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Restrand" ');
                    </script>
                 <cfelseif arrayContains(colNameArray, 'Group Event') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Group Event" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Number of Animals') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Number of Animals" ');
                    </script>
                 <cfelseif arrayContains(colNameArray, 'Sex') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sex" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Age Class') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Age Class" ');
                    </script>  
                <cfelseif arrayContains(colNameArray, 'County') eq false>
                    <script>
                        alert('The Column name in the sheet should be "County" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lat') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lat" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lon') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lon" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Body of Water') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Body of Water" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Brief History') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Brief History" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('##','') />
                    </cfloop>
                    <cfset data.setColumnNames(colNameArray) />

                    <!--- <cfdump var="#data#"abort="true"> --->

                    <cfoutput query="data" startRow="2">
                        <!--- for Veterinarian --->
                       <cfset myarray=[] >
                        <cfloop from="1" to="#ListLen(data.Veterinarian)#" index="i">
                            <cfset VeterinarianDat = '#data.Veterinarian#'>
                            <cfset VeterinarianData = VeterinarianDat.replaceAll(', ',',') />
                        <!--- store query for insert data in master table --->
                            <cfset convertedData =listToArray(VeterinarianData,",",false,true) >

                            <cfquery name="qgetdata1" datasource="#Application.dsn#" result="getData">
                                SELECT Veterinarians FROM TLU_Veterinarians
                                WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                            </cfquery> 
                            <cfset veterian = '#qgetdata1.Veterinarians#' >
                        <!--- <cfdump var="#veterian#" abort="true"> --->
                            <cfif veterian eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_Veterinarians
                                        (
                                        Veterinarians
                                        ,status
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetdata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_Veterinarians
                            WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(myarray, qgetdata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedList=myarray.toList() >

                        <!--- for teamMember --->

                        <cfset teamMemberArray=[] >
                        <cfloop from="1" to="#ListLen(data.TeamMembers)#" index="i">
                            <cfset TeamMemberDat = '#data.TeamMembers#'>
                            <cfset TeamMemberData = TeamMemberDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedTeamData =listToArray(TeamMemberData,",",false,true) >

                            <cfquery name="qgetTeamData" datasource="#Application.dsn#" result="getData">
                                SELECT RT_MemberName FROM TLU_ResearchTeamMembers
                                WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                            </cfquery> 
                            <cfset team = '#qgetTeamData.RT_MemberName#' >
                        <!--- <cfdump var="#team#" abort="true"> --->
                            <cfif team eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_ResearchTeamMembers
                                        (
                                        RT_MemberName
                                        ,active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedTeamData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetTeamdata" datasource="#Application.dsn#" >
                            SELECT RT_ID FROM TLU_ResearchTeamMembers
                            WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(teamMemberArray, qgetTeamdata.RT_ID ,"true") >
                        </cfloop>
                        <cfset myConvertedTeamList=teamMemberArray.toList() >

                        <!--- for Water of body --->
                        
                        <cfset waterOfBodyArray=[] >
                        <cfloop from="1" to="#ListLen(data.BodyofWater)#" index="i">
                            <cfset BodyofWaterDat = '#data.BodyofWater#'>
                            <cfset BodyofWaterData = BodyofWaterDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedWaterOfBodyData =listToArray(BodyofWaterData,",",false,true) >

                            <cfquery name="qgetWaterBodydata" datasource="#Application.dsn#" result="getData">
                                SELECT AreaName FROM TLU_SurveyArea
                                WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                            </cfquery> 
                            <cfset waterOFBody = '#qgetWaterBodydata.AreaName#' >
                        <!--- <cfdump var="#waterOFBody#" abort="true"> --->
                            <cfif waterOFBody eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_SurveyArea
                                        (
                                        AreaName
                                        ,Active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedWaterOfBodyData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetWaterOfBodydata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_SurveyArea
                            WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(waterOfBodyArray, qgetWaterOfBodydata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedWatarList=waterOfBodyArray.toList() >
                        <!--- teamMember end --->
            <!--- for species --->

                        <cfset speciesData = '#data.Species#'> 
    
                        <cfquery name="qgetSpeciesData" datasource="#Application.dsn#" result="getData">
                            SELECT CetaceanSpeciesName FROM TLU_CetaceanSpecies
                            WHERE CetaceanSpeciesName ='#speciesData#'                         
                        </cfquery> 
                        <cfset team = '#qgetSpeciesData.CetaceanSpeciesName#'>
                    <!--- <cfdump var="#team#" abort="true"> --->
                        <cfif team eq ''>
                            <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                INSERT INTO TLU_CetaceanSpecies
                                    (
                                    CetaceanSpeciesName
                                    ,Active
                                    ) 
                                    VALUES
                                    (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#speciesData#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                    )
                            </cfquery>
                        </cfif>
                    <cfquery name="qgetSpeciesdata" datasource="#Application.dsn#" >
                        SELECT ID FROM TLU_CetaceanSpecies
                        WHERE CetaceanSpeciesName ='#speciesData#'                         
                    </cfquery> 
                                    
            <!--- end for species --->

                        <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_LevelAForm
                            (
                            Fnumber
                            ,date
                            ,NMFS
                            ,NDB
                            ,species
                            ,Veterinarian
                            ,ResearchTeam
                            ,NAA
                            ,Restrand
                            ,GroupEvent
                            ,noOfAnimals
                            ,sex
                            ,ageClass
                            ,county
                            ,lat
                            ,lon
                            ,BodyOfWater
                            ,Location
                            ,BriefHistory       
                            ,LCE_ID                      
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NMFSRegional#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NationalDatabase#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qgetSpeciesdata.ID#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedTeamList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.StrandingAgreementorAuthority#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Restrand#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GroupEvent#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NumberofAnimals#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Sex#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AgeClass#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.County#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lat#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lon#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedWatarList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.BriefHistory#'>
                            ,<cfqueryparam  value='0'>                          
                            )
                        </cfquery>

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
    <!--- end --->
     <!--- import for sample archive --->
     <cfif structKeyExists(form, "sampleFile") and len(form.sampleFile)>
        <cfset dest = getTempDirectory()>
        <!--- <cfdump var="#isSpreadsheetFile(sampleFile)#"><cfabort> --->
        <cffile action="upload" destination="#dest#" filefield="sampleFile" result="upload" nameconflict="makeunique">
        <!--- <cfdump var="#upload#"><cfabort> --->
        <cfif upload.fileWasSaved>
            <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
            <cfif isSpreadsheetFile(theFile)>
                <cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
                <cfset showForm = false>
            <cfelse>
                <cfset errors = "The file was not an Excel file.">
                <cfset showForm = true>
            </cfif>
        <cfelse>
            <cfset errors = "The file was not properly uploaded.">	
        </cfif>
        <cfif showForm>
            <div  class="container"  role="alert" id="notify">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <cfif structKeyExists(variables, "errors")>
                            <cfoutput>
                            <h3 style="padding-left: 111px;">
                            <b>Error: #variables.errors#</b>
                            </h3>
                            </cfoutput>
                        </cfif>  
                    </div>
                </div>
            </div>
        <cfelse>
        
            <cfif data.recordCount is 1>
                <p>
                This spreadsheet appeared to have no data.
                </p>
            <cfelse>

                <!--- <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")> --->
                <cfset colNameArray = data.getColumnNames() />
                <cfif arrayContains(colNameArray, 'Sample ID') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sample ID" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Tissue Type') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Tissue Type" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Preservation Method') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Preservation Method" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Sample Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sample Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Storage Type') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Storage Type" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Bin Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Bin Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date2') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date2" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location 2') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location 2" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Subsampled') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Subsampled" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Subsample Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Subsample Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date3') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date3" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location3') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location3" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Thaw') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Thaw" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace(' ','') />
                    </cfloop>
                    <cfset data.setColumnNames(colNameArray) />
                   
                    <cfoutput query="data" startRow="2">

                        <cfquery name="qcheckFilesampleArchive" datasource="#Application.dsn#">
                            SELECT ID,Fnumber,date FROM ST_SampleArchive
                            WHERE Fnumber ='#data.FieldNumber#'  
                            
                        </cfquery>
                        <!--- <cfoutput>#qcheckFilesampleArchive.recordCount#</cfoutput> --->
                       
                        <cfif qcheckFilesampleArchive.recordCount gt 0>
                            <cfset SA_ID = "#qcheckFilesampleArchive.ID#">
                        <cfelse>
                            <cfquery name="qinsertFilesampleArchive" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_SampleArchive
                                (
                                    Fnumber
                                    
                                )
                                VALUES
                                (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                                    
                                )
                            </cfquery>
                            <cfset SA_ID = "#return_data.generatedkey#">
                        </cfif>
                        <cfquery name="qcheckFilesampleType" datasource="#Application.dsn#">
                            SELECT ID,SampleID FROM ST_SampleType
                            WHERE SampleID ='#data.SampleID#' and SampleType = '#data.TissueType#' and SA_ID = #SA_ID#
                        </cfquery>
                        <cfif qcheckFilesampleType.recordCount gt 0>
                            <cfset ST_ID = "#qcheckFilesampleType.ID#">
                        <cfelse>   
                            <!--- <cfquery name="qcheckEMptySampleIDs" datasource="#Application.dsn#">
                                SELECT ID,SampleID FROM ST_SampleType
                                WHERE SampleID ='Not Available'  and SampleType = '#data.TissueType#' and SA_ID = #SA_ID#
                            </cfquery> --->
                            <!--- <cfif qcheckEMptySampleIDs.recordCount eq 0> --->
                                <cfif data.SampleID eq "">
                                    <cfset Sid = "Not Available">
                                <cfelse>
                                    <cfset Sid = "#data.SampleID#">
                                </cfif>
                                <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                    INSERT INTO ST_SampleType
                                    (
                                    SampleID
                                    ,PreservationMethod
                                    ,SampleComments
                                    ,StorageType
                                    ,Sample_Location
                                    ,BinNumber
                                    ,SampleType
                                    ,Sample_Date
                                    ,maindate
                                    ,SA_ID
                                    ) 
                                    VALUES
                                    (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#Sid#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.PreservationMethod#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.SampleComments#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.StorageType#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BinNumber#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TissueType#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date2#' null="#IIF(Date2 EQ "", true, false)#">
                                    ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.Date#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_BIGINT" value='#SA_ID#'>
                                    )
                                </cfquery>
                                <cfset ST_ID = "#return_data.generatedkey#">
                                <cfquery name="qinsertFilesampleDetail" datasource="#Application.dsn#" result="return_data">
                                    Insert into ST_SampleDetail
                                    (
                                        SADate
                                        ,SampleLocation
                                        ,subsampleDate
                                        ,Thawed
                                        ,subsampled
                                        ,ST_ID
                                    )
                                    VALUES
                                    (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date3#' null="#IIF(Date3 EQ "", true, false)#">
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location2#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.SubsampleDate#' null="#IIF(SubsampleDate EQ "", true, false)#">
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Thaw#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Subsampled#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_BIGINT" value='#ST_ID#'>
                                    )
                                </cfquery>
                                <cfset count = 2>
                                <cfif isDefined('data.Location#count++#') AND evaluate('data.Location#count++#') neq "">
                                    <cfquery name="qinsertFilesampleDetail" datasource="#Application.dsn#" result="return_data">
                                        Insert into ST_SampleDetail
                                        (
                                            SADate
                                            ,SampleLocation
                                            ,subsampleDate
                                            ,Thawed
                                            ,subsampled
                                            ,ST_ID
                                        )
                                        VALUES
                                        (
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date3#' null="#IIF(Date3 EQ "", true, false)#">
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location3#'>
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.SubsampleDate#' null="#IIF(SubsampleDate EQ "", true, false)#">
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Thaw#'>
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Subsampled#'>
                                            ,<cfqueryparam cfsqltype="cf_sql_BIGINT" value='#ST_ID#'>
                                        )
                                    </cfquery>
                                </cfif>
                            <!--- </cfif> --->
                        </cfif>    
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
    <!--- end --->

    <!--- start for necropsy --->
    <!--- getting all fieldnumbers from stranding sections --->
    <!--- <cfset qgetallfieldnumber=application.Stranding.getallfieldnumber()> --->
    <cfset Skeletal_Findingss= ['No Findings','Fractures','Dislocation','Avulsions','Deformities','Other- Note Location in Comments']>
    <!--- <cfset Conditionsss = ['Fresh Dead', 'Moderate Decomposition' ,'Advanced Decomposition','Mummified']> --->
    <cfset Condition_at_Necropsy = ['Fresh Dead','Moderate Decomposition','Advanced Decomposition','Mummified']>
    <cfset Animal_Renderings = ['Buried On Site','Towed Offshore','Burried and Towed Offshore','Landfill']>
    <cfset Fat_Blubber = ['Abundant - No Atrophy','Mild to Moderate Atrophy','Severe Atrophy','NE']>
    <cfset Eye_Finding = ['No Findings','Cloudy','Bloody','Predated','Present']>
    <cfset Joint_Fluid = ['No Findings','Cloudy - Solid Material','Bloody']>
    <cfset Muscle_Status = ['Well Muscled - No Atropy','Mild to Modrate Atropy','Severe Atropy','NE']>
    <cfset Musculature_Findings= ['No Findings','Trauma','Hemorrhage','Pallor','Necrosis','Other']>
    <cfset Lining= ['No Findings','Masess','Hemorrhage','Adhesions','Other']>
    <cfset Biliary_Findings= ['No Findings','Gall Bladder thickened','Bile Ducts thickened','Ulcer','Exudate','Stones','Other']>
    <cfset Pericardial_Fluid= ['No Findings','Cloudy/Solid Material','Blood-tinged','Blood clots','Fibrin','Other']>
    <cfset Overall_Findings= ['None','Trauma','Endocarditis-Arteritis','Blood clots','Vessels thickened','Adhesions','Other']>
    <cfset Color_of_Foam= ['White','Pink','Red','Tan','Yellow','Green','Other']>
    <cfset Trachea_Bronchi= ['No Findings','Exudate','Masses','Ulceration','Other']>
    <cfset Kidneys_Findings= ['No Findings','Trauma','Enlarged','Masses','Parasites','Other']>
    <cfset brain_Findings= ['No Findings','Trauma','Congestion','Hemorrhage','Necrosis','Exudate','Possible Parasite Ova','Not Examed','Partial Examed','Other']>
    <cfset material_type= ['Hook','Line','Hard Plastic','Plastic Bags','Misc Soft Plastic','Ballon','Other']>
    <cfset Spinal_Cord= ['No Findings','Trauma','Hemorrhage','Necrosis','Exudate','Possible Parasite Ova','Not Examed','Partial Examed','Other']>
    <cfset qgetNxLocation= Application.StaticDataNew.getNxLocation()>
    <!--- <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()> --->
    <!--- <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()> --->
    <cfset qgetLiverFinding= Application.StaticDataNew.getLiverFinding()>
    <cfset qgetLungFinding= Application.StaticDataNew.getLungFinding()>
    <cfset qgetParasiteLocation= Application.StaticDataNew.getParasiteLocation()>
    <cfset qGIForeignMaterial= Application.StaticDataNew.getGIForeignMaterial()>
    <cfset qgetParasiteType= Application.StaticDataNew.getParasiteType()>
    <!--- <cfset qgetParasiteLocation= Application.StaticDataNew.getParasiteLocation()> --->
    <cfset qgetLymphNodePresent= Application.StaticDataNew.getLymphNodePresent()>
    <!--- <cfset qgetNxLocation= Application.StaticDataNew.getNxLocation()> --->
    <!--- <cfset getTeams=Application.SightingNew.getTeams()> --->
    <!--- <cfset ageClasss = ['Neonate','YOY','Yearling','Calf','Juvenile','Subadult','Adult','CBD/Unknown','Pup','Fetus']> --->
    <!--- <cfset sexxx = ['Male','Female','unknown']> --->
    <cfparam  name="form.fieldnumber" DEFAULT="empty">
    <cfparam  name="form.report" DEFAULT="emptys">

    <cfif isDefined('form.save')>
        <cfset form.report_ID ='#form.report_ID#'>
        <!--- <cfdump var="#form.report_ID#"><cfabort> --->
        <cfif form.report_ID eq '' >
            <cfset CNR = Application.Stranding.CetaceanNecropsyinsert(argumentCollection="#Form#")>
            <cfset form.Nfieldnumber = '#CNR#'>
            <cfset Session.CetaceanNecropsy = #CNR#>
            <!--- <cfdump var="#CNR#"><cfabort> --->
            <cfset  Application.Stranding.DynamicNutritioninsert(argumentCollection="#Form#")>
            <cfset  Application.Stranding.DynamicLymphoreticularinsert(argumentCollection="#Form#")>
            <cfset  Application.Stranding.DynamicParasitesinsert(argumentCollection="#Form#")>
        <cfelse>
             
            <cfset Application.Stranding.updateCetaceanNecropsy(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicNutrition(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicLymphoreticular(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicParasites(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicNutritioninsert(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicLymphoreticularinsert(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicParasitesinsert(argumentCollection="#Form#")>
            <cfset form.Nfieldnumber = '#form.Fnumber#'>
            <!--- <cfdump var="#form.Nfieldnumber#"><cfabort> --->
          
        </cfif>
        
    <cfelseif isDefined('deleteNecropsyRecord')>
        <!--- <cfdump var="#Form#"><cfabort> --->
        <cfset Application.Stranding.deletcetaceannecropsy("#form#")>
    <cfelseif isDefined('deletCetaceanNecropsyAllRecord')>
        <cfset Application.Stranding.deletCetaceanNecropsyAllRecord()>
    </cfif>
    <cfset qgetallfieldnumbers=application.Stranding.getallfieldnumber()>
    <!--- <cfdump var="#qgetallfieldnumbers.Fnumber#" abort="true"> --->

    <cfif isDefined('form.Nfieldnumber') and Nfieldnumber neq "">
        <cfif Session.CetaceanNecropsy NEQ form.Nfieldnumber>
             <cfset Session.CetaceanNecropsy = ''>  
        </cfif>
        <!--- <cfset Session.CetaceanNecropsy = #form.Nfieldnumber#> --->
        <cfset form.field = form.Nfieldnumber>

        
            <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.field#")>          
            <cfset qLCEDataa=Application.Stranding.getCetaceanNecropsy("#form.field#")>
            <cfset qgetcetaceanDate.CNRDATE= qLCEDataa.date>
             <!--- <cfdump var="#qgetCetaceanNecropsy#" abort="true">/ --->
            <!--- <cfdump var="#qLCEDataa#"><cfabort>  --->
        <cfset qgetAllData=Application.Stranding.getAllData("#form.field#")>
        
        <cfset qgetNutritional=Application.Stranding.getNutritional("#form.field#")>     
    

        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular("#form.field#")>
        <!--- <cfdump var="#qgetLymphoreticular#" abort="true"> --->
        <cfset qgetParasites=Application.Stranding.getParasites("#form.field#")>
        <cfif #qgetCetaceanNecropsy.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetCetaceanNecropsy.species#")>
            
        </cfif>
        <cfif isDefined('qgetAllData.species') and #qgetAllData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetAllData.species#")>
            
            <!--- <cfdump var="#getCetaceansCode#"><cfabort> --->
        </cfif>
    <cfelse>
        <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy_ten()>
        <cfset qgetNutritional=Application.Stranding.getNutritional_ten()>
        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular_ten()>
        <cfset qgetParasites=Application.Stranding.getParasites_ten()>
       
    </cfif>


    <cfif isDefined('Session.CetaceanNecropsy') and Session.CetaceanNecropsy NEQ ''> 
        <cfset form.field = #Session.CetaceanNecropsy# >
        <cfset form.NFIELDNUMBER = #Session.CetaceanNecropsy# >

        <!--- <cfdump var="#form.field#">--->
            <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.field#")>          
            <!--- <cfset qLCEDataa=Application.Stranding.getCetaceanNecropsy("#form.field#")> --->
            <cfset qgetcetaceanDate.CNRDATE= qLCEDataa.date>
             <!--- <cfdump var="#qgetCetaceanNecropsy#" abort="true">/ --->
            <!--- <cfdump var="#qLCEDataa#"><cfabort>  --->
        <cfset qgetAllData=Application.Stranding.getAllData("#form.field#")>
        
        <cfset qgetNutritional=Application.Stranding.getNutritional("#form.field#")>     
    

        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular("#form.field#")>
        <!--- <cfdump var="#qgetLymphoreticular#" abort="true"> --->
        <cfset qgetParasites=Application.Stranding.getParasites("#form.field#")>
        <cfif #qgetCetaceanNecropsy.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetCetaceanNecropsy.species#")>
            
        </cfif>
        <cfif isDefined('qgetAllData.species') and #qgetAllData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetAllData.species#")>
            
            <!--- <cfdump var="#getCetaceansCode#"><cfabort> --->
        </cfif>
    </cfif>

    <!--- end for necropsy --->

<!--- start for Morphometrics --->
<cfset qgetMorphometricsData=Application.Stranding.getMorphomatrics_ten()>
<!--- <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy_ten()> --->
<cfif isDefined('SaveAndNewMorphometrics') OR isDefined('SaveAndClose')>
    <cfif  isDefined('form.Morphometricss_ID') and form.Morphometricss_ID neq "">
        <!--- If update data --->
        <cfset Application.Stranding.MorphometricsFormUpdate(argumentCollection="#Form#")>
        <cfset form.Morphometrics_ID = '#form.Morphometricss_ID#'>
    <cfelse>        
        <!--- If inserting new data --->
        <cfset NEWMorphometricsID = Application.Stranding.MorphometricsFormInsert(argumentCollection="#Form#")> 
        <cfset Session.Morphometrics = '#NEWMorphometricsID#'>
        <cfset form.Morphometrics_ID = '#NEWMorphometricsID#'>

    </cfif>
<cfelseif isDefined('deleteMorphometrics')>
    <cfset Application.Stranding.deleteMorphometrics("#form#")>
<cfelseif isDefined('deleteallMorphometricsRecord')>
    
    <cfset Application.Stranding.deleteMorphometricsAllRecord()>
</cfif>


   <!---   getting data on the basis of HI_ID  --->
   <cfif  isDefined('form.Morphometrics_ID') and form.Morphometrics_ID neq "">
    <cfif Session.Morphometrics NEQ form.Morphometrics_ID>
    <cfset Session.Morphometrics = ''>
    </cfif>
    <cfset qgetMorphometricsData=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>
    <!--- <cfdump var="#qgetMorphometricsData#" abort="true"> --->
    <cfset qLCEDataa=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")> 
    <cfset qgetcetaceanDate=Application.Stranding.getMorphometricsNecropsyDate(#form.Morphometrics_ID#)>
    <cfif #qgetMorphometricsData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetMorphometricsData.species#")>
    </cfif>
</cfif>

<cfif isDefined('Session.Morphometrics') and Session.Morphometrics NEQ ''> 
    <cfset form.Morphometrics_ID = #Session.Morphometrics#>
    <cfset qgetMorphometricsData=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>
    <!--- <cfdump var="#qgetMorphometricsData#" abort="true"> --->
    <!--- <cfset qLCEDataa=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>  --->
    <cfset qgetcetaceanDate=Application.Stranding.getMorphometricsNecropsyDate(#form.Morphometrics_ID#)>
    <cfif #qgetMorphometricsData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetMorphometricsData.species#")>
    </cfif>
</cfif>

<cfset MorphometricsoFBNumber=Application.Stranding.getMorphometricsBNumber()>
<cfset MorphometricsoDate=Application.Stranding.getMorphometricsDate()>

<!--- end for Morphometrics ---> 

    <cfif structKeyExists(form, "sampleFile") and len(form.sampleFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="sampleFile" result="upload" nameconflict="makeunique">
        <!--- <cfdump var="#upload#"><cfabort> --->
        <cfif upload.fileWasSaved>
            <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
            <cfif isSpreadsheetFile(theFile)>
                <cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
                <cfset showForm = false>
            <cfelse>
                <cfset errors = "The file was not an Excel file.">
                <cfset showForm = true>
            </cfif>
        <cfelse>
            <cfset errors = "The file was not properly uploaded.">	
        </cfif>
        <cfif showForm>
            <div  class="container"  role="alert" id="notify">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <cfif structKeyExists(variables, "errors")>
                            <cfoutput>
                            <h3 style="padding-left: 111px;">
                            <b>Error: #variables.errors#</b>
                            </h3>
                            </cfoutput>
                        </cfif>  
                    </div>
                </div>
            </div>
        <cfelse>
        
            <cfif data.recordCount is 1>
                <p>
                This spreadsheet appeared to have no data.
                </p>
            <cfelse>
                
                <!--- <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")> --->
                <cfset colNameArray = data.getColumnNames() />
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'NMFS Regional ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "NMFS Regional #" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'National Database ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "National Database ##" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Species') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Species" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Veterinarian') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Veterinarian" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Team Members') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Team Members" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Stranding Agreement or Authority') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Stranding Agreement or Authority" ');
                    </script>
                <!--- <cfelseif arrayContains(colNameArray, 'Restrand') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Restrand" ');
                    </script>
                 <cfelseif arrayContains(colNameArray, 'Group Event') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Group Event" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Number of Animals') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Number of Animals" ');
                    </script> --->
                 <cfelseif arrayContains(colNameArray, 'Sex') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sex" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Age Class') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Age Class" ');
                    </script>  
                <cfelseif arrayContains(colNameArray, 'County') eq false>
                    <script>
                        alert('The Column name in the sheet should be "County" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lat') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lat" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lon') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lon" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Body of Water') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Body of Water" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Brief History') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Brief History" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('##','') />
                    </cfloop>
                    <cfset data.setColumnNames(colNameArray) />


                    <cfoutput query="data" startRow="2">
                        <!--- for Veterinarian --->
                       <cfset myarray=[] >
                        <cfloop from="1" to="#ListLen(data.Veterinarian)#" index="i">
                            <cfset VeterinarianDat = '#data.Veterinarian#'>
                            <cfset VeterinarianData = VeterinarianDat.replaceAll(', ',',') />
                        <!--- store query for insert data in master table --->
                            <cfset convertedData =listToArray(VeterinarianData,",",false,true) >

                            <cfquery name="qgetdata1" datasource="#Application.dsn#" result="getData">
                                SELECT Veterinarians FROM TLU_Veterinarians
                                WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                            </cfquery> 
                            <cfset veterian = '#qgetdata1.Veterinarians#' >
                        <!--- <cfdump var="#veterian#" abort="true"> --->
                            <cfif veterian eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_Veterinarians
                                        (
                                        Veterinarians
                                        ,status
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetdata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_Veterinarians
                            WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(myarray, qgetdata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedList=myarray.toList() >

                        <!--- for teamMember --->

                        <cfset teamMemberArray=[] >
                        <cfloop from="1" to="#ListLen(data.TeamMembers)#" index="i">
                            <cfset TeamMemberDat = '#data.TeamMembers#'>
                            <cfset TeamMemberData = TeamMemberDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedTeamData =listToArray(TeamMemberData,",",false,true) >

                            <cfquery name="qgetTeamData" datasource="#Application.dsn#" result="getData">
                                SELECT RT_MemberName FROM TLU_ResearchTeamMembers
                                WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                            </cfquery> 
                            <cfset team = '#qgetTeamData.RT_MemberName#' >
                        <!--- <cfdump var="#team#" abort="true"> --->
                            <cfif team eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_ResearchTeamMembers
                                        (
                                        RT_MemberName
                                        ,active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedTeamData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetTeamdata" datasource="#Application.dsn#" >
                            SELECT RT_ID FROM TLU_ResearchTeamMembers
                            WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(teamMemberArray, qgetTeamdata.RT_ID ,"true") >
                        </cfloop>
                        <cfset myConvertedTeamList=teamMemberArray.toList() >

                        <!--- for Water of body --->
                        
                        <cfset waterOfBodyArray=[] >
                        <cfloop from="1" to="#ListLen(data.BodyofWater)#" index="i">
                            <cfset BodyofWaterDat = '#data.BodyofWater#'>
                            <cfset BodyofWaterData = BodyofWaterDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedWaterOfBodyData =listToArray(BodyofWaterData,",",false,true) >

                            <cfquery name="qgetWaterBodydata" datasource="#Application.dsn#" result="getData">
                                SELECT AreaName FROM TLU_SurveyArea
                                WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                            </cfquery> 
                            <cfset waterOFBody = '#qgetWaterBodydata.AreaName#' >
                        <!--- <cfdump var="#waterOFBody#" abort="true"> --->
                            <cfif waterOFBody eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_SurveyArea
                                        (
                                        AreaName
                                        ,Active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedWaterOfBodyData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetWaterOfBodydata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_SurveyArea
                            WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(waterOfBodyArray, qgetWaterOfBodydata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedWatarList=waterOfBodyArray.toList() >
                        <!--- teamMember end --->
            <!--- for species --->

                        <cfset speciesData = '#data.Species#'> 
    
                        <cfquery name="qgetSpeciesData" datasource="#Application.dsn#" result="getData">
                            SELECT CetaceanSpeciesName FROM TLU_CetaceanSpecies
                            WHERE CetaceanSpeciesName ='#speciesData#'                         
                        </cfquery> 
                        <cfset team = '#qgetSpeciesData.CetaceanSpeciesName#'>
                    <!--- <cfdump var="#team#" abort="true"> --->
                        <cfif team eq ''>
                            <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                INSERT INTO TLU_CetaceanSpecies
                                    (
                                    CetaceanSpeciesName
                                    ,Active
                                    ) 
                                    VALUES
                                    (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#speciesData#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                    )
                            </cfquery>
                        </cfif>
                    <cfquery name="qgetSpeciesdata" datasource="#Application.dsn#" >
                        SELECT ID FROM TLU_CetaceanSpecies
                        WHERE CetaceanSpeciesName ='#speciesData#'                         
                    </cfquery> 
                                    
            <!--- end for species --->

                        <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_LiveCetaceanExam
                            (
                            Fnumber
                            ,date
                            ,NMFS
                            ,NDB
                            ,species
                            ,Veterinarian
                            ,ResearchTeam
                            ,NAA
                            ,sex
                            ,ageClass
                            ,county
                            ,lat
                            ,lon
                            ,BodyOfWater
                            ,Location
                            ,BriefHistory                            
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NMFSRegional#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NationalDatabase#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qgetSpeciesdata.ID#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedTeamList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.StrandingAgreementorAuthority#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Sex#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AgeClass#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.County#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lat#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lon#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedWatarList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.BriefHistory#'>
                                                       
                            )
                        </cfquery>

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
    
    <cfoutput>
        
        <cfif isDefined('form.ID')>
           
            <!--- <cfdump var="#form.ID#" abort="true">  --->
        <input type='hidden' name='formID' id="formID" value='#form.ID#'>
        </cfif>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Cetacean Exam</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header" id="PageText">Cetacean Exam</h1>
            <!-- end page-header -->
            <cfif isDefined('form.LCEID')>
                <input type='hidden' name='form_id' id="form_id" value='#form.LCEID#'>
            </cfif>
            <div class="row" id="CetaceanSearch">
                <!--- <div class="col-lg-3 col-md-4">                
                    <div class="form-group input-group select-width">
                        <form id="myCetaceanExamform" action="" method="post" >
                            <label for="sel1">Select Cetacean Exam</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="LCEID" onChange="cetaceanExamform()">
                                    <option value="">Select Exam</option>
                                    <cfloop query="qgetLCEID">
                                        <option value="#qgetLCEID.ID#" <cfif isDefined('form.LCEID') and form.LCEID eq #qgetLCEID.ID#>selected</cfif>>#qgetLCEID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div> --->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myCetaceanExamDateform">
                        <label for="sel1">Search Cetacean Exam By Date:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LCEID" onChange="cetaceanExamDateform()">
                                <option value="">Select Date</option>
                                <cfloop query="qgetLCEDate">
                                    <option value="#qgetLCEDate.ID#" <cfif isDefined('form.LCEID') and form.LCEID eq #qgetLCEDate.ID#>selected</cfif>>#qgetLCEDate.date#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myCetaceanExamFieldNumberform">
                        <label for="sel1">Search Cetacean Exam By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LCEID" onChange="cetaceanExamFieldNumberform()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetLCEFBNumber">
                                    <option value="#qgetLCEFBNumber.ID#" <cfif isDefined('form.LCEID') and form.LCEID eq #qgetLCEFBNumber.ID#>selected</cfif>>#qgetLCEFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
            </div>

            <!---start for HIForm --->
            <div class="row" id="HIformSerch" style="display:none;">
            
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="" method="post" id="myHIFormDate">
                            <label for="sel1">Search By Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="hIFormDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetHIDate">
                                        <option value="#qgetHIDate.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetHIDate.ID#>selected</cfif>>#qgetHIDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myHiFormFieldNumber">
                        <label for="sel1">Search By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="HI_ID" onChange="hiFormFieldNumber()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetHIFBNumber">
                                    <option value="#qgetHIFBNumber.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetHIFBNumber.ID#>selected</cfif>>#qgetHIFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>

                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myHIFormCode" action="" method="post" >
                            <label for="sel1">Select by Code</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="hIFormCode()">
                                    <option value="">Select Code</option>
                                    <cfloop query="getHIID">
                                        <option value="#getHIID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #getHIID.ID#>selected</cfif>>#getHIID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>  --->
                <!--- <cfif isDefined('form.HI_ID') and form.HI_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>    --->
            </div>
            <!--- for HIForm --->
            <!--- start for Level A Form --->
            <div class="row" id="LAFormSerch" style="display:none;">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myLevelAFormID" action="" method="post" >
                            <label for="sel1">Select Level A Form</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="LA_ID" onChange="levelAFormID()">
                                    <option value="">Select Level A Form</option>
                                    <cfloop query="qgetLevelAID">
                                        <option value="#qgetLevelAID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetLevelAID.ID#>selected</cfif>>#qgetLevelAID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div> --->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myLevelAFormDate">
                        <label for="sel1">Search Level A Form By Date:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LA_ID" onChange="levelAFormDate()">
                                <option value="">Select Date</option>
                                <cfloop query="qgetLevelADate">
                                    <option value="#qgetLevelADate.ID#" <cfif isDefined('form.LA_ID') and form.LA_ID eq #qgetLevelADate.ID#>selected</cfif>>#qgetLevelADate.date#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myLevelAFormFieldNumber">
                        <label for="sel1">Search Level A By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LA_ID" onChange="levelAFormFieldNumber()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetLevelAFBNumber">
                                    <option value="#qgetLevelAFBNumber.ID#" <cfif isDefined('form.LA_ID') and form.LA_ID eq #qgetLevelAFBNumber.ID#>selected</cfif>>#qgetLevelAFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetLevelAData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif> --->
            </div>
            <!--- End for Level A Form --->


            <!--- start for histo --->
            <div class="row" id="HIstoFormSerch" style="display:none;">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myFormHistopathology" action="" method="post" >
                            <label for="sel1">Select Histopathology</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="His_ID" onChange="formHistopathology()">
                                    <option value="">Select Histopathology</option>
                                    <cfloop query="getHistoID">
                                        <option value="#getHistoID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #getHistoID.ID#>selected</cfif>>#getHistoID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div> --->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="" method="post" id="myformHistopathologyByDate">
                            <label for="sel1">Search Histopathology By Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="His_ID" onChange="formHistopathologyByDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetHistoDate">
                                        <option value="#qgetHistoDate.ID#" <cfif isDefined('form.His_ID') and form.His_ID eq #qgetHistoDate.ID#>selected</cfif>>#qgetHistoDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformHistopathologyByFieldNumber">
                        <label for="sel1">Search Histopathology By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="His_ID" onChange="formHistopathologyByFieldNumber()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetHistoFBNumber">
                                    <option value="#qgetHistoFBNumber.ID#" <cfif isDefined('form.His_ID') and form.His_ID eq #qgetHistoFBNumber.ID#>selected</cfif>>#qgetHistoFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- <cfif isDefined('form.HI_ID') and form.HI_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>     --->
            </div>

            <!--- end for histo --->

            <!--- start for blood value --->
           
            <div class="row" style="display:none;" id="BloodValueFormSerch">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                        <form id="myformBloodValueByFieldNumber" action="" method="post" >
                            <label for="sel1">Select Blood Values</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="bloodValue_ID" onChange="formBloodValueByFieldNumber()">
                                    <option value="">Select Blood Values</option>
                                    <cfloop query="getBloodValueID">
                                        <option value="#getBloodValueID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #getBloodValueID.ID#>selected</cfif>>#getBloodValueID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div> --->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                        <form  action="" method="post" id="myformBloodValueByDate">
                            <label for="sel1">Search Blood Values By Analysis Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="bloodValue_ID" onChange="formBloodValueByDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetBloodValueDate">
                                        <option value="#qgetBloodValueDate.ID#" <cfif isDefined('form.bloodValue_ID') and form.bloodValue_ID eq #qgetBloodValueDate.ID#>selected</cfif>>#qgetBloodValueDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                    <form  action="" method="post" id="myformBloodValueByFieldNum">
                        <label for="sel1">Search Blood Values By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="bloodValue_ID" onChange="formBloodValueByFieldNum()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetBloodValueFBNumber">
                                    <option value="#qgetBloodValueFBNumber.ID#" <cfif isDefined('form.bloodValue_ID') and form.bloodValue_ID eq #qgetBloodValueFBNumber.ID#>selected</cfif>>#qgetBloodValueFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- <cfif isDefined('form.HI_ID') and form.HI_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group blood-from-froup input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group blood-from-froup input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>     --->
            </div>
            
            <!--- end for blood value --->

            <!--- start for Toxicology --->
            <div class="row" style="display:none;" id="ToxicologyFormSerch">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                        <form action="" method="post" id="myformToxicology">
                            <label for="sel1">Select Toxicology</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="Toxicology_ID" onChange="formToxicology()">
                                    <option value="">Select Toxicology</option>
                                    <cfloop query="getToxicologyID">
                                        <option value="#getToxicologyID.ID#" <cfif isDefined('form.Toxicology_ID') and form.Toxicology_ID eq #getToxicologyID.ID#>selected</cfif>>#getToxicologyID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div> --->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                        <form  action="" method="post" id="myformToxicologybyDate">
                            <label for="sel1">Search Toxicology By Analysis Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="Toxicology_ID" onChange="formToxicologybyDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetToxicologyDate">
                                        <option value="#qgetToxicologyDate.ID#" <cfif isDefined('form.Toxicology_ID') and form.Toxicology_ID eq #qgetToxicologyDate.ID#>selected</cfif>>#qgetToxicologyDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                    <form  action="" method="post" id="myformToxicologybyFieldNumber">
                        <label for="sel1">Search Toxicology By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="Toxicology_ID" onChange="formToxicologybyFieldNumber()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetToxicologyFBNumber">
                                    <option value="#qgetToxicologyFBNumber.ID#" <cfif isDefined('form.Toxicology_ID') and form.Toxicology_ID eq #qgetToxicologyFBNumber.ID#>selected</cfif>>#qgetToxicologyFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- <cfif isDefined('form.HI_ID') and form.HI_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group blood-from-froup input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group blood-from-froup input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>     --->
            </div>
            <!--- end for Toxicology --->
            <!--- start for AncillaryDiagnostics --->
            <div class="row" style="display:none;" id="AncillaryDiagnosticsFormSerch">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myformAncillaryDiagnosticsSerch" action="" method="post" >
                            <label for="sel1">Select Ancillary Diagnostics</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="AD_ID" onChange="formAncillaryDiagnosticsSerch()">
                                    <option value="">Select Ancillary Diagnostics</option>
                                    <cfloop query="getAnclillaryID">
                                        <option value="#getAnclillaryID.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #getAnclillaryID.ID#>selected</cfif>>#getAnclillaryID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div> --->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="" method="post" id="myformAncillaryDiagnosticsSerchByDate">
                            <label for="sel1">Search Ancillary Diagnostics By Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="AD_ID" onChange="formAncillaryDiagnosticsSerchByDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetAnclillaryDate">
                                        <option value="#qgetAnclillaryDate.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #qgetAnclillaryDate.ID#>selected</cfif>>#qgetAnclillaryDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformAncillaryDiagnosticsSerchByFieldNumber">
                        <label for="sel1">Search Ancillary By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="AD_ID" onChange="formAncillaryDiagnosticsSerchByFieldNumber()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetAnclillaryFBNumber">
                                    <option value="#qgetAnclillaryFBNumber.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #qgetAnclillaryFBNumber.ID#>selected</cfif>>#qgetAnclillaryFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- <cfif isDefined('form.AD_ID') and form.AD_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>     --->
            </div>
            <!--- end for AncillaryDiagnostics --->

            <!--- start for sampleArchive --->
            <div class="row" style="display:none;" id="sampleAechiveFormSerch">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myformSampleArchive" action="" method="post" >
                            <label for="sel1">Select Sample Archive</label>
                            <div class="input" id="propag"> 
                                <select class="form-control search-box" name="SEID" id="myList" onchange="formSampleSerchByFieldNumber()">
                                    <option value="">Select Sample</option>
                                        <cfloop query="getSampleID">
                                            <option value="#getSampleID.ID#" <cfif isDefined('form.SEID') and form.SEID eq #getSampleID.ID#>selected</cfif>>#getSampleID.ID#</option>
                                        </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>            --->           
                <input type="hidden" name="startValue" value="1001" id="startValue">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  id="dateform" action="" method="post" >
                        <label for="sel1">Search Sample Archive By Date:</label>
                        <div class="input"> 
                            <input type="hidden" name="searchDate" value=""  id="searchDate" autocomplete="off">
                            <input type="search" placeholder="Search by date" focusMethod="hidefeild()" style="display:none; width:100%;" onkeyup="searchData()" name="search" value="" id="search"></input>

                            <select class="form-control" name="SEID" id="listDate" onchange="addMoreRecords(event)">
                                
                                <option  value="">Select Date</option>
                                <option id="addSearch" value="Search">Search</option>
                                <cfloop query="getmaindate">
                                    <option value="#getmaindate.SA_ID#" <cfif isDefined('form.SEID') and form.SEID eq #getmaindate.SA_ID#>selected</cfif>>#getmaindate.maindate#</option>
                                </cfloop>
                                <option id="loadMore" value="LoadMore">Load More</option>
                            </select>



                            <!--- <select placeholder="Pick a state..." name="SEID" id="listDate" onchange="addMoreRecords()">
                                <option  value="">Select Date</option>
                                   <cfloop query="getmaindate">
                                    <option value="#getmaindate.SA_ID#" <cfif isDefined('form.SEID') and form.SEID eq #getmaindate.SA_ID#>selected</cfif>>#getmaindate.maindate#</option>
                                    </cfloop>
                                <option id="loadMore" value="LoadMore">Load More</option>
                                <!--- <input type="button" value="Add Record" onclick = "addMoreRecords()"> --->
                              </select> --->
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  id="fieldform" action="" method="post" >
                        <label for="sel1">Search Sample Archive By Field Number:</label>
                        <div class="input"> 
                            <input type="hidden" name="searchField" value="" id="searchField">
                            <input type="hidden" name="fielnumb" value="" id="fielnumb">
                            <select class="form-control search-box" name="SEID" id="fieldList" onchange="fieldnum()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetSampleFBNumber">
                                    <option value="#qgetSampleFBNumber.ID#" <cfif isDefined('form.SEID') and form.SEID eq #qgetSampleFBNumber.ID#>selected</cfif>>#qgetSampleFBNumber.Fnumber#</option>
                                </cfloop>
                               
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- <cfif isDefined('form.SEID') and form.SEID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text"  value="#qgetSampleData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>    --->
            </div>

            
            <!--- end for sampleArchive --->

            <!--- Start for Necropsy --->
            <div class="row" id="NecropstFormSerch" style="display:none;">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myformAncillaryDiagnosticsSerch" action="" method="post" >
                            <label for="sel1">Select Ancillary Diagnostics</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="AD_ID" onChange="formAncillaryDiagnosticsSerch()">
                                    <option value="">Select Ancillary Diagnostics</option>
                                    <cfloop query="getAnclillaryID">
                                        <option value="#getAnclillaryID.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #getAnclillaryID.ID#>selected</cfif>>#getAnclillaryID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="" method="post" id="myformAncillaryDiagnosticsSerchByDate">
                            <label for="sel1">Search Ancillary Diagnostics By Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="AD_ID" onChange="formAncillaryDiagnosticsSerchByDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetAnclillaryDate">
                                        <option value="#qgetAnclillaryDate.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #qgetAnclillaryDate.ID#>selected</cfif>>#qgetAnclillaryDate.date#</option>
                                    </cfloop>
                                </select>fv
                            </div>
                        </form>
                    </div>
                </div> --->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformNecropsySerchByFieldNumber">
                        <label for="sel1">Search Necropsy Report By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" id="fieldnumber" name="Nfieldnumber" onChange="checkfield()">
                                <option value="">Select Filed Number</option>
                                <option value="0" class="adnew">Add New</option>
                                <cfloop query="qgetallfieldnumbers">
                                    <option value="#qgetallfieldnumbers.Fnumber#" <cfif isDefined('form.Nfieldnumber') and form.Nfieldnumber eq #qgetallfieldnumbers.Fnumber#>selected<cfelseif isDefined('form.Fnumber') and form.Fnumber eq #qgetallfieldnumbers.Fnumber#>selected</cfif>>#qgetallfieldnumbers.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- awan --->
                <!--- <cfif isDefined('form.AD_ID') and form.AD_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>     --->
            </div>

            <!--- end for Necropsy --->
            <!--- Start for morMorphometrics --->
            <div class="row" id="MorphometricsFormSerch" style="display:none;">
                <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myformAncillaryDiagnosticsSerch" action="" method="post" >
                            <label for="sel1">Select Ancillary Diagnostics</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="AD_ID" onChange="formAncillaryDiagnosticsSerch()">
                                    <option value="">Select Ancillary Diagnostics</option>
                                    <cfloop query="getAnclillaryID">
                                        <option value="#getAnclillaryID.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #getAnclillaryID.ID#>selected</cfif>>#getAnclillaryID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>--->

                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="" method="post" id="myformMorphometricsSerchByDate">
                            <label for="sel1">Search Morphometrics By Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="Morphometrics_ID" onChange="formMorphometricsSerchByDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="MorphometricsoDate">
                                        <option value="#MorphometricsoDate.ID#" <cfif isDefined('form.Morphometrics_ID') and form.Morphometrics_ID eq #MorphometricsoDate.ID#>selected</cfif>>#MorphometricsoDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div> 

                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformMorphometricsSerchByFieldNumber">
                        <label for="sel1">Search Morphometrics By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="Morphometrics_ID" onChange="formMorphometricsSerchByFieldNumber()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="MorphometricsoFBNumber">
                                    <option value="#MorphometricsoFBNumber.ID#" <cfif isDefined('form.Morphometrics_ID') and form.Morphometrics_ID eq #MorphometricsoFBNumber.ID#>selected</cfif>>#MorphometricsoFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <!--- <cfif isDefined('form.AD_ID') and form.AD_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>     --->
            </div>

            <!--- end for Morphometrics --->


            <form id="myforma" action="" method="post" enctype="multipart/form-data" autocomplete="on">
                <input type="hidden"  name="sessionDistroy" id="sessionDistroy" value="sessionDistroy">
                <input type="hidden"  name="Site_url" id="Site_url" value="#Application.siteroot#/?Module=Stranding&Page=StrandingTabsNew">
                <input type="hidden"  name="ID" id="qLCEDataID" value="#qLCEData.ID#">
                <div class="form-wrapper cetacean-exam-wrapper">  
                    <div class="row cetacean-exam-holder">
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="cetaceanExam-date-form form-group m-0 blue-bg-l">
                                    <div class="cetacean-exam-form">
                                        <div class="cetacean-exam-wrap row">
                                            <!--- working start --->
                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <label class="field-number" for='necropsyfieldnumber'>Field Number</label>
                                                        <div class="input">
                                                            <input type="text" value="#qLCEDataa.Fnumber#" class="form-control" name="Fnumber" id="Fnumber" required>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 apend"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group">
                                                        <label class="">Standing Agreement or Authority</label>
                                                        <div class="input">
                                                            <input class="input input-style" type="text" value="<cfif isDefined('qLCEDataa.NAA')  and #qLCEDataa.NAA# neq "">#qLCEDataa.NAA#</cfif>"name="NAA" id="NAA">
                                                        </div>
                                                    </div>                                                    
                                                </div>
                                            </div> 
                                            <div class="col-sm-6"> 
                                                <div class="form-group">
                                                    <label class="date-padd">Stranding Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="YYYY-MM-DD" name="date" id="date"
                                                                class="form-control" value='<cfif isDefined('qLCEDataa.Date') and #qLCEDataa.Date# neq "" >#DateTimeFormat(qLCEDataa.Date, "YYYY-MM-DD")#</cfif>' required/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <label class="date-padd">Necropsy Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <!--- <cfdump var="#qgetcetaceanDate.CNRDATE#"> --->
                                                            <input type="text" placeholder="YYYY-MM-DD" name="date123" id="date"
                                                                class="form-control" value='<cfif isDefined('qgetcetaceanDate.CNRDATE') and #qgetcetaceanDate.CNRDATE# neq "" >#DateTimeFormat(qgetcetaceanDate.CNRDATE, "YYYY-MM-DD")# </cfif>' readonly/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <label class="">NMFS Regional ##</label>
                                                        <input class="input-style xl-width" type="text" value="<cfif isDefined('qLCEDataa.NMFS') and #qLCEDataa.NMFS# neq "" >#qLCEDataa.NMFS#</cfif>" name="NMFS" id="NMFS">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <label class="">National Database ##</label>
                                                        <input class="input-style xl-width" type="text" value="<cfif isDefined('qLCEDataa.NDB') and #qLCEDataa.NDB# neq "" >#qLCEDataa.NDB#</cfif>" name="NDB" id="NDB">
                                                    </div>
                                                </div>
                                            </div> 
                                       <!--- <cfif isDefined('qLCEDataa.species') and #qLCEDataa.species# neq "" > --->
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                <div class="input-group">
                                                    <label class="code-padd">Code</label>
                                                    <select class="form-control" name="code" id="code" onChange="getFbAndSex()">
                                                        <option value="">Select Code</option>
                                                        <cfif isDefined('qLCEDataa.species') and #qLCEDataa.species# neq "" >
                                                            <cfloop query="getCetaceansCode">
                                                                <option value="#getCetaceansCode.id#" <cfif #getCetaceansCode.id# eq #qLCEDataa.code#>selected</cfif>>
                                                                        #getCetaceansCode.code# </option>
                                                            </cfloop>
                                                        </cfif>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6"> 
                                            <div class="form-group m-0">
                                                <div class="input-group">
                                                    <label class="AI-label">Additional Identifier</label>
                                                    <div class="input">
                                                        <input class="input input-style" type="text" name="affiliatedID" value="#qLCEDataa.affiliatedID#" maxlength="80">
                                                    </div>
                                                </div>
                                            </div>
                                        </div> 
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="">HERA/FB No.</label>
                                                    <input class="input-style xl-width" type="text" value="<cfif isDefined('qLCEDataa.hera')>#qLCEDataa.hera#</cfif> " name="hera" id="hera">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="sex-label">Sex</label>
                                                    <select class="form-control" name="sex" id="sex">
                                                        <option value="">Select Sex</option>
                                                        <cfloop from="1" to="#ArrayLen(sex)#" index="j">
                                                            <cfif isDefined('qLCEDataa.sex')>
                                                                <option value="#sex[j]#" <cfif #sex[j]# eq #qLCEDataa.sex#>selected</cfif>>#sex[j]#</option>
                                                            </cfif>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div> 
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="ageclass-label">Age Class</label>
                                                    <select class="form-control" name="ageClass" id="ageClass">
                                                        <option value="">Select Age Class</option>
                                                        <cfloop from="1" to="#ArrayLen(ageClass)#" index="j">
                                                            <cfif isDefined('qLCEDataa.ageClass')>
                                                            <option value="#ageClass[j]#" <cfif #ageClass[j]# eq #qLCEDataa.ageClass#>selected</cfif>>#ageClass[j]#</option>
                                                        </cfif>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="ageclass-label">Actual Age</label>
                                                    <div class="input">
                                                        <input class="input input-style" type="text" name="actualClass" id="actualClass "value="#qLCEDataa.actualClass#" maxlength="80">
                                                    </div>
                                                    <!--- <select class="form-control" name="actualClass" id="actualClass">
                                                        <option value="">Select Actual Class</option>
                                                        <cfloop from="1" to="#ArrayLen(ageClass)#" index="j">
                                                            <cfif isDefined('qLCEDataa.actualClass')>
                                                            <option value="#ageClass[j]#" <cfif #ageClass[j]# eq #qLCEDataa.actualClass#>selected</cfif>>#ageClass[j]#</option>
                                                        </cfif>
                                                        </cfloop>
                                                    </select> --->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 ">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="">Initial Condition</label>
                                                    <select class="form-control" name="InitialCondition" id="InitialCondition">
                                                        <option value="">Select Initial Condition</option>
                                                        <cfloop array="#Conditions#" item="item" index="j">
                                                            <cfif isDefined('qLCEDataa.InitialCondition')>
                                                            <option value="#item#" <cfif #item# eq #qLCEDataa.InitialCondition#>selected</cfif>>#ConditionsValue[j]#-#item#</option>
                                                            </cfif>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 ">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="">Final Condition</label>
                                                    <select class="form-control" name="FinalCondition" id="FinalCondition">
                                                        <option value="">Select Final Condition</option>
                                                        <cfloop array="#Conditions#" item="item" index="j">
                                                            <cfif isDefined('qLCEDataa.FinalCondition')>
                                                            <option value="#item#" <cfif #item# eq #qLCEDataa.FinalCondition#>selected</cfif>>#ConditionsValue[j]#-#item#</option>
                                                            </cfif>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div> 
                                        <div class="col-sm-12" style="margin-bottom: 10px;">
                                            <label>Location</label>
                                            <textarea class="form-control textareaCustomReset locations-textarea" name="Location"
                                                maxlength="75"><cfif isDefined('qLCEDataa.Location')>#qLCEDataa.Location#</cfif></textarea>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="lat-one">Lat</label>
                                                    <input class="input-style xl-width" type="text" value="<cfif isDefined('qLCEDataa.lat')>#qLCEDataa.lat#</cfif>" name="lat" id="AtLatitude">
                                                </div>
                                            </div>
                                        </div> 
                                        <div class="col-sm-6">
                                            <div class="form-group ">
                                                <div class="input-group">
                                                    <label class="lon-one">Lon</label>
                                                    <input class="input-style xl-width" type="text" value="<cfif isDefined('qLCEDataa.lon')>#qLCEDataa.lon#</cfif>" name="lon" id="AtLongitude">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="form-group justify-content-end">
                                                <input type="button" id="verifyLocation" class="btn btn-skyblue" value="Verify" onclick="checkLatLng()">
                                            </div>
                                        </div> 
                                        <div class=" col-sm-6 ">
                                            <div class="form-group">
                                                <div class="input-group flex-center">
                                                    <label class="county-label">County</label>
                                                    <select class="form-control" name="county" id="county">
                                                        <option value="">Select County</option>
                                                        <cfloop query="qgetIR_CountyLocation">
                                                            <cfif active  neq 0>
                                                                <option value="#qgetIR_CountyLocation.IR_CountyLocation#" <cfif #qgetIR_CountyLocation.IR_CountyLocation# eq #qLCEDataa.county#>selected</cfif>>#qgetIR_CountyLocation.IR_CountyLocation#</option>
                                                            </cfif>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>   
                                        
                                  <!--- working end --->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="form-group m-0">
                                    <div class="row">
                                        <div class="col-lg-12 p-0 green-labels">
                                            <div class="col-lg-12">
                                                <div class="form-group input-group flex-center">
                                                    <label>Team Members</label>
                                                    <div class="input"> 

                                                            <select class="form-control search-box" multiple="multiple" name="ResearchTeam"
                                                            id="ResearchTeam">
                                                            <cfloop query="getTeams">
                                                                <!--- <cfif active eq 1> --->
                                                                    <option value="#getTeams.RT_ID#" <cfif ListFind(ValueList(qLCEDataa.ResearchTeam,","),getTeams.RT_ID)>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                                <!--- </cfif> --->
                                                            </cfloop>

                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group input-group flex-center">
                                                    <label class="veterinarian">Veterinarian</label>
                                                    <!--- <cfdump var="#qgetVeterinarians.Veterinarians#" about="true"> --->
                                                    <div class="input">
                                                        <select class="form-control search-box" multiple="multiple" name="Veterinarian" id="Veterinarian" onclick ="removeOptions()">
                                                           
                                                            <cfloop query="qgetVeterinarians">

                                                                <!--- <cfif status eq 1> --->
                                                                    <option value="#qgetVeterinarians.ID#" 
                                                                    <cfif ListFind(ValueList(qLCEDataa.Veterinarian,","),
                                                                                            qgetVeterinarians.ID)>selected
                                                                    </cfif>
                                                                    >#qgetVeterinarians.Veterinarians#</option>  
                                                                <!--- </cfif> --->
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                            <div class="col-lg-12"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">Body of Water</label>
                                                        <div class="input">
                                                            <select class="combobox form-control search-box" multiple="multiple" name="BodyOfWater">
                                                                <cfloop query="getSurveyAreaData">
                                                                    <!--- <cfif active eq 1> --->
                                                                        <option value="#getSurveyAreaData.ID#" <cfif ListFind(ValueList(qLCEDataa.BodyOfWater,","),getSurveyAreaData.ID)>selected</cfif>>#getSurveyAreaData.AreaName#</option>
                                                                    <!--- </cfif> --->
                                                                </cfloop>                                                               
                                                        
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group flex-center">
                                                    <label class="">Species</label>
                                                    <div class="input">
                                                        <select class="form-control selectCustomReset" name="species" id="species"
                                                            onChange="getCode()">
                                                            <option value=""></option>
                                                            <cfloop query="qgetCetaceanSpecies">
                                                                <!--- <cfif active eq 1> --->
                                                                    <option value="#qgetCetaceanSpecies.id#" <cfif #qgetCetaceanSpecies.id# eq #qLCEDataa.species#>selected</cfif>>
                                                                        #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                                                <!--- </cfif> --->
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group input-group flex-center">
                                                    <label class="veterinarian">Stranding Type</label>
                                                    <div class="input">
                                                        <select class="form-control" name="StTpye" id="StTpye">
                                                            <option value="">Select Stranding Type</option>
                                                            <cfloop query="qgetStrandingType">
                                                                <cfif status eq 1>
                                                                    <option value="#qgetStrandingType.ID#" <cfif #qgetStrandingType.ID# eq #qLCEDataa.StTpye#>selected</cfif>>#qgetStrandingType.type#</option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group flex-center">
                                                        <label class="">NOAA Stock</label>
                                                        <div class="input">
                                                            <select class="combobox form-control search-box" multiple="multiple" name="NOAAStock" id="stock_value">
                                                                <option value="">Select NOAA Stock</option>
                                                                <cfloop query="getStock">
                                                                    <cfif active eq 1>
                                                                        <option class="stock_value" value="#getStock.ID#" <cfif ListFind(ValueList(qLCEDataa.NOAAStock,","),getStock.ID)>selected</cfif>>
                                                                            #getStock.StockName#</option>
                                                                    </cfif>
                                                                </cfloop>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" style="margin-top: 15px;">
                                            <div class="form-group brief-history">
                                                <label class="history-label">Brief History </label>
                                                <textarea class="form-control textareaCustomReset locations-textarea" name="BriefHistory"
                                                 style="resize: auto;"><cfif isDefined('qLCEDataa.BriefHistory')>#qLCEDataa.BriefHistory#</cfif> </textarea>
                                            </div>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

               
                 <!-- Nav tabs -->
                 <div class="tab-section-list">

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                      <li role="presentation" id="CetaceanExamPage_tab" class="active"><a href="##CetaceanExamPage" onclick="showCetaceanSearchBar()" aria-controls="CetaceanExamPage" role="tab" data-toggle="tab">CetaceanExam</a></li>
                      <li role="presentation" id="HIForm_tab"><a href="##HIForm" onclick="showHISearchBar()" aria-controls="HIForm" role="tab" data-toggle="tab">HIForm</a></li>
                      <li role="presentation"><a href="##LevelAForm" aria-controls="LevelAForm" onclick="showLASearchBar()" role="tab" data-toggle="tab">Level A Form</a></li>
                      <li role="presentation"><a href="##HistoForm" onclick="HIstoFormSerch()"  aria-controls="HistoForm" role="tab" data-toggle="tab">Histopathology</a></li>
                      <li role="presentation"><a href="##BloodValue" onclick="showBloodValueSerch()"  aria-controls="BloodValue" role="tab" data-toggle="tab">Blood Value</a></li>
                      <li role="presentation"><a href="##Toxicology" onclick="showToxicologySerch()"  aria-controls="Toxicology" role="tab" data-toggle="tab">Toxicology</a></li>
                      <li role="presentation"><a href="##AncillaryDiagnostics" onclick="showAncillaryDiagnosticsSerch()"  aria-controls="AncillaryDiagnostics" role="tab" data-toggle="tab">Ancillary Diagnostics</a></li>
                      <li role="presentation"><a href="##SampleArchive" onclick="showSampleArchiveSerch()"  aria-controls="SampleArchive" role="tab" data-toggle="tab">Sample Archive</a></li>
                      <li role="presentation"><a href="##NecropsyReport" onclick="showNecropsyReportSerch()"  aria-controls="NecropsyReport" role="tab" data-toggle="tab">Necropsy Report</a></li>
                      <li role="presentation"><a href="##Morphometrics" onclick="showMorphometricsSerch()"  aria-controls="Morphometrics" role="tab" data-toggle="tab">Morphometrics</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                      <div role="tabpanel" class="tab-pane active" id="CetaceanExamPage"> 
                    
                        <h5 class="mb-1"><strong>Documents</strong></h5>
                        <input type="hidden" name="pdfFiles" value="#qLCEData.pdfFiles#" id="pdfFiles">
                        <div class="form-holder">  
                            <div class="form-group" id="find">
                                <div class="row" id="startExam">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <div class="input-group flex-center">
                                                <label class="">Upload PDF File (Max Size: 10MB)</label>
                                                <input class="input-style xl-width" type="file"  name="FileContents" id="ExamFiles" onchange="ceteacenExamImg()" accept="application/pdf" <cfif findNoCase("Read only ST", permissions) neq 0> Disabled</cfif>>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <cfset imgss = ValueList(qLCEData.pdfFiles,",")>
                                <div id="previousimagesExam">
                                    <CFIF listLen(imgss)> 
                                        <cfloop list="#imgss#" item="item" index="index">
                        
                                            <span class="pip">
                                                <a data-toggle="modal" data-target="##myModalExam" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                    <img  class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="selected(this)"/>
                                                </a>
                                                <br/>
                                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                                    <span class="remove" onclick="remov(this)" id="#item#">Remove image</span>
                                                </cfif>
                                            </span>
                                        </cfloop>
                                    </cfif>	
                                </div>
                            </div>
                        </div>
                        <!--- <div class="form-holder">  
                            <div class="form-group">
                                <div class="row">
                                  
                                    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 ">
                                    
                                        <div class="form-group flex-center">
                                            <label>Affiliated ID</label>
                                            <input class="form-control"type="text" name="affiliatedID" value="#qLCEData.affiliatedID#" maxlength="80">
                                        </div>
                                    </div> 
                                             <div class="col-lg-6 "> 
                                                        <div class="form-group flex-center">
                                                            <label class="start-time">Start Time</label>
                                                                <div class="input-group date " id="datetimepicker_StartTime">
                                                                    <input type="text" value="#TimeFormat(qLCEData.StartTime, "HH:nn")#" placeholder="hh:mm:ss" name="StartTime" id="StartTime"
                                                                        class="form-control" />
                                                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                                </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 "> 
                                                        <div class="form-group flex-center">
                                                            <label class="end-time">End Time</label>
                                                            <div class="input-group date" id="datetimepicker_EndTime">
                                                                <input type="text"  value="#TimeFormat(qLCEData.EndTime, "HH:nn")#" placeholder="hh:mm:ss" name="EndTime" id="EndTime"
                                                                    class="form-control" />
                                                                    <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                            </div>
                                                        </div>
                                                    </div> 
                                   
                                    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <div class="input-group flex-center">
                                                <label class="county-label">County</label>
                                                <select class="form-control" name="county" id="county">
                                                    <option value="">Select County</option>
                                                    <cfloop query="qgetIR_CountyLocation">
                                                        <cfif active  neq 0>
                                                            <option value="#qgetIR_CountyLocation.IR_CountyLocation#" <cfif #qgetIR_CountyLocation.IR_CountyLocation# eq #qLCEData.county#>selected</cfif>>#qgetIR_CountyLocation.IR_CountyLocation#</option>
                                                        </cfif>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                    </div>                
                                   
                                </div>
                            </div>
                        </div> --->
                        <div class="form-holder">
                            <div class="row">
                                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6 heartrate-one">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="flex-center mb-1">
                                                <label class="">Heart Rate</label>
                                                <div class="input">
                                                    <input class="input input-style" type="text" value=""  id="heartRate" placeholder="beats/min">
                                                    <span id="H_rate" class="heart_rate_error"></span>
                                                    <input type="hidden" id="hr" name="heartRate" value="">
                                                </div>
                                            </div>
                                            <div class="flex-center flex-row rate-wrap">
                                                <label class="">Time</label>
                                                <div class="input-group date " id="datetimepicker_heartRateTime">
                                                    <input class="input-style input-type-time" type="text" value=""  id="heartRateTime" placeholder="hh:mm:ss">
                                                    <input type="hidden" id="hrt" name="heartRateTime" value="">
                                                    <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                </div>    
                                                <input type="button" class="btn btn-success" id="heartRateTimeNew"
                                                    value="Add New" onClick="AddNewRate()" />
                                            </div>
                                            <span id="H_rate_time" class="H_rate_time_error"></span>
                                        </div>
                                    </div>
                                    <table class="table table-bordered table-hover" id="heartHistory" <cfif isDefined('qgetHeartData') AND #qgetHeartData.recordcount# gt 0><cfelse> hidden</cfif>>
                                        <thead>
                                            <tr>
                                                <th>Heart Rate</th>
                                                <th>Time</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <cfif isDefined('qgetHeartData')>
                                                <cfloop query="qgetHeartData">
                                                    <tr>
                                                        <td>#qgetHeartData.heartRate#</td>
                                                        <td>#qgetHeartData.heartRateTime#</td>
                                                    </tr>
                                                </cfloop>
                                            </cfif>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6 heartrate-two">
                                        <div class="form-group">
                                        <div class="input-group">
                                            <div class="flex-center mb-1">
                                                <label class="resp-rate">Resps/min</label>
                                                
                                                <div class="input">
                                                    <input type="text" class="input input-style"  value="" id="respRate" placeholder="beats/min">
                                                    <span id="resp_rate" class="resp_rate_error"></span>
                                                    <input type="hidden" value="" name="respRate" id="rr">
                                                </div>
                                            </div>
                                            <div class="flex-center flex-row rate-wrap">
                                                <label class="">Time</label>
                                                <div class="input-group date" id="datetimepicker_respRateTime">
                                                    <input class="input-style input-type-time" type="text" value="" id="respRateTime" placeholder="hh:mm:ss">
                                                    <input type="hidden" value="<cfif isDefined('qgetRespData')>#qgetRespData.respRateTime#</cfif>" name="respRateTime" id="rrt">
                                                    <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                </div> 
                                                <input type="button" class="btn btn-success" id="respRateTimeNew" value="Add New" onClick="AddNewResp()"/>
                                            </div>
                                            <span id="resp_rate_time" class="resp_rate_time_error"></span>
                                        </div>
                                    </div>
                                    <table class="table table-bordered table-hover" id="respHistory" <cfif isDefined('qgetRespData') AND #qgetRespData.recordcount# gt 0><cfelse> hidden</cfif>>
                                        <thead>
                                            <tr>
                                                <th>Resp Rate</th>
                                                <th>Time</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <cfif isDefined('qgetRespData')>
                                                <cfloop query="qgetRespData">
                                                    <tr>
                                                        <td>#qgetRespData.respRate#</td>
                                                        <td>#qgetRespData.respRateTime#</td>
                                                    </tr>
                                                </cfloop>
                                            </cfif>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-lg-6 col-md-12 heartrate-full">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 heartrate-three">
                                        <div class="form-group">
                                            <div class="input-group flex-center flex-row">
                                                <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6 p-0 flex-center flex-row"> 
                                                    <label class="">ECG</label>
                                                    <div class="radio-buttons"> 
                                                        <div class="radio-btn flex-center flex-row"> 
                                                            <input type="radio" value="1" name="ECG" id="ECGyes" <cfif #qLCEData.ECG# eq 1>
                                                            checked</cfif>>
                                                            <label for="ECGyes">Yes</label>
                                                        </div>
                                                        <div class="radio-btn flex-center flex-row"> 
                                                            <input type="radio" value="0" name="ECG" id="ECGyno" <cfif #qLCEData.ECG# eq 0>
                                                            checked</cfif>>
                                                            <label for="ECGyno">No</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                    <div class="col-lg-7 col-md-7 col-sm-6 col-xs-6 p-0">
                                                <label class="">Results</label>
                                                <textarea class="form-control textareaCustomReset results-textarea" name="ECGresults"
                                                    maxlength="75">#qLCEData.ECGresults#</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 p-0 heartrate-four">
                                        <div class="form-group">
                                            <div class="input-group flex-center flex-row">
                                                    <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6 p-0 flex-center flex-row"> 
                                                    <label class="">Ultrasound</label>
                                                    <div class="radio-buttons"> 
                                                        <div class="radio-btn flex-center flex-row"> 
                                                            <input type="radio" value="1" name="Ultrasound" id="Ultrasoundyes" <cfif #qLCEData.Ultrasound# eq 1>
                                                            checked</cfif>>
                                                            <label for="Ultrasoundyes">Yes</label>
                                                        </div>
                                                        <div class="radio-btn flex-center flex-row"> 
                                                            <input type="radio" value="0" name="Ultrasound" id="Ultrasoundyno" <cfif #qLCEData.Ultrasound# eq 0>
                                                            checked</cfif>>
                                                            <label for="Ultrasoundyno">No</label>
                                                        </div>
                                                    </div>
                                                    </div>
                                                    <div class="col-lg-7 col-md-7 col-sm-6 col-xs-6 p-0"> 
                                                    <label class="">Results</label>
                                                    <textarea class="form-control textareaCustomReset results-textarea" name="Ultrasoundresults"
                                                    maxlength="75">#qLCEData.Ultrasoundresults#</textarea>
                                                    </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 pl-0 mucus-padd">
                                        <div class="form-group">
                                            <div class="input-group flex-center">
                                                <label class="">Mucus Membrane Color</label>
                                                <div class="input">
                                                    <select class="form-control" name="mmc" id="mmc">
                                                        <option value="">Select Mucus Membrane Color</option>
                                                        <cfloop from="1" to="#ArrayLen(MucusMembraneColor)#" index="j">
                                                            <option value="#MucusMembraneColor[j]#" <cfif #MucusMembraneColor[j]# eq #qLCEData.mmc#>selected</cfif>>#MucusMembraneColor[j]#</option>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 pr-0 refil-padd">
                                        <div class="form-group">
                                            <div class="input-group flex-center">
                                                <label class="">Capillary Refill Time</label>
                                                <div class="input">
                                                    <input class="input input-style" type="text" value="#qLCEData.crt#" name="crt" id="crt">
                                                </div>
                                            </div>
                                        </div>
                                    </div> 
                                </div> 
                            </div>
                        </div>
                                    <!---Drugs Administered --->
                <div class="form-holder blue-bg">
                    <h5><strong>Drugs Administered</strong></h5>
                    <div class="row">
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Type</label>
                                <select class="form-control" id="Drugtype">
                                    <option value="">Select Type</option>
                                    <cfloop query="#qgetDrugType#">
                                        <cfif status eq 1>
                                            <option value="#qgetDrugType.ID#">#qgetDrugType.Type#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" value="" name="Drugtype" id="dt">
                            </div>
                            <span id="D_type" class="D_type_error"></span>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Admin Method</label>
                                <select class="form-control" id="DrugMethod">
                                    <option value="">Select Method</option>
                                    <cfloop query="#qgetDrugMethod#">
                                        <cfif status eq 1>
                                            <option value="#qgetDrugMethod.Method#">#qgetDrugMethod.Method#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" value="" name="DrugMethod" id="dm">
                            </div>
                            <span id="D_method" class="D_method_error"></span>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width drug-time">
                            <div class="form-group input-group flex-center">
                                <label class="">Time</label>
                                <div class="input-group date" id="datetimepicker_DrugTime">
                                    <input class="input-style input-type-time" type="text" value="" id="DrugTime" placeholder="hh:mm:ss">
                                    <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                </div> 
                                <input type="hidden" value="" name="DrugTime" id="dtime">
                            </div>
                            <span id="D_time" class="D_time_error"></span>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Dosage</label>
                                <div class="input">
                                    <input type="text" class="input input-style" id="DrugDosage">
                                    <input type="hidden" value="" name="DrugDosage" id="dd">
                                </div>
                            </div>
                            <span id="D_dosage" class="D_dosage_error"></span>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Total Volume</label>
                                <div class="input">
                                    <input type="text" class="input input-style" id="DrugVolume" placeholder="ml">
                                    <input type="hidden" value="" name="DrugVolume" id="dv">
                                </div>
                            </div>
                            <span id="D_volume" class="D_volume_error"></span>
                        </div>
                        <div class="col-lg-1 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <input type="button" class="btn btn-success ml-auto" id="drugsNew" value="Add New" onClick="AddNewDrug()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-6">
                            <table class="table table-bordered table-hover" id="drugHistory" <cfif isDefined('qgetDrugData') AND #qgetDrugData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th>Type</th>
                                        <th>Admin Method</th>
                                        <th>Time</th>
                                        <th>Dosage</th>
                                        <th>Total Volume</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetDrugData')>
                                        <cfloop query="qgetDrugData">
                                            <tr>
                                                <td>#qgetDrugData.Drugtype#</td>
                                                <td>#qgetDrugData.DrugMethod#</td>
                                                <td>#qgetDrugData.DrugTime#</td>
                                                <td>#qgetDrugData.DrugDosage#</td>
                                                <td><cfif #qgetDrugData.DrugVolume# neq 0>#qgetDrugData.DrugVolume#</cfif></td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!---Samples Taken --->
                <div class="form-holder">
                    <h5><strong>Samples Taken</strong></h5>
                    <div class="row">
                        <div class="col-lg-7 col-md-12 sample-one">
                            <div class="input-group mb-1">
                                <div class="col-lg-3 col-md-3 col-sm-4 col-xs-4 flex-center flex-row">
                                    <label class="">Sputum Sample</label>
                                    <div class="radio-buttons"> 
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="1" name="SputumSample" id="SputumSampleyes" <cfif #qLCEData.SputumSample# eq 1>
                                                    checked</cfif>>
                                            <label for="SputumSampleyes">Yes</label>
                                        </div>
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="0" name="SputumSample" id="SputumSampleno" <cfif #qLCEData.SputumSample# eq 0>
                                                    checked</cfif>>
                                            <label for="SputumSampleno">No</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-8 col-xs-8 flex-center ">
                                    <label class="">Collected For</label>

                                    <select class="form-control search-box" multiple="multiple" name="SSCollectedFor" id="SSCollectedFor">
                                        <cfloop from="1" to="#ArrayLen(SSCollectedFor)#" index="j">
                                            <option value="#SSCollectedFor[j]#" <cfif ListFind(ValueList(qLCEData.SSCollectedFor,","),#SSCollectedFor[j]#)>selected</cfif>>#SSCollectedFor[j]#</option>
                                        </cfloop>
                                    </select>
                                    </div>
                            </div>
                            <div class="input-group mb-1">
                                <div class="col-lg-3 col-md-3 col-sm-4 col-xs-4 flex-center flex-row">
                                    <label class="">Skin/Lesion</label>
                                    <div class="radio-buttons"> 
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="1" name="SkinLesion" id="SkinLesionYes" <cfif #qLCEData.SkinLesion# eq 1>
                                                    checked</cfif>>
                                            <label for="SkinLesionYes">Yes</label>
                                        </div>
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="0" name="SkinLesion" id="SkinLesioneNo" <cfif #qLCEData.SkinLesion# eq 0>
                                                    checked</cfif>>
                                            <label for="SkinLesioneNo">No</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-8 col-xs-8 flex-center">
                                    <label class="">Collected For</label>
                                    <select class="form-control search-box" multiple="multiple" name="SLCollectedFor" id="SLCollectedFor">
                                    <cfloop from="1" to="#ArrayLen(SLCollectedFor)#" index="j">
                                            <option value="#SLCollectedFor[j]#" <cfif ListFind(ValueList(qLCEData.SLCollectedFor,","),#SLCollectedFor[j]#)>selected</cfif>>#SLCollectedFor[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                            <div class="input-group mb-1">
                                <div class="col-lg-3 col-md-3 col-sm-4 col-xs-4 flex-center flex-row">
                                    <label class="">Blood Samples</label>
                                    <div class="radio-buttons"> 
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="1" name="BloodSamples" id="BloodSamplesYes" <cfif #qLCEData.BloodSamples# eq 1>
                                                    checked</cfif>>
                                            <label for="BloodSamplesYes">Yes</label>
                                        </div>
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="0" name="BloodSamples" id="BloodSamplesNo" <cfif #qLCEData.BloodSamples# eq 0>
                                                    checked</cfif>>
                                            <label for="BloodSamplesNo">No</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-8 col-xs-8 flex-center form-group">
                                    <label class="">Collected For</label>
                                    <select class="form-control search-box" multiple="multiple" name="BSCollectedFor" id="BSCollectedFor">
                                    <cfloop from="1" to="#ArrayLen(BSCollectedFor)#" index="j">
                                            <option value="#BSCollectedFor[j]#" <cfif ListFind(ValueList(qLCEData.BSCollectedFor,","),#BSCollectedFor[j]#)>selected</cfif>>#BSCollectedFor[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 flex-center">
                                    <label class="">Blood Volume</label>
                                    <div class="input">
                                        <input class="input input-style" type="text" value="#qLCEData.BSBloodVolume#" name="BSBloodVolume">
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-12 sample-two">
                            <div class="input-group">
                                <label class="">Notes</label>
                                <textarea class="form-control textareaCustomReset locations-textarea" name="BSNotes"
                                    maxlength="75">#qLCEData.BSNotes#</textarea>
                            </div>
                        </div>
                    </div>
                        <div class="saperator"></div>
                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group input-group flex-center">
                                <label class="">Biopsy Type</label>
                                <select class="form-control"id="BiopsyType">
                                    <option value="">Select Biopsy Type</option>
                                    <cfloop query="#qgetBiopsyType#">
                                        <cfif status eq 1>
                                            <option value="#qgetBiopsyType.ID#">#qgetBiopsyType.Type#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" name="BiopsyType" id="bte" value="">
                            </div>
                            <sapn id="B_type" class="B_type_error"></sapn>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group input-group flex-center">
                                <label class="">Biopsy Location</label>
                                <select class="form-control"  id="BiopsyLocation">
                                    <option value="">Select Biopsy Location</option>
                                    <cfloop query="#qgetBiopsyLocation#">
                                        <cfif status eq 1>
                                            <option value="#qgetBiopsyLocation.ID#">#qgetBiopsyLocation.Location#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" name="BiopsyLocation" id="bloc" value="">
                            </div>
                            <sapn id="B_location" class="B_location_error"></sapn>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group input-group flex-center">
                                <label class="">Biopsy Size</label>
                                <div class="input">
                                    <input type="text" class="input input-style" id="BiopsySize"
                                    placeholder="cm">
                                    <input type="hidden" name="BiopsySize" id="bsize" value="">
                                </div>
                            </div>
                            <sapn id="B_size" class="B_size_error"></sapn>
                        </div>
                        <div class="col-lg-3 col-md-12">
                            <div class="form-group input-group flex-center">
                                <input type="button" id="BiopsyNew" class="btn btn-success ml-auto"
                                    value="Add New Biopsy" onClick="AddNewBiopsy()">
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-5">
                            <table class="table table-bordered table-hover" id="biopsyHistory" <cfif isDefined('qgetBiopsyData') AND #qgetBiopsyData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th>Biopsy Type</th>
                                        <th>Biopsy Location</th>
                                        <th>Biopsy Size</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetBiopsyData')>
                                        <cfloop query="qgetBiopsyData">
                                            <tr>
                                                <td>#qgetBiopsyData.BiopsyType#</td>
                                                <td>#qgetBiopsyData.BiopsyLocation#</td>
                                                <td>#qgetBiopsyData.BiopsySize#</td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!---Body Conditions --->
                <div class="form-wrapper">
                        <h5 class="mb-1"><strong>Body Conditions</strong></h5>
                    <div class="form-holder">
                        <div class="row">
                            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-6 mb-2">
                                <div class="input-wrap flex-center">
                                <label for="BodyCondition">Body Condition</label>
                                    <select class="form-control" id="BodyCondition" name="BodyCondition">
                                        <option value="">Select Body Condition</option>
                                        <cfloop from="1" to="#ArrayLen(bodyConditions)#" index="j">
                                            <option value="#j#" <cfif #j# eq #qLCEData.BodyCondition#>selected</cfif>>#j&' - '&bodyConditions[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>    
                            <div class="col-lg-12 col-md-12">                    
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>HEAD</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_NuchalCrest">Nuchal Crest:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_NuchalCrest" name="Head_NuchalCrest">
                                                <option value="0">Select Nuchal Crest</option>
                                                <cfloop query="getHeadNuchalCrest">
                                                    <option value="#getHeadNuchalCrest.ID#" <cfif #getHeadNuchalCrest.ID# eq #qLCEData.Head_NuchalCrest#>selected
                                                    </cfif>>#getHeadNuchalCrest.HNC_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_LateralCervicalReg">Lateral Cervical Region:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_LateralCervicalReg" name="Head_LateralCervicalReg">
                                                <option value="0">Select Lateral Cervical Region</option>
                                                <cfloop query="getHeadLateralCervicalReg">
                                                    <option value="#getHeadLateralCervicalReg.ID#" <cfif #getHeadLateralCervicalReg.ID# eq #qLCEData.Head_LateralCervicalReg#>selected
                                                    </cfif>>#getHeadLateralCervicalReg.HLCR_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_FacialBones">Facial Bones:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_FacialBones" name="Head_FacialBones">
                                                <option value="0">Select Facial Bones</option>
                                                <cfloop query="getHeadFacialBones">
                                                    <option value="#getHeadFacialBones.ID#" <cfif #getHeadFacialBones.ID# eq #qLCEData.Head_FacialBones#>selected
                                                    </cfif>>#getHeadFacialBones.HFB_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_EarOS">Ear OS:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_EarOS" name="Head_EarOS">
                                                <option value="0">Select Ear OS</option>
                                                <cfloop query="getHeadEarOS">
                                                    <option value="#getHeadEarOS.ID#" <cfif #getHeadEarOS.ID# eq #qLCEData.Head_EarOS#>selected
                                                    </cfif>>#getHeadEarOS.HEOS_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_ChinSkinFolds">Chin Skin Folds:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_ChinSkinFolds" name="Head_ChinSkinFolds">
                                                <option value="0">Select Chin Skin Folds</option>
                                                <cfloop query="getHeadChinSkinFolds">
                                                    <option value="#getHeadChinSkinFolds.ID#" <cfif #getHeadChinSkinFolds.ID# eq #qLCEData.Head_ChinSkinFolds#>selected
                                                    </cfif>>#getHeadChinSkinFolds.HCSF_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>BODY</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Body_EpaxialMuscle">Epaxial Muscle:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Body_EpaxialMuscle" name="Body_EpaxialMuscle">
                                                <option value="0">Select Epaxial Muscle</option>
                                                <cfloop query="getBodyEpaxialMuscle">
                                                    <option value="#getBodyEpaxialMuscle.ID#" <cfif #getBodyEpaxialMuscle.ID# eq #qLCEData.Body_EpaxialMuscle#>selected
                                                    </cfif>>#getBodyEpaxialMuscle.BEM_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Body_DorsalRidgeScapula">Dorsal Ridge of Scapula:</label> 
                                        <div class="input-wrap">
                                            <select class="form-control" id="Body_DorsalRidgeScapula" name="Body_DorsalRidgeScapula">
                                                <option value="0">Select Dorsal Ridge of Scapula</option>
                                                <cfloop query="getBodyDorsalRidgeScapula">
                                                    <option value="#getBodyDorsalRidgeScapula.ID#" <cfif #getBodyDorsalRidgeScapula.ID# eq #qLCEData.Body_DorsalRidgeScapula#>selected
                                                    </cfif>>#getBodyDorsalRidgeScapula.BDRS_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Body_Ribs">Ribs:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Body_Ribs" name="Body_Ribs">
                                                <option value="0">Select Ribs</option>
                                                <cfloop query="getBodyRibs">
                                                    <option value="#getBodyRibs.ID#" <cfif #getBodyRibs.ID# eq #qLCEData.Body_Ribs#>selected
                                                    </cfif>>#getBodyRibs.BR_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>TAIL:</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Tail_TransversePro">Transverse Processes:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Tail_TransversePro" name="Tail_TransversePro">
                                            <option value="0">Select Transverse Processes</option>
                                            <cfloop query="getTailTransversePro">
                                                <option value="#getTailTransversePro.ID#" <cfif #getTailTransversePro.ID# eq #qLCEData.Tail_TransversePro#>selected
                                                    </cfif>>#getTailTransversePro.TTP_Name#</option>
                                            </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>LESIONS</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Lesion_Present">Lesion Present:</label>
                                        <div class="input-wrap">
                                        <select class="form-control customLesionSelect" id="LesionPresent">
                                            <option value="">Select Lesion Present</option>
                                            <option value="YES">YES</option>
                                            <option value="NO">NO</option>
                                            <option value="CBD">CBD</option> 
                                        </select>
                                        <input type="hidden" name="LesionPresent" id="lpet" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_present" class="Lession_present_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="body_condition">Lesion Type:</label>
                                        <div class="input-wrap">
                                            <select class="form-control customLesionSelect" id="LesionType" >
                                                <option value="">Select Lesion Type</option>
                                                <cfloop query="getLesionTypeData">
                                                    <option value="#getLesionTypeData.LesionTypeName#">#getLesionTypeData.LesionTypeName#</option>
                                                </cfloop>
                                            </select>
                                            <input type="hidden" name="LesionType" id="ltype" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_type" class="Lession_type_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="region">Region:</label>
                                        <div class="input-wrap body-water">
                                            <select class="form-control selected-region"id="Region">
                                            <option value="">Select Region</option>
                                            <cfset counter = 1>
                                                <cfloop query="getRegions">
                                                    <option value="#getRegions.ID#">#counter&' - '&getRegions.RegionName#</option>
                                                    <cfset counter = counter + 1>
                                                </cfloop>
                                            </select>
                                            <input type="hidden"  id="lregion" value="" name="Region">
                                        </div>
                                    </div>
                                    <span id="Lesion_region" class="Lession_region_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Side">Side:</label>
                                        <div class="input-wrap">
                                        <select class="form-control customLesionSelect" id="Side" >
                                            <option value="">Select Side</option>
                                            <cfloop from="1" to="#ArrayLen(sides)#" index="j">
                                                <option value="#sides[j]#">#sides[j]#</option>
                                            </cfloop>
                                        </select>
                                        <input type="hidden" name="Side" id="lside" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_side" class="Lession_side_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Status">Status:</label>
                                        <div class="input-wrap">
                                        <select class="form-control customLesionSelect" id="Status" >
                                            <option value="">Select Status</option>
                                            <option value="Fresh">Fresh</option>
                                            <option value="Healing">Healing</option>
                                            <option value="Healed">Healed</option>
                                        </select>
                                        <input type="hidden" name="Status" id="lstatus" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_status" class="Lession_status_error"></span>
                                </div>
                            </div>
                            <div class="col-lg-1">
                            </div>
                            <div class="col-lg-5 col-md-6 col-sm-12 col-xs-12">
                                <table class="table table-bordered table-hover" id="lesionHistory" <cfif isDefined('qgetLesionData') AND #qgetLesionData.recordcount# gt 0><cfelse> hidden</cfif>>
                                    <thead>
                                        <tr>
                                            <th>Lesion Present</th>
                                            <th>Lesion Type</th>
                                            <th>Region</th>
                                            <th>Side</th>
                                            <th>Status</th>
                                            <cfif isDefined('qgetLesionData')>
                                                <th >Action</th>
                                            </cfif>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <cfif isDefined('qgetLesionData')>
                                        <cfloop query="qgetLesionData">
                                            <tr id="tr_#ID#">
                                                <td id="idd" hidden>#ID#</td>
                                                <td id="L_present#ID#">#qgetLesionData.LesionPresent#</td>
                                                <td id="L_type#ID#">#qgetLesionData.LesionType#</td>
                                                <td id="L_region#ID#">#qgetLesionData.Region#</td>
                                                <td id="L_side#ID#">#qgetLesionData.Side#</td>
                                                <td id="L_status#ID#">#qgetLesionData.Status#</td>
                                                <td id="">
                                                    <div class="tablebutn" style="display: inline-flex;">
                                                        <input type="button" id="edit_button#ID#" value="Edit" class="edit" onclick="edit_row(#ID#)">
                                                        <input type="button" value="Delete"  class="delete" onclick="delete_row(#ID#)" style="margin-left: 5%;">
                                                    </div>
                                                </td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                                </table>
                                <div class="form-group">
                                    <div class="flex-center flex-row">
                                        <button type="button" class="btn blue-btn" id="btn_dolphin_img">Dolphin</button>
                                        <button type="button" class="btn blue-btn" id="btn_whale_img" style="float: right">Whale</button>
                                    </div>
                                    <div class="image-area">
                                        <!---<p class="cetacean-name">Dolphin</p> --->
                                        <img src="http://test.wildfins.org/resources/assets/img/dolphin-breakdown-diagram.png" class="breakdown-image full-width"/>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="idForUpdate" value="">
                            <div class="col-lg-5 col-md-6 col-sm-12 col-xs-12 justify-content-end">
                                <input type="button" class="btn btn-success" id="addNewLesion" value="Add New Lesion" onClick="AddNewLesion()"/>
                            </div>
                                
                        </div>
                    </div>
                </div>
                <!---Physical Exam Notes --->
                <div class="form-wrapper">
                        <h5 class="mb-1"><strong>Physical Exam Notes</strong></h5>
                    <div class="form-holder physical-exam">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">General</label>
                                    <textarea class="form-control textareaCustomReset" name="General">#qLCEData.General#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Scars and Natural Markings</label>
                                    <textarea class="form-control textareaCustomReset" name="SNM">#qLCEData.SNM#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Mentation</label>
                                    <textarea class="form-control textareaCustomReset" name="Mentation">#qLCEData.Mentation#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Palpation</label>
                                    <textarea class="form-control textareaCustomReset" name="Palpation">#qLCEData.Palpation#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Proprioception</label>
                                    <textarea class="form-control textareaCustomReset" name="Proprioception">#qLCEData.Proprioception#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2" id="needcopy">
                                <div class="input-group">
                                    <label class="">Reflexes</label>
                                    <textarea class="form-control textareaCustomReset" name="Reflexes" id="Reflexes">#qLCEData.Reflexes#</textarea>
                                </div>
                                <br>
                            </div>
                            <cfif isDefined('qgetNewSectionData') AND #qgetNewSectionData.recordcount# gt 0>
                                <input type="hidden" id="count" value="#qgetNewSectionData.recordcount#" name="count">
                                <cfloop query="qgetNewSectionData">
                                    <div class="col-lg-12" id="needco#qgetNewSectionData.currentrow#"><br>
                                        <div class="input-group" id="needcopytoo#qgetNewSectionData.currentrow#">
                                            <label class="">New Section #qgetNewSectionData.currentrow# </label>
                                            <textarea class="form-control textareaCustomReset" id="extraNotes#qgetNewSectionData.currentrow#"name="extraNotes#qgetNewSectionData.currentrow#">#qgetNewSectionData.New_Secion#</textarea>
                                        </div>
                                    </div>
                                </cfloop>
                            <cfelse>
                                <input type="hidden" id="count" value="0" name="count">
                            </cfif>
                            <div class="col-lg-12 col-md-12 mt-2 mb-5">
                                <div class="input-group justify-content-end">
                                    <input type="button" id="addnewsec" class="btn btn-success"
                                        value="Add New Section" onClick="AddNewSection()">
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
                                <!--- Fish section --->
                                
                                
                                <!--- Last section --->
                                <div class="form-wrapper">
                                    <div class="row">
                                        <div class="col-lg-8 col-md-12">
                                            <div class="form-holder">
                                                <div class="row">
                                                    <div class="col-lg-2 col-md-3 col-sm-3 col-xs-3">
                                                        <div class="input-group flex-center flex-row">
                                                            <label class="">Entangled</label>
                                                            <div class="radio-buttons"> 
                                                                <div class="radio-btn flex-center flex-row"> 
                                                                    <input type="radio" value="1" name="Entangled" id="Entangledyes" <cfif #qLCEData.Entangled# eq 1>
                                                                    checked</cfif>>
                                                                    <label for="Entangledyes">Yes</label>
                                                                </div>
                                                                <div class="radio-btn flex-center flex-row"> 
                                                                    <input type="radio" value="0" name="Entangled" id="Entangledno" <cfif #qLCEData.Entangled# eq 0>
                                                                    checked</cfif>>
                                                                    <label for="Entangledno">No</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-sm-3 col-xs-3">
                                                        <div class="input-group flex-center flex-row">
                                                            <label class="">Taged</label>
                                                            <div class="radio-buttons"> 
                                                                <div class="radio-btn flex-center flex-row"> 
                                                                    <input type="radio" value="1" name="Taged" id="Tagedyes" <cfif #qLCEData.Taged# eq 1>
                                                                    checked</cfif>>
                                                                    <label for="Tagedyes">Yes</label>
                                                                </div>
                                                                <div class="radio-btn flex-center flex-row"> 
                                                                    <input type="radio" value="0" name="Taged" id="Tagedno" <cfif #qLCEData.Taged# eq 0>
                                                                    checked</cfif>>
                                                                    <label for="Tagedno">No</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-5 col-md-6 col-sm-6 col-xs-6">
                                                        <div class="input-group flex-center mb-1">
                                                            <label class="taged-type">Tag Type</label>
                                                            <div class="input"> 
                                                                <input class="input-style xl-width" type="text" name="TagedType" id="TagedType" value="#qLCEData.TagedType#">
                                                            </div>
                                                        </div>
                
                                                        <div class="input-group flex-center mb-1">
                                                            <label class="">Tag Location</label>
                                                            <div class="input"> 
                                                                <input class="input-style xl-width" type="text" name="TagedLocation" id="TagedLocation" value="#qLCEData.TagedLocation#">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                                                        <div class="input-group flex-center flex-row mb-2">
                                                            <label class="">Released</label>
                                                            <div class="radio-buttons"> 
                                                                <div class="radio-btn flex-center flex-row"> 
                                                                    <input type="radio" value="1" name="Released" id="Releasedyes" <cfif #qLCEData.Released# eq 1>
                                                                    checked</cfif>>
                                                                    <label for="Releasedyes">Yes</label>
                                                                </div>
                                                                <div class="radio-btn flex-center flex-row"> 
                                                                    <input type="radio" value="0" name="Released" id="Releasedno" <cfif #qLCEData.Released# eq 0>
                                                                    checked</cfif>>
                                                                    <label for="Releasedno">No</label>
                                                                </div>
                                                            </div>
                                                            <input type="hidden" name="maxNotes" value="" id="maxNotes">
                                                        </div>
                                                        <div class="input-group flex-center mb-1">
                                                            <label class="last-lat">Lat</label>
                                                            <div class="input"> 
                                                                <input class="input-style xl-width" type="text" name="TagedLat" id="AtLatitudeTaged" value="#qLCEData.TagedLat#">
                                                            </div>
                                                        </div>
                                                        <div class="input-group flex-center mb-1">
                                                            <label class="">Lon</label>
                                                            <div class="input"> 
                                                                <input class="input-style xl-width" type="text" name="TagedLon" id="AtLongitudeTaged" value="#qLCEData.TagedLon#">
                                                            </div>
                                                        </div>
                                                        <div class="justify-content-end">
                                                            <input type="button" id="verify" class="btn btn-skyblue" value="Verify" onclick="checkLatLngTaged()">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                
                                        <div class="col-lg-4 col-md-12">
                                            <div class="form-holder p-0">
                                                <textarea class="form-control textareaCustomReset release-textarea" name="RLD" placeholder="Release Location Description" style="font-style: normal;">#qLCEData.RLD#</textarea> 
                                            </div>
                                        </div>
                
                                    </div>
                                </div>    
                                    <!--- Buttons Section--->
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <!--- <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToHIForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoHIForm" value="Save and go to HI Form" onclick="chkreq(event)"></input>
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoAForm" value="Save and go to Level A Form" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div> --->

                        <div class="row mt-4 file-tabdesign-row">
                            <form id="myform" enctype="multipart/form-data" action="" method="post" >
                                <div class="col-lg-12 dis-flex just-center choose-file-tabdesign">
                                    <div class="form-group select-width">
                                        <cfif (permissions eq "full_access")>
                                            <input type="file" name="CetaceansampleFile" >
                                        </cfif>
                                    </div>
                                    <div class="form-group select-width">
                                        <cfif (permissions eq "full_access")>
                                            <button type="submit" class="btn btn-success">Import</button>
                                        </cfif>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="flex-center flex-wrap bottons-wrap tabdesign-foot-btns">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                <input type="submit" id="deleteAllRecord" name="deleteAllRecord" class="btn btn-orange m-rl-4" value="Delete All Record" onclick="if(confirm('Are you sure to Delete all Records?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
                   
                    </div>
                    <!--- start for HIForm --->
                      <div role="tabpanel" class="tab-pane" id="HIForm">
                    
                        <h5 class="mb-1"><strong>Documents</strong></h5>
                         <input type="hidden" name="HIFormpdfFiles" value="#qgetHIData.pdfFiles#" id="HIFormpdfFiles">
                         <div class="form-holder">  
                            <div class="form-group" id="find">
                                <div class="row" id="start">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <div class="input-group flex-center">
                                                <label class="">Upload PDF File (Max Size: 10MB)</label>
                                                <input class="input-style xl-width" type="file"  name="FileContents" id="files" onchange="HIFormimg()" accept="application/pdf" <cfif findNoCase("Read only ST", permissions) neq 0> Disabled</cfif>>
        
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <cfset imgss = ValueList(qgetHIData.pdfFiles,",")>
                                <div id="HIFormPreviousimages">
                                    <CFIF listLen(imgss)> 
                                        <cfloop list="#imgss#" item="item" index="index">
                        
                                            <span class="pip">
                                                <a data-toggle="modal" data-target="##myHiFormModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                    <img  class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="selectedHIForm(this)"/>
                                                </a>
                                                <br/>
                                                <span class="remove" onclick="removeHiFormPDF(this)" id="#item#">Remove image</span>
                                            </span>
                                        </cfloop>
                                    </cfif>	
                                </div>
                            </div>
                        </div>  
                       

                                <!--- <cfif url.LCE_ID neq 0>
                                    <cfset qgetHIData=Application.Stranding.getHI_ten()>
                                </cfif>
                                <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                                    <cfset form.LCEID = form.HI_ID>
                                    <cfset qgetHIData=Application.Stranding.getHIData(argumentCollection="#Form#")>
                                <cfelse>
                                    <cfset qgetHIData=Application.Stranding.getHI_ten()>
                                </cfif> --->
                                <h5 class="mb-1"><strong>HI Exam</strong></h5>
                                <input type="hidden"  name="HIForm_ID" id="HIForm_ID" value="#qgetHIData.ID#">
                                <!--- <input type="hidden"  name="ID" value="#qgetHIData.ID#"> --->
                                <!--- <input type="hidden" name="LCE_ID" value="#qgetHIData.LCE_ID#"> --->
                                <div class="form-holder">  
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="Examtype-label">Exam type</label>
                                                        <select class="form-control" name="Examtype" id="Examtype">
                                                            <option value="">Select Exam type</option>
                                                            <cfloop from="1" to="#ArrayLen(Examtype)#" index="j">
                                                                <option value="#Examtype[j]#" <cfif #Examtype[j]# eq #qgetHIData.Examtype#>selected</cfif>>#Examtype[j]#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div> 
                                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">HI Findings</label>
                                                        <!--- <input class="finding" type="text" name="Hifindings" id="Hifindings" value="#qgetHIData.Hifindings#"> --->
                                                        <select class="form-control" name="Hifindings" id="Hifindings">
                                                            <option value="">Select</option>
                                                            <option value="Yes"<cfif isdefined('qgetHIData.Hifindings') and #qgetHIData.Hifindings# eq 'Yes'>selected</cfif>>Yes</option>
                                                            <option value="No"<cfif isdefined('qgetHIData.Hifindings') and #qgetHIData.Hifindings# eq 'No'>selected</cfif>>No</option>
                                                            <option value="CBD"<cfif isdefined('qgetHIData.Hifindings') and #qgetHIData.Hifindings# eq 'CBD'>selected</cfif>>CBD</option>
                                                            
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>     
                                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="LocationofHI-label">Location of HI</label>
                                                        <select class="form-control search-box" multiple="multiple" name="LocationofHI" id="LocationofHI">
                                                            <cfloop from="1" to="#ArrayLen(LocationofHI)#" index="j">
                                                                <option value="#LocationofHI[j]#" >#LocationofHI[j]#</option>
                                                            </cfloop>
                                                        </select>
                                                        <input type="hidden" name="HiLocation" id="HiLocation" value="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">Contributed to Stranding Event</label>
                                                        <select class="form-control" name="ContributedtoStrandingEvent" id="ContributedtoStrandingEvent">
                                                            <option value="">Select Contributed to Stranding Event</option>
                                                            <cfloop from="1" to="#ArrayLen(ContributedtoStrandingEvent)#" index="j">
                                                                <option value="#ContributedtoStrandingEvent[j]#" >#ContributedtoStrandingEvent[j]#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>  
                                        </div>
                                        <div class="row">    
                                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">Gear Collected</label>
                                                        <input class="input-style xl-width" type="checkbox" value="1" name="GearCollected" id="GearCollected">
                                                    </div>
                                                    <input type="hidden" name="gearCollected" id="gearCollected" value="">
                                                </div>
                                            </div>    
                                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">Type of HI</label>
                                                        <select class="form-control search-box" multiple="multiple" name="TypeofHI" id="TypeofHI">
                                                            <cfloop from="1" to="#ArrayLen(TypeofHI)#" index="j">
                                                                <option value="#TypeofHI[j]#" >#TypeofHI[j]#</option>
                                                            </cfloop>
                                                        </select>
                                                        <input type="hidden" name="HiType" id="HiType" value="">
                                                    </div>
                                                </div>
                                            </div>                
                                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">Type of Gear Collected</label>
                                                        <select class="form-control search-box" multiple="multiple" name="TypeofGearCollected" id="TypeofGearCollected">
                                                            <cfloop from="1" to="#ArrayLen(TypeofGearCollected)#" index="j">
                                                                <option value="#TypeofGearCollected[j]#">#TypeofGearCollected[j]#</option>
                                                            </cfloop>
                                                        </select>
                                                        <input type="hidden" name="typeOfGearCollected" id="typeOfGearCollected" value="">
                                                    </div>
                                                </div>
                                            </div>                
                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="GearDeposition-label">Gear Deposition</label>
                                                        <select class="form-control" name="GearDeposition" id="GearDeposition">
                                                            <option value="">Select Type of Gear Collected</option>
                                                            <cfloop from="1" to="#ArrayLen(GearDeposition)#" index="j">
                                                                <option value="#GearDeposition[j]#">#GearDeposition[j]#</option>
                                                            </cfloop>
                                                        </select>
                                                        <input type="hidden" name="gearDeposition" id="gearDeposition" value="">
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="hidden" id="idForUpdateHiExam" value="">
                                            <!--- <button type="button" id="addNewHiExam" value="Add New" onclick="AddNewHiExam(this)" class="float-right">Add New</button> --->
                                            <input type="button" class="btn btn-success sbtn" id="addNewHiExam" value="Add New" onClick="AddNewHiExam()"/>
                                            <!--- working start --->
                                            <div class="col-lg-8 col-md-9 col-sm-12 col-xs-12">
                                            <table class="table table-bordered table-hover" id="HiForm" <cfif isDefined('qgetHiExamData') AND #qgetHiExamData.recordcount# gt 0><cfelse> hidden</cfif>>
                                                <thead>
                                                    <tr> 
                                                        <th>Type of HI</th>
                                                        <th>Location of HI</th>
                                                        <th>Gear Collected</th>
                                                        <th>Type of Gear Collected</th>
                                                        <th>Gear Deposition</th>
                                                        <cfif isDefined('qgetHiExamData')>
                                                            <th >Action</th>
                                                        </cfif>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <cfif isDefined('qgetHiExamData')>
                                                        <!--- <cfset myList = ValueList(qgetHIData.TYPEOFHI,",")> --->
                                                        <!--- <cfset myList = ListToArray(qgetHIData.TYPEOFHI)> --->
                                                        <!--- <cfdump var="#qgetHiExamData#" abort="true"> --->
                                                    <cfloop query="qgetHiExamData">
                                                        <tr id="tr_#ID#">
                                                            <td id="idd" hidden>#ID#</td>
                                                            <td id="TYPEOFHI_#ID#"><cfif #qgetHiExamData.TYPEOFHI# eq 0><cfelse>#replace(qgetHiExamData.TYPEOFHI,"-",",","all")#</cfif></td>
                                                            <td id="LocationofHI_#ID#">#replace(qgetHiExamData.LocationofHI,"-",",","all")#</td>
                                                            <td id="GearCollected_#ID#">#qgetHiExamData.GearCollected#</td>
                                                            
                                                            <td id="TypeofGearCollected_#ID#">#replace(qgetHiExamData.TypeofGearCollected,"-",",","all")#</td>
                                                            <!--- <td id="TYPEOFHI_#ID#">#qgetHiExamData.TYPEOFHI#</td> --->
                                                            <td id="GearDeposition_#ID#">#qgetHiExamData.GearDeposition#</td>
                                                            <td id="">
                                                                <div class="tablebutn edbtn" style="display: inline-flex;">
                                                                    <input type="button" id="edit_button#ID#" value="Edit" class="edit" onclick="edit_row(#ID#)">
                                                                    <input type="button" value="Delete"  class="delete" onclick="delete_row(#ID#)" style="margin-left: 5%;">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </cfloop>
                                                </cfif>
                                            </tbody>
                                            </table>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>

                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <div class="flex-center flex-row flex-wrap">
                                        <!--- <div class="flex-center flex-row flex-wrap bottons-wrap">
                                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoAForm" value="Save and go to Level A Form" onclick="chkreq(event)">
                                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                                        </div> --->
                                        <div class="row mt-4 file-tabdesign-row">
                                            <form id="myform" enctype="multipart/form-data" action="" method="post" >
                                                <div class="col-lg-12 dis-flex just-center choose-file-tabdesign">
                                                    <div class="form-group select-width">
                                                        <cfif (permissions eq "full_access")>
                                                            <input type="file" name="HIsampleFile" required>
                                                        </cfif>
                                                    </div>
                                                    <div class="form-group select-width">
                                                        <cfif (permissions eq "full_access")>
                                                            <button type="submit" class="btn btn-success">Import</button>
                                                        </cfif>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="flex-center flex-wrap bottons-wrap tabdesign-foot-btns">
                                            <input type="submit" id="SaveAndNewHI" name="SaveAndNewHI" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                                <input type="submit" id="" name="hiRecordDelete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                
                                            </cfif>
                                            <cfif (permissions eq "full_access")>
                                                <input type="submit" id="deleteAllHiFormRecord" name="deleteAllHiFormRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records?')){}else{return false;};">
                                            </cfif>
                                        </div>
                                    </div>
                                </cfif>
                    <!--- working HIForm--->
                    </div>
                      <div role="tabpanel" class="tab-pane" id="LevelAForm">
                     <!--- working LevelAForm--->
                     <h5 class="mb-1"><strong>Documents</strong></h5>
                     <input type="hidden" name="LApdfFiles" value="#qgetLevelAData.pdfFiles#" id="LApdfFiles">
                     <div class="form-holder">  
                         <div class="form-group" id="find">
                             <div class="row" id="LAstart">
                                 <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                     <div class="form-group">
                                         <div class="input-group flex-center">
                                             <label class="">Upload PDF File (Max Size: 10MB)</label>
                                             <input class="input-style xl-width" type="file"  name="FileContents" id="LevelAFormfiles" onchange="levelAFormimg()" accept="application/pdf" <cfif findNoCase("Read only ST", permissions) neq 0> Disabled</cfif>>
                                         </div>
                                     </div>
                                 </div>
                                 <!--- <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                     <div class="form-group">
                                         <div class="input-group flex-center">
                                             <label class="">NRT Report Filed</label>
                                             <input class="input-style xl-width" type="checkbox" value="1" name="NRT_report" id="NRT_report" <cfif isdefined('qgetLevelAData.NRT_report') and  qgetLevelAData.NRT_report  eq 1>checked</cfif>>
                                         </div>
                                     </div>
                                 </div> --->
                             </div>
                             <cfset imgss = ValueList(qgetLevelAData.pdfFiles,",")>
                             <div id="LevelAFormpreviousimages">
                                 <CFIF listLen(imgss)> 
                                     <cfloop list="#imgss#" item="item" index="index">
                     
                                         <span class="pip">
                                             <a data-toggle="modal" data-target="##myHiFormModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                 <img  class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="selectedHIForm(this)"/>
                                             </a>
                                             <br/>
                                             <span class="remove" onclick="LevelAFormremove(this)" id="#item#">Remove image</span>
                                         </span>
                                     </cfloop>
                                 </cfif>	
                             </div>
                         </div>
                     </div>
                     
                     <!--- <cfif url.LCE_ID neq 0>
                        <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
                    </cfif>
                    <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                        <cfset form.LCEID = form.HI_ID>
                        <cfset qgetLevelAData=Application.Stranding.getLevelAData(argumentCollection="#Form#")>
                    <cfelse>
                        <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
                    </cfif> --->
                    <h5 class="mb-1"><strong>Stranding Event Details</strong></h5>
                    <input type="hidden"  name="level_A_ID" value="#qgetLevelAData.ID#">
                    <!--- <input type="hidden"  name="ID" value="#qgetLevelAData.ID#"> --->
                    <!--- <input type="hidden" name="LCE_ID" value="#qgetLevelAData.LCE_ID#"> --->
                    <div class="form-holder">  
                        <div class="form-group">
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group mt-3">
                                        <div class="input-group flex-center">
                                            <label class="">Initial Live Animal Disposition</label>
                                            <select class="form-control" name="ILAD" id="ILAD">
                                                <option value="">Select Initial Disposition</option>
                                                <cfloop from="1" to="#ArrayLen(ILAD)#" index="j">
                                                    <option value="#ILAD[j]#" <cfif #ILAD[j]# eq #qgetLevelAData.ILAD#>selected</cfif>>#ILAD[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div> 
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 ">
                                    <div class="form-group flex-center">
                                        <label >Comment</label>
                                        <textarea class="form-control textareaCustomReset locations-textarea" name="ILADComment"
                                            maxlength="75">#qgetLevelAData.ILADComment#</textarea>
                                    </div>
                                </div> 
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group mt-3">
                                        <div class="input-group flex-center">
                                            <label class="">Carcass Status</label>
                                            <select class="form-control" name="CarcassStatus" id="CarcassStatus">
                                                <option value="">Select Carcass Status</option>
                                                <cfloop from="1" to="#ArrayLen(CarcassStatus)#" index="j">
                                                    <option value="#CarcassStatus[j]#" <cfif #CarcassStatus[j]# eq #qgetLevelAData.CarcassStatus#>selected</cfif>>#CarcassStatus[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>     
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="CarcassStatusLat-label">Lat</label>
                                            <input class="input-style xl-width" type="text" value="#qgetLevelAData.CarcassStatusLat#" name="CarcassStatusLat" id="CarcassStatusLat">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="CarcassStatusLon-label">Lon</label>
                                            <input class="input-style xl-width" type="text" value="#qgetLevelAData.CarcassStatusLon#" name="CarcassStatusLon" id="CarcassStatusLon">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="form-group justify-content-end">
                                                <input type="button" id="verifyLocation" class="btn btn-skyblue" value="Verify" onclick="checkCarcassStatus()">
                                            </div>
                                        </div>
                                    </div>
                                </div>      
                            </div>
                            <div class="row">    
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="">Group Event</label>
                                            <input class="input-style xl-width" type="checkbox" value="1" name="GroupEvent" id="GroupEvent" <cfif qgetLevelAData.GroupEvent eq 1>checked</cfif>>
                                        </div>
                                    </div>
                                </div>    
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group input-group flex-center">
                                        <label class="">Group Event Type</label>
                                        <div class="input"> 
                                            <select class="form-control" name="GroupEventType"
                                                id="GroupEventType">
                                                <option value="">Select Carcass Status</option>
                                                <cfloop from="1" to="#ArrayLen(LAGroupEventType)#" index="j">
                                                    <option value="#LAGroupEventType[j]#" <cfif #LAGroupEventType[j]# eq #qgetLevelAData.GroupEventType#>selected</cfif>>#LAGroupEventType[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>  
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="noOfAnimals-label">Number of Animals (Max 3 digit)</label>
                                            <input class="input-style xl-width" type="text" value="#qgetLevelAData.noOfAnimals#" name="noOfAnimals" id="noOfAnimals" onchange="maxnum()">
                                        </div>
                                    </div>
                                </div> 
                                <div class="col-lg-3">
                                    <div class="form-group input-group flex-center">
                                        <label>Tags Were</label>
                                        <div class="input"> 
                                            <select class="form-control search-box" multiple="multiple" name="TagsWere"
                                            id="TagsWere">
                                            <cfloop from="1" to="#ArrayLen(TagsWere)#" index="j">
                                                <option value="#TagsWere[j]#" <cfif ListFind(ValueList(qgetLevelAData.TagsWere,","),#TagsWere[j]#)>selected</cfif>>#TagsWere[j]#</option>
                                            </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="">Restrand</label>
                                            <input class="input-style xl-width" type="checkbox" value="1" name="Restrand" id="Restrand" <cfif qgetLevelAData.Restrand eq 1>checked</cfif>>
                                        </div>
                                    </div>
                                </div>   
                            </div>
                        </div>
                    </div>
                    <cfif findNoCase("Read only ST", permissions) eq 0>
                        <div class="flex-center flex-row flex-wrap">
                            <!--- <div class="flex-center flex-row flex-wrap bottons-wrap">
                                <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoHistopathology" value="Save and go to Histopathology" onclick="chkreq(event)">
                                <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report" onclick="chkreq(event)">
                                <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                            </div> --->
                            <div class="row mt-4 file-tabdesign-row">
                                <form id="myform" enctype="multipart/form-data" action="" method="post" >
                                    <div class="col-lg-12 dis-flex just-center choose-file-tabdesign">
                                        <div class="form-group select-width">
                                            <cfif (permissions eq "full_access")>
                                                <input type="file" name="LevelAsampleFile" required>
                                            </cfif>
                                        </div>
                                        <div class="form-group select-width">
                                            <cfif (permissions eq "full_access")>
                                                <button type="submit" class="btn btn-success">Import</button>
                                            </cfif>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="flex-center flex-wrap bottons-wrap tabdesign-foot-btns">
                                <input type="submit" id="SaveAndNew" name="SaveAndNewLA" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                                <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose"value="Save and Close" onclick="chkreq(event)"> --->
                                <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                    <input type="submit" id="" name="levelAformDelete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                                </cfif>
                                <cfif (permissions eq "full_access")>
                                     <input type="submit" id="deleteAllLevelAFormRecord" name="deleteAllLevelAFormRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records ?')){}else{return false;};">
                                </cfif>
                            </div> 
                        </div>
                    </cfif>
                    
                    </div>
                    <!--- start for histo --->
            <div role="tabpanel" class="tab-pane" id="HistoForm">
                    
                     <!---  Following logic to get the data from the HI table and seting value to qgetHIData variable --->
                <!--- <cfif url.LCE_ID neq 0>
                    <cfset qgetHIData=Application.Stranding.getHisto_ten()>
                </cfif>
                <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                    <cfset form.LCEID = form.HI_ID>
                    <cfset qgetHIData=Application.Stranding.getHistoData(argumentCollection="#Form#")>
                    <input type="hidden" name="LCE_ID" value="#qgetHIData.LCE_ID#">
                <cfelse>
                    <cfset qgetHIData=Application.Stranding.getHisto_ten()>
                <input type="hidden" name="LCE_ID" value="#url.LCE_ID#">
                </cfif> --->
                
                <input type="hidden"  name="Histo_ID" value="#qgetHIDataa.ID#">
                <!--- <input type="hidden"  name="ID" value="#qgetHIDataa.ID#"> --->
                
                <!--- this input field is using for check in stranding.cfc for general Update function --->
                <!--- <input type="hidden"  name="check" value="1">
                <input type="hidden" name="histopathology_fields" value="1"> --->
                <div class="form-holder">  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"> 
                                <div class="form-group flex-center">
                                    <label class="">Histopathology Date</label>
                                        <div class="input-group date " id="datetimepicker_Date_sad">
                                            <input type="text" placeholder="YYYY-MM-DD" name="HistopathologyDate" id="HistopathologyDate"
                                            class="form-control" value='#DateTimeFormat(qgetHIDataa.histoDate, "YYYY-MM-DD")#' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                        </div>
                                </div>
                                <input type="hidden" value="" name="SADate" id="sad">
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Pathologist Accession Number</label>
                                        <input class="input-style xl-width" type="text" value="#qgetHIDataa.PathologistAccession#" name="PathologistAccession" id="PathologistAccession">
                                    </div>
                                </div>
                            </div>                
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group input-group flex-center">
                                    <label class="lab-label">Diagnostic Lab</label>
                                    <select class="form-control" name="LabSentto" id="LabSentto">
                                        <option value="">Select Diagnostic Lab</option>
                                        <cfloop query="#qgetDiagnosticLab#">
                                            <cfif status eq 1>
                                                <option value="#qgetDiagnosticLab.ID#"<cfif #qgetHIDataa.DiagnosticLab# eq #qgetDiagnosticLab.ID#>selected</cfif>>#qgetDiagnosticLab.Diagnostic#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                    <input type="hidden" value="" name="LabSentto" id="lsto">
                                </div>
                            </div>                
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 ">
                                <div class="form-group flex-center">
                                    <label class="scomment-label">Sample Comments</label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" id="SampleCommentsID" name="SampleComments">
                                        #trim(qgetHIDataa.SampleComments)#
                                    </textarea>
                                </div>
                            </div>             
                        </div>
                    </div>
                </div>

                <!---Sample Collection --->
                <div class="form-holder blue-bg sample-type-form">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group">
                                <div class="input-group flex-center" id="sampleT">
                                    <label class="county-label ">Sample Type</label>
                                    <select class="form-control search-box" name="" id="SampleType">
                                        <option value="">Select Sample</option>
                                        <cfloop query="qgetSampleType">
                                            <cfif status  neq 0>
                                                <option value="#qgetSampleType.ID#">#qgetSampleType.Type#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" name="SampleType" id="stype">
                            </div>
                            <span id="stypee" class="sampleType_error"></span>
                        </div>
                    
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group flex-center">
                                <label class="snotes-label">Results</label>
                                <textarea type="text" class="form-control textareaCustomReset locations-textarea" id="SampleNote" maxlength="2084"></textarea>
                                <input type="hidden" name="SampleNote" id="snotes">
                            </div>
                        </div>
                        <input type="hidden" name="tables" id="tables">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <input type="button" class="btn btn-success ml-auto" id="drugsNew" value="Add New" onClick="AddDrug()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table simple-type-table table-bordered table-hover" id="drugHistorya" <cfif isDefined('qgetHistoSampleData') AND #qgetHistoSampleData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th class="col-lg-4">Sample Type</th>
                                        <th>Result</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetHistoSampleData')>
                                        <cfloop query="qgetHistoSampleData">
                                            <tr>
                                                <td>#qgetHistoSampleData.SampleType#</td>
                                                <td><cfif #qgetHistoSampleData.SampleNote# neq 0>#qgetHistoSampleData.SampleNote#</cfif></td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <!--- <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoBloodForm" value="Save and go to Blood Values" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div> --->
                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="HistoSaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                <input type="submit" id="" name="histoDelete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                <input type="submit" id="deleteHIstoRecord" name="deleteHIstoRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete all Records?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
                    
            </div>
            
            <!--- Start for blood value --->
            <div role="tabpanel" class="tab-pane" id="BloodValue">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"> 
                        <div class="form-group blood-from-froup flex-center flex-wrap-wrap">
                            <label class="date-padd">Collection Date</label>
                                <div class="input-group date" id="collection_date_picker">
                                    <input type="text" placeholder="YYYY-MM-DD" name="collection_date" id="collection_date"
                                        class="form-control" value='#DateTimeFormat(qgetBloodValueData.Collection_Date, "YYYY-MM-DD")#'  />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"> 
                        <div class="form-group blood-from-froup flex-center flex-wrap-wrap">
                            <label class="date-padd">Analysis Date</label>
                                <div class="input-group date " id="datetimepicker_Datee">
                                    <input type="text" placeholder="YYYY-MM-DD" name="Analysis_date" id="Analysis_date"
                                        class="form-control" value='#DateTimeFormat(qgetBloodValueData.Analysis_date, "YYYY-MM-DD")#'  />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <div class="form-group blood-from-froup input-group flex-center flex-wrap-wrap">
                            <label class="lab-label">Diagnostic Lab</label>
                            <select class="form-control" name="LabSentto" id="LabSentto">
                                <option value="">Select Lab</option>
                                <cfloop query="#qgetDiagnosticLab#">
                                    <cfif status eq 1>
                                        <option value="#qgetDiagnosticLab.ID#" <cfif #qgetDiagnosticLab.ID# eq #qgetBloodValueData.Diagnostic_Lab#>selected</cfif> >#qgetDiagnosticLab.Diagnostic#</option>
                                    </cfif>
                                </cfloop>
                            </select>
                            <input type="hidden" value="" name="LabSentto" id="lsto">
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"> 
                        <div class="form-group blood-from-froup">
                            <div class="input-group flex-center flex-wrap-wrap">
                                <label class="">Lab number</label>
                                <input class="input-style xl-width" type="text" value="#qgetBloodValueData.Lab_Number#" name="Lab_num" id="NMFS">
                            </div>
                        </div>
                    </div> 
                </div>


                <h5 class="mb-1"><strong>CBC</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">WBC Count</label>
                                        <input class="wbc_count" type="text" maxlength="8" value="#qgetCBC_Data.wbc_count#" name="wbc_count"  id="wbc_count"> 
                                        <span> &##215; 10<sup>3</sup>&##8725;&mu;l</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="wbc_report" id="wbc_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.wbc_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="wbc_comment" id="wbc_comment"
                                     >#qgetCBC_Data.wbc_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">RBC Count</label>
                                        <input class="RBC_count" type="text" maxlength="8" value="#qgetCBC_Data.RBC_count#" name="RBC_count"  id="RBC_count"> <span> &##215; 10<sup>6</sup>&##8725;&mu;l</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="RBC_count_report" id="RBC_count_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.RBC_report #>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="RBC_count_comment" id="RBC_count_comment"
                                         >#qgetCBC_Data.RBC_count_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hemoglobin</label>
                                        <input class="Hemoglobin" type="text" maxlength="8" value="#qgetCBC_Data.Hemoglobin#" name="Hemoglobin"  id="Hemoglobin"> <span>g/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hemoglobin_report" id="Hemoglobin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Hemoglobin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Hemoglobin_comment" id="Hemoglobin_comment"
                                         >#qgetCBC_Data.Hemoglobin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hematocrit %</label>
                                        <input class="Hematocrit" type="text" maxlength="8" value="#qgetCBC_Data.Hematocrit#" name="Hematocrit"  id="Hematocrit"> <span>% </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hematocrit_report" id="Hematocrit_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Hematocrit_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Hematocrit_comment" id="Hematocrit_comment"
                                         >#qgetCBC_Data.Hematocrit_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">MCV fL</label>
                                        <input class="MCV" type="text" maxlength="8" value="#qgetCBC_Data.MCV#" name="MCV"  id="MCV"><span>fL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="MCV_report" id="MCV_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.MCV_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="MCV_comment" id="MCV_comment"
                                         >#qgetCBC_Data.MCV_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">MCH pg</label>
                                        <input class="MCH" type="text" maxlength="8" value="#qgetCBC_Data.MCH#" name="MCH"  id="MCH"><span>pg </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="MCH_report" id="MCH_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.MCH_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="MCH_comment" id="MCH_comment"
                                         >#qgetCBC_Data.MCH_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">MCHC %</label>
                                        <input class="MCHC" type="text" maxlength="8" value="#qgetCBC_Data.MCHC#" name="MCHC"  id="MCHC"><span>%</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="MCHC_report" id="MCHC_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.MCHC_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="MCHC_comment" id="MCHC_comment"
                                         >#qgetCBC_Data.MCHC_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Segmented Neutrophils Abs</label>
                                        <input class="Segmented_Neutrophils_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Segmented_Neutrophils_Abs#" name="Segmented_Neutrophils_Abs"  id="Segmented_Neutrophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Segmented_report" id="Segmented_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Segmented_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Segmented_comment" id="Segmented_comment"
                                         >#qgetCBC_Data.Segmented_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Band Neutrophils Abs </label>
                                        <input class="Band_Neutrophils_Abs " type="text" maxlength="8" value="#qgetCBC_Data.Band_Neutrophils_Abs#" name="Band_Neutrophils_Abs"  id="Band_Neutrophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Band_Neutrophils_report" id="Neutrophils_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Band_Neutrophils_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Band_Neutrophils_comment" id="Neutrophils_comment"
                                         >#qgetCBC_Data.Band_Neutrophils_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lymphocytes Abs</label>
                                        <input class="Lymphocytes_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Lymphocytes_Abs#" name="Lymphocytes_Abs"  id="Lymphocytes_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lymphocytes_report" id="Lymphocytes_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Lymphocytes_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Lymphocytes_comment" id="Lymphocytes_comment"
                                         >#qgetCBC_Data.Lymphocytes_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Monocytes Abs</label>
                                        <input class="Monocytes_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Monocytes_Abs#" name="Monocytes_Abs"  id="Monocytes_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Monocytes_report" id="Monocytes_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Monocytes_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Monocytes_comment" id="Monocytes_comment"
                                         >#qgetCBC_Data.Monocytes_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Eosinophils Abs</label>
                                        <input class="Eosinophils_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Eosinophils_Abs#" name="Eosinophils_Abs"  id="Eosinophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Eosinophils_report" id="Eosinophils_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Eosinophils_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Eosinophils_comment" id="Eosinophils_comment"
                                     >#qgetCBC_Data.Eosinophils_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Basophils Abs</label>
                                        <input class="Basophils_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Basophils_Abs#" name="Basophils_Abs"  id="Basophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Basophils_report" id="Basophils_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Basophils_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Basophils_comment" id="Basophils_comment"
                                         >#qgetCBC_Data.Basophils_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">NRBC</label>
                                        <input class="NRBC" type="text" maxlength="8" value="#qgetCBC_Data.NRBC#" name="NRBC"  id="NRBC"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="NRBC_report" id="NRBC_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.NRBC_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="NRBC_comment" id="NRBC_comment"
                                         >#qgetCBC_Data.NRBC_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="county-label">RBC Morphology</label>
                                        <select class="form-control" name="RBC_Morphology" id="RBC_Morphology">
                                            <option value="">Select RBC Morphology</option>
                                            <cfloop query="qgetRBCMorphology">
                                                <cfif status  neq 0>
                                                    <option value="#qgetRBCMorphology.RBC#" <cfif #qgetRBCMorphology.RBC# eq #qgetCBC_Data.RBC_Morphology#>selected</cfif>>#qgetRBCMorphology.RBC#</option>
                                                </cfif>
                                            </cfloop>
                                        </select> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="RBC_report" id="RBC_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.RBC_count_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="RBC_comment" id="RBC_comment"
                                         >#qgetCBC_Data.RBC_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Platelet Count (auto)</label>
                                        <input class="Platelet_Count" type="text" maxlength="8" value="#qgetCBC_Data.Platelet_Count#" name="Platelet_Count"  id="Platelet_Count"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Platelet_Count_report" id="Platelet_Count_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Platelet_Count_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Platelet_Count_comment" id="Platelet_Count_comment"
                                         >#qgetCBC_Data.Platelet_Count_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="county-label">Platelet Morphology</label>
                                        <select class="form-control" name="Platelet_Morphology" id="Platelet_Morphology">
                                            <option value="">Select Platelet Morphology</option>
                                            <cfloop query="qgetPlateletMorphology">
                                                <cfif status  neq 0>
                                                    <option value="#qgetPlateletMorphology.Platelet#" <cfif #qgetPlateletMorphology.Platelet# eq #qgetCBC_Data.Platelet_Morphology#>selected</cfif>>#qgetPlateletMorphology.Platelet#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Platelet_report" id="Platelet_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Platelet_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Platelet_comment" id="Platelet_comment"
                                         >#qgetCBC_Data.Platelet_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="county-label">WBC Morphology</label>
                                        <select class="form-control" name="WBC_Morphology" id="WBC_Morphology">
                                            <option value="">Select WBC Morphology</option>
                                            <cfloop query="qgetWbcMorphology">
                                                <cfif status  neq 0>
                                                    <option value="#qgetWbcMorphology.ID#" <cfif #qgetWbcMorphology.ID# eq #qgetCBC_Data.WBC_Morphology#>selected</cfif>>#qgetWbcMorphology.WBC#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="WBCMorphology_report" id="WBCMorphology_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.WBCMorphology_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="WBCMorphology_comment" id="WBCMorphology_comment"
                                         >#qgetCBC_Data.WBCMorphology_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                
                <h5 class="mb-1"><strong>Fibrinogen</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Fibrinogen</label>
                                        <input class="Fibrinogen" type="text" maxlength="8" value="#qgetFibrinogen.Fibrinogen#" name="Fibrinogen"  id="Fibrinogen"><span>mg/dl</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Fibrinogen_report" id="Fibrinogen_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetFibrinogen.Fibrinogen_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Fibrinogen_comment" id="Fibrinogen_comment"
                                         >#qgetFibrinogen.Fibrinogen_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>Chemistry</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total protein (refractometer)</label>
                                        <input class="Total_protein" type="text" maxlength="8" value="#qgetchemistry.Total_protein_refractometer #" name="Total_protein_refractometer"  id="Total_protein_refractometer"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="protein_refractometer_report" id="protein_refractometer_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.protein_refractometer_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="protein_refractometer_comment" id="protein_refractometer_comment"
                                         >#qgetchemistry.protein_refractometer_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hemolysis Index</label>
                                        <select class="form-control" name="Hemolysis_Index" id="Hemolysis_Index">
                                            <option value="">Select Hemolysis Index</option>
                                            <cfloop query="qgetHemolysisIndex">
                                                <cfif status  neq 0>
                                                    <option value="#qgetHemolysisIndex.ID#" <cfif #qgetHemolysisIndex.ID# eq qgetchemistry.Hemolysis_Index>selected</cfif>>#qgetHemolysisIndex.Hemolysis#</option>
                                                </cfif>
                                            </cfloop>
                                        </select> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hemolysis_report" id="Hemolysis_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Hemolysis_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Hemolysis_comment" id="Hemolysis_comment"
                                         >#qgetchemistry.Hemolysis_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lipemia Index</label>
                                        <select class="form-control" name="Lipemia_Index" id="Lipemia_Index">
                                            <option value="">Select Lipemia Index</option>
                                            <cfloop query="qgetLipemiaIndex">
                                                <cfif status  neq 0>
                                                    <option value="#qgetLipemiaIndex.ID#" <cfif #qgetLipemiaIndex.ID# eq qgetchemistry.Lipemia_Index>selected</cfif>>#qgetLipemiaIndex.Lipemia#</option>
                                                </cfif>
                                            </cfloop>
                                        </select> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lipemia_report" id="Lipemia_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Lipemia_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Lipemia_comment" id="Lipemia_comment"
                                         >#qgetchemistry.Lipemia_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Glucose</label>
                                        <input class="Glucose" type="text" maxlength="8" value="#qgetchemistry.Glucose#" name="Glucose"  id="Glucose"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Glucose_report" id="Glucose_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Glucose_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Glucose_comment" id="Glucose_comment"
                                         >#qgetchemistry.Glucose_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BUN</label>
                                        <input class="BUNf" type="text" maxlength="8" value="#qgetchemistry.BUNf#" name="BUNf"  id="BUNf"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Bunf_report" id="Bunf_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Bunf_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="BUNf_comment" id="BUNf_comment"
                                         >#qgetchemistry.BUNf_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">CREA</label>
                                        <input class="CREA" type="text" maxlength="8" value="#qgetchemistry.CREA#" name="CREA"  id="CREA"><span> mg/dL</span>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="CREA_report" id="CREA_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.CREA_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="CREA_comment" id="CREA_comment"
                                         >#qgetchemistry.CREA_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BUN/CREA Ratio</label>
                                        <input class="BUN_CREA" type="text" maxlength="8" value="#qgetchemistry.BUN_CREA#" name="BUN_CREA"  id="BUN_CREA"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Bun_Crea_report" id="Bun_Crea_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Bun_Crea_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="BUN_CREA_comment" id="BUN_CREA_comment"
                                         >#qgetchemistry.BUN_CREA_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Sodium</label>
                                        <input class="Sodium" type="text" maxlength="8" value="#qgetchemistry.Sodium#" name="Sodium"  id="Sodium"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Sodium_report" id="Sodium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Sodium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Sodium_comment" id="Sodium_comment"
                                         >#qgetchemistry.Sodium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Potassium</label>
                                        <input class="Potassium" type="text" maxlength="8" value="#qgetchemistry.Potassium#" name="Potassium"  id="Potassium"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Potassium_report" id="Potassium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Potassium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Potassium_comment" id="Potassium_comment"
                                         >#qgetchemistry.Potassium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Chloride</label>
                                        <input class="Chloride" type="text" maxlength="8" value="#qgetchemistry.Chloride#" name="Chloride"  id="Chloride"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Chloride_report" id="Chloride_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Chloride_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Chloride_comment" id="Chloride_comment"
                                         >#qgetchemistry.Chloride_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Magnesium</label>
                                        <input class="Magnesium" type="text" maxlength="8" value="#qgetchemistry.Magnesium#" name="Magnesium"  id="Magnesium"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Magnesium_report" id="Magnesium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Magnesium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Magnesium_comment" id="Magnesium_comment"
                                         >#qgetchemistry.Magnesium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Calcium</label>
                                        <input class="Calcium" type="text" maxlength="8" value="#qgetchemistry.Calcium#" name="Calcium"  id="Calcium"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Calcium_report" id="Calcium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Calcium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Calcium_comment" id="Calcium_comment"
                                         >#qgetchemistry.Calcium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Phosphorus</label>
                                        <input class="Phosphorus" type="text" maxlength="8" value="#qgetchemistry.Phosphorus#" name="Phosphorus"  id="Phosphorus"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Phosphurs_report" id="Phosphurs_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Phosphurs_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Phosphorus_comment" id="Phosphorus_comment"
                                         >#qgetchemistry.Phosphorus_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Ca/Phos Ratio</label>
                                        <input class="Ca_Phos" type="text" maxlength="8" value="#qgetchemistry.Ca_Phos#" name="Ca_Phos"  id="Ca_Phos"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Ca_Phos_report" id="Ca_Phos_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Ca_Phos_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Ca_Phos_comment" id="Ca_Phos_comment"
                                         >#qgetchemistry.Ca_Phos_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">CO<sup>2</sup></label>
                                        <input class="CO" type="text" maxlength="8" value="#qgetchemistry.CO#" name="CO"  id="CO"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Co_report" id="Co_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Co_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="CO_comment" id="CO_comment"
                                         >#qgetchemistry.CO_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Amylase</label>
                                        <input class="Amylase" type="text" maxlength="8" value="#qgetchemistry.Amylase#" name="Amylase"  id="Amylase"><span>U/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Amylase_report" id="Amylase_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Amylase_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Amylase_comment" id="Amylase_comment"
                                         >#qgetchemistry.Amylase_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lipase </label>
                                        <input class="Lipase " type="text" maxlength="8" value="#qgetchemistry.Lipase#" name="Lipase"  id="Lipase "><span>U/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lipase_report" id="Lipase_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Lipase_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Lipase_comment" id="Lipase_comment"
                                         >#qgetchemistry.Lipase_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Cholesterol</label>
                                        <input class="Cholesterol" type="text" maxlength="8" value="#qgetchemistry.Cholesterol#" name="Cholesterol"  id="Cholesterol"><span>mg/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Cholesterol_report" id="Cholesterol_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Cholesterol_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Cholesterol_comment" id="Cholesterol_comment"
                                         >#qgetchemistry.Cholesterol_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Uric Acid</label>
                                        <input class="Uric_Acid" type="text" maxlength="8" value="#qgetchemistry.Uric_Acid#" name="Uric_Acid"  id="Uric_Acid"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Uric_report" id="Uric_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Uric_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Uric_comment" id="Uric_comment"
                                         >#qgetchemistry.Uric_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total Protein</label>
                                        <input class="Total_Protein" type="text" maxlength="8" value="#qgetchemistry.Total_Protein#" name="Total_Protein"  id="Total_Protein"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Protein2_report" id="Protein2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Protein2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Protein2_comment" id="Protein2_comment"
                                         >#qgetchemistry.Protein2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Albumin</label>
                                        <input class="Albumin" type="text" maxlength="8" value="#qgetchemistry.Albumin#" name="Albumin"  id="Albumin"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Albumin_report" id="Albumin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Albumin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Albumin_comment" id="Albumin_comment"
                                         >#qgetchemistry.Albumin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">A/G Ratio</label>
                                        <input class="A_G" type="text" maxlength="8" value="#qgetchemistry.A_G#" name="A_G"  id="A_G"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="A_G_report" id="A_G_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.A_G_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="A_G_comment" id="A_G_comment"
                                         >#qgetchemistry.A_G_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">AST</label>
                                        <input class="AST" type="text" maxlength="8" value="#qgetchemistry.AST#" name="AST"  id="AST"><span> U/L </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="AST_report" id="AST_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.AST_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="AST_comment" id="AST_comment"
                                         >#qgetchemistry.AST_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">ALT</label>
                                        <input class="ALT" type="text" maxlength="8" value="#qgetchemistry.ALT#" name="ALT"  id="ALT"><span> U/L </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="ALT_report" id="ALT_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.ALT_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="ALT_comment" id="ALT_comment"
                                         >#qgetchemistry.ALT_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">LDH</label>
                                        <input class="LDH" type="text" maxlength="8" value="#qgetchemistry.LDH#" name="LDH"  id="LDH"><span> U/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="LDH_report" id="LDH_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.LDH_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="LDH_comment" id="LDH_comment"
                                         >#qgetchemistry.LDH_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">CPK</label>
                                        <input class="CPK" type="text" maxlength="8" value="#qgetchemistry.CPK#" name="CPK"  id="CPK"><span> U/L <span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="CPK_report" id="CPK_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.CPK_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="CPK_comment" id="CPK_comment"
                                         >#qgetchemistry.CPK_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Alkaline Phosphatase</label>
                                        <input class="Alkaline_Phosphatase" type="text" maxlength="8" value="#qgetchemistry.Alkaline_Phosphatase#" name="Alkaline_Phosphatase"  id="Alkaline_Phosphatase"><span> U/L <span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Alkaline_report" id="Alkaline_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Alkaline_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Alkaline_comment" id="Alkaline_comment"
                                         >#qgetchemistry.Alkaline_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">GGT</label>
                                        <input class="GGT" type="text" maxlength="8" value="#qgetchemistry.GGT#" name="GGT"  id="GGT"><span> U/L </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="GGT_report" id="GGT_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.GGT_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="GGT_comment" id="GGT_comment"
                                         >#qgetchemistry.GGT_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total Bilirubin</label>
                                        <input class="Total_Bilirubin" type="text" maxlength="8" value="#qgetchemistry.Total_Bilirubin#" name="Total_Bilirubin"  id="Total_Bilirubin"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Bilirubin_report" id="Bilirubin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Bilirubin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Bilirubin_comment" id="Bilirubin_comment"
                                         >#qgetchemistry.Bilirubin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Direct Bilirubin</label>
                                        <input class="Direct_Bilirubin" type="text" maxlength="8" value="#qgetchemistry.Direct_Bilirubin#" name="Direct_Bilirubin"  id="Direct_Bilirubin"><span> mg/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="D_Bilirubin_report" id="D_Bilirubin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.D_Bilirubin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="D_Bilirubin_comment" id="D_Bilirubin_comment"
                                         >#qgetchemistry.D_Bilirubin_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>Capillary Zone Electrophoresis</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total Protein</label>
                                        <input class="Total_Protein_cap" type="text" maxlength="8" value="#qgetCapillary.Total_Protein_cap#" name="Total_Protein_cap"  id="Total_Protein_cap"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Total_Protein_cap_report" id="Total_Protein_cap_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Total_Protein_cap_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Total_Protein_cap_comment" id="Total_Protein_cap_comment"
                                     >#qgetCapillary.Total_Protein_cap_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">A/G ratio</label>
                                        <input class="A_G_ration" type="text" maxlength="8" value="#qgetCapillary.A_G_ration#" name="A_G_ration"  id="A_G_ration"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="A_G_ration_report" id="A_G_ration_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.A_G_ration_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="A_G_ration_comment" id="A_G_ration_comment"
                                     >#qgetCapillary.A_G_ration_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Pre Albumin</label>
                                        <input class="Pre_Albumin" type="text" maxlength="8" value="#qgetCapillary.Pre_Albumin#" name="Pre_Albumin"  id="Pre_Albumin"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Pre_Albumin_report" id="Pre_Albumin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Pre_Albumin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Pre_Albumin_comment" id="Pre_Albumin_comment"
                                     >#qgetCapillary.Pre_Albumin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Albumin</label>
                                        <input class="Albumin" type="text" maxlength="8" value="#qgetCapillary.Albumin2#" name="Albumin2"  id="Albumin2"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Albumin2_report" id="Albumin2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Albumin2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Albumin2_comment" id="Albumin2_comment"
                                     >#qgetCapillary.Albumin2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Alpha 1</label>
                                        <input class="Alpha_1" type="text" maxlength="8" value="#qgetCapillary.Alpha_1#" name="Alpha_1"  id="Alpha_1"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Alpha_1_report" id="Alpha_1_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Alpha_1_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Alpha_1_comment" id="Alpha_1_comment"
                                     >#qgetCapillary.Alpha_1_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Alpha 2</label>
                                        <input class="Alpha_2" type="text" maxlength="8" value="#qgetCapillary.Alpha_2#" name="Alpha_2"  id="Alpha_2"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Alpha_2_report" id="Alpha_2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Alpha_2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Alpha_2_comment" id="Alpha_2_comment"
                                     >#qgetCapillary.vAlpha_2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Beta 1</label>
                                        <input class="Beta_1" type="text" maxlength="8" value="#qgetCapillary.Beta_1#" name="Beta_1"  id="Beta_1"><span> g/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Beta_1_report" id="Beta_1_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Beta_1_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Beta_1_comment" id="Beta_1_comment"
                                     >#qgetCapillary.Beta_1_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Beta 2</label>
                                        <input class="Beta_2" type="text" maxlength="8" value="#qgetCapillary.Beta_2#" name="Beta_2"  id="Beta_2"><span> g/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Beta_2_report" id="Beta_2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Beta_2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Beta_2_comment" id="Beta_2_comment"
                                     >#qgetCapillary.Beta_2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Beta Total</label>
                                        <input class="Beta_Total" type="text" maxlength="8" value="#qgetCapillary.Beta_Total#" name="Beta_Total"  id="Beta_Total"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Beta_Total_report" id="Beta_Total_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Beta_Total_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Beta_Total_comment" id="Beta_Total_comment"
                                     >#qgetCapillary.Beta_Total_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Gamma</label>
                                        <input class="Gamma" type="text" maxlength="8" value="#qgetCapillary.Gamma#" name="Gamma"  id="Gamma"><span> g/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Gamma_report" id="Gamma_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Gamma_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Gamma_comment" id="Gamma_comment"
                                     >#qgetCapillary.Gamma_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>Dolphin SAA</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Dolphin SAA</label>
                                        <input class="Dolphin_SAA" type="text" maxlength="8" value="#qgetDolphin.Dolphin_SAA#" name="Dolphin_SAA"  id="Dolphin_SAA"><span>mg/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Dolphin_SAA_report" id="Dolphin_SAA_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetDolphin.Dolphin_SAA_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Dolphin_SAA_comment" id="Dolphin_SAA_comment"
                                     >#qgetDolphin.Dolphin_SAA_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>ISTAT- Chem 8+</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup cust-date-r">
                                    <label class="date-padd">Date</label>
                                    <div class="input-group date " id="Chem_date_picker">
                                        <input type="text" maxlength="8" placeholder="YYYY-MM-DD" name="Chem_date" id="Chem_date"
                                        class="form-control" value='#DateTimeFormat(qgetiSTAT_Chem.Chem_date, "YYYY-MM-DD")#'  />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div> 
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <label class="start-time">Time</label>
                                    <div class="input-group date " id="datetimepicker_Chem_dateTime">
                                        <input type="text" maxlength="8" value="#TimeFormat(qgetiSTAT_Chem.Chem_dateTime, "HH:nn")#" placeholder="hh:mm:ss" name="Chem_dateTime" id="Chem_dateTime"
                                        class="form-control" />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Operator</label>
                                        <select class="form-control" name="Operator_chem" id="Operator_chem">
                                            <cfloop query="getTeams">
                                                <cfif active eq 1>
                                                    <option value="#getTeams.RT_ID#" <cfif #getTeams.RT_ID# eq #qgetiSTAT_Chem.Operator_che#>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Na</label>
                                        <input class="Na" type="text" maxlength="8" value="#qgetiSTAT_Chem.Na#" name="Na"  id="Na"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Na_report" id="Na_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Na_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Na_comment" id="Na_comment"
                                     >#qgetiSTAT_Chem.Na_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">K</label>
                                        <input class="K" type="text" maxlength="8" value="#qgetiSTAT_Chem.K#" name="K"  id="K"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="K_report" id="K_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.K_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="K_comment" id="K_comment"
                                     >#qgetiSTAT_Chem.K_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Cl</label>
                                        <input class="Cl" type="text" maxlength="8" value="#qgetiSTAT_Chem.Cl#" name="Cl"  id="Cl"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Cl_report" id="Cl_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Cl_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Cl_comment" id="Cl_comment"
                                     >#qgetiSTAT_Chem.Cl_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">iCa</label>
                                        <input class="iCa" type="text" maxlength="8" value="#qgetiSTAT_Chem.iCa#" name="iCa"  id="iCa"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="iCa_report" id="iCa_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.iCa_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="iCa_comment" id="iCa_comment"
                                     >#qgetiSTAT_Chem.iCa_comment#</textarea>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">TCO2</label>
                                        <input class="TCO2" type="text" maxlength="8" value="#qgetiSTAT_Chem.TCO2#" name="TCO2"  id="TCO2"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="TCO2_report" id="TCO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.TCO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="TCO2_comment" id="TCO2_comment"
                                     >#qgetiSTAT_Chem.TCO2_comment#</textarea>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Glu</label>
                                        <input class="Glu" type="text" maxlength="8" value="#qgetiSTAT_Chem.Glu#" name="Glu"  id="Glu"><span>mg/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Glu_report" id="Glu_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Glu_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Glu_comment" id="Glu_comment"
                                     >#qgetiSTAT_Chem.Glu_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BUN</label>
                                        <input class="BUN" type="text" maxlength="8" value="#qgetiSTAT_Chem.BUN#" name="BUN"  id="BUN"><span>mg/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="BUN_report" id="BUN_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.BUN_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="BUN_comment" id="BUN_comment"
                                     >#qgetiSTAT_Chem.BUN_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Crea</label>
                                        <input class="Crea" type="text" maxlength="8" value="#qgetiSTAT_Chem.Crea2#" name="Crea2"  id="Crea2"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Crea2_report" id="Crea2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Crea2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Crea2_comment" id="Crea2_comment"
                                     >#qgetiSTAT_Chem.Crea2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hct</label>
                                        <input class="Hct" type="text" maxlength="8" value="#qgetiSTAT_Chem.Hct#" name="Hct"  id="Hct"><span>% PCV</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hct_report" id="Hct_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Hct_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Hct_comment" id="Hct_comment"
                                     >#qgetiSTAT_Chem.Hct_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hb</label>
                                        <input class="Hb" type="text" maxlength="8" value="#qgetiSTAT_Chem.Hb#" name="Hb"  id="Hb"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hb_report" id="Hb_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Hb_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Hb_comment" id="Hb_comment"
                                     >#qgetiSTAT_Chem.Hb_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">AnGap</label>
                                        <input class="AnGap" type="text" maxlength="8" value="#qgetiSTAT_Chem.AnGap#" name="AnGap"  id="AnGap"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="AnGap_report" id="AnGap_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.AnGap_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="AnGap_comment" id="AnGap_comment"
                                     >#qgetiSTAT_Chem.AnGap_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <h5 class="mb-1"><strong>ISTAT- CG4+</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup cust-date-r">
                                    <label class="date-padd">Date</label>
                                    <div class="input-group date " id="ISTAT_CG4_date_picker">
                                        <input type="text" maxlength="8" value="#DateTimeFormat(qgetiSTAT_CG4.ISTAT_CG4_date, "YYYY-MM-DD")#" placeholder="YYYY-MM-DD" name="ISTAT_CG4_date" id="ISTAT_CG4_date"
                                        class="form-control" value=''  />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div> 
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <label class="time">Time</label>
                                    <div class="input-group date " id="datetimepicker_Time">
                                        <input type="text" maxlength="8" value="#TimeFormat(qgetiSTAT_CG4.tTime, "HH:nn")#" placeholder="hh:mm:ss" name="tTime" id="Time"
                                        class="form-control" />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Operator</label>
                                        <select class="form-control" name="Operator" id="Operator">
                                            <cfloop query="getTeams">
                                                <cfif active eq 1>
                                                    <option value="#getTeams.RT_ID#" <cfif #getTeams.RT_ID# eq #qgetiSTAT_CG4.Operator#>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Temperature</label>
                                        <input class="Temperature" type="text" maxlength="8" value="#qgetiSTAT_CG4.Temperature#" name="Temperature"  id="Temperature"><span>&##8451;</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Temperature_report" id="Temperature_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.Temperature_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Temperature_comment" id="Temperature_comment"
                                     >#qgetiSTAT_CG4.Temperature_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">pH</label>
                                        <input class="pH" type="text" maxlength="8" value="#qgetiSTAT_CG4.pH#" name="pH"  id="pH">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="pH_report" id="pH_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.pH_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="pH_comment" id="pH_comment"
                                     >#qgetiSTAT_CG4.pH_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">PCO2</label>
                                        <input class="PCO2" type="text" maxlength="8" value="#qgetiSTAT_CG4.PCO2#" name="PCO2"  id="PCO2"><span>mmHg</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="PCO2_report" id="PCO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.PCO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="PCO2_comment" id="PCO2_comment"
                                     >#qgetiSTAT_CG4.PCO2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">PO2</label>
                                        <input class="PO2" type="text" maxlength="8" value="#qgetiSTAT_CG4.PO2#" name="PO2"  id="PO2"><span>mmHg</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="PO2_report" id="PO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.PO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="PO2_comment" id="PO2_comment"
                                     >#qgetiSTAT_CG4.PO2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BEecf</label>
                                        <input class="BEecf" type="text" maxlength="8" value="#qgetiSTAT_CG4.BEecf#" name="BEecf"  id="BEecf"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="BEecf_report" id="BEecf_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.BEecf_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="BEecf_comment" id="BEecf_comment"
                                     >#qgetiSTAT_CG4.BEecf_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">HCO3</label>
                                        <input class="HCO3" type="text" maxlength="8" value="#qgetiSTAT_CG4.HCO3#" name="HCO3"  id="HCO3"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="HCO3_report" id="HCO3_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.HCO3_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="HCO3_comment" id="HCO3_comment"
                                     >#qgetiSTAT_CG4.HCO3_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">TCO2</label>
                                        <input class="TCO2cg" type="text" maxlength="8" value="#qgetiSTAT_CG4.TCO2cg#" name="TCO2cg"  id="TCO2"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="TCO2cg_report" id="TCO2cg_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.TCO2cg_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="TCO2cg_comment" id="TCO2cg_comment"
                                     >#qgetiSTAT_CG4.TCO2cg_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">sO2</label>
                                        <input class="sO2" type="text" maxlength="8" value="#qgetiSTAT_CG4.sO2#" name="sO2"  id="sO2"><span>% </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="sO2_report" id="sO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.sO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="sO2_comment" id="sO2_comment"
                                     >#qgetiSTAT_CG4.sO2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lac</label>
                                        <input class="Lac" type="text" maxlength="8" value="#qgetiSTAT_CG4.Lac#" name="Lac"  id="Lac"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lac_report" id="Lac_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.Lac_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Lac_comment" id="Lac_comment"
                                     >#qgetiSTAT_CG4.Lac_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <!---  Following logic to get the data from the HI table and seting value to qgetHIData variable --->
                    <!--- <cfif url.LCE_ID neq 0>
                        <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
                    </cfif>
                    <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                        <cfset form.LCEID = form.HI_ID>
                        <cfset qgetHIData=Application.Stranding.getBlood_VData(argumentCollection="#Form#")>
                    <cfelse>
                        <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
                    </cfif> --->
                    <input type="hidden"  name="bloodValues_ID" value="#qgetBloodValueData.ID#">
                    <!--- <input type="hidden" name="LCE_ID" value="#qgetBloodValueData.LCE_ID#"> --->
                    <!--- this input field is using for check in stranding.cfc for general Update function --->
                    <input type="hidden"  name="check" value="1">
                    <input type="hidden"  name="blood_toxi" value="1">
                    <input type="hidden"  name="bloodvalue_fields" value="1">
    
                    <cfif findNoCase("Read only ST", permissions) eq 0>
                        <div class="flex-center flex-row flex-wrap d-flex">
                            <!--- <div class="flex-center flex-row flex-wrap d-flex bottons-wrap">
                                <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoToxicology" value="Save and go to Toxicology" onclick="chkreq(event)">
                                <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                                <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                            </div> --->
                            <div class="flex-center flex-row flex-wrap d-flex bottons-wrap">
                                <input type="submit" id="SaveAndNewBloodvalue" name="SaveAndNewBloodvalue" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                                <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                                <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                    <input type="submit" id="" name="bloodValueDelete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                                </cfif>
                                <cfif (permissions eq "full_access")>
                                    <input type="submit" id="deleteBloodValuesRecord" name="deleteBloodValuesRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records?')){}else{return false;};">
                                </cfif>
                            </div>
                        </div>
                    </cfif>

                </div>
                <!---END for blood value --->
                
                <!--- Start for Toxicology --->
                <div role="tabpanel" class="tab-pane" id="Toxicology">
                    <input type="hidden"  name="TX_ID" value="#qgetToxicologyData.ID#">
                    <input type="hidden"  name="Toxicology_ID" value="#qgetToxicologyData.ID#">
                    <input type="hidden"  name="HI_ID" value="#qgetToxicologyData.ID#">
                    <input type="hidden" name="tisu_type" value="#qgetToxitype.Tissue_type#">
                    <input type="hidden" name="toxi_type_ID" value="#qgetToxitype.ID#">
                    <!--- <input type="hidden" name="LCE_ID" value="#qgetToxicologyData.LCE_ID#"> --->
                    
                    <!--- this input field is using for check in stranding.cfc for general Update function --->
                    <input type="hidden"  name="check" value="1">
                    <!--- <input type="hidden"  name="bloodvalue_fields" value="1">
                    <input type="hidden"  name="blood_toxi" value="1"> --->
                    <h5 class="mb-1"><strong>Toxicology</strong></h5>
                    <div class="form-holder blood-form-holder Toxi-sec">  
                        <div class="form-group blood-from-froup scrol">
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                                    <div class="form-group blood-from-froup type">
                                        <div class="input-group ">
                                            <label class="">Tissue Type</label>
                                            <select class="form-control search-box" name="Tissue_type" id="Tissue_type" <cfif isdefined('form.Toxicology_ID') and form.Toxicology_ID neq ""> onChange="TissueTypeForm()"</cfif>>
                                                <option value="">Select Tissue Type</option>
                                                <cfloop query="qgetTissueType">
                                                    <cfif status  neq 0>
                                                        <option value="#qgetTissueType.ID#" <cfif isdefined('form.Tissue_type') and form.Tissue_type eq #qgetTissueType.ID#>selected</cfif>>#qgetTissueType.Type#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group c-b">
                                            <label class="">Dry Weight Fraction (gravimetry)</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group c-b">
                                            <label class="">Reference Range</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group c-b">
                                            <label class="">Sample Result</label>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Arsenic</label>
                                            <input class="Arsenic" type="text" maxlength="8" value="#qgetToxitype.Arsenic#" name="Arsenic"  id="Arsenic"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Arsenic _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Arsenic_Reference_Range#" name="Arsenic_Reference_Range"  id="Arsenic_Reference_Range"><span>ug/g dry</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Arsenic_Sample_Result" id="Arsenic_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Arsenic_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Cadmium</label>
                                            <input class="Cadmium" type="text" maxlength="8" value="#qgetToxitype.Cadmium#" name="Cadmium"  id="Cadmium"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Cadmium _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Cadmium_Reference_Range#" name="Cadmium_Reference_Range"  id="Cadmium _Reference_Range"><span>ug/g dry</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Cadmium_Sample_Result" id="Cadmium_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Cadmium_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Lead</label>
                                            <input class="Lead" type="text" maxlength="8" value="#qgetToxitype.Lead#" name="Lead"  id="Lead"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Lead _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Lead_Reference_Range#" name="Lead_Reference_Range"  id="Lead _Reference_Range"><span>ug/g dry</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm- col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Lead_Sample_Result" id="Lead_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Lead_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Mercury</label>
                                            <input class="Mercury" type="text" maxlength="8" value="#qgetToxitype.Mercury#" name="Mercury"  id="Mercury"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Mercury _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Mercury_Reference_Range#" name="Mercury_Reference_Range"  id="Mercury _Reference_Range"><span>ug/g dry</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Mercury_Sample_Result" id="Mercury_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Mercury_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Thallium</label>
                                            <input class="Thallium" type="text" maxlength="8" value="#qgetToxitype.Thallium#" name="Thallium"  id="Thallium"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Thallium _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Thallium_Reference_Range#" name="Thallium_Reference_Range"  id="Thallium _Reference_Range"><span>ug/g dry</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Thallium_Sample_Result" id="Thallium_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Thallium_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Selenium</label>
                                            <input class="Selenium" type="text" maxlength="8" value="#qgetToxitype.Selenium#" name="Selenium"  id="Selenium"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Selenium _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Selenium_Reference_Range#" name="Selenium_Reference_Range"  id="Selenium _Reference_Range"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Selenium_Sample_Result" id="Selenium_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Selenium_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Iron</label>
                                            <input class="Iron" type="text" maxlength="8" value="#qgetToxitype.Iron#" name="Iron"  id="Iron"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Iron _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Iron_Reference_Range#" name="Iron_Reference_Range"  id="Iron _Reference_Range"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Iron_Sample_Result" id="Iron_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Iron_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Copper</label>
                                            <input class="Copper" type="text" maxlength="8" value="#qgetToxitype.Copper#" name="Copper"  id="Copper"><span>ug/g dry</span>  
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Copper _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Copper_Reference_Range#" name="Copper_Reference_Range"  id="Copper _Reference_Range"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Copper_Sample_Result" id="Copper_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Copper_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Zinc</label>
                                            <input class="Zinc" type="text" maxlength="8" value="#qgetToxitype.Zinc#" name="Zinc"  id="Zinc"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Zinc _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Zinc_Reference_Range#" name="Zinc_Reference_Range"  id="Zinc _Reference_Range"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Zinc_Sample_Result" id="Zinc_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Zinc_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Molybdenum</label>
                                            <input class="Molybdenum" type="text" maxlength="8" value="#qgetToxitype.Molybdenum#" name="Molybdenum"  id="Molybdenum"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Molybdenum _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Molybdenum_Reference_Range#" name="Molybdenum_Reference_Range"  id="Molybdenum _Reference_Range"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Molybdenum_Sample_Result" id="Molybdenum_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Molybdenum_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Manganese</label>
                                            <input class="Manganese" type="text" maxlength="8" value="#qgetToxitype.Manganese#" name="Manganese"  id="Manganese"><span>ug/g dry</span>  
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Manganese _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Manganese_Reference_Range#" name="Manganese_Reference_Range"  id="Manganese _Reference_Range"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Manganese_Sample_Result" id="Manganese_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Manganese_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
    
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Cobalt</label>
                                            <input class="Cobalt" type="text" maxlength="8" value="#qgetToxitype.Cobalt#" name="Cobalt"  id="Cobalt"><span>ug/g dry</span>  
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup thre-rw">
                                        <div class="input-group ">
                                            <label class="">Reference Range</label>
                                            <input class="Cobalt _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Cobalt_Reference_Range#" name="Cobalt_Reference_Range"  id="Cobalt _Reference_Range"><span>ug/g dry</span> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                    <div class="form-group blood-from-froup">
                                        <div class="input-group result-row">
                                            <label class="county-label">Sample Result</label>
                                            <select class="form-control" name="Cobalt_Sample_Result" id="Cobalt_Sample_Result">
                                                <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                    <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetToxitype.Cobalt_Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <cfif isDefined('qgetDynamicToxitype') AND #qgetDynamicToxitype.recordcount# gt 0>
                                    <input type="hidden" id="saad" value="#qgetDynamicToxitype.recordcount#" name="count">
                                    <cfloop query="qgetDynamicToxitype">
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                            <div class="form-group blood-from-froup thre-rw">
                                                <div class="input-group ">
                                                    <label class="">#qgetDynamicToxitype.Label#</label>
                                                    <input class="" type="text" value="#qgetDynamicToxitype.Toxi_type#" name="toxitype#qgetDynamicToxitype.ID#"  id=""><span>ug/g dry</span>  
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                            <div class="form-group blood-from-froup thre-rw">
                                                <div class="input-group ">
                                                    <label class="">Reference Range</label>
                                                    <input class=" _Reference_Range" type="text" maxlength="8" value="#qgetDynamicToxitype.Reference_Range#" name="toxirange#qgetDynamicToxitype.ID#"  id=" _Reference_Range"><span>ug/g dry</span> 
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                            <div class="form-group blood-from-froup">
                                                <div class="input-group result-row">
                                                    <label class="county-label">Sample Result</label>
                                                    <select class="form-control" name="toxireport#qgetDynamicToxitype.ID#" id="_Sample_Result">
                                                        <cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j">
                                                            <option value="#ToxicologySelectoptions[j]#" <cfif #ToxicologySelectoptions[j]# eq #qgetDynamicToxitype.Sample_Result#>selected</cfif>>#ToxicologySelectoptions[j]#</option>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </cfloop>
                                </cfif>
                                <div id="Toxi"> </div>
                                <input type="hidden" name="dynamic_Toxi" value="" id="dynamic_Toxi">
                                <input type="button" id="Add_new" name="Add_new" class="btn btn-success m-rl-4" value="Add New" onclick="newToxi()">
                            </div>
                        </div>
                    </div>
                    <cfif findNoCase("Read only ST", permissions) eq 0>
                        <div class="flex-center flex-row flex-wrap">
                            <!--- <div class="flex-center flex-row flex-wrap bottons-wrap">
                                <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoAncillaryDiagnostics" value="Save and go to Ancillary Diagnostics" onclick="chkreq(event)">
                                <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                                <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                            </div> --->
                            <div class="flex-center flex-wrap bottons-wrap">
                                <input type="submit" id="SaveAndNew" name="SaveAndNewToxicology" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                                <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                                <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.Toxicology_ID') and form.Toxicology_ID neq "")>
                                    <input type="submit" id="" name="deleteToxicology" class="btn btn-oRangem-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                                </cfif>
                                <cfif (permissions eq "full_access")>
                                    <input type="submit" id="deleteToxicologyAllRecord" name="deleteToxicologyAllRecord" class="btn btn-oRangem-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records?')){}else{return false;};">
                                </cfif>
                            </div>
                        </div>
                    </cfif>
                    
            </div>
            <!---END for Toxicology --->
            <!--- start for AncillaryDiagnostics --->
            <div role="tabpanel" class="tab-pane" id="AncillaryDiagnostics">
                <cfif isdefined('qgetAncillaryData.LCE_ID')>
                    <input type="hidden" name="LCE_ID" value="#qgetAncillaryData.LCE_ID#">
                    <input type="hidden"  name="ADID" value="#qgetAncillaryData.ID#">
                <cfelse>
                    <input type="hidden" name="LCE_ID" value="#url.LCE_ID#">
                    <input type="hidden"  name="ADID" value="">
                </cfif>
                <!--- <input type="hidden"  name="check" value="1">
                <input type="hidden"  name="histopathology_fields" value="1"> --->
                <!---Sample Collection --->
                <div class="form-holder blue-bg sample-accession-form">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Diagnostic Test</label>
                                    <select class="form-control" id="DiagnosticTest">
                                        <option value="">Select Diagnostic Test</option>
                                        <cfloop query="qgetDiagnosticTest">
                                            <option value="#qgetDiagnosticTest.Diagnostic#">#qgetDiagnosticTest.Diagnostic#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="DiagnosticTest" id="DT">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Test Result</label>
                                    <select class="form-control" id="TestResults">
                                        <option value="">Select Test Result</option>
                                        <cfloop from="1" to="#ArrayLen(testResult)#" index="j">
                                            <option value="#testResult[j]#">#testResult[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="TestResults" id="TR">
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="lab-label">Diagnostic Lab</label>
                                    <select class="form-control" id="DiagnosticLab">
                                        <option value="">Select Diagnostic Lab</option>
                                        <cfloop query="#qgetDiagnosticLab#">
                                            <cfif status eq 1>
                                                <option value="#qgetDiagnosticLab.Diagnostic#">#qgetDiagnosticLab.Diagnostic#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="DiagnosticLab" id="DLAB">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"> 
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="label-TestingDate">Testing Date</label>
                                    <div class="input-group date " id="datetimepicker_Date_TD">
                                        <input type="text" placeholder="YYYY-MM-DD" id="TestingDate"
                                            class="form-control" value='' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                                <input type="hidden" name="TestingDate" id="TD">
                            </div>
                        </div>
                        <input type="hidden" name="pdfFilesAncillary" value="" id="pdfFilesAncillary">
                        <div class="form-group" id="find">
                            <div class="row" id="start">
                                <div class="col-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center" id="filediv">
                                            <label class="file-label">Upload PDF File (Max Size: 10MB)</label>
                                            <input class="input-style xl-width" type="file" name="emptypdf" id="filesAncillary" accept="application/pdf" <cfif findNoCase("Read only ST", permissions) neq 0> Disabled</cfif>>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <input type="button" class="btn btn-success ml-auto" id="TestNew" value="Add New" onClick="AddNewTest()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        
                        <div class="col-lg-12">
                            <div class="simple-accession-table">
                                <div class="responsive-tale">
                                    <table class="table table-bordered table-hover" id="AncillaryTable" <cfif isDefined('qAncillaryReportGet') AND #qAncillaryReportGet.recordcount# gt 0><cfelse> hidden</cfif>>
                                        <thead>
                                            <tr>
                                                <th>Diagnostic Test</th>
                                                <th>Test Result</th>
                                                <th>Diagnostic Lab</th>
                                                <th>Testing Date</th>
                                                <th>PDF</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <cfif isDefined('qAncillaryReportGet')>
                                                <cfloop query="qAncillaryReportGet">
                                                    <tr id="tr_#ID#">

                                                        <td hidden id="AAncillaryPDF_#ID#">#qAncillaryReportGet.pdfFiles#</td>
                                                        <td id="DiagnosticTest_#ID#">#qAncillaryReportGet.DiagnosticTest#</td>
                                                        <td id="TestResults_#ID#">#qAncillaryReportGet.TestResults#</td>
                                                        <td id="DiagnosticLab_#ID#">#qAncillaryReportGet.DiagnosticLab#</td>
                                                        <td id="AncillaryDate_#ID#">#qAncillaryReportGet.TestingDate#</td>
                                                        <td id="AncillaryPDF_#ID#">
                                                            <cfif #qAncillaryReportGet.pdfFiles# neq 0>
                                                            <span>
                                                                <a data-toggle="modal" data-target="##myModalAA" href="##" title="#Application.CloudRoot##qAncillaryReportGet.pdfFiles#" target="blank">
                                                                    <img  class="imageThumb" id="imagetitle_#ID#" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#qAncillaryReportGet.pdfFiles#" onclick="showPDFmodal(this)"/>
                                                                </a>
                                                            </span>
                                                            </cfif>
                                                        </td>
                                                        <td>
                                                            <div class="tablebutn edbtn" style="display: inline-flex;">
                                                                <input type="button" id="edit_button#ID#" value="Edit" class="edit" onclick="edit_AncillaryRow(#ID#)">
                                                                <input type="button" value="Delete"  class="delete" onclick="delete_AncillaryRow(#ID#)" style="margin-left: 5%;">
                                                                </div>
                                                        
                                                        </td>

                                                    </tr>
                                                </cfloop>
                                            </cfif>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <!--- <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoSampleArchive" value="Save and go to Sample Archive" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div> --->
                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNewAncillaryDiagnostics" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.AD_ID') and form.AD_ID neq "")>
                                <input type="submit" id="" name="deleteAncillary" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                    <input type="submit" id="deleteAncillaryAllRecord" name="deleteAncillaryAllRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>

            </div>   
            <!--- end for AncillaryDiagnostics --->

            <!--- start for SampleArchive --->
            <div role="tabpanel" class="tab-pane" id="SampleArchive">

                <!--- <input type="hidden" name="histopathology_fields" value="1"> --->
                <!--- <cfif isDefined('form.SEID') and qgetSampleData.LCE_ID neq "" and qgetSampleData.LCE_ID neq 0  >
                    <input type="hidden" name="LCE_ID" value="#qgetSampleData.LCE_ID#">
                    <!--- <input type="hidden" name="SEID" value="#qgetSampleData.ID#"> --->
                <cfelse>
                    <input type="hidden" class="saaad" name="LCE_ID" value="#url.LCE_ID#">
                </cfif> --->
                <cfif isDefined('form.SEID') and form.SEID neq '' >
                    <input type="hidden" name="SEID" value="#qgetSampleData.ID#">
                </cfif>
                                <!---  Following logic to get the data from the HI table and seting value to qgetSampleData variable --->
                    <!--- <cfset qgetSampleData=Application.Stranding.getSampleType_ten()> --->
                    <input type="hidden"  name="ST_ID" value="#qgetSampleTypeDataSingle.ID#">
                    <input type="hidden" name="fielnumb" value="" id="fielnumb">
    
                    <div class="form-holder">  
                        <div class="form-group">
                            <div class="row">
                                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="samples-label">Samples</label>
                                            <select class="form-control" name="STID" id="STID" onChange="formNewSamples()">
                                                <option value="">Add New Sample</option>
                                                <cfloop query="qgetSampleTypeIByID">
                                                    <option value="#qgetSampleTypeIByID.ID#" <cfif #qgetSampleTypeDataSingle.ID# eq #qgetSampleTypeIByID.ID#>
                                                    selected</cfif>>#qgetSampleTypeIByID.SampleID#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row rowbutton">
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6"> 
                                    <div class="form-input-holder">
                                        <div class="form-group flex-center">
                                            <label class="">Sample Date</label>
                                            <div class="input-group date " id="datetimepicker_Date_sample">
                                                <input type="text" placeholder="YYYY-MM-DD" name="Sample_Date" id="Sample_Date"
                                                    class="form-control" value='#DateTimeFormat(qgetSampleTypeDataSingle.Sample_Date, "YYYY-MM-DD")#' />
                                                    <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 offset-md-4 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-input-holder">
                                        <div class="form-group input-group flex-center">
                                            <label class="">Sample Location</label>
                                            <select class="form-control" name="Sample_Location" id="Sample_Location">
                                                <option value="">Select Sample Location</option>
                                                <cfloop query="#qgetSampleLocation#">
                                                    <cfif status eq 1>
                                                        <option value="#qgetSampleLocation.Location#"<cfif #qgetSampleLocation.Location# eq #qgetSampleTypeDataSingle.Sample_Location#>
                                                            selected</cfif>>#qgetSampleLocation.Location#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="sample-label">Sample ID</label>
                                            <input class="input-style xl-width" type="text" value="#qgetSampleTypeDataSingle.SampleID#" name="SampleID" id="SampleID" >
                                            <!--- will be require --->
                                        </div>
                                    </div>
                                </div> 
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="bin-label">Bin Number</label>
                                            <select class="form-control" name="BinNumber" id="BinNumber">
                                                <option value="">Select Bin Number</option>
                                                <cfloop query="qgetBinNumber">
                                                    <cfif status  neq 0>
                                                        <option value="#qgetBinNumber.Bin_Number#" <cfif #qgetBinNumber.Bin_Number# eq #qgetSampleTypeDataSingle.BinNumber#>selected</cfif>>#qgetBinNumber.Bin_Number#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>                
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="county-label extra-w ">Sample Type</label>
                                            <select class="form-control search-box" name="SampleType" id="SampleType">
                                                <option value="">Select Sample Type</option>
                                                <cfloop query="qgetSampleType">
                                                    <cfif status  neq 0>
                                                        <option value="#qgetSampleType.Type#" <cfif #qgetSampleType.Type# eq #qgetSampleTypeDataSingle.SampleType#>selected</cfif>>#qgetSampleType.Type#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>                
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="county-label">Preservation Method</label>
                                            <select class="form-control" name="PreservationMethod" id="PreservationMethod">
                                                <option value="">Select Preservation Method</option>
                                                <cfloop query="qgetPreservationMethod">
                                                    <cfif status  neq 0>
                                                        <option value="#qgetPreservationMethod.Method#" <cfif #qgetPreservationMethod.Method# eq #qgetSampleTypeDataSingle.PreservationMethod#>selected</cfif>>#qgetPreservationMethod.Method#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="am-l">Amount of Sample</label>
                                            <input class="input-style xl-width" type="number" value="#qgetSampleTypeDataSingle.AmountofSample#" name="AmountofSample" id="AmountofSample">
                                        </div>
                                    </div>
                                </div>  
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="county-label">Unit of Sample</label>
                                            <select class="form-control" name="UnitofSample" id="UnitofSample">
                                                <option value="">Select Unit of Sample</option>
                                                <cfloop query="qgetUnitofsample">
                                                    <cfif status  neq 0>
                                                        <option value="#qgetUnitofsample.Unit#" <cfif #qgetUnitofsample.Unit# eq #qgetSampleTypeDataSingle.UnitofSample#>selected</cfif>>#qgetUnitofsample.Unit#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>               
                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center">
                                            <label class="county-label extra">Storage Type</label>
                                            <select class="form-control" name="StorageType" id="StorageType">
                                                <cfloop from="1" to="#ArrayLen(StorageTypeArray)#" index="j">
                                                    <option value="#StorageTypeArray[j]#" <cfif #StorageTypeArray[j]# eq #qgetSampleTypeDataSingle.StorageType#>selected</cfif>>#StorageTypeArray[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12 s-content">
                                    <div class="form-group flex-center">
                                        <label class="scomment-label">Sample Comments</label>
                                        <textarea class="form-control textareaCustomReset locations-textarea" name="SampleComments" id="SampleComments"
                                            maxlength="75">#qgetSampleTypeDataSingle.SampleComments#</textarea>
                                    </div>
                                </div> 
                                 <!--- Buttons Section--->
                    
                    <cfif findNoCase("Read only ST", permissions) eq 0>
                        <!--- <div class="flex-center flex-row flex-wrap"> --->
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 s-content two-btn two-btn-wrap">
                                <input type="submit" id="SaveAndNewSampleArchive" name="SaveAndNewSampleArchive" class="btn btn-pink m-rl-4" value="Save and New" onclick="chkreq(event)">
                                <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)">
                                <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('qgetSampleTypeIByID.ID') and qgetSampleTypeIByID.ID neq "")>
                                    <input type="submit" id="" name="deleteSampleAechive" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){deleteit()}else{return false;};" >
                                </cfif>
                                <cfif (permissions eq "full_access")>
                                    <input type="submit" id="deleteallSampleArchiveRecord" name="deleteallSampleArchiveRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records ?')){deleteit()}else{return false;};" >
                                </cfif>
                            </div>
                            <!--- <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4 s-content">
                                <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)">                        
                            </div> --->
                            <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4 s-content">
                                
                            </div>
                                
                            
                        <!--- </div> --->
                    </cfif>            
                            </div>
                        </div>
                    </div>    
                                    <!---Sample Collection --->
                <div class="form-holder blue-bg sample-accession-form">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"> 
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="">Sample Accession Date</label>
                                    <div class="input-group date " id="datetimepicker_Date_sadd">
                                        <input type="text" placeholder="YYYY-MM-DD" name="SampleAccessionDate" id="SampleAccessionDate"
                                            class="form-control" value='' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                                <input type="hidden" value="" name="SADate" id="sad">
                                <span id="sampleDate" class="sampleDate_error"></span>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Sample Location</label>
                                    <select class="form-control" id="SampleLocation">
                                        <option value="">Select Sample Location</option>
                                        <cfloop query="#qgetSampleLocation#">
                                            <cfif status eq 1>
                                                <option value="#qgetSampleLocation.ID#">#qgetSampleLocation.Location#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="SampleLocation" id="SL">
                                <span id="sampleLocation" class="sampleLocation_error"></span>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Sample Tracking</label>
                                    <select class="form-control" id="SampleTracking" onchange="showFieldsOfSampleArchive()">
                                        <option value="">Select Sample Tracking</option>
                                        <cfloop query="#qgetSampleTracking#">
                                            <cfif status eq 1>
                                                <option value="#qgetSampleTracking.ID#">#qgetSampleTracking.Current_Location#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="SampleTracking" id="ST">
                                <span id="sampleTracking" class="sampleTracking_error"></span>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="lab-label">Lab Sent to</label>
                                    <select class="form-control" id="LabSentto">
                                        <option value="">Select Lab Sent to</option>
                                        <cfloop query="#qgetDiagnosticLab#">
                                            <cfif status eq 1>
                                                <option value="#qgetDiagnosticLab.ID#">#qgetDiagnosticLab.Diagnostic#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="LabSentto" id="lsto">
                                <span id="labsentto" class="labSent_error"></span>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="snotes-label">Sample Note</label>
                                    <textarea type="text" class="form-control textareaCustomReset locations-textarea" id="SampleArchiveNote" maxlength="75"></textarea>
                                </div>
                                 <input type="hidden" name="SampleArchiveNote" id="samplenotes">
                                <span id="sampleNote" class="sampleNote_error"></span>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"></div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6" id="subsampleDatee"> 
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="">Subsampled Date</label>
                                    <div class="input-group date " id="datetimepicker_Date_subsample">
                                        <input type="text" placeholder="YYYY-MM-DD" name="subsampleDate" id="subsampleDate"
                                            class="form-control" value='' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                                <input type="hidden" value="" name="subsampleDate" id="sub">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6" id="Thawedd">
                            <div class="form-group">
                                <div class="input-group flex-center" >
                                    <label class="county-label">Thawed</label>
                                    <select class="form-control" id="Thawed" >
                                        <option val="0">Select Thawed</option>
                                        <cfloop from="1" to="#ArrayLen(ThawedArray)#" index="j">
                                            <option value="#ThawedArray[j]#">#ThawedArray[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="Thawed" id="Thaw">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6" id="subsamplee">
                            <div class="form-group">
                                <div class="input-group flex-center" >
                                    <label class="county-label">Sample Availability</label>
                                    <select class="form-control" id="subsample" >
                                        <option val="0">Select Availability</option>
                                        <cfloop from="1" to="#ArrayLen(Availbility)#" index="j">
                                            <option value="#Availbility[j]#">#Availbility[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="subsample" id="Avail">
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <input type="button" class="btn btn-success ml-auto" id="SampleAr" value="Add New" onClick="AddNewRecordforSample()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="simple-accession-table">
                                <div class="responsive-tale">
                                    <table class="table table-bordered table-hover" id="sampleArchivedrugHistory" <cfif isDefined('qgetSampleDetailData') AND #qgetSampleDetailData.recordcount# gt 0><cfelse> hidden</cfif>>
                                        <thead>
                                            <tr>
                                                <th>Sample Accession Date</th>
                                                <th>Sample ID</th>
                                                <th>Sample Location</th>
                                                <th>Sample Tracking</th>
                                                <th>Lab Sent to</th>
                                                <th>Sample Note</th>
                                                <th>Subsampled Date</th>
                                                <th >Sample Availability</th>
                                                <th >Thawed</th>
                                                <cfif isDefined('qgetSampleDetailData')>
                                                    <th >Action</th>
                                                </cfif>    
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <cfif isDefined('qgetSampleDetailData')>
                                                <cfloop query="qgetSampleDetailData">
                                                    <!--- <tr id= #ID#> --->
                                                    <tr id="tr_#ID#">
                                                        <td id="idd" hidden>#ID#</td>
                                                        <td id="date#ID#">#qgetSampleDetailData.SADate#</td>
                                                        <td >#qgetSampleTypeDataSingle.SampleID#</td>
                                                        <td id="location#ID#">#qgetSampleDetailData.SampleLocation#</td>
                                                        <td id="track#ID#">#qgetSampleDetailData.SampleTracking#</td>
                                                        <td id="labsent#ID#">#qgetSampleDetailData.LabSentto#</td>
                                                        <td id="samplenotes#ID#"><cfif #qgetSampleDetailData.SampleNote# neq 0>#qgetSampleDetailData.SampleNote#</cfif></td>
                                                        <td id="subdate#ID#"><cfif #qgetSampleDetailData.subsampleDate# neq 0>#qgetSampleDetailData.subsampleDate#</cfif></td>
                                                        <td id="availbility#ID#"><cfif #qgetSampleDetailData.Sample_available# neq 0 and #qgetSampleDetailData.Sample_available# neq 'Select Availability'>#qgetSampleDetailData.Sample_available#</cfif></td>
                                                        <td id="thawed#ID#"><cfif #qgetSampleDetailData.Thawed# neq 'Select Thawed' and #qgetSampleDetailData.Thawed# neq 0>#qgetSampleDetailData.Thawed#</cfif></td>
                                                        <td>
                                                            <div class="tablebutn" style="display: inline-flex;">
                                                                <input type="button" id="edit_button#ID#" value="Edit" class="edit" onclick="edit_SampleRow(#ID#)">
                                                                <input type="button" value="Delete"  class="delete" onclick="delete_sampleRow(#ID#)" style="margin-left: 5%;">
                                                            </div>
                                                            
                                                        </td>
                                                    </tr>
                                                </cfloop>
                                            </cfif>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <input type="hidden" id="idForUpdate" value="">
                <div class="form-holder blue-bg"<cfif isDefined('qgetSampleTypeIByID') AND #qgetSampleTypeIByID.recordcount# gt 0><cfelse> hidden</cfif>>
                    <div class="row">
                        <div class="col-lg-12 cut-tabl">
                            <div class="simple-t-sec">
                                <div class="simple-t-row">
                            <table class="table table-bordered table-hover" id="lasttable" >
                                <thead>
                                    <tr>
                                        <th>Sample ID</th>
                                        <th>Bin Number</th>
                                        <th>Sample Type</th>
                                        <th>Preservation Method</th>
                                        <th>Amount of sample</th>
                                        <th>Unit of sample</th>
                                        <th>Storage Type</th>
                                        <th>Sample Comments</th>
                                        <cfif isDefined('qgetSampleData')>
                                         <th>Date</th>
                                        </cfif>
                                        <th>Date2</th>
                                        <cfif isDefined('qgetSampleDetailData')>
                                            <cfset c = 2>
                                            <cfloop index="index" from="1" to="#qgetSampleDetailData.recordcount#">
                                                <cfset c = incrementValue(#c#)>
                                                <th>Date#c#</th>
                                            </cfloop>
                                        </cfif>
                                        <th>Location</th>
                                        <cfif isDefined('qgetSampleDetailData')>
                                            <cfset c = 1>
                                            <cfloop index="index" from="1" to="#qgetSampleDetailData.recordcount#">
                                                <cfset c = incrementValue(#c#)>
                                                <th>Location#c#</th>
                                            </cfloop>
                                        </cfif>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetSampleTypeIByID')>
                                        <cfloop query="qgetSampleTypeIByID">
                                            <tr>
                                                <td>#qgetSampleTypeIByID.SampleID#</td>
                                                <td>#qgetSampleTypeIByID.BinNumber#</td>
                                                <td>#qgetSampleTypeIByID.SampleType#</td>
                                                <td>#qgetSampleTypeIByID.PreservationMethod#</td>
                                                <td>#qgetSampleTypeIByID.AmountofSample#</td>
                                                <td>#qgetSampleTypeIByID.UnitofSample#</td>
                                                <td>#qgetSampleTypeIByID.StorageType#</td>
                                                <td>#qgetSampleTypeIByID.SampleComments#</td>
                                                <!--- <cfif isDefined('qgetSampleData')> --->
                                                    <td id="archivedate">#qgetSampleTypeIByID.maindate#</td>
                                                <!--- </cfif> --->
                                                <td>#qgetSampleTypeIByID.Sample_Date#</td>
                                                <cfif isDefined('qgetSampleDetailData')>
                                                    <cfloop query="qgetSampleDetailData">
                                                        <td>#qgetSampleDetailData.SADate#</td>
                                                    </cfloop>    
                                                </cfif>
                                                <td>#qgetSampleTypeIByID.Sample_Location#</td>
                                                <cfif isDefined('qgetSampleDetailData')>
                                                    <cfloop query="qgetSampleDetailData">
                                                        <td>#qgetSampleDetailData.SampleLocation#</td>
                                                    </cfloop>    
                                                </cfif>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                    </div>
                </div>
   
                <div class="row mt-4 file-tabdesign-row">
                    <form id="myform" enctype="multipart/form-data" action="" method="post" >
                        <div class="col-lg-12 dis-flex just-center choose-file-tabdesign">
                            <div class="form-group select-width">
                                <cfif (permissions eq "full_access")>
                                    <input type="file" name="sampleFile" required>
                                </cfif>
                            </div>
                            <div class="form-group select-width">
                                <cfif (permissions eq "full_access")>
                                    <button type="submit" class="btn btn-success">Import</button>
                                </cfif>
                            </div>
                        </div>
                    </form>
                </div>                     
            </div>   

            <!--- end for SampleArchive --->
            
            <!--- start for NecropsyReport --->
            <div role="tabpanel" class="tab-pane" id="NecropsyReport">                
                <input type='hidden' name='report' id="report" value='#form.report#'>
                <input type='hidden' name='report_ID' id="repotrt_ID" value='#qgetCetaceanNecropsy.ID#'>
                <input type='hidden' name='fieldno' id="fieldno" value='#form.fieldnumber#'>
                <input type='hidden' name='fieldnoo' id="fieldnoo" value='#qgetCetaceanNecropsy.Fnumber#'>
                <input type='hidden' name='form_id' id="form_id" value='#qgetCetaceanNecropsy.ID#'>
                <div class="sec-two">    
                    <div class="row">
                        <div class="col-lg-5">
                        <div class="cust-row">
                            <div class="cust-fld"><label class="fl-lbl">Attending Veterinarian</label>
                            </div>
                            <div class="cust-inp">
                                <select class="stl-op search-box" multiple="multiple" name="attendingVeterinarian" id="attendingVeterinarian">
                                    <cfloop query="qgetVeterinarians">
                                        <cfif status eq 1>
                                            <option value="#qgetVeterinarians.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.attendingVeterinarian,","),#qgetVeterinarians.ID#)>selected</cfif>>#qgetVeterinarians.Veterinarians#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="row pt-15">
                        <div class="col-lg-5">
                        <div class="cust-row">
                            <div class="cust-fld"><label class="fl-lbl">Prosectors</label>
                            </div>
                            <div class="cust-inp">
                                <select class="stl-op search-box" multiple="multiple" name="Prosectors" id="Prosectors">
                                    <cfloop query="getTeams">
                                        <cfif active eq 1>
                                            <option value="#getTeams.RT_ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Prosectors,","),#getTeams.RT_ID#)>selected</cfif>>#getTeams.RT_MemberName#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="row pt-15">
                        <div class="col-lg-12">
                        <div class="cust-row panel-rw">
                            <div class="cust-fld"><label class="fl-lbl">Tentative Gross Diagnosis</label>
                            </div>
                            <div class="cust-inp">
                                <!-- <input type="text" name="Tentative" placeholder="Expandable field to multi-line" value="#qgetCetaceanNecropsy.Tentative#"class="text-field"> -->
                                <textarea id="top-area" name="Tentative" rows="1" class="text-field" cols="50">#qgetCetaceanNecropsy.Tentative#</textarea>
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-15">
                            <div class="cust-row panel-rw">
                                <div class="cust-fld"><label class="fl-lbl">Cause of Death</label>
                                </div>
                                <div class="cust-inp">
                                    <!-- <input type="text" name="deathcause" placeholder="Expandable field to multi-line" value="#qgetCetaceanNecropsy.deathcause#"class="text-field"> -->
                                    <textarea id="top-area" name="deathcause" rows="1" class="text-field" cols="50">#qgetCetaceanNecropsy.deathcause#</textarea>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-5 mt-15">
                            <div class="btn-rw cust-row mt-30 cst-rows">
                            <div class="cust-inp cust-inpts">
                                <div class="cust-inp test" id="histoSpinner">
                                <input type="file" placeholder="pdf Path" name="histofile" id="histofile" class="text-field text-fields" accept="application/pdf">
                            </div>
                            <div class="cust-fld"><button type="button" onclick="histoUploadshowPictures()" name="histoUpload"class="upld-btn upld-btns">Upload</button></div>
                            </div>
            
            
                            <cfset HistoImagess = ValueList(qgetCetaceanNecropsy.HistoImages,",")> 
                            <!--- <input type="hidden" name="imagesFile2" value="#imgss#" id="imagesFile2"> --->
                            <input type="hidden" name="histoImages" value="#HistoImagess#" id="histoImages">
                    
                            <div id="histoUpload" >
                             <CFIF listLen(HistoImagess)>  
                                    <cfloop list="#HistoImagess#" item="item" index="index">
                    
                                        <span class="pip pipw" style="width: 30%;">
                                            <a data-toggle="modal" data-target="##myModala" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                <img  class="imageThumb imageTh" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="pdfselected(this)"/>                                  
                                            </a>
                                            <br/>
                                            <cfif findNoCase("Read only ST", permissions) eq 0>
                                                <span class="remove rem" onclick="histoPdfRemove(this)" id="#item#">Remove image</span>
                                            </cfif>
                                        </span>
                                    </cfloop>
                                </cfif>
                            </div>  
            
                            <!-- modal -->
                            <div class="modal fade" id="myModala" role="dialog">
                                <div class="modal-dialog">
                                
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title" id="pdfname"></h4>
                                        </div>
                                        <div class="modal-body">
                                            <embed id="embe" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                                        </div>
                                        <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="simple-button pt-15">
                                <!--- <cfif isDefined('qgetCetaceanNecropsy')  and #qgetCetaceanNecropsy.Fnumber# neq "">
                            <cfdump var="#qgetCetaceanNecropsy.Fnumber#">                    
                            </cfif> --->
                                <!--- <cfif isDefined('qgetCetaceanNecropsy.fnumber') and qgetCetaceanNecropsy.fnumber neq ""> --->
                                <cfif isDefined('qgetCetaceanNecropsy.Fnumber')  and #qgetCetaceanNecropsy.Fnumber# neq "empty">
                                    <cfquery name="qgetHistoLCEID" datasource="#Application.dsn#"  result="return_data" >
                                        SELECT ID from ST_HistoForm where deleted != '1' and Fnumber = '#qgetCetaceanNecropsy.Fnumber#' 
                                    </cfquery>
                                    <!--- <cfdump var="#qgetLCEID.ID#" abort="true"> --->
                                    <cfif  #qgetHistoLCEID.ID# eq " ">
                                        <cfset form.CetaceanID= "0">
                                    <cfelse>
                                        <cfset form.CetaceanID= "#qgetHistoLCEID.ID#">
                                    </cfif>
                                    
                                </cfif>
                                <a href="#Application.siteroot#?Module=Stranding&Page=StrandingTabs&Histopathology&LCE_HID=<cfif isDefined('form.CetaceanID') and #form.CetaceanID# neq "">#form.CetaceanID#<cfelse>0</cfif>"class="linkhisto">
                                    Open Histopathology
                                </a>
                            </div>
                        </div>
                        </div>
                    </div>
                    <div class="row pt-15">
                        <div class="col-lg-8 fldarea">
                            <label class="fl-lbl">Histopathology Remarks / Diagnosis</label>
                            <textarea id="top-area" name="historemark" rows="4" cols="50">#qgetCetaceanNecropsy.historemark#</textarea>
                        </div>
            
                        <!---             working strat --->
                        

                    </div>
                    <div class="examination-sec">
                        <div class="sec-title"><h2>External Examination</h2><span></span></div>
                        <div class="row pt-30">
                        <div class="col-lg-12">
                            <div class="col-lg-5">
                                <div class="cust-row">
                                    <div class="cust-fld"><label class="fl-lbl">Condition at Necropsy</label>
                                    </div>
                                    <div class="cust-inp">
                                        <select class="stl-op" name="Necropsycondition" id="Necropsy_condition">
                                            <option value="">Select</option>
                                            <cfset coutt = "2">
                                            <cfloop array="#Condition_at_Necropsy#" item="item" index="j">
                                                <option value="#item#"<cfif isdefined('qgetCetaceanNecropsy.Necropsycondition') and  qgetCetaceanNecropsy.Necropsycondition  eq #item#>selected</cfif>>#coutt#-#item#</option>
                                                <cfset coutt = coutt +1>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-10">
                            <div class="col-lg-5">
                                <div class="cust-row">
                                    <div class="cust-fld">
                                        <label class="fl-lbl">Euthanized</label>
                                    </div>
                                    <div class="cust-inp">
                                        <select class="stl-op" name="Euthanized" id="Euthanized">
                                            <option value="">Select</option>
                                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Euthanized') and  qgetCetaceanNecropsy.Euthanized  eq 'Yes'>selected</cfif>>Yes</option>
                                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Euthanized') and  qgetCetaceanNecropsy.Euthanized  eq 'No'>selected</cfif>>No</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-10">
                            <div class="col-lg-8">
                                <div class="cust-row exam-rw">
                                    <div class="cust-fld">
                                        <label class="fl-lbl">General Body Condition</label>
                                    </div>
                                    <div class="cust-inp">
                                        <input type="text"  name="NecropsyBodycondition" class="text-field" value="#qgetCetaceanNecropsy.Bodycondition#">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-10">
                            <div class="col-lg-5">
                                <div class="cust-row">
                                    <div class="cust-fld"><label class="fl-lbl">Level A Date</label>
                                    </div>
                                    <div class="cust-inp input-group date"id="LevelA_Date">
                                        <input type="text" id="Level_A_Date" name="LevelADate" value='#DateTimeFormat(qgetCetaceanNecropsy.LevelADate, "YYYY-MM-DD")#' placeholder="YYYY-MM-DD"class="text-field"> 
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="cust-row">
                                    <div class="cust-fld"><label class="fl-lbl">Animal Renderings</label>
                                    </div>
                                    <div class="cust-inp">
                                        <select class="stl-op" name="AnimalRenderings" id="Animal_Renderings">
                                            <option value="">Select</option>
                                            <cfloop from="1" to="#ArrayLen(Animal_Renderings)#" index="j">
                                                <option value="#Animal_Renderings[j]#" <cfif isdefined('qgetCetaceanNecropsy.AnimalRenderings') and  qgetCetaceanNecropsy.AnimalRenderings  eq #Animal_Renderings[j]#>selected</cfif>>#Animal_Renderings[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-10">
                            <div class="col-lg-5">
                                <div class="cust-row">
                                    <div class="cust-fld"><label class="fl-lbl">Necropsy Date</label>
                                    </div>
                                    <div class="cust-inp input-group date"id="Necropsy_Date">
                                        <input type="text" id="NecropsyDate" name="NecropsyDate"value='#DateTimeFormat(qgetCetaceanNecropsy.NecropsyDate, "YYYY-MM-DD") #' placeholder="YYYY-MM-DD"class="text-field"> 
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="cust-row">
                                    <div class="cust-fld"><label class="fl-lbl">Nx Location</label>
                                    </div>
                                    <div class="cust-inp">
                                        <select class="stl-op search-box" multiple="multiple" name="NxLocation" id="NxLocation">
                                            <cfloop query="qgetNxLocation">
                                                <cfif status eq 1>
                                                    <option value="#qgetNxLocation.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.NxLocation,","),#qgetNxLocation.ID#)>selected</cfif>>#qgetNxLocation.location#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                
                        
                    <!--- working start --->
                        <div class="col-lg-5" id="ExternalExamDiv" style="display: none;">
                            <div class="cust-row btn-rw startSpinner" >
                                <div class="cust-inp test" id="start">                    
                                    <input type="file" placeholder="image Path" name="ExternalExamphoto" id="ExternalExamphoto" class="text-field text-fields" accept="image/*">
                                </div>
                                <div class="cust-fld"><button type="button"  onclick="showPictures()" class="upld-btn upld-btns">Upload</button></div>
                            </div>
                        </div>
                            <div class="choose-images">
                                <cfset imgss = ValueList(qgetCetaceanNecropsy.images,",")>
                                <input type="hidden" name="imagesFile" value="#imgss#" id="imagesFile">
                        
                                <div id="previousimages"  class="choose-images-detail">
                                    <!--- <div id="previousImagesRemove"> --->
                                    
                                    <CFIF listLen(imgss)> 
                
                                        <cfloop list="#imgss#" item="item" index="index">
                        
                                            <span class="pip pipwse" >
                                                <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                                </a>
                                                <br/>
                                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                                    <span class="remove rms" onclick="ExternalExamphotoremove(this)" id="#item#">Remove image</span>
                                                </cfif>
                                            </span>
                                        </cfloop>
                                    </cfif>	
                                <!--- </div> --->
                                </div>
                            </div>        
                        </div>
                    </div>
                
                            <!--- working --->
                            <!--- modal --->
                    <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title" id="pdfname"></h4>
                                </div>
                                <div class="modal-body">
                                    <img id="emb" src="" width="98%" height="500" type="application/jpeg" title="test.jpeg">
                                </div>
                                <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--- working end --->
              


    <div class="examination-sec">
        <div class="sec-title"><h2>Integument</h2><span></span></div>
        <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-6">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Skin Lesion Form</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Lesionform" id="Lesion_Form">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Lesionform') and  qgetCetaceanNecropsy.Lesionform  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Lesionform') and  qgetCetaceanNecropsy.Lesionform  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">HI Form</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="HIForm" id="HI_Form">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.HIForm') and  qgetCetaceanNecropsy.HIForm  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.HIForm') and  qgetCetaceanNecropsy.HIForm  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Wounds</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" value="#qgetCetaceanNecropsy.cutterwounds#"name="cutterwounds"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Scars</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" value="#qgetCetaceanNecropsy.cutterscars#" name="cutterscars"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Eye Findings LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="eyeleft" id="eye_left">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Eye_Finding)#" index="j">
                                <option value="#Eye_Finding[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.eyeleft,","),#Eye_Finding[j]#)>selected</cfif>>#Eye_Finding[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Eye Findings RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="eyeright" id="eye_right">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Eye_Finding)#" index="j">
                                <option value="#Eye_Finding[j]#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.eyeright,","),#Eye_Finding[j]#)>selected</cfif>>#Eye_Finding[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
                <!--- <cfif isDefined('qgetCetaceanNecropsy')  and #qgetCetaceanNecropsy.Fnumber# neq "">
                    <cfdump var="#qgetCetaceanNecropsy.Fnumber#">                    
                </cfif> --->
                <cfif isDefined('qgetCetaceanNecropsy.Fnumber')  and #qgetCetaceanNecropsy.Fnumber# neq "empty">
                
                    <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
                        SELECT ID from ST_LiveCetaceanExam where deleted != '1' and Fnumber = '#qgetCetaceanNecropsy.Fnumber#' 
                    </cfquery>
                    <!--- <cfdump var="#qgetLCEID.ID#" abort="true"> --->
                    <cfif  #qgetLCEID.ID# eq " ">
                        <cfset form.CetaceanID= "0">
                    <cfelse>
                        <cfset form.CetaceanID= "#qgetLCEID.ID#">
                    </cfif>
                    
                    <!--- <cfdump var="#form.CetaceanID#" > --->
                </cfif>
                <div class="simple-button pt-15 align-right">
                    <!--- <button type="button" class="linkcetacean" onclick="goToCetecanExamPage()">
                        Open Cetacean Exam
                    </button> --->
                    <a href="#Application.siteroot#?Module=Stranding&Page=StrandingTabs&CetaceanExam&LCEID=<cfif isDefined('form.CetaceanID') and #form.CetaceanID# neq "">#form.CetaceanID#<cfelse>0</cfif>"class="linkcetacean">
                        Open Cetacean Exam
                    </a>
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">If skin lesion present, please describe</label>
            <textarea id="top-area" name="lessiondescribe" rows="12" cols="120">#qgetCetaceanNecropsy.lessiondescribe#</textarea>
        </div>
        <div class="col-lg-12 fldarea">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="lessioncomments" rows="12" cols="120">#qgetCetaceanNecropsy.lessioncomments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input  type="checkbox"name="lessionphototaken" id="lessionphototaken" onclick="lessionphotos()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.lessionphototaken') and  qgetCetaceanNecropsy.lessionphototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
        <!--- working start --->
        <div class="col-lg-5" id="integumentdiv" style="display: block;">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inpts">
                    <div class="cust-inp test" id="startSpinner">
                        <input type="file" placeholder="image Path" name="Integumentphoto" id="Integumentphoto" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="integumentshowPictures()">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset imgs = ValueList(qgetCetaceanNecropsy.integumentImages,",")>
                <input type="hidden" name="integumentImagesFile" value="#imgs#" id="integumentImagesFile">
                <div id="IntegumentPreviousimages" class="choose-images-detail">
                    <CFIF listLen(imgs)> 
                        <cfloop list="#imgs#" item="item" index="index">
        
                            <span class="pip pipws">
                                <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rms" onclick="integumentImageremove(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>	
                </div> 
        </div>

        <!--- working end --->
    

    </div>
    </div>
    <div class="examination-sec">
        <div class="sec-title"><h2>Internal Examination</h2><span></span></div>
        <div class="mid-t"><h3>NUTRITIONAL CONDITION - INTERNAL</h3></div>
        <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fat/Blubber Status</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Fat_Blubber" id="Fat_Blubber">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.Fat_Blubber') and  qgetCetaceanNecropsy.Fat_Blubber  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"></label>
                    </div>
                    <div class="cust-fld"><label class="fl-lbl"><strong>Fat Around Organs</strong></label>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Heart</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="heart" id="heart">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.heart') and  qgetCetaceanNecropsy.heart  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Mesentery</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="mesentery" id="mesentery">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.mesentery') and  qgetCetaceanNecropsy.mesentery  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw ">
                    <div class="cust-fld"><label class="fl-lbl">Kidneys</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="kidney" id="kidney">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.kidney') and  qgetCetaceanNecropsy.kidney  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <cfif isDefined('qgetNutritional') AND #qgetNutritional.recordcount# gt 0>
                    <input type="hidden" id="dynamicone" value="#qgetNutritional.recordcount#" name="count">
                    <cfloop query="qgetNutritional">
                        <div class="cust-row ingm-rw kidneyClass">
                            <cfif isDefined('qgetNutritional.organs_label')>
                            <div class="cust-fld"><label class="fl-lbl"><input name="organlabel#qgetNutritional.ID#" type="text" value="#qgetNutritional.organs_label#" class="text-field"></label>
                            </div>
                        
                            <div class="cust-inp">
                                <select class="stl-op" name="NUTRI#qgetNutritional.ID#">
                                    <option value="">Select</option>
                                    <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                        <option value="#Fat_Blubber[j]#"<cfif isdefined('qgetNutritional.newNUTRI') and  qgetNutritional.newNUTRI  eq '#Fat_Blubber[j]#'>selected</cfif> >#Fat_Blubber[j]#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </cfif>
                        </div>
                    </cfloop>
                </cfif>
                <div id="newNUTRI" class="add_new_btn_content"></div>
                <div class="simple-button pt-15 align-right">
                    <input type="hidden" name="dynamic_NUTRITIONAL" value="" id="dynamic_NUTRITIONAL">
                    <!--- <button class="upld-btn">Add New</button> --->
                    <input type="button" id="Add_new" name="Add_new" class="upld-btn" value="Add New" onclick="newNUTRITIONAL()">
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="internal_comments" rows="12" cols="120">#qgetCetaceanNecropsy.internal_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="internal_phototaken" id="internal_phototaken" onclick="internalPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.internal_phototaken') and  qgetCetaceanNecropsy.internal_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
        <div class="col-lg-8" id="intenalExamphotoDiv">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inptsi">
                    <div class="cust-inp test" id="intenalExamSpinner">
                        <input type="file" name="intenalExamphoto" id="intenalExamphoto" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button type="button" onclick="intenalExamPictures()" class="upld-btn upld-btns">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset IntenalExamimg = ValueList(qgetCetaceanNecropsy.IntenalExamImages,",")>
                    <input type="hidden" name="intenalExamImagesFile" value="#IntenalExamimg#" id="intenalExamImagesFile">
                    <div id="intenalExamPreviousimages" class="choose-images-detail"> 
                        <div id="">
                        </div>
                    <CFIF listLen(IntenalExamimg)> 
                            <cfloop list="#IntenalExamimg#" item="item" index="index">
            
                                <span class="pip pipswi">
                                    <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                        <!-- <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/> -->
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="intenalImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                </div>
        </div>
    <div class="row pt-30">
        <div class="col-lg-7 mt-10">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">MUSCULOSKELETAL SYSTEM</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="MUSCULOSKELETALNecropsy" id="MUSCULOSKELETAL">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.MUSCULOSKELETAL') and  qgetCetaceanNecropsy.MUSCULOSKELETAL  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.MUSCULOSKELETAL') and  qgetCetaceanNecropsy.MUSCULOSKELETAL  eq 'NE'>selected</cfif>>NE</option>
                            
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Joint Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Joint_Fluid"id="Joint_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Joint_Fluid)#" index="j">
                                <option value="#Joint_Fluid[j]#"<cfif isdefined('qgetCetaceanNecropsy.Joint_Fluid') and  qgetCetaceanNecropsy.Joint_Fluid  eq #Joint_Fluid[j]#>selected</cfif>>#Joint_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Skeletal Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="Skeletal_Findings"id="Skeletal_Findings">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Skeletal_Findingss)#" index="j">
                                <option value="#Skeletal_Findingss[j]#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Skeletal_Findings,","),#Skeletal_Findingss[j]#)>selected</cfif>>#Skeletal_Findingss[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Muscle Status</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Muscle_Status" id="Muscle_Status">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Muscle_Status)#" index="j">
                                <!--- <option value="#Muscle_Status[j]#"<<cfif ListFind(ValueList(qgetCetaceanNecropsy.Muscle_Status,","),#Muscle_Status[j]#)>selected</cfif>>#Muscle_Status[j]#</option> --->
                                <option value="#Muscle_Status[j]#"<cfif isdefined('qgetCetaceanNecropsy.Muscle_Status') and  qgetCetaceanNecropsy.Muscle_Status  eq #Muscle_Status[j]#>selected</cfif>>#Muscle_Status[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Musculature Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="Musculature_Findings" id="Musculature_Findings">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Musculature_Findings)#" index="j">
                                <option value="#Musculature_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.Musculature_Findings,","),#Musculature_Findings[j]#)>selected</cfif>>#Musculature_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>


        <!--- working start --->
        <div class="col-lg-12" id="musculoskeletalDiv">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inpts">
                    <div class="cust-inp test" id="startMusculoskeletalSpinner">
                        <input type="file" placeholder="image Path" name="musculoskeletal" id="musculoskeletal" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="musculoskeletalshowPictures()">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset musculoskeletalImgs = ValueList(qgetCetaceanNecropsy.musculoskeletalImages,",")>
                <input type="hidden" name="musculoskeletalImagesFile" value="#musculoskeletalImgs#" id="musculoskeletalImagesFile">
                <div id="musculoskeletalPreviousimages" class="choose-images-detail">
                    <CFIF listLen(musculoskeletalImgs)> 
                        <cfloop list="#musculoskeletalImgs#" item="item" index="index">
        
                            <span class="pip pipws">
                                <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rms" onclick="musculoskeletalImageremove(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>	
                </div> 
        </div>

        <!--- working end --->
        </div>
        <div class="col-lg-5 mt-5">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="muscular_comments" rows="10" cols="120">#qgetCetaceanNecropsy.muscular_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="muscular_phototaken" id="muscular_phototaken" onclick="muscularPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.muscular_phototaken') and  qgetCetaceanNecropsy.muscular_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">THORACIC CAVITY</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op"name="THORACIC"id="THORACIC">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.THORACIC') and  qgetCetaceanNecropsy.THORACIC  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.THORACIC') and  qgetCetaceanNecropsy.THORACIC  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="fluidVolume" value="#qgetCetaceanNecropsy.fluidVolume#"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">ml</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ml" id="ml">
                            <option value="">Select</option>
                            <option value="Actual"<cfif isdefined('qgetCetaceanNecropsy.ml') and  qgetCetaceanNecropsy.ml  eq 'Actual'>selected</cfif>>Actual</option>
                            <option value="Estimate"<cfif isdefined('qgetCetaceanNecropsy.ml') and  qgetCetaceanNecropsy.ml  eq 'Estimate'>selected</cfif>>Estimate</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="THORACIC_Fluid"id="THORACIC_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Joint_Fluid)#" index="j">
                                <option value="#Joint_Fluid[j]#" <cfif isdefined('qgetCetaceanNecropsy.THORACIC_Fluid') and  qgetCetaceanNecropsy.THORACIC_Fluid  eq #Joint_Fluid[j]#>selected</cfif>>#Joint_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lining</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op"name="THORACIC_Lining"id="THORACIC_Lining">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Lining)#" index="j">
                                <option value="#Lining[j]#"<cfif isdefined('qgetCetaceanNecropsy.THORACIC_Lining') and  qgetCetaceanNecropsy.THORACIC_Lining  eq #Lining[j]#>selected</cfif> >#Lining[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
         
                    <!--- working start --->
                    <div class="col-lg-12" id="thoracicphotoDiv">
                        <div class="cust-row btn-rw startSpinner">
                            <div class="cust-inp cust-inpts">
                                <div class="cust-inp test" id="startThoracicSpinner">
                                    <input type="file" placeholder="image Path" name="thoracicphoto" id="thoracicphoto" class="text-field text-fields" accept="image/*">
                                </div>
                                <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="thoracicshowPictures()">Upload</button></div>
                            </div>
                        </div>
                    </div>
                    <div class="choose-images">
                        <cfset thoracictImgs = ValueList(qgetCetaceanNecropsy.thoracictImages,",")>
                            <input type="hidden" name="thoracicImagesFile" value="#thoracictImgs#" id="thoracicImagesFile">
                            <div id="thoracicPreviousimages" class="choose-images-detail">
                                <CFIF listLen(thoracictImgs)> 
                                    <cfloop list="#thoracictImgs#" item="item" index="index">
                    
                                        <span class="pip pipws">
                                            <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                            </a>
                                            <br/>
                                            <cfif findNoCase("Read only ST", permissions) eq 0>
                                                <span class="remove rms" onclick="thoracicImageremove(this)" id="#item#">Remove image</span>
                                            </cfif>
                                        </span>
                                    </cfloop>
                                </cfif>	
                            </div> 
                    </div>
            
                    <!--- working end --->
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="thoratic_comments" rows="10" cols="120">#qgetCetaceanNecropsy.thoratic_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="thoratic_phototaken" id="thoratic_phototaken" onclick="thoraticPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.thoratic_phototaken') and  qgetCetaceanNecropsy.thoratic_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <div class="row pt-30">
    <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">ABDOMINAL CAVITY</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ABDOMINAL" id="ABDOMINAL">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL') and  qgetCetaceanNecropsy.ABDOMINAL  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL') and  qgetCetaceanNecropsy.ABDOMINAL  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="abdominal_fluidVolume" value="#qgetCetaceanNecropsy.abdominal_fluidVolume#"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">ml</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ABDOMINAL_ml" id="ABDOMINAL_ml">
                            <option value="">Select</option>
                            <option value="Actual"<cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL_ml') and  qgetCetaceanNecropsy.ABDOMINAL_ml  eq 'Actual'>selected</cfif>>Actual</option>
                            <option value="Estimate"<cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL_ml') and  qgetCetaceanNecropsy.ABDOMINAL_ml  eq 'Estimate'>selected</cfif>>Estimate</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ABDOMINAL_Fluid" id="ABDOMINAL_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Joint_Fluid)#" index="j">
                                <option value="#Joint_Fluid[j]#" <cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL_Fluid') and  qgetCetaceanNecropsy.ABDOMINAL_Fluid  eq #Joint_Fluid[j]#>selected</cfif>
                                    >#Joint_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lining</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="ABDOMINAL_Lining" id="ABDOMINAL_Lining">
                            <cfloop from="1" to="#ArrayLen(Lining)#" index="j">
                                <option value="#Lining[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.ABDOMINAL_Lining,","),#Lining[j]#)>selected</cfif>
                                    >#Lining[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
              
                    <!--- working start --->
                    <div class="col-lg-12" id="abdominalDiv">
                        <div class="cust-row btn-rw startSpinner">
                            <div class="cust-inp cust-inpts">
                                <div class="cust-inp test" id="startAbdominalSpinner">
                                    <input type="file" placeholder="image Path" name="abdominalphoto" id="abdominalphoto" class="text-field text-fields" accept="image/*">
                                </div>
                                <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="abdominalshowPictures()">Upload</button></div>
                            </div>
                        </div>
                    </div>
                    <div class="choose-images">
                        <cfset abdominalImgs = ValueList(qgetCetaceanNecropsy.abdominalImages,",")>
                            <input type="hidden" name="abdominalImagesFile" value="#abdominalImgs#" id="abdominalImagesFile">
                            <div id="abdominalPreviousimages" class="choose-images-detail">
                                <CFIF listLen(abdominalImgs)> 
                                    <cfloop list="#abdominalImgs#" item="item" index="index">
                    
                                        <span class="pip pipws">
                                            <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                            </a>
                                            <br/>
                                            <cfif findNoCase("Read only ST", permissions) eq 0>
                                                <span class="remove rms" onclick="abdominalImageremove(this)" id="#item#">Remove image</span>
                                            </cfif>
                                        </span>
                                    </cfloop>
                                </cfif>	
                            </div> 
                    </div>
            
                    <!--- working end --->
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="abdominal_comments" rows="10" cols="120">#qgetCetaceanNecropsy.abdominal_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="abdominal_phototaken" id="abdominal_phototaken" onclick="abdominalPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.abdominal_phototaken') and  qgetCetaceanNecropsy.abdominal_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">HEPATOBILIARY SYSTEM</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="HEPATOBILIARY" id="HEPATOBILIARY">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.HEPATOBILIARY') and  qgetCetaceanNecropsy.HEPATOBILIARY  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.HEPATOBILIARY') and  qgetCetaceanNecropsy.HEPATOBILIARY  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Liver Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple"name="Liver_Findings" id="Liver_Findings">
                            <cfloop query="qgetLiverFinding">
                                <cfif status eq 1>
                                    <option value="#qgetLiverFinding.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Liver_Findings,","),#qgetLiverFinding.ID#)>selected</cfif>>#qgetLiverFinding.finding#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Biliary Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Biliary_Findings" id="Biliary_Findings">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Biliary_Findings)#" index="j">
                                <option value="#Biliary_Findings[j]#"<cfif isdefined('qgetCetaceanNecropsy.Biliary_Findings') and  qgetCetaceanNecropsy.Biliary_Findings  eq #Biliary_Findings[j]#>selected</cfif> >#Biliary_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            
<!--- working start --->
<div class="col-lg-12" id="hepatobiliaryDiv">
    <div class="cust-row btn-rw startSpinner">
        <div class="cust-inp cust-inpts">
            <div class="cust-inp test" id="startHepatobiliarySpinner">
                <input type="file" placeholder="image Path" name="hepatobiliaryphoto" id="hepatobiliaryphoto" class="text-field text-fields" accept="image/*">
            </div>
            <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="hepatobiliaryShowPictures()">Upload</button></div>
        </div>
    </div>
</div>
<div class="choose-images">
    <cfset hepatobiliaryImgs = ValueList(qgetCetaceanNecropsy.hepatobiliaryImages,",")>
        <input type="hidden" name="hepatobiliaryImagesFile" value="#hepatobiliaryImgs#" id="hepatobiliaryImagesFile">
        <div id="hepatobiliaryPreviousimages" class="choose-images-detail">
            <CFIF listLen(hepatobiliaryImgs)> 
                <cfloop list="#hepatobiliaryImgs#" item="item" index="index">

                    <span class="pip pipws">
                        <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                            <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                        </a>
                        <br/>
                        <cfif findNoCase("Read only ST", permissions) eq 0>
                            <span class="remove rms" onclick="hepatobiliaryImageremove(this)" id="#item#">Remove image</span>
                        </cfif>
                    </span>
                </cfloop>
            </cfif>	
        </div> 
</div>

<!--- working end --->
    </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="hepatobiliary_comments" rows="10" cols="120">#qgetCetaceanNecropsy.hepatobiliary_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="hepatobiliary_phototaken" id="hepatobiliary_phototaken" onclick="hepatobiliaryPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.hepatobiliary_phototaken') and  qgetCetaceanNecropsy.hepatobiliary_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <!--- 6 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">CARDIOVASCULAR SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CARDIOVASCULAR" id="CARDIOVASCULAR">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.CARDIOVASCULAR') and  qgetCetaceanNecropsy.CARDIOVASCULAR  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.CARDIOVASCULAR') and  qgetCetaceanNecropsy.CARDIOVASCULAR  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl">Blood in Heart Chambers</label>
                </div>
                <div class="cust-inp" >
                    <select class="stl-op"name="Chambers" id="Chambers">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Chambers') and  qgetCetaceanNecropsy.Chambers  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Chambers') and  qgetCetaceanNecropsy.Chambers  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl">Describe</label>
                </div>
                <div class="cust-inp">
                    <input type="text" name="cardio_describe" value="#qgetCetaceanNecropsy.cardio_describe#" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <!--- 7 --->
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Pericardial Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Pericardial_Fluid" id="Pericardial_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Pericardial_Fluid)#" index="j">
                                <option value="#Pericardial_Fluid[j]#"<cfif isdefined('qgetCetaceanNecropsy.Pericardial_Fluid') and  qgetCetaceanNecropsy.Pericardial_Fluid  eq #Pericardial_Fluid[j]#>selected</cfif>
                                    >#Pericardial_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Overall Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Overall_Findings" id="Overall_Findings">
                            <cfloop from="1" to="#ArrayLen(Overall_Findings)#" index="j">
                                <option value="#Overall_Findings[j]#"
                                 <cfif ListFind(ValueList(qgetCetaceanNecropsy.Overall_Findings,","),#Overall_Findings[j]#)>selected</cfif>
                                    >#Overall_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
               
               <!--- working start --->
               <div class="col-lg-12" id="cardiovascularDiv">
                   <div class="cust-row btn-rw startSpinner">
                       <div class="cust-inp cust-inpts">
                           <div class="cust-inpst test" id="startCardiovascularSpinner">
                               <input type="file" placeholder="image Path" name="cardiovascularphoto" id="cardiovascularphoto" class="text-field text-fields" accept="image/*">
                           </div>
                           <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="cardiovascularShowPictures()">Upload</button></div>
                       </div>
                   </div>
               </div>
               <div class="choose-images">
                   <cfset cardiovascularImgs = ValueList(qgetCetaceanNecropsy.cardiovascularImages,",")>
                       <input type="hidden" name="cardiovascularImagesFile" value="#cardiovascularImgs#" id="cardiovascularImagesFile">
                       <div id="cardiovascularPreviousimages" class="choose-images-detail">
                           <CFIF listLen(cardiovascularImgs)> 
                               <cfloop list="#cardiovascularImgs#" item="item" index="index">
               
                                   <span class="pip pipws">
                                       <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                           <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                       </a>
                                       <br/>
                                       <cfif findNoCase("Read only ST", permissions) eq 0>
                                           <span class="remove rms" onclick="cardiovascularImageremove(this)" id="#item#">Remove image</span>
                                       </cfif>
                                   </span>
                               </cfloop>
                           </cfif>	
                       </div> 
               </div>
       
               <!--- working end --->
        </div>
    
    </div>
    <div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="cardio_comments" rows="10" cols="120">#qgetCetaceanNecropsy.cardio_comments#</textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" name="cardio_phototaken" id="cardio_phototaken" onclick="cardioPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.cardio_phototaken') and  qgetCetaceanNecropsy.cardio_phototaken  eq 'on'>checked</cfif>
            >
        </div>
    </div>
    <!--- 8 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PULMONARY SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PULMONARY" id="PULMONARY">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.PULMONARY') and  qgetCetaceanNecropsy.PULMONARY  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.PULMONARY') and  qgetCetaceanNecropsy.PULMONARY  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl">Foam - Froth in Airway</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Froth_in_Airway" id="Froth_in_Airway">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Froth_in_Airway') and  qgetCetaceanNecropsy.Froth_in_Airway  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Froth_in_Airway') and  qgetCetaceanNecropsy.Froth_in_Airway  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl">If Present</label>
                </div>
                <div class="cust-inp" >
                    <select class="stl-op"name="If_Present" id="If_Present">
                        <option value="">Select</option>
                        <option value="Anterior to Bifurction"<cfif isdefined('qgetCetaceanNecropsy.If_Present') and  qgetCetaceanNecropsy.If_Present  eq 'Anterior to Bifurction'>selected</cfif>>Anterior to Bifurction</option>
                        <option value="Posterior to Bifurction"<cfif isdefined('qgetCetaceanNecropsy.If_Present') and  qgetCetaceanNecropsy.If_Present  eq 'Posterior to Bifurction'>selected</cfif>>Posterior to Bifurction</option>
                        <option value="Anterior and Posterior to Bifurction"<cfif isdefined('qgetCetaceanNecropsy.If_Present') and  qgetCetaceanNecropsy.If_Present  eq 'Anterior and Posterior to Bifurction'>selected</cfif>>Anterior and Posterior to Bifurction</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Foam Amount:</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Foam_Amount" id="Foam_Amount">
                            <option value="">Select</option>
                            <option value="Small"<cfif isdefined('qgetCetaceanNecropsy.Foam_Amount') and  qgetCetaceanNecropsy.Foam_Amount  eq 'Small'>selected</cfif>>Small </option>
                            <option value="Moderate"<cfif isdefined('qgetCetaceanNecropsy.Foam_Amount') and  qgetCetaceanNecropsy.Foam_Amount  eq 'Moderate'>selected</cfif>>Moderate</option>
                            <option value="Copious"<cfif isdefined('qgetCetaceanNecropsy.Foam_Amount') and  qgetCetaceanNecropsy.Foam_Amount  eq 'Copious'>selected</cfif>>Copious</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Color of Foam</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Color_of_Foam" id="Color_of_Foam">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Color_of_Foam)#" index="j">
                                <option value="#Color_of_Foam[j]#" <cfif isdefined('qgetCetaceanNecropsy.Color_of_Foam') and  qgetCetaceanNecropsy.Color_of_Foam  eq #Color_of_Foam[j]#>selected</cfif>>#Color_of_Foam[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Sand/Sediment in Airway</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Sand_Sediment" id="Sand_Sediment">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Sand_Sediment') and  qgetCetaceanNecropsy.Sand_Sediment  eq 'Yes'>selected</cfif>>Yes</option>
                             <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Sand_Sediment') and  qgetCetaceanNecropsy.Sand_Sediment  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Trachea/Bronchi</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Trachea_Bronchi" id="Trachea_Bronchi">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Trachea_Bronchi)#" index="j">
                                <option value="#Trachea_Bronchi[j]#" <cfif isdefined('qgetCetaceanNecropsy.Trachea_Bronchi') and  qgetCetaceanNecropsy.Trachea_Bronchi  eq #Trachea_Bronchi[j]#>selected</cfif>>#Trachea_Bronchi[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lungs Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Lungs_Findings" id="Lungs_Findings">
                            <cfloop query="qgetLungFinding">
                                <cfif status eq 1>
                                    <option value="#qgetLungFinding.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Lungs_Findings,","),#qgetLungFinding.ID#)>selected</cfif>>#qgetLungFinding.finding#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lungs Float in Formalin</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Lungs_Float" id="Lungs_Float">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Lungs_Float') and  qgetCetaceanNecropsy.Lungs_Float  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Lungs_Float') and  qgetCetaceanNecropsy.Lungs_Float  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="pulmonary_comments" rows="10" cols="120">#qgetCetaceanNecropsy.pulmonary_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="pulmonary_phototaken" id="pulmonary_phototaken" onclick="pulmonaryPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.pulmonary_phototaken') and  qgetCetaceanNecropsy.pulmonary_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Parasites</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PULMONARYParasites" id="PULMONARYParasites">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.PULMONARYParasites') and  qgetCetaceanNecropsy.PULMONARYParasites  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value="No" <cfif isdefined('qgetCetaceanNecropsy.PULMONARYParasites') and  qgetCetaceanNecropsy.PULMONARYParasites  eq 'No'>selected</cfif>>No</option>
                        <!--- <option value="Yes">Yes</option>
                        <option value="No">No</option> --->
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Location</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box"multiple="multiple" name="Parasites_Location" id="Parasites_Location">
                        <cfloop query="qgetParasiteLocation">
                            <cfif status eq 1>
                                <option value="#qgetParasiteLocation.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Parasites_Location,","),#qgetParasiteLocation.ID#)>selected</cfif>>#qgetParasiteLocation.location#</option>
                            </cfif>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl"></label>
                </div>
                <div class="cust-inp">
                    <textarea id="top-area" name="pulmonary_textarea" rows="5" cols="50" spellcheck="false">#qgetCetaceanNecropsy.pulmonary_textarea#</textarea>
                </div>
            </div>
        </div>

                       <!--- working start --->
                       <div class="col-lg-5" id="pulmonaryDiv">
                        <div class="cust-row btn-rw startSpinner">
                            <div class="cust-inp cust-inpts">
                                <div class="cust-inp test" id="startPulmonarySpinner">
                                    <input type="file" placeholder="image Path" name="pulmonaryphoto" id="pulmonaryphoto" class="text-field text-fields" accept="image/*">
                                </div>
                                <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="pulmonaryShowPictures()">Upload</button></div>
                            </div>
                        </div>
                    </div>
                    <div class="choose-images">
                        <cfset pulmonaryImgs = ValueList(qgetCetaceanNecropsy.pulmonaryImages,",")>
                            <input type="hidden" name="pulmonaryImagesFile" value="#pulmonaryImgs#" id="pulmonaryImagesFile">
                            <div id="pulmonaryPreviousimages" class="choose-images-detail">
                                <CFIF listLen(pulmonaryImgs)> 
                                    <cfloop list="#pulmonaryImgs#" item="item" index="index">
                    
                                        <span class="pip pipws">
                                            <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                            </a>
                                            <br/>
                                            <cfif findNoCase("Read only ST", permissions) eq 0>
                                                <span class="remove rms" onclick="pulmonaryImageremove(this)" id="#item#">Remove image</span>
                                            </cfif>
                                        </span>
                                    </cfloop>
                                </cfif>	
                            </div> 
                    </div>
            
                    <!--- working end --->
    </div>
    </div>
    <!--- 9 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">LYMPHORETICULAR SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="LYMPHORETICULAR" id="LYMPHORETICULAR">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.LYMPHORETICULAR') and  qgetCetaceanNecropsy.LYMPHORETICULAR  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.LYMPHORETICULAR') and  qgetCetaceanNecropsy.LYMPHORETICULAR  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
    <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Spleen</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Spleen" id="Spleen">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.Spleen') and  qgetCetaceanNecropsy.Spleen  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.Spleen') and  qgetCetaceanNecropsy.Spleen  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Spleen Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Spleen_Findings" id="Spleen_Findings">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Trauma"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Trauma'>selected</cfif>>Trauma</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Masses"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Masses'>selected</cfif>>Masses</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw other">
                <!--- <div class="cust-fld"><label class="fl-lbl"></label>
                </div> --->
                <div class="cust-inp">
                    <input type="text" value="#qgetCetaceanNecropsy.lympho_other#"name="lympho_other"placeholder="Other" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <cfif isDefined('qgetLymphoreticular') AND #qgetLymphoreticular.recordcount# gt 0>
            <cfloop query="qgetLymphoreticular">
                <div class="col-lg-12 chako" >
                    <div class="col-lg-5">
                        <div class="cust-row">
                            <div class="cust-fld"><label class="fl-lbl">Lymph Node Present</label>
                            </div>
                            <div class="cust-inp">
                                <select name="lymphnode#qgetLymphoreticular.id#"id="lymphnode"class="stl-op">
                                    <option value="">Select</option>
                                    <cfloop query="qgetLymphNodePresent">
                                        <cfif status eq 1>
                                            <option value="#qgetLymphNodePresent.LymphNodePresent#"<cfif isdefined('qgetLymphoreticular.lymphnode') and  qgetLymphoreticular.lymphnode  eq #qgetLymphNodePresent.LymphNodePresent#>selected</cfif>>#qgetLymphNodePresent.LymphNodePresent#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="theak"></div>
                    <div class="col-lg-2">
                        <div class="cust-row ingm-rw">
                            <div class="cust-fld"><label class="fl-lbl">Size Length</label>
                            </div>
                            <div class="cust-inp">
                                <input type="text" placeholder="cm" value="#qgetLymphoreticular.nodelength#" id="nodelength" name="nodelength#qgetLymphoreticular.id#"class="text-field">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="cust-row ingm-rw">
                            <div class="cust-fld"><label class="fl-lbl">Width</label>
                            </div>
                            <div class="cust-inp">
                            <input type="text" placeholder="cm"  value="#qgetLymphoreticular.nodewidth#" id="nodewidth" name="nodewidth#qgetLymphoreticular.id#" class="text-field">
                            </div>
                        </div>
                    </div>
                </div>
            </cfloop>
        <cfelse>
            <div class="col-lg-12 chako" >
                <div class="col-lg-5">
                    <div class="cust-row">
                        <div class="cust-fld"><label class="fl-lbl">Lymph Node Present</label>
                        </div>
                        <div class="cust-inp">
                            <select name="lymphnode"id="lymphnode"class="stl-op">
                                <option value="">Select</option>
                                <cfloop query="qgetLymphNodePresent">
                                    <cfif status eq 1>
                                        <option value="#qgetLymphNodePresent.LymphNodePresent#"<cfif isdefined('qgetLymphoreticular.lymphnode') and  qgetLymphoreticular.lymphnode  eq #qgetLymphNodePresent.LymphNodePresent#>selected</cfif>>#qgetLymphNodePresent.LymphNodePresent#</option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="theak"></div>
                <div class="col-lg-2">
                    <div class="cust-row ingm-rw">
                        <div class="cust-fld"><label class="fl-lbl">Size Length</label>
                        </div>
                        <div class="cust-inp">
                            <input type="text" placeholder="cm" value="#qgetLymphoreticular.nodelength#" name="nodelength"class="text-field">
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="cust-row ingm-rw">
                        <div class="cust-fld"><label class="fl-lbl">Width</label>
                        </div>
                        <div class="cust-inp">
                        <input type="text" placeholder="cm"  value="#qgetLymphoreticular.nodewidth#" name="nodewidth" class="text-field">
                        </div>
                    </div>
                </div>
            </div>
        </cfif>
        
    <div id="newLymph" class="add_new_btn_content"></div>
    <div class="col-lg-12">
        <input type="hidden" name="dynamic_Lymph" value="" id="dynamic_Lymph">
        <input type="button" id="Add_newLymph" name="Add_newLymph" class="upld-btn" value="Add New" onclick="newLymphnode()">
    </div>

    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="lympho_comments" rows="10" cols="120">#qgetCetaceanNecropsy.lympho_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="lympho_phototaken" id="lympho_phototaken" onclick="lymphoPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.lympho_phototaken') and  qgetCetaceanNecropsy.lympho_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>
                   <!--- working start --->
              <div class="col-lg-5" id="lymphoreticularDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startLymphoreticularSpinner">
                            <input type="file" placeholder="image Path" name="lymphoreticularphoto" id="lymphoreticularphoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="lymphoreticularShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset lymphoreticularImgs = ValueList(qgetCetaceanNecropsy.lymphoreticularImages,",")>
                    <input type="hidden" name="lymphoreticularImagesFile" value="#lymphoreticularImgs#" id="lymphoreticularImagesFile">
                    <div id="lymphoreticularPreviousimages" class="choose-images-detail">
                        <CFIF listLen(lymphoreticularImgs)> 
                            <cfloop list="#lymphoreticularImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="lymphoreticularImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!--- 10 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">ENDOCRINE SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="ENDOCRINE" id="ENDOCRINE">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.ENDOCRINE') and  qgetCetaceanNecropsy.ENDOCRINE  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.ENDOCRINE') and  qgetCetaceanNecropsy.Spleen  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Adrenal Glands</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Adrenal_Glands" id="Adrenal_Glands">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Adrenal_Glands') and  qgetCetaceanNecropsy.Adrenal_Glands  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Adrenal_Glands') and  qgetCetaceanNecropsy.Adrenal_Glands  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Adrenal_Glands') and  qgetCetaceanNecropsy.Adrenal_Glands  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Left Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text" name="adrenal_leftLength"placeholder="cm" value="#qgetCetaceanNecropsy.adrenal_leftLength#"class="text-field">
                </div>
            </div>
            <div class="cust-row ingm-rw mt-10">
                <div class="cust-fld"><label class="fl-lbl">Right Length</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_rightLength"placeholder="cm" value="#qgetCetaceanNecropsy.adrenal_rightLength#"class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_leftwidth"placeholder="cm" value="#qgetCetaceanNecropsy.adrenal_leftwidth#"class="text-field">
                </div>
            </div>
            <div class="cust-row mt-10">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_rightwidth"placeholder="cm"value="#qgetCetaceanNecropsy.adrenal_rightwidth#" class="text-field">
            </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Thyroid</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Thyroid" id="Thyroid">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Thyroid') and  qgetCetaceanNecropsy.Thyroid  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Thyroid') and  qgetCetaceanNecropsy.Thyroid  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Thyroid') and  qgetCetaceanNecropsy.Thyroid  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text"name="thyroid_length" value="#qgetCetaceanNecropsy.thyroid_length#"placeholder="cm" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="thyroid_width"placeholder="cm"value="#qgetCetaceanNecropsy.thyroid_width#" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Pituitary Gland</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Pituitary_Gland" id="Pituitary_Gland">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Pituitary_Gland') and  qgetCetaceanNecropsy.Pituitary_Gland  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Pituitary_Gland') and  qgetCetaceanNecropsy.Pituitary_Gland  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Pituitary_Gland') and  qgetCetaceanNecropsy.Pituitary_Gland  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text"name="Pituitary_length" placeholder="cm" value="#qgetCetaceanNecropsy.Pituitary_length#"class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" placeholder="cm" name="Pituitary_width"value="#qgetCetaceanNecropsy.Pituitary_width#"class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5"></div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="endocrine_comments" rows="10" cols="120">#qgetCetaceanNecropsy.endocrine_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="endocrine_phototaken" id="endocrine_phototaken" onclick="endocrinePhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.endocrine_phototaken') and  qgetCetaceanNecropsy.endocrine_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>

                  <!--- working start --->
              <div class="col-lg-5" id="endocrineDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startEndocrineSpinner">
                            <input type="file" placeholder="image Path" name="endocrinephoto" id="endocrinephoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="endocrineShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset endocrineImgs = ValueList(qgetCetaceanNecropsy.endocrineImages,",")>
                    <input type="hidden" name="endocrineImagesFile" value="#endocrineImgs#" id="endocrineImagesFile">
                    <div id="endocrinePreviousimages" class="choose-images-detail">
                        <CFIF listLen(endocrineImgs)> 
                            <cfloop list="#endocrineImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="endocrineImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!--- 11 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">UROGENITAL SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="UROGENITAL" id="UROGENITAL">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL') and  qgetCetaceanNecropsy.UROGENITAL  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.UROGENITAL') and  qgetCetaceanNecropsy.UROGENITAL  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Kidneys Findings LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Kidney_left" id="Kidney_left">
                            <cfloop from="1" to="#ArrayLen(Kidneys_Findings)#" index="j">
                                <option value="#Kidneys_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.Kidney_left,","),#Kidneys_Findings[j]#)>selected</cfif>>#Kidneys_Findings[j]#</option>
                                
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Kidneys Findings RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Kidney_right" id="Kidney_right">
                            <cfloop from="1" to="#ArrayLen(Kidneys_Findings)#" index="j">
                                <option value="#Kidneys_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.Kidney_right,","),#Kidneys_Findings[j]#)>selected</cfif>>#Kidneys_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-3 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Urinary Bladder</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Urinary_Bladder" id="Urinary_Bladder">
                            <option value="">Select</option>
                            <option value="Empty"<cfif isdefined('qgetCetaceanNecropsy.Urinary_Bladder') and  qgetCetaceanNecropsy.Urinary_Bladder  eq "Empty">selected</cfif>>Empty </option>
                            <option value="Contents"<cfif isdefined('qgetCetaceanNecropsy.Urinary_Bladder') and  qgetCetaceanNecropsy.Urinary_Bladder  eq "Contents">selected</cfif>>Contents</option>
                            
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="urin_volume" value="#qgetCetaceanNecropsy.urin_volume#"placeholder="ml" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-3 mt-10">
                <strong class="strong-position">If Urine Present</strong>
                <div class="cust-row">
                    <div class="cust-fld">  <label class="fl-lbl">  Color</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="UROGENITAL_color" id="UROGENITAL_color">
                            <option value="">Select</option>
                            <option value="Clear"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Clear">selected</cfif>>Clear</option>
                            <option value="Light yellow"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Light yellow">selected</cfif>>Light yellow</option>
                            <option value="Dark yellow"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Dark yellow">selected</cfif>>Dark yellow</option>
                            <option value="Pink - Red"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Pink - Red">selected</cfif>>Pink - Red</option>
                            <option value="Brown"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Brown">selected</cfif>>Brown</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Consistancy</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Consistancy" id="Consistancy">
                            <option value="">Select</option>
                            <option value="Clear"<cfif isdefined('qgetCetaceanNecropsy.Consistancy') and  qgetCetaceanNecropsy.Consistancy  eq "Clear">selected</cfif>>Clear</option>
                            <option value="Cloudy"<cfif isdefined('qgetCetaceanNecropsy.Consistancy') and  qgetCetaceanNecropsy.Consistancy  eq "Cloudy">selected</cfif>>Cloudy</option>
                            <option value="Flocculent"<cfif isdefined('qgetCetaceanNecropsy.Consistancy') and  qgetCetaceanNecropsy.Consistancy  eq "Flocculent">selected</cfif>>Flocculent</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Abnormalities</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Abnormalities" id="Abnormalities">
                            <option value="">Select</option>
                            <option value="Mass(es)"<cfif isdefined('qgetCetaceanNecropsy.Abnormalities') and  qgetCetaceanNecropsy.Abnormalities  eq "Mass(es)">selected</cfif>>Mass(es)</option>
                            <option value="Parasites"<cfif isdefined('qgetCetaceanNecropsy.Abnormalities') and  qgetCetaceanNecropsy.Abnormalities  eq "Parasites">selected</cfif>>Parasites</option>
                            <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Abnormalities') and  qgetCetaceanNecropsy.Abnormalities  eq "Other">selected</cfif>>Other</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Describe</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Abnormalities_describe" value="#qgetCetaceanNecropsy.Abnormalities_describe#"class="text-field">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Reproductive Organs</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Reproductive_Organs" id="Reproductive_Organs">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.Reproductive_Organs') and  qgetCetaceanNecropsy.Reproductive_Organs  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.Reproductive_Organs') and  qgetCetaceanNecropsy.Reproductive_Organs  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Identified As</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Identified_As" id="Identified_As">
                            <option value="">Select</option>
                            <option value="Penis"<cfif isdefined('qgetCetaceanNecropsy.Identified_As') and  qgetCetaceanNecropsy.Identified_As  eq 'Penis'>selected</cfif>>Penis</option>
                            <option value="Vagina"<cfif isdefined('qgetCetaceanNecropsy.Identified_As') and  qgetCetaceanNecropsy.Identified_As  eq 'Vagina'>selected</cfif>>Vagina</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Lesions</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Lesions" id="Lesions">
                            <option valu="">Select</option>
                            <option valu="Yes"<cfif isdefined('qgetCetaceanNecropsy.Lesions') and  qgetCetaceanNecropsy.Lesions  eq 'Yes'>selected</cfif>>Yes</option>
                            <option valu="No"<cfif isdefined('qgetCetaceanNecropsy.Lesions') and  qgetCetaceanNecropsy.Lesions  eq 'No'>selected</cfif>>No</option>
                            <option value="Unknown"<cfif isdefined('qgetCetaceanNecropsy.Lesions') and  qgetCetaceanNecropsy.Lesions  eq 'Unknown'>selected</cfif>>Unknown</option>
                            
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Gonads Identified as</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Gonads_Identified" id="Gonads_Identified">
                            <option value=" ">Select</option>
                            <option value="Testes"<cfif isdefined('qgetCetaceanNecropsy.Gonads_Identified') and  qgetCetaceanNecropsy.Gonads_Identified  eq 'Testes'>selected</cfif>>Testes </option>
                            <option value=""<cfif isdefined('qgetCetaceanNecropsy.Gonads_Identified') and  qgetCetaceanNecropsy.Gonads_Identified  eq 'Ovaries'>selected</cfif>>Ovaries</option>
                         
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Testes Length LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_Length_LEFT" value="#qgetCetaceanNecropsy.Testes_Length_LEFT#"placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Testes_Length_width"placeholder="cm" value="#qgetCetaceanNecropsy.Testes_Length_width#"class="text-field">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Mammary Glands LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Glands_LEFT" id="Glands_LEFT">
                            <option value="">Select</option>
                            <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Glands_LEFT') and  qgetCetaceanNecropsy.Glands_LEFT  eq "No Findings">selected</cfif>>No Findings </option>
                            <option value="Milk Production"<cfif isdefined('qgetCetaceanNecropsy.Glands_LEFT') and  qgetCetaceanNecropsy.Glands_LEFT  eq 'Milk Production'>selected</cfif>>Milk Production</option>
                            <option value="Abnormal"<cfif isdefined('qgetCetaceanNecropsy.Glands_LEFT') and  qgetCetaceanNecropsy.Glands_LEFT  eq 'Abnormal'>selected</cfif>>Abnormal</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Testes Length RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_Length_right" placeholder="cm" value="#qgetCetaceanNecropsy.Testes_Length_right#" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_width_right" value="#qgetCetaceanNecropsy.Testes_width_right#" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Mammary Glands RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Glands_RIGHT" id="Glands_RIGHT">
                            <option value="">Select</option>
                            <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Glands_RIGHT') and  qgetCetaceanNecropsy.Glands_RIGHT  eq 'No Findings'>selected</cfif>>No Findings </option>
                            <option value="Milk Production"<cfif isdefined('qgetCetaceanNecropsy.Glands_RIGHT') and  qgetCetaceanNecropsy.Glands_RIGHT  eq 'Milk Production'>selected</cfif>>Milk Production</option>
                            <option value="Abnormal"<cfif isdefined('qgetCetaceanNecropsy.Glands_RIGHT') and  qgetCetaceanNecropsy.Glands_RIGHT  eq 'Abnormal'>selected</cfif>>Abnormal</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Ovary Length LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_Length_LEFT" placeholder="cm"value="#qgetCetaceanNecropsy.Ovary_Length_LEFT#" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Ovary_Width_LEFT"placeholder="cm" value="#qgetCetaceanNecropsy.Ovary_Width_LEFT#"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row lnth-rw">
                    <div class="cust-fld"><label class="fl-lbl">Follicles Present</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Follicles_Present_Left" id="Follicles_Present_Left">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_Left') and  qgetCetaceanNecropsy.Follicles_Present_Left  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value="No"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_Left') and  qgetCetaceanNecropsy.Follicles_Present_Left  eq 'No'>selected</cfif>>No</option>
                           
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10"></div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Ovary Length RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_Length_right" placeholder="cm" value="#qgetCetaceanNecropsy.Ovary_Length_right#" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_width_right" value="#qgetCetaceanNecropsy.Ovary_width_right#" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row lnth-rw">
                    <div class="cust-fld"><label class="fl-lbl">Follicles Present</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Follicles_Present_right" id="Follicles_Present_right">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_right') and  qgetCetaceanNecropsy.Follicles_Present_right  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value="No"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_right') and  qgetCetaceanNecropsy.Follicles_Present_right  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5"></div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="UROGENITAL_Comments" rows="10" cols="120">#qgetCetaceanNecropsy.UROGENITAL_Comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="UROGENITAL_phototaken" id="UROGENITAL_phototaken" onclick="UROGENITALPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_phototaken') and  qgetCetaceanNecropsy.UROGENITAL_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>
                   <!--- working start --->
              <div class="col-lg-5" id="urogenitalDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startUrogenitalSpinner">
                            <input type="file" placeholder="image Path" name="urogenitalphoto" id="urogenitalphoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="urogenitalShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset urogenitalImgs = ValueList(qgetCetaceanNecropsy.urogenitalImages,",")>
                    <input type="hidden" name="urogenitalImagesFile" value="#urogenitalImgs#" id="urogenitalImagesFile">
                    <div id="urogenitalPreviousimages" class="choose-images-detail">
                        <CFIF listLen(urogenitalImgs)> 
                            <cfloop list="#urogenitalImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="urogenitalImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!--- 12 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">ALIMENTARY SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="ALIMENTARYSYSTEM" id="ALIMENTARYSYSTEM">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'NE'>selected</cfif>>NE</option>
                        <option value="Complete"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'Complete'>selected</cfif>>Complete</option>
                        <option value="Partial"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'Partial'>selected</cfif>>Partial</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">ESOPHAGUS</h3>
            </div>
            <div class="sys-colum">
                <p>Ulcers/exudate</p>
                <select class="sys-op" name="ESOPHAGUSUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Trauma</p>
                <select class="sys-op" name="ESOPHAGUSTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Masses</p>
                <select class="sys-op" name="ESOPHAGUSMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Impaction</p>
                <select class="sys-op" name="ESOPHAGUSImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Obstruction</p>
                <select class="sys-op" name="ESOPHAGUSObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>lntussusception</p>
                <select class="sys-op" name="ESOPHAGUSlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Parasites</p>
                <select class="sys-op" name="ESOPHAGUSParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <p>Other</p>
                <input type="text" class="text-field"value="#qgetCetaceanNecropsy.ESOPHAGUSOther#" name="ESOPHAGUSOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="ESOPHAGUSContents" value="#qgetCetaceanNecropsy.ESOPHAGUSContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">FORESTOMACH</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="FORESTOMACHOther"value="#qgetCetaceanNecropsy.FORESTOMACHOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="FORESTOMACHContents"value="#qgetCetaceanNecropsy.FORESTOMACHContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">GLANDULAR STOMACH</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="GLANDULARSTOMACHOther" value="#qgetCetaceanNecropsy.GLANDULARSTOMACHOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="GLANDULARSTOMACHContents" value="#qgetCetaceanNecropsy.GLANDULARSTOMACHContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">PYLORUS</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="PYLORUSOther"value="#qgetCetaceanNecropsy.PYLORUSOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="PYLORUSContents" value="#qgetCetaceanNecropsy.PYLORUSContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">SMALL INTESTINE</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINETrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINElntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="SMALLINTESTINEOther"value="#qgetCetaceanNecropsy.SMALLINTESTINEOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="SMALLINTESTINEContents"value="#qgetCetaceanNecropsy.SMALLINTESTINEContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">COLON</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="COLONOther"value="#qgetCetaceanNecropsy.COLONOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="COLONContents"value="#qgetCetaceanNecropsy.COLONContents#">
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PANCREAS</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PANCREAS" id="PANCREAS">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.PANCREAS') and  qgetCetaceanNecropsy.PANCREAS  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.PANCREAS') and  qgetCetaceanNecropsy.PANCREAS  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Pancreas Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PancreasFindings" id="PancreasFindings">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Trauma"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Trauma'>selected</cfif>>Trauma</option>
                        <option value="Masses"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Masses'>selected</cfif>>Masses</option>
                        <option value="Engorged"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Engorged'>selected</cfif>>Engorged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                <!--- <div class="cust-fld"><label class="fl-lbl">Describe</label>
                </div> --->
                <div class="cust-inp">
                    <input type="text" placeholder="Other" class="text-field" name="PANCREASOthers"value="#qgetCetaceanNecropsy.PANCREASOthers#">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">GI FOREIGN MATERIAL</h3></div></label>
                </div>
                 <div class="cust-inp">
                    <select class="stl-op" name="GIFOREIGNMATERIAL" id="GIFOREIGNMATERIAL">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.GIFOREIGNMATERIAL') and  qgetCetaceanNecropsy.GIFOREIGNMATERIAL  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value="No"<cfif isdefined('qgetCetaceanNecropsy.GIFOREIGNMATERIAL') and  qgetCetaceanNecropsy.GIFOREIGNMATERIAL  eq 'No'>selected</cfif>>No</option>
                    </select>
                    <!---<select class="stl-op search-box" multiple="multiple" name=" GIFOREIGNMATERIAL" id="GIFOREIGNMATERIAL">
                       
                        <cfloop query="qGIForeignMaterial">
                            <cfif status eq 1 >
                                <option value="#qGIForeignMaterial.GIForeignMaterial#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.GIFOREIGNMATERIAL,","),#qGIForeignMaterial.GIForeignMaterial#)>selected</cfif>>#qGIForeignMaterial.GIForeignMaterial#</option>
                            </cfif>
                        </cfloop>
                    </select>--->
                </div> 
            </div>
        </div>
        <div class="col-lg-2">
                <div class="just-fld"><label class="fl-lbl">If Yes, see below</label>
            </div>
        </div>
        <!--- <cfdump var="#qgetCetaceanNecropsy.InjuryLesionAssociated#>" --->
        <div class="col-lg-5">
            <div class="cust-row material-rw">
                <div class="cust-fld"><label class="fl-lbl">Injury/Lesion Associated with Foreign Material</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="InjuryLesionAssociated" id="InjuryLesionAssociated">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.InjuryLesionAssociated') and  qgetCetaceanNecropsy.InjuryLesionAssociated  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value="No"<cfif isdefined('qgetCetaceanNecropsy.InjuryLesionAssociated') and  qgetCetaceanNecropsy.InjuryLesionAssociated  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="sys-comment-row mt-20 btm-sec">
        <div class="sys-colum-left">
            <h3 class="sys-title">Describe</h3>
        </div>
        <div class="sys-colum-right">
            <textarea id="top-area" name="InjuryLesionAssociatedContents" rows="10" cols="120">#qgetCetaceanNecropsy.InjuryLesionAssociatedContents#</textarea>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">GI Foreign Material Type</label>
                </div>
                <div class="cust-inp ">
                    <!--- <select class="stl-op search-box" multiple="multiple" name="GIForeignMaterialType" id="GIForeignMaterialType" >
                       <option value="">Select</option>
                        <cfloop array="#material_type#" item="item" index="j">
                            <option value="#item#" <cfif isdefined('qgetCetaceanNecropsy.GIForeignMaterialType') and  qgetCetaceanNecropsy.GIForeignMaterialType  eq #item#>selected</cfif>>#item#</option>
                            
                        </cfloop>
                    </select> --->

                    <select class="stl-op search-box" multiple="multiple" name="GIForeignMaterialType" id="GIForeignMaterialType">
                        <cfloop from="1" to="#ArrayLen(material_type)#" index="j">
                            <option value="#material_type[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.GIForeignMaterialType,","),#material_type[j]#)>selected</cfif>
                                >#material_type[j]#</option>
                        </cfloop>
                    </select>

                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Material Lesion Location</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field" name="MaterialLesionLocation" value="#qgetCetaceanNecropsy.MaterialLesionLocation#">
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 material">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">Material Collected</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="MaterialCollected" id="MaterialCollected">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.MaterialCollected') and  qgetCetaceanNecropsy.MaterialCollected  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value="No"<cfif isdefined('qgetCetaceanNecropsy.MaterialCollected') and  qgetCetaceanNecropsy.MaterialCollected  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-6 ">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Disposition of Material Collected</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field" name="DispositionofMaterialCollected"value="#qgetCetaceanNecropsy.DispositionofMaterialCollected#">
                </div>
            </div>
        </div>
    </div>
    <!--- AND #report# neq '' AND #report# neq 'emptys' --->
    <cfif isDefined('qgetParasites') AND #qgetParasites.recordcount# gt 0>
        <input type="hidden" id="Dynamicparasites" value="#qgetParasites.recordcount#" name="counting">
        <cfloop query="qgetParasites">
            <div class="col-lg-12 parasitediv ">
                <div class="col-lg-4">
                    <div class="cust-row btm-rw">
                        <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PARASITES</h3></div></label>
                        </div>
                        <div class="cust-inp">
                            <select class="stl-op" name="PARASITES#qgetParasites.id#" id="PARASITES">
                                <!--- <option value="">Select</option> --->
                                <option value="Yes"<cfif isdefined('qgetParasites.PARASITES') and  qgetParasites.PARASITES  eq 'Yes'>selected</cfif>>Yes</option>
                                <option value="No"<cfif isdefined('qgetParasites.PARASITES') and  qgetParasites.PARASITES  eq 'No'>selected</cfif>>No</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="cust-row">
                        <div class="cust-fld"><label class="fl-lbl">Parasite Type</label>
                        </div>
                        <div class="cust-inp">
                            <select class="stl-op" name="ParasiteType#qgetParasites.id#" id="ParasiteType">
                                
                                <cfloop query="qgetParasiteType">
                                    <cfif status eq 1 >
                                        <option value="#qgetParasiteType.type#"<cfif isdefined('qgetParasites.ParasiteType') and  qgetParasites.ParasiteType  eq #qgetParasiteType.type#>selected</cfif>>#qgetParasiteType.type#</option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="cust-row describe-rw">
                        <div class="cust-fld"><label class="fl-lbl">Location</label>
                        </div>
                        <div class="cust-inp">
                            <select class="stl-op" name="Parasitelocation#qgetParasites.id#" id="Parasitelocation">
                                <cfloop query="qgetParasiteLocation">
                                    <cfif status eq 1 >
                                        <option value="#qgetParasiteLocation.location#"<cfif isdefined('qgetParasites.Parasitelocation') and  qgetParasites.Parasitelocation  eq #qgetParasiteLocation.location#>selected</cfif>>#qgetParasiteLocation.location#</option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </cfloop>
    <cfelse>
        <div class="col-lg-12 parasitediv ">
            <div class="col-lg-4">
                <div class="cust-row btm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PARASITES</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="PARASITES" id="PARASITES">
                            <option value="">Select</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Parasite Type</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ParasiteType" id="ParasiteType">
                            <cfloop query="qgetParasiteType">
                                <cfif status eq 1 >
                                    <option value="#qgetParasiteType.type#">#qgetParasiteType.type#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="cust-row describe-rw">
                    <div class="cust-fld"><label class="fl-lbl">Location</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Parasitelocation" id="Parasitelocation">
                            <cfloop query="qgetParasiteLocation">
                                <cfif status eq 1 >
                                    <option value="#qgetParasiteLocation.location#">#qgetParasiteLocation.location#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </cfif>
    <div  id="newparasite"></div>
    <div class="col-lg-12">
        <div class="simple-button pt-15 align-right">
            <input type="hidden" name="dynamic_parasite" value="" id="dynamic_parasite">
            <input type="button" id="Add_newparasite" name="Add_newparasite" class="upld-btn" value="Add New" onclick="newparasite()">
        </div>
    </div>
    </div>
    <div class="row">
    <div class="col-lg-12">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="Parasitecomments" rows="10" cols="120">#qgetCetaceanNecropsy.Parasitecomments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="Parasite_phototaken" id="Parasite_phototaken" onclick="ParasitePhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.Parasite_phototaken') and  qgetCetaceanNecropsy.Parasite_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
               <!--- working start --->
              <div class="col-lg-5" id="alimentaryphotoDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startAlimentarySpinner">
                            <input type="file" placeholder="image Path" name="alimentaryphoto" id="alimentaryphoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="alimentaryShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset alimentaryImgs = ValueList(qgetCetaceanNecropsy.alimentaryImages,",")>
                    <input type="hidden" name="alimentaryImagesFile" value="#alimentaryImgs#" id="alimentaryImagesFile">
                    <div id="alimentaryPreviousimages" class="choose-images-detail">
                        <CFIF listLen(alimentaryImgs)> 
                            <cfloop list="#alimentaryImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="alimentaryImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!-- 13 -->
    <div class="row pt-30">
    <div class="">
        <div class="mrb-40">
            <label class="fl-lbl">
                <div class="mid-t">
                    <h3 class="m-0">CENTRAL NERVOUS SYSTEM</h3>
                </div>
            </label>
        </div>
    </div>
    <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld">
                    <label class="fl-lbl">Brain</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CENTRALbrain" id="">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALbrain') and  qgetCetaceanNecropsy.CENTRALbrain  eq "Examined">selected</cfif>
                            >Examined</option>
                        <option value="NE"<cfif isdefined('qgetCetaceanNecropsy.CENTRALbrain') and  qgetCetaceanNecropsy.CENTRALbrain  eq 'NE'>selected</cfif>
                            >NE</option>
                        <option value="Partial Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALbrain') and  qgetCetaceanNecropsy.CENTRALbrain  eq "Partial Examined">selected</cfif>
                            >Partial Examined</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Brain Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box" multiple="multiple" name="CENTRALBrainFindings" id="CENTRALBrainFindings">
                        <cfloop from="1" to="#ArrayLen(brain_Findings)#" index="j">
                            <option value="#brain_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.CENTRALBrainFindings,","),#brain_Findings[j]#)>selected</cfif>
                                >#brain_Findings[j]#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                
                <div class="cust-inp">
                    <input type="text"name="brainother" value="#qgetCetaceanNecropsy.brainother#"placeholder="Other" class="text-field">
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 mt-10">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">Spinal Cord</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CENTRALSpinalCord" id="">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALSpinalCord') and  qgetCetaceanNecropsy.CENTRALSpinalCord  eq "Examined">selected</cfif>
                            >Examined</option>
                        <option value="NE"<cfif isdefined('qgetCetaceanNecropsy.CENTRALSpinalCord') and  qgetCetaceanNecropsy.CENTRALSpinalCord  eq 'NE'>selected</cfif>
                            >NE</option>
                        <option value="Partial Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALSpinalCord') and  qgetCetaceanNecropsy.CENTRALSpinalCord  eq "Partial Examined">selected</cfif>
                            >Partial Examined</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Spinal Cord Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box" multiple="multiple" name="CENTRALSpinalCordfinding" id="CENTRALSpinalCordfinding">
                        <cfloop from="1" to="#ArrayLen(brain_Findings)#" index="j">
                            <option value="#brain_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.CENTRALSpinalCordfinding,","),#brain_Findings[j]#)>selected</cfif>
                                >#brain_Findings[j]#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                
                <div class="cust-inp">
                    <input type="text"name="spinalother" placeholder="Other" value="#qgetCetaceanNecropsy.spinalother#"class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-20">
        <div class="col-lg-5"></div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="nervoussystemcomments" rows="10" cols="120" spellcheck="false">#qgetCetaceanNecropsy.nervoussystemcomments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="nervoussystemphototaken" onclick="centralNervous()" id="centralNervousCheck" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.nervoussystemphototaken') and  qgetCetaceanNecropsy.nervoussystemphototaken  eq 'on'>checked</cfif>
                >
            </div>

            <!--- working start --->
            





    
            <!--- working end --->
            




        </div>
        <div class="col-lg-5" id="centralNervousdiv">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inpts">
                    <div class="cust-inp test" id="startCentralNervousSpinner">
                        <input type="file" placeholder="image Path" name="centralNervousphoto" id="centralNervousphoto" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="centralNervousShowPictures()">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset centralNervousImgs = ValueList(qgetCetaceanNecropsy.centralNervousImages,",")>
                <input type="hidden" name="centralNervousImagesFile" value="#centralNervousImgs#" id="centralNervousImagesFile">
                <div id="centralNervousPreviousimages" class="choose-images-detail">
                    <CFIF listLen(centralNervousImgs)> 
                        <cfloop list="#centralNervousImgs#" item="item" index="index">
        
                            <span class="pip pipws">
                                <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rms" onclick="centralNervousImageremove(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>	
                </div>
            
        </div>

        <div class="col-lg-6 sd-btns">
            <input type="hidden" value="" id="dropdownvalues">
                <button type="submit" value="Save"  id="savebutton" name="save" class="btn btn-success btn-save">Save</button>
                <cfif isDefined('qgetCetaceanNecropsy.ID') and qgetCetaceanNecropsy.ID neq "">
                    <input type="submit" id="delete_btn" name="deleteNecropsyRecord" class="btn btn-oRangem-rl-4 btn-del" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                </cfif>
                <cfif (permissions eq "full_access")>
                    <input  type="submit" id="deletCetaceanNecropsyAllRecord" name="deletCetaceanNecropsyAllRecord" class="btn btn-oRangem-rl-4 btn-del" value="Delete All Records" onclick="if(confirm('Are you sure to Delete all Records?')){}else{return false;};">
                </cfif>
        </div>

        
    </div>
    </div>
    </div>
    </div>

                </div>
            </div>   
            <!--- end for NecropsyReport --->

            <!--- start for Morphometrics --->
            <div role="tabpanel" class="tab-pane" id="Morphometrics">  
                <input type='hidden' name='Morphometricss_ID' id="Morphometricss_ID" value='#qgetMorphometricsData.ID#'>
                <div class="row pt-20">              
                <div class="full-img-sec">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="img-group">
                                <img src="http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Tursiops_Diagram.png"id="measureImage">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <!-- <div class="mb-1 cust-row right-panel-rw">
                                <label class="fishtwo-labelone">Estimated Weight</label>
                                <div class="input"> 
                                    <input class="input-style weight-input text-field" type="text" name="EstimatedWeight" id="EstimatedWeight" value="#qgetMorphometricsData.EstimatedWeight#">

                                    <select class="input-style " name="EstimatedWeightUnit">
                                        <option value="lbs" <cfif '#qgetMorphometricsData.EstimatedWeightUnit#' eq 'lbs'>selected</cfif> >lbs</option>
                                        <option value="kg" <cfif '#qgetMorphometricsData.EstimatedWeightUnit#' eq 'kg'>selected</cfif>>kg</option>
                                    </select>
                                </div>
                            </div> -->

                            <div class="cust-row right-panel-rw">
                                <div class="right-fld"><label class="fl-lbl">Estimated Weight</label>
                                </div>
                                <div class="right-inp">
                                    <input class="text-field" type="text" name="EstimatedWeight" id="EstimatedWeight" value="#qgetMorphometricsData.EstimatedWeight#">
                                </div>
                                <div class="right-fld">
                                    <select class="input-style estimate-style" name="EstimatedWeightUnit">
                                        <option value="lbs" <cfif '#qgetMorphometricsData.EstimatedWeightUnit#' eq 'lbs'>selected</cfif> >lbs</option>
                                        <option value="kg" <cfif '#qgetMorphometricsData.EstimatedWeightUnit#' eq 'kg'>selected</cfif>>kg</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="cust-row right-panel-rw mt-10">
                                <div class="right-fld"><label class="fl-lbl">Total Length (1)</label>
                                </div>
                                <div class="right-inp">
                                    <input type="text" name="totalLength"placeholder="" value="#qgetMorphometricsData.totalLength#" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm (rostrum to fluke notch)</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10">
                                <div class="right-fld"><label class="fl-lbl">Rostrum to Dorsal Fin (2)</label>
                                </div>
                                <div class="right-inp">
                                    <input type="text" name="rostrum"placeholder=""  value="#qgetMorphometricsData.rostrum#" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm (center of blowhole)</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10">
                                <div class="right-fld"><label class="fl-lbl">Blowhole to Dorsal (3)</label>
                                </div>
                                <div class="right-inp">
                                    <input type="text" name="blowhole"  value="#qgetMorphometricsData.blowhole#"  placeholder="" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10">
                                <div class="right-fld"><label class="fl-lbl">Fluke Width (4)</label>
                                </div>
                                <div class="right-inp">
                                    <input type="text"name="fluke"   value="#qgetMorphometricsData.fluke#" placeholder="" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10">
                                <div class="right-fld"><label class="fl-lbl">Girth (circumference) (5)</label>
                                </div>
                                <div class="right-inp">
                                    <input type="text"name="girth"   value="#qgetMorphometricsData.girth#" placeholder="" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10">
                                <div class="right-fld"><label class="fl-lbl">Axillary (6)</label>
                                </div>
                                <div class="right-inp">
                                    <input type="text" name="axillary"placeholder=""  value="#qgetMorphometricsData.axillary#" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10">
                                <div class="right-fld"><label class="fl-lbl">Maximum (7)</label>
                                </div>
                                <div class="right-inp">
                                    <input type="text" name="maxium" placeholder=""   value="#qgetMorphometricsData.maxium#" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10" id="DorsalFinHeight" >
                                <div class="right-fld"><label class="fl-lbl">Dorsal Fin Height (8)</label>
                                </div>
                                <!--- <cfdump var="#qgetMorphometricsData.maxium#" > --->
                                <div class="right-inp">
                                    <input type="text" name="DorsalFinHeight" placeholder=""   value="#qgetMorphometricsData.DorsalFinHeight#" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm</label>
                                </div>
                            </div>
                            <div class="cust-row right-panel-rw mt-10" id="RostrumtoBlowhole" >
                                <div class="right-fld"><label class="fl-lbl">Rostrum to Blowhole<span id="KogiaSpan" style="display:none;">(9)</span></label>
                                </div>
                                <div class="right-inp">
                                    <input type="text" name="RostrumtoBlowhole" placeholder=""   value="#qgetMorphometricsData.RostrumtoBlowhole#" class="text-field">
                                </div>
                                <div class="right-fld"><label class="fl-lbl">cm</label>
                                </div>
                            </div>

                            </div>
                    </div>
                    <div class="row pt-30">
                        <div class="col-lg-5">
                            <div class="cust-row mid-dorsal">
                                <div class="cust-fld"><label class="fl-lbl">Blubber Thickness Mid-Dorsal</label>
                                </div>
                                <div class="cust-inp">
                                    <input type="text" name="blubber"  value="#qgetMorphometricsData.blubber#" class="text-field">
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <div class="cust-fld">
                        <lable class="fl-lbl">Tooth Count</lable>
                    </div>
                        </div>
                    </div>
                    <div class="row mt-10">
                        <div class="col-lg-5">
                            <div class="cust-row mid-dorsal">
                                <div class="cust-fld"><label class="fl-lbl">Mid-Lateral</label>
                                </div>
                                <div class="cust-inp">
                                    <input type="text" name="midlateral"  value="#qgetMorphometricsData.midlateral#" class="text-field">
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="cust-row mid-dorsal">
                                <div class="cust-fld"><label class="fl-lbl">Upper Left</label>
                                </div>
                                <div class="cust-inp">
                                    <input type="text" name="Lateralupperleft"  value="#qgetMorphometricsData.Lateralupperleft#" class="text-field">
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="cust-row mid-dorsal">
                                <div class="cust-fld"><label class="fl-lbl">Lower Left</label>
                                </div>
                                <div class="cust-inp">
                                    <input type="text" name="Laterallowerleft"  value="#qgetMorphometricsData.Laterallowerleft#" class="text-field">
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-3"></div>
                    </div>
                    <div class="row mt-10">
                        <div class="col-lg-5">
                            <div class="cust-row mid-dorsal">
                                <div class="cust-fld"><label class="fl-lbl">Mid-Ventral</label>
                                </div>
                                <div class="cust-inp">
                                    <input type="text" name="midVentral"  value="#qgetMorphometricsData.midVentral#"  class="text-field">
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="cust-row mid-dorsal">
                                <div class="cust-fld"><label class="fl-lbl">Upper Right</label>
                                </div>
                                <div class="cust-inp">
                                    <input type="text" name="Ventralupperleft" value="#qgetMorphometricsData.Ventralupperleft#"class="text-field">
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="cust-row mid-dorsal">
                                <div class="cust-fld"><label class="fl-lbl">Lower Right</label>
                                </div>
                                <div class="cust-inp">
                                    <input type="text"name="Ventrallowerright" value="#qgetMorphometricsData.Ventrallowerright#"class="text-field">
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-3"></div>
                    </div>
                    </div>    
                    <cfif findNoCase("Read only ST", permissions) eq 0>
                        <!--- <div class="flex-center flex-row flex-wrap"> --->
                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12 mt-4 s-content two-btn two-btn-wrap">
                                <input type="submit" id="SaveAndNewMorphometrics" name="SaveAndNewMorphometrics" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                                <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)"> --->
                                <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('qgetMorphometricsData.ID') and qgetMorphometricsData.ID neq "")>
                                    <input type="submit" id="" name="deleteMorphometrics" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};" >
                                </cfif>
                                <cfif (permissions eq "full_access")>
                                    <input type="submit" id="deleteallMorphometricsRecord" name="deleteallMorphometricsRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records ?')){deleteit()}else{return false;};" >
                                </cfif>
                            </div>
                            <!--- <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4 s-content">
                                <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)">                        
                            </div> --->
                            <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4 s-content">
                                
                            </div>
                                
                            
                        <!--- </div> --->
                    </cfif> 
                    </div>    
            </div>   
            <!--- end for Morphometrics --->


            </div>
            
            </div>
                


                <!--- <cfif isDefined('CetaceanExamPage') or isDefined('form.LCEID')> --->
                                   

            </form>   
             
               <!--- <div class="row mt-4">
                <form id="myform" enctype="multipart/form-data" action="" method="post" >
                    <div class="col-lg-12 dis-flex just-center">
                        <div class="form-group select-width">
                            <cfif (permissions eq "full_access")>
                                <input type="file" name="sampleFile" required>
                            </cfif>
                        </div>
                        <div class="form-group select-width">
                            <cfif (permissions eq "full_access")>
                                <button type="submit" class="btn btn-success">Import</button>
                            </cfif>
                        </div>
                    </div>
                </form>
            </div> --->
             
        </div>
    <!--- </cfif>  --->
    <!--- for Ancillary --->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
        
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="pdfname"></h4>
                </div>
                <div class="modal-body">
                    <object data="mypdf.pdf" type="application/pdf" frameborder="0" width="100%" height="600px" style="padding: 20px;">
<!---                             <embed src="https://drive.google.com/file/d/1CRFdbp6uBDE-YKJFaqRm4uy9Z4wgMS7H/preview?usp=sharing" width="100%" height="600px"/>  --->
                    <embed id="emb" src="" width="1000" height="500" type="application/pdf" title="test.pdf">

                    </object>
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>  
    
    <!--- for Ancillary --->
        <div class="modal fade" id="myModalA" role="dialog">
            <div class="modal-dialog">
            
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="pdfname"></h4>
                    </div>
                    <div class="modal-body">
                        <embed id="emb" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModalAA" role="dialog">
            <div class="modal-dialog">
            
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="embAncillaryDiagnosticspdfname"></h4>
                    </div>
                    <div class="modal-body">
                        <embed id="embAncillaryDiagnostics" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
              <!--- for cetecean Exam--->
              <div class="modal fade" id="myModalExam" role="dialog">
                <div class="modal-dialog">
                
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" id="pdfExamName"></h4>
                        </div>
                        <div class="modal-body">
                            <embed id="embExamPDF" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                        </div>
                        <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
           <!--- end for cetecean Exam --->
           <!--- start for hiform --->
           <div class="modal fade" id="myHiFormModal" role="dialog">
            <div class="modal-dialog">
            
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="HIpdfname"></h4>
                    </div>
                    <div class="modal-body">
                        <embed id="embHIForm" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
           <!--- end for hiform --->
           <!--- start for Necropsy --->
           <div class="modal fade" id="myNecropsyModal" role="dialog">
            <div class="modal-dialog">
            
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="NecropsyPICname"></h4>
                    </div>
                    <div class="modal-body">
                        <embed id="embNecropsy" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
           <!--- end for Necropsy --->
    </cfoutput>

    <style>

        .toxic-field {
            border-bottom: 2px solid #bec3c6 !important;
            border-left: 0px !important;
            border-right: 0px !important;
            border-top: 0px !important;
        }

        .estimate-style {
            padding: 5px;
        }

        .form-wrapper.cetacean-exam-wrapper {
            margin-bottom: 30px;
        }
        .form-wrapper.cetacean-exam-wrapper .cetacean-exam-holder {
            display: flex;
        }
        .form-wrapper.cetacean-exam-wrapper .form-holder.blue-bg {
            height: 100%;
            margin: 0 !important;
        }
        .cetacean-exam-form .cetacean-exam-wrap.row {
            display: flex;
            flex-wrap: wrap;
        }
        .tab-section-list .nav.nav-tabs>li a {
            color: #fff;
            padding: 10px 20px;
        }
        .tab-section-list .nav.nav-tabs>li {
            background: #4472c4;
            border: 1px solid #30373e73;
            margin-right: 8px;
        }
        .tab-section-list .nav.nav-tabs>li.active:after{
            display: none;
        }
        .tab-section-list .nav.nav-tabs>li.active {
            background: #add8e6;
        }
        .tab-section-list .nav.nav-tabs>li.active a{
            color: #000;
            font-weight: 500;
        }
        .pip {
        display: inline-block;
        margin: 10px 10px 0 0;
        }
        .dis-flex.just-center {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px 0 0;
        }
        .remove {
        display: block;
        background: #444;
        border: 1px solid black;
        color: white;
        text-align: center;
        cursor: pointer;
        }
        .remove:hover {
        background: white;
        color: black;
        }
        input[type="file"] {
        display: block;
        }
        .imageThumb {
        max-height: 132px;
        border: 4px solid;
        cursor: pointer;
        }
        .pip {
        display: inline-block;
        margin: 10px 10px 0 0;
        }
        .remove {
        display: block;
        background: #444;
        border: 1px solid black;
        color: white;
        text-align: center;
        cursor: pointer;
        }
        .remove:hover {
        background: white;
        color: black;
        }
        .form-holder{
            background-color: #fff;
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #30373e73;
            box-shadow: 0px 0px 5px 5px #30373e1c;
        }
        .input-group {
            width: 100%;
        }
        .select2-container--default .select2-selection--single {
            border-radius: 0;
        }
        .flex-center{
            display: flex; 
            justify-content: space-between;
            align-items: center;
        }
        label {
            font-weight: 400;
            margin-bottom: 0;
            padding-right: 5px;
            min-width: fit-content;
        }
        .input{
            width: 100%;
        }
        .mb-1{
        margin-bottom: 10px;
        }
        .mb-2{
        margin-bottom: 20px;
        }
        .mb-3{
        margin-bottom: 30px;
        }
        .mb-5{
            margin-bottom: 50px;
        }
        .mt-1{
        margin-top: 10px;
        }
        .mt-2{
        margin-top: 20px;
        }
        .p-0{
            padding: 0;
        }
        .pl-0{
        padding-left: 0; 
        }
        .pr-0{
        padding-right: 0; 
        }
        .pb-2{
        padding-bottom: 15px !important; 
        }
        .p-rl-4{
            padding: 0 4px;
        }
        .m-rl-4{
            margin: 0 4px;
        }
        .m-0{
            margin: 0;
        }
        .blue-bg{
            background-color: #add8e6;
            padding-bottom: 70px;
        }
        .blue-bg-l{
            background-color: #add8e6;
            /* padding-bottom: 119px; */
        }
        .saperator{
            border-top: 1px solid #c1c1c1;
            margin: 20px 0 30px;
        }
        .physical-exam textarea{
            min-height: 120px;
            resize: none;
        }
        .locations-textarea{
            min-height: 120px;
            resize: none;
        }
        .results-textarea{
            min-height: 52px;
            resize: none;
        }
        .release-textarea{
            min-height: 197px;
            padding: 12px !important;
            font-style: italic;
            border: none;
            resize: none;
        }
        .justify-content-end{
            display: flex;
            justify-content: flex-end;
        }
        .full-width{
            width: 100%;
        }
        .blue-btn{
            background-color: #0b36b5;
            color: #FFF;
        }
        .blue-btn:hover{
            color: #FFF;
            
        }
        .btn-skyblue{
            background-color: #4472c4;
            color: #FFF;
        }
        .btn-skyblue:hover{
            color: #FFF;
        }
        .H_rate_time_error{
            font-style: oblique;
            color:red;
            margin-left: 60px;
        }
        .heart_rate_error{
            font-style: oblique;
            color:red;
        }
        .resp_rate_time_error{
            font-style: oblique;
            color:red;
            margin-left: 64px;
        }
        .resp_rate_error{
            font-style: oblique;
            color:red;
        }
        .D_volume_error{
            font-style: oblique;
            color:red;
            margin-left: 74px;
        }
        .D_dosage_error{
            font-style: oblique;
            color:red;
            margin-left: 48px;
        }
        .D_time_error{
            font-style: oblique;
            color:red;
            margin-left: 32px;
        }
        .D_method_error{
            font-style: oblique;
            color:red;
            margin-left: 91px;
        }
        .D_type_error{
            font-style: oblique;
            color:red;
            margin-left: 53px;
        }
        .B_type_error{
            font-style: oblique;
            color:red;
            margin-left: 72px;
        }
        .B_location_error{
            font-style: oblique;
            color:red;
            margin-left: 95px;
        }
        .B_size_error{
            font-style: oblique;
            color:red;
            margin-left: 68px;
        }
        .Lession_present_error{
            font-style: oblique;
            color:red;
        }
        .Lession_type_error{
            font-style: oblique;
            color:red;
        }
        .Lession_region_error{
            font-style: oblique;
            color:red;
        }
        .Lession_side_error{
            font-style: oblique;
            color:red;
        }
        .Lession_status_error{
            font-style: oblique;
            color:red;
        }
        .btn-pink{
            background-color: #be44c4;
            color: #FFF;
        }
        .btn-pink:hover{
            color: #FFF;
        }
        .btn-green{
            background-color: #70ad47;
            color: #FFF;
        }
        .btn-green:hover{
            color: #FFF;
        }
        .btn-orange{
            background-color: #ed7d31;
            color: #FFF;
        }
        .btn-orange:hover{
            color: #FFF;
        }
        .form-control{
            height: 30px;
            padding: 0px 12px;
            border-radius: 0;
        }
        .select2-container .select2-selection--single {
            height: 30px!important;
            padding: 0px 12px!important;
            display: flex !important;
            align-items: center;
        }
        .form-wrapper .input-style {
            border: 2px solid #bec3c6;
            color: #30373F;
            height: 30px;
            padding: 0px 12px;
        }
        .form-wrapper  .focus-visible {
            border-color: #8d9aa5;
            border-radius: 0;
        }
        .form-holder .input-style {
            border: 2px solid #bec3c6;
            background: #FFF;
            color: #30373F;
            height: 30px;
            padding: 0px 4px;
        }
        .form-holder .focus-visible {
            border-color: #8d9aa5 !important;
            border-radius: 0;
        }
        .weight-input{
            width: 43%;
        }
        .weight-input-two{
            width: 68%;
        }
        .time-icon {
            padding: 4px 10px;
            border-width: 0px;
            border: 2px solid #bec3c6;
        }
        .body-water .select2-container--default .select2-selection--multiple {
            background-color: #fff !important;
            border: 2px solid #bec3c6 !important;
            border-radius: 0 !important;
        }
        .body-water span{
            width: 100% !important;
        }
        .xl-width{
            width: 100%;
        }
        .rosturn-text{
            font-style: italic;
            padding-left: 6px;
        }
        .fishone-width{
            width: 59%;
        }
        .fishone-width{
            width: 59%;
        }
        .end-time{
            padding-right: 52px;
        }
        .start-time{
            padding-right: 63px;
        }
        .body-of-water{
            padding-right: 10px;
        }
        .veterinarian{
            padding-right: 9px;
        }
        .field-number{
            padding-right: 45px;
        }
        .lat-one{
            padding-right: 65px;
        }
        .lon-one{
            padding-right: 62px;
        }
        .code-padd{
            padding-right: 25px;
        }
        .btn {
            padding: 0 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 30px;
        }
        .date-padd{
            padding-right: 81px;
        }
        .taged-type{
            padding-right: 27px;
        }
        .last-lat{
            padding-right: 8px;
        }
        .rate-wrap .time-icon{
            position: relative;
            left: -32px;
            border: 2px solid #bec3c6;
        }
        .rate-wrap .input-group{
            max-width: 102px;
        }
        .rate-wrap .input-type-time{
            max-width: 102px;
        }
        .rate-wrap label{
            padding-right: 39px;
        }
        .resp-rate{
            padding-right: 8px;
        }
        .refil-padd{
            padding-left: 25px !important;
        }
        .fishone-labelone{
            padding-right: 20px;
        }
        .fishone-labeltwo{
            padding-right: 21px;
        }
        .fishone-labelthree{
            padding-right: 17px;
        }
        .fishone-labelfour{
            padding-right: 19px;
        }
        .drug-time .input-type-time {
            max-width: 102px;
        }
        .drug-time .input-group{
            max-width: 102px;
        }
        .drug-time .time-icon{
            position: relative;
            left: -34px;
            border: 2px solid #bec3c6;
        }
        .first-date input {
            width: 100%;
        }
        .first-date .time-icon {
            padding: 6px 10px;
            width: 36px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .first-date input[type="date"]::-webkit-calendar-picker-indicator {
            display: none;
            -webkit-appearance: none;
        }
        .fishtwo-labelone {
            padding-right: 22px;
        }
        .fishtwo-labeltwo {
            padding-right: 37px;
        }
        .fishtwo-labelthree {
            padding-right: 42px;
        }
        .fishtwo-labelfour {
            padding-right: 35px;
        }
        .fishtwo-labelfive {
            padding-right: 12.5px;
        }
        .fishtwo-labelsix {
            padding-right: 25px;
        }
        .weight-input-three {
            width: 64%;
        }
        .green-labels label {
            min-width: 20%;
            background: #3C454D;
            box-shadow: 0 1px #24292e;
            font-size: 12px;
            color: #3dde42;
            min-height: 34.56px;
            border-radius: 4px 0 0 4px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .green-labels .input select { 
            height: 35px;
        }
        .green-labels .input span{ 
            width: 100% !important;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice {
            margin-right: 25px;
            position: relative;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            position: absolute;
            right: -12px;
            width: 20px !important;
            height: 100% !important;
        }
        .select-width span{ 
            width: 100% !important;
        }
        .weight-input-four {
            width: 78.5%;
        }
        .history-label {
            padding-right: 19px;
        }
        .ageclass-label {
            padding-right: 33px;
        }
        .sex-label {
            padding-right: 76px;
        }
        .img-group img {
        width: 100%;
    }
    /* strat for necropsy */
    strong.strong-position {
    position: absolute;
    top: -30px;
    font-size: 16px;
}
    .choose-images .choose-images-detail {
        display: flex;
        width: 100%;
        padding: 20px 10px 0;
    }
    .choose-images .choose-images-detail .pip {
        width: 150px;
        margin-right: 15px;
    }
    .imageTh {
        height: 80px !important;
        width: 80px !important;
    }

    .rem {
        font-size: 8px !important;
        width: 80px !important;
    }

    .pipw {
        width: 17% !important;
    }


    .imgsw {
        width: 805px !important;
    }


    .rms {
        width: 150px;
    }

    .inps {
        display: flex !important;
        flex-direction: row;
        width: 82% !important;
    }

    .cst-rows {
        flex-direction: column;
    }

    .imag {
        object-fit: cover !important;
        height: 160px !important;
        width: 150px !important;
    }

    .cust-inpts {
        display: flex !important;
        width: 75% !important;
    }

    .btn-save {
        margin-top: 10px;
        /* margin-left: 500px !important; */
    }

    .btn-del {
        margin-top: 10px !important;
    }

    .sd-btns {
        width: 60%;
        float: right;
    }

    .select2.select2-container.select2-container--default {
        width: 100% !important;
    }

    .appnd {
        margin-left: 12px;
    }

    .input-label {
        padding: 5px;
        width: 54% !important;
        margin-right: 5px;
    }
    .dis-flex.just-center.choose-file-tabdesign {
        margin: 0;
    }
    .dis-flex.just-center.choose-file-tabdesign .form-group.select-width {
        margin: 0;
        width: 100%;
    }
    .dis-flex.just-center.choose-file-tabdesign .form-group.select-width input[type="file"] {
        width: 100%;
    }
    .dis-flex.just-center.choose-file-tabdesign .form-group.select-width .btn.btn-success {
        margin-left: 10px;
    }
    .dis-flex.just-center.choose-file-tabdesign .form-group.select-width:last-child {
        width: auto;
    }
    .file-tabdesign-row {
        max-width: 248px;
    }
    .two-btn.two-btn-wrap {
        display: flex;
        flex-wrap: wrap;
    }
    

    /*******Inner tab section******/
    .col-lg-6.sd-btns {
        display: flex;
    }
    .col-lg-6.sd-btns .btn {
        margin-right: 10px;
    }
    strong.strong-position {
    position: absolute;
    top: -30px;
    font-size: 16px;
}
    .choose-images .choose-images-detail {
        display: flex;
        width: 100%;
        padding: 20px 10px 0;
    }
    .choose-images .choose-images-detail .pip {
        width: 150px;
        margin-right: 15px;
    }
    .imageTh {
        height: 80px !important;
        width: 80px !important;
    }

    .rem {
        font-size: 8px !important;
        width: 80px !important;
    }

    .pipw {
        width: 17% !important;
    }


    .imgsw {
        width: 805px !important;
    }


    .rms {
        width: 150px;
    }

    .inps {
        display: flex !important;
        flex-direction: row;
        width: 82% !important;
    }

    .cst-rows {
        flex-direction: column;
    }

    .imag {
        object-fit: cover !important;
        height: 160px !important;
        width: 150px !important;
    }

    .cust-inpts {
        display: flex !important;
        width: 75% !important;
    }

    .btn-save {
        margin-top: 10px;
        /* margin-left: 500px !important; */
    }

    .btn-del {
        margin-top: 10px !important;
    }

    .sd-btns {
        width: 60%;
        float: right;
    }

    .select2.select2-container.select2-container--default {
        width: 100% !important;
    }

    .appnd {
        margin-left: 12px;
    }

    .input-label {
        padding: 5px;
        width: 54% !important;
        margin-right: 5px;
    }
    .cust-inpst {
        width: 78% !important;
    }
    .cust-inptsi {
        display: flex !important;
    }

    .cust-inptsii {
        width: 32% !important;
    }

    .imgexs {
        margin-left: 25px;
    }

    .remove {
    display: block;
    background: #444;
    border: 1px solid black;
    color: white;
    text-align: center;
    cursor: pointer;
    }
    .remove:hover {
    background: white;
    color: black;
    }
    .pt-30{
    padding-top: 30px;
    }
    .pt-20{
    padding-top: 20px;
    }
    .pt-15{
    padding-top: 15px;
    }
    .mt-100{
    margin-top: 100px;
    }
    .mt-20{
    margin-top: 20px;
    }
    .mt-15{
    margin-top: 15px;
    }
    .mt-10{
    margin-top: 10px;
    }
    .mt-0{
    margin: 0px;
    }
    .align-right{
        text-align: right;
    }
    .mrb-40 {
        margin-bottom: 40px;
    }
    div#newparasite .col-lg-12 {
        padding: 0 10px;
    }
    .top-sec {
        background-color: #add8e6;
        padding: 20px 15px;
    }
    .cust-row {
        display: flex;
    }
    .cust-fld {
        width: 35%;
        margin-top: auto;
        margin-bottom: auto;
    }
    .cust-inp {
        width: 65%;
    }
    .cust-row .fl-lbl {
        font-size: 16px;
    }
    .cust-inp select {
        width: 100%;
        display: block;
        padding: 6px;
        font-size: 15px;
        border: 1px solid;
    }
    .text-field {
        padding: 6px;
        width: 100%;
        border: 1px solid;
    }
    .cust-inp select option{
        font-size: 15px;
    }
    input.check-bxt-fld {
        width: 17px;
        height: 17px;
        border: 0;
        border-radius: 0;
    }
    label.check-cust-fld {
        margin: 0;
        font-size: 16px;
        position: relative;
        bottom: 2px;
    }
    .check-fld {
        width: 26%;
        margin-top: auto;
    }
    .cust-row .check-bx {
        width: 16%;
        margin-top: auto;
    }
    .cust-row .check-ipt {
        width: 42%;
    }
    .panel-rw .cust-fld {
        width: 14%;
        margin-right: 4px;
    }
    .fldarea .fl-lbl {
        display: block;
        font-size: 16px;
    }
    .fldarea #top-area {
        display: block;
        width: 100%;
        height: 170px;
        border: 1px solid;
    }
    .sec-two {
        padding: 20px 15px;
    }
    .btn-rw .cust-fld {
        margin-left: 25px;
        margin-bottom: auto;
    }
    .upld-btn {
        font-size: 15px;
        padding: 4px 12px;
        background: #17B6A4;
        border: 0;
        color: #fff;
    }
    .noOfAnimals-label {
    min-width: 120px;
    text-align: center;
}
    .linkhisto{
        background-color: #4472c4;
        color: white;
        padding: 14px 25px;
        font-size: 15px;
        font-style: normal;
        font-weight: 400;
        text-align: center;
        text-decoration: none;
        display: inline-block;
    }
    .linkhisto:hover, .linkhisto:active {
        background-color: #4472c4;
        color: white;
    }
    .linkcetacean{
        background-color: #4472c4;
        color: white;
        padding: 14px 25px;
        font-size: 15px;
        font-style: normal;
        font-weight: 400;
        text-align: center;
        text-decoration: none;
        display: inline-block;
    }
    .linkcetacean:hover, .linkcetacean:active {
        background-color: #4472c4;
        color: white;
    }
    .full-img-sec {
        padding: 20px 15px;
        background-color: #efefef;
        margin-bottom: 20px;
    }
    .img-group img {
        width: 100%;
    }
    .right-fld {
        width: 30%;
        margin-top: auto;
        margin-bottom: auto;
    }
    .right-inp {
        width: 40%;
        margin-right: 15px;
    }
    .cust-row.mid-dorsal .cust-fld {
        width: 45%;
    }
    .cust-row.mid-dorsal .cust-fld {
        width: 55%;
    }
    .sec-title h2 {
        font-size: 30px;
        color: #02254b;
        margin: 0;
    }
    .sec-title {
        position: relative;
    }
    .sec-title span {
        background: #02254b;
        display: block;
        width: 78%;
        height: 3px;
        position: absolute;
        top: 15px;
        right: 12px;
    }
    .examination-sec {
        padding: 20px;
    }
    .exam-rw .cust-fld {
        width: 21.5%;
    }
    .ingm-rw .cust-fld {
        width: 50%;
    }
    /* .cust-inp {
        width: 50%;
    } */
    .fl-lbl {
        font-size: 16px;
    }
    .mid-t h3 {
        font-size: 20px;
        color: #02254b;
        font-weight: 500;
    }
    .material{
        margin-top: 10px;
        margin-bottom:100px;
    }
    .parasitediv{
        margin-bottom:10px;
    }
    .chako{
        margin-bottom:10px;
    }
    .hrt-rw .cust-fld {
        width: 70%;
    }
    .hrt-rw .cust-inp {
        width: 30%;
    }
    .describe-rw .cust-fld {
        width: 20%;
    }
    .describe-rw .cust-inp {
        width: 80%;
    }
    #top-area {
        width: 100%;
        border: 1px solid;
    }
    .lnth-rw .cust-fld {
        width: 60%;
    }
    .lnth-rw .cust-inp {
        width: 40%;
    }
    .sys-op {
        width: 100%;
        display: block;
        padding: 6px;
        font-size: 15px;
    }
    .sys-colum p {
        font-size: 17px;
        font-weight: bold;
    }
    .systum-row,.sys-comment-row {
        display: flex;
    }
    .sys-colum {
        width: 8%;
        margin-right: 33px;
    }
    .sys-colum.clm-15 {
        width: 12%;
        margin: auto;
    }
    .sys-colum-left {
        width: 12%;
        margin-right: 60px;
        text-align: center;
        margin-top: auto;
        margin-bottom: auto;
    }
    .sys-colum-right {
        width: 69.5%;
    }
    .sys-colum.clm-15:last-child {
        margin: 0;
    }
    .sys-title {
        margin: 0;
        font-size: 19px;
        font-weight: bold;
    }
    .systum-sec {
        padding-bottom: 20px;
        border-bottom: 3px solid #b7b9ba;
        padding-top: 20px;
    }
    .btm-rw .cust-fld {
        width: 48%;
    }
    .btm-rw .cust-inp {
        width: 50%;
    }
    .material-rw .cust-fld {
        width: 70%;
    }
    .material-rw .cust-inp {
        width: 30%;
    }
    .btm-sec .sys-colum-right {
        width: 74.5%;
    }
    .add_new_btn_content {
        display: inline-block;
        width: 100%;
    }
    .add_new_btn_content .col-lg-12 {
        padding: 0;
    }
    .add_new_btn_content .cust-row.ingm-rw label.fl-lbl input:focus {
        outline: none;
    }
    .add_new_btn_content .cust-row.ingm-rw label.fl-lbl input {
        padding: 8px 0;
        background: transparent;
        border: none;
        border-bottom: 1px solid;
        width: 60%;
    }
    .add_new_btn_content .cust-row.ingm-rw label.fl-lbl input::placeholder {
        color: #3c454d;
    }
    div#newLymph .col-lg-12 {
        padding: 0 10px;
        margin-top: 10px;
    }
    .cst-rows #histoUpload {
        display: flex;
        flex-wrap: wrap;
        padding-top: 10px;
    }
    .btn-rw.startSpinner {
        padding-top: 20px;
    }
        /*******HIForm*******/
        .finding{
        width: 112px;
        border: 2px solid #bec3c6;
        background: #FFF;
        color: #30373F;
        height: 30px;
        padding: 0px 4px;
    }
        input[type="file"] {
        display: block;
        }
        .imageThumb {
        max-height: 132px;
        border: 4px solid;
        cursor: pointer;
        }
        .pip {
        display: inline-block;
        margin: 10px 10px 0 0;
        }
        .remove {
        display: block;
        background: #444;
        border: 1px solid black;
        color: white;
        text-align: center;
        cursor: pointer;
        }
        .remove:hover {
        background: white;
        color: black;
        }
        .form-holder{
            background-color: #fff;
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #30373e73;
            box-shadow: 0px 0px 5px 5px #30373e1c;
        }
        .input-group {
            width: 100%;
        }
        .select2-container--default .select2-selection--single {
            border-radius: 0;
        }
        .flex-center{
            display: flex; 
            justify-content: space-between;
            align-items: center;
        }
        label {
            font-weight: 400;
            margin-bottom: 0;
            padding-right: 5px;
            min-width: fit-content;
        }
        .input{
            width: 100%;
        }
        .mb-1{
        margin-bottom: 10px;
        }
        .mb-2{
        margin-bottom: 20px;
        }
        .mb-3{
        margin-bottom: 30px;
        }
        .mb-5{
            margin-bottom: 50px;
        }
        .mt-1{
        margin-top: 10px;
        }
        .mt-2{
        margin-top: 20px;
        }
        .p-0{
            padding: 0;
        }
        .pl-0{
        padding-left: 0; 
        }
        .pr-0{
        padding-right: 0; 
        }
        .pb-2{
        padding-bottom: 15px !important; 
        }
        .p-rl-4{
            padding: 0 4px;
        }
        .m-rl-4{
            margin: 0 4px;
        }
        .m-0{
            margin: 0;
        }
        .blue-bg{
            background-color: #add8e6;
            padding-bottom: 70px;
        }
        .blue-bg-l{
            background-color: #add8e6;
            /* padding-bottom: 119px; */
        }
        .saperator{
            border-top: 1px solid #c1c1c1;
            margin: 20px 0 30px;
        }
        .physical-exam textarea{
            min-height: 120px;
            resize: none;
        }
        .locations-textarea{
            min-height: 120px;
            resize: none;
        }
        .results-textarea{
            min-height: 52px;
            resize: none;
        }
        .release-textarea{
            min-height: 197px;
            padding: 12px !important;
            font-style: italic;
            border: none;
            resize: none;
        }
        .justify-content-end{
            display: flex;
            justify-content: flex-end;
        }
        .full-width{
            width: 100%;
        }
        .blue-btn{
            background-color: #0b36b5;
            color: #FFF;
        }
        .blue-btn:hover{
            color: #FFF;
            
        }
        .btn-skyblue{
            background-color: #4472c4;
            color: #FFF;
        }
        .btn-skyblue:hover{
            color: #FFF;
        }
        .btn-pink{
            background-color: #be44c4;
            color: #FFF;
        }
        .btn-pink:hover{
            color: #FFF;
        }
        .btn-green{
            background-color: #70ad47;
            color: #FFF;
        }
        .btn-green:hover{
            color: #FFF;
        }
        .btn-orange{
            background-color: #ed7d31;
            color: #FFF;
        }
        .btn-orange:hover{
            color: #FFF;
        }
        .form-control{
            height: 30px;
            padding: 0px 12px;
            border-radius: 0;
        }
        .select2-container .select2-selection--single {
            height: 30px!important;
            padding: 0px 12px!important;
            display: flex !important;
            align-items: center;
        }
        .form-wrapper .input-style {
            border: 2px solid #bec3c6;
            color: #30373F;
            height: 30px;
            padding: 0px 12px;
        }
        .form-wrapper  .focus-visible {
            border-color: #8d9aa5;
            border-radius: 0;
        }
        .form-holder .input-style {
            border: 2px solid #bec3c6;
            background: #FFF;
            color: #30373F;
            height: 30px;
            padding: 0px 4px;
        }
        .form-holder .focus-visible {
            border-color: #8d9aa5 !important;
            border-radius: 0;
        }
        .weight-input{
            width: 43%;
        }
        .weight-input-two{
            width: 68%;
        }
        .time-icon {
            padding: 4px 10px;
            border-width: 0px;
            border: 2px solid #bec3c6;
        }
        .body-water .select2-container--default .select2-selection--multiple {
            background-color: #fff !important;
            border: 2px solid #bec3c6 !important;
            border-radius: 0 !important;
        }
        .body-water span{
            width: 100% !important;
        }
        .xl-width{
            width: 100%;
        }
        .rosturn-text{
            font-style: italic;
            padding-left: 6px;
        }
        .fishone-width{
            width: 59%;
        }
        .fishone-width{
            width: 59%;
        }
        .end-time{
            padding-right: 52px;
        }
        .start-time{
            padding-right: 63px;
        }
        .body-of-water{
            padding-right: 10px;
        }
        .veterinarian{
            padding-right: 9px;
        }
        .field-number{
            padding-right: 45px;
        }
        .lat-one{
            padding-right: 65px;
        }
        .lon-one{
            padding-right: 62px;
        }
        .code-padd{
            padding-right: 25px;
        }
        .btn {
            padding: 0 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 30px;
        }
        .date-padd{
            padding-right: 81px;
        }
        .taged-type{
            padding-right: 27px;
        }
        .last-lat{
            padding-right: 8px;
        }
        .rate-wrap .time-icon{
            position: relative;
            left: -32px;
            border: 2px solid #bec3c6;
        }
        .rate-wrap .input-group{
            max-width: 102px;
        }
        .rate-wrap .input-type-time{
            max-width: 102px;
        }
        .rate-wrap label{
            padding-right: 39px;
        }
        .resp-rate{
            padding-right: 8px;
        }
        .refil-padd{
            padding-left: 25px !important;
        }
        .fishone-labelone{
            padding-right: 20px;
        }
        .fishone-labeltwo{
            padding-right: 21px;
        }
        .fishone-labelthree{
            padding-right: 17px;
        }
        .fishone-labelfour{
            padding-right: 19px;
        }
        .drug-time .input-type-time {
            max-width: 102px;
        }
        .drug-time .input-group{
            max-width: 102px;
        }
        .drug-time .time-icon{
            position: relative;
            left: -34px;
            border: 2px solid #bec3c6;
        }
        .first-date input {
            width: 100%;
        }
        .first-date .time-icon {
            padding: 6px 10px;
            width: 36px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .first-date input[type="date"]::-webkit-calendar-picker-indicator {
            display: none;
            -webkit-appearance: none;
        }
        .fishtwo-labelone {
            padding-right: 22px;
        }
        .fishtwo-labeltwo {
            padding-right: 37px;
        }
        .fishtwo-labelthree {
            padding-right: 42px;
        }
        .fishtwo-labelfour {
            padding-right: 35px;
        }
        .fishtwo-labelfive {
            padding-right: 12.5px;
        }
        .fishtwo-labelsix {
            padding-right: 25px;
        }
        .weight-input-three {
            width: 64%;
        }
        .green-labels label {
            min-width: 20%;
            background: #3C454D;
            box-shadow: 0 1px #24292e;
            font-size: 12px;
            color: #3dde42;
            min-height: 34.56px;
            border-radius: 4px 0 0 4px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .green-labels .input select { 
            height: 35px;
        }
        .green-labels .input span{ 
            width: 100% !important;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice {
            margin-right: 25px;
            position: relative;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            position: absolute;
            right: -12px;
            width: 20px !important;
            height: 100% !important;
        }
        .select-width span{ 
            width: 100% !important;
        }
        .weight-input-four {
            width: 78.5%;
        }
        .history-label {
            padding-right: 19px;
        }
        .ageclass-label {
            padding-right: 33px;
        }
        .TypeofHI-label {
            padding-right: 78px;
        }
        .sex-label {
            padding-right: 76px;
        }
        .Examtype-label {
            padding-right: 49px;
        }
        .LocationofHI-label {
            padding-right: 55px;
        }
        .GearDeposition-label {
            padding-right: 93px;
        }
    /********END******/
    /*********Blood Value**********/
    .blood-form-holder .blood-column .blood-from-froup .input-group.cust-blod input[type="text"] {
    margin-right: 10px;
}
html body .select2-container--default .select2-selection--single, 
html body input, html body select, html body textarea, html body .bloodValues-date-form.form-holder.blue-bg.pb-2 select, html body .bloodValues-date-form.form-holder.blue-bg.pb-2 input {
    border:1px solid #bec3c6 !important;
}
.blood-form-holder .blood-column .blood-from-froup .input-group.cust-blod span {
    width: 15%;
    text-align: left;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) select, 
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) input {
    width: 70%;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1) {
    width: 27.5%;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
    width: 24%;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 {
    width: 48.5%;
}
.form-holder.blood-form-holder.cust-v-sec {
    padding-right: 0;
}
html body .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 .date input {
    width: 100%;
}

.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) .form-group.blood-from-froup.cust-date-r {
    width: 70%;
}
.form-group.blood-from-froup.cust-v-row textarea, .form-group.blood-from-froup.cust-v-row select, .form-group.blood-from-froup.cust-v-row input {
    height: 34.5px;
    border-radius: 3px;
}
.d-flex, .form-group.blood-from-froup .input-group.cust-blod {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
}
input[type="file"] {
display: block;
}
.imageThumb {
max-height: 132px;
border: 4px solid;
cursor: pointer;
}
.pip {
display: inline-block;
margin: 10px 10px 0 0;
}
.remove {
display: block;
background: #444;
border: 1px solid black;
color: white;
text-align: center;
cursor: pointer;
}
.remove:hover {
background: white;
color: black;
}
.form-holder{
    background-color: #fff;
    margin-bottom: 20px;
    padding: 15px;
    border: 1px solid #d5d8da;
    box-shadow: 0px 0px 5px 5px #30373e1c;
}
.form-group.blood-from-froup.cust-v-row label, 
.input-group {
    width: 100%;
}
.form-group.blood-from-froup.cust-v-row label {
    padding-bottom: 5px;
}
.select2-container--default .select2-selection--single {
    border: 1px solid #add8e6 !important;
    height: 34.5px !important;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
}
html body .form-group.blood-from-froup.input-group.select-width .input input.form-control {
    height: 34.5px;
    background: #fff;
    opacity: 1;
    box-shadow: none;
    border-radius: 4px;
}
html body .bloodValues-date-form.form-holder.blue-bg.pb-2 select, html body .bloodValues-date-form.form-holder.blue-bg.pb-2 input {
    height: 34.5px;
    border-radius: 4px;
}
.flex-center{
    justify-content: space-between;
}
.select2-container--default .select2-search--inline .select2-search__field {
    border: none !important;
}
label {
    font-weight: 400;
    margin-bottom: 0;
    padding-right: 5px;
    min-width: fit-content;
}
.input{
    width: 100%;
}
.mb-1{
margin-bottom: 10px;
}
.mb-2{
margin-bottom: 20px;
}
.mb-3{
margin-bottom: 30px;
}
.mb-5{
    margin-bottom: 50px;
}
.mt-1{
margin-top: 10px;
}
.mt-2{
margin-top: 20px;
}
.p-0{
    padding: 0;
}
.pl-0{
padding-left: 0; 
}
.pr-0{
padding-right: 0; 
}
.pb-2{
padding-bottom: 15px ; 
}
.p-rl-4{
    padding: 0 4px;
}
.m-rl-4{
    margin: 0 4px;
}
.m-0{
    margin: 0;
}
.blue-bg{
    background-color: #add8e6;
    /*padding-bottom: 70px;*/
}
.blue-bg-l{
    background-color: #add8e6;
    padding-bottom: 119px;
}
.saperator{
    border-top: 1px solid #c1c1c1;
    margin: 20px 0 30px;
}
.physical-exam textarea{
    min-height: 120px;
    resize: none;
}
.locations-textarea{
    min-height: 120px;
    resize: none;
}
.results-textarea{
    min-height: 52px;
    resize: none;
}
.release-textarea{
    min-height: 197px;
    padding: 12px ;
    font-style: italic;
    border: none;
    resize: none;
}
.justify-content-end{
    display: flex;
    justify-content: flex-end;
}
.full-width{
    width: 100%;
}
.blue-btn{
    background-color: #0b36b5;
    color: #FFF;
}
.blue-btn:hover{
    color: #FFF;
    
}
.btn-skyblue{
    background-color: #4472c4;
    color: #FFF;
}
.btn-skyblue:hover{
    color: #FFF;
}
.btn-pink{
    background-color: #be44c4;
    color: #FFF;
}
.btn-pink:hover{
    color: #FFF;
}
.btn-green{
    background-color: #70ad47;
    color: #FFF;
}
.btn-green:hover{
    color: #FFF;
}
.btn-orange{
    background-color: #ed7d31;
    color: #FFF;
}
.btn-orange:hover{
    color: #FFF;
}
.form-control{
    height: 30px;
    padding: 0px 12px;
    border-radius: 0;
}
.form-wrapper .input-style {
    border: 2px solid #bec3c6;
    color: #30373F;
    height: 30px;
    padding: 0px 12px;
}
.form-wrapper  .focus-visible {
    border-color: #8d9aa5;
    border-radius: 0;
}
.form-holder .input-style {
    border: 2px solid #bec3c6;
    background: #FFF;
    color: #30373F;
    height: 30px;
    padding: 0px 4px;
}
.form-holder .focus-visible {
    border-color: #8d9aa5 ;
    border-radius: 0;
}
.weight-input{
    width: 43%;
}
.weight-input-two{
    width: 68%;
}
.time-icon {
    padding: 4px 10px;
    border-width: 0px;
    border: 2px solid #bec3c6;
}
.body-water .select2-container--default .select2-selection--multiple {
    background-color: #fff ;
    border: 2px solid #bec3c6 ;
    border-radius: 0 ;
}
.body-water span{
    width: 100% ;
}
.xl-width{
    width: 100%;
}
.rosturn-text{
    font-style: italic;
    padding-left: 6px;
}
.fishone-width{
    width: 59%;
}
.fishone-width{
    width: 59%;
}
.end-time{
    padding-right: 52px;
}
.start-time{
    padding-right: 63px;
}
.body-of-water{
    padding-right: 10px;
}
.veterinarian{
    padding-right: 9px;
}
.field-number{
    padding-right: 45px;
}
.lat-one{
    padding-right: 65px;
}
.lon-one{
    padding-right: 62px;
}
.code-padd{
    padding-right: 25px;
}
.bloodValues-date-form .form-group blood-from-froup label {
    padding-right: 5px;
    width: 55%;
    display: block;
}
.btn {
    padding: 0 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 30px;
}
.date-padd{
    padding-right: 81px;
}
.taged-type{
    padding-right: 27px;
}
.last-lat{
    padding-right: 8px;
}
.rate-wrap .time-icon{
    position: relative;
    left: -32px;
    border: 2px solid #bec3c6;
}
.rate-wrap .input-group{
    max-width: 102px;
}
.rate-wrap .input-type-time{
    max-width: 102px;
}
.rate-wrap label{
    padding-right: 39px;
}
.resp-rate{
    padding-right: 8px;
}
.refil-padd{
    padding-left: 25px ;
}
.fishone-labelone{
    padding-right: 20px;
}
.fishone-labeltwo{
    padding-right: 21px;
}
.fishone-labelthree{
    padding-right: 17px;
}
.fishone-labelfour{
    padding-right: 19px;
}
.drug-time .input-type-time {
    max-width: 102px;
}
.drug-time .input-group{
    max-width: 102px;
}
.drug-time .time-icon{
    position: relative;
    left: -34px;
    border: 2px solid #bec3c6;
}
.first-date input {
    width: 100%;
}
.first-date .time-icon {
    padding: 6px 10px;
    width: 36px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.first-date input[type="date"]::-webkit-calendar-picker-indicator {
    display: none;
    -webkit-appearance: none;
}
.fishtwo-labelone {
    padding-right: 22px;
}
.fishtwo-labeltwo {
    padding-right: 37px;
}
.fishtwo-labelthree {
    padding-right: 42px;
}
.fishtwo-labelfour {
    padding-right: 35px;
}
.fishtwo-labelfive {
    padding-right: 12.5px;
}
.fishtwo-labelsix {
    padding-right: 25px;
}
.weight-input-three {
    width: 64%;
}
.green-labels label {
    /*min-width: 20%;*/
    background: #3C454D;
    box-shadow: 0 1px #24292e;
    font-size: 12px;
    color: #3dde42;
    min-height: 34.56px;
    border-radius: 4px 0 0 4px;
    display: flex;
    justify-content: center;
    align-items: center;
}
html body .green-labels .input select:last-child, 
html body .green-labels .input select {
    height: 35px;
    background: #ebeced;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
}
.bloodValues-date-form.form-holder.blue-bg.pb-2 {
    min-height: 315px;
}
.green-labels .input span{ 
    width: 100% ;
}
.green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice {
    margin-right: 25px;
    position: relative;
}
.green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
    position: absolute;
    right: -12px;
    width: 20px ;
    height: 100% ;
}
.select-width span{ 
    width: 100% ;
}
.weight-input-four {
    width: 78.5%;
}
.history-label {
    padding-right: 19px;
}
.ageclass-label {
    padding-right: 33px;
}
.TypeofHI-label {
    padding-right: 78px;
}
.sex-label {
    padding-right: 76px;
}
.Examtype-label {
    padding-right: 49px;
}
.LocationofHI-label {
    padding-right: 55px;
}
.GearDeposition-label {
    padding-right: 93px;
}
.blood-form-holder .blood-from-froup .row {
    justify-content: flex-start;
    display: flex;
    flex-wrap: wrap;
    width: 100%;
}
html body .bloodValues-date-form.form-holder.blue-bg.pb-2 input:focus {
    outline: none;
}
.form-group.blood-from-froup .input-group {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
}
.form-group.blood-from-froup .input-group.date {
    display: table;
}
.flex-wrap-wrap {
    flex-wrap: wrap;
}
.form-group.blood-from-froup.blue-bg-l .input-group span,
.form-group.blood-from-froup .input-group span {
    white-space: nowrap;
}
.form-group.blood-from-froup .input-group.date span {
    white-space: inherit;
    border: 1px solid #bec3c6;
    border-left: none;
}
.form-group.blood-from-froup.blue-bg-l .form-group.blood-from-froup label,
.form-group.blood-from-froup .form-group.blood-from-froup label {
    padding-right: 5px;
}
.form-group.blood-from-froup {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
}
.form-group.blood-from-froup.input-group.select-width {
    display: table;
}
.form-group.blood-from-froup .green-labels .input-group{
    justify-content: space-between;
    align-items: center
}
.bloodValues-date-form .blue-bg-l {
    padding-bottom: 148px;
}
.col-lg-6.team-member-sec .form-holder.blue-bg.pb-2 .form-group.blood-from-froup.m-0 .input {
    width: 75%;
}
.col-lg-6.team-member-sec .form-holder.blue-bg.pb-2 .form-group.blood-from-froup.m-0 label {
    width: 25%;
}
.form-group.blood-from-froup.m-0 .row {
    width: 100%;
}
@media (max-width: 1399px){
    .form-group.blood-from-froup.input-group.select-width label{
        font-size: 11px;
    }
    .col-lg-6.team-member-sec .form-holder.blue-bg.pb-2 {
        padding-right: 0;
    }
}
@media (max-width: 1200px){
	.bloodValues-date-form.form-holder.blue-bg.pb-2 {
	    min-height: inherit;
	    padding-right: 0;
	}
}
@media (max-width: 1024px){
	.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
	    width: 33%;
	}
	.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1) {
	    width: 30%;
	}
    .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 {
        width: 37%;
    }
}
@media (max-width:991px){
    .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 {
        width: 100%;
    }
    .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1), .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
        width: 50%;
    }
    .flex-center.flex-row.flex-wrap.d-flex.bottons-wrap input {
        width: 47%;
        margin-bottom: 15px;
    }
}
@media (max-width:425px){
	.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1), .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
	    width: 100%;
	}
	.flex-center.flex-row.flex-wrap.d-flex.bottons-wrap input {
	    width: 100%;
	}
}
    /*********END*******/
    /*********Toxicology********/
    #Toxi {
    width: 100%;
}
/* .row.toxi-rw {
    padding: 0 10px;
    margin-bottom: 15px;
} */

.row.toxi-rw {
    padding: 0 0px;
    margin-bottom: 15px;
    margin-left: 0px;
}
.toxi-rw .col-lg-4 #toxi_label {
    width: 27%;
    margin-right: 5px;
}
.toxi-rw .col-lg-4 #toxi_type {
    width: 45%;
    margin-right: 4px;
}
.toxi-rw .col-lg-4 label {
    width: 28%;
}
#Toxi {
    width: 100%;
    padding: 0px 0 10px 0;
}
.toxi-rw .col-lg-4 input {
    width: 45%;
    margin-right: 4px;
    border: 0;
    border-bottom: 2px solid #bec3c6;
}
.toxi-rw span,.toxi-rw label{
    margin-top: auto;
}
.toxi-rw .col-lg-4 label.t-cust-l {
    padding-right: 55px;
    margin: auto;
}
.toxi-rw .col-lg-4 #toxi_report {
    height: 30px;
    padding: 0px 12px;
    border-radius: 0;
    width: 100%;
}
.toxi-rw .col-lg-4 {
    display: block;
}
.thre-rw .input-group {
    display: flex;
}
.blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 45%;
}
.thre-rw .input-group label {
    width: 28%;
    margin-top: auto;
    line-height: .7;
}
.thre-rw .input-group span {
    margin-top: auto;
    line-height: .7;
}
.input-group.c-b label {
    text-align: center;
    font-weight: bold;
    display: block;
}
.result-row {
    display: flex;
}
.blood-form-holder.Toxi-sec .blood-column .blood-from-froup .input-group input[type="text"] {
    width: 25%;
    /* height: 6px; */
    margin-right: 4px;
    margin-top: 0;
    margin-bottom: 0;
}
.cust-css .field-number {
    padding-right: 0;
}
.cust-css .form-group label.cust-l {
    width: 45%;
    margin: unset;
    float: left;
}
.cust-css .form-group .xl-width {
    width: 55%;
}
    .cust-css .form-group {
    display: flex;
}
.cust-css .form-group label {
    width: 80%;
    min-width: unset;
    margin: auto;
    max-width: initial;
    display: block;
}
.type .input-group {
    display: flex;
}
.blue-bg-l.pt-m {
    padding-bottom: 148px;
}
.cust-css .form-group select {
    width: 96%;
    padding: 0;
}
/* .field-size input, .cust-css .form-control {
    font-size: 11px;
    padding: 0 5px;
} */
   .field-size input,.cust-css .form-control {
    font-size: 11px;
    padding: 0 5px;
}
        input[type="file"] {
        display: block;
        }
        .imageThumb {
        max-height: 132px;
        border: 4px solid;
        cursor: pointer;
        }
        .pip {
        display: inline-block;
        margin: 10px 10px 0 0;
        }
        .remove {
        display: block;
        background: #444;
        border: 1px solid black;
        color: white;
        text-align: center;
        cursor: pointer;
        }
        .remove:hover {
        background: white;
        color: black;
        }
        .form-holder{
            background-color: #fff;
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #30373e73;
            box-shadow: 0px 0px 5px 5px #30373e1c;
        }
        .input-group {
            width: 100%;
        }
        .wbc_count{
            width: 100%;
            margin: 8px 0;
            box-sizing: border-box;
            border: none;
            border-bottom: 1px solid black;

        }
        .select2-container--default .select2-selection--single {
            border-radius: 0;
        }
        .flex-center{
            display: flex; 
            justify-content: space-between;
            align-items: center;
        }
        label {
            font-weight: 400;
            margin-bottom: 0;
            padding-right: 5px;
            min-width: fit-content;
        }
        .input{
            width: 100%;
        }
        .mb-1{
        margin-bottom: 10px;
        }
        .mb-2{
        margin-bottom: 20px;
        }
        .mb-3{
        margin-bottom: 30px;
        }
        .mb-5{
            margin-bottom: 50px;
        }
        .mt-1{
        margin-top: 10px;
        }
        .mt-2{
        margin-top: 20px;
        }
        .p-0{
            padding: 0;
        }
        .pl-0{
        padding-left: 0; 
        }
        .pr-0{
        padding-right: 0; 
        }
        .pb-2{
        padding-bottom: 15px !important; 
        }
        .p-rl-4{
            padding: 0 4px;
        }
        .m-rl-4{
            margin: 0 4px;
        }
        .m-0{
            margin: 0;
        }
        .blue-bg{
            background-color: #add8e6;
            padding-bottom: 70px;
        }
        .blue-bg-l{
            background-color: #add8e6;
            padding-bottom: 119px;
        }
        .saperator{
            border-top: 1px solid #c1c1c1;
            margin: 20px 0 30px;
        }
        .physical-exam textarea{
            min-height: 120px;
            resize: none;
        }
        .locations-textarea{
            min-height: 120px;
            resize: none;
        }
        .results-textarea{
            min-height: 52px;
            resize: none;
        }
        .release-textarea{
            min-height: 197px;
            padding: 12px !important;
            font-style: italic;
            border: none;
            resize: none;
        }
        .justify-content-end{
            display: flex;
            justify-content: flex-end;
        }
        .full-width{
            width: 100%;
        }
        .blue-btn{
            background-color: #0b36b5;
            color: #FFF;
        }
        .blue-btn:hover{
            color: #FFF;
            
        }
        .btn-skyblue{
            background-color: #4472c4;
            color: #FFF;
        }
        .btn-skyblue:hover{
            color: #FFF;
        }
        .btn-pink{
            background-color: #be44c4;
            color: #FFF;
        }
        .btn-pink:hover{
            color: #FFF;
        }
        .btn-green{
            background-color: #70ad47;
            color: #FFF;
        }
        .btn-green:hover{
            color: #FFF;
        }
        .btn-orange{
            background-color: #ed7d31;
            color: #FFF;
        }
        .btn-orange:hover{
            color: #FFF;
        }
        .form-control{
            height: 30px;
            padding: 0px 12px;
            border-radius: 0;
        }
        .select2-container .select2-selection--single {
            height: 30px!important;
            padding: 0px 12px!important;
            display: flex !important;
            align-items: center;
        }
        .form-wrapper .input-style {
            border: 2px solid #bec3c6;
            color: #30373F;
            height: 30px;
            padding: 0px 12px;
        }
        .form-wrapper  .focus-visible {
            border-color: #8d9aa5;
            border-radius: 0;
        }
        .form-holder .input-style {
            border: 2px solid #bec3c6;
            background: #FFF;
            color: #30373F;
            height: 30px;
            padding: 0px 4px;
        }
        .form-holder .focus-visible {
            border-color: #8d9aa5 !important;
            border-radius: 0;
        }
        .weight-input{
            width: 43%;
        }
        .weight-input-two{
            width: 68%;
        }
        .time-icon {
            padding: 4px 10px;
            border-width: 0px;
            border: 2px solid #bec3c6;
        }
        .body-water .select2-container--default .select2-selection--multiple {
            background-color: #fff !important;
            border: 2px solid #bec3c6 !important;
            border-radius: 0 !important;
        }
        .body-water span{
            width: 100% !important;
        }
        .xl-width{
            width: 100%;
        }
        .rosturn-text{
            font-style: italic;
            padding-left: 6px;
        }
        .fishone-width{
            width: 59%;
        }
        .fishone-width{
            width: 59%;
        }
        .end-time{
            padding-right: 52px;
        }
        .start-time{
            padding-right: 63px;
        }
        .body-of-water{
            padding-right: 10px;
        }
        .veterinarian{
            padding-right: 9px;
        }
        .field-number{
            padding-right: 45px;
        }
        .lat-one{
            padding-right: 65px;
        }
        .lon-one{
            padding-right: 62px;
        }
        .code-padd{
            padding-right: 25px;
        }
        .bloodValues-date-form .form-group blood-from-froup label {
            padding-right: 5px;
            width: 55%;
            display: block;
        }
        .btn {
            padding: 0 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 30px;
        }
        /* .date-padd{
            padding-right: 81px;
        } */
        .taged-type{
            padding-right: 27px;
        }
        .last-lat{
            padding-right: 8px;
        }
        .rate-wrap .time-icon{
            position: relative;
            left: -32px;
            border: 2px solid #bec3c6;
        }
        .rate-wrap .input-group{
            max-width: 102px;
        }
        .rate-wrap .input-type-time{
            max-width: 102px;
        }
        .rate-wrap label{
            padding-right: 39px;
        }
        .resp-rate{
            padding-right: 8px;
        }
        .refil-padd{
            padding-left: 25px !important;
        }
        .fishone-labelone{
            padding-right: 20px;
        }
        .fishone-labeltwo{
            padding-right: 21px;
        }
        .fishone-labelthree{
            padding-right: 17px;
        }
        .fishone-labelfour{
            padding-right: 19px;
        }
        .drug-time .input-type-time {
            max-width: 102px;
        }
        .drug-time .input-group{
            max-width: 102px;
        }
        .drug-time .time-icon{
            position: relative;
            left: -34px;
            border: 2px solid #bec3c6;
        }
        .first-date input {
            width: 100%;
        }
        .first-date .time-icon {
            padding: 6px 10px;
            width: 36px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .first-date input[type="date"]::-webkit-calendar-picker-indicator {
            display: none;
            -webkit-appearance: none;
        }
        .fishtwo-labelone {
            padding-right: 22px;
        }
        .fishtwo-labeltwo {
            padding-right: 37px;
        }
        .fishtwo-labelthree {
            padding-right: 42px;
        }
        .fishtwo-labelfour {
            padding-right: 35px;
        }
        .fishtwo-labelfive {
            padding-right: 12.5px;
        }
        .fishtwo-labelsix {
            padding-right: 25px;
        }
        .weight-input-three {
            width: 64%;
        }
        .green-labels label {
            min-width: 20%;
            background: #3C454D;
            box-shadow: 0 1px #24292e;
            font-size: 12px;
            color: #3dde42;
            min-height: 34.56px;
            border-radius: 4px 0 0 4px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .green-labels .input select { 
            height: 35px;
        }
        .green-labels .input span{ 
            width: 100% !important;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice {
            margin-right: 25px;
            position: relative;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            position: absolute;
            right: -12px;
            width: 20px !important;
            height: 100% !important;
        }
        .select-width span{ 
            width: 100% !important;
        }
        .weight-input-four {
            width: 78.5%;
        }
        .history-label {
            padding-right: 19px;
        }
        .ageclass-label {
            padding-right: 33px;
        }
        .TypeofHI-label {
            padding-right: 78px;
        }
        .sex-label {
            padding-right: 76px;
        }
        .Examtype-label {
            padding-right: 49px;
        }
        .LocationofHI-label {
            padding-right: 55px;
        }
        .GearDeposition-label {
            padding-right: 93px;
        }
        .Toxi-sec.blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
            width: 60%;
            margin: 8px 0;
            box-sizing: border-box;
            border: none !important;
            border-bottom: 2px solid #bec3c6 !important;
            outline: none;
            margin-right: 4px;
            margin-top: 0;
            margin-bottom: 0;
        }
        .blood-form-holder .blood-column .blood-from-froup .input-group.date input {
            width: 100%;
            margin: 0;
            border: 2px solid #bec3c6;
        }
        .blood-form-holder .blood-from-froup .row {
            justify-content: flex-start;
            display: flex;
            flex-wrap: wrap;
        }
        .blood-form-holder .blood-from-froup .blood-from-froup textarea {
            height: 44px !important;
            width: 100% !important;
            padding: 4px 10px;
        }
        @media (max-width: 1799px){
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 45%;
            }
        }
        @media (max-width: 1599px){
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 40%;
            }
        }
        @media (max-width: 1399px){
            .bloodValues-date-form .form-group blood-from-froup.flex-center {
            flex-wrap: wrap;
            }
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 25%;
            }
            .bloodValues-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
        }
        @media (max-width: 1199px){
            .bloodValues-date-form .form-group blood-from-froup.flex-center {
            flex-wrap: nowrap;
            }
            .bloodValues-date-form .input-group.flex-center {
            flex-wrap: nowrap;
            }
        }
        @media (max-width:1510px){
            .rosturn-text {
                display: block;
            }
            .weight-input {
                max-width: 52px;
            }
            .heartrate-two{
                padding-left: 20px !important;
            }
        }
        @media (max-width:1439px){
            .flex-wrap{
                flex-wrap: wrap;
                justify-content: center;
                margin-bottom: 15px;
            }
            .sample-one{
                width: 75%;
            }
            .sample-two{
                width: 25%;
            }
            .heartrate-one{
                width: 35%;
            }
            .heartrate-two{
                width: 35%;
                padding-left: 10px !important;
            }
            .heartrate-full{
                width: 100%;
            }
            .drug-width{
                width: 25%;
            }
            .rate-wrap label{
                padding-right: 30px;
            }
            .refil-padd{
                padding-left: 10px !important;
            }
        }
        @media (max-width:1350px){
            .field-size input, .cust-css .form-control {
    font-size: 8px;
}
        }
        @media (max-width:1325px){
   
            .green-labels label {
                min-width: 30%;
            }
            .cust-css .form-group label {
               font-size: 11px;
        }
        }
        @media (max-width:1281px){
            .weight-input {
                max-width: 20px;
            }
        }
        @media (max-width:1254px){
            .weight-input-two {
                max-width: 38px;
            }
        }
        @media (max-width:1218px){
            .blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 27%;
}
.thre-rw .input-group label {
    font-size: 12px;
}
.county-label {
    padding-right: 15px;
}
.input-group .form-control {
    font-size: 12px;
}
        }       
         @media (max-width:1199px){
            .m-rl-4 {
                margin: 4px;
            }
            input{
                width: 100%;
            }
            .btn{
                max-width: fit-content;
            }
            .bottons-wrap  .btn{
                max-width: 100%;
            }
            .radio-btn input{
                width: auto;
            }
            .bottons-wrap{
                width: 40%
            }
            .locations-textarea {
                min-height: 80px;
            }
            .physical-exam textarea {
                min-height: 80px;
            }
            .sample-one{
                width: 100%;
            }
            .sample-two{
                width: 100%;
            }
            .heartrate-one{
                width: 50%;
            }
            .heartrate-two{
                width: 50%;
            }
            .heartrate-one .btn.btn-success{
            margin-left: auto;
            }
            .heartrate-two .btn.btn-success{
            margin-left: auto;
            }
            .blue-bg {
                padding-bottom: 20px;
            }
            .blue-bg-l {
                padding-bottom: 20px;
            }
            .weight-input-two {
                max-width: 52px;
            }
            .drug-width {
                width: 33.33%;
            }
            .mb-5 {
                margin-bottom: 20px;
            }
            .body-of-water{
                padding-right: 5px;
            }
            .veterinarian{
                padding-right: 5px;
            }
            .lat-one{
                padding-right: 5px;
            }
            .code-padd{
                padding-right: 5px;
            }
            .rate-wrap label{
                padding-right: 39px;
            }
            .ml-auto{
                margin-left: auto;
            }
            .weight-input-three {
                width: 64%;
            }
            .rate-wrap .input-type-time {
                min-width: 102px;
            }
            .drug-time .input-type-time {
                min-width: 102px;
            }
            .weight-input-four {
                width: 65%;
            }
            .weight-input {
                max-width: 71px;
            }
        }
        @media (max-width:1218px){
            .toxi-rw .col-lg-4 label {
    min-width: fit-content;
}
.toxi-rw .col-lg-4 span {
    min-width: fit-content;
}
.toxi-rw .col-lg-4 input {
    width: 25%;
}
.toxi-rw .col-lg-4 #toxi_type {
    width: 27%;
}
        }
        @media (max-width:1200px){
            .toxi-rw .col-lg-4 #toxi_label {
    width: 40%;
}
.toxi-rw .col-lg-4 #toxi_type {
    width: 45%;
}
.toxi-rw .col-lg-4 label {
    min-width: fit-content;
    font-size: 12px;
    width: 40%;
}
.toxi-rw .col-lg-4 input {
    width: 45%;
}
.toxi-rw .col-lg-4 label.t-cust-l {
    padding-right: 22px;
}
            .Toxi-sec {
    overflow-x: auto;
}
.Toxi-sec .scrol {
    width: 900px;
}
            .county-label {
    min-width: fit-content;
}
            .thre-rw .input-group label {
    width: 40%;
}
.thre-rw .input-group label {
    font-size: 12px;
    min-width: fit-content;
}
.thre-rw .input-group span {
    min-width: fit-content;
}
.blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 43%;
}
            .bottons-wrap{
                width: 48%
            }
            .weight-input {
                width: 44%;
            }
            .mb-5{
                margin-bottom: 0;
            }
            .fishone-width{
                width: 100%;
            }
            .drug-width {
                width: 50%;
            }
            .date-padd{
                padding-right: 5px;
            }
            .taged-type{
                padding-right: 5px;
            }
            .last-lon{
                padding-right: 5px;
            }
            .heartrate-one{
                width: 50%;
            }
            .heartrate-two{
                width: 50%;
            }
            label{
                min-width: auto;
            }
            .flex-center {
                flex-direction: column;
                align-items: flex-start;
            }
            .flex-row {
                    flex-direction: row;
            }
            .rate-wrap{
                    flex-wrap: wrap;
                    align-items: center;
                    justify-content: flex-start;
            }
            .drug-width .btn.btn-success {
                margin-top: 15px;
            }
            .first-date .time-icon {
                position: absolute;
                top: 18.5px;
                right: 9px;
            }
            .green-labels .flex-center {
                flex-direction: row;
            }
            
        }
        @media (max-width: 917.9px){
            .heartrate-one .btn.btn-success{
            margin-top: 10px;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 10px;
            }
        }
        @media (max-width: 849px){
            .heartrate-three{
                width: 100%;
                padding: 0;
            }
            .heartrate-four{
                width: 100%;
            }
        }
        @media (max-width: 767px){
            .bottons-wrap{
                width: 60%
            }
            .heartrate-one{
                width: 100%;
            }
            .heartrate-two{
                width: 100%;
            }
            .heartrate-one .btn.btn-success{
            margin-top: 0;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 0;
            }
            .drug-width .btn.btn-success {
                margin-top: 20px;
            }
            .content {
                padding: 25px 15px;
            }
            
        }
        @media (max-width:574px){
                        /* .input-group .form-control {
    width: 35%;
} */
.form-group.blood-from-froup.scrol .col-xs-4 {
    width: 33.33333333%;
}
            .blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 52%;
}
            .thre-rw .input-group label {
    width: 37%;
}
            .col-xs-3 {
                width: 100%;
            }
            .col-xs-4 {
                width: 100%;
            }
            .col-xs-6 {
                width: 100%;
            }
            .col-xs-8 {
                width: 100%;
            }
            .bottons-wrap{
                width: 100%;
            }
            .drug-width {
                width: 100%;
            }
            .mucus-padd{
                padding: 0;
            }
            .refil-padd{
                padding: 0 !important;
            }
            .drug-width .btn.btn-success {
                margin-top: 0;
            }
            .green-labels label {
                min-width: 40%;
            }
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 80%;
            }
        }
        @media (max-width: 354.9px){
            .heartrate-one .btn.btn-success{
            margin-top: 10px;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 10px;
            }
        }
    /*******END******/
    /*******SampleArchive*******/
    .date-padd{
            padding-right: 81px;
        }
        .taged-type{
            padding-right: 27px;
        }
        .last-lat{
            padding-right: 8px;
        }
        .rate-wrap .time-icon{
            position: relative;
            left: -32px;
            border: 2px solid #bec3c6;
        }
        .rate-wrap .input-group{
            max-width: 102px;
        }
        .rate-wrap .input-type-time{
            max-width: 102px;
        }
        .rate-wrap label{
            padding-right: 39px;
        }
        .resp-rate{
            padding-right: 8px;
        }
        .refil-padd{
            padding-left: 25px !important;
        }
        .fishone-labelone{
            padding-right: 20px;
        }
        .fishone-labeltwo{
            padding-right: 21px;
        }
        .fishone-labelthree{
            padding-right: 17px;
        }
        .fishone-labelfour{
            padding-right: 19px;
        }
        .drug-time .input-type-time {
            max-width: 102px;
        }
        .drug-time .input-group{
            max-width: 102px;
        }
        .drug-time .time-icon{
            position: relative;
            left: -34px;
            border: 2px solid #bec3c6;
        }
        .first-date input {
            width: 100%;
        }
        .first-date .time-icon {
            padding: 6px 10px;
            width: 36px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .first-date input[type="date"]::-webkit-calendar-picker-indicator {
            display: none;
            -webkit-appearance: none;
        }
        .fishtwo-labelone {
            padding-right: 22px;
        }
        .fishtwo-labeltwo {
            padding-right: 37px;
        }
        .fishtwo-labelthree {
            padding-right: 42px;
        }
        .fishtwo-labelfour {
            padding-right: 35px;
        }
        .fishtwo-labelfive {
            padding-right: 12.5px;
        }
        .fishtwo-labelsix {
            padding-right: 25px;
        }
        .weight-input-three {
            width: 64%;
        }
        .green-labels label {
            min-width: 20%;
            background: #3C454D;
            box-shadow: 0 1px #24292e;
            font-size: 12px;
            color: #3dde42;
            min-height: 34.56px;
            border-radius: 4px 0 0 4px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .green-labels .input select { 
            height: 35px;
        }
        .green-labels .input span{ 
            width: 100% !important;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice {
            margin-right: 25px;
            position: relative;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            position: absolute;
            right: -12px;
            width: 20px !important;
            height: 100% !important;
        }
        .select-width span{ 
            width: 100% !important;
        }
        .weight-input-four {
            width: 78.5%;
        }
        .history-label {
            padding-right: 19px;
        }
        .ageclass-label {
            padding-right: 33px;
        }
        .am-l{
            width: 70%;
        }
        .county-label {
            /* padding-right: 10px; */
            width: 69%;
        }
        .sample-label {
            /* padding-right: 54px; */
            width: 70%;
        }
        .bin-label {
            /* padding-right: 26px; */
            width: 69%;
        }
        label.scomment-label {
    width: 25%;
}
        .samples-label {
            /* padding-right: 64px; */
            width: 44%;
        }
        /* .scomment-label {
            padding-right: 19px;
        } */
        .lab-label {
            padding-right: 20px;
        }
        /* .snotes-label {
            padding-right: 26px;
        } */
        .sex-label {
            padding-right: 76px;
        }
        .sample-accession-form .row{
           display: flex;
            flex-wrap: wrap;
            align-items: center; 
        }
        .form-holder.blue-bg.sample-accession-form .row {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
        }
        .sample-accession-form .col-lg-12 {
            width: 100%;
        }
        .simple-accession-table .responsive-tale table td{
            word-break: break-all;
        }
        .simple-t-sec .dataTables_scrollHeadInner table.table.table-bordered.table-hover.dataTable,
        .simple-t-sec .dataTables_scrollHeadInner, 
        .dataTables_scrollBody table.table.table-bordered.table-hover.dataTable  {
            min-width: 100%;
        }
        .form-input-holder label {
            width: 69%;
        }
    /*******END******/

        @media (max-width: 1200px) {
        .nflex {
            display: flex;
            flex-wrap: wrap;
        }

        .input-label {
            margin-right: 1px !important;
            width: 75% !important;
            margin-left: auto;
            margin-bottom: 15px;
        }
    }

    @media (max-width: 850px) {
        .input-label {
            width: 70% !important;
        }
    }

    @media (max-width: 600px) {
        .input-label {
            width: 100% !important;
        }
    }

    @media (max-width : 1200px) {
        .appnd {
            margin-left: 0px;
        }
    }

    @media (max-width: 575px) {
        .sd-btns {
            width: 68% !important;
        }
    }

    @media (max-width: 1500px) {
        .inps {
            width: 85% !important;
        }
    }

    @media (max-width: 1463px) {
        .inps {
            width: 90% !important;
        }
    }

    @media (max-width: 1439px) {
        .cust-inpts {
            width: 100% !important;
        }

        .inps {
            width: 115% !important;
        }
    }

    

    @media (max-width: 767px) {
        .cust-inpts {
            width: 90% !important;
        }

        .cust-inpst {
            width: 93% !important;
        }
    }

    @media (max-width: 575px) {
        .upld-btns {
            font-size: 7px !important; 
        }

        .text-fields {
            font-size: 6px !important;
            padding: 2px !important;
        }
    }

    
    @media (max-width: 1800px){
        .cust-row .fl-lbl,.fl-lbl {
        font-size: 15px;
        }
        label.check-cust-fld {
            font-size: 15px;
        }
        .mid-t h3 {
            font-size: 17px;
        }
        .sec-title span {
            width: 72%;
        }
        .sec-title h2 {
            font-size: 27px;
        }

    }
    @media (max-width: 1600px){
        .cust-row .fl-lbl,.fl-lbl {
        font-size: 13px;
        }
        label.check-cust-fld {
            font-size: 13px;
        }
        .mid-t h3 {
            font-size: 15px;
        }
        .cust-row .check-bx {
            width: 19%;
            margin-top: auto;
        }
        .cust-row .check-ipt {
            width: 37%;
        }
        .sys-title {
            font-size: 13px;
        }
        .sys-colum p {
            font-size: 13px;
        }
    }
    @media (max-width: 1400px){
        .cust-fld {
        width: 50%;
        margin-top: auto;
        }
    }
    @media (max-width: 1300px){
        .main-new-page-content{
            width: 1155px;
            overflow: scroll;
        }
    }
    @media (max-width: 1200px){
        .cust-fld {
        width: 25%;
        margin-top: auto;
        }
        strong.strong-position {
        position: static;
        }
        .main-new-page-content {
            width: auto;
            overflow: initial;
        }
        .cust-inp {
            width: 75%;
        }
        .row .col-lg-2,.row .col-lg-3,.row .col-lg-4,.row .col-lg-5,.row .col-lg-6,.row .col-lg-7,.row .col-lg-8,.row .col-lg-9,.row .col-lg-10,.row .col-lg-11,.row .col-lg-12 {
            padding: 0;
        }
        .cust-row {
            margin-bottom: 15px;
        }
        .panel-rw .cust-fld {
            width: 25%;
            margin-right: 0;
        }
        .right-fld {
            width: 25%;
        }
        .right-inp {
            width: 50%;
            margin-right: 15px;
        }
        .cust-row.mid-dorsal .cust-fld {
            width: 25%;
        }
        .sec-title span {
            width: 58%;
        }
        .sec-title h2 {
            font-size: 20px;
        }
        .exam-rw .cust-fld {
            width: 25%;
        }
        .ingm-rw .cust-fld {
            width: 25%;
        }
        .hrt-rw .cust-fld {
            width: 25%;
        }
        .hrt-rw .cust-inp,.hrt-rw .cust-inp {
            width: 75%;
        }
        .describe-rw .cust-fld {
            width: 25%;
        }
        .describe-rw .cust-inp {
            width: 75%;
        }
        .systum-row{
            display: block;
        }
        .sys-colum {
            width: 100%;
            margin-right: 0;
            margin-bottom: 10px;
        }
        .sys-colum.clm-15{
            width: 100%;
        }
        .sys-title {
            font-size: 20px;
            margin-bottom: 20px;
        }
        .sys-colum-left {
            width: 12%;
            margin-right: 1%;
        }
        .sys-colum-right {
            width: 100%;
        }
        .material-rw .cust-fld {
            width: 25%;
        }
        .material-rw .cust-inp {
            width: 75%;
        }
        .systum-row, .sys-comment-row {
            display: block;
        }
        .btm-sec .sys-colum-left {
            width: 100%;
        }
        .btm-sec .sys-colum-right {
            width: 100%;
        }
        .examination-sec {
            padding: 20px 10px;
        }
        .img-group img {
            width: 100%;
            margin-bottom: 20px;
        }
        .fldarea {
            margin-bottom: 15px;
        }
        .lnth-rw .cust-fld,.btm-rw .cust-fld {
            width: 25%;
        }
        .lnth-rw .cust-inp,.btm-rw .cust-inp {
            width: 75%;
        }

    }
    @media (max-width: 1199px){
        .rms {
            width: 120px;
        }
        .imag {
            height: 130px !important;
            width: 120px !important;
        }
        .choose-images .choose-images-detail .pip {
            width: 120px;
            margin-right: 10px;
        }
    }
    @media (max-width: 991px){
        .choose-images .choose-images-detail {
            padding: 0;
            flex-wrap: wrap;
        }
        .choose-images .choose-images-detail .pip {
            margin-bottom: 6px;
            margin-right: 6px;
        }
    }
    @media (max-width: 850px){
        .cust-fld {
        width: 30%;
        margin-top: auto;
        }
        .main-new-page-content {
            width: auto;
            overflow: initial;
        }
        .cust-inp {
            width: 70%;
        }
        .panel-rw .cust-fld {
            width: 30%;
            margin-right: 0;
        }
        .right-fld {
            width: 30%;
        }
        .right-inp {
            width: 50%;
            margin-right: 15px;
        }
        .cust-row.mid-dorsal .cust-fld {
            width: 30%;
        }
        .sec-title span {
            width: 58%;
        }
        .exam-rw .cust-fld,.ingm-rw .cust-fld,.hrt-rw .cust-fld,.describe-rw .cust-fld,.material-rw .cust-fld {
            width: 30%;
        }
        .hrt-rw .cust-inp,.hrt-rw .cust-inp,.describe-rw .cust-inp,.material-rw .cust-inp  {
            width: 70%;
        }
        .cust-row.describe-rw.other .cust-inp {
            width: 100%;
        }
        .top-sec,.full-img-sec,.examination-sec {
            padding: 20px;
        }
        .sec-title span {
            display: none;
        }
        #top-area,.fldarea #top-area {
            height: 100px;
        }
        .lnth-rw .cust-fld, .btm-rw .cust-fld {
            width: 30%;
        }
        .lnth-rw .cust-inp, .btm-rw .cust-inp {
            width: 70%;
        }
        .sys-colum-left {
            text-align: left;
        }
        .cust-inp select,.sys-op {
            padding: 5px;
            font-size: 13px;
        }
        .text-field {
            padding: 5px;
        }
    }
    @media (max-width: 767px){
        .btn-rw.startSpinner .cust-inp.cust-inpts {
            width: 100% !important;
        }
        .choose-images .choose-images-detail {
            justify-content: center;
        }
        .pipw {
            width: 30% !important;
        }
        .cst-rows #histoUpload {
            flex-wrap: wrap;
        }
    }
    @media (max-width: 600px){
        .exam-rw .cust-fld,.ingm-rw .cust-fld,.hrt-rw .cust-fld,.describe-rw .cust-fld,.material-rw .cust-fld,.cust-row.mid-dorsal .cust-fld,
        .right-fld,.cust-fld,.btm-rw .cust-fld {
        width: 100%;
        }
        .hrt-rw .cust-inp,.hrt-rw .cust-inp,.describe-rw .cust-inp,.material-rw .cust-inp,
        .cust-inp,.cust-row .check-ipt,.right-inp,.btm-rw .cust-inp  {
            width: 100%;
        }
        .cust-row {
            display: block;
        }
        .cust-row.btn-rw {
            display: flex;
        }
    }

    /* end for necropsy */
        
        @media (max-width: 1399px){
            .cetaceanExam-date-form .form-group.flex-center {
            flex-wrap: wrap;
            }
            .cetaceanExam-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
        }

        @media (max-width: 1199px){
            .cetaceanExam-date-form .form-group.flex-center {
            flex-wrap: nowrap;
            }
            .cetaceanExam-date-form .input-group.flex-center {
            flex-wrap: nowrap;
            }
        }
        @media (max-width:1618px){
            .tab-section-list .nav.nav-tabs>li{
                margin-bottom: 8px;
            }
        }
        @media (max-width:1510px){
            .rosturn-text {
                display: block;
            }
            .weight-input {
                max-width: 52px;
            }
            .heartrate-two{
                padding-left: 20px !important;
            }
            .btn {
                padding: 0 7px;
                height: 28px;
                font-size: 12px;
            }
        }
        @media (max-width:1439px){
            .flex-wrap{
                flex-wrap: wrap;
                justify-content: center;
                margin-bottom: 15px;
            }
            .dis-flex.just-center.choose-file-tabdesign {
                margin: 0 0 15px;
            }
            .flex-center.flex-wrap.bottons-wrap.tabdesign-foot-btns {
                margin: 0;
                width: 100%;
            }
            .sample-one{
                width: 75%;
            }
            .sample-two{
                width: 25%;
            }
            .heartrate-one{
                width: 35%;
            }
            .heartrate-two{
                width: 35%;
                padding-left: 10px !important;
            }
            .heartrate-full{
                width: 100%;
            }
            .drug-width{
                width: 25%;
            }
            .rate-wrap label{
                padding-right: 30px;
            }
            .refil-padd{
                padding-left: 10px !important;
            }
        }
        @media (max-width:1325px){
            .green-labels label {
                min-width: 30%;
            }
        }
        @media (max-width:1281px){
            .weight-input {
                max-width: 20px;
            }
            .file-tabdesign-row {
                max-width: 225px;
            }
        }
        @media (max-width:1254px){
            .weight-input-two {
                max-width: 38px;
            }
        }
        @media (max-width:1199px){
            .m-rl-4 {
                margin: 4px;
            }
            input{
                width: 100%;
            }
            .btn{
                max-width: fit-content;
            }
            .bottons-wrap  .btn{
                max-width: 100%;
            }
            .radio-btn input{
                width: auto;
            }
            .bottons-wrap{
                width: 40%
            }
            .locations-textarea {
                min-height: 80px;
            }
            .physical-exam textarea {
                min-height: 80px;
            }
            .sample-one{
                width: 100%;
            }
            .sample-two{
                width: 100%;
            }
            .heartrate-one{
                width: 50%;
            }
            .heartrate-two{
                width: 50%;
            }
            .heartrate-one .btn.btn-success{
            margin-left: auto;
            }
            .heartrate-two .btn.btn-success{
            margin-left: auto;
            }
            .blue-bg {
                padding-bottom: 20px;
            }
            .blue-bg-l {
                padding-bottom: 20px;
            }
            .weight-input-two {
                max-width: 52px;
            }
            .drug-width {
                width: 33.33%;
            }
            .mb-5 {
                margin-bottom: 20px;
            }
            .body-of-water{
                padding-right: 5px;
            }
            .veterinarian{
                padding-right: 5px;
            }
            .lat-one{
                padding-right: 5px;
            }
            .code-padd{
                padding-right: 5px;
            }
            .rate-wrap label{
                padding-right: 39px;
            }
            .ml-auto{
                margin-left: auto;
            }
            .weight-input-three {
                width: 64%;
            }
            .rate-wrap .input-type-time {
                min-width: 102px;
            }
            .drug-time .input-type-time {
                min-width: 102px;
            }
            .weight-input-four {
                width: 65%;
            }
            .weight-input {
                max-width: 71px;
            }
        }
        @media (max-width:991px){
            .bottons-wrap{
                width: 48%
            }
            .weight-input {
                width: 44%;
            }
            .mb-5{
                margin-bottom: 0;
            }
            .fishone-width{
                width: 100%;
            }
            .drug-width {
                width: 50%;
            }
            .date-padd{
                padding-right: 5px;
            }
            .taged-type{
                padding-right: 5px;
            }
            .last-lon{
                padding-right: 5px;
            }
            .heartrate-one{
                width: 50%;
            }
            .heartrate-two{
                width: 50%;
            }
            label{
                min-width: auto;
            }
            .flex-center {
                flex-direction: column;
                align-items: flex-start;
            }
            .flex-row {
                    flex-direction: row;
            }
            .rate-wrap{
                    flex-wrap: wrap;
                    align-items: center;
                    justify-content: flex-start;
            }
            .drug-width .btn.btn-success {
                margin-top: 15px;
            }
            .first-date .time-icon {
                position: absolute;
                top: 18.5px;
                right: 9px;
            }
            .green-labels .flex-center {
                flex-direction: row;
            }
        
            
        }
        @media (max-width: 917.9px){
            .heartrate-one .btn.btn-success{
            margin-top: 10px;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 10px;
            }
        }
        @media (max-width: 849px){
            .heartrate-three{
                width: 100%;
                padding: 0;
            }
            .heartrate-four{
                width: 100%;
            }
        }
        @media (max-width: 767px){
            .estimate-style {
                margin-top: 10px;
            }

            .bottons-wrap{
                width: 60%
            }
            .heartrate-one{
                width: 100%;
            }
            .heartrate-two{
                width: 100%;
            }
            .heartrate-one .btn.btn-success{
            margin-top: 0;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 0;
            }
            .drug-width .btn.btn-success {
                margin-top: 20px;
            }
            .content {
                padding: 25px 15px;
            }
            .cetacean-exam-form .cetacean-exam-wrap.row .col-sm-6 {
                width: 100%;
            }
            
        }
        @media (max-width:574px){
            .col-xs-3 {
                width: 100%;
            }
            .col-xs-4 {
                width: 100%;
            }
            .col-xs-6 {
                width: 100%;
            }
            .col-xs-8 {
                width: 100%;
            }
            .bottons-wrap{
                width: 100%;
            }
            .drug-width {
                width: 100%;
            }
            .mucus-padd{
                padding: 0;
            }
            .refil-padd{
                padding: 0 !important;
            }
            .drug-width .btn.btn-success {
                margin-top: 0;
            }
            .green-labels label {
                min-width: 40%;
            }
        }
        @media (max-width: 354.9px){
            .heartrate-one .btn.btn-success{
            margin-top: 10px;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 10px;
            }
        }
    </style>
    <cfinclude template="GoogleMap.cfm">
<cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Stranding</a></li>
            <li><a href="javascript:;">Cetacean Exam</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>