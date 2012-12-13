//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.ui
{
	import mx.core.FlexGlobals;
	
	import spark.primitives.BitmapImage;
	
	[Style(name="source",type="String",format="String",inherit="no")]
	
	/**
	 * Styleable Bitmap Image class creates a bitmap which is embedded in the dymanically loaded CSS File.
	 */	
	public class StyleableBitmapImage extends BitmapImage
	{
		
		private var _styleName:String; 
		
		/**
		 * Constructor of the class.
		 */	
		public function StyleableBitmapImage()
		{
			super();
		}
		
		/**
		 * Setter for setting the stylename for the class.
		 */	
		public function set styleName(s:String):void
		{
			_styleName = "."+s;
			
			if(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(_styleName))
				this.source = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(_styleName).getStyle("source");
		}
		
		/**
		 * Getter of the style name.
		 */	
		[Bindable]
		public function get styleName():String
		{
			return _styleName;
		}
		
		/**
		 * Method to define style for this component.
		 */	
		public function setStyle(property:String, value:Object):void
		{
			if (property == "source")
				this.source = value;
		}
		
		
		/**
		 * Override method to perform custom styling for the component.
		 */	
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(_styleName && FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(_styleName))
				this.source = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(_styleName).getStyle("source");
		}
		
	}
}