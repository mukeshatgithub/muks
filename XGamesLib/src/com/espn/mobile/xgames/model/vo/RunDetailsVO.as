package com.espn.mobile.xgames.model.vo
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;

	[Bindable]
	public class RunDetailsVO
	{
		
		public var detailType:String;
		public var attempts:ArrayCollection;

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