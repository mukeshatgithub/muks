//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.ui.comp
{
	import com.espn.mobile.xgames.events.StyleableGridRowEvent;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Group;
	
	/**
	 * Border color
	 * 
	 */	
	[Style(name="rowBorderColor", inherit="no", type="uint")]
	
	/**
	 * header color 
	 */	
	[Style(name="headerBackgroundColor", inherit="no", type="uint")]
	
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
	 * headerTextColor
	 */	
	[Style(name="headerTextColor", inherit="no", type="uint")]
	
	/**
	 * 
	 * rowTextColor
	 */	
	[Style(name="rowTextColor", inherit="no", type="uint")]
	
	/**
	 * 
	 * down star icon source
	 */	
	[Style(name="downIconSrc", inherit="no", type="Object")]
	
	/**
	 * 
	 * up star icon source
	 */	
	[Style(name="upIconSrc", inherit="no", type="Object")]
	
	/**
	 * 
	 * watch ESPN icon source
	 */	
	[Style(name="watchESPNIcon", inherit="no", type="Object")]
	
	/**
	 * 
	 * cell text color
	 */	
	[Style(name="cellTextColor", inherit="no", type="uint")]
	
	/**
	 * 
	 * cell text size
	 */	
	[Style(name="cellTextSize", inherit="no", type="number")]
	
	
	/**
	 * 
	 * header text size
	 */	
	[Style(name="headerTextSize", inherit="no", type="number")]
	
	
	/**
	 * 
	 * Watch ESPN logo align
	 */	
	[Style(name="watchESPNLogoAlign", inherit="no", type="String", enumeration="top,middle,bottom")]
	
	
	
	/**
	 * 
	 * @author rmish8
	 * 
	 * StyleableGrid class
	 * 
	 */	
	public class StyleableGrid extends Group
	{
		
		/**
		 *	constructor 
		 * 
		 */		
		public function StyleableGrid()
		{
			super();
		}
		
		
		/**
		 *	row favourite field 
		 */		
		public var favoriteField:String;
		
		
		private var _rowHeight:Number;
		
		private var currentRowCount:int = 0; 
		private var rowIncrement:int = 2;


		
		/**
		 *	height for row
		 */
		public function get rowHeight():Number
		{
			return _rowHeight;
		}

		/**
		 * @private
		 */
		public function set rowHeight(value:Number):void
		{
			_rowHeight = value;
		}

		private var _headerRowHeight:Number;
		
		
		/**
		 *	height for header row
		 */
		public function get headerRowHeight():Number
		{
			return _headerRowHeight;
		}
		
		/**
		 * @private
		 */
		public function set headerRowHeight(value:Number):void
		{
			_headerRowHeight = value;
		}

		
		/**
		 *	flag to identify data provider change
		 *  
		 */
		private var dataProviderChanged:Boolean = false;
		
		/**
		 *	number of rows 
		 */		
		private var numRows:int;
		
		private var _dataProvider:ArrayCollection;

		/**
		 *	data provider for StyleableGrid 
		 */
		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}

		/**
		 * @private
		 */
		public function set dataProvider(value:ArrayCollection):void
		{
			if(!value || value == _dataProvider)
				return;
			
			_dataProvider = value;
			//numRows = _dataProvider.length;
			dataProviderChanged = true;
			invalidateProperties();
		}
		
		
		private var _dataField:String;

		/**
		 *	column data field 
		 */
		public function set dataField(value:String):void
		{
			_dataField = value;
		}
		
		private var _columns:Array;

		/**
		 *	styleable grid columns 
		 */
		public function set columns(value:Array):void
		{
			_columns = value;
		}
		
		/**
		 * header column change flag 
		 */		
		private var headerColChanged:Boolean = false;
		
		private var _headerColums:Array;

		/**
		 * header columns 
		 */
		public function set headerColums(value:Array):void
		{
			if(!value || value == _headerColums)
				return;
			
			_headerColums = value;
			headerColChanged = true;
			invalidateProperties();
		}

		/**
		 * header container 
		 */		
		private var headerContainer:Group;
		
		private var rowsContainer:Group;

		/**
		 *	main rows container 
		 * 
		 */
		public function getRowsContainer():Group
		{
			return rowsContainer;
		}


		private var _showAllBorders:Boolean = false;

		public function set showAllBorders(value:Boolean):void
		{
			_showAllBorders = value;
		}

		
		/**
		 *	@override
		 */		
		override protected function createChildren():void
		{
			super.createChildren();
			
			// create and add header container
			headerContainer = new Group();
			addElement(headerContainer);
			
			rowsContainer = new Group();
			rowsContainer.width = width;
			addElement(rowsContainer);
		}
		
		/**
		 *	@override 
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(dataProviderChanged)
			{	
				headerContainer.removeAllElements();
				rowsContainer.removeAllElements();
				currentRowCount = 0;
				numRows = 0;
				addEventListener(Event.ENTER_FRAME, renderRows);
				//createGridRows();
				dataProviderChanged = false;
			}
			
		}
		
		/**
		 * Event handler for enter frame
		 * GREEN THREADING :)
		 **/
		private function renderRows(e:Event):void
		{
			if (currentRowCount < dataProvider.length)
			{
				var startIndex:int = currentRowCount;
				var endIndex:int;
				if ((startIndex + rowIncrement) > dataProvider.length)
					endIndex = dataProvider.length;
				else 
					endIndex = startIndex + rowIncrement;
				//trace("Rendering rows : " + startIndex + " to " + endIndex);
				if (headerRowHeight!=0 && currentRowCount == 0) 
					createHeader();
				createGridRows(startIndex, endIndex); 
				numRows = currentRowCount = endIndex;
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, renderRows);
				var gridRowEvt:StyleableGridRowEvent = new StyleableGridRowEvent(StyleableGridRowEvent.ROWS_CREATED);
				dispatchEvent(gridRowEvt);
			}
		}

		
		
		/**
		 * create grid header 
		 * 
		 */
		private function createHeader():void
		{
			var gridHeader:StyleableGridRow = new StyleableGridRow(true);
			gridHeader.columns = _columns;
			gridHeader.percentWidth = 100;
			gridHeader.height = headerRowHeight;
			gridHeader.borderSides = "TRBL";
			gridHeader.setStyle('rowBackgroundColor', getStyle('headerBackgroundColor'));
			gridHeader.setStyle('rowBorderColor',getStyle('rowBorderColor'));
			gridHeader.setStyle('rowBorderWeight',getStyle('rowBorderWeight'));
			gridHeader.setStyle('cellTextColor', getStyle('headerTextColor'));
			gridHeader.setStyle('cellTextAlign', "center");
			gridHeader.setStyle("fontSize", getStyle('headerTextSize'));
			headerContainer.addElement(gridHeader);
		}
		
		/**
		 * create grid rows 
		 */		
		private function createGridRows(startIndex:int, endIndex:int):void
		{
			for(var i:int = startIndex; i < endIndex; i++)
			{
				var gridRow:StyleableGridRow = new StyleableGridRow();
				gridRow.columns = _columns;
				gridRow.percentWidth = 100;
				gridRow.height = rowHeight;
				gridRow.rowData = dataProvider.getItemAt(i);
				gridRow.rowIndex = i;
				if (i == 0)
					gridRow.borderSides = "T-B-";
				else
					gridRow.borderSides = "--B-";
				gridRow.setStyle('rowBackgroundColor',getStyle('rowBackgroundColor'));
				gridRow.setStyle('rowBorderColor',getStyle('rowBorderColor'));
				gridRow.setStyle('rowBorderWeight',getStyle('rowBorderWeight'));
				gridRow.setStyle('cellTextAlign', "center");
				gridRow.setStyle('cellTextColor', getStyle('rowTextColor'));
				gridRow.setStyle('upIconSrc', getStyle('upIconSrc'));
				gridRow.favoriteField = favoriteField;
				//trace("up icon src", getStyle('upIconSrc'));
				gridRow.setStyle('downIconSrc', getStyle('downIconSrc'));
				gridRow.setStyle('watchESPNIcon', getStyle('watchESPNIcon'));
				gridRow.setStyle("fontSize", getStyle('cellTextSize'));
				gridRow.setStyle('watchESPNLogoAlign', getStyle('watchESPNLogoAlign'));

				if(_showAllBorders) {
					gridRow.borderSides = "TRBL";
				}
				rowsContainer.addElement(gridRow);
			}
			
			
		}
		
		/**
		 * 
		 * @override
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			//trace("unscaledHeight", unscaledHeight);
			
			/*if(_headerColums)
			{
				for(var i:int = 0; i < _headerColums.length; i++)
				{
					headerContainer.getElementAt(i).width = (_headerColums[i].width) ? _headerColums[i].width : unscaledWidth/_headerColums.length;
					
					if(i > 0)
						headerContainer.getElementAt(i).x = headerContainer.getElementAt(i-1).x + headerContainer.getElementAt(i-1).width;
					
				}
			}*/
			
			var rowY:Number = 0;
			
			if(numRows && rowsContainer && rowsContainer.numChildren > 0)
			{
				rowsContainer.y = headerContainer.getPreferredBoundsHeight();
				rowsContainer.width = unscaledWidth;
				headerContainer.width = unscaledWidth;
				for(var j:int = 0; j < numRows; j++)
				{
					rowsContainer.getElementAt(j).y = rowY;
					rowY += (rowsContainer.getElementAt(j) as StyleableGridRow).calculatedHeight;
				}
			}
			
		}

	}
}