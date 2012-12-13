//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * Value object to store a single pulse Item data
	 */	
	public class PulseItemVO
	{
		public static const TWITTER:String = "tweet";
		public static const VIDEO_ARTICLE:String = "video";
		public static const PHOTO_ARTICLE:String = "photo_article";
		public static const INTERVIEW_ARTICLE:String = "interview_article";
		public static const ARTICLE_PAGE:String = "article";
		public static const PHOTO_GALLERY:String = "gallery";
		public static const SPOTIFY:String = "spotify";
		public static const FACEBOOK:String = "facebook";
		public static const INSTAGRAM:String = "instagram";
		public static const PODCAST:String = "podcast";
		public static const GEAR:String = "gear";
		public static const YOUTUBE:String = "youtube";

		
		public var id:String;
		public var title:String;
		public var type:String;
		public var link:String;
		public var items:ArrayCollection;
		public var videoID:String;
		public var instagramImageURL:String;
		public var instagramProfileURL:String;
		
		public var tweetDescription:String;
		public var tweetId:String;
		public var tweetAuthorName:String;
		public var tweetIconUrl:String;
		public var contentHTML:String;
		
		[Bindable]
		public var selectedVideoItem:VideoItemVO;
		
	}
}