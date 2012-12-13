package com.espn.mobile.xgames.model.vo
{
	import mx.utils.ObjectUtil;

	public class ContestantVO
	{
		public var id:Number;
		private var _name:String; 

		[Bindable]
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value.toUpperCase();
		}

		public var athleteURL:String; 
		
		public var photoURL:String;
		public var videoItem:VideoItemVO; 
		public var title:String; 
		public var voteCount:Number; 
		public var votePercentage:Number; 
		public var etc:String;
		
		public var athleteId:String;
		
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