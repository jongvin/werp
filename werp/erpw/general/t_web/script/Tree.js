var arrRowID = new Array();
var intLastInx = -1;
var strTreeImagePath = "../Images/Tree/";

var ICON_COLLAPSE_END = "icon_collapse_end.gif";
var ICON_COLLAPSE_MORE = "icon_collapse_more.gif";
var ICON_EXPAND_END = "icon_expand_end.gif";
var ICON_EXPAND_MORE = "icon_expand_more.gif";
var ICON_CONNECT_END = "icon_connect_end.gif";
var ICON_CONNECT_MORE = "icon_connect_more.gif";
var ICON_CONNECT_BRIDGE = "icon_connect_bridge.gif";
var ICON_EMPTY = "icon_empty.gif";
var ICON_FOLDER_OPEN = "icon_folder_open.gif";
var ICON_FOLDER_CLOSE = "icon_folder_close.gif";

function TfnTreeShowHide(obj, RowID, intIndex)
{
	var Row;
	var arrTemp = obj.src.split("/");
	var bolExpand;
	
	switch (arrTemp[arrTemp.length - 1])
	{
		case ICON_COLLAPSE_END:
			obj.src = strTreeImagePath + ICON_EXPAND_END;
			bolExpand = false;
			break;
		case ICON_EXPAND_END:
			obj.src = strTreeImagePath + ICON_COLLAPSE_END;
			bolExpand = true;
			break;
		case ICON_COLLAPSE_MORE:
			obj.src = strTreeImagePath + ICON_EXPAND_MORE;
			bolExpand = false;
			break;
		case ICON_EXPAND_MORE:
			obj.src = strTreeImagePath + ICON_COLLAPSE_MORE;
			bolExpand = true;
			break;
	}
	
	Row = arrRowID[intIndex].split(",");
	
	if (bolExpand)
	{
		TfnOpenNode(Row[0], intIndex, RowID.split("_").length);
		Row[1] = "true";
	}
	else
	{
		TfnCloseNode(RowID, intIndex);
		Row[1] = "false";
	}
	
	arrRowID[intIndex] = Row[0] + "," + Row[1] + "," + Row[2] + "," + Row[3];
}

function TfnOpenNode(RowID, intIndex, intLevel)
{
	var Node;
	var Row;
	
	for (var i = intIndex + 1; i < arrRowID.length; i++)
	{
		Row = arrRowID[i].split(",");
		
		if (Row[0].split("_").length != intLevel + 1) continue;
		if (Row[0].substr(0, RowID.length) != RowID) continue;
		if (Row[1] == "true" && Row[2] == "true")
		{
			TfnOpenNode(Row[0], i, intLevel + 1);
		}
		
		Node = eval(Row[0] + ".style");
		Node.display = "block";
	}
}

function TfnCloseNode(RowID, intIndex)
{
	var Node;
	var Row;
	
	for (var i = intIndex + 1; i < arrRowID.length; i++)
	{
		Row = arrRowID[i].split(",");
		
		if (Row[0].length > RowID.length && Row[0].substr(0, RowID.length) == RowID)
		{
			Node = eval(Row[0] + ".style");
			Node.display = "none";
		}
	}
}

function TfnRowSelect(obj, RowID, intIndex)
{
	var Node;
	var Img;
	var Row;
	var tmpRowID;
	var bolLastNode;
	var strValue;
	
	if (intLastInx > -1)
	{
		Row = arrRowID[intLastInx].split(",");
		Node = eval(Row[0]);
		Node.bgColor = Row[3];
		
		Img = eval("Img" + Row[0].substr(3));
		Img.src = strTreeImagePath + ICON_FOLDER_CLOSE;
	}
	
	obj.bgColor = "#FFCC00";
	Img = eval("Img" + RowID.substr(3));
	Img.src = strTreeImagePath + ICON_FOLDER_OPEN;
	intLastInx = intIndex;
	
	Row = arrRowID[intIndex].split(",");
	tmpRowID = RowID.split("_");
	intNodeKey = tmpRowID[tmpRowID.length - 1];
	bolLastNode = Row[2] == "true" ? false : true;
	strValue = Row[4];
	
	try
	{
		fnTreeNodeSelected(obj, intNodeKey, bolLastNode, tmpRowID, RowID, intIndex, strValue);
	}
	catch(e)
	{
	}
}

function tfnGetIndex(obj)
{
	return obj.parentElement.parentElement.rows(obj.id).rowIndex;
}

function TfnRowSelectSplit(obj)
{
	var RowID = obj.id;
	var intIndex = tfnGetIndex(obj);
	var Node;
	var Img;
	var Row;
	var tmpRowID;
	var bolLastNode;
	var strValue;
	
	if (intLastInx > -1)
	{
		Row = arrRowID[intLastInx].split(",");
		Node = eval("L_"+Row[0]);
		Node.bgColor = Row[3];
		Node = eval("R_"+Row[0]);
		Node.bgColor = Row[3];
		Img = eval("Img" + Row[0].substr(3));
		Img.src = strTreeImagePath + ICON_FOLDER_CLOSE;
	}
	Node = eval("L_Row" + RowID.substr(5));
	Node.bgColor = "#FFCC00";
	Node = eval("R_Row" + RowID.substr(5));
	Node.bgColor = "#FFCC00";
	Img = eval("Img" + RowID.substr(5));
	Img.src = strTreeImagePath + ICON_FOLDER_OPEN;
	intLastInx = intIndex;
	Row = arrRowID[intIndex].split(",");
	tmpRowID = RowID.split("_");
	intNodeKey = tmpRowID[tmpRowID.length - 1];
	bolLastNode = Row[2] == "true" ? false : true;
	strValue = Row[4];
	
	try
	{
		fnTreeNodeSelected(obj, intNodeKey, bolLastNode, tmpRowID, RowID, intIndex, strValue);
	}
	catch(e)
	{
	}
}

function TfnTreeShowHideSplit(obj)
{
	var RowID = obj.parentElement.parentElement.id;
	var intIndex = tfnGetIndex(obj.parentElement.parentElement);
	var Row;
	var arrTemp = obj.src.split("/");
	var bolExpand;
	switch (arrTemp[arrTemp.length - 1])
	{
		case ICON_COLLAPSE_END:
			obj.src = strTreeImagePath + ICON_EXPAND_END;
			bolExpand = false;
			break;
		case ICON_EXPAND_END:
			obj.src = strTreeImagePath + ICON_COLLAPSE_END;
			bolExpand = true;
			break;
		case ICON_COLLAPSE_MORE:
			obj.src = strTreeImagePath + ICON_EXPAND_MORE;
			bolExpand = false;
			break;
		case ICON_EXPAND_MORE:
			obj.src = strTreeImagePath + ICON_COLLAPSE_MORE;
			bolExpand = true;
			break;
	}
	
	Row = arrRowID[intIndex].split(",");
	
	if (bolExpand)
	{
		TfnOpenNodeSplit(Row[0], intIndex, RowID.substr(2).split("_").length);
		Row[1] = "true";
	}
	else
	{
		TfnCloseNodeSplit(RowID, intIndex);
		Row[1] = "false";
	}
	
	arrRowID[intIndex] = Row[0] + "," + Row[1] + "," + Row[2] + "," + Row[3];
}

function TfnTreeShowHideSplit_1(obj)
{
	var RowID = obj.parentElement.parentElement.id;
	var intIndex = tfnGetIndex(obj.parentElement.parentElement);
	var Row;
	var arrTemp = obj.src.split("/");
	var bolExpand;
	switch (arrTemp[arrTemp.length - 1])
	{
		case ICON_COLLAPSE_END:
			obj.src = strTreeImagePath + ICON_EXPAND_END;
			bolExpand = false;
			break;
		case ICON_EXPAND_END:
			obj.src = strTreeImagePath + ICON_COLLAPSE_END;
			bolExpand = true;
			break;
		case ICON_COLLAPSE_MORE:
			obj.src = strTreeImagePath + ICON_EXPAND_MORE;
			bolExpand = false;
			break;
		case ICON_EXPAND_MORE:
			obj.src = strTreeImagePath + ICON_COLLAPSE_MORE;
			bolExpand = true;
			break;
	}
	
	Row = arrRowID[intIndex].split(",");
	
	if (bolExpand)
	{
		TfnOpenNodeSplit(Row[0], intIndex, RowID.substr(2).split("_").length);
		Row[1] = "true";
	}
	else
	{
		TfnCloseNodeSplit(RowID, intIndex);
		Row[1] = "false";
	}
	
	arrRowID[intIndex] = Row[0] + "," + Row[1] + "," + Row[2] + "," + Row[3];
}

function TfnOpenNodeSplit(RowID, intIndex, intLevel)
{
	var Node;
	var Row;
	
	for (var i = intIndex + 1; i < arrRowID.length; i++)
	{
		Row = arrRowID[i].split(",");
		if (Row[0].split("_").length != intLevel + 1) continue;


		if (Row[0].substr(0, RowID.length) != RowID) continue;
		if (Row[1] == "true" && Row[2] == "true")
		{
			TfnOpenNodeSplit(Row[0], i, intLevel + 1);
		}
		Node = eval("L_"+Row[0] + ".style");
		Node.display = "block";
		Node = eval("R_"+Row[0] + ".style");
		Node.display = "block";
	}
}

function TfnCloseNodeSplit(RowID, intIndex)
{
	var Node;
	var Row;
	var RowName;
	
	for (var i = intIndex + 1; i < arrRowID.length; i++)
	{
		Row = arrRowID[i].split(",");
		RowName = "L_"+Row[0];
		if (RowName.length > RowID.length && RowName.substr(0, RowID.length ) == RowID)
		{
			Node = eval("L_"+Row[0] + ".style");
			Node.display = "none";
			Node = eval("R_"+Row[0] + ".style");
			Node.display = "none";
		}
	}
}
