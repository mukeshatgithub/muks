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
	public class LocalAppConfigVO
	{
		public var lastModified:String;
		public var dateText:String;
		public var color1:String;
		public var color2:String;
		public var imageLogo:String;
		public var imageBackgroud:String;
		public var hypeSharingText:String;
		public var imageHost:String;
		public var videoHost:String;

		public var feedbackURL:String;
		public var termsOfUseURL:String;
		public var privacyPolicyURL:String;
		
		public var localLogoURL:String;
		public var localBackgroundURL:String;
		
		public var tabletArticleCSS:String;
		public var mobileArticleCSS:String;
		public var showWatchESPNLogo:Boolean;
		public var watchESPNDefaultURL:String;
		public var webDomain:String;
		
		public var internetBasedAdsURL:String;
		public var patentsURL:String;
		
		public var isAlertSettingsOn:Boolean;
		public var showRealSeriesScreen:Boolean;
		public var showHelpScreen:Boolean;
		public var showMenuOpenScreen:Boolean;
		public var hideRealIntroPopUp:Boolean;
		
	}
}