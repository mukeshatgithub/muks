package com.espn.mobile.xgames.constants
{
	public class XAlertConstants
	{
		public static const BASE_URL:String = "http://api.espn.com/test/alerts/app/library/";
		
		// below URL is for testing only for production it would be: 
		// http://m.espn.go.com/mobile/apps/common/generateUUID
		public static const SWID_URL:String = "http://qam.espn.go.com/mobile/apps/common/generateUUID";
		public static const ALERT_DETAIL_URL:String = "http://api.espn.com/alerts/?alertId=";
		
		
		
		public static const TABLET_APP_ID:String = "&applicationId=30";
		public static const MOBILE_APP_ID:String = "&applicationId=19";
		public static const ESPN_API_KEY:String = "&apikey=mwdeyymst29eh6e7zqv34d5y";
		public static const ALERT_SHARED_SECRET:String = "N7fg237H4nPyp9dbtfHSrMqP"// not sure if this will be used or not
		public static const ALERT_REGISTER_DEVICE:String = "registerDevice";
		public static const QUERY_STRING:String = "?";
		public static const SWID:String = "&swid=";
		public static const PM_SWID:String = "swid";
		public static const SWID_START:String = "{";
		public static const SWID_END:String = "}";
		
		public static const FORMAT_IOS:String = "&format=ios";
		public static const ASPN_TOKEN:String = "&APNSToken=";
		
		public static const ALERTS_LOGIN:String = "enableAlerts";
		public static const ALERTS_LOGOUT:String = "disableAlerts";
		public static const FAVORITE_ALERTS_ON:String = "on";
		public static const FAVORITE_ALERTS_OFF:String = "off";
		public static const FAVORITE_ALERT_ON_OFF_KEY:String = "key=";
		
		public static const NOTIFICATION_TYPE_BREAKING_NEWS:String = "breakingNews";
		public static const NOTIFICATION_TYPE_VIDEO:String = "videoNotification";
		public static const NOTIFICATION_TYPE_ARTICLE:String = "articleNotification";
		
		
		
		
	}
}