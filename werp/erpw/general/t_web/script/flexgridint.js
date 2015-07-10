var			F_arrFlexGrids = new Array();
var			ROOT_NODE_INDEX = 0;
var			PARENT_NODE_INDEX = 1;
var			FIRSTCHILD_NODE_INDEX = 2;
var			LASTCHILD_NODE_INDEX = 3;
var			FISTSIBIL_NODE_INDEX = 4;
var			LASTSIBIL_NODE_INDEX = 5;
var			NEXTSIBIL_NODE_INDEX = 6;
var			PREVSIBIL_NODE_INDEX = 7;

var			CELL_VALUE = 0;
var			CELL_BKCOLOR = 6;

var			FlexAlignLeftTop = 0;
var			FlexAlignLeftCenter = 1;
var			FlexAlignLeftBottom = 2;
var			FlexAlignCenterTop = 3;
var			FlexAlignCenterCenter = 4;
var			FlexAlignCenterBottom = 5;
var			FlexAlignRightTop = 6;
var			FlexAlignRightCenter = 7;
var			FlexAlignRightBottom = 8;
var			FlexAlignGeneral = 9;

var			FlexOutlineBarNone = 0;
var			FlexOutlineBarComplete = 1;
var			FlexOutlineBarSimple = 2;
var			FlexOutlineBarSymbols = 3;
var			FlexOutlineBarCompleteLeaf = 4;
var			FlexOutlineBarSimpleLeaf = 5;
var			FlexOutlineBarSymbolsLeaf = 6;

var			flexResizeNone = 0;
var			flexResizeColumns = 1;
var			flexResizeRows = 2;
var			flexResizeBoth = 3;
var			flexResizeBothUniform = 4;

var			DFLT_WIDTH = 1400;
var			EDITSTYLE_NORMAL = 0;
var			EDITSTYLE_COMBO = 1;
var			EDITSTYLE_POPUP = 2;
var			NUMBER_DATA = 1;
var			STRING_DATA = 2;
function	F_CodeName(aCode,aName)
{
	this.code = aCode;
	this.name = aName;
}
function	F_FlexGridColumnInfo(aColumnName,aDataType,aEditStyle,aFormat,aWidth,aVisible,aComboValues,aComboEditable)
{
	this.columnName = aColumnName;
	this.dataType = aDataType;
	this.dataFormat = aFormat;
	this.columnWidth = C_isNull(aWidth)? DFLT_WIDTH:aWidth;
	this.columnVisible = C_isNull(aVisible)? true:aVisible;
	this.columnEditStyle = C_isNull(aEditStyle)? EDITSTYLE_NORMAL:aEditStyle;
	this.columnValues = new Array();
	this.columnHashMap = new C_Dictionary();
	if(this.columnEditStyle == EDITSTYLE_COMBO && !C_isNull(aComboValues))
	{
		for(i = 0 ; i < aComboValues.length ; ++i)
		{
			this.columnHashMap[aComboValues[i].code] = i;
			this.columnValues[i] = aComboValues[i];
		}
	}
	this.comboEditable = aComboEditable;
	this.getValueByIndex = F_getValueByIndex;
	this.getNameByIndex = F_getNameByIndex;
	this.getIndexByValue = F_getIndexByValue;
	this.makeComboString = F_makeComboString;
}
function	F_getValueByIndex(iSeq)
{
	return this.columnValues[iSeq].code;
}
function	F_getNameByIndex(iSeq)
{
	return this.columnValues[iSeq].name;
}
function	F_getIndexByValue(aValue)
{
	return this.columnHashMap[aValue];
}
function	F_makeComboString()
{
	var			lsRet = "";
	for(var i = 0 ; i < this.columnValues.length ; ++ i)
	{
		lsRet += "#"+i+";"+this.columnValues[i].name+"|";
	}
	//if(this.comboEditable)
	//{
	//	//lsRet = lsRet.substring(0,lsRet.length - 1);
	//	lsRet = "|"+lsRet;
	//}
	return lsRet;
}
function	F_FlexGridInfo(aGrid,aDataset,aDeleteDataset,aStartRow,aLabelColumn,aLevelColumn,aLevelSeqColumn,aKeyColumn,aPNoColumn,aNewItemValue)
{
	this.fg_ = aGrid;
	this.dataset = aDataset;
	this.deletedataset = aDeleteDataset;
	this.startrow = aStartRow;
	this.labelcolumn = aLabelColumn;
	this.levelcolumn = aLevelColumn;
	this.levelseqcolumn = aLevelSeqColumn;
	this.keycolumn = aKeyColumn;
	this.pnocolumn = aPNoColumn;
	this.newitemvalue = C_isNull(aNewItemValue) ? "신규항목":aNewItemValue;
	this.columns = new Array();
	this.columnByNames = new C_Dictionary();
	this.addColumn = F_addColumn;
	this.getColumnIndex = F_getColumnIndex;
	this.getColumnName = F_getColumnName;
	this.getColumnInfo = F_getColumnInfo;
	this.displayData = F_displayData;
	this.initGrid = F_initGrid;
	this.setRow = F_setRow;
	this.displayRow = F_displayRow;
	this.getDataRow = F_getDataRow;
	this.addChildInternal = F_addChildInternal;
	this.addSiblingInternal = F_addSiblingInternal;
	this.deleteInternal = F_deleteInternal;
	this.moveUp = F_moveUp;
	this.moveDn = F_moveDn;
}
function	F_addColumn(arColumnInfo)
{
	this.columns.push(arColumnInfo);
	this.columnByNames[arColumnInfo.columnName] = this.columns.length - 1;
}
function	F_initGrid()
{

	this.rowdatacolumn = this.columns.length;
	this.fg_.Cols=this.columns.length + 1;
	this.fg_.ColHidden(this.rowdatacolumn)= true;
	this.fg_.SelectionMode = 0;
	this.fg_.OutlineBar = 1;
	this.fg_.AllowUserResizing = 1;
	this.fg_.FixedRows = this.startrow;
	this.fg_.FixedCols = 0;
	this.fg_.Rows=this.startrow;
	var			liColLength = this.columns.length;
	for(var i = 0 ; i <liColLength ; ++ i)
	{
		var			lrColumnInfo = this.columns[i];
		this.fg_.ColHidden(i  )= ! lrColumnInfo.columnVisible;
		this.fg_.ColWidth(i )= lrColumnInfo.columnWidth;
		if(!C_isNull(lrColumnInfo.dataFormat))
		{
			this.fg_.ColFormat(i)=lrColumnInfo.dataFormat;
		}
		if(lrColumnInfo.columnEditStyle == EDITSTYLE_COMBO)
		{
			this.fg_.ColComboList(i) = lrColumnInfo.makeComboString();
		}
		else if(lrColumnInfo.columnEditStyle == EDITSTYLE_POPUP && lrColumnInfo.comboEditable)
		{
			this.fg_.ColComboList(i) = "|...";
		}
		else if(lrColumnInfo.columnEditStyle == EDITSTYLE_POPUP && ! lrColumnInfo.comboEditable)
		{
			this.fg_.ColComboList(i) = "...";
		}
	}
}
function	F_getColumnIndex(asColumnName)
{
	return this.columnByNames[asColumnName];
}
function	F_getColumnInfo(aiColIndex)
{
	return this.columns[aiColIndex]
}
function	F_getColumnName(aiColIndex)
{
	return this.getColumnInfo(aiColIndex).columnName;
}
function	F_displayData()
{
	this.fg_.Rows = this.fg_.FixedRows;
	var		liLabelIndex = this.getColumnIndex(this.labelcolumn);
	var		liCountRow = this.dataset.CountRow;
	for(i = 1 ; i <= liCountRow; ++i)
	{
		this.fg_.AddItem(this.dataset.NameString(i,this.labelcolumn));
		this.fg_.RowOutlineLevel(this.fg_.Rows - 1) =  parseInt(this.dataset.NameString(i,this.levelcolumn)) ;
		F_setCellValue(this.fg_,this.fg_.Rows - 1,this.rowdatacolumn,i);
		this.fg_.IsSubtotal(this.fg_.Rows - 1 ) = true;
		this.displayRow(this.fg_.Rows - 1,i,1);
	}

	G_Load(this.deletedataset);
	if(this.fg_.Rows > this.fg_.FixedRows)
	{
		this.fg_.Row = this.fg_.FixedRows;
	}
}
function	F_displayRow(aiGridRow, i,aiStartColumn)
{
	var			liCountColumns = this.columns.length;
	for(j = aiStartColumn ; j < liCountColumns ; ++ j)
	{
		var			lrColumnInfo = this.columns[j];
		if(lrColumnInfo.columnEditStyle == EDITSTYLE_COMBO)
		{
			var			liValueIndex = lrColumnInfo.getIndexByValue(this.dataset.NameString(i,lrColumnInfo.columnName));
			F_setCellValue(this.fg_,aiGridRow,j,liValueIndex);
		}
		else
		{
			if(lrColumnInfo.dataType == NUMBER_DATA)
			{
				F_setCellValue(this.fg_,aiGridRow, j,G_getFloatFrom(this.dataset,i,lrColumnInfo.columnName));
			}
			else
			{
				F_setCellValue(this.fg_,aiGridRow, j,this.dataset.NameString(i,lrColumnInfo.columnName));
			}
		}
	}
}
function	F_getDataRow(aiRow)
{
	if(aiRow < this.fg_.FixedRows) return -1;
	return F_getCellValue(this.fg_,aiRow,this.rowdatacolumn);
}
function	F_setRow(aiRow)
{
	var			liParentRow = this.fg_.GetNodeRow(aiRow,PARENT_NODE_INDEX);
	var			liPNo;
	var			liLevelNum;
	if(liParentRow < 0)
	{
		liLevelNum = 1;
	}
	else
	{
		var			node = this.fg_.GetNode(liParentRow);
		if(node == null || node == undefined)
		{
			liLevelNum = 1;
		}
		else
		{
			liLevelNum = node.Level + 1;
		}
	}
	var			liPreSibRow = this.fg_.GetNodeRow(aiRow,PREVSIBIL_NODE_INDEX);
	var			liLevelSeq = 0;
	var			liDataRow = this.getDataRow(aiRow);
	var			liSetStartRow;



	if(liParentRow == -1)
	{
		liPNo = 0;
	}
	else
	{
		liPNo = parseInt(this.dataset.NameString(this.getDataRow(liParentRow),this.keycolumn));
	}
	if(liPreSibRow == -1)
	{
		liLevelSeq = 1;
	}
	else
	{
		liLevelSeq = parseInt(this.dataset.NameString(this.getDataRow(liPreSibRow),this.levelseqcolumn)) + 1;
	}
	this.dataset.NameString(liDataRow,this.pnocolumn) = liPNo;
	this.dataset.NameString(liDataRow,this.levelcolumn) = liLevelNum;
	this.dataset.NameString(liDataRow,this.labelcolumn) = F_getCellValue(this.fg_,aiRow,this.getColumnIndex(this.labelcolumn));
	liSetStartRow = aiRow;
	while(true)
	{
		this.dataset.NameString(this.getDataRow(liSetStartRow),this.levelseqcolumn) = liLevelSeq;
		liLevelSeq ++;
		liSetStartRow = this.fg_.GetNodeRow(liSetStartRow,NEXTSIBIL_NODE_INDEX);
		if(liSetStartRow == -1) break;
	}
	this.displayRow(aiRow,liDataRow,1);
}
function	F_addChildInternal()
{
	G_addRow(this.dataset);
	var			liDataRow = this.dataset.RowPosition;
	var			liRow;
	var			liLevel;
	if(liDataRow < 0) return -1;
	if(this.fg_.Rows == this.fg_.FixedRows || this.fg_.Row < this.fg_.FixedRows)
	{
		liRow = this.fg_.Rows;
		liLevel = 1;
	}
	else
	{
		liRow = this.fg_.GetNodeRow(this.fg_.Row,LASTCHILD_NODE_INDEX);
		var		node = this.fg_.GetNode(this.fg_.Row);
		if(liRow == -1)
		{
			liRow = this.fg_.Row + 1;
		}
		else
		{
			liRow = liRow + 1;
		}
		liLevel = node.Level + 1;
	}
	this.fg_.AddItem(this.newitemvalue,liRow);
	this.fg_.IsSubtotal(liRow) = true;
	this.fg_.RowOutlineLevel(liRow) =  liLevel;
	F_setCellValue(this.fg_,liRow,this.rowdatacolumn,liDataRow);
	this.fg_.Row = liRow;
	this.fg_.Col = this.getColumnIndex(this.labelcolumn);
	this.setRow(liRow);
	return liRow;
}
function	F_addSiblingInternal()
{
	G_addRow(this.dataset);
	var			liDataRow = this.dataset.RowPosition;
	var			liRow;
	var			liLevel;
	if(liDataRow < 0) return -1;
	if(this.fg_.Rows == this.fg_.FixedRows || this.fg_.Row < this.fg_.FixedRows)
	{
		liRow = this.fg_.Rows;
		liLevel = 1;
	}
	else
	{
		liRow = this.fg_.GetNodeRow(this.fg_.Row,NEXTSIBIL_NODE_INDEX);
		var		node = this.fg_.GetNode(this.fg_.Row);
		if(liRow == -1)
		{
			var		liFindRow = this.fg_.Rows;
			for(i = this.fg_.Row + 1 ; i < this.fg_.Rows ; i ++)
			{
				if(this.fg_.GetNode(i).Level < node.Level)
				{
					liFindRow = i;
					break;
				}
			}
			liRow = liFindRow;
		}
		else
		{
			liRow = liRow ;
		}
		liLevel = node.Level ;
	}
	this.fg_.AddItem(this.newitemvalue,liRow);
	this.fg_.IsSubtotal(liRow) = true;
	this.fg_.RowOutlineLevel(liRow) =  liLevel;
	F_setCellValue(this.fg_,liRow,this.rowdatacolumn,liDataRow);
	this.fg_.Row = liRow;
	this.fg_.Col = this.getColumnIndex(this.labelcolumn);
	this.setRow(liRow);
	return liRow;
}
function	F_deleteInternal()
{
	var			lrNode = this.fg_.GetNode();
	var			liNextSib = 0;
	var			liDataRow;
	if(lrNode == null || lrNode == undefined) return;
	if(lrNode.Children > 0)
	{
		C_msgOk("하위를 먼저 삭제하십시오.","알림");
		this.fg_.focus();
		return;
	}
	var			liParentRow = this.fg_.GetNodeRow(this.fg_.Row,PARENT_NODE_INDEX);
	liNextSib = this.fg_.GetNodeRow(this.fg_.Row,NEXTSIBIL_NODE_INDEX);
	liDataRow = this.getDataRow(this.fg_.Row);

	var			liSeq = parseInt(this.dataset.NameString(liDataRow,this.levelseqcolumn));
	var			liLevelSeq = liSeq;
	if(liNextSib != -1)
	{
		var			liSetStartRow = liNextSib;
		while(true)
		{
			this.dataset.NameString(this.getDataRow(liSetStartRow),this.levelseqcolumn) = liLevelSeq;
			liLevelSeq ++;
			liSetStartRow = this.fg_.GetNodeRow(liSetStartRow,NEXTSIBIL_NODE_INDEX);
			if(liSetStartRow == -1) break;
		}
	}
	this.fg_.RemoveItem(this.fg_.Row);
	G_addRow(this.deletedataset);
	this.deletedataset.NameString(this.deletedataset.RowPosition,this.keycolumn) = this.dataset.NameString(liDataRow,this.keycolumn);
}
function	F_moveUp()
{
	var			lrNode = this.fg_.GetNode();
	var			liOldRow = this.fg_.Row;
	if(lrNode == null || lrNode == undefined) return;
	lrNode.Move(2,lrNode);
	var			liNewRow = this.fg_.Row;
	if(liNewRow == liOldRow)
	{
		return;
	}
	var			liDataRow = this.getDataRow(liNewRow);
	var			liSeq = parseInt(this.dataset.NameString(liDataRow,this.levelseqcolumn));
	liSeq --;
	var			liLevelSeq = liSeq;
	var			liSetStartRow = liNewRow;
	while(true)
	{
		this.dataset.NameString(this.getDataRow(liSetStartRow),this.levelseqcolumn) = liLevelSeq;
		liLevelSeq ++;
		liSetStartRow = this.fg_.GetNodeRow(liSetStartRow,NEXTSIBIL_NODE_INDEX);
		if(liSetStartRow == -1) break;
	}
}
function	F_moveDn()
{
	var			lrNode = this.fg_.GetNode();
	var			liOldRow = this.fg_.Row;
	if(lrNode == null || lrNode == undefined) return;
	lrNode.Move(3,lrNode);
	var			liNewRow = this.fg_.Row;
	if(liNewRow == liOldRow)
	{
		return;
	}
	var			liDataRow = this.getDataRow(liOldRow);
	var			liSeq = parseInt(this.dataset.NameString(liDataRow,this.levelseqcolumn));
	liSeq --;
	var			liLevelSeq = liSeq;
	var			liSetStartRow = liOldRow;
	while(true)
	{
		this.dataset.NameString(this.getDataRow(liSetStartRow),this.levelseqcolumn) = liLevelSeq;
		liLevelSeq ++;
		liSetStartRow = this.fg_.GetNodeRow(liSetStartRow,NEXTSIBIL_NODE_INDEX);
		if(liSetStartRow == -1) break;
	}
}
function	MyRound(aiNumber,aiDigit)
{
	var			liDigit;
	if(aiDigit == null)
	{
		liDigit = 1;
	}
	else
	{
		liDigit = Math.pow(10,aiDigit);
	}
	return Math.round(aiNumber * liDigit) / liDigit;
}
function	ToHex(aiNumber)
{
	return "0123456789ABCDEF".substring(aiNumber,aiNumber + 1);
}
function	ToHexByte(aiNumber)
{
	var			liHigh = Math.floor(aiNumber / 16);
	var			liLow = aiNumber % 16;
	return "%"+ToHex(liHigh) + ToHex(liLow);
}
function	Rgb(r,g,b)
{
	return r | g <<8 | b << 16;
}
//FlexGrid의 배경색
function	F_setCellBackColor(fgrid,row,col,color)
{
	fgrid.Cell(CELL_BKCOLOR,row,col,row,col) = color;
}
function	F_setCellsBackColor(fgrid,row1,col1,row2,col2,color)
{
	fgrid.Cell(CELL_BKCOLOR,row1,col1,row2,col2) = color;
}
function	F_setCellValue(fgrid,row,col,val)
{
	fgrid.Cell(CELL_VALUE,row,col) = val;
}
function	F_getCellValue(fgrid,row,col)
{
	return fgrid.Cell(CELL_VALUE,row,col);
}
function	GetCellNumber(fgrid,row,col)
{
	return C_convSafeFloat(C_getNumberTypeString(fgrid.Cell(CELL_VALUE,row,col)));
}
function	F_addFlexGrid(aGrid,aDataset,aDeleteDataset,aStartRow,aLabelColumn,aLevelColumn,aLevelSeqColumn,aKeyColumn,aPNoColumn,aNewItemValue)
{
	var lrRet = new F_FlexGridInfo(aGrid,aDataset,aDeleteDataset,aStartRow,aLabelColumn,aLevelColumn,aLevelSeqColumn,aKeyColumn,aPNoColumn,aNewItemValue);

	aGrid.attachEvent ("AfterEdit", new Function("Row", "Col", "F_OnGridAfterEdit(" + aGrid.id + ", Row, Col);"));
	aGrid.attachEvent ("AfterRowColChange", new Function("OldRow","OldCol", "NewRow", "NewCol", "F_OnGridAfterRowColChange(" + aGrid.id + ", OldRow, OldCol, NewRow, NewCol);"));
	aGrid.attachEvent ("onfocus",new Function("F_focusDataset("+aDataset.id+","+aGrid.id+");"));
	aGrid.attachEvent ("CellButtonClick",new Function("Row", "Col","F_OnCellButtonClick("+aGrid.id+", Row , Col);"));

	F_arrFlexGrids.push(lrRet);
	return lrRet;
}
function	F_findGridInfo(fg)
{
	for(i = 0 ; i < F_arrFlexGrids.length ; ++i)
	{
		if(F_arrFlexGrids[i].fg_ == fg) return F_arrFlexGrids[i];
	}
	return null;
}

function	F_OnGridAfterRowColChange(fg, OldRow, OldCol, NewRow, NewCol)
{
	try
	{
		OnGridAfterRowColChange(fg, OldRow, OldCol, NewRow, NewCol);
	}
	catch (e)
	{
	}
}

function	F_OnGridAfterEdit(fg,Row,Col)
{
	try
	{
		OnGridAfterEdit(fg,Row,Col);
	}
	catch (e)
	{
	}
	var			lrGridInfo = F_findGridInfo(fg);
	if(C_isNull(lrGridInfo)) return;
	
	var			liDataRow = lrGridInfo.getDataRow(Row);
	var			lrColumnInfo = lrGridInfo.getColumnInfo(Col);
	if(liDataRow < 1) return;

	if(lrColumnInfo.columnEditStyle == EDITSTYLE_COMBO)
	{
		var			liIndex = F_getCellValue(fg,Row,Col);
		if(C_isNull(liIndex))
		{
			lrGridInfo.dataset.NameString(liDataRow,lrColumnInfo.columnName) = "";
		}
		else
		{
			var			lsCode = lrColumnInfo.columnValues[liIndex].code;
			lrGridInfo.dataset.NameString(liDataRow,lrColumnInfo.columnName) = lsCode;
		}
	}
	else
	{
		lrGridInfo.dataset.NameString(liDataRow,lrColumnInfo.columnName) = F_getCellValue(fg,Row,Col);
	}
}
function	F_OnCellButtonClick(fg,Row,Col)
{
	try
	{
		OnCellButtonClick(fg,Row,Col);
	}
	catch (e)
	{
	}
}
function	F_focusDataset(aDataset,aGrid)
{
	C_EventObject = aGrid;
	
	G_FocusObject = aGrid;
	G_focusDataset(aDataset);
}
