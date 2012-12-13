//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.ui.comp
{
	import com.espn.mobile.xgames.events.StyleableGridRowEvent;
	import com.espn.mobile.xgames.model.vo.ScheduleItemVO;
	import com.espn.mobile.xgames.model.vo.XFavoriteVO;
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.events.MouseEvent;
	import flash.net.getClassByAlias;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.Label;
	import spark.primitives.BitmapImage;
	
	/**
	 * Border color
	 * 
	 */	
	[Style(name="rowBorderColor", inherit="no", type="uint")]
	
	/**
	 * 
	 * Border weight
	 */	
	[Style(name="rowBorderWeight", inherit="no", type="number")]
	
	/**
	 * 
	 * row background color
	 */	
	[Style(name="rowBackgroundColor", inherit="no", type="uint")]
	
	/**
	 * 
	 * cell text align
	 */	
	[Style(name="cellTextAlign", inherit="no", type="String", enumeration="left,center,right")]
	
	/**
	 * 
	 * up star icon source
	 */	
	[Style(name="upIconSrc", inherit="no", type="Object")]
	
	/**
	 * 
	 * down star icon source
	 */	
	[Style(name="downIconSrc", inherit="no", type="Object")]
	
	/**
	 * 
	 * cell text color
	 */	
	[Style(name="cellTextColor", inherit="no", type="uint")]
	
	/**
	 * Background alpha 
	 * 
	 */	
	[Style(name="rowBackgroundAlpha", inherit="no", type="uint")]
	
	/**
	 * 
	 * Watch ESPN logo align
	 */	
	[Style(name="watchESPNLogoAlign", inherit="no", type="String", enumeration="top,middle,bottom")]
	
	/**
	 * 
	 * Padding Left
	 */	
	[Style(name="cellPaddingLeft", inherit="no", type="number")]
	
	/**
	 * 
	 * Padding Right
	 */	
	[Style(name="cellPaddingRight", inherit="no", type="number")]
	
	
	/**
	 * 
	 * @author rmish8
	 * StyleableGridRowHeader class
	 */	
	public class StyleableGridRow extends Group
	{
		/**
		 *	constructor 
		 * 
		 */		
		public function StyleableGridRow(isHeader:Boolean = false)
		{
			super();
			this.isHeader = isHeader;
			scaleFactor =  getStyle('scaleFactor');
		}
		
		[Inject(source="xModel.favoriteList", bind="true")]
		public function set favoriteList(value:ArrayCollection):void
		{
			isFavorite = false;
			if(value) {
				//trace("favoriteList in gridrow:" + value.length + ": "  + value);
				if(rowData) {
					var schVO:ScheduleItemVO = rowData as ScheduleItemVO;
					if(schVO && schVO.eventId) {
						for(var favCount:int = 0;favCount < value.length; favCount++) {
							var xFavoriteVO:XFavoriteVO = value.getItemAt(favCount) as XFavoriteVO;
							if(xFavoriteVO && xFavoriteVO.favId == schVO.eventId) {
								isFavorite = true;
								break;
							}
						}
					}
					
				}
			}
		}
		
		/**
		 *	flag for column number change 
		 */		
		private var numColChanged:Boolean = false;
		
		/**
		 *	Button Object 
		 */		
		private var buttonObject:UIComponent;
		
		/**
		 * scale factor 
		 */		
		private var scaleFactor:Number = 1;
		
		
		/**
		 *	Icons array
		 */		
		private var icons:Array;
		
		/**
		 *	number of columns 
		 */		
		private var numCols:int;
		
		
		/**
		 * check if row is a header 
		 */
		private var isHeader:Boolean = false;
		
		public var favoriteField:String;
		
		public var calculatedHeight:Number;
		
		[Bindable]
		public var isFavorite:Boolean = false;
		
		
		private var _columns:Array;
		
		/**
		 * @private
		 * columns in the header 
		 */
		public function set columns(value:Array):void
		{
			if(!value || value == _columns)
				return;
			
			_columns = value;
			numColChanged = true;
			icons = new Array();
			numCols = _columns.length;
		}
		
		
		private var _columnField:String;
		
		/**
		 * @private
		 * column field 
		 * 
		 */
		public function set columnField(value:String):void
		{
			_columnField = value;
		}
		
		
		private var _rowData:Object;
		
		public function get rowData():Object
		{
			return _rowData;
		}
		
		/**
		 *	row data 
		 * 
		 */
		public function set rowData(value:Object):void
		{
			if(!value || value == _rowData)
				return;
			
			_rowData = value;
			invalidateProperties();
		}
		
		private var _rowIndex:int;
		
		/**
		 * row index 
		 */
		public function get rowIndex():int
		{
			return _rowIndex;
		}
		
		/**
		 * @private
		 */
		public function set rowIndex(value:int):void
		{
			_rowIndex = value;
		}
		
		
		private var _borderSides:String
		private var watchESPNGroup:Group;
		private var watchESPNBitmapGroup:Group;
		
		[Inspectable(category="General", enumeration="TRBL,T---,TR--,TRB-,-RBL,--BL,---L,TR-L,TR--,-RB-,-R--,--B-", defaultValue="false")]
		/**
		 *	@private 
		 * 	border sides
		 */
		public function get borderSides():String
		{
			return _borderSides;
		}
		
		/**
		 * @private
		 */
		public function set borderSides(value:String):void
		{
			_borderSides = value;
		}
		
		
		/**
		 *	@override 
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(numColChanged && _columns && _columns.length > 0)
			{
				createCols();
				numColChanged = false;
			}
		}
		
		/**
		 *	create columns 
		 */		
		private function createCols():void
		{
			scaleFactor = getStyle('scaleFactor');
			for(var i:int = 0; i < numCols; i++)
			{
				var cell:Label = new Label();
				cell.percentWidth = 80;
				//cell.percentHeight = 100;
				/*if (_columns[i].hasOwnProperty('percentWidth'))
				{
				cell.width = 270 * scaleFactor;
				}*/
				//cell.maxDisplayedLines = 1;
				if (height < cell.getPreferredBoundsHeight())
					height = cell.height;
				if(isHeader)
				{
					if(_columns[i].headerText)
						cell.text = _columns[i].headerText
					else
						cell.text = "";
				}
				else
				{
					if (_columns[i].hasOwnProperty("button") && _columns[i].hasOwnProperty("className"))
					{
						//Insert a button instead of a text field
						//button placing is done in updateDisplayList method override
						var buttonClass:Class = getClassByAlias( _columns[i].className ) as Class;
						if( buttonClass != null ) 
						{
							buttonObject = UIComponent( new buttonClass() );
							if( buttonObject.hasOwnProperty( "label" ) )
								buttonObject[ "label" ].text = String(_columns[i].buttonLabel);
							buttonObject.id = String(i);
							buttonObject.addEventListener(MouseEvent.CLICK, onColButtonClick);
							this.addElement( buttonObject );
						}
					}
					else 
					{
						cell.text = String(_rowData[_columns[i].columnField]);
					}
				}
				
				cell.setStyle('paddingTop', 5);
				if (_columns[i].textAlign == "center")
				{
					cell.setStyle('paddingLeft', 0);
					cell.setStyle('paddingRight', 0);
				}
				else
				{
					cell.setStyle('paddingLeft', getStyle('cellPaddingLeft'));
					cell.setStyle('paddingRight', getStyle('cellPaddingRight'));
				}
				//cell.setStyle('paddingBottom', 5);
				cell.verticalCenter = 0;
				cell.setStyle('textAlign', _columns[i].textAlign);
				cell.setStyle('color', getStyle('cellTextColor'));
				//addElement(cell);
				if (_columns[i].hasOwnProperty("iconType"))
				{
					try
					{
						var iconClass:Class = getClassByAlias("IconFactory") as Class;
					}
					catch (e:Error)
					{
						trace("------------------------------------------------------------------------------------");
						trace("Error : Icon factory class not found as an Alias Class. Only cell text will be added");
						trace("In order to use a Styleable Icon here, IconFactory class must be registered as an Alias");
						trace("Declare an Alias for the Icon Factory in your Application Class Constructor like this:");
						trace("registerClassAlias('IconFactory', IconFactory);");
						addElement(cell);
					}
					if( iconClass != null ) 
					{
						var iconGrp:Group = new Group();
						iconGrp.id = "cell" + String(i);
						var iconFactory:* = new iconClass();
						var iconObject:StyleableIcon = new StyleableIcon();
						iconObject.enableDownState = true;
						iconObject.icon = iconFactory.constructor.getIcon(_columns[i].iconType);
						iconObject.id = String(i);
						iconObject.addEventListener(MouseEvent.CLICK, onIconClicked);
						iconGrp.percentWidth = 100;
						iconGrp.percentHeight = 100;
						iconObject.right = 3 * scaleFactor;
						cell.left = 0;
						cell.verticalCenter = iconObject.verticalCenter = 0;
						iconGrp.addElement(cell);
						iconGrp.addElement(iconObject);
						addElement(iconGrp);
					}
				}
				else if (_columns[i].hasOwnProperty('showWatchESPN') && rowData && rowData.watchESPNURL)
				{
					watchESPNGroup = new Group();
					watchESPNGroup.percentWidth = 100;
					watchESPNGroup.percentHeight = 100;
					
					if(getStyle('watchESPNLogoAlign') == null)
						watchESPNGroup.verticalCenter = 0;
					else
						watchESPNGroup.bottom = 5;
					
					cell.left = 0;
					
					watchESPNBitmapGroup = new Group();
					watchESPNBitmapGroup.id = "watchESPN" + String(i);
					var watchESPNIcon:BitmapImage = new BitmapImage(); 
					watchESPNIcon.source = getStyle('watchESPNIcon');
					
					if(getStyle('watchESPNLogoAlign') == null)
					{
						watchESPNBitmapGroup.verticalCenter = 0;
						watchESPNBitmapGroup.right = 10*scaleFactor;
						
					}
					else
					{
						watchESPNBitmapGroup.bottom = 0;
						watchESPNBitmapGroup.left = 4*scaleFactor;
					}
					
					watchESPNBitmapGroup.addElement(watchESPNIcon);
					watchESPNBitmapGroup.addEventListener(MouseEvent.MOUSE_DOWN, onWatchESPNMouseDown);
					watchESPNBitmapGroup.addEventListener(MouseEvent.MOUSE_UP, onWatchESPNMouseUp);
					watchESPNBitmapGroup.addEventListener(MouseEvent.MOUSE_OUT, onWatchESPNMouseUp);
					watchESPNBitmapGroup.addEventListener(MouseEvent.ROLL_OUT, onWatchESPNMouseUp);
					watchESPNBitmapGroup.addEventListener(MouseEvent.CLICK, onWatchESPNIconClicked);
					
					watchESPNGroup.addElement(cell);
					watchESPNGroup.addElement(watchESPNBitmapGroup);
					addElement(watchESPNGroup);
				}
				else if(!_columns[i].hasOwnProperty('showStar'))
					addElement(cell);
				else
				{
					var starGroup:Group = new Group();
					starGroup.percentWidth = 100;
					starGroup.percentHeight = 100;
					cell.left = 0;
					
					
					var star:Star = new Star();
					star.upImg.source = getStyle('upIconSrc');
					star.downImg.source = getStyle('downIconSrc');
					star.right = 5;
					star.colIndex = i;
					star.addEventListener(MouseEvent.CLICK, onStarClick);
					cell.verticalCenter = star.verticalCenter = 0;
					BindingUtils.bindProperty(star, "selected", this, 'isFavorite');
					if(favoriteField && _rowData.hasOwnProperty(favoriteField) && _rowData[favoriteField]) {
						isFavorite = _rowData[favoriteField];
					} else {
						isFavorite =false;
						star.selected = false;
					}
					// to show star as orange in favorites..
					star.isFav = true;
					
					starGroup.addElement(cell);
					starGroup.addElement(star);
					addElement(starGroup);
				}
			}
		}
		
		protected function onWatchESPNMouseUp(event:MouseEvent):void
		{
			watchESPNBitmapGroup.alpha = 1;
		}
		
		protected function onWatchESPNMouseDown(event:MouseEvent):void
		{
			watchESPNBitmapGroup.alpha = 0.5;
		}
		
		protected function onWatchESPNIconClicked(event:MouseEvent):void
		{
			var iconGroup:Group = event.target as Group;
			var gridRowEvt:StyleableGridRowEvent = new StyleableGridRowEvent(StyleableGridRowEvent.WATCH_ESPN_CLICKED);
			gridRowEvt.rowIndex = rowIndex;
			gridRowEvt.columnIndex = event.currentTarget.id;
			gridRowEvt.rowData = _rowData;
			this.dispatchEvent(gridRowEvt);
		}
		
		/**
		 * Handle click of icon
		 * */
		protected function onIconClicked(event:MouseEvent):void
		{
			var iconGroup:Group = event.target as Group;
			var gridRowEvt:StyleableGridRowEvent = new StyleableGridRowEvent(StyleableGridRowEvent.ICON_CLICKED);
			//gridRowEvt.payload = iconGroup.id;
			gridRowEvt.rowIndex = rowIndex;
			gridRowEvt.columnIndex = event.currentTarget.id;
			gridRowEvt.rowData = _rowData;
			this.dispatchEvent(gridRowEvt);
		}
		
		/**
		 * 
		 * Handle click of star
		 * 
		 */
		private function onStarClick(e:MouseEvent):void
		{
			var starClickEvt:StyleableGridRowEvent = new StyleableGridRowEvent(StyleableGridRowEvent.STAR_CLICKED);
			starClickEvt.rowIndex = rowIndex;
			starClickEvt.columnIndex = e.currentTarget.colIndex;
			starClickEvt.rowData = _rowData;
			starClickEvt.makeFavorite = e.target.selected;
			this.dispatchEvent(starClickEvt);
		}
		
		/**
		 * 
		 * Handle click of button on column
		 * 
		 */
		private function onColButtonClick(e:MouseEvent):void
		{
			var btnClickEvt:StyleableGridRowEvent = new StyleableGridRowEvent(StyleableGridRowEvent.BUTTON_CLICKED);
			btnClickEvt.rowIndex = rowIndex;
			btnClickEvt.columnIndex = e.currentTarget.id;
			btnClickEvt.rowData = _rowData;
			this.dispatchEvent(btnClickEvt);
		}
		
		/**
		 * 
		 * draw row border
		 * 
		 */		
		private function drawRowBorder(borderSides:String):void
		{
			graphics.lineStyle(getStyle('rowBorderWeight'), getStyle('rowBorderColor'), 1, false, "normal", CapsStyle.SQUARE, JointStyle.MITER);
			if (borderSides.length == 4)
			{
				if (borderSides.substr(0,1) == "T")
				{
					graphics.moveTo(0,0);
					graphics.lineTo(width, 0);
				}
				if (borderSides.substr(1,1) == "R")
				{
					graphics.moveTo(width,0);
					graphics.lineTo(width, height);
				}
				if (borderSides.substr(2,1) == "B")
				{
					graphics.moveTo(0, height);
					graphics.lineTo(width,height);
				}
				if (borderSides.substr(3,1) == "L")
				{
					graphics.moveTo(0,height);
					graphics.lineTo(0, 0);
				}
			}
		}
		
		/**
		 * Method to draw divider lines  
		 */
		private function drawDivider(xPos:Number):void
		{
			graphics.lineStyle(getStyle('rowBorderWeight'), getStyle('rowBorderColor'), 1, false, "normal", CapsStyle.SQUARE, JointStyle.MITER);
			graphics.moveTo(xPos, 0); 
			graphics.lineTo(xPos, height);
		}
		
		/**
		 * @override
		 * 
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			graphics.clear();
			if (getStyle('rowBackgroundColor') != undefined)
			{
				graphics.beginFill(getStyle('rowBackgroundColor'));
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
			}
			
			for(var k:int=0; k<numChildren;k++)
			{
				if (getElementAt(k).height > height)
					height = getElementAt(k).height + 5*scaleFactor;
			}
			calculatedHeight = height;
			
			drawRowBorder(borderSides);
			var currentX:Number = 0;
			if(numCols)
			{
				for(var i:int = 0; i < numCols; i++)
				{
					var columnElement:Object = _columns[i] as Object; 
					var columnWidth:Number;
					if (columnElement.hasOwnProperty('percentWidth'))
					{
						if (getElementAt(i) == buttonObject)
						{
							columnWidth = (_columns[i].percentWidth/100) * unscaledWidth;
							setButtonCoordinates(columnWidth, i);
							//currentX += columnWidth;
						}
						else
						{
							getElementAt(i).width = (_columns[i].percentWidth/100) * unscaledWidth;
							
							if(i > 0)
								getElementAt(i).x = getElementAt(i-1).x + getElementAt(i-1).width;
							
							currentX += getElementAt(i).width;
						}
						drawDivider(currentX);
					}
					else 
					{
						if (getElementAt(i) == buttonObject)
						{
							columnWidth = (_columns[i].width) ? _columns[i].width : unscaledWidth/numCols;
							setButtonCoordinates(columnWidth, i);
							//currentX += columnWidth;
						}
						else
						{
							getElementAt(i).width = (_columns[i].width) ? _columns[i].width : unscaledWidth/numCols;
							
							if(i > 0)
								getElementAt(i).x = getElementAt(i-1).x + getElementAt(i-1).width;
							
							currentX += getElementAt(i).width;
						}
						drawDivider(currentX);
					}
					
				}
			}
			/*for (var j:uint = 0 ; j < icons.length; j++)
			{
			var iconDetail:Object = icons[j] as Object; 
			var icon:StyleableIcon = iconDetail.iconObject as StyleableIcon;
			columnElement = iconDetail.column as Object; 
			if (columnElement.hasOwnProperty('percentWidth'))
			{
			columnWidth = (columnElement.percentWidth/100) * unscaledWidth;
			setIconCoordinates(icon, columnWidth, j);
			}
			else 
			{
			columnWidth = (columnElement.width) ? columnElement.width : width/numCols;
			trace(j,columnWidth);
			setIconCoordinates(icon, columnWidth, j);
			}
			this.addElement(icon);
			}*/
			
		}
		
		/**
		 * Method to set the location of the button inside the cell.<br>
		 * Button will be centrally aligned to the width and height of the column  
		 * @param columnWidth Width of the column
		 * @param index The count of the column
		 * 
		 */		
		private function setButtonCoordinates(columnWidth:Number, index:int):void
		{
			buttonObject.width = Number(_columns[index].buttonWidth);
			buttonObject.height = Number(_columns[index].buttonHeight);
			if(index > 0)
				buttonObject.x = getElementAt(index-1).x + getElementAt(index-1).width + columnWidth/2 - buttonObject.width/2;
			else
				buttonObject.x = columnWidth/2 - buttonObject.width/2;
			buttonObject.verticalCenter = 0;
		}
		
		/**
		 * Method to set the location of the icon inside the cell.<br>
		 * Icon will always be right aligned to the width and height of the column  
		 * @param icon The icon object needed to be aligned
		 * @param columnWidth Width of the column
		 * @param index The count of the column
		 * 
		 */		
		/*private function setIconCoordinates(icon:StyleableIcon, columnWidth:Number, index:int):void
		{
		if(index > 0)
		icon.x = getElementAt(index-1).x + getElementAt(index-1).width + columnWidth - iconObject.measuredWidth - 2;
		else
		icon.x = columnWidth - 20;
		trace(icon.x);
		icon.verticalCenter = 0;
		}*/
		
	}
}