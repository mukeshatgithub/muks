package com.espn.mobile.xgames.controllers
{
	import air.net.URLMonitor;
	
	import com.espn.mobile.xgames.constants.OmnitureConstants;
	import com.espn.mobile.xgames.model.omniture.OmnitureConfigModel;
	import com.espn.mobile.xgames.service.XAlertService;
	import com.espn.mobile.xgames.utilities.Utils;
	import com.omniture.AppMeasurement;
	
	import flash.display.Stage;
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	
	import mx.core.FlexGlobals;

	public class OmnitureController
	{	
		
		private var s:AppMeasurement;
		private var monitor:URLMonitor;		
		private var hasConnection:Boolean;
		
		[Inject]
		public var omnitureModel:OmnitureConfigModel;
		
		public function updateParams(): void {
			
			var devicePlatformString:String = flash.system.Capabilities.os;
			if(devicePlatformString && devicePlatformString.search("Linux") != -1) {
				omnitureModel.deviceType = OmnitureConstants.DEVICE_TYPE_ANDROID;
			} else {
				omnitureModel.deviceType = OmnitureConstants.DEVICE_TYPE_IOS;
			}
			
			var stage:Stage = FlexGlobals.topLevelApplication.stage;
			
			if(stage) {
				var _width : Number = Math.max( stage.stageWidth, stage.stageHeight );
				var _height : Number = Math.min( stage.stageWidth, stage.stageHeight );
				
				_width = _width / FlexGlobals.topLevelApplication.applicationDPI;
				_height = _height / FlexGlobals.topLevelApplication.applicationDPI;
				
				//this will resolve to the physical size in inches...
				//if greater than 7 inches, assume its a tablet
				if ( _width >= 7 ) {
					if(omnitureModel.deviceType == OmnitureConstants.DEVICE_TYPE_ANDROID) 
						omnitureModel.channel = OmnitureConstants.CHANNEL_ANDROID_TABLET;
					else 
						omnitureModel.channel = OmnitureConstants.CHANNEL_IPAD;
					
					omnitureModel.orientation = OmnitureConstants.ORIENTATION_LANDSCAPE;
				} else {
					if(omnitureModel.deviceType == OmnitureConstants.DEVICE_TYPE_ANDROID) 
						omnitureModel.channel = OmnitureConstants.CHANNEL_ANDROID_HANDSET;
					else 
						omnitureModel.channel = OmnitureConstants.CHANNEL_IPHONE;
					
					omnitureModel.orientation = OmnitureConstants.ORIENTATION_PORTRAIT;
				}
				
				updateDeviceOS();
				omnitureModel.appVersion = Utils.getAppVersion();
			} else {
				//trace("stage is null in OmnitureConfigModel");
			}
			
			initVariables();
			
		}
		
		private function updateDeviceOS() : void {
			
			if(omnitureModel.deviceType == OmnitureConstants.DEVICE_TYPE_ANDROID) {
				omnitureModel.deviceOS = Capabilities.os;
			} else {
				var os:String =  Capabilities.os;
				var osVersion:String = Capabilities.os.substr(10, 3);
				var iOSVersion:Number = parseFloat(osVersion);
				omnitureModel.deviceOS = iOSVersion as String;
			}
		}
		
		
		
		[PostConstruct]
		public function postConstruct():void
		{
			// initiate the AppMeasurement object
			// set the app level values like account name which are same through out the app.
			s = new AppMeasurement();
			//s.account = omnitureModel.account;
			s.account = OmnitureConstants.OMNITURE_PRIMARY_SUITEID  + "," + OmnitureConstants.OMNITURE_SECONDRY_SUITEID;
			s.ssl = true;
			s.trackingServer=OmnitureConstants.OMNITURE_TRACKING_SERVER;;
			
			monitor = new URLMonitor(new URLRequest('http://www.google.com'));
			monitor.addEventListener(StatusEvent.STATUS, onNetworkStateChangeHandler);
			monitor.start();
		}
		
		private var xAlertService:XAlertService = new XAlertService();
		
		private function initVariables() : void {
			
			//app name
			s.prop1 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX;
			
			//channel
			s.channel = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel;
			
			//SWID
			
			s.prop2 = "D=" + xAlertService.getSWID();
			
			//language
			s.eVar9 = "en"
			s.prop17 = "espn:" + s.eVar9;
			
			//user agent
			s.prop37 = s.eVar37 = "";
			
			//orientation
			s.prop38 = omnitureModel.orientation;
			
			//app version
			s.prop47 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + omnitureModel.appVersion;
			
			//OS version
			s.prop48 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + omnitureModel.deviceOS;
		}
		
		private function onNetworkStateChangeHandler(e:StatusEvent):void
		{
			hasConnection = (monitor.available)?true:false;
		}
		
		public function initOmniture() : void {

			if(s && hasConnection) {
				trace("App load tracking");
				printTraces();
				s.track();
			}
		}
		
		private function printTraces(): void {
			trace("s.account: " + s.account
				+ ", s.ssl:" + s.ssl
				+ ", s.trackingServer:" + s.trackingServer
				+ ", s.prop17:" + s.prop17
				+ ", s.prop38:" + s.prop38
				+ ", s.prop47:" + s.prop47
				+ ", s.prop48:" + s.prop48
				+ ", s.prop1:" + s.prop1
				+ ", s.prop5:" + s.prop5
				+ ", s.channel:" + s.channel
				+ ", s.prop4:" + s.prop4
				+ ", s.prop35:" + s.prop35
				+ ", s.prop2:" + s.prop2
				+ ", s.eVar2:" + s.eVar2
				+ ", s.eVar9:" + s.eVar9
				+ ", s.prop9:" + s.prop9
				+ ", s.prop3:" + s.prop3
				+ ", s.prop23:" + s.prop23
				+ ", s.evar72:" + s.evar72
				+ ", s.evar10:" + s.evar10
				+ ", s.eventList:" + s.eventList
				+ ", s.prop15:" + s.prop15
				+ ", s.evar11:" + s.evar11
				+ ", s.prop25:" + s.prop25
				+ ", s.eVar6:" + s.eVar6
				+ ", s.evar19:" + s.evar19
				+ ", s.eVar15:" + s.eVar15);
		}
		
		private function clearFields() : void {
			//clear existing fields	
			s.prop13 = "";
			
			//sportName
			s.prop25 = s.evar19 = "";
			
			s.eVar15 = s.prop15 = "";
			
			//columnist
			s.prop23 = s.eVar10  = "";
			
			//article source line
			s.prop13 = "";
			
			//video ids
			s.prop3 = s.eVar2 = "";
			
			//video content type
			s.prop35 = "";
			
			s.eVar6 = "";
			
		}
		
		
		
		public function trackClusterPageView(pageName:String, sportName:String=null, evarB:String = null):void
		{
			if(hasConnection)
			{
				clearFields(); 
				
				s.pageName = s.eVar13 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName + ":cluster";
				s.prop5 = s.evar11 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName;
				s.eventList = ['event' + OmnitureConstants.OMNITURE_EVENT_NUMBER_PAGEVIEW, 'event' + OmnitureConstants.OMNITURE_EVENT_NUMBER_PERSONALIZATION];
				
				if( evarB != null ) { 
					s.evar27 = evarB;
				}
				
				//page / content type
				s.prop35 = s.prop4 = "cluster";
				
				
				//if Sport related, s.prop25 = s.evar19 = sport name > YES on all page views, but only for sport-specific content
				if(sportName)
					s.prop25 = s.evar19 = sportName;
				
				//trace("ClusterPageView tracking");
				//printTraces();
				s.track();
			}
		}
		
		
		public function trackArticle(pageName:String, sportName:String=null, articleTitle:String=null, columnistName:String=null, sourceline:String = null, evarB:String = null):void
		{
			if(hasConnection)
			{
				clearFields();
				
				s.pageName = s.eVar13 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName + ":article";
				s.prop5 = s.evar11 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName;
				
				s.eventList = ['event' + OmnitureConstants.OMNITURE_EVENT_NUMBER_PAGEVIEW];
				
				if( evarB != null ) { 
					s.evar27 = evarB;
				}
				
				//page / content type
				s.prop35 = "article";
				s.prop4 = "story";
				
				//if Sport related, s.prop25 = s.evar19 = sport name > YES on all page views, but only for sport-specific content
				if(sportName)
					s.prop25 = s.evar19 = sportName;
				
				if(articleTitle)
					s.eVar15 = s.prop15 = articleTitle;
				
				if(columnistName)
					s.prop23 = s.eVar10 = columnistName;
				
				if(sourceline)
					s.prop13 = sourceline;
				
				//trace("Article tracking");
				//printTraces();
				s.track();
			}
		}
		
		// call it when ever we start a video
		public function trackVideoEvents(linkObject:Object, linkName:String, videoID:String, title:String, sportName:String, pageName:String, videoContent:String, varOverride:Object = null) :void {
			
			if(hasConnection)
			{
				clearFields();
				
				s.pageName = s.eVar13 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName + ":view";
				s.prop5 = s.evar11 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName;
				
				s.eventList = ['event' + OmnitureConstants.OMNITURE_EVENT_NUMBER_VIDEOSTART];
				
				//page / content type
				s.prop4 = s.prop35 = "video";
				
				if(sportName)
					s.prop25 = s.evar19 = sportName;
				
				if(videoID && title)
					s.prop3 = s.eVar2 = "videoID=" + videoID + "::" + title;
				
				//The type of content viewed in the video  > only where the video is viewed
				if(videoContent)
					s.prop35 = videoContent;
				
				//link id has to go blank
				s.prop9 = "";
				
				//trace("Video tracking");
				//printTraces();
				s.trackLink(null, OmnitureConstants.LINKTYPE, linkName, varOverride);
			}
		}
		
		//call this when app gets launched from some external source like campaign / alert etc..
		public function trackCampaigns(alertType:String, landingPageName:String, landingPageSection:String, evarB:String = null):void
		{
			if(hasConnection)
			{
				clearFields();
				s.prop9 = "";
				
				s.campaign =  OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":alertlaunch:" + alertType;   
				s.pageName = s.eVar13 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + landingPageSection+ ":" + landingPageName;
				s.prop5 = s.eVar11=  OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + landingPageSection;
				
				var tempEvent:String = "event" + OmnitureConstants.OMNITURE_EVENT_NUMBER_PAGEVIEW;
				s.eventList = [tempEvent];
				
				if( evarB != null ) { 
					s.evar27 = evarB;
				}
				
				trace("Campaigns alert tracking");
				printTraces();
				s.track();
			}
		}
		
		
		// tracking fav alerts
		public function trackFavoritesAlerts(pageName:String, linkObject:Object, favoriteName:String, alertName:String, sportName:String, isAdd:Boolean, varOverride:Object = null):void
		{
			if(hasConnection)
			{
				clearFields();
				
				s.pageName = s.eVar13 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName + ":favoritesalert";
				s.prop5 = s.evar11 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName;
				
				s.eventList = ['event' + OmnitureConstants.OMNITURE_EVENT_NUMBER_PERSONALIZATION];
				
				//page / content type
				s.prop4 = s.prop35 = "";
				
				var sport:String = "";
				var linkName:String = "";
				if(sportName) {
					sport = ":" + sportName;
					s.prop25 = s.evar19 = sportName;
				}
					
				
				if(isAdd) {
					linkName = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":addalert" + sport + ":favoritealert_add";
					s.eVar6 = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":addalert" + sport + ":favoritealert";
				} else {
					linkName = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":removealert" + sport + ":favoritealert_remove";
					s.eVar6 = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":removealert" + sport + ":favoritealert";
				}
				
				
				var tempEvent:String = "event" + OmnitureConstants.OMNITURE_EVENT_NUMBER_PERSONALIZATION;
				s.eventList = [tempEvent];
				
				//trace("Favorites alert tracking");
				//printTraces();
				
				s.trackLink(linkObject, OmnitureConstants.LINKTYPE, linkName, varOverride);
			}
		}
		
		// tracking breaking news alerts
		public function trackBreakingNewsAlerts(pageName:String, linkObject:Object, alertName:String, sportName:String, isAdd:Boolean, varOverride:Object = null):void
		{
			if(hasConnection)
			{
				clearFields();
				
				s.pageName = s.eVar13 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName + ":breakingnewsalert";
				s.prop5 = s.evar11 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName;
				
				s.eventList = ['event' + OmnitureConstants.OMNITURE_EVENT_NUMBER_PERSONALIZATION];
				
				//page / content type
				s.prop4 = s.prop35 = "";
				
				var sport:String = "";
				var linkName:String = "";
				if(sportName) {
					sport = ":" + sportName;
					s.prop25 = s.evar19 = sportName;
				}
				
				
				if(isAdd) {
					linkName = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":addalert" + sport + ":breakingnewsalert_add";
					s.eVar6 = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":addalert" + sport + ":breakingnewsalert";
				} else {
					linkName = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":removealert" + sport + ":breakingnewsalert_remove";
					s.eVar6 = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":removealert" + sport + ":breakingnewsalert";
				}
				
				
				var tempEvent:String = "event" + OmnitureConstants.OMNITURE_EVENT_NUMBER_PERSONALIZATION;
				s.eventList = [tempEvent];
				
				trace("BreakingNews alert tracking");
				printTraces();
				s.trackLink(linkObject, OmnitureConstants.LINKTYPE, linkName, varOverride);
			}
		}
				
		//call this when we share any story from the app	
		public function trackStoryShare(linkObject:Object, pageName:String, storyName:String, sharingService:String, varOverride:Object = null):void
		{
			if(hasConnection)
			{
				clearFields();
				s.prop5 = s.evar11 = "";
				
				var tempEvent:String = "event" + OmnitureConstants.OMNITURE_EVENT_NUMBER_STORYSHARE;
				s.eventList = [tempEvent];
				
				var linkName:String = s.eVar72 = s.prop9 = OmnitureConstants.OMNITURE_PARAMETER_PREFIX + ":" + omnitureModel.channel + ":" + pageName + ":" + storyName + ":share:" + sharingService;
				
				//trace("StoryShare tracking");
			//	printTraces();
				s.trackLink(linkObject, OmnitureConstants.LINKTYPE, linkName, varOverride);
			}
		}
		
	}
}