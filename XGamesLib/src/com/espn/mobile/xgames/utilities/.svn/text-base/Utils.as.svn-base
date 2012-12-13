//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.utilities
{
	
	/*import com.adobe.crypto.MD5;*/
	import com.adobe.crypto.MD5;
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.model.vo.ArticleVO;
	
	import flash.desktop.NativeApplication;
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;
	import flash.system.Capabilities;
	
	import mx.core.FlexGlobals;

	/**
	 * 
	 * This class should be used for defining functions which are common to many classes
	 * which perform actions related to calculations, string parsing etc, which can be utilized by other classes. 
	 * 
	 */	
	public class Utils
	{
		public static const DEVICE_ANDROID:Number = 1001;
		public static const DEVICE_IOS:Number = 1002;
		
		/**
		 *	const for Android
		 */	
		private static const LINUX:String = "Linux";
		
		/**
		 *	returns the current DPI of the application. 
		 */		
		public static function applicationDPI():Number
		{
			return FlexGlobals.topLevelApplication.applicationDPI;
		}
		
		/**
		 *	Validate the bitmap source, if it contains the noPhoto
		 */		
		public static function isBitmapSourceValid(sourceBitmapString:String):Boolean{
			if(sourceBitmapString.indexOf("nophoto") == -1){
				return true;
			}else{
				return false;
			}
		}
		
		/**
		 * Convert numeric date in milliseconds to actual date 
		 */		
		public static function convertMillisecondsToDate(seconds:int):Date
		{
			var output:Date = new Date(seconds);
			return output;
		}
		
		/**
		 * Format date to full date
		 * Example January 23, 1982 
		 */		
		public static function convertDate(date:Date):String
		{
			var df:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT); 
			df.setDateTimePattern("EEEE, MMMM d, yyyy");
			return df.format(date).toUpperCase();
		}

		public static function getThumbnailHeightByAspectRatio(thumbnailWidth:Number, aspectRatio:String):Number
		{
				var thumbnailHeight:Number;
		
				if(aspectRatio == AppConstants.IMAGE_16X9)
					thumbnailHeight = (thumbnailWidth * 9)/16;
				else if(aspectRatio == AppConstants.IMAGE_7X5)
					thumbnailHeight = (thumbnailWidth * 5)/7;
				else if(aspectRatio == AppConstants.IMAGE_2X3)
					thumbnailHeight = (thumbnailWidth * 3)/2;
				return thumbnailHeight;
		}
		
		public static function getUpdatedDate(ms:int):String {
			
			var date:Date = new Date(ms * 1000);
			var dateTimeFormatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT); 
			dateTimeFormatter.setDateTimePattern("EEEE, MMMM d, yyyy");
			var finalDate:String = dateTimeFormatter.format(date).toUpperCase();
			return finalDate;
		}
		
		
		/**
		 * function to return the image section
		 */
//		private static function getInlineImageTag(imageUrl:String, _height:int, _width:int, _credit:String, _caption:String) : String {
//			return "<div class='mod-inline image full'><img src=http://espn.go.com" +imageUrl+ " border='0'><cite>" +_credit + "</cite>" +_caption + ". </div>";
//		}
		
		private static function getInlineImageTag(imageUrl:String, _height:int, _width:int, _credit:String, _caption:String) : String {
			
			if(!_caption)
				_caption = "";
			
			if(!_credit)
				_credit = "";
			
			if(!imageUrl)
				return "";
			
			return "<div class='mod-inline image full'><img src=http://espn.go.com" +imageUrl+ " border='0' height='" + _height + "' width='" + _width +"'><cite>" +_credit + "</cite>" +_caption + ". </div>";
		}
		
		/**
		 * function to replace the <photo> tags in the response with the correct img tags.
		 */
		private static function findAndReplaceImageTags(articleVO:ArticleVO):String {
			
			var photoTagCount:Number = 0;
			if(articleVO && (articleVO.photos) && (articleVO.photos.length > 0)) {
				photoTagCount = articleVO.photos.length;
			}  
			
			var htmlString:String = articleVO.body;
			for(var count:Number = 0;count<photoTagCount;count++) {
				
				var tagFormat:String = AppConstants.ARTICLE_PHOTO_TAG + (count+1) + AppConstants.ARTICLE_PHOTO_CLOSING_TAG;
				var tagLocation:Number = htmlString.search(tagFormat);
				if(tagLocation > -1) {
					htmlString = htmlString.replace(tagFormat, getInlineImageTag(articleVO.photos[count].beauty.url,articleVO.photos[count].beauty.height, articleVO.photos[count].beauty.width, articleVO.photos[count].beauty.credit, articleVO.photos[count].caption));
				}
			} 
			return htmlString;
		}
		 		
		public static function getArticleHTML(articleVO:ArticleVO) : String {
			
			var bodyText:String = "";
			if(articleVO) {
				bodyText = findAndReplaceImageTags(articleVO);
				if(bodyText)
					return "<html><head><link rel='stylesheet' href='http://a.espncdn.com/xgames/qa/static/css/main.css' type='text/css' media='screen' charset='utf-8' /></head><body class='fullscreen-article' style='background: none !important;'><article class='article module'><div class='article-body'>"+ bodyText + "</div></article></body</html>";
				return bodyText;
			}
			else
				return bodyText;
		}
		
		public static function getSimpleHTML(bodyText:String) : String 
		{
				if(bodyText)
					return "<html><head><link rel='stylesheet' href='http://a.espncdn.com/xgames/qa/static/css/main.css' type='text/css' media='screen' charset='utf-8' /></head><body class='fullscreen-article' style='background: none !important;'><article class='article module'><div class='article-body'>"+ bodyText + "</div></article></body</html>";
				return bodyText;
		}
		
		public static function getCurrentDate() : Date {
			
			var currentDateTime:Date = new Date();
//			var currentDF:DateFormatter = new DateFormatter();
//			currentDF.formatString = "MM/DD/YY"
//			var dateTimeString:String = currentDF.format(currentDateTime);
			return currentDateTime;
		}
		
		public static function compareDates (date1:Date, date2:Date) : int
		{
			var date1Timestamp : Number = date1.getTime();
			var date2Timestamp : Number = date2.getTime();
			
			if(date2Timestamp - date1Timestamp > AppConstants.SECONDS_IN_A_DAY) {
				return 1;
			} else if (date2Timestamp - date1Timestamp == AppConstants.SECONDS_IN_A_DAY) {
				return 0;
			}
			return -1;
		}
		
		public static function getDeviceType() : Number {
			
			var devicePlatformString:String = flash.system.Capabilities.os;
			if(devicePlatformString && devicePlatformString.search(LINUX) != -1) {
				return DEVICE_ANDROID;
			} else {
				return DEVICE_IOS;
			}
			
		}
		
		public static function getAddHypeUrl(hypeValue:String, hypeType:String):String
		{
			var salt:String = "triplecrown";
			var randomNum:int = Math.random()*100;		
			var date:Date = new Date();
			var build:String = AppConstants.ADD_HYPE_BUILD_VERSION;
			
			var pstDate:Date = new Date(date.fullYearUTC, date.monthUTC, date.dateUTC, (date.hoursUTC -8), date.minutesUTC, date.secondsUTC, date.millisecondsUTC);
			
			var dateFormatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
			dateFormatter.setDateTimePattern("yyyyMMdd.HH.mm.ss");//    "EEEE, MMMM d, yyyy"
			var formattedDate:String = dateFormatter.format(pstDate);
			
			var msgBuilder:String = salt + "value=" + hypeValue + "&hypeType=" + hypeType +
									"&date=" + formattedDate + "&rand=" + randomNum.toString() + "&build=" + build + salt;
			
			var digest:String = MD5.hash(msgBuilder);
			
			var baseUri:String = "http://xgames.qa.espn.go.com/api/v0/hype/add";
			
			var requestUri:String = baseUri + "?hypeValue=" + hypeValue + "&hypeType=" + hypeType +
									"&date=" + formattedDate + "&random=" + randomNum.toString() + "&build=" + build + 
									"&digest=" + digest;
			
			
		
			return requestUri;
		}
		
		
		
		public static function getWatchESPNEventID(val:String):String 
		{ 
			var eventID:String = ""; 
			var doubleSlashPosition:Number = val.indexOf("//"); 
			if(doubleSlashPosition > -1) 
			{ 
				eventID = val.substr(doubleSlashPosition, val.length-1); 
			} 
			return ":" + eventID; 
		}
		
		public static function getAppVersion() : String {
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appVersion:String = appXml.ns::versionNumber[0];
			return appVersion;
		}
		
		/**
		 * This method will be used to remove the HTML tags
		 * from a string
		 */
		public static function clearHTMLTag(value:String):String
		{
			//Regular expression to remove HTML tags from a string
			var myPattern: RegExp =/<[^>]*>/g; 
			var newStr:String = "";
			
			if(value && value.length > 0)
			{
				newStr = value.replace(myPattern,"");
			}
		
			return newStr;
		}

	}
}