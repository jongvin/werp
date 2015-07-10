// DataSet ��� �迭
var G_arrDataSets = new Array();

// DataSet�� �б� ���� ����
var G_isLoading = false;

// Transaction�� Post ���� ����
var G_isSaveing = false;

// Transaction�� Error ����
var G_isError = false;

// DataSet�� SyncData üũ ����
var G_isSyncDataCheck = false;

// DataSet�� ��Ī
var G_DataSetTitle = null;

// NotNull �÷���
var G_NotNullColName = null;

// Key �÷���
var G_KeyColName = null;

// ���� ��Ŀ���� ���콺 ��ü
var G_FocusObject = null;

// ���� ��Ŀ���� ���콺 �׸����� Dataset ��ü
var G_FocusDataset = null;

// �˻�
var G_findCol = "";
var G_findText = "";
var G_findUpper = false;

// ���� �޼���
var G_MSG_SAVE = "���� �Ͻðڽ��ϱ�?";
var G_MSG_CHANGED_SAVE = "���� ������ ���� �Ͻðڽ��ϱ�?";
var G_MSG_SAVE_OK = "����Ǿ����ϴ�.";
var G_MSG_SAVE_ERR = "�������";
var G_MSG_SEVICE_URL_ERR = "Service URL�� �������� �ʽ��ϴ�.";
var G_MSG_DATASET_NULL = "DataSet�� ��(Null) �Դϴ�.";
var G_MSG_DATASET_NAME_NULL = "DataSet���� ��(Null) �Դϴ�.";
var G_MSG_DATASET_REG_ERR = "DataSet�� ��ϵ��� �ʾҽ��ϴ�.";
var G_MSG_TRANS_NULL = "Transaction�� ��(Null) �Դϴ�.";
var G_MSG_GRID_NULL = "Grid�� ��(Null) �Դϴ�.";
var G_MSG_ROW_NULL = "row(��)�� ��(Null)�̰ų� 1���� �۽��ϴ�.";
var G_MSG_COL_NAME_NULL = "�÷����� ��(Null) �Դϴ�.";
var G_MSG_COL_NOT_NULL = "�ʼ��׸��� �Էµ��� �ʾҽ��ϴ�.";

var G_MSG_COL_KEY_ERROR = "";
var G_MSG_COL_KEY_ERROR_NOT_NULL= "�ʼ��Է��׸��� �Էµ��� �ʾҽ��ϴ�.";
var G_MSG_COL_KEY_ERROR_KEY		= "Ű�׸��� �ߺ��Ǿ����ϴ�.";

// �÷��� ����
var G_NORMAL_COLOR = "#FFFFFF";
var G_KEY_COLOR = "#D6E6F3";
var G_NOTNULL_COLOR = "#FFFFB5";
var G_READONLY_COLOR = "#EFEFEF";
var G_LOV_COLOR = "#E7D576";
var G_TOGGLE_COLOR = "#F4F2D8";
var G_GRID_SET_FOCUS_COLOR = "#BBE0F4"; //<-- �� ��������(#F0F0F0:���õ� ����)
var G_GRID_KILL_FOCUS_COLOR = "#D4D0C8";

// ���� DB ����
var G_ORA_20009 = "ORA-20009";

/*-------------------- �ʱ�ȭ --------------------*/
function G_Initialize()
{
	//objectPatch();
}

/*-------------------- DataSet ���� --------------------*/
// DataSetInfo ��ü Class
function G_DataSetInfo(aDataset, aTrans, aGrid, aServiceURL, aDataSetTitle, aNotNullColName, aSort, aClearChild)
{
	try
	{
		// DataSet
		if (aDataset != null)
		{
			// DataSet�� DataID(Service URL)
			aDataset.DataID = C_isNull(aServiceURL) ? G_MSG_SEVICE_URL_ERR : aServiceURL;
			this.dataset = aDataset;
			this.dataset_id = aDataset.id;
		}
		else
		{
			this.dataset = null;
			this.dataset_id = null;
		}
		
		// Transaction
		if (aTrans != null)
		{
			this.trans = aTrans;
			this.trans_id = aTrans.id;
		}
		else
		{
			this.trans = null;
			this.trans_id = null;
		}
		
		// Grid
		if (aGrid != null)
		{
			this.grid = aGrid;
			this.grid_id = aGrid.id;
		}
		else
		{
			this.grid = null;
			this.grid_id = null;
		}
		
		// �׸����� ��ġ
		this.grid_x = 0;
		this.grid_y = 0;
		// �׸��� ���� �̺�Ʈ �߻� ��ġ
		this.grid_event_x = 0;
		this.grid_event_Y = 0;
		
		// DataSet�� ��Ī
		this.dataset_title = C_isNull(aDataSetTitle) ? aDataset.id : aDataSetTitle;
		
		// NotNull �÷���
		this.notnull_col_name = aNotNullColName;
		
		// Sort ����
		this.sort = C_isNull(aSort) ? true : aSort;
		
		// Master DataSetInfo(���� DataSetInfo�� ����)
		this.masterDataSet = null;
		
		// Detail DataSetInfo(���� DataSetInfo�� ����)
		this.detailDataSets = new Array();
		
		// Relation �÷� ����
		this.relCols = new Array();
		
		this.isLoaded = false;
		this.isClearChild = aClearChild == null ? false:aClearChild;
		
		this.isOffLoadChild = false;
	}
	catch (e)
	{
		C_msgOk("G_DataSetInfo ���� : " + e.message, "����");
	}
}

// RelColInfo ��ü Class
function G_RelColInfo(aMColName, aDColName)
{
	try
	{
		this.masterColName = aMColName;
		this.detailColName = aDColName;
	}
	catch (e)
	{
		C_msgOk("G_RelColInfo ���� : " + e.message, "����");
	}
}

// ��ϵ� DataSet�� �˻�
function G_searchDataSet(aDataSetName)
{
	var dataset = null;
	var datasetinfo = null;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSetName);
		dataset = datasetinfo == null ? null : datasetinfo.dataset;
	}
	catch (e)
	{
		C_msgOk("G_searchDataSet ���� : " + e.message, "����");
	}
	
	return dataset;
}

// ��ϵ� DataSetInfo �˻�
function G_searchDataSetInfo(aDataSetName)
{
	var datasetinfo = null;
	
	try
	{
		if (C_isNull(aDataSetName))
		{
			C_msgOk("G_searchDataSetInfo ���� : " + G_MSG_DATASET_NAME_NULL, "����");
			return null;
		}
		
		// ��ϵ� DataSet�� �˻�
		for (var i = 0; i < G_arrDataSets.length; i++)
		{
			if (G_arrDataSets[i].dataset_id == aDataSetName)
			{
				datasetinfo = G_arrDataSets[i];
				break;
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_searchDataSetInfo ���� : " + e.message, "����");
	}
	
	return datasetinfo;
}
//�ش� ����Ÿ �V�� load ���� ����
function G_isLoaded(aDataSetName)
{
	var datasetinfo = null;
	var changed = false;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSetName);
		return datasetinfo.isLoaded;
	}
	catch (e)
	{
		C_msgOk("G_isChanged ���� : " + e.message, "����");
	}
	
	return false;
}

// ���� DataSet�� ���濩��
function G_isChanged(aDataSetName)
{
	var datasetinfo = null;
	var changed = false;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSetName);
		
		for (var i = 0; i < datasetinfo.detailDataSets.length; i++)
		{
			if (datasetinfo.detailDataSets[i].dataset.IsUpdated)
			{
				G_DataSetTitle = datasetinfo.detailDataSets[i].dataset_title;
				return true;
			}
			
			if (datasetinfo.detailDataSets[i].detailDataSets.length > 0)
			{
				changed = G_isChanged(datasetinfo.detailDataSets[i].dataset_id);
			}
			
			if (changed) return true;
		}
	}
	catch (e)
	{
		C_msgOk("G_isChanged ���� : " + e.message, "����");
	}
	
	return false;
}

// ���� DataSet�� ���ڵ� ���� ����
function G_isExistRow(aDataSetName)
{
	var datasetinfo = null;
	var existRow = false;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSetName);
		
		for (var i = 0; i < datasetinfo.detailDataSets.length; i++)
		{
			if (datasetinfo.detailDataSets[i].dataset.CountRow > 0)
			{
				G_DataSetTitle = datasetinfo.detailDataSets[i].dataset_title;
				return true;
			}
			
			if (datasetinfo.detailDataSets[i].detailDataSets.length > 0)
			{
				existRow = G_isExistRow(datasetinfo.detailDataSets[i].dataset_id);
			}
			
			if (existRow) return true;
		}
	}
	catch (e)
	{
		C_msgOk("G_isExistRow ���� : " + e.message, "����");
	}
	
	return false;
}

// DataSet�� Key �ߺ� �� �Է¿���
function G_isSyncData()
{
	try
	{
		for (var i = 0; i < G_arrDataSets.length; i++)
		{
			G_isSyncDataCheck = true;
			
			if (!G_arrDataSets[i].dataset.SyncData)
			{
				G_DataSetTitle = G_arrDataSets[i].dataset_title;

				// jsk4 �߰� ����
				G_NotNullColName = "";
				G_KeyColName = "";
				for( col=1;col<=G_arrDataSets[i].dataset.CountColumn;col++){
					ColProp = G_arrDataSets[i].dataset.ColumnProp(col);
					// 2 Key Column
					// 4 Not Null Column
					if( (ColProp == 2 ) || (ColProp == 4 ) )
					{
						var _datasetColumn = G_arrDataSets[i].dataset.ColumnID(col);
						var _gridTitle = G_arrDataSets[i].grid.ColumnProp(_datasetColumn, 'Name');

						if(G_arrDataSets[i].dataset.NameString(G_arrDataSets[i].dataset.RowPosition, _datasetColumn) == "")
						{
							if(G_NotNullColName != ""){
								G_NotNullColName = G_NotNullColName + ", ";
							}

							G_NotNullColName = G_NotNullColName + ( C_isNull(_gridTitle)?"["+_datasetColumn + "]":"["+_gridTitle + "]" );
						}

						if(ColProp == 2 ) {
							if(G_KeyColName != ""){
								G_KeyColName = G_KeyColName + ", ";
							}

							G_KeyColName = G_KeyColName + ( C_isNull(_gridTitle)?"["+_datasetColumn + "]":"["+_gridTitle + "]" );
						}
					}
				}
				if(G_NotNullColName != "") {
					G_MSG_COL_KEY_ERROR = G_MSG_COL_KEY_ERROR_NOT_NULL;
					G_NotNullColName = "<BR><BR>* ���Է��׸� : " + G_NotNullColName;
				} else {
					G_MSG_COL_KEY_ERROR = G_MSG_COL_KEY_ERROR_KEY;
					G_NotNullColName = "<BR><BR>* Ű�׸� : " + G_KeyColName;
				}
				// jsk4 �߰� ��

				// �� �ҽ� �ּ�ó��
				/*
				G_NotNullColName = C_isNull(G_arrDataSets[i].notnull_col_name) ? "(�ʼ��Է�:" + G_arrDataSets[i].notnull_col_name + ")" : "";
				*/

				G_isSyncDataCheck = false;
				return false;
			}
			
			G_isSyncDataCheck = false;
		}
	}
	catch (e)
	{
		C_msgOk("G_isSyncData ���� : " + e.message, "����");
	}
	
	return true;
}

// ���� DataSet�� Relation Key �Է¿���
function G_isMasterKeyInserted(aDataSetName)
{
	var datasetinfoM = null;
	var datasetinfoD = null;
	var colname = null;
	var row = -1;
	var columnindex = -1;
	
	try
	{
		datasetinfoD = G_searchDataSetInfo(aDataSetName);
		datasetinfoM = datasetinfoD.masterDataSet;
		
		for (var i = 0; i < datasetinfoD.relCols.length; i++)
		{
			colname = datasetinfoD.relCols[i].masterColName;
			row = datasetinfoM.dataset.RowPosition;
			columnindex = datasetinfoM.dataset.ColumnIndex(colname);
			
			if (C_isNull(datasetinfoM.dataset.ColumnString(row, columnindex)))
			{
				G_DataSetTitle = datasetinfoM.dataset_title;
				return false;
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_isMasterKeyInserted ���� : " + e.message, "����");
	}
	
	return true;
}

// DataSet�� Key �÷� �� Not Null �÷� �Է¿���
function G_isKeyInserted(aDataSetName)
{
	var datasetinfo = null;
	var dataset = null;
	var row = -1;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSetName);
		dataset = datasetinfo.dataset;
		
		for (var i = 1; i <= dataset.CountRow; i++)
		{
			// Row�� Status�� �Է�,����(1:Insert,3:Update)�� �ƴϸ� Skip
			if (dataset.RowStatus(i) != 1 && dataset.RowStatus(i) != 3) continue;
			
			for (var j = 1; j <= dataset.CountColumn; j++)
			{
				// �÷��� �Ӽ��� Key(2) �Ǵ� Not Null(4)�� ��� �Է¿��� ����
				if (dataset.ColumnProp(j) == "2" || dataset.ColumnProp(j) == "4")
				{
					if (C_isNull(dataset.ColumnString(i, j)))
					{
						G_DataSetTitle = datasetinfo.dataset_title;
						return false;
					}
				}
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_isKeyInserted ���� : " + e.message, "����");
	}
	
	return true;
}

// ���� DataSet�� Relation Key�� ���� ������ �Է�
function G_setKeyInsert(aDataSetName)
{
	var datasetinfoM = null;
	var datasetinfoD = null;
	var colnameM = null;
	var rowM = -1;
	var colnameD = null;
	var rowD = -1;
	try
	{
		datasetinfoD = G_searchDataSetInfo(aDataSetName);
		datasetinfoM = datasetinfoD.masterDataSet;
		
		for (var i = 0; i < datasetinfoD.relCols.length; i++)
		{
			colnameM = datasetinfoD.relCols[i].masterColName;
			rowM = datasetinfoM.dataset.RowPosition;
			
			colnameD = datasetinfoD.relCols[i].detailColName;
			rowD = datasetinfoD.dataset.RowPosition;
			datasetinfoD.dataset.NameValue(rowD, colnameD) = datasetinfoM.dataset.NameValue(rowM, colnameM);
		}
	}
	catch (e)
	{
		C_msgOk("G_setKeyInsert ���� : " + e.message, "����");
	}
}

// ���� DataSet ������ �б�
function G_loadDetailDataSet(aDataSetName)
{
	var datasetinfo = null;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSetName);
		if(datasetinfo.isOffLoadChild) return;
		for (var i = 0; i < datasetinfo.detailDataSets.length; i++)
		{
			G_Load(datasetinfo.detailDataSets[i].dataset, "");
		}
	}
	catch (e)
	{
		C_msgOk("G_loadDetailDataSet ���� : " + e.message, "����");
	}
}

// ���� DataSet�� ���ڵ� Ŭ����
function G_clearDetailDataSet(aDataSetName)
{
	var datasetinfo = null;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSetName);
		
		for (var i = 0; i < datasetinfo.detailDataSets.length; i++)
		{
			datasetinfo.detailDataSets[i].dataset.ClearData();
			
			if (datasetinfo.detailDataSets[i].detailDataSets.length > 0)
			{
				G_clearDetailDataSet(datasetinfo.detailDataSets[i].dataset_id);
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_isExistRow ���� : " + e.message, "����");
	}
}


/*-------------------- DataSet �̺�Ʈ ���� --------------------*/
function G_OnRowInsertBefore(dataset)
{
	var ret = true;
	
	try
	{
		// ������ ���� �Լ� Call
		ret = OnRowInsertBefore(dataset);
	}
	catch (e)
	{
		if (typeof(OnRowInsertBefore) == "function")
		{
			C_msgOk("G_OnRowInsertBefore �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
			return false;
		}
	}
	
	// ret�� ���� false�� ��� �Է��۾��� ��ҵȴ�.
	if (ret == false) return false;
	
	return true;
}

function G_OnRowInserted(dataset, row)
{
	try
	{
		// ������ ���� �Լ� Call
		OnRowInserted(dataset, row);
	}
	catch (e)
	{
		if (typeof(OnRowInserted) == "function")
		{
			C_msgOk("G_OnRowInserted �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnRowDeleteBefore(dataset)
{
	var ret = true;
	
	try
	{
		// ������ ���� �Լ� Call
		ret = OnRowDeleteBefore(dataset);
	}
	catch (e)
	{
		if (typeof(OnRowDeleteBefore) == "function")
		{
			C_msgOk("G_OnRowDeleteBefore �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
			return false;
		}
	}
	
	// ret�� ���� false�� ��� �����۾��� ��ҵȴ�.
	if (ret == false) return false;
	
	return true;
}

function G_OnRowDeleted(dataset, row)
{
	try
	{
		// ������ ���� �Լ� Call
		OnRowDeleted(dataset, row);
	}
	catch (e)
	{
		if (typeof(OnRowDeleted) == "function")
		{
			C_msgOk("G_OnRowDeleted �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnDataError(dataset, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnDataError(dataset, row, colid);
	}
	catch (e)
	{
		if (typeof(OnDataError) == "function")
		{
			C_msgOk("G_OnDataError �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_CanRowPosChange(dataset, row)
{
	try
	{
		if (G_isLoading || G_isSaveing || G_isSyncDataCheck) return true;
		
		try
		{
			// ������ ���� �Լ� Call
			if (!OnRowPosChangeBefore(dataset, row)) return false;
		}
		catch (e)
		{
			if (typeof(OnRowPosChangeBefore) == "function")
			{
				C_msgOk("G_CanRowPosChange �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
			}
		}
		
		if (G_isChanged(dataset.id))
		{
			var ret = C_msgYesNoCancel(G_MSG_SAVE, "����");
			
			if (ret == "Y")
			{
				if (!G_saveAllDataMsg(dataset)) return false;
			}
			else if (ret == "C")
			{
				return false;
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_CanRowPosChange ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

function G_OnRowPosChanged(dataset, row)
{
	try
	{
		if (G_isLoading) return;
		
		try
		{
			// ������ ���� �Լ� Call
			OnRowPosChanged(dataset, row);
		}
		catch (e)
		{
			if (typeof(OnRowPosChanged) == "function")
			{
				C_msgOk("G_OnRowPosChanged �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
				return;
			}
		}
		
		// ���� ���̺� ������ �б�
		G_loadDetailDataSet(dataset.id);
		
		// ���� ��Ŀ���� ���� �׸����� �����͙V�� ������ ���¹ٿ� ǥ��
		//alert("��ü2");
		if (dataset == G_FocusDataset) window.status = "[��ü : " + dataset.CountRow + " ��] ���� : " + row + " ��";
	}
	catch (e)
	{
		C_msgOk("G_OnRowPosChanged ���� : " + e.message, "����");
	}
}

function G_OnColumnChanged(dataset, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnColumnChanged(dataset, row, colid);
	}
	catch (e)
	{
		if (typeof(OnColumnChanged) == "function")
		{
			C_msgOk("G_OnColumnChanged �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnLoadBefore(dataset)
{
	try
	{
		// ������ ���� �Լ� Call
		OnLoadBefore(dataset);
	}
	catch (e)
	{
		if (typeof(OnLoadBefore) == "function")
		{
			C_msgOk("G_OnLoadBefore �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnLoadStarted(dataset)
{
	var datasetinfo = G_searchDataSetInfo(dataset.id);
	
	if (datasetinfo.grid != null)
	{
		datasetinfo.grid.ReDraw = false;
	}
	
	// Wait ������ ǥ��
	//C_ShowWait(true);
	
	try
	{
		// ������ ���� �Լ� Call
		OnLoadStarted(dataset);
	}
	catch (e)
	{
		if (typeof(OnLoadStarted) == "function")
		{
			C_msgOk("G_OnLoadStarted �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnLoadCompleted(dataset, rowcnt)
{
	var datasetinfo = null;
	var grid = null;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(dataset.id);
		datasetinfo.isLoaded = true;
		grid = datasetinfo.grid;
		
		if (grid != null)
		{
			grid.ReDraw = true;
			
			for (var i = 1; i <= dataset.CountColumn; i++)
			{
				switch (dataset.ColumnProp(i))
				{
					case 2 :
						if (grid.ColumnProp(dataset.ColumnID(i), "BgColor") == "{Decode(CurRow-ToInteger(CurRow/2)*2, 0, '" + G_TOGGLE_COLOR + "', 1, '" + G_NORMAL_COLOR + "')}")
						{
							grid.ColumnProp(dataset.ColumnID(i), "BgColor") = G_KEY_COLOR;
						}
						break;
					case 4 :
						if (grid.ColumnProp(dataset.ColumnID(i), "BgColor") == "{Decode(CurRow-ToInteger(CurRow/2)*2, 0, '" + G_TOGGLE_COLOR + "', 1, '" + G_NORMAL_COLOR + "')}")
						{
							grid.ColumnProp(dataset.ColumnID(i), "BgColor") = G_NOTNULL_COLOR;
						}
						break;
					default :
						break;
				}
			}
		}
		
		if (rowcnt < 1)
		{
			// ���� DataSet�� ���ڵ� Ŭ����
			G_clearDetailDataSet(dataset.id);
		}
	}
	catch (e)
	{
		C_msgOk("G_OnLoadCompleted Grid �÷��� ������ ���� : " + e.message, "����");
	}
	
	// Wait ������ �����
	//C_ShowWait(false);
	
	try
	{
		G_isLoading = false;
		
		// ������ ���� �Լ� Call
		OnLoadCompleted(dataset, rowcnt);
	}
	catch (e)
	{
		if (typeof(OnLoadCompleted) == "function")
		{
			C_msgOk("G_OnLoadCompleted �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnLoadError(dataset)
{
	var datasetinfo = null;
	var msg = null;
	
	// Wait ������ �����
	//C_ShowWait(false);
	
	try
	{
		datasetinfo = G_searchDataSetInfo(dataset.id);
		
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.ReDraw = true;
		}
		
		msg = datasetinfo.dataset_title + "(" + datasetinfo.dataset_id + ")" + "�� �б� ����\n";
		msg += "\nDataId : " + dataset.DataId;
		msg += "\n�����ڵ� : " + dataset.ErrorCode;
		msg += "\n�����޼��� : " + dataset.ErrorMsg;
		
		try
		{
			G_isLoading = false;
			
			// ������ ���� �Լ� Call
			OnLoadError(dataset, msg);
		}
		catch (e)
		{
			C_msgError(msg, "����");
		}
	}
	catch (e)
	{
		C_msgOk("G_OnLoadError �̺�Ʈ ���� : " + e.message, "����");
	}
}

function G_OnLoadProcess(dataset, rowcnt)
{
	try
	{
		// ������ ���� �Լ� Call
		OnLoadProcess(dataset, rowcnt);
	}
	catch (e)
	{
		if (typeof(OnLoadProcess) == "function")
		{
			C_msgOk("G_OnLoadProcess �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnFilter(dataset, row)
{
	try
	{
		// ������ ���� �Լ� Call
		if (!OnFilter(dataset, row)) return false;
	}
	catch (e)
	{
		if (typeof(OnFilter) == "function")
		{
			C_msgOk("G_OnFilter �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	return true;
}

function G_OnLayoutChanged(dataset, colcnt)
{
	try
	{
		// ������ ���� �Լ� Call
		OnLayoutChanged(dataset, colcnt);
	}
	catch (e)
	{
		if (typeof(OnLayoutChanged) == "function")
		{
			C_msgOk("G_OnLayoutChanged �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnRowsetChanged(dataset)
{
	try
	{
		// ������ ���� �Լ� Call
		OnRowsetChanged(dataset);
	}
	catch (e)
	{
		if (typeof(OnRowsetChanged) == "function")
		{
			C_msgOk("G_OnRowsetChanged �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}


/*-------------------- Transaction �̺�Ʈ ���� --------------------*/
function G_OnPostBefore(dataset, trans)
{
	try
	{
		// ������ ���� �Լ� Call
		if (!OnPostBefore(dataset, trans))
		{
			return false;
		}
	}
	catch (e)
	{
		if (typeof(OnPostBefore) == "function")
		{
			C_msgOk("G_OnPostBefore �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
			return false;
		}
	}
	
	return true;
}

function G_OnSuccess(dataset, trans)
{
	try
	{
		G_isSaveing = false;
		
		// ������ ���� �Լ� Call
		OnSuccess(dataset, trans);
	}
	catch (e)
	{
		if (typeof(OnSuccess) == "function")
		{
			C_msgOk("G_OnSuccess �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnFail(dataset, trans)
{
	var datasetinfo = null;
	var msg = null;
	
	try
	{
		// �ߺ� ������ ����
		if (G_isError) return;
		
		G_isSaveing = false;
		G_isError = true;
		
		datasetinfo = G_searchDataSetInfo(dataset.id);
		
		if (trans.ErrorMsg.indexOf(G_ORA_20009) > -1)
		{
			var liStartIndex = trans.ErrorMsg.indexOf(G_ORA_20009) + G_ORA_20009.length + 2;
			var liEndIndex = trans.ErrorMsg.indexOf("ORA-", liStartIndex) > -1 ? trans.ErrorMsg.indexOf("ORA-", liStartIndex) : trans.ErrorMsg.length;
			msg = trans.ErrorMsg.substring(liStartIndex, liEndIndex);
		}
		else
		{
			//msg = datasetinfo.dataset_title + "(" + datasetinfo.dataset_id + ")" + "�� ���� ����\n";
			msg = "���� ����!\n";
			msg += "\nAction : " + trans.Action;
			msg += "\n�����ڵ� : " + trans.ErrorCode;
			msg += "\n�����޼��� : " + trans.ErrorMsg;
		}
		
		try
		{
			// ������ ���� �Լ� Call
			OnFail(dataset, trans, msg);
		}
		catch (e)
		{
			var ret = trans.ErrorMsg.indexOf(G_ORA_20009) > -1 ? C_msgOk(msg, "����") : C_msgError(msg, "����");
		}
	}
	catch (e)
	{
		C_msgOk("G_OnFail �̺�Ʈ ���� : " + e.message, "����");
	}
}


/*-------------------- Grid �̺�Ʈ ���� --------------------*/
// �׸����� onFocus ó�� �Լ�
function G_OnFocus()
{
	var datasetinfo = null;
	
	try
	{
		// ���� �̺�Ʈ ��ü�� ����
		C_EventObject = event.srcElement;
		
		// ���� ��Ŀ���� ���콺 ��ü�� ����
		G_FocusObject = event.srcElement;
		
		datasetinfo = G_searchDataSetInfo(C_EventObject.DataID);
		// �׸����� ��ġ�� ����
		datasetinfo.grid_x = event.clientX - event.offsetX;
		datasetinfo.grid_y = event.clientY - event.offsetY;
		
		// ���� ��Ŀ���� ���콺 �׸����� Dataset ��ü�� ����
		G_FocusDataset = datasetinfo.dataset;
	}
	catch (e)
	{
		C_msgOk("G_OnFocus ���� : " + e.message, "����");
	}
}

function G_CanColumnPosChange(dataset, grid, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		if (!CanColumnPosChange(dataset, grid, row, colid)) return false;
	}
	catch (e)
	{
		if (typeof(CanColumnPosChange) == "function")
		{
			C_msgOk("G_CanColumnPosChange �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	return true;
}

function G_OnClick(dataset, grid, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnClick(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnClick) == "function")
		{
			C_msgOk("G_OnClick �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnCloseUp(dataset, grid, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnCloseUp(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnCloseUp) == "function")
		{
			C_msgOk("G_OnCloseUp �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnColIndexChanged(dataset, grid, srcIndex, destIndex)
{
	try
	{
		// ������ ���� �Լ� Call
		OnColIndexChanged(dataset, grid, srcIndex, destIndex);
	}
	catch (e)
	{
		if (typeof(OnColIndexChanged) == "function")
		{
			C_msgOk("G_OnColIndexChanged �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnColSizing(dataset, grid, Index, OrgWidth, RstWidth)
{
	try
	{
		// ������ ���� �Լ� Call
		OnColSizing(dataset, grid, Index, OrgWidth, RstWidth);
	}
	catch (e)
	{
		if (typeof(OnColSizing) == "function")
		{
			C_msgOk("G_OnColSizing �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnColumnPosChanged(dataset, grid, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		if (!OnColumnPosChanged(dataset, grid, row, colid)) return false;
	}
	catch (e)
	{
		if (typeof(OnColumnPosChanged) == "function")
		{
			C_msgOk("G_OnColumnPosChanged �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	return true;
}

function G_OnCommand(dataset, grid, code, text)
{
	try
	{
		// ������ ���� �Լ� Call
		OnCommand(dataset, grid, code, text);
	}
	catch (e)
	{
		if (typeof(OnCommand) == "function")
		{
			C_msgOk("G_OnCommand �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	try
	{
		if (code == "1020")
		{
			G_findWindow(dataset, grid);
		}
		else if (code == "1040")
		{
			G_find(dataset, G_findCol, G_findText, G_findUpper, false);
		}
		else if (code == "3010")
		{
			try
			{
				btnquery_onclick();
			}
			catch (e)
			{
				if (typeof(btnquery_onclick) == "function")
				{
					C_msgOk("�����ư(��ȸ) ������ ���� �Լ� Call ���� : " + e.message, "����");
				}
				else
				{
					C_msgOk("�����ư(��ȸ) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
				}
			}
		}
		else if (code == "3020")
		{
			try
			{
				btnadd_onclick();
			}
			catch (e)
			{
				if (typeof(btnadd_onclick) == "function")
				{
					C_msgOk("�����ư(�߰�) ������ ���� �Լ� Call ���� : " + e.message, "����");
				}
				else
				{
					C_msgOk("�����ư(�߰�) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
				}
			}
		}
		else if (code == "3030")
		{
			try
			{
				btninsert_onclick();
			}
			catch (e)
			{
				if (typeof(btninsert_onclick) == "function")
				{
					C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
				}
				else
				{
					C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
				}
			}
		}
		else if (code == "3040")
		{
			try
			{
				btndelete_onclick();
			}
			catch (e)
			{
				if (typeof(btndelete_onclick) == "function")
				{
					C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
				}
				else
				{
					C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
				}
			}
		}
		else if (code == "3045")
		{
			G_duplicateColumn(dataset, grid);
		}
		else if (code == "3050")
		{
			try
			{
				btnsave_onclick();
			}
			catch (e)
			{
				if (typeof(btnsave_onclick) == "function")
				{
					C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
				}
				else
				{
					C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
				}
			}
		}
		else if (code == "5020")
		{
			var datasetinfo = G_searchDataSetInfo(dataset.id);
			
			grid.RunExcel(datasetinfo.dataset_title);
		}
		else if (code == "5040")
		{
			var datasetinfo = G_searchDataSetInfo(dataset.id);
			
			grid.RunExcelSheet(datasetinfo.dataset_title);
		}
		else if (code == "7020")
		{
			grid.ColumnProp(grid.GetColumn(), "Show") = "false";
		}
		else if (code == "7040")
		{
			var lrCols = G_getGridCols(grid);
		
			if (lrCols != null && lrCols.length > 0)
			{
				for (var i = 0; i < lrCols.length; i++)
				{
					grid.ColumnProp(lrCols[i], "Show") = "true";
				}
			}
		}
		else if (code.toString().length > 4 && code.toString().substring(0, 4) == "7040")
		{
			var lrCols = G_getGridCols(grid);
			var subcode = code.toString().substring(4);
			
			if (subcode == "0")
			{
				if (lrCols != null && lrCols.length > 0)
				{
					for (var i = 0; i < lrCols.length; i++)
					{
						if (grid.ColumnProp(lrCols[i], "Show") == "FALSE")
						{
							grid.ColumnProp(lrCols[i], "Show") = "true";
						}
					}
				}
			}
			else
			{
				grid.ColumnProp(lrCols[parseInt(subcode) - 1], "Show") = "true";
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_OnCommand �̺�Ʈ ���� : " + e.message, "����");
	}
}

function G_OnDblClick(dataset, grid, row, colid)
{
	var datasetinfo = null;
	
	try
	{
		// ������ ���� �Լ� Call
		if (row > 0)
		{
			OnDblClick(dataset, grid, row, colid);
		}
	}
	catch (e)
	{
		if (typeof(OnDblClick) == "function")
		{
			C_msgOk("G_OnDblClick �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	try
	{
		if (G_searchDataSetInfo(dataset.id).sort == true && row == 0)
		{
			var lsSign = "";
			
			if (colid == dataset.SortExpr.substr(1))
			{
				lsSign = dataset.SortExpr.substr(0, 1) == "+" ? "-" : "+";
			}
			else
			{
				lsSign = "+";
			}
			
			dataset.SortExpr = lsSign + colid;
			dataset.Sort();
		}
	}
	catch (e)
	{
		C_msgOk("G_OnDblClick Grid �÷��� Sort ���� : " + e.message, "����");
	}
}

function G_OnDropDown(dataset, grid, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnDropDown(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnDropDown) == "function")
		{
			C_msgOk("G_OnDropDown �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnEnter(dataset, grid, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnEnter(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnEnter) == "function")
		{
			C_msgOk("G_OnEnter �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnExit(dataset, grid, row, colid, olddata)
{
	try
	{
		// ������ ���� �Լ� Call
		OnExit(dataset, grid, row, colid, olddata);
	}
	catch (e)
	{
		if (typeof(OnExit) == "function")
		{
			C_msgOk("G_OnExit �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnFirstUp(dataset, grid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnFirstUp(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnFirstUp) == "function")
		{
			C_msgOk("G_OnFirstUp �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnKeyPress(dataset, grid, kcode)
{
	try
	{
		// ������ ���� �Լ� Call
		OnKeyPress(dataset, grid, kcode);
	}
	catch (e)
	{
		if (typeof(OnKeyPress) == "function")
		{
			C_msgOk("G_OnKeyPress �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	try
	{
		if (kcode == "123") // F12
		{
			if (C_isNull(G_findCol) || C_isNull(G_findText))
			{
				G_findWindow(dataset, grid);
			}
			else
			{
				G_find(dataset, G_findCol, G_findText, G_findUpper, false);
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_OnKeyPress ���� : " + e.message, "����");
		return;
	}
}

function G_OnKillFocus(dataset, grid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnKillFocus(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnKillFocus) == "function")
		{
			C_msgOk("G_OnKillFocus �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	try
	{
		/*
		window.status = "";
		*/
	}
	catch (e)
	{
		C_msgOk("G_OnKillFocus �̺�Ʈ ���� : " + e.message, "����");
	}
}

function G_OnLastDown(dataset, grid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnLastDown(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnLastDown) == "function")
		{
			C_msgOk("G_OnLastDown �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnLButtonDblClk(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// ������ ���� �Լ� Call
		OnLButtonDblClk(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnLButtonDblClk) == "function")
		{
			C_msgOk("G_OnLButtonDblClk �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnLButtonDown(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// ������ ���� �Լ� Call
		OnLButtonDown(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnLButtonDown) == "function")
		{
			C_msgOk("G_OnLButtonDown �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnLButtonUp(dataset, grid, row, colid, xpos, ypos)
{
	var datasetinfo = null;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(dataset.id);
		// �̺�Ʈ �߻���ġ ����
		datasetinfo.grid_event_x = xpos;
		datasetinfo.grid_event_y = ypos;
	}
	catch (e)
	{
		C_msgOk("G_OnLButtonUp ���� : " + e.message, "����");
	}
	
	try
	{
		// ������ ���� �Լ� Call
		OnLButtonUp(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnLButtonUp) == "function")
		{
			C_msgOk("G_OnLButtonUp �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnPopup(dataset, grid, row, colid, data)
{
	try
	{
		// ������ ���� �Լ� Call
		OnPopup(dataset, grid, row, colid, data);
	}
	catch (e)
	{
		if (typeof(OnPopup) == "function")
		{
			C_msgOk("G_OnPopup �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnRButtonDblClk(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// ������ ���� �Լ� Call
		OnRButtonDblClk(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnRButtonDblClk) == "function")
		{
			C_msgOk("G_OnRButtonDblClk �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnRButtonDown(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// ������ ���� �Լ� Call
		OnRButtonDown(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnRButtonDown) == "function")
		{
			C_msgOk("G_OnRButtonDown �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	try
	{
		var lsBar1 = "����������������^1^0001^false";
		var lsBar2 = "����������������^1^0002^false";
		var lsBar3 = "����������������^1^0003^false";
		
		var lsFind = dataset.CountRow > 0 ? "ã��(ALT+F)^1^1020^true" : "ã��^1^1020^false";
		var lsNextFind = C_isNull(G_findCol) || C_isNull(G_findText) || dataset.CountRow < 1 ? "����ã��(F12)^1^1040^false" : "����ã��(F12)^1^1040^true";
		
		var lsLoad = "��ȸ(ALT+R)^1^3010^true";
		var lsAdd = "�߰�(ALT+A)^1^3020^true";
		var lsInsert = dataset.CountRow > 0 ? "����(ALT+I)^1^3030^true" : "����(ALT+I)^1^3030^false";
		var lsDelete = dataset.CountRow > 0 ? "����(ALT+D)^1^3040^true" : "����(ALT+D)^1^3040^false";
		var	lsDuplicate = dataset.CountRow > 0 && dataset.RowPosition > 1 ? "����(ALT+C)^1^3045^true" : "����(ALT+C)^1^3045^false";
		var lsSave = "����(ALT+S)^1^3050^true";
		
		var lsExcel = dataset.CountRow > 0 ? "������ȯ^1^5020^true" : "������ȯ^1^5020^false";
		var lsExcelSheet = dataset.CountRow > 0 ? "������ȯ(Sheet)^1^5040^true" : "������ȯ(Sheet)^1^5040^false";
		
		var lsColHide = C_isNull(grid.GetColumn()) ? "�������^1^7020^false" : "�������^1^7020^true";
		var lsColShow = "�����̱�^1^7040^true";
		var lsColList = "��ü^2^70400^true,";
		
		// ������ �� ����Ʈ�� ���� �޴��� ����
		var lrCols = G_getGridCols(grid);
		
		if (lrCols != null && lrCols.length > 0)
		{
			for (var i = 0; i < lrCols.length; i++)
			{
				if (grid.ColumnProp(lrCols[i], "Show") == "FALSE")
				{
					lsColList += grid.ColumnProp(lrCols[i], "Name") + "^2^7040" + (i + 1) + "^true,";
				}
			}
			
			lsColList = lsColList.substring(0, lsColList.length - 1);
		}
		
		switch (C_ProgAuthority)
		{
			case "U" : // ����
				break;
			case "R" : // �б�
				lsLoad = "��ȸ(ALT+R)^1^3010^true";
				lsAdd = "�߰�(ALT+A)^1^3020^false";
				lsInsert = "����(ALT+I)^1^3030^false";
				lsDelete = "����(ALT+D)^1^3040^false";
				lsSave = "����(ALT+S)^1^3050^false";
				lsDuplicate = "����(ALT+C)^1^3045^false";
				break;
			case "S" : // ����
				lsLoad = "��ȸ(ALT+R)^1^3010^true";
				lsAdd = "�߰�(ALT+A)^1^3020^false";
				lsInsert = "����(ALT+I)^1^3030^false";
				lsDelete = "����(ALT+D)^1^3040^false";
				lsSave = "����(ALT+S)^1^3050^true";
				break;
			case "P" : // ����
				lsLoad = "��ȸ(ALT+R)^1^3010^true";
				lsAdd = "�߰�(ALT+A)^1^3020^false";
				lsInsert = "����(ALT+I)^1^3030^false";
				lsDelete = "����(ALT+D)^1^3040^false";
				lsSave = "����(ALT+S)^1^3050^false";
				lsDuplicate = "����(ALT+C)^1^3045^false";
				break;
			default :
				lsLoad = "��ȸ(ALT+R)^1^3010^false";
				lsAdd = "�߰�(ALT+A)^1^3020^false";
				lsInsert = "����(ALT+I)^1^3030^false";
				lsDelete = "����(ALT+D)^1^3040^false";
				lsSave = "����(ALT+S)^1^3050^false";
				lsDuplicate = "����(ALT+C)^1^3045^false";
				break;
		}
		if(! grid.Editable)
		{
			lsAdd = "�߰�(ALT+A)^1^3020^false";
			lsInsert = "����(ALT+I)^1^3030^false";
			lsDelete = "����(ALT+D)^1^3040^false";
			lsSave = "����(ALT+S)^1^3050^false";
			lsDuplicate = "����(ALT+C)^1^3045^false";
		}
		grid.MenuData = lsFind + "," + lsNextFind;
		grid.MenuData += "," + lsBar1 + "," + lsLoad + "," + lsAdd + "," + lsInsert + "," + lsDuplicate + "," + lsDelete + "," + lsSave;
		grid.MenuData += "," + lsBar2 + "," + lsExcel + "," + lsExcelSheet;
		grid.MenuData += "," + lsBar3 + "," + lsColHide + "," + lsColShow + "," + lsColList;
		grid.SetColumn(colid);
		grid.TrackPopupMenu (xpos, ypos);
	}
	catch (e)
	{
		C_msgOk("G_OnRButtonDown �̺�Ʈ ���� : " + e.message, "����");
	}
}

function G_OnRButtonUp(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// ������ ���� �Լ� Call
		OnRButtonUp(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnRButtonUp) == "function")
		{
			C_msgOk("G_OnRButtonUp �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnReturn(dataset, grid, row, colid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnReturn(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnReturn) == "function")
		{
			C_msgOk("G_OnReturn �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnScrolling(dataset, grid, row, column, setscrolling)
{
	try
	{
		// ������ ���� �Լ� Call
		OnScrolling(dataset, grid, row, column, setscrolling);
	}
	catch (e)
	{
		if (typeof(OnScrolling) == "function")
		{
			C_msgOk("G_OnScrolling �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}

function G_OnSetFocus(dataset, grid)
{
	try
	{
		// ������ ���� �Լ� Call
		OnSetFocus(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnSetFocus) == "function")
		{
			C_msgOk("G_OnSetFocus �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
	
	try
	{
		var lrCols = null;
		var lrGrps = null;
		
		// ��ü �׸��� ���V
		for (var i = 0; i < G_arrDataSets.length; i++)
		{
			if (G_arrDataSets[i].grid == null) continue;
			
			lrCols = G_getGridCols(G_arrDataSets[i].grid);

			G_arrDataSets[i].grid.IndicatorBkColor = G_arrDataSets[i].grid == grid ? G_GRID_SET_FOCUS_COLOR : G_GRID_KILL_FOCUS_COLOR;
			//G_arrDataSets[i].grid.IndicatorColBkColor = G_arrDataSets[i].grid == grid ? G_GRID_SET_FOCUS_COLOR : G_GRID_KILL_FOCUS_COLOR;
			
			if (lrCols != null && lrCols.length > 0)
			{
				for (var j = 0; j < lrCols.length; j++)
				{
					G_arrDataSets[i].grid.ColumnProp(lrCols[j], "HeadBgColor") = G_arrDataSets[i].grid == grid ? G_GRID_SET_FOCUS_COLOR : G_GRID_KILL_FOCUS_COLOR;
				}
			}			
		}
		
		// ���� ��Ŀ���� ���� �׸����� �����͙V ����
		G_FocusDataset = dataset;
		
		// ���� ��Ŀ���� ���� �׸����� �����͙V�� ������ ���¹ٿ� ǥ��
		window.status = "[��ü : " + dataset.CountRow + " ��] ���� : " + dataset.RowPosition + " ��";
	}
	catch (e)
	{
		C_msgOk("G_OnSetFocus �̺�Ʈ ���� : " + e.message, "����");
	}
}

function G_OnUserColor(dataset, grid, row, eventid)
{
	try
	{
		// ������ ���� �Լ� Call
		return OnUserColor(dataset, grid, row, eventid);
	}
	catch (e)
	{
		if (typeof(OnUserColor) == "function")
		{
			C_msgOk("G_OnUserColor �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
		}
	}
}


/*-------------------- ������ ��밡�� �Լ� --------------------*/
// DataSet ���� �ʱ�ȭ
function G_DataSetInit(dataset)
{
	if (dataset == null)
	{
		C_msgOk("DataSet ���� �ʱ�ȭ ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	try
	{
		// !!DataSet ���� �ʱ�ȭ �߰�!!
		dataset.SyncLoad = true;
	}
	catch (e)
	{
		C_msgOk("DataSet ���� �ʱ�ȭ ���� ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// Transaction ���� �ʱ�ȭ
function G_TransInit(trans)
{
	if (trans == null)
	{
		C_msgOk("Transaction ���� �ʱ�ȭ ���� : " + G_MSG_TRANS_NULL, "����");
		return false;
	}
	
	try
	{
		// !!Transaction ���� �ʱ�ȭ �߰�!!
		trans.ServerIP = "";
		trans.KeyName = "toinb_dataid4";
		trans.Protocol = "1";
		//trans.StatusResetType = "0";
	}
	catch (e)
	{
		C_msgOk("Transaction ���� �ʱ�ȭ ���� ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// Grid ���� �ʱ�ȭ
function G_GridInit(grid)
{
	if (grid == null)
	{
		C_msgOk("Grid ���� �ʱ�ȭ ���� : " + G_MSG_GRID_NULL, "����");
		return false;
	}
	
	try
	{
		// !!Grid ���� �ʱ�ȭ �߰�!!
		grid.ColSelect = false;
		grid.SortView = "false";
		grid.AutoResizing = true;
		grid.FixSizing = true;
		grid.UsingOneClick = 1;
		grid.DragDropEnable = true;
		//grid.BorderStyle = 1;
		//grid.HeadBorder = 4;
	}
	catch (e)
	{
		C_msgOk("Grid ���� �ʱ�ȭ ���� ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet ���
function G_addDataSet(aDataset, aTrans, aGrid, aServiceURL, aDataSetTitle, aNotNullColName, aSort, aClearChild)
{
	if (aDataset == null)
	{
		C_msgOk("DataSet ��� ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	try
	{
		var objDataSetInfo = new G_DataSetInfo(aDataset, aTrans, aGrid, aServiceURL, aDataSetTitle, aNotNullColName, aSort, aClearChild);
		
		if (G_arrDataSets == null) G_arrDataSets = new Array();
		
		G_arrDataSets.push(objDataSetInfo);
	}
	catch (e)
	{
		C_msgOk("DataSet ��� ���� : " + e.message, "����");
		return false;
	}
	
	try
	{
		G_DataSetInit(aDataset);
		// DataSet ���� �̺�Ʈ
		aDataset.attachEvent ("OnRowInserted", new Function("row", "G_OnRowInserted(" + aDataset.id + ", row);"));
		aDataset.attachEvent ("OnRowDeleted", new Function("row", "G_OnRowDeleted(" + aDataset.id + ", row);"));
		aDataset.attachEvent ("OnDataError", new Function("row", "colid", "G_OnDataError(" + aDataset.id + ", row, colid);"));
		aDataset.attachEvent ("CanRowPosChange", new Function("row", "return G_CanRowPosChange(" + aDataset.id + ", row);"));
		aDataset.attachEvent ("OnRowPosChanged", new Function("row", "G_OnRowPosChanged(" + aDataset.id + ", row);"));
		aDataset.attachEvent ("OnColumnChanged", new Function("row", "colid", "G_OnColumnChanged(" + aDataset.id + ", row, colid);"));
		aDataset.attachEvent ("OnLoadStarted", new Function("G_OnLoadStarted(" + aDataset.id + ");"));
		aDataset.attachEvent ("OnLoadCompleted", new Function("rowcnt", "G_OnLoadCompleted(" + aDataset.id + ", rowcnt);"));
		aDataset.attachEvent ("OnLoadError", new Function("G_OnLoadError(" + aDataset.id + ");"));
		aDataset.attachEvent ("OnLoadProcess", new Function("rowcnt", "G_OnLoadProcess(" + aDataset.id + ", rowcnt);"));
		aDataset.attachEvent ("OnFilter", new Function("row", "return G_OnFilter(" + aDataset.id + ", row);"));
		aDataset.attachEvent ("OnLayoutChanged", new Function("colcnt", "G_OnLayoutChanged(" + aDataset.id + ", colcnt);"));
		aDataset.attachEvent ("OnRowsetChanged", new Function("G_OnRowsetChanged(" + aDataset.id + ");"));
	}
	catch (e)
	{
		C_msgOk("DataSet �ʱ�ȭ ���� : " + e.message, "����");
		return false;
	}
	
	try
	{
		if (aTrans != null)
		{
			G_TransInit(aTrans);
			
			// Transaction ���� �̺�Ʈ
			aTrans.attachEvent ("OnSuccess", new Function("G_OnSuccess(" + aDataset.id + ", " + aTrans.id + ");"));
			aTrans.attachEvent ("OnFail", new Function("G_OnFail(" + aDataset.id + ", " + aTrans.id + ");"));
		}
	}
	catch (e)
	{
		C_msgOk("Transaction �ʱ�ȭ ���� : " + e.message, "����");
		return false;
	}
	
	try
	{
		if (aGrid != null)
		{
			aGrid.DataID = aDataset.id;
			
			G_GridInit(aGrid);
			G_setGridToggleColor(aGrid);
			
			// �׸����� onFocus ó�� �Լ�
			aGrid.onfocus = G_OnFocus;
			
			// Grid ���� �̺�Ʈ
			aGrid.attachEvent ("CanColumnPosChange", new Function("row", "colid", "return G_CanColumnPosChange(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnClick", new Function("row", "colid", "G_OnClick(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnCloseUp", new Function("row", "colid", "G_OnCloseUp(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnColIndexChanged", new Function("srcIndex", "destIndex", "G_OnColIndexChanged(" + aDataset.id + ", " + aGrid.id + ", srcIndex, destIndex);"));
			aGrid.attachEvent ("OnColSizing", new Function("Index", "OrgWidth", "RstWidth", "G_OnColSizing(" + aDataset.id + ", " + aGrid.id + ", Index, OrgWidth, RstWidth);"));
			aGrid.attachEvent ("OnColumnPosChanged", new Function("row", "colid", "return G_OnColumnPosChanged(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnCommand", new Function("code", "text", "G_OnCommand(" + aDataset.id + ", " + aGrid.id + ", code, text);"));
			aGrid.attachEvent ("OnDblClick", new Function("row", "colid", "G_OnDblClick(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnDropDown", new Function("row", "colid", "G_OnDropDown(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnEnter", new Function("row", "colid", "G_OnEnter(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnExit", new Function("row", "colid", "olddata", "G_OnExit(" + aDataset.id + ", " + aGrid.id + ", row, colid, olddata);"));
			aGrid.attachEvent ("OnFirstUp", new Function("G_OnFirstUp(" + aDataset.id + ", " + aGrid.id + ");"));
			aGrid.attachEvent ("OnKeyPress", new Function("kcode", "G_OnKeyPress(" + aDataset.id + ", " + aGrid.id + ", kcode);"));
			aGrid.attachEvent ("OnKillFocus", new Function("G_OnKillFocus(" + aDataset.id + ", " + aGrid.id + ");"));
			aGrid.attachEvent ("OnLastDown", new Function("G_OnLastDown(" + aDataset.id + ", " + aGrid.id + ");"));
			aGrid.attachEvent ("OnLButtonDblClk", new Function("row", "colid", "xpos", "ypos", "G_OnLButtonDblClk(" + aDataset.id + ", " + aGrid.id + ", row, colid, xpos, ypos);"));
			aGrid.attachEvent ("OnLButtonDown", new Function("row", "colid", "xpos", "ypos", "G_OnLButtonDown(" + aDataset.id + ", " + aGrid.id + ", row, colid, xpos, ypos);"));
			aGrid.attachEvent ("OnLButtonUp", new Function("row", "colid", "xpos", "ypos", "G_OnLButtonUp(" + aDataset.id + ", " + aGrid.id + ", row, colid, xpos, ypos);"));
			aGrid.attachEvent ("OnPopup", new Function("row", "colid", "data", "G_OnPopup(" + aDataset.id + ", " + aGrid.id + ", row, colid, data);"));
			aGrid.attachEvent ("OnRButtonDblClk", new Function("row", "colid", "xpos", "ypos", "G_OnRButtonDblClk(" + aDataset.id + ", " + aGrid.id + ", row, colid, xpos, ypos);"));
			aGrid.attachEvent ("OnRButtonDown", new Function("row", "colid", "xpos", "ypos", "G_OnRButtonDown(" + aDataset.id + ", " + aGrid.id + ", row, colid, xpos, ypos);"));
			aGrid.attachEvent ("OnRButtonUp", new Function("row", "colid", "xpos", "ypos", "G_OnRButtonUp(" + aDataset.id + ", " + aGrid.id + ", row, colid, xpos, ypos);"));
			aGrid.attachEvent ("OnReturn", new Function("row", "colid", "G_OnReturn(" + aDataset.id + ", " + aGrid.id + ", row, colid);"));
			aGrid.attachEvent ("OnScrolling", new Function("row", "column", "setscrolling", "G_OnScrolling(" + aDataset.id + ", " + aGrid.id + ", row, column, setscrolling);"));
			aGrid.attachEvent ("OnSetFocus", new Function("G_OnSetFocus(" + aDataset.id + ", " + aGrid.id + ");"));
			aGrid.attachEvent ("OnUserColor", new Function("row", "eventid", "return G_OnUserColor(" + aDataset.id + ", " + aGrid.id + ", row, eventid);"));
		}
	}
	catch (e)
	{
		C_msgOk("Grid �ʱ�ȭ ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� Relation ���
function G_addRel(aMasterDataset, aDetailDataset)
{
	if (aMasterDataset == null || aDetailDataset == null)
	{
		C_msgOk("G_addRel ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	try
	{
		var datasetinfoM = G_searchDataSetInfo(aMasterDataset.id);
		var datasetinfoD = G_searchDataSetInfo(aDetailDataset.id);
		
		if (datasetinfoM == null)
		{
			C_msgOk("G_addRel ���� : " + G_MSG_DATASET_REG_ERR + "(" + aMasterDataset.id + ")", "����");
			return false;
		}
		
		if (datasetinfoD == null)
		{
			C_msgOk("G_addRel ���� : " + G_MSG_DATASET_REG_ERR + "(" + aDetailDataset.id + ")", "����");
			return false;
		}
		
		if (datasetinfoM.detailDataSets == null) datasetinfoM.detailDataSets = new Array();
		
		datasetinfoM.detailDataSets.push(datasetinfoD);
		datasetinfoD.masterDataSet = datasetinfoM;
	}
	catch (e)
	{
		C_msgOk("G_addRel ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� Relation ���
function G_addRelCol(aDataset, aMasterColName, aDetailColName)
{
	if (aDataset == null)
	{
		C_msgOk("G_addRelCol ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	if (C_isNull(aMasterColName) || C_isNull(aDetailColName))
	{
		C_msgOk("G_addRelCol ���� : " + G_MSG_COL_NAME_NULL, "����");
		return false;
	}
	
	try
	{
		var datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		if (datasetinfo == null)
		{
			C_msgOk("G_addRelCol ���� : " + G_MSG_DATASET_REG_ERR + "(" + aDataset.id + ")", "����");
			return false;
		}
		
		if (datasetinfo.relCols == null) datasetinfo.relCols = new Array();
		
		var relColInfo = new G_RelColInfo(aMasterColName, aDetailColName);
		
		datasetinfo.relCols.push(relColInfo);
	}
	catch (e)
	{
		C_msgOk("G_addRelCol ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� �ڷ��б�
function G_Load(aDataset, aDataId)
{
	if (aDataset == null)
	{
		C_msgOk("G_Load ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	try
	{
		// �б��� ������� üũ(���� ��� ����)
		/*
		if (aDataset.IsUpdated || G_isChanged(aDataset.id))
		{
			var ret = C_msgYesNo(G_MSG_CHANGED_SAVE, "����");
			
			if (ret == "Y")
			{
				if (!G_saveAllData(aDataset)) return false;
			}
			else
			{
				G_clearAllData(aDataset);
			}
		}
		*/
		
		G_isLoading = true;
		
		if (!C_isNull(aDataId))
		{
			aDataset.DataId = aDataId;
		}
		
		G_OnLoadBefore(aDataset);

		aDataset.reset();
	}
	catch (e)
	{
		G_isLoading = false;
		C_msgOk("G_Load ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� �� �� �߰�
function G_addRow(aDataset, aValid)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_addRow ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	if (!G_OnRowInsertBefore(aDataset)) return;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		if (aValid == null || aValid == true)
		{
			if (!G_isSyncData())
			{
				C_msgOk("'" + G_DataSetTitle + "'�� " + G_MSG_COL_KEY_ERROR + G_NotNullColName, "����");
				return false;
			}
			
			if (!G_isMasterKeyInserted(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'�� " + G_MSG_COL_NOT_NULL, "����");
				return false;
			}
			
			if (G_isChanged(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'��(��) ������� �ʾҽ��ϴ�.", "����");
				return false;
			}
		}
		
		aDataset.addRow();
		G_setKeyInsert(aDataset.id);
		
		// �ڵ� ��Ŀ��
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_addRow ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� Ư�� ��ġ�� �� �� �߰�
function G_insertRow(aDataset, row, aValid)
{
	var datasetinfo = null;
	var iRow = 0;
	
	if (aDataset == null)
	{
		C_msgOk("G_insertRow ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	iRow = (row == null || row == undefined) ? aDataset.RowPosition : row;
	
	if (row < 1)
	{
		C_msgOk("G_insertRow ���� : " + G_MSG_ROW_NULL, "����");
		return false;
	}
	
	if (!G_OnRowInsertBefore(aDataset)) return;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		if (aValid == null || aValid == true)
		{
			if (!G_isSyncData())
			{
				C_msgOk("'" + G_DataSetTitle + "'�� " + G_MSG_COL_KEY_ERROR + G_NotNullColName, "����");
				return false;
			}
			
			if (!G_isMasterKeyInserted(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'�� " + G_MSG_COL_NOT_NULL, "����");
				return false;
			}
			
			if (G_isChanged(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'��(��) ������� �ʾҽ��ϴ�.", "����");
				return false;
			}
		}
		
		aDataset.InsertRow(iRow);
		G_setKeyInsert(aDataset.id);
		
		// �ڵ� ��Ŀ��
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_insertRow ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� Ư�� ��ġ�� �� �� ����
function G_deleteRow(aDataset, row, aValid)
{
	var datasetinfo = null;
	var iRow = 0;
	
	if (aDataset == null)
	{
		C_msgOk("G_deleteRow ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	iRow = (row == null || row < 1) ? aDataset.RowPosition : row;
	
	if (aDataset.CountRow > 0)
	{
		if (iRow == null || iRow < 1)
		{
			C_msgOk("G_deleteRow ���� : " + G_MSG_ROW_NULL, "����");
			return false;
		}
	}
	
	if (!G_OnRowDeleteBefore(aDataset)) return;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		if (aValid == null || aValid == true)
		{
			if (G_isChanged(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'��(��) ������� �ʾҽ��ϴ�.", "����");
				return false;
			}
			
			if (G_isExistRow(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'�� �����Ͱ� �����մϴ�.", "����");
				return false;
			}
		}
		
		aDataset.DeleteRow(iRow);
		
		// �ڵ� ��Ŀ��
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_deleteRow ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� ��� �� ����
function G_deleteAllRow(aDataset, aValid)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_deleteAllRow ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	if (!G_OnRowDeleteBefore(aDataset)) return;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		if (aValid == null || aValid == true)
		{
			if (G_isChanged(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'��(��) ������� �ʾҽ��ϴ�.", "Ȯ��");
				return false;
			}
			
			if (G_isExistRow(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'�� �����Ͱ� �����մϴ�.", "Ȯ��");
				return false;
			}
		}
		
		aDataset.DeleteAll();
		
		// �ڵ� ��Ŀ��
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_deleteAllRow ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}

// DataSet�� ����
function G_saveData(aDataset)
{
	var datasetinfo = null;
	var trans = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_saveData ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		trans = datasetinfo.trans;
		
		if (trans == null)
		{
			C_msgOk("G_saveData ���� : " + G_MSG_TRANS_NULL + "(" + aDataset.id + ")", "����");
			return false;
		}
		
		if(!G_OnPostBefore(aDataset, trans)) return false;
		
		if (!G_isSyncData())
		{
			C_msgOk("'" + G_DataSetTitle + "'�� " + G_MSG_COL_KEY_ERROR + G_NotNullColName, "����");
			return false;
		}
		
		if (!G_isKeyInserted(aDataset.id))
		{
			C_msgOk("'" + G_DataSetTitle + "'�� " + G_MSG_COL_NOT_NULL, "Ȯ��");
			return false;
		}
		
		G_isSaveing = true;
		G_isError = false;

		trans.Post();
	}
	catch (e)
	{
		G_isSaveing = false;
		C_msgOk("G_saveData ���� : " + e.message, "����");
		return false;
	}
	
	return !G_isError;
}

// DataSet�� ����(����Ϸ� �޼��� ���)
function G_saveDataMsg(aDataset)
{
	if (G_saveData(aDataset) && !G_isError)
	{
		C_msgOk(G_MSG_SAVE_OK);
		return true;
	}
	else
	{
		return false;
	}
}
// �ش� DataSet�� ���� �� ������ ��� DataSet ����(����Ϸ� �޼��� ���)
function G_saveAllDataMsg(aDataset)
{
	if (G_saveAllData(aDataset))
	{
		C_msgOk(G_MSG_SAVE_OK);
		return true;
	}
	else
	{
		return false;
	}
}

// �ش� DataSet�� ���� �� ������ ��� DataSet ����
function G_saveAllData(aDataset)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_saveAllData ���� : " + G_MSG_DATASET_NULL, "����");
		return false;
	}
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		if (aDataset.IsUpdated)
		{
			if (!G_saveData(aDataset)) return false;
		}
		
		for (var i = 0; i < datasetinfo.detailDataSets.length; i++)
		{
			if (!G_saveAllData(datasetinfo.detailDataSets[i].dataset)) return false;
		}
	}
	catch (e)
	{
		C_msgOk("G_saveAllData ���� : " + e.message, "����");
		return false;
	}
	
	return true;
}


// �ش� DataSet �� ������ ��� DataSet�� ��� Data �� Header ������ �����
function G_clearAllData(aDataset)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_clearAllData ���� : " + G_MSG_DATASET_NULL, "����");
		return;
	}
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		aDataset.ClearAll();
		
		for (var i = 0; i < datasetinfo.detailDataSets.length; i++)
		{
			G_clearAllData(datasetinfo.detailDataSets[i].dataset);
		}
	}
	catch (e)
	{
		C_msgOk("G_clearAllData ���� : " + e.message, "����");
		return;
	}
}

// �ش� DataSet�� �б�/���� �÷� ����
function G_setReadWriteCol(aGrid, aColName)
{
	if (aGrid == null)
	{
		C_msgOk("G_setReadWriteCol ���� : " + G_MSG_GRID_NULL, "����");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setReadWriteCol ���� : " + G_MSG_COL_NAME_NULL, "����");
		return;
	}
	
	try
	{
		aGrid.ColumnProp(aColName, "Edit") = "";
		aGrid.ColumnProp(aColName, "BgColor") = G_NORMAL_COLOR;
	}
	catch (e)
	{
		C_msgOk("G_setReadWriteCol ���� : " + e.message, "����");
		return;
	}
}

// �ش� DataSet�� �б����� �÷� ����
function G_setReadOnlyCol(aGrid, aColName)
{
	if (aGrid == null)
	{
		C_msgOk("G_setReadOnlyCol ���� : " + G_MSG_GRID_NULL, "����");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setReadOnlyCol ���� : " + G_MSG_COL_NAME_NULL, "����");
		return;
	}
	
	try
	{
		aGrid.ColumnProp(aColName, "Edit") = "None"; // �����Ұ�
		aGrid.ColumnProp(aColName, "BgColor") = G_READONLY_COLOR;
	}
	catch (e)
	{
		C_msgOk("G_setReadOnlyCol ���� : " + e.message, "����");
		return;
	}
}

// �ش� DataSet�� LOV �÷� ����
function G_setLovCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setLovCol ���� : " + G_MSG_GRID_NULL, "����");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setLovCol ���� : " + G_MSG_COL_NAME_NULL, "����");
		return;
	}
	
	try
	{
		//aGrid.ColumnProp(aColName, "Edit") = "None"; // �����Ұ�
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_LOV_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "Popup";
	}
	catch (e)
	{
		C_msgOk("G_setLovCol ���� : " + e.message, "����");
		return;
	}
}

// �ش� Grid�� LOV �÷� ����(�÷������Ұ�)
function G_setLovFixCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setLovFixCol ���� : " + G_MSG_GRID_NULL, "����");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setLovFixCol ���� : " + G_MSG_COL_NAME_NULL, "����");
		return;
	}
	
	try
	{
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_LOV_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "PopupFix";
	}
	catch (e)
	{
		C_msgOk("G_setLovFixCol ���� : " + e.message, "����");
		return;
	}
}

// �ش� Grid�� �˾� �÷� ����
function G_setPopupCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setPopupCol ���� : " + G_MSG_GRID_NULL, "����");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setPopupCol ���� : " + G_MSG_COL_NAME_NULL, "����");
		return;
	}
	
	try
	{
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_NORMAL_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "Popup";
	}
	catch (e)
	{
		C_msgOk("G_setPopupCol ���� : " + e.message, "����");
		return;
	}
}

// �ش� Grid�� �˾� �÷� ����(�÷������Ұ�)
function G_setPopupFixCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setPopupFixCol ���� : " + G_MSG_GRID_NULL, "����");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setPopupFixCol ���� : " + G_MSG_COL_NAME_NULL, "����");
		return;
	}
	
	try
	{
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_READONLY_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "PopupFix";
	}
	catch (e)
	{
		C_msgOk("G_setPopupFixCol ���� : " + e.message, "����");
		return;
	}
}

// �ش� Grid�� �÷� ID�� �迭�� �ѱ��.
function G_getGridCols(aGrid)
{
	if (aGrid == null)
	{
		C_msgOk("G_getGridCols ���� : " + G_MSG_GRID_NULL, "����");
		return null;
	}
	
	if (C_isNull(aGrid.Format)) return null;
	
	var lrCols = new Array();
	var lsTemp = aGrid.Format.toUpperCase().replace(/\t/g," ").replace(/\r/g," ").replace(/'/g,"").replace(/"/g,""); //'
	var lrExceptionChars = new Array("'", '"', " ");
	var lsCol = "";
	var liLastInx = 0;
	
	try
	{
		do
		{
			liLastInx = lsTemp.indexOf("ID", liLastInx);
			
			if (liLastInx == -1) break;
			
			if (lsTemp.charAt(liLastInx - 1) != ' ')
			{
				liLastInx += 2;
				continue;
			}
			
			for (var i = liLastInx + 2; i < lsTemp.length; i++)
			{
				if (lsTemp.charAt(i) == '=')
				{
					lsCol = lsTemp.substring(i + 1, lsTemp.indexOf(" ", i + 1));
					
					if (!C_isNull(lsCol))
					{
						lrCols.push(lsCol);
						liLastInx = lsTemp.indexOf(" ", i + 1);
						break;
					}
				}
				
				liLastInx = i;
			}
		}
		while (liLastInx > 0 && liLastInx < lsTemp.length);
		
		return (lrCols == null || lrCols.length < 1) ? null : lrCols;
	}
	catch (e)
	{
		C_msgOk("G_getGridCols ���� : " + e.message, "����");
		return null;
	}
}

// �ش� Grid�� �� ������ ����ϵ��� ����(aCols:�÷����� ���� �迭)
function G_setGridToggleColor(aGrid)
{
	if (aGrid == null)
	{
		C_msgOk("G_setGridToggleColor ���� : " + G_MSG_GRID_NULL, "����");
		return;
	}
	
	try
	{
		var lrCols = G_getGridCols(aGrid);
		
		if (lrCols == null || lrCols.length < 1) return;
		
		for (var i = 0; i < lrCols.length; i++)
		{
			if (aGrid.ColumnProp(lrCols[i], "BgColor") == -1)
			{
				aGrid.ColumnProp(lrCols[i], "BgColor") = "{Decode(CurRow-ToInteger(CurRow/2)*2, 0, '" + G_TOGGLE_COLOR + "', 1, '" + G_NORMAL_COLOR + "')}";
			}
		}
	}
	catch (e)
	{
		C_msgOk("G_setGridToggleColor ���� : " + e.message, "����");
		return;
	}
}

function G_findWindow(dataset, grid)
{
	try
	{
		var args = new Array();
		var ret = null;
		
		args[0] = dataset;
		args[1] = grid;
		args[2] = grid.GetColumn();
		args[3] = G_findText;
		args[4] = G_findUpper;
		
		ret = window.showModalDialog(COMM_PATH + "alertFind.jsp", args, "center:yes; dialogWidth:378px; dialogHeight:206px; status:no; help:no; scroll:no");
		
		if (ret == null || ret.length < 4) return;
		
		G_findCol = ret[1];
		G_findText = ret[2];
		G_findUpper = ret[3];
		
		G_find(dataset, G_findCol, G_findText, G_findUpper, false);
		grid.Focus();
	}
	catch (e)
	{
		C_msgOk("G_findWindow ���� : " + e.message, "����");
	}
}

function G_find(dataset, colid, text, upper, end)
{
	try
	{
		var lsFindText = upper ? G_findText : G_findText.toUpperCase();
		
		if (dataset == null)
		{
			C_msgOk("G_find ���� : " + G_MSG_DATASET_NULL, "����");
			return;
		}
		
		if (C_isNull(colid) || C_isNull(text))
		{
			C_msgOk("G_find ���� : �˻��÷� �Ǵ� �˻�� �������� �ʾҽ��ϴ�.", "����");
			return;
		}
		
		for (var i = end ? 1 : dataset.RowPosition + 1; i <= dataset.CountRow; i++)
		{
			var lsText = upper ? dataset.NameString(i, G_findCol) : dataset.NameString(i, G_findCol).toUpperCase();
			
			if (lsText.indexOf(lsFindText) > -1)
			{
				dataset.RowPosition = i;
				G_searchDataSetInfo(dataset.id).grid.Focus();
				return;
			}
		}
		
		if (C_msgYesNo("�˻��Ϸ�!<br><br>ó������ �ٽ� �˻��Ͻðڽ��ϱ�?") == "Y")
		{
			G_find(dataset, colid, text, upper, true);
		}
	}
	catch (e)
	{
		C_msgOk("G_find ���� : " + e.message, "����");
	}
}

function   G_MultiDeleteRow(aDataset)
{
	  for (i=1;i<=aDataset.CountRow;i++) {
		  if (aDataset.RowMark(i) == 1) 
		  {
			   aDataset.DeleteMarked();
		  }
	  }
}
function G_ChildRetrieveOnOff(aDataset,abBool)
{
	var datasetinfo = null;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		datasetinfo.isOffLoadChild = abBool;
	}
	catch (e)
	{
		C_msgOk("G_ChildRetrieveOnOff ���� : " + e.message, "����");
	}
}
function G_ChildRetrieveOn(aDataset)
{
	G_ChildRetrieveOnOff(aDataset,false);
}
function G_ChildRetrieveOff(aDataset)
{
	G_ChildRetrieveOnOff(aDataset,true);
}
// �ش� �����͙V�� �׸��带 �����Ѵ�.(������ ��Ÿ�Ͻ� ���)
function G_focusDataset(aDataset)
{
	var datasetinfo = null;
	
	if (aDataset == null) return;
	if (G_FocusDataset == aDataset) return;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		G_FocusDataset = datasetinfo.dataset;
		G_FocusObject = datasetinfo.grid;
		
		G_OnSetFocus(datasetinfo.dataset, datasetinfo.grid);
	}
	catch (e)
	{
	}
}
function	G_isChangedDataset(dataset)
{
	if(dataset.IsUpdated) return true;
	return G_isChanged(dataset.id);
}
function	G_assignDatasetToDictionary(dataset,dict,row)
{
	for(var i = 1 ; i <= dataset.CountColumn ; i ++)
	{
		dict.set(dataset.ColumnID(i),dataset.NameString(row,dataset.ColumnID(i)));
	}
}
function	G_assignDictionaryToDataset(dataset,dict,row)
{
	for(var i = 1 ; i <= dataset.CountColumn ; i ++)
	{
		dataset.NameString(row,dataset.ColumnID(i)) = dict.get(dataset.ColumnID(i));
	}
}
function	G_getDataHeader(dataset)
{
	var		lsDataHeader = "";
	for(var i = 1 ; i <= dataset.CountColumn ; i ++)
	{
		var		lsColName = dataset.ColumnID(i);
		var		liColType = dataset.ColumnType(i);
		var		lsColType;
		var		lsColProp;
		if(liColType == 1)
		{
			lsColType = "STRING("+dataset.ColumnSize(i)+")";
		}
		else if(liColType == 2)
		{
			lsColType = "INT";
		}
		else if(liColType == 3)
		{
			lsColType = "DECIMAL("+dataset.ColumnSize(i)+"."+dataset.ColumnDec(i)+")";
		}
		else if(liColType == 5)
		{
			lsColType = "URL";
		}
		else
		{
			lsColType = "STRING("+dataset.ColumnSize(i)+")";
		}
		var		liColProp = dataset.ColumnProp(i);

		if(liColProp == 0)
		{
			lsColProp = "NORMALTYPE";
		}
		else if(liColProp == 1)
		{
			lsColProp = "NORMALTYPE";
		}
		else if(liColType == 2)
		{
			lsColProp = "KEYVALUETYPE";
		}
		else
		{
			lsColProp = "NORMALTYPE";
		}
		if(i == 1)
		{
			lsDataHeader += lsColName+":"+lsColType+":"+lsColProp;
		}
		else
		{
			lsDataHeader += ","+lsColName+":"+lsColType+":"+lsColProp;
		}
	}
	return lsDataHeader;
}
function	G_getFloatFrom(dataset,aiRow,asCol)
{
	try
	{
		var			lfRet = parseFloat(dataset.NameString(aiRow,asCol));
		if(isNaN(lfRet)) return 0.0;
		return lfRet;
	}
	catch(e)
	{
		return 0.0;
	}
}
function	G_setFloatTo(dataset,aiRow,asCol,afValue)
{
	if(isNaN(afValue))
	{
		dataset.NameString(aiRow,asCol) = "0";
	}
	else
	{
		dataset.NameString(aiRow,asCol) = afValue;
	}
	
}
function	G_duplicateColumn(dataset, grid)
{
	var		column = grid.GetColumn();
	if(dataset.ColumnIndex(column) < 1) return;
	if(grid.ColumnProp(column, 'Edit').toUpperCase() == "NONE") return;
	if(dataset.ColumnProp(dataset.ColumnIndex(column)) == 2)	//Ű�÷��̸�
	{
		C_msgOk("�ش� �÷��� ������ų �� �����ϴ�.(���ϰ� �׸��Դϴ�.) ", "�˸�");
		return;
	}
	if(dataset.RowPosition <= 1) return;
	dataset.NameString(dataset.RowPosition,column) = dataset.NameString(dataset.RowPosition - 1,column);
	
	try
	{
		OnDuplicateColumn(dataset,grid,dataset.RowPosition,column);
	}
	catch(e)
	{
	}
}

function	btnfind_onclick()
{
	try
	{
		var			grid = C_EventObject;
		var			dataset = G_searchDataSet(grid.DataID);
		G_findWindow(dataset, grid);
	}
	catch(e)
	{
	}
}
function	btndup_onclick()
{
	try
	{
		var			grid = C_EventObject;
		var			dataset = G_searchDataSet(grid.DataID);
		if(dataset.CountRow < 1) return;
		if(dataset.RowPosition <= 1) return;
		if(!grid.Editable) return;
		G_duplicateColumn(dataset, grid);
	}
	catch(e)
	{
	}
}
function objectPatch()
{
	var os = document.getElementsByTagName("object");
	for (var idx=0; idx < os.length; idx++)
	{
		var peer = os[idx];
		var clsid = peer.getAttribute("classid");
		if (C_isNull(clsid)) continue;
		switch (clsid.toUpperCase()) {
			case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" :  // grid
					//C_msgOk(html, "Ȯ��");
					try
					{
						var html = peer.outerHTML;
						//alert(html);
						peer.outerHTML = html;
					}
					catch(e)
					{
					}
	  				break;
			case "clsid:bb4533a0-85e0-4657-9bf2-e8e7b100d47e" :  // combo
			case "clsid:71e7aca0-ef63-4055-9894-229b056e9c31" :  // grid
			case "clsid:6bf52a52-394a-11d3-b153-00c04f79faa6" :  // media player
			case "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" :  // flash
					var html = peer.outerHTML;
	  				//peer.outerHTML = html;
	  				break;
	  	default:
	  				break;
		}
	}
}

function __ws__(id)
{
	var outerHTML = id.outerHTML;
	id.outerHTML="";
	document.write(outerHTML);
}
function	__WS__(id)
{
	document.write(id.innerHTML);
}
