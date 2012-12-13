//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model.vo
{
	
	/**
	 * AppConfigVO
	 */
	
	[Bindable]
	[RemoteClass(alias="configSettings")]
	[Entity]
	public class AppConfigVO
	{
		/** webserviceMode  */
		public var webserviceMode:String;

		/** webserviceDelay  */
		public var webserviceDelay:Number;

		/** serverIPAdress */
		public var serverIPAdress:String;
		
		/** serverFolderPath */
		public var serverFolderPath:String;

		/** deviceType */
		public var deviceType:String;

		/** rootXmlFolderPath */
		public var rootXmlFolderPath:String;

		/** rootJSONFolderPath */
		public var rootJsonFolderPath:String;

		/** servicesXmlPath */
		public var servicesXmlPath:String;

		/** clusterServicePath */
		public var clusterServiceIP:String;
		
		/** video url prefix */
		public var videoUrlPrefix:String = "http://api.espn.com/v1/video/clips/{id}?apikey=ax34uywpzdzvfyjctpebzjdc";

		/** clusterServerFolderPath */
		public var clusterServerFolderPath:String;
		
		/** image url prefix */
		public var imageUrlPrefix:String = "a.espncdn.com";

		[Id]
		public var Id:String;
		
		//public var languges:Array;
		
		public var lastUpdatedTime:String = "";
		public var isEventMode:Boolean = false;
		public var isLocationFlag:String = "";
		public var isAlertsFlag:Boolean = false;

		
		public var feedbackURL:String = "";
		public var termsOfUseURL:String = "";
		public var privacyPolicyURL:String = "";
		public var splashScreenURL:String = "";
		
		// INTERNAL USE - would not be updated by service
		public var isEventModeThemeCached:Boolean = false;
		
		
	}
}