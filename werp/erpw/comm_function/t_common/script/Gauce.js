// DataSet 등록 배열
var G_arrDataSets = new Array();

// DataSet의 읽기 진행 여부
var G_isLoading = false;

// Transaction의 Post 진행 여부
var G_isSaveing = false;

// Transaction의 Error 여부
var G_isError = false;

// DataSet의 SyncData 체크 여부
var G_isSyncDataCheck = false;

// DataSet의 별칭
var G_DataSetTitle = null;

// NotNull 컬럼명
var G_NotNullColName = null;

// Key 컬럼명
var G_KeyColName = null;

// 최종 포커스된 가우스 객체
var G_FocusObject = null;

// 최종 포커스된 가우스 그리드의 Dataset 객체
var G_FocusDataset = null;

// 검색
var G_findCol = "";
var G_findText = "";
var G_findUpper = false;

// 각종 메세지
var G_MSG_SAVE = "저장 하시겠습니까?";
var G_MSG_CHANGED_SAVE = "변경 사항을 저장 하시겠습니까?";
var G_MSG_SAVE_OK = "저장되었습니다.";
var G_MSG_SAVE_ERR = "저장실패";
var G_MSG_SEVICE_URL_ERR = "Service URL이 존재하지 않습니다.";
var G_MSG_DATASET_NULL = "DataSet이 널(Null) 입니다.";
var G_MSG_DATASET_NAME_NULL = "DataSet명이 널(Null) 입니다.";
var G_MSG_DATASET_REG_ERR = "DataSet이 등록되지 않았습니다.";
var G_MSG_TRANS_NULL = "Transaction이 널(Null) 입니다.";
var G_MSG_GRID_NULL = "Grid가 널(Null) 입니다.";
var G_MSG_ROW_NULL = "row(이)가 널(Null)이거나 1보다 작습니다.";
var G_MSG_COL_NAME_NULL = "컬럼명이 널(Null) 입니다.";
var G_MSG_COL_NOT_NULL = "필수항목이 입력되지 않았습니다.";

var G_MSG_COL_KEY_ERROR = "";
var G_MSG_COL_KEY_ERROR_NOT_NULL= "필수입력항목이 입력되지 않았습니다.";
var G_MSG_COL_KEY_ERROR_KEY		= "키항목이 중복되었습니다.";

// 컬럼의 색상
var G_NORMAL_COLOR = "#FFFFFF";
var G_KEY_COLOR = "#D6E6F3";
var G_NOTNULL_COLOR = "#FFFFB5";
var G_READONLY_COLOR = "#EFEFEF";
var G_LOV_COLOR = "#E7D576";
var G_TOGGLE_COLOR = "#F4F2D8";
var G_GRID_SET_FOCUS_COLOR = "#BBE0F4"; //<-- 영 구리구리(#F0F0F0:세련된 색상)
var G_GRID_KILL_FOCUS_COLOR = "#D4D0C8";

// 공통 DB 에러
var G_ORA_20009 = "ORA-20009";

/*-------------------- 초기화 --------------------*/
function G_Initialize()
{
	//objectPatch();
}

/*-------------------- DataSet 관련 --------------------*/
// DataSetInfo 객체 Class
function G_DataSetInfo(aDataset, aTrans, aGrid, aServiceURL, aDataSetTitle, aNotNullColName, aSort, aClearChild)
{
	try
	{
		// DataSet
		if (aDataset != null)
		{
			// DataSet의 DataID(Service URL)
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
		
		// 그리드의 위치
		this.grid_x = 0;
		this.grid_y = 0;
		// 그리드 내의 이벤트 발생 위치
		this.grid_event_x = 0;
		this.grid_event_Y = 0;
		
		// DataSet의 별칭
		this.dataset_title = C_isNull(aDataSetTitle) ? aDataset.id : aDataSetTitle;
		
		// NotNull 컬럼명
		this.notnull_col_name = aNotNullColName;
		
		// Sort 여부
		this.sort = C_isNull(aSort) ? true : aSort;
		
		// Master DataSetInfo(단일 DataSetInfo로 설정)
		this.masterDataSet = null;
		
		// Detail DataSetInfo(복수 DataSetInfo로 설정)
		this.detailDataSets = new Array();
		
		// Relation 컬럼 정보
		this.relCols = new Array();
		
		this.isLoaded = false;
		this.isClearChild = aClearChild == null ? false:aClearChild;
		
		this.isOffLoadChild = false;
	}
	catch (e)
	{
		C_msgOk("G_DataSetInfo 에러 : " + e.message, "에러");
	}
}

// RelColInfo 객체 Class
function G_RelColInfo(aMColName, aDColName)
{
	try
	{
		this.masterColName = aMColName;
		this.detailColName = aDColName;
	}
	catch (e)
	{
		C_msgOk("G_RelColInfo 에러 : " + e.message, "에러");
	}
}

// 등록된 DataSet을 검색
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
		C_msgOk("G_searchDataSet 에러 : " + e.message, "에러");
	}
	
	return dataset;
}

// 등록된 DataSetInfo 검색
function G_searchDataSetInfo(aDataSetName)
{
	var datasetinfo = null;
	
	try
	{
		if (C_isNull(aDataSetName))
		{
			C_msgOk("G_searchDataSetInfo 에러 : " + G_MSG_DATASET_NAME_NULL, "에러");
			return null;
		}
		
		// 등록된 DataSet을 검색
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
		C_msgOk("G_searchDataSetInfo 에러 : " + e.message, "에러");
	}
	
	return datasetinfo;
}
//해당 데이타 셑의 load 여부 검증
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
		C_msgOk("G_isChanged 에러 : " + e.message, "에러");
	}
	
	return false;
}

// 하위 DataSet의 변경여부
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
		C_msgOk("G_isChanged 에러 : " + e.message, "에러");
	}
	
	return false;
}

// 하위 DataSet의 레코드 존재 여부
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
		C_msgOk("G_isExistRow 에러 : " + e.message, "에러");
	}
	
	return false;
}

// DataSet의 Key 중복 및 입력여부
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

				// jsk4 추가 시작
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
					G_NotNullColName = "<BR><BR>* 미입력항목 : " + G_NotNullColName;
				} else {
					G_MSG_COL_KEY_ERROR = G_MSG_COL_KEY_ERROR_KEY;
					G_NotNullColName = "<BR><BR>* 키항목 : " + G_KeyColName;
				}
				// jsk4 추가 끝

				// 원 소스 주석처리
				/*
				G_NotNullColName = C_isNull(G_arrDataSets[i].notnull_col_name) ? "(필수입력:" + G_arrDataSets[i].notnull_col_name + ")" : "";
				*/

				G_isSyncDataCheck = false;
				return false;
			}
			
			G_isSyncDataCheck = false;
		}
	}
	catch (e)
	{
		C_msgOk("G_isSyncData 에러 : " + e.message, "에러");
	}
	
	return true;
}

// 상위 DataSet의 Relation Key 입력여부
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
		C_msgOk("G_isMasterKeyInserted 에러 : " + e.message, "에러");
	}
	
	return true;
}

// DataSet의 Key 컬럼 및 Not Null 컬럼 입력여부
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
			// Row의 Status가 입력,수정(1:Insert,3:Update)이 아니면 Skip
			if (dataset.RowStatus(i) != 1 && dataset.RowStatus(i) != 3) continue;
			
			for (var j = 1; j <= dataset.CountColumn; j++)
			{
				// 컬럼의 속성이 Key(2) 또는 Not Null(4)인 경우 입력여부 검증
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
		C_msgOk("G_isKeyInserted 에러 : " + e.message, "에러");
	}
	
	return true;
}

// 상위 DataSet의 Relation Key의 값을 가져와 입력
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
		C_msgOk("G_setKeyInsert 에러 : " + e.message, "에러");
	}
}

// 하위 DataSet 데이터 읽기
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
		C_msgOk("G_loadDetailDataSet 에러 : " + e.message, "에러");
	}
}

// 하위 DataSet의 레코드 클리어
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
		C_msgOk("G_isExistRow 에러 : " + e.message, "에러");
	}
}


/*-------------------- DataSet 이벤트 관련 --------------------*/
function G_OnRowInsertBefore(dataset)
{
	var ret = true;
	
	try
	{
		// 개발자 정의 함수 Call
		ret = OnRowInsertBefore(dataset);
	}
	catch (e)
	{
		if (typeof(OnRowInsertBefore) == "function")
		{
			C_msgOk("G_OnRowInsertBefore 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
			return false;
		}
	}
	
	// ret의 값이 false인 경우 입력작업이 취소된다.
	if (ret == false) return false;
	
	return true;
}

function G_OnRowInserted(dataset, row)
{
	try
	{
		// 개발자 정의 함수 Call
		OnRowInserted(dataset, row);
	}
	catch (e)
	{
		if (typeof(OnRowInserted) == "function")
		{
			C_msgOk("G_OnRowInserted 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnRowDeleteBefore(dataset)
{
	var ret = true;
	
	try
	{
		// 개발자 정의 함수 Call
		ret = OnRowDeleteBefore(dataset);
	}
	catch (e)
	{
		if (typeof(OnRowDeleteBefore) == "function")
		{
			C_msgOk("G_OnRowDeleteBefore 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
			return false;
		}
	}
	
	// ret의 값이 false인 경우 삭제작업이 취소된다.
	if (ret == false) return false;
	
	return true;
}

function G_OnRowDeleted(dataset, row)
{
	try
	{
		// 개발자 정의 함수 Call
		OnRowDeleted(dataset, row);
	}
	catch (e)
	{
		if (typeof(OnRowDeleted) == "function")
		{
			C_msgOk("G_OnRowDeleted 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnDataError(dataset, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnDataError(dataset, row, colid);
	}
	catch (e)
	{
		if (typeof(OnDataError) == "function")
		{
			C_msgOk("G_OnDataError 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
			// 개발자 정의 함수 Call
			if (!OnRowPosChangeBefore(dataset, row)) return false;
		}
		catch (e)
		{
			if (typeof(OnRowPosChangeBefore) == "function")
			{
				C_msgOk("G_CanRowPosChange 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
			}
		}
		
		if (G_isChanged(dataset.id))
		{
			var ret = C_msgYesNoCancel(G_MSG_SAVE, "저장");
			
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
		C_msgOk("G_CanRowPosChange 에러 : " + e.message, "에러");
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
			// 개발자 정의 함수 Call
			OnRowPosChanged(dataset, row);
		}
		catch (e)
		{
			if (typeof(OnRowPosChanged) == "function")
			{
				C_msgOk("G_OnRowPosChanged 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
				return;
			}
		}
		
		// 하위 테이블 데이터 읽기
		G_loadDetailDataSet(dataset.id);
		
		// 현재 포커스를 받은 그리드의 데이터셑의 정보를 상태바에 표시
		//alert("전체2");
		if (dataset == G_FocusDataset) window.status = "[전체 : " + dataset.CountRow + " 행] 현재 : " + row + " 행";
	}
	catch (e)
	{
		C_msgOk("G_OnRowPosChanged 에러 : " + e.message, "에러");
	}
}

function G_OnColumnChanged(dataset, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnColumnChanged(dataset, row, colid);
	}
	catch (e)
	{
		if (typeof(OnColumnChanged) == "function")
		{
			C_msgOk("G_OnColumnChanged 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnLoadBefore(dataset)
{
	try
	{
		// 개발자 정의 함수 Call
		OnLoadBefore(dataset);
	}
	catch (e)
	{
		if (typeof(OnLoadBefore) == "function")
		{
			C_msgOk("G_OnLoadBefore 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
	
	// Wait 프레임 표시
	//C_ShowWait(true);
	
	try
	{
		// 개발자 정의 함수 Call
		OnLoadStarted(dataset);
	}
	catch (e)
	{
		if (typeof(OnLoadStarted) == "function")
		{
			C_msgOk("G_OnLoadStarted 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
			// 하위 DataSet의 레코드 클리어
			G_clearDetailDataSet(dataset.id);
		}
	}
	catch (e)
	{
		C_msgOk("G_OnLoadCompleted Grid 컬럼의 색상설정 에러 : " + e.message, "에러");
	}
	
	// Wait 프레임 숨기기
	//C_ShowWait(false);
	
	try
	{
		G_isLoading = false;
		
		// 개발자 정의 함수 Call
		OnLoadCompleted(dataset, rowcnt);
	}
	catch (e)
	{
		if (typeof(OnLoadCompleted) == "function")
		{
			C_msgOk("G_OnLoadCompleted 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnLoadError(dataset)
{
	var datasetinfo = null;
	var msg = null;
	
	// Wait 프레임 숨기기
	//C_ShowWait(false);
	
	try
	{
		datasetinfo = G_searchDataSetInfo(dataset.id);
		
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.ReDraw = true;
		}
		
		msg = datasetinfo.dataset_title + "(" + datasetinfo.dataset_id + ")" + "의 읽기 에러\n";
		msg += "\nDataId : " + dataset.DataId;
		msg += "\n에러코드 : " + dataset.ErrorCode;
		msg += "\n에러메세지 : " + dataset.ErrorMsg;
		
		try
		{
			G_isLoading = false;
			
			// 개발자 정의 함수 Call
			OnLoadError(dataset, msg);
		}
		catch (e)
		{
			C_msgError(msg, "에러");
		}
	}
	catch (e)
	{
		C_msgOk("G_OnLoadError 이벤트 에러 : " + e.message, "에러");
	}
}

function G_OnLoadProcess(dataset, rowcnt)
{
	try
	{
		// 개발자 정의 함수 Call
		OnLoadProcess(dataset, rowcnt);
	}
	catch (e)
	{
		if (typeof(OnLoadProcess) == "function")
		{
			C_msgOk("G_OnLoadProcess 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnFilter(dataset, row)
{
	try
	{
		// 개발자 정의 함수 Call
		if (!OnFilter(dataset, row)) return false;
	}
	catch (e)
	{
		if (typeof(OnFilter) == "function")
		{
			C_msgOk("G_OnFilter 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
	
	return true;
}

function G_OnLayoutChanged(dataset, colcnt)
{
	try
	{
		// 개발자 정의 함수 Call
		OnLayoutChanged(dataset, colcnt);
	}
	catch (e)
	{
		if (typeof(OnLayoutChanged) == "function")
		{
			C_msgOk("G_OnLayoutChanged 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnRowsetChanged(dataset)
{
	try
	{
		// 개발자 정의 함수 Call
		OnRowsetChanged(dataset);
	}
	catch (e)
	{
		if (typeof(OnRowsetChanged) == "function")
		{
			C_msgOk("G_OnRowsetChanged 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}


/*-------------------- Transaction 이벤트 관련 --------------------*/
function G_OnPostBefore(dataset, trans)
{
	try
	{
		// 개발자 정의 함수 Call
		if (!OnPostBefore(dataset, trans))
		{
			return false;
		}
	}
	catch (e)
	{
		if (typeof(OnPostBefore) == "function")
		{
			C_msgOk("G_OnPostBefore 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
		
		// 개발자 정의 함수 Call
		OnSuccess(dataset, trans);
	}
	catch (e)
	{
		if (typeof(OnSuccess) == "function")
		{
			C_msgOk("G_OnSuccess 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnFail(dataset, trans)
{
	var datasetinfo = null;
	var msg = null;
	
	try
	{
		// 중복 재진입 방지
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
			//msg = datasetinfo.dataset_title + "(" + datasetinfo.dataset_id + ")" + "의 저장 에러\n";
			msg = "저장 에러!\n";
			msg += "\nAction : " + trans.Action;
			msg += "\n에러코드 : " + trans.ErrorCode;
			msg += "\n에러메세지 : " + trans.ErrorMsg;
		}
		
		try
		{
			// 개발자 정의 함수 Call
			OnFail(dataset, trans, msg);
		}
		catch (e)
		{
			var ret = trans.ErrorMsg.indexOf(G_ORA_20009) > -1 ? C_msgOk(msg, "에러") : C_msgError(msg, "에러");
		}
	}
	catch (e)
	{
		C_msgOk("G_OnFail 이벤트 에러 : " + e.message, "에러");
	}
}


/*-------------------- Grid 이벤트 관련 --------------------*/
// 그리드의 onFocus 처리 함수
function G_OnFocus()
{
	var datasetinfo = null;
	
	try
	{
		// 현재 이벤트 객체를 저장
		C_EventObject = event.srcElement;
		
		// 최종 포커스된 가우스 객체를 저장
		G_FocusObject = event.srcElement;
		
		datasetinfo = G_searchDataSetInfo(C_EventObject.DataID);
		// 그리드의 위치를 저장
		datasetinfo.grid_x = event.clientX - event.offsetX;
		datasetinfo.grid_y = event.clientY - event.offsetY;
		
		// 최종 포커스된 가우스 그리드의 Dataset 객체를 저장
		G_FocusDataset = datasetinfo.dataset;
	}
	catch (e)
	{
		C_msgOk("G_OnFocus 에러 : " + e.message, "에러");
	}
}

function G_CanColumnPosChange(dataset, grid, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		if (!CanColumnPosChange(dataset, grid, row, colid)) return false;
	}
	catch (e)
	{
		if (typeof(CanColumnPosChange) == "function")
		{
			C_msgOk("G_CanColumnPosChange 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
	
	return true;
}

function G_OnClick(dataset, grid, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnClick(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnClick) == "function")
		{
			C_msgOk("G_OnClick 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnCloseUp(dataset, grid, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnCloseUp(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnCloseUp) == "function")
		{
			C_msgOk("G_OnCloseUp 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnColIndexChanged(dataset, grid, srcIndex, destIndex)
{
	try
	{
		// 개발자 정의 함수 Call
		OnColIndexChanged(dataset, grid, srcIndex, destIndex);
	}
	catch (e)
	{
		if (typeof(OnColIndexChanged) == "function")
		{
			C_msgOk("G_OnColIndexChanged 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnColSizing(dataset, grid, Index, OrgWidth, RstWidth)
{
	try
	{
		// 개발자 정의 함수 Call
		OnColSizing(dataset, grid, Index, OrgWidth, RstWidth);
	}
	catch (e)
	{
		if (typeof(OnColSizing) == "function")
		{
			C_msgOk("G_OnColSizing 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnColumnPosChanged(dataset, grid, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		if (!OnColumnPosChanged(dataset, grid, row, colid)) return false;
	}
	catch (e)
	{
		if (typeof(OnColumnPosChanged) == "function")
		{
			C_msgOk("G_OnColumnPosChanged 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
	
	return true;
}

function G_OnCommand(dataset, grid, code, text)
{
	try
	{
		// 개발자 정의 함수 Call
		OnCommand(dataset, grid, code, text);
	}
	catch (e)
	{
		if (typeof(OnCommand) == "function")
		{
			C_msgOk("G_OnCommand 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
					C_msgOk("공통버튼(조회) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
				}
				else
				{
					C_msgOk("공통버튼(조회) 개발자 정의 함수가 존재하지 않습니다.", "에러");
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
					C_msgOk("공통버튼(추가) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
				}
				else
				{
					C_msgOk("공통버튼(추가) 개발자 정의 함수가 존재하지 않습니다.", "에러");
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
					C_msgOk("공통버튼(삽입) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
				}
				else
				{
					C_msgOk("공통버튼(삽입) 개발자 정의 함수가 존재하지 않습니다.", "에러");
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
					C_msgOk("공통버튼(삭제) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
				}
				else
				{
					C_msgOk("공통버튼(삭제) 개발자 정의 함수가 존재하지 않습니다.", "에러");
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
					C_msgOk("공통버튼(저장) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
				}
				else
				{
					C_msgOk("공통버튼(저장) 개발자 정의 함수가 존재하지 않습니다.", "에러");
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
		C_msgOk("G_OnCommand 이벤트 에러 : " + e.message, "에러");
	}
}

function G_OnDblClick(dataset, grid, row, colid)
{
	var datasetinfo = null;
	
	try
	{
		// 개발자 정의 함수 Call
		if (row > 0)
		{
			OnDblClick(dataset, grid, row, colid);
		}
	}
	catch (e)
	{
		if (typeof(OnDblClick) == "function")
		{
			C_msgOk("G_OnDblClick 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
		C_msgOk("G_OnDblClick Grid 컬럼의 Sort 에러 : " + e.message, "에러");
	}
}

function G_OnDropDown(dataset, grid, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnDropDown(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnDropDown) == "function")
		{
			C_msgOk("G_OnDropDown 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnEnter(dataset, grid, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnEnter(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnEnter) == "function")
		{
			C_msgOk("G_OnEnter 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnExit(dataset, grid, row, colid, olddata)
{
	try
	{
		// 개발자 정의 함수 Call
		OnExit(dataset, grid, row, colid, olddata);
	}
	catch (e)
	{
		if (typeof(OnExit) == "function")
		{
			C_msgOk("G_OnExit 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnFirstUp(dataset, grid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnFirstUp(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnFirstUp) == "function")
		{
			C_msgOk("G_OnFirstUp 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnKeyPress(dataset, grid, kcode)
{
	try
	{
		// 개발자 정의 함수 Call
		OnKeyPress(dataset, grid, kcode);
	}
	catch (e)
	{
		if (typeof(OnKeyPress) == "function")
		{
			C_msgOk("G_OnKeyPress 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
		C_msgOk("G_OnKeyPress 에러 : " + e.message, "에러");
		return;
	}
}

function G_OnKillFocus(dataset, grid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnKillFocus(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnKillFocus) == "function")
		{
			C_msgOk("G_OnKillFocus 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
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
		C_msgOk("G_OnKillFocus 이벤트 에러 : " + e.message, "에러");
	}
}

function G_OnLastDown(dataset, grid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnLastDown(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnLastDown) == "function")
		{
			C_msgOk("G_OnLastDown 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnLButtonDblClk(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// 개발자 정의 함수 Call
		OnLButtonDblClk(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnLButtonDblClk) == "function")
		{
			C_msgOk("G_OnLButtonDblClk 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnLButtonDown(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// 개발자 정의 함수 Call
		OnLButtonDown(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnLButtonDown) == "function")
		{
			C_msgOk("G_OnLButtonDown 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnLButtonUp(dataset, grid, row, colid, xpos, ypos)
{
	var datasetinfo = null;
	
	try
	{
		datasetinfo = G_searchDataSetInfo(dataset.id);
		// 이벤트 발생위치 저장
		datasetinfo.grid_event_x = xpos;
		datasetinfo.grid_event_y = ypos;
	}
	catch (e)
	{
		C_msgOk("G_OnLButtonUp 에러 : " + e.message, "에러");
	}
	
	try
	{
		// 개발자 정의 함수 Call
		OnLButtonUp(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnLButtonUp) == "function")
		{
			C_msgOk("G_OnLButtonUp 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnPopup(dataset, grid, row, colid, data)
{
	try
	{
		// 개발자 정의 함수 Call
		OnPopup(dataset, grid, row, colid, data);
	}
	catch (e)
	{
		if (typeof(OnPopup) == "function")
		{
			C_msgOk("G_OnPopup 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnRButtonDblClk(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// 개발자 정의 함수 Call
		OnRButtonDblClk(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnRButtonDblClk) == "function")
		{
			C_msgOk("G_OnRButtonDblClk 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnRButtonDown(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// 개발자 정의 함수 Call
		OnRButtonDown(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnRButtonDown) == "function")
		{
			C_msgOk("G_OnRButtonDown 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
	
	try
	{
		var lsBar1 = "────────^1^0001^false";
		var lsBar2 = "────────^1^0002^false";
		var lsBar3 = "────────^1^0003^false";
		
		var lsFind = dataset.CountRow > 0 ? "찾기(ALT+F)^1^1020^true" : "찾기^1^1020^false";
		var lsNextFind = C_isNull(G_findCol) || C_isNull(G_findText) || dataset.CountRow < 1 ? "다음찾기(F12)^1^1040^false" : "다음찾기(F12)^1^1040^true";
		
		var lsLoad = "조회(ALT+R)^1^3010^true";
		var lsAdd = "추가(ALT+A)^1^3020^true";
		var lsInsert = dataset.CountRow > 0 ? "삽입(ALT+I)^1^3030^true" : "삽입(ALT+I)^1^3030^false";
		var lsDelete = dataset.CountRow > 0 ? "삭제(ALT+D)^1^3040^true" : "삭제(ALT+D)^1^3040^false";
		var	lsDuplicate = dataset.CountRow > 0 && dataset.RowPosition > 1 ? "복제(ALT+C)^1^3045^true" : "복제(ALT+C)^1^3045^false";
		var lsSave = "저장(ALT+S)^1^3050^true";
		
		var lsExcel = dataset.CountRow > 0 ? "엑셀변환^1^5020^true" : "엑셀변환^1^5020^false";
		var lsExcelSheet = dataset.CountRow > 0 ? "엑셀변환(Sheet)^1^5040^true" : "엑셀변환(Sheet)^1^5040^false";
		
		var lsColHide = C_isNull(grid.GetColumn()) ? "열숨기기^1^7020^false" : "열숨기기^1^7020^true";
		var lsColShow = "열보이기^1^7040^true";
		var lsColList = "전체^2^70400^true,";
		
		// 숨겨진 열 리스트를 서브 메뉴로 구성
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
			case "U" : // 쓰기
				break;
			case "R" : // 읽기
				lsLoad = "조회(ALT+R)^1^3010^true";
				lsAdd = "추가(ALT+A)^1^3020^false";
				lsInsert = "삽입(ALT+I)^1^3030^false";
				lsDelete = "삭제(ALT+D)^1^3040^false";
				lsSave = "저장(ALT+S)^1^3050^false";
				lsDuplicate = "복제(ALT+C)^1^3045^false";
				break;
			case "S" : // 저장
				lsLoad = "조회(ALT+R)^1^3010^true";
				lsAdd = "추가(ALT+A)^1^3020^false";
				lsInsert = "삽입(ALT+I)^1^3030^false";
				lsDelete = "삭제(ALT+D)^1^3040^false";
				lsSave = "저장(ALT+S)^1^3050^true";
				break;
			case "P" : // 보고서
				lsLoad = "조회(ALT+R)^1^3010^true";
				lsAdd = "추가(ALT+A)^1^3020^false";
				lsInsert = "삽입(ALT+I)^1^3030^false";
				lsDelete = "삭제(ALT+D)^1^3040^false";
				lsSave = "저장(ALT+S)^1^3050^false";
				lsDuplicate = "복제(ALT+C)^1^3045^false";
				break;
			default :
				lsLoad = "조회(ALT+R)^1^3010^false";
				lsAdd = "추가(ALT+A)^1^3020^false";
				lsInsert = "삽입(ALT+I)^1^3030^false";
				lsDelete = "삭제(ALT+D)^1^3040^false";
				lsSave = "저장(ALT+S)^1^3050^false";
				lsDuplicate = "복제(ALT+C)^1^3045^false";
				break;
		}
		if(! grid.Editable)
		{
			lsAdd = "추가(ALT+A)^1^3020^false";
			lsInsert = "삽입(ALT+I)^1^3030^false";
			lsDelete = "삭제(ALT+D)^1^3040^false";
			lsSave = "저장(ALT+S)^1^3050^false";
			lsDuplicate = "복제(ALT+C)^1^3045^false";
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
		C_msgOk("G_OnRButtonDown 이벤트 에러 : " + e.message, "에러");
	}
}

function G_OnRButtonUp(dataset, grid, row, colid, xpos, ypos)
{
	try
	{
		// 개발자 정의 함수 Call
		OnRButtonUp(dataset, grid, row, colid, xpos, ypos);
	}
	catch (e)
	{
		if (typeof(OnRButtonUp) == "function")
		{
			C_msgOk("G_OnRButtonUp 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnReturn(dataset, grid, row, colid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnReturn(dataset, grid, row, colid);
	}
	catch (e)
	{
		if (typeof(OnReturn) == "function")
		{
			C_msgOk("G_OnReturn 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnScrolling(dataset, grid, row, column, setscrolling)
{
	try
	{
		// 개발자 정의 함수 Call
		OnScrolling(dataset, grid, row, column, setscrolling);
	}
	catch (e)
	{
		if (typeof(OnScrolling) == "function")
		{
			C_msgOk("G_OnScrolling 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function G_OnSetFocus(dataset, grid)
{
	try
	{
		// 개발자 정의 함수 Call
		OnSetFocus(dataset, grid);
	}
	catch (e)
	{
		if (typeof(OnSetFocus) == "function")
		{
			C_msgOk("G_OnSetFocus 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
	
	try
	{
		var lrCols = null;
		var lrGrps = null;
		
		// 전체 그리드 리셑
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
		
		// 현재 포커스를 받은 그리드의 데이터셑 저장
		G_FocusDataset = dataset;
		
		// 현재 포커스를 받은 그리드의 데이터셑의 정보를 상태바에 표시
		window.status = "[전체 : " + dataset.CountRow + " 행] 현재 : " + dataset.RowPosition + " 행";
	}
	catch (e)
	{
		C_msgOk("G_OnSetFocus 이벤트 에러 : " + e.message, "에러");
	}
}

function G_OnUserColor(dataset, grid, row, eventid)
{
	try
	{
		// 개발자 정의 함수 Call
		return OnUserColor(dataset, grid, row, eventid);
	}
	catch (e)
	{
		if (typeof(OnUserColor) == "function")
		{
			C_msgOk("G_OnUserColor 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}


/*-------------------- 개발자 사용가능 함수 --------------------*/
// DataSet 공통 초기화
function G_DataSetInit(dataset)
{
	if (dataset == null)
	{
		C_msgOk("DataSet 공통 초기화 에러 : " + G_MSG_DATASET_NULL, "에러");
		return false;
	}
	
	try
	{
		// !!DataSet 공통 초기화 추가!!
		dataset.SyncLoad = true;
	}
	catch (e)
	{
		C_msgOk("DataSet 공통 초기화 설정 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// Transaction 공통 초기화
function G_TransInit(trans)
{
	if (trans == null)
	{
		C_msgOk("Transaction 공통 초기화 에러 : " + G_MSG_TRANS_NULL, "에러");
		return false;
	}
	
	try
	{
		// !!Transaction 공통 초기화 추가!!
		trans.ServerIP = "";
		trans.KeyName = "toinb_dataid4";
		trans.Protocol = "1";
		//trans.StatusResetType = "0";
	}
	catch (e)
	{
		C_msgOk("Transaction 공통 초기화 설정 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// Grid 공통 초기화
function G_GridInit(grid)
{
	if (grid == null)
	{
		C_msgOk("Grid 공통 초기화 에러 : " + G_MSG_GRID_NULL, "에러");
		return false;
	}
	
	try
	{
		// !!Grid 공통 초기화 추가!!
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
		C_msgOk("Grid 공통 초기화 설정 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet 등록
function G_addDataSet(aDataset, aTrans, aGrid, aServiceURL, aDataSetTitle, aNotNullColName, aSort, aClearChild)
{
	if (aDataset == null)
	{
		C_msgOk("DataSet 등록 에러 : " + G_MSG_DATASET_NULL, "에러");
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
		C_msgOk("DataSet 등록 에러 : " + e.message, "에러");
		return false;
	}
	
	try
	{
		G_DataSetInit(aDataset);
		// DataSet 관련 이벤트
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
		C_msgOk("DataSet 초기화 에러 : " + e.message, "에러");
		return false;
	}
	
	try
	{
		if (aTrans != null)
		{
			G_TransInit(aTrans);
			
			// Transaction 관련 이벤트
			aTrans.attachEvent ("OnSuccess", new Function("G_OnSuccess(" + aDataset.id + ", " + aTrans.id + ");"));
			aTrans.attachEvent ("OnFail", new Function("G_OnFail(" + aDataset.id + ", " + aTrans.id + ");"));
		}
	}
	catch (e)
	{
		C_msgOk("Transaction 초기화 에러 : " + e.message, "에러");
		return false;
	}
	
	try
	{
		if (aGrid != null)
		{
			aGrid.DataID = aDataset.id;
			
			G_GridInit(aGrid);
			G_setGridToggleColor(aGrid);
			
			// 그리드의 onFocus 처리 함수
			aGrid.onfocus = G_OnFocus;
			
			// Grid 관련 이벤트
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
		C_msgOk("Grid 초기화 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet의 Relation 등록
function G_addRel(aMasterDataset, aDetailDataset)
{
	if (aMasterDataset == null || aDetailDataset == null)
	{
		C_msgOk("G_addRel 에러 : " + G_MSG_DATASET_NULL, "에러");
		return false;
	}
	
	try
	{
		var datasetinfoM = G_searchDataSetInfo(aMasterDataset.id);
		var datasetinfoD = G_searchDataSetInfo(aDetailDataset.id);
		
		if (datasetinfoM == null)
		{
			C_msgOk("G_addRel 에러 : " + G_MSG_DATASET_REG_ERR + "(" + aMasterDataset.id + ")", "에러");
			return false;
		}
		
		if (datasetinfoD == null)
		{
			C_msgOk("G_addRel 에러 : " + G_MSG_DATASET_REG_ERR + "(" + aDetailDataset.id + ")", "에러");
			return false;
		}
		
		if (datasetinfoM.detailDataSets == null) datasetinfoM.detailDataSets = new Array();
		
		datasetinfoM.detailDataSets.push(datasetinfoD);
		datasetinfoD.masterDataSet = datasetinfoM;
	}
	catch (e)
	{
		C_msgOk("G_addRel 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet의 Relation 등록
function G_addRelCol(aDataset, aMasterColName, aDetailColName)
{
	if (aDataset == null)
	{
		C_msgOk("G_addRelCol 에러 : " + G_MSG_DATASET_NULL, "에러");
		return false;
	}
	
	if (C_isNull(aMasterColName) || C_isNull(aDetailColName))
	{
		C_msgOk("G_addRelCol 에러 : " + G_MSG_COL_NAME_NULL, "에러");
		return false;
	}
	
	try
	{
		var datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		if (datasetinfo == null)
		{
			C_msgOk("G_addRelCol 에러 : " + G_MSG_DATASET_REG_ERR + "(" + aDataset.id + ")", "에러");
			return false;
		}
		
		if (datasetinfo.relCols == null) datasetinfo.relCols = new Array();
		
		var relColInfo = new G_RelColInfo(aMasterColName, aDetailColName);
		
		datasetinfo.relCols.push(relColInfo);
	}
	catch (e)
	{
		C_msgOk("G_addRelCol 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet의 자료읽기
function G_Load(aDataset, aDataId)
{
	if (aDataset == null)
	{
		C_msgOk("G_Load 에러 : " + G_MSG_DATASET_NULL, "에러");
		return false;
	}
	
	try
	{
		// 읽기전 변경사항 체크(현재 사용 안함)
		/*
		if (aDataset.IsUpdated || G_isChanged(aDataset.id))
		{
			var ret = C_msgYesNo(G_MSG_CHANGED_SAVE, "저장");
			
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
		C_msgOk("G_Load 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet에 한 행 추가
function G_addRow(aDataset, aValid)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_addRow 에러 : " + G_MSG_DATASET_NULL, "에러");
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
				C_msgOk("'" + G_DataSetTitle + "'의 " + G_MSG_COL_KEY_ERROR + G_NotNullColName, "에러");
				return false;
			}
			
			if (!G_isMasterKeyInserted(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'의 " + G_MSG_COL_NOT_NULL, "에러");
				return false;
			}
			
			if (G_isChanged(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'이(가) 저장되지 않았습니다.", "에러");
				return false;
			}
		}
		
		aDataset.addRow();
		G_setKeyInsert(aDataset.id);
		
		// 자동 포커스
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_addRow 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet의 특정 위치에 한 행 추가
function G_insertRow(aDataset, row, aValid)
{
	var datasetinfo = null;
	var iRow = 0;
	
	if (aDataset == null)
	{
		C_msgOk("G_insertRow 에러 : " + G_MSG_DATASET_NULL, "에러");
		return false;
	}
	
	iRow = (row == null || row == undefined) ? aDataset.RowPosition : row;
	
	if (row < 1)
	{
		C_msgOk("G_insertRow 에러 : " + G_MSG_ROW_NULL, "에러");
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
				C_msgOk("'" + G_DataSetTitle + "'의 " + G_MSG_COL_KEY_ERROR + G_NotNullColName, "에러");
				return false;
			}
			
			if (!G_isMasterKeyInserted(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'의 " + G_MSG_COL_NOT_NULL, "에러");
				return false;
			}
			
			if (G_isChanged(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'이(가) 저장되지 않았습니다.", "에러");
				return false;
			}
		}
		
		aDataset.InsertRow(iRow);
		G_setKeyInsert(aDataset.id);
		
		// 자동 포커스
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_insertRow 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet의 특정 위치에 한 행 삭제
function G_deleteRow(aDataset, row, aValid)
{
	var datasetinfo = null;
	var iRow = 0;
	
	if (aDataset == null)
	{
		C_msgOk("G_deleteRow 에러 : " + G_MSG_DATASET_NULL, "에러");
		return false;
	}
	
	iRow = (row == null || row < 1) ? aDataset.RowPosition : row;
	
	if (aDataset.CountRow > 0)
	{
		if (iRow == null || iRow < 1)
		{
			C_msgOk("G_deleteRow 에러 : " + G_MSG_ROW_NULL, "에러");
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
				C_msgOk("'" + G_DataSetTitle + "'이(가) 저장되지 않았습니다.", "에러");
				return false;
			}
			
			if (G_isExistRow(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'의 데이터가 존재합니다.", "에러");
				return false;
			}
		}
		
		aDataset.DeleteRow(iRow);
		
		// 자동 포커스
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_deleteRow 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet의 모든 행 삭제
function G_deleteAllRow(aDataset, aValid)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_deleteAllRow 에러 : " + G_MSG_DATASET_NULL, "에러");
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
				C_msgOk("'" + G_DataSetTitle + "'이(가) 저장되지 않았습니다.", "확인");
				return false;
			}
			
			if (G_isExistRow(aDataset.id))
			{
				C_msgOk("'" + G_DataSetTitle + "'의 데이터가 존재합니다.", "확인");
				return false;
			}
		}
		
		aDataset.DeleteAll();
		
		// 자동 포커스
		if (datasetinfo.grid != null)
		{
			datasetinfo.grid.Focus();
		}
	}
	catch (e)
	{
		C_msgOk("G_deleteAllRow 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}

// DataSet의 저장
function G_saveData(aDataset)
{
	var datasetinfo = null;
	var trans = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_saveData 에러 : " + G_MSG_DATASET_NULL, "에러");
		return false;
	}
	
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
		
		trans = datasetinfo.trans;
		
		if (trans == null)
		{
			C_msgOk("G_saveData 에러 : " + G_MSG_TRANS_NULL + "(" + aDataset.id + ")", "에러");
			return false;
		}
		
		if(!G_OnPostBefore(aDataset, trans)) return false;
		
		if (!G_isSyncData())
		{
			C_msgOk("'" + G_DataSetTitle + "'의 " + G_MSG_COL_KEY_ERROR + G_NotNullColName, "에러");
			return false;
		}
		
		if (!G_isKeyInserted(aDataset.id))
		{
			C_msgOk("'" + G_DataSetTitle + "'의 " + G_MSG_COL_NOT_NULL, "확인");
			return false;
		}
		
		G_isSaveing = true;
		G_isError = false;

		trans.Post();
	}
	catch (e)
	{
		G_isSaveing = false;
		C_msgOk("G_saveData 에러 : " + e.message, "에러");
		return false;
	}
	
	return !G_isError;
}

// DataSet의 저장(저장완료 메세지 출력)
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
// 해당 DataSet의 저장 및 하위의 모든 DataSet 저장(저장완료 메세지 출력)
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

// 해당 DataSet의 저장 및 하위의 모든 DataSet 저장
function G_saveAllData(aDataset)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_saveAllData 에러 : " + G_MSG_DATASET_NULL, "에러");
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
		C_msgOk("G_saveAllData 에러 : " + e.message, "에러");
		return false;
	}
	
	return true;
}


// 해당 DataSet 및 하위의 모든 DataSet의 모든 Data 및 Header 정보를 지운다
function G_clearAllData(aDataset)
{
	var datasetinfo = null;
	
	if (aDataset == null)
	{
		C_msgOk("G_clearAllData 에러 : " + G_MSG_DATASET_NULL, "에러");
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
		C_msgOk("G_clearAllData 에러 : " + e.message, "에러");
		return;
	}
}

// 해당 DataSet의 읽기/쓰기 컬럼 설정
function G_setReadWriteCol(aGrid, aColName)
{
	if (aGrid == null)
	{
		C_msgOk("G_setReadWriteCol 에러 : " + G_MSG_GRID_NULL, "에러");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setReadWriteCol 에러 : " + G_MSG_COL_NAME_NULL, "에러");
		return;
	}
	
	try
	{
		aGrid.ColumnProp(aColName, "Edit") = "";
		aGrid.ColumnProp(aColName, "BgColor") = G_NORMAL_COLOR;
	}
	catch (e)
	{
		C_msgOk("G_setReadWriteCol 에러 : " + e.message, "에러");
		return;
	}
}

// 해당 DataSet의 읽기전용 컬럼 설정
function G_setReadOnlyCol(aGrid, aColName)
{
	if (aGrid == null)
	{
		C_msgOk("G_setReadOnlyCol 에러 : " + G_MSG_GRID_NULL, "에러");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setReadOnlyCol 에러 : " + G_MSG_COL_NAME_NULL, "에러");
		return;
	}
	
	try
	{
		aGrid.ColumnProp(aColName, "Edit") = "None"; // 수정불가
		aGrid.ColumnProp(aColName, "BgColor") = G_READONLY_COLOR;
	}
	catch (e)
	{
		C_msgOk("G_setReadOnlyCol 에러 : " + e.message, "에러");
		return;
	}
}

// 해당 DataSet의 LOV 컬럼 설정
function G_setLovCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setLovCol 에러 : " + G_MSG_GRID_NULL, "에러");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setLovCol 에러 : " + G_MSG_COL_NAME_NULL, "에러");
		return;
	}
	
	try
	{
		//aGrid.ColumnProp(aColName, "Edit") = "None"; // 수정불가
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_LOV_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "Popup";
	}
	catch (e)
	{
		C_msgOk("G_setLovCol 에러 : " + e.message, "에러");
		return;
	}
}

// 해당 Grid의 LOV 컬럼 설정(컬럼편집불가)
function G_setLovFixCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setLovFixCol 에러 : " + G_MSG_GRID_NULL, "에러");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setLovFixCol 에러 : " + G_MSG_COL_NAME_NULL, "에러");
		return;
	}
	
	try
	{
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_LOV_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "PopupFix";
	}
	catch (e)
	{
		C_msgOk("G_setLovFixCol 에러 : " + e.message, "에러");
		return;
	}
}

// 해당 Grid의 팝업 컬럼 설정
function G_setPopupCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setPopupCol 에러 : " + G_MSG_GRID_NULL, "에러");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setPopupCol 에러 : " + G_MSG_COL_NAME_NULL, "에러");
		return;
	}
	
	try
	{
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_NORMAL_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "Popup";
	}
	catch (e)
	{
		C_msgOk("G_setPopupCol 에러 : " + e.message, "에러");
		return;
	}
}

// 해당 Grid의 팝업 컬럼 설정(컬럼편집불가)
function G_setPopupFixCol(aGrid, aColName, isBgColor)
{
	if (aGrid == null)
	{
		C_msgOk("G_setPopupFixCol 에러 : " + G_MSG_GRID_NULL, "에러");
		return;
	}
	
	if (C_isNull(aColName))
	{
		C_msgOk("G_setPopupFixCol 에러 : " + G_MSG_COL_NAME_NULL, "에러");
		return;
	}
	
	try
	{
		if (isBgColor == null || isBgColor) aGrid.ColumnProp(aColName, "BgColor") = G_READONLY_COLOR;
		aGrid.ColumnProp(aColName, "EditStyle") = "PopupFix";
	}
	catch (e)
	{
		C_msgOk("G_setPopupFixCol 에러 : " + e.message, "에러");
		return;
	}
}

// 해당 Grid의 컬럼 ID를 배열로 넘긴다.
function G_getGridCols(aGrid)
{
	if (aGrid == null)
	{
		C_msgOk("G_getGridCols 에러 : " + G_MSG_GRID_NULL, "에러");
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
		C_msgOk("G_getGridCols 에러 : " + e.message, "에러");
		return null;
	}
}

// 해당 Grid의 행 색상을 토글하도록 설정(aCols:컬럼명을 담은 배열)
function G_setGridToggleColor(aGrid)
{
	if (aGrid == null)
	{
		C_msgOk("G_setGridToggleColor 에러 : " + G_MSG_GRID_NULL, "에러");
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
		C_msgOk("G_setGridToggleColor 에러 : " + e.message, "에러");
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
		C_msgOk("G_findWindow 에러 : " + e.message, "에러");
	}
}

function G_find(dataset, colid, text, upper, end)
{
	try
	{
		var lsFindText = upper ? G_findText : G_findText.toUpperCase();
		
		if (dataset == null)
		{
			C_msgOk("G_find 에러 : " + G_MSG_DATASET_NULL, "에러");
			return;
		}
		
		if (C_isNull(colid) || C_isNull(text))
		{
			C_msgOk("G_find 에러 : 검색컬럼 또는 검색어가 지정되지 않았습니다.", "에러");
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
		
		if (C_msgYesNo("검색완료!<br><br>처음부터 다시 검색하시겠습니까?") == "Y")
		{
			G_find(dataset, colid, text, upper, true);
		}
	}
	catch (e)
	{
		C_msgOk("G_find 에러 : " + e.message, "에러");
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
		C_msgOk("G_ChildRetrieveOnOff 에러 : " + e.message, "에러");
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
// 해당 데이터셑과 그리드를 설정한다.(프리폼 스타일시 사용)
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
	if(dataset.ColumnProp(dataset.ColumnIndex(column)) == 2)	//키컬럼이면
	{
		C_msgOk("해당 컬럼은 복제시킬 수 없습니다.(유일값 항목입니다.) ", "알림");
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
					//C_msgOk(html, "확인");
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
