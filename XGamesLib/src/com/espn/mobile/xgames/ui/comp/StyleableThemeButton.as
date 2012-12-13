package com.espn.mobile.xgames.ui.comp
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mx.flash.UIMovieClip;
	
	import spark.components.Group;
	import spark.components.Label;
	
	public class StyleableThemeButton extends Group
	{
		 
		
		//-------------------------------------------------------------------------
		// Private Variables
		//-------------------------------------------------------------------------
		
		/**
		 *	button width 
		 */		
		private var _buttonWidth:Number = 0;
		
		/**
		 *	minimnum width 
		 */		
		private var _minimumWidth:Number = 100;
		
		/**
		 *	minimum width change flag 
		 */		
		private var _minimumWidthChanged:Boolean = false;

		/**
		 *	scale factor for Multi DPI 
		 */		
		private var _scaleFactor:Number = 1;
		
		/**
		 *	label change flag 
		 */		
		private var _labelChanged:Boolean = false;

		/**
		 *	padding 
		 */		
		private var _padding:Number = 15;
		
		/**
		 *	padding change flag 
		 */		
		private var _paddingChanged:Boolean = false;
		
		/**
		 *	arrow change flag 
		 */		
		private var _hasArrowChanged:Boolean = true;
		
		/**
		 * selection chanage flag 
		 */		
		private var _selectedChanged:Boolean = false;
		
		/**
		 *	style change flag 
		 */		
		private var _styleChangedFlag:Boolean = true;

		
		//-------------------------------------------------------------------------
		// Public Variables
		//-------------------------------------------------------------------------

		/**
		 *	arrow position constant 
		 */
		public static const TOP:String = "top"; 
		/**
		 *	arrow position constant 
		 */
		public static const BOTTOM:String = "bottom"; 
		/**
		 *	arrow position constant 
		 */
		public static const LEFT:String = "left"; 
		/**
		 *	arrow position constant 
		 */
		public static const RIGHT:String = "right"; 

		
		//-------------------------------------------------------------------------
		// Children Components
		//-------------------------------------------------------------------------
		
		/**
		 *	icon state when not selected
		 */		
		public var upIcon:StyleableIcon; 
		
		/**
		 *	icon state when selected
		 */		
		public var downIcon:StyleableIcon;
		
		/**
		 *	label container 
		 */		
		private var labelContainer:Group;
		
		/**
		 *	label component 
		 */		
		public var labelField:Label; 
		
		/**
		 *	hit area for StyleableThemeButton 
		 */		
		private var customHitArea:HitArea;
		
		/**
		 *	source property for up icon 
		 */		
		private var _upIconSrc:UIMovieClip
		
		public function set upIconSrc(value:UIMovieClip):void
		{
			_upIconSrc = value;
			invalidateProperties();
		}

		/**
		 *	source property for down icon 
		 */		
		private var _downIconSrc:UIMovieClip;

		public function set downIconSrc(value:UIMovieClip):void
		{
			_downIconSrc = value;
			invalidateProperties();
		}

		/**
		 *	constructor 
		 * 
		 */		
		
		public function StyleableThemeButton()
		{
			super();
		}
		
		public function set minimumWidth(value:Number):void
		{
			_minimumWidth = value;
			_minimumWidthChanged = true;
			
			invalidateDisplayList();
		}

		public function set padding(value:Number):void
		{
			this._padding = value;
			_paddingChanged = true; 
			if (initialized)
			{
				updateDisplayList(unscaledWidth, unscaledHeight); 
				_paddingChanged = false;
			}
		}
		
		public function get padding():Number
		{
			return _padding;
		}
		
		/**
		 *	label property of StyleableThemeButton 
		 */		
		private var _label:String = "BUTTON NAME";
		
		

		public function set label(text:String):void
		{
			_label = text; 
			_labelChanged = true;
			if (initialized)
			{
				labelField.text = _label; 
				validateDisplayList();
				_labelChanged = false;
			}
		}
		
		public function get label():String
		{
			return _label;
		}
		
		/**
		 *	arrow position 
		 */
		private var _arrowPosition:String;
		
		/**
		 *	arrow position change holder
		 */
		private var arrowPositionChanged:Boolean = false;
		
		

		/**
		 *	get the arrow position 
		 */
		public function get arrowPosition():String
		{
			return _arrowPosition;
		}

		/**
		 *	set the arrow position 
		 */
		public function set arrowPosition(value:String):void
		{
			_arrowPosition = value;
			arrowPositionChanged = true; 
			if (initialized) 
			{
				invalidateDisplayList();
				arrowPositionChanged = false;
			}
			
		}
		
		

		
		/**
		 *	flag to check if the StyleableThemeButton has arrow or not 
		 */		
		private var _hasArrow:Boolean = true;
		
		public function set hasArrow(value:Boolean):void
		{
			_hasArrow = value; 
			_hasArrowChanged = true;
			if (initialized)
			{
				downIcon.hasArrow = value;
				_hasArrowChanged = false;
				
				invalidateProperties();
			}
		}
		
		public function get hasArrow():Boolean
		{
			return _hasArrow;
		}
		
		/**
		 *	StyleableThemeButton selection property
		 */		
		private var _selected:Boolean = false;
		
		public function set selected(value:Boolean):void
		{
			_selected = value; 
			_selectedChanged = true; 
			if (initialized) 
			{
				downIcon.visible = _selected; 
				upIcon.visible = !_selected;
				_selectedChanged = false;
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}		
		
		/**
		 *	@override 
		 * 
		 */		
		override protected function createChildren():void
		{
			super.createChildren();

			upIcon = new StyleableIcon(); 
			upIcon.isThemeStylable = false;
			//upIcon.icon = IconFactory.getIcon(IconFactory.ARROW_BUTTON_UP);
			addElement(upIcon);
			
			downIcon = new StyleableIcon(); 
			//downIcon.icon = IconFactory.getIcon(IconFactory.ARROW_BUTTON_DOWN);
			addElement(downIcon); 
			downIcon.visible = false;
			
			labelContainer = new Group();
			labelContainer.percentWidth = 100;
			labelContainer.percentHeight = 100;
			labelContainer.verticalCenter = 0;
			addElement(labelContainer);

			labelField = new Label(); 
			labelField.verticalCenter = 0;
			labelField.horizontalCenter = 0;
			labelField.percentHeight = 100;
			labelField.setStyle('verticalAlign', 'middle');
			labelField.text = _label;
			labelContainer.addElement(labelField);

			customHitArea = new HitArea();
			addElement(customHitArea);
			
			//customHitArea.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown,false, 0, true);
			customHitArea.addEventListener(MouseEvent.MOUSE_UP, onMouseUp,false, 0, true);
			//customHitArea.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp,false, 0, true);
		}
		

		/**
		 * 
		 * @override
		 * 
		 */		
		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			
			if(styleProp == "scaleFactor" )
			{
				_styleChangedFlag = true;
			}
			
		}
		
		/**
		 *	@override 
		 * 
		 */		
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(upIcon)
				upIcon.icon = _upIconSrc;
			
			if(downIcon)
				downIcon.icon = _downIconSrc;
			
			if (_hasArrowChanged && downIcon.icon)
			{
				/*(downIcon.icon.getChildByName("base") as MovieClip).getChildByName("arrow").visible = _hasArrow;
				downIcon.invalidateProperties();*/
				downIcon.hasArrow = hasArrow;
				_hasArrowChanged = false;
			}
			if (_selectedChanged)
			{
				downIcon.visible = _selected; 
				upIcon.visible = !_selected;
				_selectedChanged = false;
			}		
		}
		
		/**
		 * 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 * @override
		 * 
		 */		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
			if(_styleChangedFlag)
			{
				
				if(!isNaN(getStyle("scaleFactor")))
				{
					_scaleFactor = getStyle("scaleFactor");
					minimumWidth = _minimumWidth * _scaleFactor;
				}
				_styleChangedFlag = false;
			}
			
			if (labelField.measuredWidth > upIcon.measuredWidth || _minimumWidthChanged)
			{
				_buttonWidth = labelField.measuredWidth + _padding;
				
				if (_buttonWidth < _minimumWidth)
					_buttonWidth = _minimumWidth;
				
				
				var tempWidth:Number = _buttonWidth / _scaleFactor;
				
				var labelBottomPosistion:Number = 0;
				
				if(upIcon.icon)
					upIcon.icon.getChildByName("base").width = tempWidth;
				
				if(downIcon.icon)
					(downIcon.icon.getChildByName("base") as MovieClip).getChildByName("box").width = tempWidth;
				var arrowIcon:MovieClip
				if(downIcon.icon && downIcon.icon.getChildByName('base') && (downIcon.icon.getChildByName("base") as MovieClip).getChildByName("arrow"))
				{
					arrowIcon = (downIcon.icon.getChildByName("base") as MovieClip).getChildByName("arrow") as MovieClip;
					arrowIcon.x = tempWidth/2;
				}
				
				if(downIcon.icon && downIcon.icon.getChildByName("gradient"))
					downIcon.icon.getChildByName("gradient").width = tempWidth;
				
				customHitArea.width = _buttonWidth;
				this.width = _buttonWidth;
				labelField.text = _label;
				_paddingChanged = false;
				_labelChanged = false; 
				_minimumWidthChanged = false;
				if (hasArrow && arrowIcon && arrowPositionChanged)
				{
					positionArrow(arrowIcon);
					arrowPositionChanged = false;
					labelBottomPosistion = arrowIcon.height;
				}
				
				if(labelContainer)
					labelContainer.verticalCenter = -2*_scaleFactor;
				
			}
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		private function positionArrow(arrowIcon:MovieClip):void
		{
			switch (arrowPosition)
			{
				case BOTTOM:
					//do nothing
					break; 
				case TOP:
					arrowIcon.rotation = -180;
					arrowIcon.x = _buttonWidth/2; 
					arrowIcon.y = 1; 
					break; 
				case LEFT:
					arrowIcon.rotation = 90;
					arrowIcon.x = 0; 
					arrowIcon.y = upIcon.measuredHeight/2; 
					break; 
				case RIGHT:
					arrowIcon.rotation = -90;
					arrowIcon.x = unscaledWidth/getStyle('scaleFactor');
					arrowIcon.y = upIcon.measuredHeight/2;
					break; 
			}
		}
		
		
		/**
		 * 
		 * mouse up event handler
		 * 
		 */		
		protected function onMouseUp(event:MouseEvent):void
		{
			//if (_selected) return;
			downIcon.visible = _selected; 
			upIcon.visible = !_selected;
		}
		
	}
}