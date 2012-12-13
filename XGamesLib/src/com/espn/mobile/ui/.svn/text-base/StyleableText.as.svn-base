//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.ui
{
	import spark.components.Label;
	
	/**
	 * Styleable Text is a text component which changes color based on theme being used.
	 */	
	public class StyleableText extends Label
	{
		private var _styleChangedFlag:Boolean = true;
		
		/**
		 * Class constructor.
		 */	
		public function StyleableText()
		{
			super();
		}
		
		/**
		 * override method for check change in style for the component.
		 */	
		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			
			if(styleProp == "themeColor")
			{
				_styleChangedFlag = true;
			}
			
		}
		
		/**
		 * override method for setting custom style.
		 */	
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(_styleChangedFlag)
			{
				this.setStyle("color", getStyle("themeColor"));
				_styleChangedFlag = false;
			}
			
		}
		
		/**
		 * override method for setting theme color in the component.
		 */	
		override protected function childrenCreated():void
		{
			this.setStyle("color", getStyle("themeColor"));
		}
	}
}