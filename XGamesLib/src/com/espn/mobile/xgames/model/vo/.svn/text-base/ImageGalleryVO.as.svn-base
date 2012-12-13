package com.espn.mobile.xgames.model.vo
{
	import mx.utils.ObjectUtil;

	public class ImageGalleryVO
	{
		public var url:String;
		public var credit:String;
		public var width:Number; 
		public var height:Number;
		
		[Bindable]
		public var headline:String;
		
		[Bindable]
		public var description:String;
		
		public var shareUrl:String;
		
		public function toString():String
		{
			var str:String = "";
			for(var propCounter:uint; propCounter<ObjectUtil.getClassInfo(this).properties.length; propCounter++)
			{
				var item:String = ObjectUtil.getClassInfo(this).properties[propCounter];
				str += item + " " + this[item] + "\r";
			}
			
			return str;
		}
	}
}