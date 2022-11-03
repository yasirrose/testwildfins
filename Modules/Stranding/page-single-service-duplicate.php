<?php

// Template Name: Single Service Duplicate
global $post;

if (ICL_LANGUAGE_CODE == 'en') {
	$lang = 'en';
} else {
	$lang = 'fr';
}

get_header();

get_template_part('partials/content-breadcrumb');

	echo '<main class="main-container" id="maincontentTarget">';

while ( have_posts() ) : the_post();

	$stu_inline_video = get_field('stu_inline_video');
	$stu_inline_video_caption = get_field('stu_inline_video_caption');
	$stu_inline_video_text = get_field('stu_inline_video_text');
	$stu_text_callout = get_field('stu_text_callout');

$stu_related_sidebar = get_field('stu_related_sidebar');
$s_ids = $stu_related_sidebar;

$surgeons_description = get_field('surgeons_description');
$surgeons_slider = get_field('surgeons_carousel');
$testimonials = get_field('surgeons_testimonials');
$service_intro = get_field('service_intro');
$faq_intro = get_field('faq_intro');
$service_banner_image = get_field('service_banner_image');
$mobile_banner = get_field('mobile_banner_image');


	echo '<div class="the-content">';

		echo '<div class="main-content-video OMFS">';

			the_title('<h1 class="page-title">','</h1>');

			if( !empty(service_banner_image) ) {
				echo '<div class="service-banner">';
					echo '<img class="desktop-banner" src="' .$service_banner_image['url']. '" alt="">';
				echo '</div>';
			}
echo '<img class="mobile-banner" src="' .$mobile_banner['url']. '" alt="">';
			if( !empty($service_intro) ) {
				echo '<div class="service-intro-b">';
					echo $service_intro;
				echo '</div>';
			}
			
			echo '<div class="video-intro service-intro">';
				if($stu_inline_video) {
					echo '<div class="video-intro-content">';
					echo $stu_inline_video_text;
					echo '<p class="video-intro-link">' . $stu_inline_video_caption . '</p>';
				echo '</div>';
				}

				echo '<div class="video-video">';
				echo '<div class="video-wrapper">';
					echo $stu_inline_video;
				echo '</div>';
			echo '</div>';

			echo '</div>';

		echo '</div>';


?>
			<div class="contact-block newblock">
				<div class="contact-block-content">
					<h4>
						<em>Contact us and we will have one of our trained professionals get back to you as soon as possible.</em>
					</h4>
					<p>
						<a class="btn-default" href="/procedures/#contact_form_button">Contact us</a> 
						<a class="btn-outline" href="tel:(613)778-8888">CALL US: (613) 778-8888</a>
				    </p>
				</div>
			</div>

<div class="vision-mission h3-section-tittle OMFS">
				<div class="col-full-12">
					<div class="col-half-6">
						<div class="img_wrap">
							<img src="/wp-content/uploads/2022/02/thumb-shutterstock_398189713-1.jpg" alt="img">
						</div>
					</div>
					<div class="col-half-6">
						<div class="text-wrap">
							<h3>Anaesthesiology</h3>
							<p>All OMFSs undergo mandatory anaesthesia training in a hospital-based setting. This makes them unique among the many dental and surgical specialties. Our surgeons and staff are pleased to offer the complete range of anaesthesia options to our patients.</p>

							   <p>	For more information, visit our <a href="https://argyleassociates.com/anaesthesia/"> anaesthesia resource page.</a></p>
						</div>
					</div>
				</div>
			</div>

			<div class="vision-mission h3-section-tittle OMFS">
				<div class="col-full-12">
				<div class="col-half-6">
						<div class="text-wrap">
							<h3>Hospital Privileges</h3>
							<p>All the surgeons at Argyle Associates have hospital privileges in the Ottawa region. This allows us to treat patients in a hospital-based setting when necessary.</p>

<p>We can therefore provide care for a variety of complex injuries and conditions, including urgent care and trauma. In addition to their work in our 4 offices, our surgeons are all actively engaged in the hospitals, providing urgent care for a variety of <a href="/procedures/dental-implants/">complex injuries and conditions.</a> </p>
						</div>
					</div>
					<div class="col-half-6">
						<div class="img_wrap left_img">
							<img src="/wp-content/uploads/2022/02/thumb-shutterstock_661362253.jpg" alt="img">
						</div>
					</div>
				</div>
			</div>
<?php
		echo '<div class="argyle-associates-help">';
			if ($lang == 'en') {
				echo '<h3 class="ser-ttl">Conditions Treated</h3>';	
				echo '<p class="ser-ttl">An OMFS diagnoses and surgically treats these conditions:</p>';	

				echo '<div class="home-ser-list">';
					echo '<div class="home-service">';
						echo '<a href="/procedures/wisdom-tooth-removal/" class="home-ser-inner">';
							echo '<img src="/wp-content/uploads/2017/08/icon-procedures-wisdom-tooth-removal.png">';
							echo '<h4>Wisdom tooth removal</h4>';
							echo '<p>Argyle Associates provides expert, efficient removal of problematic or impacted wisdom teeth in Ottawa & surrounding areas. </p>';
						echo '</a>';
					echo '</div>';
					echo '<div class="home-service">';
						echo '<a href="/procedures/dental-implants/" class="home-ser-inner">';
							echo '<img src="/wp-content/uploads/2017/08/icon-procedure-implant.png">';
							echo '<h4>Dental Implants</h4>';
							echo '<p>We are the gold-standard for replacing missing teeth, helping restore the natural smile you deserve.</p>';
						echo '</a>';
					echo '</div>';
					echo '<div class="home-service">';
					echo '<a href="/procedures/impacted-canine-teeth/" class="home-ser-inner">';
						echo '<img src="/wp-content/uploads/2017/08/icon-procedures-impacted-canine.png">';
						echo '<h4>IMPACTED CANINE TEETH</h4>';
						echo '<p>Exposure or extraction of un-erupted teeth, helping to make proper room in your mouth.</p>';
					echo '</a>';
				echo '</div>';
				echo '<div class="home-service">';
						echo '<a href="/procedures/bone-grafting/" class="home-ser-inner">';
							echo '<img src="/wp-content/uploads/2017/08/icon-procedures-bone-graft.png">';
							echo '<h4>BONE GRAFTING</h4>';
							echo '<p>Restoration & reconstruction of bone and soft tissue, increasing the volume of your jawbone.</p>';
						echo '</a>';
					echo '</div>';

				echo '</div>';

				echo '<div class="home-ser-list">';
				echo '<div class="home-service">';
				echo '<a href="/procedures/facial-trauma/" class="home-ser-inner">';
					echo '<img src="/wp-content/uploads/2017/08/icon-procedures-face-trauma.png">';
					echo '<h4>FACIAL TRAUMA</h4>';
					echo '<p>Treatment of facial lacerations, knocked-out teeth, fractured facial bones & jaws from accidents & injuries, etc.</p>';
				echo '</a>';
			echo '</div>';
			echo '<div class="home-service">';
			echo '<a href="/procedures/cosmetic-facial-surgery/" class="home-ser-inner">';
				echo '<img src="/wp-content/uploads/2017/08/icon-procedures-cosmetic.png">';
				echo '<h4>FACIAL COSMETIC SURGERY</h4>';
				echo '<p>Restoring confidence through surgery to enhance the appearance of the jaw, mouth, and face.</p>';
			echo '</a>';
		echo '</div>';
		echo '<div class="home-service">';
		echo '<a href="/procedures/cleft-surgery/" class="home-ser-inner">';
			echo '<img src="/wp-content/uploads/2017/08/icon-procedures-cleft-palate.png">';
			echo '<h4>CLEFT LIP & CLEFT PALATE SURGERY</h4>';
			echo '<p>Treatment for children and adults with congenital cleft lip and palate deformities.</p>';
		echo '</a>';
	echo '</div>';

					echo '<div class="home-service">';
						echo '<a href="/procedures/tmj-dysfunction/" class="home-ser-inner">';
							echo '<img src="/wp-content/uploads/2017/08/icon-procedures-tmj.png">';
							echo '<h4>TMJ DYSFUNCTION</h4>';
							echo '<p>Surgical & non-surgical care for jaw pain, joint clicking & related issues with the temporomandibular joint.</p>';
						echo '</a>';
					echo '</div>';
			
	
				echo '</div>';

				echo '<div class="home-ser-list">';

					echo '<div class="home-service">';
					echo '<a href="/procedures/sleep-apnea/" class="home-ser-inner">';
						echo '<img src="/wp-content/uploads/2017/08/icon-procedures-apnea.png">';
						echo '<h4>SLEEP APNEA</h4>';
						echo '<p>Surgical treatment for obstructive sleep apnea, a potentially life-saving procedure to help breathing.</p>';
					echo '</a>';
				echo '</div>';
				echo '<div class="home-service">';
				echo '<a href="/procedures/head-neck-oral-cancer/" class="home-ser-inner">';
					echo '<img src="/wp-content/uploads/2017/08/icon-procedures-cancer.png">';
					echo '<h4>HEAD, NECK & ORAL CANCER</h4>';
					echo '<p>We can diagnose and help plan treatment for diseases such as oral cancer.</p>';
				echo '</a>';
			echo '</div>';
					echo '<div class="home-service">';
						echo '<a href="/procedures/corrective-jaw-surgery/" class="home-ser-inner">';
							echo '<img src="/wp-content/uploads/2017/08/icon-procedure-corrective-jaw.png">';
							echo '<h4>CORRECTIVE JAW SURGERY</h4>';
							echo '<p>Surgical corrections for facial and jaw abnormalities that cannot corrected by braces alone.</p>';
						echo '</a>';
					echo '</div>';
					echo '<div class="home-service contact-now-block">';
					echo '<a href="/contact/" class="home-ser-inner">';
						echo '<img src="/wp-content/uploads/2019/07/discuss-issue.png">';
						echo '<h2>Need Help?<br> Contact Us Now!</h2>';
						echo '<a href="#contact_form_button" class="btn-default">CONTACT US</a>';
					echo '</a>';
				echo '</div>';
				echo '</div>';
			} 
		echo '</div>';
			?>

			<div class="vision-mission h3-section-tittle refer_para">
				<div class="text-wrap">
					<h3>Why Dentists Refer Patients to OMFS</h3>
				</div>
				<div class="col-full-12">
					<div class="col-half-6">
					<div class="text-wrap">
							<p>Dentists refer their patients to us for many reasons. Trust and overall quality of care are at the top of the list. Removing wisdom teeth and placing dental implants are two of the most common surgical procedures that we perform.</p>

<p>We are highly skilled, educated, and experienced in handling complex procedures and conditions related to the face, mouth, and jaws. As a large group of surgeons with nursing staff and multiple locations, we are generally able to schedule surgeries and postoperative visits quickly.</p>
							
						</div>
					</div>
					<div class="col-half-6">
						<div class="text-wrap">
							<p>We support your dentist or family physician when they require additional surgical support to manage surgical complications. Due to the extent of our experience in and focus on surgery, we can perform the procedure efficiently and with minimal complications.</p>

<p>We offer the full range of anaesthesia options. This includes, local anaesthesia (freezing), nitrous oxide (“laughing gas”), oral sedation, intravenous (IV) conscious and deep sedation, and general anaesthesia. We can treat patients in private clinic or a hospital-based setting.</p>
						</div>
					</div>
				</div>
			</div>
			</div>
		<?php 

		// $opt_contact_text_content 	= get_field('opt_contact_text_content', 'option');
		// $stu_show_contact_block 	= get_field('stu_show_contact_block');

		//if($opt_contact_text_content && $stu_show_contact_block) {
			// echo '<div class="contact-block">';
			// 	echo '<div class="contact-block-content">';
			// 		echo $opt_contact_text_content;
			// 	echo '</div>';
			// echo '</div>';
		//}

			//if( !empty($faq_intro) ) {
			//	echo '<div class="service-intro-b">';
			//		echo $faq_intro;
			//	echo '</div>';
			//}
			
			//echo '<div class="main-content">';

			//echo the_content();

			//if( have_rows('stu_accordion') ) {

			//	echo '<div class="accordion-component">';

			//		while( have_rows('stu_accordion') ) : the_row();

			//			$stu_accordion_title 	= get_sub_field('stu_accordion_title');
			//			$stu_accoddion_content 	= get_sub_field('stu_accoddion_content');
			//			$stu_accordion_image = get_sub_field('stu_accordion_image');

			//			echo '<h3><button>' . $stu_accordion_title . '</button></h3>';
			//			echo '<div class="accordion-pane">';
			//				if ($stu_accordion_image) {
			//					echo '<img class="alignright" src="' . $stu_accordion_image . '">';
			//				}
			//				echo $stu_accoddion_content;
			//			echo '</div>';

			//		endwhile;

			//	echo '</div>';

		//	}

		//echo '</div>';

	//	get_sidebar('right');

	echo '</div>';

endwhile;

	echo '</main>';

	if( !empty($surgeons_description) ) {
		echo '<div class="location-ttl">' . $surgeons_description . '</div>';
		// echo 'Surgeons';
		
			if( !empty($surgeons_slider) ) {
				echo $surgeons_slider;
			}
	
	}

//	if( !empty($testimonials) ) {
//		echo '<div class="service-quote">';
//			echo $testimonials;
//		echo '</div">';
//	}

	get_template_part('partials/contact-footer');

$opt_hp_content = get_field('opt_hp_content', 'option');
	if($opt_hp_content) {
		echo '<div class="hp-content">';
			// echo $opt_hp_content;
		echo '</div>';
	}

get_footer();

?>

<script src="/wp-content/themes/stu/assets/slider/js/lightslider.js"></script>

<script type="text/javascript">
 jQuery(document).ready(function() {		
 jQuery("#slider").lightSlider({
			     item:5,
                loop:true,
	 			speed:500,
                auto:true,
	            pauseOnHover: true,
                keyPress:true,
                enableTouch:false,
                enableDrag:false,
                freeMove:false,
               controls:false,
	 			responsive : [
            {
                breakpoint:800,
                settings: {
                    item:3,
                    slideMove:1,
                    slideMargin:6,
                  }
            },
            {
                breakpoint:480,
                settings: {
                    item:2,
                    slideMove:1
                  }
            }
        ]
            });
 });
</script>