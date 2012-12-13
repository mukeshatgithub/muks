//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.ui.comp
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import mx.flash.UIMovieClip;
	
	import spark.components.Group;
	import spark.primitives.BitmapImage;
	
	public class StyleableIcon extends Group
	{
		
		private var _enableDownState:Boolean = false;

		public function get enableDownState():Boolean
		{
			return _enableDownState;
		}

		public function set enableDownState(value:Boolean):void
		{
			_enableDownState = value;
		}


		/**
		 * Boolean to use alternate theme color
		 **/
		private var _isIconTypeChanged:Boolean = false;
		
		/**
		 * ColorTransform 
		 */		
		private var colorTransform:ColorTransform;
		
		/**
		 * Use alternate theme color
		 **/
		
		private var _useAlternateThemeColor:Boolean;

		
		/**
		 *	BitmapImage instance to display the icon 
		 */		
		//private var iconDisplay:BitmapImage;
		
		/**
		 * styleChangedFlag
		 */		
		private var _styleChangedFlag:Boolean = true;

		/**
		 * styleChangedFlag
		 */		
		private var themeColorChanged:Boolean = false;
		
		private var _iconColor:uint;

		/**
		 * icon color 
		 */
		public function set iconColor(value:uint):void
		{
			_iconColor = value;
			invalidateDisplayList();
		}
	
		
		/**
		 * icon color 
		 */
		public function get iconColor():uint
		{
			return _iconColor;
		}
		
		/**
		 *	isThemeStyleable 
		 */		
		public var isThemeStylable:Boolean = true;
		
		/**
		 *	scale factor for MultiDPI 
		 */		
		public var scaleFactor:Number = 1;
		
		private var _hitArea:HitArea;
		
		/**
		 *	constructor 
		 * 
		 */		
		public function StyleableIcon()
		{
			super();
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage,false, 0, true);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown,false,0, true);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp,false,0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut,false,0, true);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut,false,0, true);
		}
		
		protected function onRemovedFromStage(event:Event):void
		{
			this.removeAllElements();
			colorTransform = null; 
			icon = null;
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage); 
			
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
		}
		
		private var _data:Object;

		/**
		 * Variable to hold any data for this object
		 **/
		public function get data():Object
		{
			return _data;
		}

		/**
		 * @private
		 */
		public function set data(value:Object):void
		{
			_data = value;
		}

		
		/**
		 * 
		 * @override
		 * 
		 */
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		/**
		 * icon property to store the UIMovieClip of StyleableIcon
		 */		
		private var _icon:UIMovieClip;
		
		/**
		 * 
		 * @param value
		 * 
		 * icon setter
		 * 
		 */		
		public function set icon(value:UIMovieClip):void
		{
			/*if(_icon && getElementIndex(_icon) != -1)
			{
				removeElement(_icon);
			}*/
			
			if(_icon != value)
			{
				removeAllElements();
				_icon = value;
				_isIconTypeChanged = true;
				invalidateProperties();
				invalidateDisplayList();
			}
			
		}
		
		/**
		 * 
		 * @return
		 * icon getter 
		 * 
		 */		
		public function get icon():UIMovieClip
		{
			return _icon;
		}
		
		
		/**
		 *	flag to check if styleable icon has arrow or not 
		 */		
		private var _hasArrow:Boolean = true;

		public function set hasArrow(value:Boolean):void
		{
			_hasArrow = value;
			
			invalidateProperties();
		}
		
		public function get hasArrow():Boolean
		{
			return _hasArrow;
		}
		
		/**
		 * 
		 * @override
		 * 
		 */		

		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			
			if(styleProp == "scaleFactor" || styleProp == "themeColor" )
			{
				_styleChangedFlag = true;
			}
		}
		
		/**
		 * 
		 *	@override 
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
	
			
			if(icon && _isIconTypeChanged)
			{
				addElement(icon);
				_isIconTypeChanged = false;
			}
			
			if(icon && icon.getChildByName('base') && (icon.getChildByName("base") as MovieClip).getChildByName("arrow"))
			{
				(icon.getChildByName("base") as MovieClip).getChildByName("arrow").visible = hasArrow;
			}
			
			if(icon && isThemeStylable && !themeColorChanged)
			{
				colorTransform = new ColorTransform(); 
				colorTransform.color = getStyle("themeColor");
				if (icon.getChildByName("base") !=null)
					icon.getChildByName("base").transform.colorTransform = colorTransform;
			}
			if (_hasHitArea)
			{
				_hitArea = new HitArea();
				//Uncomment line below to test hit area visibility and area.
				//_hitArea.hitAlpha = 0.5;
				_hitArea.percentHeight = _hitArea.percentWidth = 160;
				addElement(_hitArea);
			}
			
			
		}
		
		private function onMouseDown(event:MouseEvent) : void {
			if(icon && enableDownState) icon.alpha = 0.5;
		}
		
		private function onMouseUp(event:MouseEvent) : void {
			if(icon && enableDownState) icon.alpha = 1;
		}
		
		private function onMouseOut(event:MouseEvent) : void {
			if(icon && enableDownState) icon.alpha = 1;
		}
		
		private function onRollOut(event:MouseEvent) : void {
			if(icon && enableDownState) icon.alpha = 1;
		}
		
		
		private var _hasHitArea:Boolean = false;

		public function get hasHitArea():Boolean
		{
			return _hasHitArea;
		}

		public function set hasHitArea(value:Boolean):void
		{
			_hasHitArea = value;
		}

		
		/**
		 * 
		 * @override
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			scaleFactor = getStyle("scaleFactor");
			
			if (icon && !isNaN(scaleFactor))
			{
				
				icon.scaleX = icon.scaleY = scaleFactor;
				this.measuredWidth = icon.width * scaleFactor;
				this.measuredHeight = icon.height  * scaleFactor;
			}
			
			if (themeColorChanged)
			{
				colorTransform = new ColorTransform(); 
				colorTransform.color = getStyle("alternateThemeColor");
				if (icon.getChildByName("base") !=null)
					icon.getChildByName("base").transform.colorTransform = colorTransform;
				themeColorChanged = false;
			}
			
			if(_iconColor)
			{
				colorTransform = new ColorTransform(); 
				colorTransform.color = _iconColor;
				if (icon.getChildByName("base") !=null)
					icon.getChildByName("base").transform.colorTransform = colorTransform;
				themeColorChanged = false;
			}
			
			/*if(_styleChangedFlag)
			{
				scaleFactor = getStyle("scaleFactor");

				if (icon && !isNaN(scaleFactor))
				{
					this.width = width*scaleFactor;
					this.height = height*scaleFactor;
					icon.scaleX = icon.scaleY = scaleFactor
				}
			
						
				if(icon && isThemeStylable)
				{
					colorTransform = new ColorTransform(); 
					colorTransform.color = getStyle("themeColor");
					if (icon.getChildByName("base") !=null)
						icon.getChildByName("base").transform.colorTransform = colorTransform;
				}
				
				_styleChangedFlag = false;
			}*/
			
		}

		/**
		 * getter for using alternate theme color 
		 */
		public function get useAlternateThemeColor():Boolean
		{
			return _useAlternateThemeColor;
		}

		/**
		 * setter for using alternate theme color 
		 */
		public function set useAlternateThemeColor(value:Boolean):void
		{
			_useAlternateThemeColor = value;
			themeColorChanged = true; 
			if (initialized)
			{
				if(icon && isThemeStylable)
				{
					colorTransform = new ColorTransform(); 
					colorTransform.color = getStyle("alternateThemeColor");
					if (icon.getChildByName("base") !=null)
						icon.getChildByName("base").transform.colorTransform = colorTransform;
					themeColorChanged = false;
				}
			}
		}
		
		
	}
}