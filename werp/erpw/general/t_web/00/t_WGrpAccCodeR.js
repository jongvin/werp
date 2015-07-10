/**************************************************************************/
/* 1. 프 로 그 램 id : t_WUserAuthR.jsp(사용자별권한관리)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 사용자별권한관리
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-12)
/* 5. 관련  프로그램 : 없음
/* 6. 특  기  사  항 : 없음
/**************************************************************************/
var			strFIND_EMP_NO = "";
var			strFIND_EMP_NAME = "";
var			lbEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "사용자목록");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "권한사업장");
	G_addDataSet(dsSUB02, trans, gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "비권한사업장");
	
	G_addDataSet(dsSET, transSet, null, sSelectPageName+D_P1("ACT","SET"), "기본권한설정");
	


	G_addRel(dsMAIN, dsSUB01);
	G_addRelCol(dsSUB01, "ACC_GRP_CODE", "ACC_GRP_CODE");

	G_addRel(dsMAIN, dsSUB02);
	G_addRelCol(dsSUB02, "ACC_GRP_CODE", "ACC_GRP_CODE");
	
	G_setReadOnlyCol(gridSUB01,"COMP_CODE");
	G_setReadOnlyCol(gridSUB01,"COMPANY_NAME");
	G_setReadOnlyCol(gridSUB02,"COMP_CODE");
	G_setReadOnlyCol(gridSUB02,"COMPANY_NAME");

	gridMAIN.focus();
	//G_focusDataset(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
							//+ D_P2("SEARCH_CONDITION",txtSEARCH_CONDITION.value);
	}
	else if(dataset == dsSUB01)
	{
		var	strKEY = dsMAIN.RowPosition < 1 ? "":dsMAIN.NameString(dsMAIN.RowPosition,"ACC_GRP_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("ACC_GRP_CODE",strKEY);
	}
	else if(dataset == dsSUB02)
	{
		var	strKEY = dsMAIN.RowPosition < 1 ? "":dsMAIN.NameString(dsMAIN.RowPosition,"ACC_GRP_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
							+ D_P2("ACC_GRP_CODE",strKEY);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}
	else if (dataset == dsSET)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SET");
	}
}

// 세션관련 함수----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// 함수관련---------------------------------------------------------------------//
function	CopyOneRow(arSrcDataset,arSrcRow,arDstDataset,arDstRow)
{
	for(var j = 1 ; j <= arSrcDataset.CountColumn ; ++ j)
	{
		arDstDataset.NameString(arDstRow,arSrcDataset.ColumnID(j)) = arSrcDataset.ColumnString(arSrcRow,j);
	}
	return true;
}
function	MoveSelectedRows(arSrcDataset,arDstDataset)
{
	var		lrArrayRows = new Array();
	for(var i = 1 ; i <= arSrcDataset.CountRow ; ++ i)
	{
		if(arSrcDataset.NameString(i,"CHK_CLS") == "T")
		{
			lrArrayRows.push(i);
			G_addRow(arDstDataset);
			if(!CopyOneRow(arSrcDataset,i,arDstDataset,arDstDataset.RowPosition)) return;
		}
	}
	for(var i = lrArrayRows.length - 1 ; i >= 0 ; --i)
	{
		G_deleteRow(arSrcDataset,lrArrayRows[i],false);
	}
}
function	CheckExistsEmp(arACC_GRP_CODE)
{
	var		iCount = dsMAIN.CountRow;
	for( var i = 1 ; i <= iCount ; ++i)
	{
		if(arACC_GRP_CODE == dsMAIN.NameString(i,"ACC_GRP_CODE"))
		{
			C_msgOk("이미 존재하는 사번을 선택하셨습니다.");
			return true;
		}
	}
	return false;
}
function	FindEmp()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_SEARCH_USER_GRANT", lrArgs,"F");
	if (lrRet != null)
	{
		strFIND_EMP_NO = lrRet.get("ACC_GRP_CODE");
		strFIND_EMP_NAME = lrRet.get("NAME");
		return true;
	}
	else
	{
		return false;
	}
}
function	CheckSave()
{
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNoCancel("먼저 변경된 내용을 저장하셔야 작업이 가능합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
		}
		else if(ret == "C")
		{
			return false;
		}
	}
	return true;
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultAdd();
	}
	else
	{
		C_msgOk("추가,삽입 및 삭제를 하실 수 없습니다.(권한 설정 또는 해제 버튼을 사용하여 주십시오.");
		return;
	}
}

// 삽입
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultInsert();
	}
	else
	{
		C_msgOk("추가,삽입 및 삭제를 하실 수 없습니다.(권한 설정 또는 해제 버튼을 사용하여 주십시오.");
		return;
	}
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultDelete();
	}
	else
	{
		C_msgOk("추가,삽입 및 삭제를 하실 수 없습니다.(권한 설정 또는 해제 버튼을 사용하여 주십시오.");
		return;
	}
}

// 저장
function btnsave_onclick()
{
	D_defaultSave(dsSUB01);
	gridSUB02.focus();
	D_defaultLoad();
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameString(dsMAIN.RowPosition,"USE_TAG") = "T";
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsSUB02)
	{
	}
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
	if(lbEnter) return;
	lbEnter = true;
	try
	{
		if(dataset == dsSUB01)
		{
			if(colid == 'CHK_CLS')
			{
				if(dataset.NameString(dataset.RowPosition,"FUND_INPUT_CLS") != "T")
				{
					var			lv = C_convSafeFloat(dataset.NameString(dataset.RowPosition,"ACC_LVL"));
					var			liCount = dataset.CountRow;
					var			lsTag = dataset.NameString(row,"CHK_CLS");
					for(var i = row+1;i<=liCount;++i)
					{
						var		lvTemp = C_convSafeFloat(dataset.NameString(i,"ACC_LVL"));
						if(lvTemp <= lv) break;
						dataset.NameString(i,"CHK_CLS") = lsTag;
					}
				}
			}
		}
		else if(dataset == dsSUB02)
		{
			if(colid == 'CHK_CLS')
			{
				if(dataset.NameString(dataset.RowPosition,"FUND_INPUT_CLS") != "T")
				{
					var			lv = C_convSafeFloat(dataset.NameString(dataset.RowPosition,"ACC_LVL"));
					var			liCount = dataset.CountRow;
					var			lsTag = dataset.NameString(row,"CHK_CLS");
					for(var i = row+1;i<=liCount;++i)
					{
						var		lvTemp = C_convSafeFloat(dataset.NameString(i,"ACC_LVL"));
						if(lvTemp <= lv) break;
						dataset.NameString(i,"CHK_CLS") = lsTag;
					}
				}
			}
		}
		else
		{
		}
	}
	catch(e)
	{
	}
	lbEnter = false;
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//
function	btnGrantCompCode_onClick()
{
	MoveSelectedRows(dsSUB02,dsSUB01);
	gridSUB02.focus();
	if(dsSUB02.RowPosition > 0 && dsSUB02.RowMark(dsSUB02.RowPosition) != 1)
	{
		dsSUB02.RowMark(dsSUB02.RowPosition) = 1;
	}
}
function	btnRevokeCompCode_onClick()
{
	MoveSelectedRows(dsSUB01,dsSUB02);
	gridSUB01.focus();
	if(dsSUB01.RowPosition > 0 && dsSUB01.RowMark(dsSUB01.RowPosition) != 1)
	{
		dsSUB01.RowMark(dsSUB01.RowPosition) = 1;
	}
}

function	btnAllCheck1_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB01.CountRow;i++){
		if(dsSUB01.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB01.NameString(i,"CHK_CLS") = "T";
		}
	}
}

function	btnAllUnCheck1_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB01.CountRow;i++){
		if(dsSUB01.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB01.NameString(i,"CHK_CLS") = "F";
		}
	}
}

function	btnAllCheck2_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB02.CountRow;i++){
		if(dsSUB02.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB02.NameString(i,"CHK_CLS") = "T";
		}
	}
}

function	btnAllUnCheck2_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB02.CountRow;i++){
		if(dsSUB02.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB02.NameString(i,"CHK_CLS") = "F";
		}
	}
}


