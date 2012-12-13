//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.ui
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.Label;
	import spark.primitives.BitmapImage;
	
	[Style(name="iconImage", type="Class", format="EmbeddedFile")]
	
	
	/**
	 * Styleable Button class creates a button which consists of two bitmaps which are embedded in the dynamically loaded CSS File.
	 */	
	public class StyleableMenuButton extends Group
	{
		public var iconImage:StyleableBitmapImage; 
		
		public var labelField:Label;
		
		private var _scaleFactor:Number = 1;

		
		private var _label:String;
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			_label = value;
		}
		
		/**
		 * Constructor of the class.
		 */	
		public function StyleableMenuButton()
		{
			super();
			
			if(!isNaN(getStyle("scaleFactor")))
				_scaleFactor = getStyle("scaleFactor");

		}

		
		

		/**
		 * Override to create additional children as per need.
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			
			iconImage = new StyleableBitmapImage(); 
			iconImage.horizontalCenter = 0;
			iconImage.source = getStyle("iconImage");
			addElement(iconImage); 

			labelField = new Label(); 
			labelField.bottom = 8 * _scaleFactor;
			labelField.horizontalCenter = 0;
			
			labelField.text = _label;
			addElement(labelField);
					
			//labelField.verticalCenter = 12*_scaleFactor
			//labelField.horizontalCenter = 0;
			
		}
		
		
	}
}