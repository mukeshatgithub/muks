//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.events.AppDataEvent;
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.model.vo.AppConfigVO;
	import com.espn.mobile.xgames.model.vo.ClusterVO;
	import com.espn.mobile.xgames.model.vo.LocalAppConfigVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLVariables;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.core.FlexGlobals;
	import mx.states.OverrideBase;
	
	/**
	 * This is main model class and holds all centralized data to be communicated across modules.
	 * 
	 * 
	 */
	public class AppConfigModel extends BaseService
	{
		
		
		/* PRIVATE MEMBERS */
		
		/** serviceXML */
		private var serviceXML:XML;
		/** currentServiceID */
		private var currentServiceID:String;
		
		
		/** GETTER/SETTER MEMBERS */
		private var _configSettings:AppConfigVO;
		
		
		
		/** GETTER/SETTER MEMBERS FOR LOCAL CONFIG */
		private var _localConfigSettings:LocalAppConfigVO;

		public var navigationItems:ArrayCollection;
		

		
		/**
		 * AppConfigModel
		 */
		
		public function AppConfigModel() // NOPMD
		{	
		}
		
		
		/**
		 * Load startup data which includes config settings, services.xml and modules.xml
		 * 
		 * */
		public function loadXMLConfig():void 
		{
			loadXML(AppConstants.CONFIG_XML_PATH);
		}
		
		
		/**
		 * public method to invoke loading of the app config.
		 */	
		public function loadAppConfig(lastUpdate:String):void
		{
			var params:URLVariables = new URLVariables();
			params.lastUpdatedTime = lastUpdate;
			params.deviceType = settings.deviceType;
			read(getServicePath(AppConstants.APP_CONFIG), params, true);
		}
		
		/**
		 * Returns object of <code>ConfigSettingsVO</code> where all configuration settings are stored. 
		 * These settings are getting stored when configuration.xml is loaded.
		 * */
		public function get settings():AppConfigVO
		{
			return _configSettings;
		}
		
		/**
		 * Returns object of <code>LocalAppConfigVO</code> where all configuration settings are stored. 
		 * These settings are getting stored when configuration.xml is loaded.
		 * */
		public function get localSettings():LocalAppConfigVO
		{
			return _localConfigSettings;
		}

		public function set localSettings(val:LocalAppConfigVO):void
		{
			_localConfigSettings = val;
		}

		
		/**
		 * Returns web service/xml path as per the ID provided.
		 * ID is maintained as constants inside <code>AppConstants</code>
		 * */
		public function getServicePath(serviceID:String):String
		{
			var strServiceURL:String;
			
			//CHANGES FOR CALLING SERVICE FROM LOCAL XML
			var servicesList:XMLList = serviceXML.service.(@service_id == serviceID);

			// IF webserviceMode = local THEN IT WILL TAKE THE DATA FROM LOCAL XML
			if(settings.webserviceMode == "LOCAL")
			{
				var serviceName:String = servicesList.@service_name;
				
				//CHECK IF local_name IS GIVEN THEN USE IT
				if(servicesList.hasOwnProperty("@local_name"))
					serviceName = servicesList.@local_name;
				
				
				strServiceURL = settings.rootJsonFolderPath + serviceXML.@xml_url + serviceName + ".json";
			}
			else
			{
				if(serviceID == AppConstants.CLUSTER)
					strServiceURL = "http://" + settings.clusterServiceIP + settings.clusterServerFolderPath + servicesList.@service_name;
				else
					strServiceURL = "http://" + settings.serverIPAdress + settings.serverFolderPath + servicesList.@service_name;
			}
			
			currentServiceID = serviceID;
			return strServiceURL;
		}
		
		/**
		 * Returns web service/xml path as per the ID provided.
		 * ID is maintained as constants inside <code>AppConstants</code>
		 * */
		public function getClusterServicePath(item:ClusterVO):String
		{
			var strServiceURL:String;
			
			// IF webserviceMode = local THEN IT WILL TAKE THE DATA FROM LOCAL XML
			if(settings.webserviceMode == "LOCAL")
				strServiceURL = settings.rootJsonFolderPath + item.type + ".json";
			else
				strServiceURL = "http://" + settings.clusterServiceIP +  item.url;
			
			return strServiceURL;
		}
		
		
				
		/**
		 * Returns web service/xml path as per the ID provided.
		 * ID is maintained as constants inside <code>AppConstants</code>
		 * */
		public function getModuleServicePath(serviceID:String):String
		{
			var strServiceURL:String;
			var servicesList:XMLList = serviceXML.service.(@service_id == serviceID);
			// IF webserviceMode = local THEN IT WILL TAKE THE DATA FROM LOCAL XML
			if(settings.webserviceMode == "LOCAL")
				strServiceURL = settings.rootJsonFolderPath + serviceID + ".json";
			else
				strServiceURL = "http://" + settings.clusterServiceIP +  servicesList.@service_name;
			
			return strServiceURL;
		}
		
		/**
		 * Result handler - onResult
		 * 
		 */ 
		
		protected override function onResult(event:Event):void
		{
			super.onResult(event);
			var oXML:XML = XML(event.target.data);
			var xmlID:String = oXML.@id.toString() == "" ? currentServiceID : oXML.@id.toString();
			
			switch(xmlID)
			{
				
				case AppConstants.XML_CONFIG:
					initXMLConfig(oXML);
					break;
				case AppConstants.XML_SERVICES:
					serviceXML = oXML.copy();
					// TO DO - FECTCH THE lastUpdaetedTime from Persistence Manmager and have to pass as parameter for this webserive
					loadAppConfig(_configSettings.lastUpdatedTime);
					//dispatchEvent(new AppDataEvent(AppDataEvent.APP_XML_LOADED));
					break;
				case AppConstants.APP_CONFIG:
					var _data:Object =  JSON.parse(String(event.target.data));
					initAppData(_data);
					break;
				default:
					trace("default");
					break;
			}
			
		}
		
		/**
		 * Error handler - onResult
		 * 
		 */ 
		
		protected override function onError(event:IOErrorEvent):void
		{
			dispatchEvent(new AppErrorEvent(AppErrorEvent.NETWORK_FAILURE, null));
		}
		
		private function initXMLConfig(oXML:XML):void
		{
			_configSettings = new AppConfigVO();
			_configSettings.deviceType 					= oXML.settings.device_type;
			_configSettings.webserviceMode 				= oXML.settings.web_service_mode;
			_configSettings.webserviceDelay 			= Number(oXML.settings.web_service_delay);
			_configSettings.serverIPAdress 				= oXML.settings.server_ip_address + "/";
			_configSettings.serverFolderPath 			= oXML.settings.server_folder_path + "/";
			_configSettings.rootXmlFolderPath 			= oXML.settings.root_xml_folder_path + "/";
			_configSettings.rootJsonFolderPath 			= oXML.settings.root_json_folder_path + "/";
			_configSettings.servicesXmlPath 			= oXML.settings.services_xml_path;
			
			/*
			  Now the server_ip_address and cluster_service_ip would same,
			_configSettings.clusterServiceIP 			= oXML.settings.cluster_service_ip;
			
			Still contiang the code for the future....
			*/
			_configSettings.clusterServiceIP 			= oXML.settings.server_ip_address;

			_configSettings.clusterServerFolderPath 	= oXML.settings.cluster_server_folder_path + "/";
			
			// LOAD SERVICES XML NOW
			loadXML(settings.rootXmlFolderPath + settings.servicesXmlPath);
			
		}
		
		private function initAppData(data:Object):void
		{
		
			localSettings = new LocalAppConfigVO();
			localSettings.lastModified = data["last-modified"];
			
			if(_configSettings.deviceType == "m")
				localSettings.dateText = data["date-text"];
			
			localSettings.color1 = data["color1"];
			localSettings.color2 = data["color2"];
			localSettings.imageLogo = data["image-logo"];
			localSettings.imageBackgroud = data["image-background"];

			localSettings.hypeSharingText = data["hypeSharingText"];
			localSettings.imageHost = data["imageHost"];
			localSettings.videoHost = data["videoHost"];
			localSettings.feedbackURL = data["feedbackURL"];
			localSettings.termsOfUseURL = data["termsOfUseURL"];
			localSettings.privacyPolicyURL = data["privacyPolicyURL"];
			
			localSettings.tabletArticleCSS = data["tabletArticleCSS"];
			localSettings.mobileArticleCSS = data["mobileArticleCSS"];
			localSettings.showWatchESPNLogo = Boolean(data["showWatchESPNLogo"]);
			localSettings.watchESPNDefaultURL = data["watchESPNDefaultURL"];
			localSettings.webDomain = data["webDomain"];
			
			localSettings.patentsURL = data["patentsURL"];
			localSettings.internetBasedAdsURL = data["internetBasedAdsURL"];
			
			
			
			/*
			_configSettings.lastUpdatedTime = data.last-modified;
			_configSettings.isEventMode = data.globalAppConfig.isEventMode;
			_configSettings.isLocationFlag = data.globalAppConfig.locationFlag;
			_configSettings.isAlertsFlag = data.globalAppConfig.alertsFlag;
			*/
			
			dispatchEvent(new AppDataEvent(AppDataEvent.APP_CONFIG_LOADED));
		}
		
	} // end class
} // end package

//internal class SingletonEnforcer{}