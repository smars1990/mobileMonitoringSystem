﻿<!DOCTYPE html>
<html>
<head>
  <%@include file="/common/taglib.jsp"%>
  <meta charset="UTF-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
  <title>智能监控终端</title>
  
  <link rel="stylesheet" href="../../media/css/weui.min.css">
  <link rel="stylesheet" href="../../media/css/weui-gds.css">
  <link rel="stylesheet" href="../../media/jquery-weui/css/jquery-weui.css">
  
  <style type="text/css">
   .swiper-container {
     width: 100%;
     height: 230px;
   } 

  .swiper-container img {
    display: block;
    width: 100%;
  }
  
.swiper-slide .flag{
	position: absolute;
	border: 1px solid #f00;
	box-sizing: border-box;
}
 </style>
 

</head>
<body ontouchstart>

<div class="container">
    
    <input type="hidden" name="warningID" id="warningID" value="${phoneEarlyWarningDTO.warningID }">
    
    <div class="weui-tab" style="height:auto;">
     <div class="weui-navbar">
        <div class="weui-navbar__item weui-bar__item_on">图集</div>
      </div> 
      
          <div class="weui-tab__panel">
          
               <div class="weui-cells">
		           <div class="weui-cell">
		               <div class="swiper-container">
					      <div class="swiper-wrapper">
					      
					        <c:set var="warningImageDetailHashMap" scope="session" value="${phoneEarlyWarningDTO.warningImageDetailHashMap}"/>
					        <c:choose>
					           <c:when test="${not empty phoneEarlyWarningDTO.warningImageList }">
					              <c:forEach items="${phoneEarlyWarningDTO.warningImageList }" var="imagespath">
							        
							        <div class="swiper-slide" style="position: relative;">
							          <img src="http://smars1990.viphk.ngrok.org/phoneWarningWeixin/getImageInof.do?urlPath=${imagespath}"   width="100%" height="194" />
							        </div>
							        
						  	      </c:forEach>
					           </c:when>
					           <c:otherwise>
					              <div class="swiper-slide"><img src="" /></div>
					           </c:otherwise> 
					        </c:choose>
					
                         </div>
					      <div class="swiper-pagination"></div>
					      
					    </div>
		           </div>
		           
		            <div class="weui-cell">
	                <a href="javascript:void(0);" id="openLocation"  latitude="${phoneEarlyWarningDTO.latitude }" longitude="${phoneEarlyWarningDTO.longitude }"  class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../../media/images/map-marker.png" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title">${phoneEarlyWarningDTO.warningTypeName}告警地点</h4>
                        <p class="weui-media-box__desc">${phoneEarlyWarningDTO.warningAddress }</p>
                    </div>
                   </a>
	            </div>
	            <div class="weui-cell" >
				   
				  <a href="javascript:void(0)" id="openDepContacts" class="weui-btn weui-btn_plain-default" style="margin-top: 0px;width:25%;font-size: 16px;">派警</a>
				  <c:if test="${phoneEarlyWarningDTO.warningStatus eq '1' }">  </c:if>
				  <c:choose>
				    <c:when test="${phoneEarlyWarningDTO.warningStatus eq '1' }">
				      <a href="javascript:void(0);" class="weui-btn weui-btn_primary" onclick="modifyPhoneWarning('${phoneEarlyWarningDTO.warningID}','3');" style="margin-top: 0px;width:33%;font-size: 16px;">确认该警告</a>
					  <a href="javascript:void(0);" id="shareAppMessage" class="weui-btn weui-btn_warnning"  onclick="modifyPhoneWarning('${phoneEarlyWarningDTO.warningID}','2');" style="margin-top: 0px;width:33%;font-size: 16px;" >标记为误报</a>
				    </c:when>
				    <c:otherwise>
				      <a href="javascript:void(0);" class="weui-btn weui-btn_disabled weui-btn_primary"  style="margin-top: 0px;width:33%;font-size: 16px;">确认该警告</a>
					  <a href="javascript:void(0);" id="shareAppMessage" class="weui-btn weui-btn_disabled weui-btn_warnning"  style="margin-top: 0px;width:33%;font-size: 16px;" >标记为误报</a>
				    </c:otherwise>
				  </c:choose>
				    	    
				</div>
		           
		       </div> 
		       
       </div>
             
   </div>
   
      
 </div>
 
<div class="search-modal">
  <div class="search-content">
    <div class="weui-cells__title">请选择人员</div>
    <div class="weui-cells weui-cells_radio">
          <c:forEach items="${sensorSiteMangeEmpList}" var="sensorSiteMangeEmpDTO" varStatus="sensorSiteMangeEmpDTOStatus">
            <label class="weui-cell weui-check__label" for="x1${sensorSiteMangeEmpDTOStatus.count}">
		        <div class="weui-cell__bd">
                       <p>${sensorSiteMangeEmpDTO.realName }</p>
                    </div>
                    <div class="weui-cell__ft">
            		<input type="radio" class="weui-check" name="openid" id="x1${sensorSiteMangeEmpDTOStatus.count}"  value="${sensorSiteMangeEmpDTO.wechatNo}"  <c:if test="${sensorSiteMangeEmpDTOStatus.count eq 1}">checked</c:if> >
           			 <span class="weui-icon-checked"></span>
        		</div>
		    </label>
          </c:forEach>
        </div>
  </div>
  <div class="weui-dialog__ft search-btn">
    <a href="javascript:searchHidden();" class="weui-dialog__btn weui-dialog__btn_default">取消</a>
    <a href="javascript:void(0);" onclick="selectLeaveType();" class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
  </div>
</div>
		         


  <script src="../../media/js/jquery.min.js"></script>
  <script src="../../media/js/jweixin-1.2.0.js"></script>
  <script src="../../media/jquery-weui/js/jquery-weui.js"></script>
  <script src="../../media/jquery-weui/js/swiper.js"></script>

<script type="text/javascript">

   /*  
     //对图片的flag类型进行等比例缩放
    $(".swiper-slide .flag").each(function(index,object){
    	// 获取图片的宽度的比率
    	var  widthRatio= parseFloat($(object).parent().find("img").css("width")) /1920 ;
    	// 获取图片的高度的比率
    	var heightRatio = 194/1080;
    	
    	//更换X轴坐标
    	var xAxis = parseFloat( $(object).css("left") ) * widthRatio ;  
    	$(object).animate({left: xAxis},0);
    	
    	//更换Y轴坐标
    	var yAxis = parseFloat($(object).css("top")) * heightRatio;  
    	$(object).animate({top: yAxis},0);
    	
    	//更换width
    	var widthAxis = parseFloat($(object).css("width")) * widthRatio ;  
    	$(object).animate({width: xAxis - widthAxis},0);
    	
    	//更换height
    	var heightAxis =  parseFloat($(object).css("height")) * heightRatio;  
    	$(object).animate({height: yAxis - heightAxis},0);
    	
    	//对图片渲染完后显示
    	$(object).css('display','block'); 
    });  */
    
     // 加载图片相册：轮换功能屏蔽
      $(".swiper-container").swiper({
        loop: false
      });
        
        configWx();
        function configWx() {  
        	// 获取当前页面URL链接
        	var  httpUrl = encodeURIComponent(location.href.split('#')[0]);
        	
        	$.ajax({
                cache: true, //缓存开启加速
                type: "POST",
                url: "/phoneWarningWeixin/getJsTicket.do",
                data: "url="+httpUrl,
                async: false, //同步、异步                
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                  $.toast("JsTicket配置请求错误！", function() {
                      console.log('close');
                    });
                },
                success: function(data) {
                	 if (data != null) {  
                        wx.config({  
                            debug : true,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。  
                            appId : data.appId,  
                            timestamp : data.timestamp,  
                            nonceStr : data.nonceStr,  
                            signature : data.signature,  
                            jsApiList : [
                                         'openLocation',
                                         'previewImage'
                                         ]  
                        }); 
                        wx.ready(function () {
                           
                        	//查看地理位置
                        	document.querySelector('#openLocation').onclick = function () {
                        		var latitude = parseFloat($(this).attr("latitude"));
                        	    var longitude = parseFloat($(this).attr("longitude"));
                        	    
                        		wx.openLocation({
                            	    latitude: latitude, // 纬度，浮点数，范围为90 ~ -90
                            	    longitude: longitude, // 经度，浮点数，范围为180 ~ -180。
                            	    name: '', // 位置名
                            	    address: '', // 地址详情说明
                            	    scale: 16, // 地图缩放级别,整形值,范围从1~28。默认为16
                            	});
                        	};
                        	
                        	 //调用微信预览图片的方法
                        	 var funcReadImgInfo = function (){
	                        	var imgs = [];
	                            var imgObj = $(".swiper-slide img");//这里改成相应的对象
	                            for(var i=0; i<imgObj.length; i++){
	                                 imgs.push(imgObj.eq(i).attr('src'));
	                                 imgObj.eq(i).click(function(){
	                                      var nowImgurl = $(this).attr('src');
	                                          wx.previewImage({
	  	                               			current: nowImgurl, // 当前显示图片的http链接
	  	                               			urls: imgs // 需要预览的图片http链接列表
	  	                               		   }); 
	                                 });
	                            }
                        	 }
                        	funcReadImgInfo();
                        	
                     });
                     
                     wx.error(function (res) {
                       alert("err....:"+res.errMsg);
                     }); 
                     
                  } else {  
                 	 $.toast("配置weixin jsapi失败", function() {
                         console.log('close');
                       });
                  }  
             }
           });
     } 
        
      //  修改警告状态
      function modifyPhoneWarning(warningID,waringStatusCode){
    	  var  data = "waringStatusCode="+waringStatusCode+"&warningID="+warningID;
   	      $.ajax({
             cache: true, //缓存开启加速
             type: "POST",
             url: "/phoneWarningWeixin/modifyPhoneWarning.do",
			  data: data,
             async: false, //同步、异步                
             error: function(XMLHttpRequest, textStatus, errorThrown) {
               weui.alert("修改警告状态失败，请重试！");
             },
             success: function(data) {
             	 if (data != null) {  
             		$.toast(data, function() {
                       console.log('close');
                   });
             	 }
             }
     	}); 
      }
      
      // 获取预警状态码
      var  warningStatusCode  = ${phoneEarlyWarningDTO.warningStatus};

   	  // 打开通讯录
   	  document.querySelector('#openDepContacts').onclick = function () {
   		 $('.search-modal').toggleClass('search-modal-show');
   	  }  
      
      //选择微信公众号人员 ：点击取消
      function searchHidden() {
        $('.search-modal').toggleClass('search-modal-show');
        $('.modal-mask').remove();
      }
      
      //选择微信公众号人员 ：点击确定
      function selectLeaveType() {
    	  //获取告警Id
          var  warningID = $("#warningID").val();
    	  //获取选中的微信公众号关注人员的openID
    	  var userOpenID = $("input[name='openid']:checked").val();
          
          $.ajax({
              cache: true, //缓存开启加速
              type: "POST",
              url: "/phoneWarningWeixin/sendUsersMessage.do",
              data: "warningType=alarm&userOpenID="+userOpenID+"&warningID="+warningID,
              async: false, //同步、异步                
              error: function(XMLHttpRequest, textStatus, errorThrown) {
                $.toast("发送消息失败，请重试！", function() {
                       console.log('close');
                });
              },
              success: function(data) {
            	 var data  = eval('(' + data + ')');
               	 if (data != null) {
               		// 发送消息内容
             	    var messageData = "";
             	    if( 'success'  != data.message){
             	    	messageData = "发送消息失败！";
             	    }else{
             	    	messageData = "发送消息成功！";
             	    }
             	  
               	    searchHidden();
               	    $.toast(messageData, function() {
                            console.log(messageData);
                     });
               	  
               	 }
              }
      	});
      }
      

   
    </script>
</body>
</html>