package com.espn.mobile.xgames.model.vo
{
	import flash.media.Video;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;

	[Bindable]
	public class CompetitorVO
	{
		
		public var id:String; 
		public var name:String; 
		public var gender:String;
		public var photoURL:String;
		public var rank:uint;
		public var athleteLink:String;
		public var scores:ArrayCollection;
		public var bestScore:Number;
		public var bestVideo:VideoItemVO;
		public var country:String;
		public var flagImg:String;
		
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