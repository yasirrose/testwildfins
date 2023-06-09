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
    <cfset ConditionsValue = ['1', '2', '3' ,'4','5']>
    <cfparam  name="url.LCEID" DEFAULT="0">
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfparam  name="url.LCE_HID" DEFAULT="0">

    <cfif isDefined('SaveAndNew') >
     
        <cfif isDefined('form.ID') and form.ID neq "">

            <cfset Session.CeteacenExam = #form.ID#>
            <cfset form.LCE_ID = "#form.ID#">
            <cfset form.LCEID = "#form.ID#">
            <cfset form.CeteacenSelect = "#form.ID#">

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
        <cfset form.LCE_ID = "#form.ID#">
        <cfset Application.Stranding.deleteCE("#form#")>
    
    <cfelseif isDefined('deleteAllRecord')>
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
    <cfif isDefined('form.removeSession') and form.removeSession EQ 'removeS'>
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
        <!--- <cfdump var="#form.LCE_ID#" abort="true"> --->
         <cfif Session.CeteacenExam NEQ form.LCEID>
        <cfset Session.CeteacenExam = ''>
        </cfif>
        <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <cfset qLCEDataa=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
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

        <!--- form.LCEID --->
        <cfif isDefined('Session.CeteacenExam') and Session.CeteacenExam NEQ ''>
            <cfset form.LCEID = #Session.CeteacenExam#>
          
            <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
    
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
    <cfif isDefined('url.HIFormID') and url.HIFormID neq 0>
        <cfset form.HI_ID = '#url.HIFormID#'>
        <cfset form.LCEID = '#url.HIFormID#'>                
       <cfset qgetHIData=Application.Stranding.getHIData("#form.LCEID#")>
        <cfset qLCEDataa=Application.Stranding.getHIData("#form.LCEID#")>
        <cfset qgetcetaceanDate=Application.Stranding.getHIFormNecropsyDate(#form.LCEID#)>
        <cfif #qgetHIData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
        </cfif>
        <cfset qgetHiExamData = Application.Stranding.getHiExamData(LCEID="#form.LCEID#")> 
    </cfif>

    
<cfif isDefined('SaveAndNewHI') OR isDefined('SaveandgotoAForm') OR isDefined('SaveAndClose')>
    <!--- If updating existing data --->

        <cfif  isDefined('form.HIForm_ID') and form.HIForm_ID neq "">
            <cfset Session.HIForm = #form.HIForm_ID#>
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
    <cfset GearDeposition =  ['NMFS','FAU Harbor Branch','Disposed of']>
   <!---  <cfset GearDeposition =  ['NMFS','FAU Harbor Branch','FAU Ocean Discovery Visitor’s Center','Disposed of']>--->
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

    <cfif isDefined('Session.HIForm') and Session.HIForm NEQ ''>        
       
        <cfset form.LCEID = #Session.HIForm#>
        <cfset form.HI_ID = #Session.HIForm#>
        
        <cfset qgetHIData=Application.Stranding.getHIData("#form.LCEID#")>        
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
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderately Decomposed' ,'Advanced Composition','Mummified']>
    <!--- <cfparam  name="url.LCE_ID" DEFAULT="0"> --->

    <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
    
    <cfif isDefined('SaveAndNewLA') > 
        <!--- If updating existing data --->
       
        <cfif  isDefined('form.level_A_ID') and form.level_A_ID neq "">
            <cfset Session.LevelAForm = #form.level_A_ID#>
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
        <cfset Application.Stranding.deleteLA("#form.level_A_ID#")>
    <cfelseif isDefined('deleteAllLevelAFormRecord')>
        <cfset Application.Stranding.deleteAllLevelAFormRecord()>
    </cfif>
 
<!--- nouman --->
    <cfif isDefined('url.LevelAID') and url.LevelAID neq 0>
        
        <cfset form.LCEID = url.LevelAID>
        <cfset form.LA_ID = url.LevelAID>
        <cfset qgetLevelAData=Application.Stranding.getLevelAData("#form.LCEID#")>
        <cfset qLCEDataa=Application.Stranding.getLevelAData("#form.LCEID#")>
        <cfset qgetcetaceanDate=Application.Stranding.getLevelAFormNecropsyDate(#form.LA_ID#)>
        <!--- <cfdump var="#url.LevelAID#" abort="true"> --->
        <cfif #qgetLevelAData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetLevelAData.species#")>
        </cfif> 
    </cfif>
<!---   getting data on the basis of LevelA ID  --->

<cfif  isDefined('form.LA_ID') and form.LA_ID neq "">
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


    <!--- start for Histo --->
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
     
        <!--- If updating existing data --->
        <cfif  isDefined('form.Histo_ID') and form.Histo_ID neq "">
            <!--- if sampletype field is not empty then insert Histo sample form's data which can be multiple at single time --->
            <cfset Session.Histo = #form.Histo_ID#>
            <cfset form.His_ID = "#form.Histo_ID#">
            <cfif form.SampleType neq "" and form.SampleNote neq "">
                <cfset form.HI_ID = "#form.Histo_ID#">
                <cfset Application.Stranding.InsertHistopathologySampleData(argumentCollection="#Form#")>
            </cfif>
              <cfset LCE = Application.Stranding.HistoFormUpdate(argumentCollection="#Form#")>
            
        <cfelse>
            <!--- If inserting new data --->
            <cfset form.LCE_ID = url.LCE_ID>
            <!--- here LCE is catching ID against the latest form/data inserted --->
            <cfset LCE = Application.Stranding.HistoFormInsert(argumentCollection="#Form#")>
            <cfset Session.Histo = #LCE#>
            <cfset form.His_ID = "#LCE#">
            <cfset form.HI_ID  = "#LCE#">
            <cfif form.SampleType neq "" and form.SampleNote neq "">
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

    <!---   getting data on the basis of His_ID  --->
    <cfif  isDefined('form.His_ID') and form.His_ID neq "">
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
   

    <cfif isDefined('SaveAndNewBloodvalue') OR isDefined('SaveandgotoToxicology') OR isDefined('SaveAndClose')>
        <!--- If updating existing data --->
       
        <cfif  isDefined('form.bloodValues_ID') and form.bloodValues_ID neq "">
            <cfset Session.bloodValue = #form.bloodValues_ID#>
            <cfset form.ID = form.bloodValues_ID>
            <cfset form.bloodValue_ID = "#form.bloodValues_ID#">

            <cfset CBCUpdate = Application.Stranding.CBCUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.FibrinogenUpdate(argumentCollection="#Form#")>
        
            <cfset Application.Stranding.ChemisteryUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.CapillaryUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.DolphinUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.iSTAT_ChemUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.CG4Update(argumentCollection="#Form#")>
            <cfset LCE = Application.Stranding.Blood_VFormUpdate(argumentCollection="#Form#")>
      
        <cfelse> 

            <!--- If inserting new data --->
            
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
            <!--- <cfif isDefined('SaveandgotoToxicology')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Toxicology&LCE_ID=#url.LCE_ID#" >
            </cfif> --->
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

    <cfif isDefined('url.BVID') and url.BVID neq 0>
        <cfset form.LCEID = url.BVID>
        <cfset form.bloodValue_ID = url.BVID>
        <cfset form.bloodID = url.BVID>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetBloodValueData=Application.Stranding.getBlood_VData("#form.LCEID#")>
        <cfset qLCEDataa=Application.Stranding.getBlood_VData("#form.LCEID#")>      
        <cfset qgetcetaceanDate=Application.Stranding.getBloodValueNecropsyDate(#form.bloodValue_ID#)>
        <cfif #qgetBloodValueData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetBloodValueData.species#")>
        </cfif>
        <cfset qgetCBC_Data=Application.Stranding.getCBC_Data("#form.bloodID#")>
        <cfset qgetFibrinogen=Application.Stranding.getFibrinogen("#form.bloodID#")>
        <cfset qgetchemistry=Application.Stranding.getchemistry("#form.bloodID#")>
        <cfset qgetCapillary=Application.Stranding.getCapillary("#form.bloodID#")>
        <cfset qgetDolphin=Application.Stranding.getDolphin("#form.bloodID#")>
        <cfset qgetiSTAT_Chem=Application.Stranding.getiSTAT_Chem("#form.bloodID#")>
        <cfset qgetiSTAT_CG4=Application.Stranding.getiSTAT_CG4("#form.bloodID#")>
    </cfif>
    
        <!---  get all records order by ID DESC--->
        <cfset getBloodValueID=Application.Stranding.getBlood_VID()>
        <!---  get all records order by Date Desc --->
        <cfset qgetBloodValueDate=Application.Stranding.getBlood_VDate()>
        <!---  get all records order by Field Numbert Desc --->
        <cfset qgetBloodValueFBNumber=Application.Stranding.getBlood_VBNumber()>
    
    
  
    <!--- end for blood value --->


        <!--- start for Toxicology --->
        <cfset qgetTissueType=Application.StaticDataNew.getTissueType()>

        <cfset ToxicologySelectoptions = ['High','Low','Critical Result','Corrected Result','None']>
        <cfif isDefined('SaveAndNewToxicology') OR isDefined('SaveAndClose') OR isdefined('Add_new') >
            <!--- If updating existing data --->
            <cfif  isDefined('form.TX_ID') and form.TX_ID neq "">
                <cfset Session.Toxicology = #form.TX_ID#>
                <cfset form.Toxi_ID = "#form.TX_ID#">
                <cfset form.Toxicology_ID = "#TX_ID#">
                <cfif form.tisu_type neq "" and form.tisu_type neq "0">
                    
                    <cfset Application.Stranding.ToxiType_FormUpdate(argumentCollection="#Form#")>
                    <cfset Application.Stranding.Update_DynamicToxiType(argumentCollection="#Form#")>
                    <cfset Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
                <cfelse>
                    <cfset TT_ID =Application.Stranding.ToxiType_Insert(argumentCollection="#Form#")>
                    <cfset Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
                </cfif>
                <cfset Application.Stranding.Toxicology_FormUpdate(argumentCollection="#Form#")>
              
                <cfset form.Tissue_type = "">
           
            <cfelse>     
                <!--- If inserting new data --->
               
                <cfset form.LCE_ID = url.LCE_ID>
                <cfset Toxi_ID = Application.Stranding.Toxicology_FormInsert(argumentCollection="#Form#")>
                <cfset Session.Toxicology = #Toxi_ID#>

                <cfset form.Toxi_ID = "#Toxi_ID#">
                <cfset form.Toxicology_ID = "#Toxi_ID#">

                <cfset TT_ID = Application.Stranding.ToxiType_Insert(argumentCollection="#Form#")>
                <!--- DT is Dynamic toxi --->
                <cfset DT_ID = Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
                
                <cfset form.Tissue_type = "">
          
            </cfif>
    
        <cfelseif isDefined('deleteToxicology')>
            <cfset Application.Stranding.deletToxicology("#form#")>
            <cfset form.Toxicology_ID = "">
        <cfelseif isDefined('deleteToxicologyAllRecord')>
            <cfset Application.Stranding.deleteToxicologyAllRecord()>
            <cfset form.Toxicology_ID = "">
        </cfif>
      
        <!---   getting data on the basis of HI_ID  --->
        <cfif  isDefined('form.Toxicology_ID') and form.Toxicology_ID neq "">
            <cfif Session.Toxicology NEQ form.Toxicology_ID>
                <cfset Session.Toxicology = ''>
                </cfif>
            <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
            <cfset qgetToxicologyData=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qLCEDataa=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qgetcetaceanDate=Application.Stranding.getToxicologyNecropsyDate(#form.Toxicology_ID#)>
            <cfset TissueTypeForTable =Application.Stranding.getTissueTypeForTable(#form.Toxicology_ID#)>

            

            <cfif #qgetToxicologyData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetToxicologyData.species#")>
            </cfif>


            <cfif isdefined('form.Tissue_type') and form.Tissue_type neq "">
                <cfset qgetToxitype=Application.Stranding.getToxitype("#form.Tissue_type#,#form.TX_ID#")>
                <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype("#form.Tissue_type#")>
                
            <cfelse>
                <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
                <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype_ten()>
            </cfif>
        <cfelse>
            <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
            <cfset qgetToxicologyData=Application.Stranding.gettoxiform_ten()>
            <!--- <cfset qLCEDataa=Application.Stranding.gettoxiform_ten()> --->
        </cfif>

        <cfif isDefined('Session.Toxicology') and Session.Toxicology NEQ ''>
            <cfset form.Toxicology_ID = #Session.Toxicology#>
            <cfset qgetToxicologyData=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qgetcetaceanDate=Application.Stranding.getToxicologyNecropsyDate(#form.Toxicology_ID#)>
            <cfset TissueTypeForTable =Application.Stranding.getTissueTypeForTable(#form.Toxicology_ID#)>
            <cfif #qgetToxicologyData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetToxicologyData.species#")>
                
            </cfif>
            <cfif isdefined('form.Tissue_type') and form.Tissue_type neq "">
                <cfset qgetToxitype=Application.Stranding.getToxitype("#form.Tissue_type#,#form.TX_ID#")>       
                <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype("#form.Tissue_type#")>    
            </cfif>        
            <!--- <cfset qLCEDataa=Application.Stranding.gettoxiform_ten()> --->
        </cfif>
        
        <cfif isDefined('url.ToxiID') and url.ToxiID NEQ '0'>
            <cfset form.Toxicology_ID = url.ToxiID>
            <cfset qgetToxicologyData=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qLCEDataa=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
            <cfset qgetcetaceanDate=Application.Stranding.getToxicologyNecropsyDate(#form.Toxicology_ID#)>
            <cfset TissueTypeForTable =Application.Stranding.getTissueTypeForTable(#form.Toxicology_ID#)>
            <cfif #qgetToxicologyData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetToxicologyData.species#")>
                
            </cfif>
            <!--- <cfif isdefined('form.Tissue_type') and form.Tissue_type neq "">
                <cfset qgetToxitype=Application.Stranding.getToxitype("#form.Tissue_type#,#form.TX_ID#")>       
                <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype("#form.Tissue_type#")>    
            </cfif>   --->     
             
        </cfif>

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
                <cfset Session.Ancillary = #form.ADID#>
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
           
            </cfif>
        <cfelseif isDefined('deleteAncillary')>
            <cfset Application.Stranding.deleteAncillary("#form#")>
        <cfelseif isDefined('deleteAncillaryAllRecord')>
            <cfset Application.Stranding.deleteAncillaryAllRecord()>
        </cfif>

      
        <!---   getting data on the basis of AD_ID  --->
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
        <cfif isDefined('url.ADID') and url.ADID NEQ '0'> 
            <cfset form.AD_ID = url.ADID>
            <cfset qgetAncillaryData=Application.Stranding.getAncillaryData("#form.AD_ID#")>
            <cfset qLCEDataa=Application.Stranding.getAncillaryData("#form.AD_ID#")> 
            <cfset qgetcetaceanDate=Application.Stranding.getAncillaryDiagnosticsNecropsyDate(#form.AD_ID#)>
            <cfif #qgetAncillaryData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetAncillaryData.species#")>
            </cfif>
            <cfset qAncillaryReportGet=Application.Stranding.AncillaryReportGet("#form.AD_ID#")>
        </cfif>
 
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
    <cfset qgetSampleLocation=Application.StaticDataNew.getSampleLocation()>
    <cfset qgetSampleTracking=Application.StaticDataNew.getSampleTracking()>
    <cfset qgetBinNumber=Application.StaticDataNew.getBinNumber()>
    <cfset qgetUnitofsample=Application.StaticDataNew.getUnitofsample()>
    <cfset qgetPreservationMethod=Application.StaticDataNew.getPreservationMethod()>

    <cfif isDefined('SaveAndNewSampleArchive')>
        
        <cfif isDefined('form.SampleArchiveSEID') and form.SampleArchiveSEID neq "">
            <cfset Session.SampleArchive = #form.SampleArchiveSEID#>
            <cfset form.SEID = "#SampleArchiveSEID#">
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
            <cfset form.STID = "">
        <cfelse>
            <cfset SA_ID = Application.Stranding.SampleArchiveInsert(argumentCollection="#Form#")>
            <cfset Session.SampleArchive = #SA_ID#>

            <cfset form.SA_ID = "#SA_ID#">
            <cfset form.SEID = "#SA_ID#">
            <cfif form.SampleID neq "">
                <cfset ST_ID = Application.Stranding.SampleTypeInsert(argumentCollection="#Form#")>
                <cfset form.ST_ID = "#ST_ID#">
                <cfif form.SADate neq "">
                    <cfset Application.Stranding.InsertSampleData(argumentCollection="#Form#")>
                </cfif>
            </cfif>
            <cfset form.STID = "">
           
        </cfif>
    <cfelseif isDefined('deleteSampleAechive')>
        <cfset Application.Stranding.DeleteSampleType("#form.SampleArchiveSEID#")>
        <!--- <cfset form.STID = ""> --->
    <cfelseif isDefined('deleteallSampleArchiveRecord')>
        <cfset Application.Stranding.deleteallSampleArchiveRecord()>
        <!--- <cfset form.STID = ""> --->
    </cfif>

 <!---   getting data on the basis of LCEID  error--->
   
    


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
    <cfif isDefined('url.SAID') and url.SAID NEQ '0'> 
        <cfset form.SEID = url.SAID>
        <cfset qgetSampleData=Application.Stranding.getSampleArchiveData("#form.SEID#")>
        <cfset qLCEDataa=Application.Stranding.getSampleArchiveData("#form.SEID#")> 
        <cfif #qgetSampleData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetSampleData.species#")>
        </cfif>
        <cfset qgetSampleList=Application.Stranding.getSampleList("#form.SEID#")>
        <cfset qgetSampleFBNumberList=Application.Stranding.getSampleFBNumberList("#form.SEID#")>        
        <!---  get all records order by ID  Desc of SampleType agianst SEID--->
        <cfset qgetSampleTypeIByID=Application.Stranding.getSampleTypeIByID("#form.SEID#")>
        <!---<cfif  isDefined('form.STID') and form.STID neq "">             
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleTypeDataSingle("#form.STID#")>
            <cfset qgetSampleDetailData = Application.Stranding.getSampleDetailDataSingle("#form.STID#")>
        <cfelse>
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleType_ten()>
        </cfif>--->
        <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate(#form.SEID#)>
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


    <cfif (isDefined('form.LCEID') and form.LCEID neq "") || (isDefined('form.bloodValue_ID') and form.bloodValue_ID neq "") || (isDefined('form.His_ID') and form.His_ID neq "") || (isDefined('form.LA_ID') and form.LA_ID neq "") || (isDefined('form.HI_ID') and form.HI_ID neq "") || (isDefined('form.Toxicology_ID') and form.Toxicology_ID neq "") || (isDefined('form.AD_ID') and form.AD_ID neq "") || (isDefined('form.Nfieldnumber') and form.Nfieldnumber neq "") || (isDefined('form.Morphometrics_ID') and form.Morphometrics_ID neq "")>
        <!--- <cfdump var="#form.Toxicology_ID#" abort="true"> --->
        <!--- ceteceanExam test--->
        <cfif isDefined('form.LCEID') and form.LCEID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_LiveCetaceanExam where ID = #form.LCEID#
            </cfquery>
        </cfif>
        <!--- HiForm --->
        <cfif isDefined('form.HI_ID') and form.HI_ID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_HIForm where ID = #form.HI_ID#
            </cfquery>
        </cfif>
        
        <!--- LevelAForm --->
        <cfif isDefined('form.LA_ID') and form.LA_ID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_LevelAForm where ID = #form.LA_ID#
            </cfquery>
        </cfif>

        <!--- Histopathalogy --->
        <cfif isDefined('form.His_ID') and form.His_ID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_HistoForm where ID = #form.His_ID#
            </cfquery>
        </cfif>

        <!--- Blood value --->
        <cfif isDefined('form.bloodValue_ID') and form.bloodValue_ID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_Blood_Values where ID = #form.bloodValue_ID#
            </cfquery>
        </cfif>
        
        <!--- Toxicology --->
        <cfif isDefined('form.Toxicology_ID') and form.Toxicology_ID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_Toxicology where ID = #form.Toxicology_ID#
            </cfquery>
        </cfif>

        <!--- Ancillary Diagnostics --->
        <cfif isDefined('form.AD_ID') and form.AD_ID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_Ancillary_Diagnostics where ID = #form.AD_ID#
            </cfquery>
        </cfif>

        <!--- Necropsy --->
        <cfif isDefined('form.Nfieldnumber') and form.Nfieldnumber neq "">        
            <!--- <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_CetaceanNecropsyReport where Fnumber = #form.Nfieldnumber#
            </cfquery> --->
            <cfset qgetLiveCetaceanExam.Fnumber = form.Nfieldnumber>
        </cfif>
        
        <!--- Morphometrics --->
        <cfif isDefined('form.Morphometrics_ID') and form.Morphometrics_ID neq "">        
            <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
                SELECT Fnumber from ST_Morphometrics where ID = #form.Morphometrics_ID#
            </cfquery>
        </cfif>

        
        <cfquery name="qgetSampleDataByLCE" datasource="#Application.dsn#" maxRows = "1">
            SELECT ID from ST_SampleArchive where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
        </cfquery>


        <cfif isDefined('qgetSampleDataByLCE.ID') and qgetSampleDataByLCE.ID neq "">
            <cfset form.SEID = qgetSampleDataByLCE.ID>
        <cfelse>
            <cfset form.SEID = ''>
        </cfif>

        <!--- <cfdump var="#qgetSampleDataByLCE.ID#" abort="true">--->

        <cfif isDefined('form.SEID') and form.SEID neq "">
        <cfset qgetSampleData=Application.Stranding.getSampleArchiveData("#form.SEID#")>
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
    
        </cfif>
        <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate(#form.SEID#)>
    </cfif>


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
     <!--- import for sample archive test--->
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
         <!--- import for Specialsamplearchive test--->
         <cfif structKeyExists(form, "sampleArchiveSpecialFile") and len(form.sampleArchiveSpecialFile)>
            <cfset dest = getTempDirectory()>
            <cffile action="upload" destination="#dest#" filefield="sampleArchiveSpecialFile" result="upload" nameconflict="makeunique">
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
                    <!--- <cfdump var="#colNameArray#" abort="true"> --->
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
                       <!--- <cfdump var="#data#" abort="true"> --->
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
    
    <cfset Condition_at_Necropsy = ['Fresh Dead','Moderate Decomposition','Advanced Decomposition','Mummified']>
    <cfset Animal_Renderings = ['Buried On Site','Towed Offshore','Burried and Towed Offshore','Landfill']>
    <cfset Fat_Blubber = ['Abundant - No Atrophy','Mild to Moderate Atrophy','Severe Atrophy','NE']>
    <cfset Eye_Finding = ['No Findings','Cloudy','Bloody','Predated','Present']>
    <cfset Joint_Fluid = ['No Findings','Cloudy - Solid Material','Bloody','Blood-tinged','Blood clots','Fibrin','Other']>
    <cfset Muscle_Status = ['Well Muscled - No Atropy','Mild to Modrate Atropy','Severe Atropy','NE']>
    <cfset Musculature_Findings= ['No Findings','Trauma','Hemorrhage','Pallor','Necrosis','Other']>
    <cfset Lining= ['No Findings','Masess','Hemorrhage','Adhesions','Other']>
    <cfset Biliary_Findings= ['No Findings','Gall Bladder thickened','Bile Ducts thickened','Ulcer','Exudate','Stones','Other']>
    <cfset Pericardial_Fluid= ['No Findings','Cloudy/Solid Material','Blood-tinged','Blood clots','Fibrin','Other']>
    <cfset Overall_Findings= ['None','Trauma','Endocarditis-Arteritis','Blood clots','Vessels thickened','Adhesions','Other']>
    <cfset Color_of_Foam= ['White','Pink','Red','Tan','Yellow','Green','Other']>
    <cfset Trachea_Bronchi= ['No Findings','Exudate','Masses','Ulceration','Other']>
    <cfset Kidneys_Findings= ['No Findings','Trauma','Enlarged','Masses','Parasites','Other']>
    <cfset Alimentary_SystemArray= ['Ulcers/exudate','Trauma','Masses','Impaction','Obstruction','lntussusception','Parasites']>
    <cfset brain_Findings= ['No Findings','Trauma','Congestion','Hemorrhage','Necrosis','Exudate','Possible Parasite Ova','Not Examed','Partial Examed','Other']>
    <cfset material_type= ['Hook','Line','Hard Plastic','Plastic Bags','Misc Soft Plastic','Ballon','Other']>
    <cfset Spinal_Cord= ['No Findings','Trauma','Hemorrhage','Necrosis','Exudate','Possible Parasite Ova','Not Examed','Partial Examed','Other']>
    <cfset qgetNxLocation= Application.StaticDataNew.getNxLocation()>
    <cfset qgetLiverFinding= Application.StaticDataNew.getLiverFinding()>
    <cfset qgetLungFinding= Application.StaticDataNew.getLungFinding()>
    <cfset qgetParasiteLocation= Application.StaticDataNew.getParasiteLocation()>
    <cfset qGIForeignMaterial= Application.StaticDataNew.getGIForeignMaterial()>
    <cfset qgetParasiteType= Application.StaticDataNew.getParasiteType()>
    <cfset qgetLymphNodePresent= Application.StaticDataNew.getLymphNodePresent()>

    <cfparam  name="form.fieldnumber" DEFAULT="empty">
    <cfparam  name="form.report" DEFAULT="emptys">

    <cfif isDefined('form.save')>
        <cfset form.report_ID ='#form.report_ID#'>
        <cfif form.report_ID eq '' >
            <cfset CNR = Application.Stranding.CetaceanNecropsyinsert(argumentCollection="#Form#")>
            <cfset form.Nfieldnumber = '#CNR#'> 
            <cfset Session.CetaceanNecropsy = #CNR#>

            <cfset  Application.Stranding.DynamicNutritioninsert(argumentCollection="#Form#")>
            <cfset  Application.Stranding.DynamicLymphoreticularinsert(argumentCollection="#Form#")>
            <cfset  Application.Stranding.DynamicParasitesinsert(argumentCollection="#Form#")>
        <cfelse>
            <cfset Session.CetaceanNecropsy = #form.report_ID#>
            <cfset Application.Stranding.updateCetaceanNecropsy(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicNutrition(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicLymphoreticular(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicParasites(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicNutritioninsert(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicLymphoreticularinsert(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicParasitesinsert(argumentCollection="#Form#")>
            <cfset form.Nfieldnumber = '#form.Fnumber#'>
             
        </cfif>
        
    <cfelseif isDefined('deleteNecropsyRecord')>
        
        <cfset Application.Stranding.deletcetaceannecropsy("#form#")>
    <cfelseif isDefined('deletCetaceanNecropsyAllRecord')>
        <cfset Application.Stranding.deletCetaceanNecropsyAllRecord()>
    </cfif>
    <cfset qgetallfieldnumbers = application.Stranding.getallfieldnumber()>
    <cfset qgetNecropsyDate = application.Stranding.getNecropsyDate()>
    <!--- <cfdump var="#qgetallfieldnumbers.Fnumber#" abort="true"> --->

    <cfif isDefined('form.Nfieldnumber') and Nfieldnumber neq "">

        <cfif Session.CetaceanNecropsy NEQ form.Nfieldnumber>
            <cfset Session.CetaceanNecropsy = ''>  
       </cfif>
        <cfset form.field = form.Nfieldnumber>
            <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.field#")>          
            <cfset qLCEDataa=Application.Stranding.getCetaceanNecropsy("#form.field#")>
            <cfset qgetcetaceanDate.CNRDATE= qLCEDataa.CNRDATE>

            <cfset qgetAllData=Application.Stranding.getAllData("#form.field#")>        
            <cfset qgetNutritional=Application.Stranding.getNutritional("#form.field#")>   
            <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular("#form.field#")>
            <cfset qgetParasites=Application.Stranding.getParasites("#form.field#")>
            <cfif #qgetCetaceanNecropsy.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetCetaceanNecropsy.species#")> 
        </cfif>
        <cfif isDefined('qgetAllData.species') and #qgetAllData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetAllData.species#")>
        </cfif>
    <cfelse>
        <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy_ten()>
        <cfset qgetNutritional=Application.Stranding.getNutritional_ten()>
        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular_ten()>
        <cfset qgetParasites=Application.Stranding.getParasites_ten()>
       
    </cfif>
     <!---         TodayWorking2  --->
    <cfif isDefined('caseReport')>
        <cfset form.field = form.Fnumber>
        <cfset form.Fnumber = form.Fnumber>

        <cfset qgetNecropsyImages=Application.Stranding.getNecropsyImages("#form.Fnumber#")> 
        <!--- <cfdump var="#qgetNecropsyImages#" abort="true"> --->
        <cfset qgetPdfFiles=Application.Stranding.getPdfFiles("#form.Fnumber#")> 
        <cfset qgetHeaderImages=Application.Stranding.getHeaderImages("#form.Fnumber#")> 
        
        <cfset pdfList = "">
        <cfloop query="qgetPdfFiles">
        <cfif qgetPdfFiles.pdfFiles neq ''>
            <cfset myArray = listToArray(qgetPdfFiles.pdfFiles)>
            <cfloop array="#myArray#" index="i">
                <cfset pdfList = ListAppend(pdfList, "http://cloud.wildfins.org/#i#", ",")> 
            </cfloop>
        </cfif>
        </cfloop>
        
        <cfset imagesList = "">
        <cfloop query="qgetHeaderImages">
            <cfif qgetHeaderImages.headerImages neq ''>
                <cfset myImageArray = listToArray(qgetHeaderImages.headerImages)>
                <cfloop array="#myImageArray#" index="i">
                    <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                        <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                    </cfif>
                </cfloop>               
            </cfif>
        </cfloop>

        <cfif isDefined('qgetNecropsyImages.IMAGES') and qgetNecropsyImages.IMAGES neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.IMAGES)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop> 
        </cfif>
        <cfif isDefined('qgetNecropsyImages.INTEGUMENTIMAGES') and qgetNecropsyImages.INTEGUMENTIMAGES neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.INTEGUMENTIMAGES)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.IntenalExamImages') and qgetNecropsyImages.IntenalExamImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.IntenalExamImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.musculoskeletalImages') and qgetNecropsyImages.musculoskeletalImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.musculoskeletalImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.thoracictImages') and qgetNecropsyImages.thoracictImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.thoracictImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.abdominalImages') and qgetNecropsyImages.abdominalImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.abdominalImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.hepatobiliaryImages') and qgetNecropsyImages.hepatobiliaryImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.hepatobiliaryImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.cardiovascularImages') and qgetNecropsyImages.cardiovascularImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.cardiovascularImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.pulmonaryImages') and qgetNecropsyImages.pulmonaryImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.pulmonaryImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.lymphoreticularImages') and qgetNecropsyImages.lymphoreticularImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.lymphoreticularImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.endocrineImages') and qgetNecropsyImages.endocrineImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.endocrineImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.urogenitalImages') and qgetNecropsyImages.urogenitalImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.urogenitalImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.alimentaryImages') and qgetNecropsyImages.alimentaryImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.alimentaryImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>
        <cfif isDefined('qgetNecropsyImages.centralNervousImages') and qgetNecropsyImages.centralNervousImages neq ''>
            <cfset myImageArray = listToArray(qgetNecropsyImages.centralNervousImages)>
            <cfloop array="#myImageArray#" index="i">
                <cfif NOT ListFind(imagesList, "http://cloud.wildfins.org/#i#")>
                    <cfset imagesList = ListAppend(imagesList, "http://cloud.wildfins.org/#i#", ",")> 
                </cfif>
            </cfloop>
        </cfif>

    <cfif (imagesList neq '') or (pdfList neq '')>
        <cfif imagesList eq ''>
            <cfset Src = "#pdfList#">
        <cfelse>

            <cfhtmltopdf destination="#Application.CloudDirectory#mypdf.pdf" overwrite = "yes">
                <cfoutput>
                    <cfloop list="#imagesList#" index="item">
                        <img src="#item#" alt="Image" width="100" height="100">
                     </cfloop>
                </cfoutput>
            </cfhtmltopdf>

            <cfset pdfPath = '#Application.CloudDirectory#mypdf.pdf'>
            <cfif fileExists(pdfPath)> 
                
                <cfif pdfList neq ''>
                    <cfset Src = "#pdfList#,http://cloud.wildfins.org/mypdf.pdf">
                <cfelse>
                        <cfset Src = "http://cloud.wildfins.org/mypdf.pdf">
                </cfif>
                <cfif pdfList eq ''>
                    <cfset pdfPathforall = 'http://cloud.wildfins.org/mypdf.pdf'>
                    <cfheader name="Content-Disposition" value="attachment;filename=mypdf.pdf">
                    <cfcontent type="application/pdf" file="#pdfPathforall#">

                </cfif>
            
            </cfif>
        </cfif>    

<!---      <cfdump var="#Src#" abort="true">  --->
<!---         <cfset pdfPath = '#Application.CloudDirectory#mypdf.pdf'> --->
        <cfif pdfList neq ''>

            <cfif (ListLen(pdfList) eq '1') and (imagesList eq '')>
                <cfset pdfPathforall = '#Src#'>
                <cfheader name="Content-Disposition" value="attachment;filename=CaseReport.pdf">
                <cfcontent type="application/pdf" file="#pdfPathforall#">
            <cfelse>

                <cfpdf action="merge" overwrite = "yes"  source="#Src#" destination="#Application.CloudDirectory#/output.pdf" /> 
                <cfset pdfPathforall = '#Application.CloudDirectory#output.pdf'>
                <cfheader name="Content-Disposition" value="attachment;filename=CaseReport.pdf">
                <cfcontent type="application/pdf" file="#pdfPathforall#">
            </cfif>
        </cfif>
    </cfif>

               
    </cfif>

    <!---TodayWorking22  --->
    <cfif isDefined('createPdf')>
        <cfset form.field = form.Fnumber>
        <cfset form.Nfieldnumber = form.Fnumber>
        <cfset form.Morphometrics_ID = form.Fnumber>
        <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.Nfieldnumber#")> 
       <cfset qgetMorphometricsData=Application.Stranding.getMorphometricsAllFnumberData("#form.Morphometrics_ID#")>
       <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
       <cfset getTeams=Application.SightingNew.getTeams()>
    <cfoutput>
    <cfsavecontent variable="myVariableName">
   
    <!---TodayWorking22 --->
    <body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
            <table  id="Table_01" width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="2" style="height: 20px;"></td>
                            </tr>	
                            <tr>
                                <td style="width: 5%;"></td>
                                <td style="width: 90%;">
                                    <table style="width: 100%; background-color: ##fff;">
                                        <tr>
                                            <td style="height: 20px;"></td>
                                        </tr>	
                                        <tr>
                                            <td style="line-height: 0; text-align: center;"><a href=""><img src="http://cloud.wildfins.org/necropsyPDF/logo-img.png"></a></td>
                                        </tr>	
                                        <tr>
                                            <td style="height: 50px;"></td>
                                        </tr>	
                                        <tr>
                                            <td style="line-height: 0; padding-top:50px; text-align: center; font-size: 20px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Gross Necropsy Report</td>
                                        </tr>	
                                        <tr>
                                            <td style="line-height: 0; padding-top:50px; text-align: center; font-size: 24px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.Fnumber#</td>
                                        </tr>	
                                        <tr>
                                            <td style="line-height: 0; padding-top:20px; text-align: center; font-size: 14px; font-family: Arial, Helvetica, sans-serif;">Bottlenose Dolphin</td>
                                        </tr>	
                                        <tr>
                                            <td style="line-height: 0; padding-top:20px; text-align: center; font-size: 14px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;"><i>Tursiops truncatus</i></td>
                                        </tr>	
                                        <cfif isDefined('qgetCetaceanNecropsy.Date') and #qgetCetaceanNecropsy.Date# neq "" >	
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Stranding Date:</strong>#DateTimeFormat(qgetCetaceanNecropsy.Date, "MM/dd/YYYY")#</td>
                                            </tr>
                                        </cfif>	
                                        <cfif isDefined('qgetCetaceanNecropsy.Location') and #qgetCetaceanNecropsy.code# neq "">
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Stranding Location:</strong> #qgetCetaceanNecropsy.Location#</td>
                                            </tr>
                                        </cfif>	
                                        
                                        <tr>
                                            <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Animal ID:</strong>New</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.code') and #qgetCetaceanNecropsy.code# neq "" >	
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Code:</strong>#qgetCetaceanNecropsy.code#</td>
                                            </tr>
                                        </cfif>
                                        <cfif isDefined('qgetCetaceanNecropsy.sex') and #qgetCetaceanNecropsy.sex# neq "" >	
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Sex:</strong>#qgetCetaceanNecropsy.sex#</td>
                                            </tr>
                                        </cfif>	
                                        <tr>
                                            <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Weight:</strong>130lbs</td>
                                        </tr>
                                            
                                        <cfif isDefined('qgetCetaceanNecropsy.actualClass') and #qgetCetaceanNecropsy.actualClass# neq "" >	
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Age Class:</strong>#qgetCetaceanNecropsy.actualClass#</td>
                                            </tr>
                                        </cfif>
                                        <cfif isDefined('qgetCetaceanNecropsy.BriefHistory') and #qgetCetaceanNecropsy.BriefHistory# neq "" >
                                            <tr>
                                                <td style="line-height: 28px; padding-top:10px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Brief History:</strong>#qgetCetaceanNecropsy.BriefHistory#</td>
                                            </tr>
                                        </cfif>
                                        <cfif isDefined('qgetCetaceanNecropsy.LevelADate') and #qgetCetaceanNecropsy.LevelADate# neq "" >
                                        <tr>
                                            <td style="line-height: 0; padding-top:10px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Level A Date:</strong>#DateTimeFormat(qgetCetaceanNecropsy.LevelADate, "MM/dd/YYYY")#</td>
                                        </tr>
                                        </cfif>
                                        
                                            <cfif isDefined('qgetCetaceanNecropsy.CNRDATE') and #qgetCetaceanNecropsy.CNRDATE# neq "" >	
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Necropsy Date:</strong>#qgetCetaceanNecropsy.CNRDATE#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 40px;"></td>
                                        </tr> 
                                        <tr>
                                            <td>
                                                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="line-height: 0; text-align: left;"><img src="http://cloud.wildfins.org/necropsyPDF/img-1.png" alt="" style="width: 100%;"></td>
                                                        <td style="line-height: 0; width: 40px;"></td>
                                                        <td style="line-height: 0; text-align: left;"><img src="http://cloud.wildfins.org/necropsyPDF/img-2.png" alt="" style="width: 100%;"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 0; padding-top:50px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Euthanized:</strong>#qgetCetaceanNecropsy.Euthanized#</td>
                                        </tr>	
                                        <cfif isDefined('qgetCetaceanNecropsy.Bodycondition') and #qgetCetaceanNecropsy.Bodycondition# neq "" >
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>General Body Condition:</strong> #qgetCetaceanNecropsy.Bodycondition#</td>
                                            </tr>
                                        </cfif>
                                        <cfif isDefined('qgetCetaceanNecropsy.AnimalRenderings') and #qgetCetaceanNecropsy.AnimalRenderings# neq "" >
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Animal Renderings:</strong> #qgetCetaceanNecropsy.AnimalRenderings#</td>
                                            </tr>
                                        </cfif>	
                                        <cfif isDefined('qgetCetaceanNecropsy.attendingVeterinarian') and #qgetCetaceanNecropsy.attendingVeterinarian# neq "" >
        
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Attending Veterinarian:</strong> 
                                                    <cfloop query="qgetVeterinarians">
                                                            <cfif ListFind(ValueList(qgetCetaceanNecropsy.attendingVeterinarian,","),#qgetVeterinarians.ID#)>
                                                                #qgetVeterinarians.Veterinarians#,
                                                            </cfif>
                                                    </cfloop>
                                                </td>
                                            </tr>
                                        </cfif>
                                        <cfif isDefined('qgetCetaceanNecropsy.Prosectors') and #qgetCetaceanNecropsy.Prosectors# neq "" >
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Prosectors:</strong>
                                                    <cfloop query="getTeams">
                                                            <cfif ListFind(ValueList(qgetCetaceanNecropsy.Prosectors,","),#getTeams.RT_ID#)>#getTeams.RT_MemberName#,</cfif>
                                                    </cfloop>
                                                </td>
                                            </tr>
                                        </cfif>
                                        <cfif isDefined('qgetCetaceanNecropsy.Tentative') and #qgetCetaceanNecropsy.Tentative# neq "" >
                                            <tr>
                                                <td style="line-height: 20px; padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif; word-break: break-all; word-break: break-word;">
                                                    <strong>Tentative Gross Diagnosis:</strong>#qgetCetaceanNecropsy.Tentative#
                                                </td>
                                            </tr>	
                                        </cfif>	
                                        <cfif isDefined('qgetCetaceanNecropsy.deathcause') and #qgetCetaceanNecropsy.deathcause# neq "" >
                                            <tr>
                                                <td style="line-height: 28px; padding-top:10px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Cause of Death:</strong> #qgetCetaceanNecropsy.deathcause#</td>
                                            </tr>
                                        </cfif>	
                                        <tr>
                                            <td style="line-height: 0; padding-top:30px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>UGA Respiratory Pathogen Test:</strong>(See attached lab results)</td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 0; padding-top:30px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>MSU Heavy Metals:</strong> (See attached lab results)</td>
                                        </tr>	
                                        <tr>
                                            <td style="line-height: 0; padding-top:30px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Histopathology Report:</strong> Dr. David Rotstein</td>
                                        </tr>	
                                        <cfif isDefined('qgetCetaceanNecropsy.historemark') and #qgetCetaceanNecropsy.historemark# neq "" >
                                            <tr>
                                                <td style="line-height: 28px; padding-top:10px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Remarks:</strong> #qgetCetaceanNecropsy.historemark#</td>
                                            </tr>
                                        </cfif>
                                        
                                        <tr>
                                            <td style="line-height: 0px; padding-top:10px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Primary Diagnostic Category:</strong> Parasitic</td>
                                        </tr>	
                                        <tr>
                                            <td style="text-align: left; padding-top:20px; font-size: 16px; font-family: Arial, Helvetica, sans-serif;"><strong>Diagnosis:</strong> Pulmonary Fibrosis, Verminous Pneumonia (degenerate parasites)</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 12%;"></td>
                                                        <td style="width: 76%;">
                                                            <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Integumentary System/Musculoskeletal System</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            <tr>
                                                                                <td style="width: 10%;"></td>
                                                                                <td style="width: 80%;">
                                                                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                        <tr>
                                                                                            <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">A. Skin: Cytoplasmic pallor, focally extensive.</td>
                                                                                        </tr>
                                                                                    </table>    
                                                                                </td>
                                                                                <td style="width: 10%;"></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Urinary and Reproductive System</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Nervous System/Sensory System:</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            <tr>
                                                                                <td style="width: 10%;"></td>
                                                                                <td style="width: 80%;">
                                                                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                        <tr>
                                                                                            <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">NE</td>
                                                                                        </tr>
                                                                                    </table>    
                                                                                </td>
                                                                                <td style="width: 10%;"></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Cardiovascular System:</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            <td style="width: 10%;"></td>
                                                                            <td style="width: 80%;">
                                                                                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">NSF</td>
                                                                                    </tr>
                                                                                </table>    
                                                                            </td>
                                                                            <td style="width: 10%;"></td>
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Respiratory System:</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            <td style="width: 10%;"></td>
                                                                            <td style="width: 80%;">
                                                                                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">A. Lung:</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table style="width: 100%;">
                                                                                                <tr>
                                                                                                    <td style="width: 5%;"></td>
                                                                                                    <td style="width: 90%;">
                                                                                                        <table style="width: 100%;">
                                                                                                            <tr>
                                                                                                                <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">a. Fibrosis, multifocal, mild.</td>
                                                                                                            </tr>    
                                                                                                            <tr>
                                                                                                                <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">b. Fibrous capsule with mineralization (prior endoparasitism).</td>
                                                                                                            </tr>  
                                                                                                        </table>
                                                                                                    </td>
                                                                                                    <td style="width: 5%;"></td>   
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>    
                                                                            </td>
                                                                            <td style="width: 10%;"></td>
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Digestive System:</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            <tr>
                                                                                <td style="width: 10%;"></td>
                                                                                <td style="width: 80%;">
                                                                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                        <tr>
                                                                                            <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">NSF</td>
                                                                                        </tr>
                                                                                    </table>    
                                                                                </td>
                                                                                <td style="width: 10%;"></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Hepatobiliary System:</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            <tr>
                                                                                <td style="width: 10%;"></td>
                                                                                <td style="width: 80%;">
                                                                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                        <tr>
                                                                                            <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">A. Lymph Node, Multiple: Lymphoid hyperplasia, mild.</td>
                                                                                        </tr>
                                                                                    </table>    
                                                                                </td>
                                                                                <td style="width: 10%;"></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                                <tr>
                                                                    <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">Endocrine System:</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>                  
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                            <tr>
                                                                                <td style="width: 10%;"></td>
                                                                                <td style="width: 80%;">
                                                                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                        <tr>
                                                                                            <td style="line-height: 15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">NSF</td>
                                                                                        </tr>
                                                                                    </table>    
                                                                                </td>
                                                                                <td style="width: 10%;"></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>             
                                                                </tr>
                                                            </table>  
                                                        </td>
                                                        <td style="width: 12%;"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 25px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">The following tissues have no significant histological findings: IV Septum (1), esophagus (1), right atrium (2), right ventricle (2), left atrium (3), left ventricle (3), right pulmonary lymph node (3), tendon (4), left tracheobronchial lymph node (4), uterus (12), pylorus (5), right kidney (5), trachea (11), pancreas (6), forestomach (6), left kidney (10) fundus (10), adrenal gland (7), large intestine (7), liver (7), left lung lymph node (8), urinary bladder (8), small intestine (8), duodenal ampulla (9), right adrenal gland (9)</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 50px;"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%; text-align: center;">
                                                    <tr>
                                                        <td style="line-height: 0; text-align: center;"><img  src="http://cloud.wildfins.org/necropsyPDF/fish-img.png" alt="" style="width: 100%;"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 50px;"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    
                                                    <cfif isDefined('qgetMorphometricsData.totalLength') and qgetMorphometricsData.totalLength neq ''>
                                                        <tr>
                                                            <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Total Length (1): </strong><u> #qgetMorphometricsData.totalLength# cm</u>(rostrum to fluke notch)</td>
        
                                                            <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Rostrum to Dorsal Fin (2): </strong><u>#qgetMorphometricsData.rostrum#cm</u></td>
                                                        </tr>
                                                    </cfif>
                                                    <tr>
                                                        <td colspan="2" style="height: 20px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Blowhole to Dorsal (3): </strong><u>#qgetMorphometricsData.blowhole#</u>(center of blowhole)</td>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Fluke Width: (4): </strong><u>#qgetMorphometricsData.fluke# cm</u></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="height: 20px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Girth (circumference): Cervical (5): </strong><u>#qgetMorphometricsData.girth# cm</u></td>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Axillary (6): </strong><u>#qgetMorphometricsData.axillary# cm</u></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="height: 20px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Maximum (7): </strong><u>#qgetMorphometricsData.maxium# cm</u></td>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Blubber Thickness: Mid-Dorsal: </strong><u>#qgetMorphometricsData.blubber# cm</u></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="height: 20px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Mid-Lateral: </strong><u>#qgetMorphometricsData.midlateral# cm</u></td>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Mid-Ventral: </strong><u>#qgetMorphometricsData.midVentral# cm</u></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="height: 20px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Tooth Count: </strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="height: 20px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Upper-Left: </strong><u>#qgetMorphometricsData.Lateralupperleft#</u></td>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Lower-Left: </strong><u>#qgetMorphometricsData.Laterallowerleft#</u></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="height: 20px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Upper-Right: </strong><u>#qgetMorphometricsData.Ventralupperleft#</u></td>
                                                        <td style="line-height: 0; font-size: 16px; font-family: Arial, Helvetica, sans-serif; text-align: left;"><strong>Lower-Right: </strong><u>#qgetMorphometricsData.Ventrallowerright#</u></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0; padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Integument</td>
                                        </tr>
                                        
                                        <cfif isDefined('qgetCetaceanNecropsy.Lesionform') and #qgetCetaceanNecropsy.Lesionform# neq "" >
                                            <tr>
                                                <td style="line-height: 0; padding-top:20px; text-align: left; font-size: 14px; font-family: Arial, Helvetica, sans-serif;"><strong>Skin Lesson Form ? </strong>#qgetCetaceanNecropsy.Lesionform#</td>
                                            </tr>
                                        </cfif>
                                        <cfif isDefined('qgetCetaceanNecropsy.lessiondescribe') and #qgetCetaceanNecropsy.lessiondescribe# neq "" >
                                            <tr>
                                                <td style="line-height: 28px; padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.lessiondescribe#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 50px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <cfset imgs = ValueList(qgetCetaceanNecropsy.integumentImages,",")>
                                                        <cfif listLen(imgs)> 
                                                            <cfloop list="#imgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>	
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0; padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Nutritional Condition—Internal</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.muscular_comments') and #qgetCetaceanNecropsy.muscular_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.muscular_comments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <cfset IntenalExamimg = ValueList(qgetCetaceanNecropsy.IntenalExamImages,",")>
                                                        <cfif listLen(IntenalExamimg)> 
                                                            <cfloop list="#IntenalExamimg#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>	
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Musculoskeletal System</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.muscular_comments') and #qgetCetaceanNecropsy.muscular_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.muscular_comments# </td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <cfset musculoskeletalImgs = ValueList(qgetCetaceanNecropsy.musculoskeletalImages,",")>
                                                        <cfif listLen(musculoskeletalImgs)> 
                                                            <cfloop list="#musculoskeletalImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>	
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Thoracic Cavity</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.thoratic_comments') and #qgetCetaceanNecropsy.thoratic_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.thoratic_comments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 60px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <cfset thoracictImgs = ValueList(qgetCetaceanNecropsy.thoracictImages,",")>
                                                        <cfif listLen(thoracictImgs)> 
                                                            <cfloop list="#thoracictImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Abdominal Cavity</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.abdominal_comments') and #qgetCetaceanNecropsy.abdominal_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.abdominal_comments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <cfset abdominalImgs = ValueList(qgetCetaceanNecropsy.abdominalImages,",")>
                                                    <tr>
                                                        <cfif listLen(abdominalImgs)> 
                                                            <cfloop list="#abdominalImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Alimentary System</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.Parasitecomments') and #qgetCetaceanNecropsy.Parasitecomments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.Parasitecomments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 60px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <cfset alimentaryImgs = ValueList(qgetCetaceanNecropsy.alimentaryImages,",")>
                                                    <tr>
                                                        <cfif listLen(alimentaryImgs)> 
                                                            <cfloop list="#alimentaryImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Hepatobiliary System</td>
                                        </tr>
                                        
                                        <cfif isDefined('qgetCetaceanNecropsy.hepatobiliary_comments') and #qgetCetaceanNecropsy.hepatobiliary_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.hepatobiliary_comments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <cfset hepatobiliaryImgs = ValueList(qgetCetaceanNecropsy.hepatobiliaryImages,",")>
                                                    <tr>
                                                        <cfif listLen(hepatobiliaryImgs)> 
                                                            <cfloop list="#hepatobiliaryImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Cardiovascular System</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.cardio_comments') and #qgetCetaceanNecropsy.cardio_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">T#qgetCetaceanNecropsy.cardio_comments#</td>
                                            </tr>
                                            </cfif>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Pulmonary System</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.pulmonary_comments') and #qgetCetaceanNecropsy.pulmonary_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.pulmonary_comments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 60px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <cfset pulmonaryImgs = ValueList(qgetCetaceanNecropsy.pulmonaryImages,",")>
                                                    <tr>
                                                        <cfif listLen(pulmonaryImgs)> 
                                                            <cfloop list="#pulmonaryImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Lymphoreticular System</td>
                                        </tr>
                                        
                                        <cfif isDefined('qgetCetaceanNecropsy.lympho_comments') and #qgetCetaceanNecropsy.lympho_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.lympho_comments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <cfset lymphoreticularImgs = ValueList(qgetCetaceanNecropsy.lymphoreticularImages,",")>
                                                    <tr>
                                                        <cfif listLen(lymphoreticularImgs)> 
                                                            <cfloop list="#lymphoreticularImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Endocrine</td>
                                        </tr>
                                        
                                        
                                        <cfif isDefined('qgetCetaceanNecropsy.endocrine_comments') and #qgetCetaceanNecropsy.endocrine_comments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.endocrine_comments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <cfset endocrineImgs = ValueList(qgetCetaceanNecropsy.endocrineImages,",")>
                                                    <tr>
                                                        <cfif listLen(endocrineImgs)> 
                                                            <cfloop list="#endocrineImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Urogenital System</td>
                                        </tr>
                                        
                                        
                                        <tr>
                                            <td style="line-height: 28px;padding-top:15px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.UROGENITAL_Comments#</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <cfset urogenitalImgs = ValueList(qgetCetaceanNecropsy.urogenitalImages,",")>
                                                    <tr>
                                                        <cfif listLen(urogenitalImgs)> 
                                                            <cfloop list="#urogenitalImgs#" item="item" index="index">
                                                                <td style="line-height: 0; text-align: left;">
                                                                    <img src="http://cloud.wildfins.org/#item#" alt="" style="height: 115px;width:115px;">
                                                                </td>
                                                            </cfloop>
                                                        </cfif>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 40px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Central Nervous System</td>
                                        </tr>
                                        <cfif isDefined('qgetCetaceanNecropsy.nervoussystemcomments') and #qgetCetaceanNecropsy.nervoussystemcomments# neq "" >
                                            <tr>
                                                <td style="line-height: 28px;padding-top:20px; text-align: left; font-size: 16px; font-family: Arial, Helvetica, sans-serif;">#qgetCetaceanNecropsy.nervoussystemcomments#</td>
                                            </tr>
                                        </cfif>
                                        <tr>
                                            <td style="height: 30px; border-bottom: 2px solid ##579cd4;"></td>
                                        </tr>
                                        <tr>
                                            <td style="line-height: 0;padding-top:20px; text-align: center; font-size: 22px; font-weight: 600; font-family: Arial, Helvetica, sans-serif;">Additional Notes</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 400px"></td>
                                        </tr>
                                    </table>  
                                </td>    
                            </tr>	
                            <tr>
                                <td colspan="2" style="height: 20px;"></td>
                            </tr>	      
                        </table>
                    </td>
                </tr>
            </table>
    </body>   
  





    <!---TodayWorking22 --->

    </cfsavecontent>
    </cfoutput>

        <cfhtmltopdf name="mypdf">
            <cfoutput>#myVariableName#</cfoutput>
        </cfhtmltopdf>

        <cfoutput>
            <cfheader name="Content-Disposition" value="attachment; filename=NecropsyReport.pdf">
            <cfcontent type="application/pdf" variable="#toBinary(mypdf)#">
<!---             <a href="#mypdf.pdf#" download="mydownload.pdf">Download PDF</a> --->
        </cfoutput>   
    </cfif> 
<!---     End Today --->
    
    <cfif isDefined('Session.CetaceanNecropsy') and Session.CetaceanNecropsy NEQ ''> 
        <cfset form.field = #Session.CetaceanNecropsy# >
        <cfset form.NFIELDNUMBER = #Session.CetaceanNecropsy# >

        <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.field#")>          
        <!--- <cfset qLCEDataa=Application.Stranding.getCetaceanNecropsy("#form.field#")> --->
        <cfset qgetcetaceanDate.CNRDATE= qLCEDataa.CNRDATE>
        <cfset qgetAllData=Application.Stranding.getAllData("#form.field#")>        
        <cfset qgetNutritional=Application.Stranding.getNutritional("#form.field#")>     
        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular("#form.field#")>
        <cfset qgetParasites=Application.Stranding.getParasites("#form.field#")>
        <cfif #qgetCetaceanNecropsy.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetCetaceanNecropsy.species#")>
        </cfif>
        <cfif isDefined('qgetAllData.species') and #qgetAllData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetAllData.species#")>
        </cfif>
    </cfif>
    <cfif isDefined('url.NRID') and url.NRID NEQ '0'>
        <cfset form.field = url.NRID >
        <cfset form.NFIELDNUMBER = url.NRID >

        <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.field#")>   
<!---         <cfdump var="#qgetCetaceanNecropsy#" abort="true">        --->
        <cfset qLCEDataa=Application.Stranding.getCetaceanNecropsy("#form.field#")> 
        <cfset qgetcetaceanDate.CNRDATE= qLCEDataa.CNRDATE>
        <cfset qgetAllData=Application.Stranding.getAllData("#form.field#")>        
        <cfset qgetNutritional=Application.Stranding.getNutritional("#form.field#")>     
        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular("#form.field#")>
        <cfset qgetParasites=Application.Stranding.getParasites("#form.field#")>
        <cfif #qgetCetaceanNecropsy.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetCetaceanNecropsy.species#")>
        </cfif>
        <cfif isDefined('qgetAllData.species') and #qgetAllData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetAllData.species#")>
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
        <cfset Session.Morphometrics = '#form.Morphometricss_ID#'>
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
    <cfset qLCEDataa=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")> 
    <cfset qgetcetaceanDate=Application.Stranding.getMorphometricsNecropsyDate(#form.Morphometrics_ID#)>
    <cfif #qgetMorphometricsData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetMorphometricsData.species#")>
    </cfif>
</cfif>
<cfif isDefined('url.MorphoID') and url.MorphoID NEQ '0'> 
    <cfset form.Morphometrics_ID = url.MorphoID>
    <cfset qgetMorphometricsData=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>
    <cfset qLCEDataa=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>
    <cfset qgetcetaceanDate=Application.Stranding.getMorphometricsNecropsyDate(#form.Morphometrics_ID#)>
    <cfif #qgetMorphometricsData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetMorphometricsData.species#")>
    </cfif>
</cfif>
<cfif isDefined('Session.Morphometrics') and Session.Morphometrics NEQ ''> 
    <cfset form.Morphometrics_ID = #Session.Morphometrics#>
    <cfset qgetMorphometricsData=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>
    <cfset qgetcetaceanDate=Application.Stranding.getMorphometricsNecropsyDate(#form.Morphometrics_ID#)>
    <cfif #qgetMorphometricsData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetMorphometricsData.species#")>
    </cfif>
</cfif>

<cfset MorphometricsoFBNumber=Application.Stranding.getMorphometricsBNumber()>
<cfset MorphometricsoDate=Application.Stranding.getMorphometricsDate()>

<!--- start data for all header --->
<!---for HIForm --->
<cfif (isDefined('form.LCEID') and form.LCEID neq "") || (isDefined('form.bloodValue_ID') and form.bloodValue_ID neq "") || (isDefined('form.His_ID') and form.His_ID neq "") || (isDefined('form.LA_ID') and form.LA_ID neq "") || (isDefined('form.HI_ID') and form.HI_ID neq "") || (isDefined('form.Toxicology_ID') and form.Toxicology_ID neq "") || (isDefined('form.AD_ID') and form.AD_ID neq "") || (isDefined('form.Nfieldnumber') and form.Nfieldnumber neq "") || (isDefined('form.Morphometrics_ID') and form.Morphometrics_ID neq "") || (isDefined('form.SEID') and form.SEID neq "")>
  
    <cfif isDefined('form.LCEID') and form.LCEID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_LiveCetaceanExam where ID = #form.LCEID#
        </cfquery>
    </cfif>
    <!--- HiForm --->
    <cfif isDefined('form.HI_ID') and form.HI_ID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_HIForm where ID = #form.HI_ID#
        </cfquery>
    </cfif>
    
    <!--- LevelAForm --->
    <cfif isDefined('form.LA_ID') and form.LA_ID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_LevelAForm where ID = #form.LA_ID#
        </cfquery>
    </cfif>

    <!--- Histopathalogy --->
    <cfif isDefined('form.His_ID') and form.His_ID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_HistoForm where ID = #form.His_ID#
        </cfquery>
    </cfif>

    <!--- Blood value --->
    <cfif isDefined('form.bloodValue_ID') and form.bloodValue_ID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_Blood_Values where ID = #form.bloodValue_ID#
        </cfquery>
    </cfif>
    
    <!--- Toxicology --->
    <cfif isDefined('form.Toxicology_ID') and form.Toxicology_ID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_Toxicology where ID = #form.Toxicology_ID#
        </cfquery>
    </cfif>

    <!--- Sample Archive --->
    <cfif isDefined('form.SEID') and form.SEID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_SampleArchive where ID = #form.SEID#
        </cfquery>
    </cfif>

    <!--- Ancillary Diagnostics --->
    <cfif isDefined('form.AD_ID') and form.AD_ID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_Ancillary_Diagnostics where ID = #form.AD_ID#
        </cfquery>
    </cfif>

    <!--- Necropsy --->
    <cfif isDefined('form.Nfieldnumber') and form.Nfieldnumber neq "">        
        <!--- <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_CetaceanNecropsyReport where Fnumber = #form.Nfieldnumber#
        </cfquery> --->
        <cfset qgetLiveCetaceanExam.Fnumber = form.Nfieldnumber>
    </cfif>
    
    <!--- Morphometrics --->
    <cfif isDefined('form.Morphometrics_ID') and form.Morphometrics_ID neq "">        
        <cfquery name="qgetLiveCetaceanExam" datasource="#Application.dsn#">
            SELECT Fnumber from ST_Morphometrics where ID = #form.Morphometrics_ID#
        </cfquery>
    </cfif>


    <!--- start for CetaceanExam --->
    <cfquery name="qgetCetaceanExamDataByfn" datasource="#Application.dsn#" maxRows = "1">
        SELECT ID from ST_LiveCetaceanExam where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
    </cfquery>

    <cfif isDefined('qgetCetaceanExamDataByfn.ID') and qgetCetaceanExamDataByfn.ID neq "">
        <cfset form.LCEID = qgetCetaceanExamDataByfn.ID>
        <cfset form.CeteacenSelect = "#qgetCetaceanExamDataByfn.ID#">
    <cfelse>
        <cfset form.LCEID = ''>
        <cfset form.CeteacenSelect = ''>
    </cfif>

    <cfif (isDefined('form.LCEID') and form.LCEID neq "")>
  
        <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <!--- <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate(argumentCollection="#Form#")> --->
        <!--- <cfset form.NRD = qLCEDataa.Fnumber> --->
        <!--- <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate(#form.LCEID#)> --->
        <!--- <cfdump var="#qgetcetaceanDate.CNRDATE#" abort="true"> --->
        <!--- <cfif #qLCEData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qLCEData.species#")>
        </cfif> --->
        <cfset qgetHeartData = Application.Stranding.getHeartData(LCEID="#form.LCEID#")>
        <cfset qgetRespData = Application.Stranding.getRespData(LCEID="#form.LCEID#")>
        <cfset qgetDrugData = Application.Stranding.getDrugData(LCEID="#form.LCEID#")>
        <cfset qgetBiopsyData = Application.Stranding.getBiopsyData(LCEID="#form.LCEID#")>
        <cfset qgetLesionData = Application.Stranding.getLesionData(LCEID="#form.LCEID#")>
        <cfset qgetNewSectionData = Application.Stranding.getNewSectionData(LCEID="#form.LCEID#")>
    <!--- <cfelse>
        <!--- <cfset qgetcetaceanDate=Application.Stranding.getcetaceanNecropsyDate_ten()> --->
        <cfset qLCEData=Application.Stranding.getLCE_ten()>
        <cfset qLCEDataa=Application.Stranding.getLCE_ten()> --->
    </cfif>

    <!--- end for CetaceanExam --->
   <!--- for Hi form --->
    <cfquery name="qgetHIFOrmDataByfn" datasource="#Application.dsn#" maxRows = "1">
        SELECT ID from ST_HIForm where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
    </cfquery>

    <cfif isDefined('qgetHIFOrmDataByfn.ID') and qgetHIFOrmDataByfn.ID neq "">
        <cfset form.HI_ID = qgetHIFOrmDataByfn.ID>
    <cfelse>
        <cfset form.HI_ID = ''>
    </cfif>


        <!---   getting data on the basis of HI_ID  --->
    <!--- <cfif  isDefined('form.HI_ID') and form.HI_ID neq ""> --->
        <cfif (isDefined('form.HI_ID') and form.HI_ID neq "") or (isDefined('form.LCE_HIID') and form.LCE_HIID neq '0')>

            <cfset form.LCEID = form.HI_ID>
            
            <cfset qgetHIData=Application.Stranding.getHIData("#form.LCEID#")>
            <!--- <cfset qgetcetaceanDate=Application.Stranding.getHIFormNecropsyDate(#form.LCEID#)>

            <cfif #qgetHIData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
            </cfif> --->

            <cfset qgetHiExamData = Application.Stranding.getHiExamData(LCEID="#form.LCEID#")>
        </cfif>
    <!--- for Hi form --->

    <!--- start for level a form --->
        <cfquery name="qgetLevelAFormDataByfn" datasource="#Application.dsn#" maxRows = "1">
            SELECT ID from ST_LevelAForm where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
        </cfquery>

        <cfif isDefined('qgetLevelAFormDataByfn.ID') and qgetLevelAFormDataByfn.ID neq "">
            <cfset form.LA_ID = qgetLevelAFormDataByfn.ID>
        <cfelse>
            <cfset form.LA_ID = ''>
        </cfif>
            
        <cfif  isDefined('form.LA_ID') and form.LA_ID neq "">

            <cfset form.LCEID = form.LA_ID>
            <cfset qgetLevelAData=Application.Stranding.getLevelAData("#form.LCEID#")>
            <!--- <cfset qgetcetaceanDate=Application.Stranding.getLevelAFormNecropsyDate(#form.LA_ID#)> --->
            <!--- <cfdump var="#qgetLevelAData#" abort="true"> --->
            <!--- <cfif #qgetLevelAData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetLevelAData.species#")>
            </cfif> --->
        </cfif>
    <!--- end for level a form --->
    <!--- strat for Histopathology--->
        <cfquery name="qgetHistopathologyDataByfn" datasource="#Application.dsn#" maxRows = "1">
            SELECT ID from ST_HistoForm where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
        </cfquery>

        <cfif isDefined('qgetHistopathologyDataByfn.ID') and qgetHistopathologyDataByfn.ID neq "">
            <cfset form.His_ID = qgetHistopathologyDataByfn.ID>
        <cfelse>
            <cfset form.His_ID = ''>
        </cfif>

        <!---   getting data on the basis of His_ID  --->
        <cfif  isDefined('form.His_ID') and form.His_ID neq "">

            <cfset form.LCEID = form.His_ID>
            <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
            <cfset qgetHIDataa=Application.Stranding.getHistoData("#form.LCEID#")>

            <!--- <cfset qgetcetaceanDate=Application.Stranding.getHistopathologyNecropsyDate(#form.His_ID#)> --->
            <cfset qgetHistoSampleData = Application.Stranding.getHistoSampleData(HI_ID="#form.LCEID#")>
            <!--- <cfif #qgetHIDataa.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIDataa.species#")>
            </cfif> --->
        </cfif>

    <!--- end for Histopathology --->
    
    <!--- start for blood value --->
    <cfquery name="qgetBloodValueDataByfn" datasource="#Application.dsn#" maxRows = "1">
        SELECT ID from ST_Blood_Values where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
    </cfquery>

    <cfif isDefined('qgetBloodValueDataByfn.ID') and qgetBloodValueDataByfn.ID neq "">
        <cfset form.bloodValue_ID = qgetBloodValueDataByfn.ID>
    <cfelse>
        <cfset form.bloodValue_ID = ''>
    </cfif>
    
    <cfif isDefined('form.bloodValue_ID') and form.bloodValue_ID NEQ ''> 
        <cfset form.LCEID = "#form.bloodValue_ID#">
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetBloodValueData=Application.Stranding.getBlood_VData("#form.LCEID#")>
     

        <cfset form.bloodID = "#form.bloodValue_ID#" >
        <cfset qgetCBC_Data=Application.Stranding.getCBC_Data("#form.bloodID#")>
        <cfset qgetFibrinogen=Application.Stranding.getFibrinogen("#form.bloodID#")>
        <cfset qgetchemistry=Application.Stranding.getchemistry("#form.bloodID#")>
        <cfset qgetCapillary=Application.Stranding.getCapillary("#form.bloodID#")>
        <cfset qgetDolphin=Application.Stranding.getDolphin("#form.bloodID#")>
        <cfset qgetiSTAT_Chem=Application.Stranding.getiSTAT_Chem("#form.bloodID#")>
        <cfset qgetiSTAT_CG4=Application.Stranding.getiSTAT_CG4("#form.bloodID#")>
    </cfif>

    <!--- end for blood value --->
    
    <!--- start for texcology --->
      <cfquery name="qgetToxicologyDataByfn" datasource="#Application.dsn#" maxRows = "1">
        SELECT ID from ST_Toxicology where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
    </cfquery>

    <cfif isDefined('qgetToxicologyDataByfn.ID') and qgetToxicologyDataByfn.ID neq "">
        <cfset form.Toxicology_ID = qgetToxicologyDataByfn.ID>
    <cfelse>
        <cfset form.Toxicology_ID = ''>
    </cfif>

    <cfif isDefined('form.Toxicology_ID') and form.Toxicology_ID NEQ ''>
        <cfset form.Toxicology_ID = #form.Toxicology_ID#>
        <cfset qgetToxicologyData=Application.Stranding.gettoxiform("#form.Toxicology_ID#")>
      
            <cfset TissueTypeForTable =Application.Stranding.getTissueTypeForTable(#form.Toxicology_ID#)>
        <cfif isdefined('form.Tissue_type') and form.Tissue_type neq "">
            <cfset qgetToxitype=Application.Stranding.getToxitype("#form.Tissue_type#,#form.TX_ID#")>
            <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype("#form.Tissue_type#")>
        </cfif>        
    </cfif>

    <!--- end for texcology --->
    <!--- start for Ancillary --->
    <cfquery name="qgetAncillaryDataByfn" datasource="#Application.dsn#" maxRows = "1">
        SELECT ID from ST_Ancillary_Diagnostics where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
    </cfquery>

    <cfif isDefined('qgetAncillaryDataByfn.ID') and qgetAncillaryDataByfn.ID neq "">
        <cfset form.AD_ID = qgetAncillaryDataByfn.ID>
    <cfelse>
        <cfset form.AD_ID = ''>
    </cfif>

    <cfif  isDefined('form.AD_ID') and form.AD_ID neq "">

        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetAncillaryData=Application.Stranding.getAncillaryData("#form.AD_ID#")>
        <!--- <cfset qgetcetaceanDate=Application.Stranding.getAncillaryDiagnosticsNecropsyDate(#form.AD_ID#)>
        <cfif #qgetAncillaryData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetAncillaryData.species#")>
        </cfif> --->
        <cfset qAncillaryReportGet=Application.Stranding.AncillaryReportGet("#form.AD_ID#")>
    </cfif>

    <!--- end for Ancillary --->

    <!--- start for NecropsyReport --->
        <cfquery name="qgetNecropsyReportDataByfn" datasource="#Application.dsn#" maxRows = "1">
            SELECT ID from ST_CetaceanNecropsyReport where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
        </cfquery>

        <cfif isDefined('qgetNecropsyReportDataByfn.ID') and qgetNecropsyReportDataByfn.ID neq "">
            <cfset form.Nfieldnumber = qgetLiveCetaceanExam.Fnumber>
        <cfelse>
            <cfset form.Nfieldnumber = ''>
        </cfif>

        <cfif isDefined('form.Nfieldnumber') and Nfieldnumber neq "">

            <cfset form.field = form.Nfieldnumber>
            <!--- <cfdump var="#form.field#">--->
                <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.field#")>          
                <!--- <cfset qLCEDataa=Application.Stranding.getCetaceanNecropsy("#form.field#")>
                <cfset qgetcetaceanDate.CNRDATE= qLCEDataa.CNRDATE> --->
                <!--- <cfdump var="#qLCEDataa#"><cfabort>  --->
            <cfset qgetAllData=Application.Stranding.getAllData("#form.field#")>
            
            <cfset qgetNutritional=Application.Stranding.getNutritional("#form.field#")>     
        
    
            <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular("#form.field#")>
            <!--- <cfdump var="#qgetLymphoreticular#" abort="true"> --->
            <cfset qgetParasites=Application.Stranding.getParasites("#form.field#")>
            <!--- <cfif #qgetCetaceanNecropsy.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetCetaceanNecropsy.species#")>
                
            </cfif>
            <cfif isDefined('qgetAllData.species') and #qgetAllData.species# neq "">
                <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetAllData.species#")>
                
                <!--- <cfdump var="#getCetaceansCode#"><cfabort> --->
            </cfif> --->
        <!--- <cfelse>
            <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy_ten()>
            <cfset qgetNutritional=Application.Stranding.getNutritional_ten()>
            <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular_ten()>
            <cfset qgetParasites=Application.Stranding.getParasites_ten()> --->
           
        </cfif>

    <!--- end for NecropsyReport --->
    <!--- start for Morpho --->
    <cfquery name="qgetMorphometricsDataByfn" datasource="#Application.dsn#" maxRows = "1">
        SELECT ID from ST_Morphometrics where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
    </cfquery>

    <cfif isDefined('qgetMorphometricsDataByfn.ID') and qgetMorphometricsDataByfn.ID neq "">
        <cfset form.Morphometrics_ID = qgetMorphometricsDataByfn.ID>
    <cfelse>
        <cfset form.Morphometrics_ID = ''>
    </cfif>

    
   <!---   getting data on the basis of HI_ID  --->
   <cfif  isDefined('form.Morphometrics_ID') and form.Morphometrics_ID neq "">

  
        <cfset qgetMorphometricsData=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>
    <!--- <cfdump var="#qgetMorphometricsData#" abort="true"> --->
    <!--- <cfset qLCEDataa=Application.Stranding.getMorphometricsAllData("#form.Morphometrics_ID#")>  --->
    <!--- <cfset qgetcetaceanDate=Application.Stranding.getMorphometricsNecropsyDate(#form.Morphometrics_ID#)>
    <cfif #qgetMorphometricsData.species# neq "">
        <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetMorphometricsData.species#")>
    </cfif> --->
</cfif>

    <!--- end for Morpho --->


    <!---start for sample Archive --->
    <!--- <cfquery name="qgetSampleDataByLCE" datasource="#Application.dsn#" maxRows = "1">
        SELECT ID from ST_SampleArchive where Fnumber = '#qgetLiveCetaceanExam.Fnumber#'
    </cfquery>


    <cfif isDefined('qgetSampleDataByLCE.ID') and qgetSampleDataByLCE.ID neq "">
        <cfset form.SEID = qgetSampleDataByLCE.ID>
    <cfelse>
        <cfset form.SEID = ''>
    </cfif>

    <!--- <cfdump var="#qgetSampleDataByLCE.ID#" abort="true">--->

    <cfif isDefined('form.SEID') and form.SEID neq "">
    <cfset qgetSampleData=Application.Stranding.getSampleArchiveData("#form.SEID#")>
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
    <!--- <cfelse>
        <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleType_ten()>  --->
    </cfif>
    <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate(#form.SEID#)>
</cfif> --->
    <!--- <cfdump var="#qgetcetaceanDate.CNRDATE#" abort="true">/ --->
<!--- <cfelse>
    <cfset qgetSampleTypeIByID=Application.Stranding.getSampleType_ten()>
    <cfset qgetSampleTypeDataSingle = #qgetSampleTypeIByID#>  --->
<!---End for sample Archive --->



</cfif>

<!--- end data for all header --->





     <!--- import for Morphomatric --->
     <cfif structKeyExists(form, "MorphometricsFile") and len(form.MorphometricsFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="MorphometricsFile" result="upload" nameconflict="makeunique">
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

                <!--- <cfdump var="#colNameArray#" abort="true"> --->
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <!--- <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script> --->
                <cfelseif arrayContains(colNameArray, 'Weight') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Weight" ');
                    </script>
                <!--- <cfelseif arrayContains(colNameArray, 'Weight Estimated/Actual') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Weight Estimated/Actual" ');
                    </script> --->
                <cfelseif arrayContains(colNameArray, 'Total Length (1)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Total Length (1)" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Length Estimated/Actual') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Length Estimated/Actual" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Rostrum to Dorsal Fin (2)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Rostrum to Dorsal Fin (2)" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Blowhole to Dorsal (3)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Blowhole to Dorsal (3)" ');
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
                 <cfelseif arrayContains(colNameArray, 'Fluke Width (4)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Fluke Width (4)" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Girth- Cervical (5)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Girth- Cervical (5)" ');
                    </script>  
                <cfelseif arrayContains(colNameArray, 'Girth- Axillary (6)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Girth- Axillary (6)" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Girth- Maximum (7)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Girth- Maximum (7)" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Blubber Mid-Dorsal') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Blubber Mid-Dorsal" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Blubber Mid-Lateral') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Blubber Mid-Lateral" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Blubber Mid-Ventral') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Blubber Mid-Ventral" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Tooth Upper Left') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Tooth Upper Left" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Tooth Upper Right') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Tooth Upper Right" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Tooth Lower Left') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Tooth Lower Left" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Tooth Lower Left') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Tooth Lower Left" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('/','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('-','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(1)','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(2)','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(3)','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(4)','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(5)','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(6)','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(7)','') />
                    </cfloop>
                    <!--- <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('##','') />
                    </cfloop> --->
                    <cfset data.setColumnNames(colNameArray) />

                    
                    <cfoutput query="data" startRow="2">

                        <cfquery name="qcheckMorphoFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_Morphometrics
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckMorphoFnumber.Fnumber') and qcheckMorphoFnumber.Fnumber neq ''>
                            <!--- <cfdump var="exist" abort="true"> --->
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_Morphometrics set 
                                EstimatedWeight = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Weight#'>
                                ,weight_values = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.WEIGHTESTIMATEDACTUAL#'> 
                                ,totalLength = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TOTALLENGTH#'> 
                                ,blowhole = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLOWHOLETODORSAL#'> 
                                ,lengthWeight_values = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.LENGTHESTIMATEDACTUAL#'> 
                                ,rostrum = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ROSTRUMTODORSALFIN#'> 
                                ,girth = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIRTHCERVICAL#'> 
                                ,fluke = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FLUKEWIDTH#'> 
                                ,axillary = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIRTHAXILLARY#'> 
                                ,maxium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIRTHMAXIMUM#'> 
                                ,blubber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLUBBERMIDDORSAL#'> 
                                ,midlateral = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLUBBERMIDLATERAL#'> 
                                ,midVentral = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLUBBERMIDVENTRAL#'> 
                                ,Lateralupperleft = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothUpperLeft#'> 
                                ,Laterallowerleft = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothLowerLeft#'> 
                                ,Ventralupperleft = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothUpperRight#'> 
                                ,Ventrallowerright = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothLowerRight#'> 

                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckMorphoFnumber.ID#'>
                            </cfquery>
                        <cfelse>
                                 
                       <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_Morphometrics
                            (
                            Fnumber
                            ,EstimatedWeight
                            ,weight_values
                            ,totalLength
                            ,blowhole   
                            ,lengthWeight_values                         
                            ,rostrum
                            ,girth    
                            ,fluke                     
                            ,axillary                     
                            ,maxium                     
                            ,blubber                     
                            ,midlateral                     
                            ,midVentral                     
                            ,Lateralupperleft                     
                            ,Laterallowerleft
                            ,Ventralupperleft  
                            ,Ventrallowerright                   
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Weight#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.WEIGHTESTIMATEDACTUAL#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TOTALLENGTH#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLOWHOLETODORSAL#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.LENGTHESTIMATEDACTUAL#'>                    
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ROSTRUMTODORSALFIN#'>                       
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIRTHCERVICAL#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FLUKEWIDTH#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIRTHAXILLARY#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIRTHMAXIMUM#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLUBBERMIDDORSAL#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLUBBERMIDLATERAL#'>                        
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BLUBBERMIDVENTRAL#'>                        
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothUpperLeft#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothLowerLeft#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothUpperRight#'>                         
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ToothLowerRight#'>                         
                            )
                        </cfquery>

                        </cfif>
                        

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
     <!--- Morphometric import end --->
     <!--- import for Level A Form --->
     <cfif structKeyExists(form, "LevelAsampleSpecialFile") and len(form.LevelAsampleSpecialFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="LevelAsampleSpecialFile" result="upload" nameconflict="makeunique">
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

                <!--- <cfdump var="#colNameArray#" abort="true"> --->
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Initial Live Animal Disposition (Level A)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Initial Live Animal Disposition (Level A)" ');
                    </script>
              
                <cfelseif arrayContains(colNameArray, 'Carcass Status (Level A)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Carcass Status (Level A)" ');
                    </script>     
                
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('/','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(LevelA)','') />
                    </cfloop> 
                    <cfset data.setColumnNames(colNameArray) />

                     <!--- <cfdump var="#data#"abort="true">  --->

                    <cfoutput query="data" startRow="2">
                                               
                         <!---  Level A Form ---> 
                        <cfquery name="qcheckLAFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_LevelAForm
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckLAFnumber.Fnumber') and qcheckLAFnumber.Fnumber neq ''>

                        <cfloop query="qcheckLAFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_LevelAForm set 
                                ILAD = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.INITIALLIVEANIMALDISPOSITION#'>
                                ,CarcassStatus = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CARCASSSTATUS#'> 
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckLAFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_LevelAForm
                                (
                                Fnumber
                                ,ILAD
                                ,CarcassStatus                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.INITIALLIVEANIMALDISPOSITION#'>
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CARCASSSTATUS#'> 
                                                        
                                )
                            </cfquery>
                      
                        </cfif>
                

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
<!--- end for Level A form ---> 
     <!--- import for Special HIForm --->
     <cfif structKeyExists(form, "HIsampleSpecialFile") and len(form.HIsampleSpecialFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="HIsampleSpecialFile" result="upload" nameconflict="makeunique">
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

                <!--- <cfdump var="#colNameArray#" abort="true"> --->
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'HI Findings (Y/N/CBD/Blank)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "HI Findings (Y/N/CBD/Blank)" ');
                    </script>
              
                <cfelseif arrayContains(colNameArray, 'Type of HI') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Type of HI" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Location of HI') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location of HI" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Type of Gear Collected') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Type of Gear Collected" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Gear Collected') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Gear Collected" ');
                    </script>     
                
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('/','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(YNCBD','') />
                    </cfloop>                    
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace(')','') />
                    </cfloop> 
                    <cfset data.setColumnNames(colNameArray) />

                     
                    <cfoutput query="data" startRow="2">    
                        <!---  HIForm ---> 
                    <cfquery name="qcheckHIformFnumber" datasource="#Application.dsn#">
                        SELECT ID,Fnumber FROM ST_HIForm
                        WHERE Fnumber ='#data.FieldNumber#'
                    </cfquery>

                    <cfif data.GEARCOLLECTED neq '' AND data.GEARCOLLECTED eq 'TRUE'>
                        <cfset gearCollected = 'Yes'>
                    <cfelse>
                        <cfset gearCollected = 'No'>
                    </cfif>
                    <cfif isDefined('qcheckHIformFnumber.Fnumber') and qcheckHIformFnumber.Fnumber neq ''>

                    <cfloop query="qcheckHIformFnumber">
                        <cfquery name="qUpdateHiFormData" datasource="#Application.dsn#" result="qUpdateHiFormDataa">
                            Update  ST_HIForm set 
                            Hifindings = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HIFINDINGSBLANK#'>
                            where
                            ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckHIformFnumber.ID#'>
                        </cfquery>

                    <cfquery name="qcheckDynamicHIFnumber" datasource="#Application.dsn#">
                        SELECT ID,HI_ID FROM ST_DynamicHI
                        WHERE HI_ID ='#qcheckHIformFnumber.ID#'
                    </cfquery>
                    <cfif isDefined('qcheckDynamicHIFnumber.HI_ID') and qcheckDynamicHIFnumber.HI_ID neq ''>
                        <cfquery name="qUpdateDynamicHIData" datasource="#Application.dsn#" result="qUpdateDynamicHIDataa">
                            Update  ST_DynamicHI set 
                            TypeofHI = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TYPEOFHI#'>
                            ,LocationofHI = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.LOCATIONOFHI#'>
                            ,GearCollected = <cfqueryparam cfsqltype="cf_sql_varchar" value='#gearCollected#'>
                            ,TypeofGearCollected = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TYPEOFGEARCOLLECTED#'>
                            where
                            HI_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckHIformFnumber.ID#'>
                        </cfquery>
                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_DynamicHI
                                (
                                    TypeofHI
                                    ,LocationofHI
                                    ,GearCollected
                                    ,TypeofGearCollected
                                    ,HI_ID                                                           
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TYPEOFHI#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.LOCATIONOFHI#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#gearCollected#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TYPEOFGEARCOLLECTED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qcheckHIformFnumber.ID#'>   
                                )
                            </cfquery>
                    </cfif>

                    </cfloop>
                <!--- end update --->
                    <cfelse>
                        <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_HIForm
                            (
                            Fnumber   
                            ,Hifindings                                                        
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HIFINDINGSBLANK#'>   
                            )
                        </cfquery>
                        <cfset HI_ID = "#return_data.generatedkey#">
                       <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_DynamicHI
                            (
                                TypeofHI
                                ,LocationofHI
                                ,GearCollected
                                ,TypeofGearCollected
                                ,HI_ID                                                           
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TYPEOFHI#'>   
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.LOCATIONOFHI#'>   
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#gearCollected#'>   
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TYPEOFGEARCOLLECTED#'>   
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#HI_ID#'>   
                            )
                        </cfquery>
                 
                    
                    </cfif>                
             

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
<!--- HiForm Import end ---> 
     <!--- import for Special histo --->
     <cfif structKeyExists(form, "HistosampleSpecialFile") and len(form.HistosampleSpecialFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="HistosampleSpecialFile" result="upload" nameconflict="makeunique">
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

                <!--- <cfdump var="#colNameArray#" abort="true"> --->
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Histopathology Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Histopathology Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Pathologist Accession Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Pathologist Accession Number');
                    </script>       
                <cfelseif arrayContains(colNameArray, 'Remarks') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Remarks');
                    </script>     
                
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                  
                    <cfset data.setColumnNames(colNameArray) />

                    
                    <cfoutput query="data" startRow="2">
                                               
                        <!---  Histo ---> 
                       <cfquery name="qcheckHistoFnumber" datasource="#Application.dsn#">
                           SELECT ID,Fnumber FROM ST_HistoForm
                           WHERE Fnumber ='#data.FieldNumber#'
                       </cfquery>

                       <cfif isDefined('qcheckHistoFnumber.Fnumber') and qcheckHistoFnumber.Fnumber neq ''>
                        <!--- <cfdump var="update" abort="true"> --->
                        <!--- <cfif isDefined('data.HISTOPATHOLOGYDATE') and data.HISTOPATHOLOGYDATE neq ''>
                            <cfset histoDate = data.HISTOPATHOLOGYDATE>
                        <cfelse>
                            <cfset histoDate = '0000-00-00'>
                        </cfif> --->
                       <cfloop query="qcheckHistoFnumber">

                           <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                               Update  ST_HistoForm set 
                               histoDate = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HISTOPATHOLOGYDATE#'>
                               ,PathologistAccession = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.PATHOLOGISTACCESSIONNUMBER#'> 
                               ,SampleComments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.REMARKS#'> 
                               where
                               ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckHistoFnumber.ID#'>
                           </cfquery>
                       </cfloop>

                       <cfelse>
                        <!--- <cfdump var="insert" abort="true"> --->
                           <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                               INSERT INTO ST_HistoForm
                               (
                               Fnumber
                               ,histoDate
                               ,PathologistAccession
                               ,SampleComments                                   
                               ) 
                               VALUES
                               (
                               <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                               ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HISTOPATHOLOGYDATE#'>
                               ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.PATHOLOGISTACCESSIONNUMBER#'> 
                               ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.REMARKS#'> 
                                                       
                               )
                           </cfquery>
                     
                       </cfif>              

                    
                   </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
   <!--- Scond file for histo --->
   <cfif structKeyExists(form, "HistosampleSpecialFilee") and len(form.HistosampleSpecialFilee)>
    <cfset dest = getTempDirectory()>
    <cffile action="upload" destination="#dest#" filefield="HistosampleSpecialFilee" result="upload" nameconflict="makeunique">
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

            <!--- <cfdump var="#colNameArray#" abort="true"> --->
            <cfif arrayContains(colNameArray, 'Field Number') eq false>
                <script>
                    alert('The Column name in the sheet should be "Field Number" ');
                </script>
            <cfelseif arrayContains(colNameArray, 'organ') eq false>
                <script>
                    alert('The Column name in the sheet should be "organ" ');
                </script>
          
            <cfelseif arrayContains(colNameArray, 'diaglab') eq false>
                <script>
                    alert('The Column name in the sheet should be "diaglab" ');
                </script>     
            <cfelseif arrayContains(colNameArray, 'results') eq false>
                <script>
                    alert('The Column name in the sheet should be "results" ');
                </script>     
                      
            <cfelse>
                <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                    <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                </cfloop>
               
                <cfset data.setColumnNames(colNameArray) />

                <!--- <cfdump var="#data#" abort="true"> --->
                <cfoutput query="data" startRow="2">    
               <!---  second file of histopathology ---> 
               <!--- insert master data start --->
                <cfquery name="qcheckSampleTypee" datasource="#Application.dsn#">
                    SELECT ID,type FROM TLU_Sample_Type
                    WHERE type ='#data.organ#'
                </cfquery>
                <cfif isDefined('qcheckSampleTypee.type') and qcheckSampleTypee.type eq ''>
                    <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                        INSERT INTO TLU_Sample_Type
                        (
                            type                          
                            ,status                                                           
                        ) 
                        VALUES
                        (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.organ#'>   
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='1'>  
                        )
                    </cfquery>
                </cfif>
                <cfquery name="qcheckDiagnosticLab" datasource="#Application.dsn#">
                    SELECT ID,Diagnostic FROM TLU_Diagnostic_Lab
                    WHERE Diagnostic ='#data.DIAGLAB#'
                </cfquery>
                <cfif isDefined('qcheckDiagnosticLab.Diagnostic') and qcheckDiagnosticLab.Diagnostic eq ''>
                    <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                        INSERT INTO TLU_Diagnostic_Lab
                        (
                            Diagnostic                          
                            ,status                                                           
                        ) 
                        VALUES
                        (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.DIAGLAB#'>   
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='1'>  
                        )
                    </cfquery>
                </cfif>

                <!--- insert master data end --->

                <cfquery name="qcheckHIformFnumber" datasource="#Application.dsn#">
                    SELECT ID,Fnumber FROM ST_HistoForm
                    WHERE Fnumber ='#data.FieldNumber#'
                </cfquery>

                <cfif isDefined('qcheckHIformFnumber.Fnumber') and qcheckHIformFnumber.Fnumber neq ''>
                    
                <cfloop query="qcheckHIformFnumber">
     
                <cfquery name="qcheckDynamicHIstoIdFnumber" datasource="#Application.dsn#">
                    SELECT ID,Fnumber FROM ST_HistoForm
                    WHERE Fnumber ='#data.FieldNumber#'
                </cfquery>


                <!--- <cfquery name="qcheckDynamicHIFnumber" datasource="#Application.dsn#">
                    SELECT ID,HI_ID FROM ST_HistoSampleData
                    WHERE HI_ID ='#qcheckDynamicHIstoIdFnumber.ID#'
                </cfquery> --->
             <!--- <cfdump var="#qcheckDynamicHIFnumber#" abort="true"> --->

                <!--- <cfif isDefined('qcheckDynamicHIFnumber.HI_ID') and qcheckDynamicHIFnumber.HI_ID neq ''>
                    <cfquery name="qUpdateDynamicHIData" datasource="#Application.dsn#" result="qUpdateDynamicHIDataa">
                        Update  ST_HistoSampleData set 
                        SampleType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.organ#'>
                        ,DiagnosticLab = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.DIAGLAB#'>
                        ,SampleNote = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.RESULTS#'>
                        where
                        HI_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckDynamicHIFnumber.ID#'>
                    </cfquery>


                <cfelse>                         --->
                    <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                        INSERT INTO ST_HistoSampleData
                        (
                            SampleType
                            ,DiagnosticLab
                            ,SampleNote
                            ,HI_ID                                                           
                        ) 
                        VALUES
                        (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.organ#'>   
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.DIAGLAB#'>   
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.RESULTS#'>     
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qcheckDynamicHIstoIdFnumber.ID#'>   
                        )
                    </cfquery>
                <!--- </cfif> --->

                </cfloop>
            <!--- end update --->
                <cfelse>
                    <!--- <cfdump var="insert" abort="true"> --->
                    <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                        INSERT INTO ST_HistoForm
                        (
                        Fnumber                                                          
                        ) 
                        VALUES
                        (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>     
                        )
                    </cfquery>
                    <cfset HI_ID = "#return_data.generatedkey#">
                   <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                        INSERT INTO ST_HistoSampleData
                        (
                            SampleType
                            ,DiagnosticLab
                            ,SampleNote
                            ,HI_ID                                                           
                        ) 
                        VALUES
                        (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.organ#'>   
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.DIAGLAB#'>   
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.RESULTS#'>     
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#HI_ID#'>   
                        )
                    </cfquery>
             
                
                </cfif>                
         
                 
                </cfoutput>
            </cfif>    
        </cfif>    
    </cfif>
</cfif>
   <!--- Scond file for histo --->
<!--- Histo Import end ---> 
     <!--- import for Special Header --->
     <cfif structKeyExists(form, "CetaceanSpecialFile") and len(form.CetaceanSpecialFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="CetaceanSpecialFile" result="upload" nameconflict="makeunique">
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

                <!--- <cfdump var="#colNameArray#" abort="true"> --->
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <!--- <cfelseif arrayContains(colNameArray, 'Additional Identifier') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Additional Identifier" ');
                    </script> --->
              
                <!--- <cfelseif arrayContains(colNameArray, 'Initial Condition') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Initial Condition" ');
                    </script>      --->
                <!--- <cfelseif arrayContains(colNameArray, 'FINAL CONDITION') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Final Condition" ');
                    </script>--->
                <cfelseif arrayContains(colNameArray, 'CODE') eq false>
                    <script>
                        alert('The Column name in the sheet should be "CODE" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'HERA/FB no.') eq false>
                    <script>
                        alert('The Column name in the sheet should be "HERA/FB no." ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Euthanized (Check Box)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Euthanized (Check Box)" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Necropsy Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Necropsy Date" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Actual Age') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Actual Age" ');
                    </script>     
                
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('/','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('.','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(CheckBox)','') />
                    </cfloop> 
                    <cfset data.setColumnNames(colNameArray) />

                    <!---  cetecan--->
                    <cfoutput query="data" startRow="2"> 
                        <cfif isDefined('data.INITIALCONDITION') and data.INITIALCONDITION NEQ ''>
                            <cfif data.INITIALCONDITION eq '1'>
                                <cfset initialcodition = 'Alive'> 
                            <cfelseif data.INITIALCONDITION eq '2'>
                                <cfset initialcodition = 'Fresh Dead'> 
                            <cfelseif data.INITIALCONDITION eq '3'>
                                <cfset initialcodition = 'Moderately Decomposed'> 
                            <cfelseif data.INITIALCONDITION eq '4'>
                                <cfset initialcodition = 'Advanced Composition'> 
                            <cfelseif data.INITIALCONDITION eq '5'>
                                <cfset initialcodition = 'Mummified'> 
                            </cfif>    
                        <cfelse>
                            <cfset initialcodition = ''>
                        </cfif>
                        <cfif isDefined('data.FINALCONDITION') and data.FINALCONDITION NEQ '' >
                            <cfif data.FINALCONDITION eq '1'>
                                <cfset Finalcodition = 'Alive'> 
                            <cfelseif data.FINALCONDITION eq '2'>
                                <cfset Finalcodition = 'Fresh Dead'> 
                            <cfelseif data.FINALCONDITION eq '3'>
                                <cfset Finalcodition = 'Moderately Decomposed'> 
                            <cfelseif data.FINALCONDITION eq '4'>
                                <cfset Finalcodition = 'Advanced Composition'> 
                            <cfelseif data.FINALCONDITION eq '5'>
                                <cfset Finalcodition = 'Mummified'> 
                            </cfif>  
                        <cfelse>
                            <cfset Finalcodition = ''>
                        </cfif>
                        <cfif isDefined('data.EUTHANIZED') and data.EUTHANIZED NEQ '' >
                            <cfif data.EUTHANIZED eq 'TRUE'>
                                <cfset EUTHANIZED = '1'>
                            <cfelse>
                                <cfset EUTHANIZED = '0'>
                            </cfif>
                        </cfif>
                        
                        <!---  CetaceanExam ---> 
                        <!--- <cfquery name="qcheckFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_LiveCetaceanExam
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>
                        
                        <cfif isDefined('qcheckFnumber.Fnumber') and qcheckFnumber.Fnumber neq ''>

                        <cfloop query="qcheckFnumber">
                        <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                            Update  ST_LiveCetaceanExam set 
                            affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                            ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                            ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                            ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                            ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                            ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                            where
                            ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckFnumber.ID#'>
                        </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_LiveCetaceanExam
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif> --->

                        <!---  HIform ---> 
                         <!--- <cfquery name="qcheckHiFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_HIForm
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckHiFnumber.Fnumber') and qcheckHiFnumber.Fnumber neq ''>

                        <!--- <cfdump var="#qcheckHiFnumber#" abort="true"> --->
                        <cfloop query="qcheckHiFnumber">
                        <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                            Update  ST_HIForm set 
                            affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                            ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                            ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                            ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                            ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                            ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                            where
                            ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckHiFnumber.ID#'>
                        </cfquery>
                        </cfloop>

                        <cfelse>
                            <!--- <cfdump var="insert" abort="true"> --->
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_HIForm
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif> --->
                
                        <!---  Level A Form ---> 
                        <!--- <cfquery name="qcheckLAFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_LevelAForm
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckLAFnumber.Fnumber') and qcheckLAFnumber.Fnumber neq ''>

                        <cfloop query="qcheckLAFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_LevelAForm set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckLAFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_LevelAForm
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif>
                 --->
                        <!---  Histopathology ---> 
                        <cfquery name="qcheckHisFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_HistoForm
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckHisFnumber.Fnumber') and qcheckHisFnumber.Fnumber neq ''>

                        <cfloop query="qcheckHisFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_HistoForm set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckHisFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_HistoForm
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif>
                        
                        <!---  Blood Value ---> 
                         <!---   <cfquery name="qcheckBVFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_Blood_Values
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckBVFnumber.Fnumber') and qcheckBVFnumber.Fnumber neq ''>

                        <cfloop query="qcheckBVFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_Blood_Values set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckBVFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_Blood_Values
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif>
                        
                        
                        <!---  Toxicology ---> 
                        <cfquery name="qcheckToxiFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_Toxicology
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckToxiFnumber.Fnumber') and qcheckToxiFnumber.Fnumber neq ''>

                        <cfloop query="qcheckToxiFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_Toxicology set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckToxiFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_Toxicology
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif>--->

                        <!---  Ancillary_Diagnostics  ---> 
                        <!--- <cfquery name="qcheckADFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_Ancillary_Diagnostics
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckADFnumber.Fnumber') and qcheckADFnumber.Fnumber neq ''>

                        <cfloop query="qcheckADFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_Ancillary_Diagnostics set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckADFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_Ancillary_Diagnostics
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif>

                        <!---  SampleArchive  ---> 
                        <cfquery name="qcheckSAFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_SampleArchive
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckSAFnumber.Fnumber') and qcheckSAFnumber.Fnumber neq ''>

                        <cfloop query="qcheckSAFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_SampleArchive set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckSAFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_SampleArchive
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery> 
                        </cfif> --->


                        <!---  Necropsy Report ---> 
                        <!--- <cfquery name="qcheckCNFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_CetaceanNecropsyReport
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckCNFnumber.Fnumber') and qcheckCNFnumber.Fnumber neq ''>

                        <cfloop query="qcheckCNFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_CetaceanNecropsyReport set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckCNFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_CetaceanNecropsyReport
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                                                 
                                ,CNRDATE                                                  
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NecropsyDate#'>   
                                )
                            </cfquery> 
                        </cfif>
                

                        <!---  Morphometrics ---> 
                        <cfquery name="qcheckMorphoFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_Morphometrics
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>

                        <cfif isDefined('qcheckMorphoFnumber.Fnumber') and qcheckMorphoFnumber.Fnumber neq ''>

                        <cfloop query="qcheckMorphoFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_Morphometrics set 
                                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>
                                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>
                                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>
                                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>
                                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>
                                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>
                                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckMorphoFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_Morphometrics
                                (
                                Fnumber   
                                ,affiliatedID   
                                ,InitialCondition  
                                ,FinalCondition                                                   
                                ,code                                                   
                                ,hera                                                   
                                ,euthanizedCB                                                   
                                ,actualClass                                                   
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ADDITIONALIDENTIFIER#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#initialcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Finalcodition#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.code#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HERAFBNO#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#EUTHANIZED#'>   
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ACTUALAGE#'>   
                                )
                            </cfquery>
                        </cfif>                                              --->
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
<!--- header Import end ---> 
     <!--- import for Necropsy test--->
     <cfif structKeyExists(form, "NecropsySpecialFile") and len(form.NecropsySpecialFile)>
        <cfset dest = getTempDirectory()>
        <cffile action="upload" destination="#dest#" filefield="NecropsySpecialFile" result="upload" nameconflict="makeunique">
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

                <!--- <cfdump var="#colNameArray#" abort="true"> --->
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Attending Veterninarian') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Attending Veterninarian" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Prosectors') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Prosectors" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Tentative Gross Diagnosis') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Tentative Gross Diagnosis" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Cause of Death') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Cause of Death" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'General Body Condition') eq false>
                    <script>
                        alert('The Column name in the sheet should be "General Body Condition" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Integument Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Integument Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Musculoskeletal System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Musculoskeletal System Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Alimentary Tract Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Alimentary Tract Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Hepatobiliary System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "	Hepatobiliary System Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Cardiovascular System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Cardiovascular System Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Pulmonary System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Pulmonary System Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Urogential System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "	Urogential System Comments" ');
                    </script>              
                <cfelseif arrayContains(colNameArray, 'Endocrine System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Endocrine System Comments" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Lymphoreticular System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lymphoreticular System Comments" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'Central Nervous System Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Central Nervous System Comments" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'GI Foreign Material Type (Necropsy)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "GI Foreign Material Type (Necropsy)" ');
                    </script>     
                <cfelseif arrayContains(colNameArray, 'GI Foreign Material Describe (Necropsy)') eq false>
                    <script>
                        alert('The Column name in the sheet should be "GI Foreign Material Describe (Necropsy)" ');
                    </script>     
                
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace('(Necropsy)','') />
                    </cfloop> 
                    <cfset data.setColumnNames(colNameArray) />

                     <!--- <cfdump var="#data#"abort="true">  --->

                    <cfoutput query="data" startRow="2">
                        <!--- Start team veterinarian --->
                          <!--- for Veterinarian --->
                        <cfif isDefined('data.ATTENDINGVETERNINARIAN') and data.ATTENDINGVETERNINARIAN neq ''>
                            <cfset myarray=[] >
                            <cfloop from="1" to="#ListLen(data.ATTENDINGVETERNINARIAN)#" index="i">
                                <cfset VeterinarianDat = '#data.ATTENDINGVETERNINARIAN#'>
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
                        <cfelse>
                            <cfset myConvertedList= ''>
                        </cfif>
                       <!--- end veterbarian --->
                        <!--- <cfdump var="#myConvertedList#"abort="true">   --->
                       <!--- for teamMember --->
                       <!--- testabc --->
                       <cfif isDefined('data.Prosectors') and data.Prosectors neq ''>
                        <cfset teamMemberArray=[] >
                        <cfloop from="1" to="#ListLen(data.Prosectors)#" index="i">
                            <cfset TeamMemberDat = '#data.Prosectors#'>
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

                        <cfelse>
                            <cfset myConvertedTeamList= ''>
                       </cfif>
                        
                        <!--- end team veterinarian --->
                        <!--- <cfdump var="#myConvertedTeamList#" abort="true">  --->

                         <!--- test Necropsy ---> 
                         <!--- <cfquery name="qgetVeterinarians" datasource="#Application.dsn#" >
                            SELECT * from TLU_Veterinarians
                            where Veterinarians = '#data.ATTENDINGVETERNINARIAN#'
                         </cfquery>
                        <cfquery name="query" datasource="#Application.dsn#">
                            SELECT * FROM TLU_ResearchTeamMembers where RT_MemberName = '#data.Prosectors#'
                        </cfquery> --->
                        <!--- <cfdump var="#myConvertedTeamList#"abort="true">  --->

                        <cfquery name="qcheckNRFnumber" datasource="#Application.dsn#">
                            SELECT ID,Fnumber FROM ST_CetaceanNecropsyReport
                            WHERE Fnumber ='#data.FieldNumber#'
                        </cfquery>
                        <cfif isDefined('qcheckNRFnumber.Fnumber') and qcheckNRFnumber.Fnumber neq ''>

                        <cfloop query="qcheckNRFnumber">
                            <cfquery name="qUpdateNotesData" datasource="#Application.dsn#">
                                Update  ST_CetaceanNecropsyReport set 
                                attendingVeterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedList#'>
                                ,Prosectors = <cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedTeamList#'> 
                                ,Tentative = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TENTATIVEGROSSDIAGNOSIS#'> 
                                ,deathcause = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CAUSEOFDEATH#'> 
                                ,Bodycondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GENERALBODYCONDITION#'> 
                                ,lessiondescribe = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.INTEGUMENTCOMMENTS#'> 
                                ,muscular_comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.MUSCULOSKELETALSYSTEMCOMMENTS#'> 
                                ,hepatobiliary_comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HEPATOBILIARYSYSTEMCOMMENTS#'> 
                                ,cardio_comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CARDIOVASCULARSYSTEMCOMMENTS#'> 
                                ,pulmonary_comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.PULMONARYSYSTEMCOMMENTS#'> 
                                ,UROGENITAL_Comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.UROGENTIALSYSTEMCOMMENTS#'> 
                                ,endocrine_comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ENDOCRINESYSTEMCOMMENTS#'> 
                                ,lympho_comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.LYMPHORETICULARSYSTEMCOMMENTS#'> 
                                ,nervoussystemcomments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CENTRALNERVOUSSYSTEMCOMMENTS#'> 
                                ,GIForeignMaterialType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIFOREIGNMATERIALTYPE#'> 
                                ,InjuryLesionAssociatedContents = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIFOREIGNMATERIALDESCRIBE#'> 
                                ,Parasitecomments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AlimentaryTractComments#'> 
                                where
                                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qcheckNRFnumber.ID#'>
                            </cfquery>
                        </cfloop>

                        <cfelse>
                            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_CetaceanNecropsyReport
                                (
                                Fnumber
                                ,attendingVeterinarian
                                ,Prosectors
                                ,Tentative
                                ,deathcause
                                ,Bodycondition
                                ,lessiondescribe
                                ,muscular_comments
                                ,hepatobiliary_comments
                                ,cardio_comments
                                ,pulmonary_comments
                                ,UROGENITAL_Comments
                                ,endocrine_comments  
                                ,lympho_comments  
                                ,nervoussystemcomments
                                ,GIForeignMaterialType
                                ,InjuryLesionAssociatedContents  
                                ,Parasitecomments                            
                                ) 
                                VALUES
                                (
                                <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedList#'>
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedTeamList#'> 
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TENTATIVEGROSSDIAGNOSIS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CAUSEOFDEATH#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GENERALBODYCONDITION#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.INTEGUMENTCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.MUSCULOSKELETALSYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.HEPATOBILIARYSYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CARDIOVASCULARSYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.PULMONARYSYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.UROGENTIALSYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.ENDOCRINESYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.LYMPHORETICULARSYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.CENTRALNERVOUSSYSTEMCOMMENTS#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIFOREIGNMATERIALTYPE#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GIFOREIGNMATERIALDESCRIBE#'>  
                                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AlimentaryTractComments#'>  
                                                        
                                )
                            </cfquery>
                      
                        </cfif>
                                    
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
<!--- end for NecropsyReport ---> 
    
    
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
                <input type='hidden' name='form_examid' id="form_examid" value='#form.LCEID#'>
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
               <!--- <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myCetaceanExamDateform">
                        <label for="sel1">Search Cetacean Exam By Date:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LCEID" onChange="cetaceanExamDateform()">
                                <option value="">Select Date</option>
                                <cfloop query="qgetLCEDate">
                                    <option value="#qgetLCEDate.ID#" <cfif isDefined('form.CeteacenSelect') and form.CeteacenSelect eq #qgetLCEDate.ID#>selected</cfif>>#qgetLCEDate.date#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>--->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myCetaceanExamFieldNumberform">
                        <label for="sel1">Search Cetacean Exam By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LCEID" id="LCEID" onChange="cetaceanExamFieldNumberform()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetLCEFBNumber">
                                    <option value="#qgetLCEFBNumber.ID#" <cfif isDefined('form.CeteacenSelect') and form.CeteacenSelect eq #qgetLCEFBNumber.ID#>selected</cfif>>#qgetLCEFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="reset" class="btn btn-default" value="Reset" onClick="ResetAll()"/>
                </div>
            </div>

            <!---start for HIForm --->
            <div class="row" id="HIformSerch" style="display:none;">
            
               <!--- <div class="col-lg-3 col-md-4">
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
                </div>--->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myHiFormFieldNumber">
                        <label for="sel1">Search By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="HI_ID" onChange="hiFormFieldNumber()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetHIFBNumber">
                                    <option value="#qgetHIFBNumber.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetHIFBNumber.ID#>selected</cfif>>#qgetHIFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
                </div>

            </div>
            <!--- for HIForm --->
            <!--- start for Level A Form --->
            <div class="row" id="LAFormSerch" style="display:none;">

               <!--- <div class="col-lg-3 col-md-4">
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
                </div>--->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myLevelAFormFieldNumber">
                        <label for="sel1">Search Level A By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LA_ID" onChange="levelAFormFieldNumber()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetLevelAFBNumber">
                                    <option value="#qgetLevelAFBNumber.ID#" <cfif isDefined('form.LA_ID') and form.LA_ID eq #qgetLevelAFBNumber.ID#>selected</cfif>>#qgetLevelAFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
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
                <!---<div class="col-lg-3 col-md-4">
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
                </div>--->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformHistopathologyByFieldNumber">
                        <label for="sel1">Search Histopathology By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="His_ID" onChange="formHistopathologyByFieldNumber()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetHistoFBNumber">
                                    <option value="#qgetHistoFBNumber.ID#" <cfif isDefined('form.His_ID') and form.His_ID eq #qgetHistoFBNumber.ID#>selected</cfif>>#qgetHistoFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
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
                </div>--->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                    <form  action="" method="post" id="myformBloodValueByFieldNum">
                        <label for="sel1">Search Blood Values By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="bloodValue_ID" onChange="formBloodValueByFieldNum()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetBloodValueFBNumber">
                                    <option value="#qgetBloodValueFBNumber.ID#" <cfif isDefined('form.bloodValue_ID') and form.bloodValue_ID eq #qgetBloodValueFBNumber.ID#>selected</cfif>>#qgetBloodValueFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
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
       
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                    <form  action="" method="post" id="myformToxicologybyFieldNumber">
                        <label for="sel1">Search Toxicology By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="Toxicology_ID" onChange="formToxicologybyFieldNumber()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetToxicologyFBNumber">
                                    <option value="#qgetToxicologyFBNumber.ID#" <cfif isDefined('form.Toxicology_ID') and form.Toxicology_ID eq #qgetToxicologyFBNumber.ID#>selected</cfif>>#qgetToxicologyFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
                </div>
         
            </div>
            <!--- end for Toxicology --->
            <!--- start for AncillaryDiagnostics --->
            <div class="row" style="display:none;" id="AncillaryDiagnosticsFormSerch">
        
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformAncillaryDiagnosticsSerchByFieldNumber">
                        <label for="sel1">Search Ancillary By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="AD_ID" onChange="formAncillaryDiagnosticsSerchByFieldNumber()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetAnclillaryFBNumber">
                                    <option value="#qgetAnclillaryFBNumber.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #qgetAnclillaryFBNumber.ID#>selected</cfif>>#qgetAnclillaryFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
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
                <!---<div class="col-lg-3 col-md-4">
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
                </div>--->
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
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
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
                <!---<div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="" method="post" id="myformNecropsySerchByDate">
                            <label for="sel1">Search Necropsy Report By Stranding Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="Nfieldnumber" onChange="formNecropsySerchByDate()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetNecropsyDate">
                                        <option value="#qgetNecropsyDate.Fnumber#" <cfif isDefined('form.Nfieldnumber') and form.Nfieldnumber eq #qgetNecropsyDate.Fnumber#>selected</cfif>>#qgetNecropsyDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>--->
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformNecropsySerchByFieldNumber">
                        <label for="sel1">Search Necropsy Report By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" id="fieldnumber" name="Nfieldnumber" onChange="checkfield()">
                                <option value="">Select Field Number</option>
                                <option value="0" class="adnew">Add New</option>
                                <cfloop query="qgetallfieldnumbers">
                                    <option value="#qgetallfieldnumbers.Fnumber#" <cfif isDefined('form.Nfieldnumber') and form.Nfieldnumber eq #qgetallfieldnumbers.Fnumber#>selected<cfelseif isDefined('form.Fnumber') and form.Fnumber eq #qgetallfieldnumbers.Fnumber#>selected</cfif>>#qgetallfieldnumbers.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>     
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
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

               <!--- <div class="col-lg-3 col-md-4">
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
                </div> --->

                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" id="myformMorphometricsSerchByFieldNumber">
                        <label for="sel1">Search Morphometrics By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="Morphometrics_ID" onChange="formMorphometricsSerchByFieldNumber()">
                                <option value="">Select Field Number</option>
                                <cfloop query="MorphometricsoFBNumber">
                                    <option value="#MorphometricsoFBNumber.ID#" <cfif isDefined('form.Morphometrics_ID') and form.Morphometrics_ID eq #MorphometricsoFBNumber.ID#>selected</cfif>>#MorphometricsoFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-md-3 reset-btn">
                    <input type="button" name="reset" id="" class="btn btn-default" value="Reset" onClick="ResetAll()"/>                
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
                
                <input type="hidden"  name="Site_url" id="Site_url" value="#Application.siteroot#/?Module=Stranding&Page=StrandingTabs">
                <input type="hidden"  name="ID" id="qLCEDataID" value="#qLCEData.ID#">
                <input type="hidden"  name="removeSession" id="removeSession" value="">
                <div class="form-wrapper cetacean-exam-wrapper">  
                    <div class="row cetacean-exam-holder">
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="cetaceanExam-date-form form-group m-0 blue-bg-l">
                                    <div class="cetacean-exam-form">
                                        <div class="cetacean-exam-wrap row">

                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <label class="field-number" for='necropsyfieldnumber'>Field Number</label>
                                                        <div class="input">
                                                            <input type="text" value="#qLCEDataa.Fnumber#" class="form-control" name="Fnumber" id="Fnumber" required>
                                                        </div>
                                                        <span style="color:red; display:none;" id="requiredFnumber">This field is required</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 apend"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group">
                                                        <label class="">Standing Agreement or Authority</label>
                                                        <div class="input">
                                                            <input class="input input-style" type="text" value="<cfif isDefined('qLCEDataa.NAA')  and #qLCEDataa.NAA# neq "">#qLCEDataa.NAA#</cfif>"name="NAA" id="NAA" onblur="headerDataSave()">
                                                        </div>
                                                    </div>                                                    
                                                </div>
                                            </div> 
                                            <div class="col-sm-6"> 
                                                <div class="form-group">
                                                    <label class="date-padd">Stranding Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="date" id="date"
                                                                class="form-control" value='<cfif isDefined('qLCEDataa.Date') and #qLCEDataa.Date# neq "" >#DateTimeFormat(qLCEDataa.Date, "MM/dd/YYYY")#</cfif>' required/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                        <span style="color:red; display:none;" id="requiredDate">This field is required</span>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <label class="date-padd">Necropsy Date</label>
                                                        <div class="input-group date " id="datetimepicker_NDate">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="necropsyDateID" id="necropsyDateID"
                                                                class="form-control" value='<cfif isDefined('qgetcetaceanDate.CNRDATE') and #DateTimeFormat(qgetcetaceanDate.CNRDATE, "MM/DD/YYYY")# neq "" >#DateTimeFormat(qgetcetaceanDate.CNRDATE, "MM/dd/YYYY")# </cfif>' readonly/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <label class="">NMFS Regional ##</label>
                                                        <input class="input-style xl-width" onblur="headerDataSave()" type="text" value="<cfif isDefined('qLCEDataa.NMFS') and #qLCEDataa.NMFS# neq "" >#qLCEDataa.NMFS#</cfif>" name="NMFS" id="NMFS">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 "> 
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <label class="">National Database ##</label>
                                                        <input class="input-style xl-width" type="text" onblur="headerDataSave()" value="<cfif isDefined('qLCEDataa.NDB') and #qLCEDataa.NDB# neq "" >#qLCEDataa.NDB#</cfif>" name="NDB" id="NDB">
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
                                                                <option value="#getCetaceansCode.id#" <cfif #getCetaceansCode.id# eq '#qLCEDataa.code#'>selected</cfif>>
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
                                                        <input class="input input-style" onblur="headerDataSave()" type="text" name="affiliatedID" id="affiliatedID" value="#qLCEDataa.affiliatedID#" maxlength="80">
                                                    </div>
                                                </div>
                                            </div>
                                        </div> 
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="">HERA/FB No.</label>
                                                    <input class="input-style xl-width" type="text" onblur="headerDataSave()" value="<cfif isDefined('qLCEDataa.hera')>#qLCEDataa.hera#</cfif> " name="hera" id="hera">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="sex-label">Sex</label>
                                                    <select class="form-control" name="sex" id="sex" onChange="headerDataSave()">
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
                                                    <select class="form-control" name="ageClass" id="ageClass" onChange="headerDataSave()">
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
                                                        <input class="input input-style" type="text" onblur="headerDataSave()" name="actualClass" id="actualClass" value="#qLCEDataa.actualClass#" maxlength="80">
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
                                                    <select class="form-control" name="InitialCondition" id="InitialCondition" onChange="headerDataSave()">
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
                                                    <select class="form-control" name="FinalCondition" id="FinalCondition" onChange="headerDataSave()">
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
                                            <textarea class="form-control textareaCustomReset locations-textarea" onblur="headerDataSave()" id="Location" name="Location"
                                                maxlength="75"><cfif isDefined('qLCEDataa.Location')>#qLCEDataa.Location#</cfif></textarea>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label class="lat-one">Lat</label>
                                                    <input class="input-style xl-width" onblur="headerDataSave()" onfocusout="checkValue(this)" type="text" value="<cfif isDefined('qLCEDataa.lat')>#qLCEDataa.lat#</cfif>" name="lat" id="AtLatitude">
                                                </div>
                                            </div>
                                        </div> 
                                        <div class="col-sm-6">
                                            <div class="form-group ">
                                                <div class="input-group">
                                                    <label class="lon-one">Lon</label>
                                                    <input class="input-style xl-width" onblur="headerDataSave()" onfocusout="checkValue(this)" type="text" value="<cfif isDefined('qLCEDataa.lon')>#qLCEDataa.lon#</cfif>" name="lon" id="AtLongitude">
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
                                                    <select class="form-control" name="county" id="county" onChange="headerDataSave()">
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
                                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                            <div class="form-group">
                                                <div class="input-group flex-center">
                                                    <label class="">Euthanized</label>
                                                    <input class="input-style xl-width" type="checkbox" value="1" name="euthanizedCB" id="euthanizedCB" <cfif (isdefined('qLCEDataa.euthanizedCB') and  qLCEDataa.euthanizedCB eq '1') || (isdefined('qLCEDataa.euthanizedCB') and  qLCEDataa.euthanizedCB eq 'Yes')>checked</cfif>>
                                                </div>                                          
                                            </div>
                                        </div> 
                                        
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
                                                            <select class="combobox form-control search-box" multiple="multiple" name="BodyOfWater" id="BodyOfWater">
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
                                                <label class="history-label">Brief History</label>
                                                <textarea class="form-control textareaCustomReset locations-textarea" onblur="headerDataSave()" name="BriefHistory" id="BriefHistory"  maxlength="2084" style="resize: auto;"><cfif isDefined('qLCEDataa.BriefHistory')>#qLCEDataa.BriefHistory#</cfif> </textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" id="headerImages" >
                                            <label class="history-label">Case Report</label>
                                            <div class="cust-row btn-rw startSpinner">
                                                <div class="cust-inp cust-inpts">
                                                    <div class="cust-inp test" id="startheaderSpinner">
                                                        <input type="file" placeholder="image Path" name="hImages" id="hImages" class="text-field text-fields" accept="image/*">
                                                    </div>
                                                    <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="headershowPictures()">Upload</button></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="choose-images case-report-image">
                                            <cfset imgs = ValueList(qLCEDataa.headerImages,",")>
                                                <input type="hidden" name="headerImagesFile" value="#imgs#" id="headerImagesFile">
                                                <div id="headerPreviousimages" class="choose-images-detail">
                                                    <CFIF listLen(imgs)> 
                                                        <cfloop list="#imgs#" item="item" index="index">
                                            
                                                            <span class="pip pipws">
                                                                <a class="imag" data-toggle="modal" data-target="##myNecropsyModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selectedNecropsy(this)"/>
                                                                </a>
                                                                <br/>
                                                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                                                    <span class="remove rms" onclick="headerImageremove(this)" id="#item#">Remove image</span>
                                                                </cfif>
                                                            </span>
                                                        </cfloop>
                                                    </cfif>	
                                                </div> 
                                            </div>
                                            <button type="submit" value="caseReport"  id="caseReport" name="caseReport" class="btn btn-pink btn-save">Generate Report
                                            </button>
                                     <!---working ---> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

               
                 <!-- Nav tabs -->
                 <div class="tab-section-list">

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs my-tabs" role="tablist">
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
                    <div class="tab-content my-content">
                      <div role="tabpanel" class="tab-pane active" id="CetaceanExamPage">   
                        <input type='hidden' name='autoSaveValue' id="autoSaveValue" value='CetaceanExam'>                     
                        <input type="hidden" name="codeID" value="#qLCEDataa.code#" id="codeID">
                        <h5 class="mb-1"><strong>Documents</strong></h5>
                        <input type="hidden" name="pdfFiles" value="#qLCEData.pdfFiles#" id="pdfFiles">
                        <div class="form-holder choose-images">  
                            <div class="form-group" id="find">
                            <!---  <button type="submit" value="caseReport"  id="caseReport" name="caseReport" class="btn btn-pink btn-save">Case Report</button> --->
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
                                <div id="previousimagesExam" class="PDFInline choose-images-detail">
                                    <CFIF listLen(imgss)> 
                                        <cfloop list="#imgss#" item="item" index="index">
                        
                                            <span class="pip">
                                                <a data-toggle="modal" data-target="##myModalExam" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                    <img  class="imageThumb imag" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="selected(this)"/>
                                                </a>
                                                <br/>
                                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                                    <span class="remove" onclick="removeExam(this)" id="#item#">Remove File</span>
                                                </cfif>
                                                <br/>
                                                <span class="remove" id="#item#">#item#</span>
                                            </span>
                                        </cfloop>
                                    </cfif>	
                                </div>
                            </div>
                            <input class="input-style xl-width" type="checkbox" value="1" name="caseReportBox" id="caseReportBox" <cfif (isdefined('qLCEData.caseReportBox') and  qLCEData.caseReportBox eq '1')>checked</cfif>>
                        </div>

                        <div class="form-holder">
                            <div class="row">
                                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6 heartrate-one">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="flex-center mb-1">
                                                <label class="">Heart Rate</label>
                                                <div class="input">
                                                    <input class="input input-style" type="text" value="" onblur="checkValue(this)"  id="heartRate" placeholder="beats/min">
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
                                                    <input type="text" class="input input-style" onblur="checkValue(this)" value="" id="respRate" placeholder="Resps /min">
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
                                            <option value="#qgetDrugType.Type#">#qgetDrugType.Type#</option>
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
                                    <input type="text" class="input input-style" onblur="checkValue(this)" id="DrugDosage">
                                    <input type="hidden" value="" name="DrugDosage" id="dd">
                                </div>
                            </div>
                            <span id="D_dosage" class="D_dosage_error"></span>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Total Volume</label>
                                <div class="input">
                                    <input type="text" class="input input-style" onblur="checkValue(this)" id="DrugVolume" placeholder="ml">
                                    <input type="hidden" value="" name="DrugVolume" id="dv">
                                </div>
                            </div>
                            <span id="D_volume" class="D_volume_error"></span>
                        </div>
                        <div class="col-lg-1 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <input type="button" class="btn btn-success ml-auto" id="drugsNeww" value="Add New" onClick="AddNewDrug()"/>
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
                                        <cfif isDefined('qgetDrugData')>
                                        <th>Action</th>
                                        </cfif>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetDrugData')>
                                        <cfloop query="qgetDrugData">
                                            <tr id="DrugsAdministered_#ID#">
                                                <td id="Drugtype#ID#">#qgetDrugData.Drugtype#</td>
                                                <td id="DrugMethod#ID#"><cfif #qgetDrugData.DrugMethod# neq 0>#qgetDrugData.DrugMethod#</cfif></td>
                                                <td id="DrugTime#ID#"><cfif #qgetDrugData.DrugTime# neq 0>#qgetDrugData.DrugTime#</cfif></td>
                                                <td id="DrugDosage#ID#"><cfif #qgetDrugData.DrugDosage# neq 0>#qgetDrugData.DrugDosage#</cfif></td>
                                                <td id="DrugVolume#ID#"><cfif #qgetDrugData.DrugVolume# neq 0>#qgetDrugData.DrugVolume#</cfif></td>
                                                <td>
                                                    <div class="tablebutn" style="display: inline-flex;">
                                                        <input type="button" id="edit_DrugsAdministered#ID#" value="Edit" class="edit" onclick="edit_DrugsAdministered(#ID#)">
                                                        <input type="button" value="Delete"  class="delete" onclick="delete_DrugsAdministered(#ID#)" style="margin-left: 5%;"> 
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
                                        <input class="input input-style" type="text" onblur="checkValue(this)" value="#qLCEData.BSBloodVolume#" id="BSBloodVolume" name="BSBloodVolume">
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
                                                    <cfif Active eq 1>
                                                    <option value="#getLesionTypeData.LesionTypeName#">#getLesionTypeData.LesionTypeName#</option>
                                                        </cfif>
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
                            <input type="hidden" id="idForUpdateSampleReport" value="">
                            <input type="hidden" id="idForUpdatetoxicology" value="">
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
                                    <textarea class="form-control textareaCustomReset" maxlength="512" name="General">#qLCEData.General#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Scars and Natural Markings</label>
                                    <textarea class="form-control textareaCustomReset" maxlength="512" name="SNM">#qLCEData.SNM#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Mentation</label>
                                    <textarea class="form-control textareaCustomReset" maxlength="512"name="Mentation">#qLCEData.Mentation#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Palpation</label>
                                    <textarea class="form-control textareaCustomReset" maxlength="512" name="Palpation">#qLCEData.Palpation#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Proprioception</label>
                                    <textarea class="form-control textareaCustomReset" maxlength="512" name="Proprioception">#qLCEData.Proprioception#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2" id="needcopy">
                                <div class="input-group">
                                    <label class="">Reflexes</label>
                                    <textarea class="form-control textareaCustomReset" name="Reflexes" maxlength="512" id="Reflexes">#qLCEData.Reflexes#</textarea>
                                </div>
                                <br>
                            </div>
                            <cfif isDefined('qgetNewSectionData') AND #qgetNewSectionData.recordcount# gt 0>
                                <input type="hidden" id="countaa" value="#qgetNewSectionData.recordcount#" name="count">
                                <cfloop query="qgetNewSectionData">
                                    <div class="col-lg-12" id="needco#qgetNewSectionData.currentrow#"><br>
                                        <div class="input-group" id="needcopytoo#qgetNewSectionData.currentrow#">
                                            <label class="">New Section #qgetNewSectionData.currentrow# </label>
                                            <textarea class="form-control textareaCustomReset" maxlength="512" id="extraNotes#qgetNewSectionData.currentrow#"name="extraNotes#qgetNewSectionData.currentrow#">#qgetNewSectionData.New_Secion#</textarea>
                                        </div>
                                    </div>
                                </cfloop>
                            <cfelse>
                                <input type="hidden" id="countaa" value="0" name="count">
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
                                   