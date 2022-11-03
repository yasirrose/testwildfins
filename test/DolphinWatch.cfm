<cfinclude template="Templates/observationheader.cfm">
		<div class="container">
			<div class="text-center">
				<div class="logoWrap">
					<img class="img-responsive center-block" src="/assets/dolphin/logo.png" alt="">
				</div>
               <!--- <a href="getObservers.cfm" class="btn btn-md btn-primary" style="margin-left:720px;">Click to see all users</a>--->
			</div>
			<div class="allFormWrap">
				<div class="jumbotron">
					<div class="container-fluid">
						<div class="row headerSec">
							<div class="col-sm-6">
								<div class="leftimg">
									<img class="img-responsive" src="/assets/dolphin/Dolphens.jpg" alt="">
								</div>
							</div>
							<div class="col-sm-6 header-right">
								<div class="header-text text-center">
                                    <img  class="img-responsive" src="/assets/dolphin/wildlogo.jpg"  alt="">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="formWrap">
					<form  role="form" id="chatImageUpload" name="chatImageUpload" enctype="multipart/form-data" method="post">
						<div class="container-fluid">
							<div class="row">
								<!---<div class="col-sm-3">--->
									<!---<div class="smallLogo">--->
										<!---<!---<img class="img-responsive" src="/assets/dolphin/small.png" width="100" alt="">--->--->
									<!---</div>--->
								<!---</div>--->
								<div class="col-sm-12">
									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="">Primary Observer's Name *</label>
												<input type="text" name="name" class="form-control">
                                               <span class="error-class-text"></span>
											</div>
											<div class="form-group">
												<label for="">Describe yourself *</label><br>
												<div class="checkbox">
													<label><input type="checkbox" name="is_HBOIVolunteer" value="1">HBOI Volunteer</label>
												</div>
												<div class="checkbox">
													<label><input type="checkbox" name="is_MRCVolunteer" value="1">MRC Volunteer</label>
												</div>
												<div class="checkbox">
													<label><input type="checkbox" name="publicmember" value="1">member of the public</label>
												</div>
												<div class="checkbox">
													<label><input type="checkbox" name="nphotographer" value="1">nature photographer or naturalist</label>
												</div>
												<div class="checkbox">
													<label><input type="checkbox" value=""><input type="text" name="other" class="form-control" placeholder="Other"></label>
												</div>
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<label for="">E-mail</label>
												<input type="email" name="email" class="form-control">
											</div>
											<div class="form-group">
												<label for="">Phone Number</label>
												<input type="tel" id="phone" name="phone" data-type="mask-number" class="form-control" autocomplete="off"  value="">
												<span class="f10">please provide phone if we can contact you for more information</span>
											</div>
											<!---<div class="form-group">
												<label for="">Names of other observers present</label>
												<textarea class="form-control" name="otherobserver"></textarea>
											</div>--->
										</div>
									</div>
								</div>
							</div>
						</div>
				<div class="jumbotron sec-heading">
					<div class="header-text text-center">
						<h2>Dolphins Observation Information</h2>
					</div>
				</div>
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="">Observation type *</label><br>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="checkbox" name="liveDobservation" value="1">sighting of live Dolphins(s)</label>
											</div>
										<!---	<div class="checkbox">
												<label><input type="checkbox" name="roadkillobservation" value="1">roadkill Dolphins sighting</label>
											</div>--->
										</div>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="checkbox" value=""><input type="text" name="otherobservation" class="form-control" placeholder="Other"></label>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									
                                    <!----
                                    <div class="form-group">
										<label for="">Other signs of Dolphins</label><br>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="checkbox" name="tracks" value="1">tracks</label>
											</div>
											<div class="checkbox">
												<label><input type="checkbox" name="den" value="1">den</label>
											</div>
										</div>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="checkbox" name="scat" value="1">scat</label>
											</div>
											<div class="checkbox">
												<label><input type="checkbox" name="slidinout" value="1">slide out/in</label>
											</div>
										</div>
									</div>
                                    --->
								</div>
							</div>
							<div class="row">
								<div class="col-sm-4">
									<div class="form-group">
										<label for="">Number of Dolphinss observed *</label><br>
										<input type="text" name="observedolphins" class="form-control">
									</div>
								</div>
								<div class="col-sm-8">
									<div class="form-group">
										<label for="">Date & Time *</label><br>
										<div class="halfer">
										<input type="text" id="datepicker"   class="form-control">
									</div>
									<div class="halfer"> 
										<div class="timeSelect">
											<span>at</span>
											<select name="hours" id="hrs" class="form-control">
												  <option>  </option>
								                  <option value="1"> 1 </option>
								                  <option value="2"> 2 </option>
								                  <option value="3"> 3 </option>
								                  <option value="4"> 4 </option>
								                  <option value="5"> 5 </option>
								                  <option value="6"> 6 </option>
								                  <option value="7"> 7 </option>
								                  <option value="8"> 8 </option>
								                  <option value="9"> 9 </option>
								                  <option value="10"> 10 </option>
								                  <option value="11"> 11 </option>
								                  <option value="12"> 12 </option>
											</select>
											<select name="minutes" id="mnts" class="form-control">
												  <option>  </option>
								                  <option value="00"> 00 </option>
								                  <option value="10"> 10 </option>
								                  <option value="20"> 20 </option>
								                  <option value="30"> 30 </option>
								                  <option value="40"> 40 </option>
								                  <option value="50"> 50 </option>
											</select>
											<select name="maritium" id="mrtm" class="form-control">
												  <option>  </option>
								                  <option value="am"> AM </option>
								                  <option value="pm"> PM </option>
											</select>
										</div>
									</div>
									</div>
								</div>
							</div>
							<div class="row bodySize">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="">Dolphins # 1 body size *</label><br>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="radio" name="size1" value="large"> large (adult)</label>
											</div>
											<div class="checkbox">
												<label><input type="radio" name="size1" value="small"> small (baby)</label>
											</div>
											<div id="size1_validate"></div>
										</div>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="radio" name="size1" value="medium"> medium (juvenile)</label>
											</div>
											<div class="checkbox">
												<label><input type="radio" name="size1" value="not sure"> not sure</label>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<label for="">Dolphins # 2 body size *</label><br>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="radio" name="size2" value="large"> large (adult)</label>
											</div>
											<div class="checkbox">
												<label><input type="radio" name="size2" value="small"> small (baby)</label>
											</div>
										</div>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="radio" name="size2" value="medium">  (juvenile)</label>
											</div>
											<div class="checkbox">
												<label><input type="radio" name="size2"  value="not sure"> not sure</label>
											</div>
										</div>
									</div>
								</div>
								<div class="cstmRow">
									<div class="col-sm-6">
									<div class="form-group">
										<label for="">Dolphins # 3 body size *</label><br>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="radio" name="size3" value="large"> large (adult)</label>
											</div>
											<div class="checkbox">
												<label><input type="radio" name="size3" value="small"> small (baby)</label>
											</div>
										</div>
										<div class="halfer">
											<div class="checkbox">
												<label><input type="radio" name="size3" value="medium"> medium (juvenile)</label>
											</div>
											<div class="checkbox">
												<label><input type="radio" name="size3" value="not sure"> not sure</label>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<label for="">additional Dolphinss' body size</label><br>
										<input type="text" name="additionalsize" class="form-control">
									</div>
								</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<p class="text-danger redTxt">Location is very importnt. Please give address or drop a pin using your phone to get latitude and longitude. You can also "screen shot" your location and upload it as a photo (below). Please give as many details as possible.</p>
								</div>
								<div id="map-canvas"></div>
							</div>
							<div class="row mtop20">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="">City and water body (if known) *</label><br>
										<textarea class="form-control" name="waterbody"></textarea>
										<span class="f10">for example: Merritt Island, Sykes Creek or Melbourne, retention pond</span>
									</div>
									<div class="form-group">
										<label for="">Address (you can drop a pin on your phone for lat/long) *</label><br>
										<textarea class="form-control" name="addresss"></textarea>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="">Latitude</label><br>
												<input type="text" name="Latitude" class="form-control">
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<label for="">Longitude</label><br>
												<input type="text" name="Longitude" class="form-control">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label for="">Confidence of sighting *</label><br>
										<div class="checkbox">
											<label><input type="radio" name="confidence" value="100% sure"> 100% sure</label>
										</div>
										<div class="checkbox">
											<label><input type="radio" name="confidence" value="only got a fast look"> pretty sure but only got a fast look  not sure Other</label>
										</div>
										<div class="checkbox">
											<label><input type="radio" name="confidence" value="not sure"> not sure</label>
										</div>
										<div class="checkbox">
											<label><input type="text" name="confidence" class="form-control" placeholder="Other"></label>
										</div>
									</div>
								</div>
							</div>
							<div class="row mtop20">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="">Dolphins behavior</label><br>
										<select name="Dolphinsbehavior" class="form-control">
									     	<option value=""> </option>
								            <option value="swimming"> swimming </option>
								            <option value="on bank of water body"> on bank of water body </option>
								            <option value="actively feeding (food in mouth)"> actively feeding (food in mouth) </option>
								            <option value="social (playing)"> social (playing) </option>
								            <option value="resting"> resting </option>
								            <option value="crossing road"> crossing road </option>
								            <option value="not sure"> not sure </option>
								            <option value="other (please describe below)"> other (please describe below) </option>
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<label for="">more behavior details</label><br>
										<textarea class="form-control" name="behaviordetails"></textarea>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<div class="jumbotron">
										<div class="header-text text-center">
											<h2>Photos/Videos</h2>
												<p>If you have videos that you would like to share, please email us at Wildfins and we will send you a dropbox link.</p>
										</div>
									</div>
								</div>
							</div>
							<div class="row mtop20">
								<div class="col-sm-4">
									<label for="">Did you take any photos or videos? *</label><br>
									<div class="checkbox">
										<label><input type="checkbox" name="Photos" value="1">Photos</label>
									</div>
									<div class="checkbox">
										<label><input type="checkbox" name="videos" value="1">Videos</label>
									</div>
									<div class="checkbox">
										<label><input type="checkbox" name="nonemedia" value="1">None</label>
									</div>
								</div>

								<div class="col-sm-8">
									<label for="">Add Photos of Dolphinss here</label><br>
									<input class="btn btn-success" id="BestImage"  multiple="multiple" value="upload a File" name="BestImage" type="file">
								</div>

								</div>
							<div class="row mtop20">
                                <label for="">Example of type of photos needed</label>
                                <br>
                                <br><br>
                                <div class="row">
									<div class="col-md-12">
										<div class="col-md-4">
                                            <img class="myImg"  src="/assets/dolphin/1.jpg"  alt="Dolphin Sight" width="300" height="200">
										</div>
                                        <div class="col-md-4">
                                            <img class="myImg"  src="/assets/dolphin/2.jpg"  alt="Dolphin Sight" width="300" height="200">
										</div>
                                        <div class="col-md-4">
                                            <img class="myImg"  src="/assets/dolphin/3.jpg"  alt="Dolphin Sight" width="300" height="200">
										</div>
									</div>
								</div>


                                <!-- The Modal -->
                                <div id="myModal" class="modal">

                                    <!-- The Close Button -->
                                    <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>

                                    <!-- Modal Content (The Image) -->
                                    <img class="modal-content" id="img01">

                                    <!-- Modal Caption (Image Text) -->
                                    <div id="caption"></div>
                                </div>
							</div>

							<div class="row mtop20">
								<div class="col-sm-12">
									<label for="">Photo / Video Release- I authorize Hubbs-SeaWorld Research Inst. to use my photos/videos:</label><br>
									<div class="radio">
										<label><input type="radio" name="authorizemedia" value="however they see fit, WITHOUT photo credit">however they see fit, WITHOUT photo credit</label>
									</div>
									<div class="radio">
										<label><input type="radio" name="authorizemedia" value="however they see fit, WITH photo credit">however they see fit, WITH photo credit</label>
									</div>
									<div class="radio">
										<label><input type="radio" name="authorizemedia" value="only for work relating to Dolphins Spotter data collection ">only for work relating to Dolphins Spotter data collection and reporting</label>
									</div>
									<div class="radio">
										<label><input type="radio" name="authorizemedia" value="Contact me for permission before use">Contact me for permission before use</label>
									</div>
								</div>
							</div>
							<div class="row mtop20">
								<div class="col-sm-12">
									<label for="">How did you hear about the Dolphins Spotter program?</label><br>
								<!---	<div class="checkbox">
										<label><input type="radio" name="hearingsource" value="by HSWRI"> Dolphins Spotter training by HSWRI</label>
									</div>--->
									<div class="checkbox">
										<label><input type="radio" name="hearingsource" value="newspaper article"> posted sign or newspaper article</label>
									</div>
									<div class="checkbox">
										<label><input type="radio" name="hearingsource" value="public talk by HSWRI"> public talk</label>

									<div class="checkbox">
										<label><input type="radio" name="hearingsource" value="from another organization"> from another organization or person</label>
									</div>
									<div class="checkbox">
										<label><input type="radio"  name="hearingsource" value="staff at HSWRI"> staff at HBOI</label>
									</div>
									<div class="checkbox">
										<label><input type="radio"  name="hearingsource"value="social media"> social media (e.g. facebook)</label>
									</div>
								</div>
							</div>
							<div class="row mtop20">
								<div class="col-sm-12 text-center">
									<input type="submit" name="submit"  id="submit-observer" class="btn btn-success" value="submit"/><br>
								</div>
							</div>
						</div>
						</div>
					</form>
				</div>
				</div>
		</div>
<cfinclude template="Templates/observationofooter.cfm">