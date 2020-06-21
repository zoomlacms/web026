$(function(){
	$("#loading").hide();
	$("#distribution-apply").click(function(event){
		event.preventDefault();
		$("#distribution-tip").fadeIn();
		setTimeout(function(){
		$("#distribution-tip").fadeOut();
			},4000)
		}   	 
	);	
	//close advertisement
	$("#advertisement-close").click(function(){
		$("#advertisement-apptip").hide();
		$("#fromesb-wechat").animate({
			top:0
			});
		})
	//contact float
	$("#contFloat").click(function(event){
		event.preventDefault();
		$("#contFloat-detail").show();
		})
	$("#contFloat-detail-close").click(function(){
		$("#contFloat-detail").hide();
		})



	$("#collect-link").on("click",function(){
			$("#collect-tip").show();
			})
		$("#a-know").on("click",function(){
			$("#collect-tip").hide();
			})
	//share
	$("#share-link").on("click",function(){
			$("#share-tip").show();
			})
		$("#a-know").on("click",function(){
			$("#share-tip").hide();
			})
	//app download close
	$("#appdown-close").on("click",function(){
		$("#apptip").hide();
		})	
		

	//ios4 fixed
	var isIOS = (/iphone|ipad/gi).test(navigator.appVersion);
	if (isIOS) {
	$('#s_buy').on('focus', 'input', function () {
	$('.head').addClass('relative');
	$('.mod_slider').css("margin-top","10px")
	}).on('focusout', 'input', function () {
	$('.head').removeClass('relative');
	$('.mod_slider').css("margin-top","50px")
	});
	}
    //menu float
	var menufloatclicknumber=0;
	  function menufloatin(){
		  $(".menu-c").removeClass("out");
		  $("#menufloat").addClass("show")
		  $(".mask_menu").fadeIn();
		  $("#menufloat-c").show();
		  $(".menu-c-inner").removeClass("outer");
		  $(".menu-c-inner").addClass("in")
		  $(".menu-c-inner a").show();
		  menufloatclicknumber=1;
		  }
	  function menufloatout(){
		  $("#menufloat").removeClass("show")
		  $(".mask_menu").fadeOut();
		  $(".menu-c-inner").removeClass("in")
		  $(".menu-c-inner").addClass("outer")
		  $(".menu-c-inner a").hide();
		  $(".menu-c").addClass("out");
		  menufloatclicknumber=0;		
		  }	   
	  $("#menufloat").click(function(){
		  if(menufloatclicknumber==0){
		     menufloatin();
			 }
		  else{
		  	 menufloatout();
			  }			 	
		  })
		$(".mask_menu").click(function(){
			menufloatout();
			})
})
