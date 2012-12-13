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
	import spark.primitives.BitmapImage;
	
	[Style(name="upImage", type="Class", format="EmbeddedFile")]
	[Style(name="downImage", type="Class", format="EmbeddedFile")]
	
	/**
	 * Styleable Button class creates a button which consists of two bitmaps which are embedded in the dynamically loaded CSS File.
	 */	
	public class StyleableButton extends Group
	{
		public var upImage:StyleableBitmapImage; 
		public var downImage:StyleableBitmapImage;

		private var _styleName:String;
		private var _styleNameChanged:Boolean = false;
		private var _selected:Boolean = false;
		private var _selectedChanged:Boolean = false;
		
		/**
		 * Constructor of the class.
		 */	
		public function StyleableButton()
		{
			super();
		}
		
		/**
		 * Override to create additional children as per need.
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			upImage = new StyleableBitmapImage(); 
			downImage = new StyleableBitmapImage(); 
			addElement(downImage); 
			addElement(upImage);
			downImage.visible = false;
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown,false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseUp,false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp,false, 0, true);
		}
		
		/**
		 * override method to execute custom logic.
		 */	
		override protected function childrenCreated():void
		{
			
			if(_styleName)
			{
				upImage.source = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(_styleName).getStyle("upImage")
				downImage.source = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(_styleName).getStyle("downImage")
			}
			else
			{
				upImage.source = getStyle("upImage");
				downImage.source = getStyle("downImage");
			}
			
			_styleNameChanged = false;

			if (_selectedChanged)
			{
				downImage.visible = _selected; 
				upImage.visible = !_selected;
				_selectedChanged = false;
			}
			
		}
		
		/**
		 * Override method to check style change and execute specific custom logic.
		 */	
		override public function styleChanged(styleProp:String):void
		{
			
			super.styleChanged(styleProp);
			if(initialized)
			{
				childrenCreated();
			}
		}
		
		
		/**
		 * Event handler for mouse interaction.
		 */	
		protected function onMouseUp(event:MouseEvent):void
		{
			if (_selected) return;
			downImage.visible = false; 
			upImage.visible = true;
		}
		
		/**
		 * Event handler for mouse interaction.
		 */	
		protected function onMouseDown(event:MouseEvent):void
		{
			downImage.visible = true; 
			upImage.visible = false;
		}
		
		
		/**
		 * override method for custom style implementation.
		 */	
		override public function set styleName(s:Object):void
		{
			super.styleName = s;
			_styleName = "."+s;
			_styleNameChanged = true;
			if (initialized)
			{
				upImage.source = getStyle("upImage");
				downImage.source = getStyle("downImage");

				_styleNameChanged = false;
			}
		}
		
		/**
		 * override getter.
		 */	
		override public function get styleName():Object
		{
			return _styleName;
		}
		
		/**
		 * Setter for toggling the selected property of the component.
		 */	
		public function set selected(value:Boolean):void
		{
			_selected = value; 
			_selectedChanged = true; 
			if (initialized) 
			{
				downImage.visible = _selected; 
				upImage.visible = !_selected;
				_selectedChanged = false;
			}
		}
		
		/**
		 * Getter for the selected property of the component.
		 */	
		public function get selected():Boolean
		{
			return _selected;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight); 
			if (_selectedChanged)
			{
				downImage.visible = _selected; 
				upImage.visible = !_selected;
				_selectedChanged = false;
			}
		}
		
	}
}