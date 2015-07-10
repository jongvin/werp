/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixDeprecAccCodeR.js(고정자산상각비계정등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산상각비계정등록 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "상각비계정");
	
	G_addDataSet(dsFIX_ASSET_CLS_CODE, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_CLS_CODE"), "고정자산종류코드");
	G_addDataSet(dsCOST_DEPT_KND_TAG, null, null, sSelectPageName+D_P1("ACT","COST_DEPT_KND_TAG"), "원가현장구분");
	G_addDataSet(dsLOV, null, null, null, "LOV"); 

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	
	gridMAIN.focus();
	G_setReadOnlyCol(gridMAIN, "ASSET_CLS_NAME");
	G_setReadOnlyCol(gridMAIN, "ACC_NAME");
	G_Load(dsFIX_ASSET_CLS_CODE, null);
	G_Load(dsCOST_DEPT_KND_TAG, null);
	D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("ASSET_CLS_CODE", dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE"))
									 + D_P2("COST_DEPT_KND_TAG", dsCOST_DEPT_KND_TAG.NameValue(dsCOST_DEPT_KND_TAG.RowPosition, "COST_DEPT_KND_TAG"));
	}
	else if(dataset == dsFIX_ASSET_CLS_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FIX_ASSET_CLS_CODE");
	}
	else if(dataset == dsCOST_DEPT_KND_TAG)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COST_DEPT_KND_TAG");
									
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

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	D_defaultAdd();
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	D_defaultSave(dsMAIN);
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
	if (dataset == dsMAIN)
	{
		dataset.NameValue(row, "ASSET_CLS_NAME") = dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_NAME"); 
		dataset.NameValue(row, "ASSET_CLS_CODE") = dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE");
		dataset.NameValue(row, "COST_DEPT_KND_TAG") = dsCOST_DEPT_KND_TAG.NameValue(dsCOST_DEPT_KND_TAG.RowPosition, "COST_DEPT_KND_TAG");
		dataset.NameValue(row, "COST_DEPT_KND_NAME") = dsCOST_DEPT_KND_TAG.NameValue(dsCOST_DEPT_KND_TAG.RowPosition, "COST_DEPT_KND_NAME");
		 	
	}
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
	
}

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsMAIN)
	{
		oldData = dataset.NameValue(row, "ACC_CODE");	
	}
	
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if ( colid == "ACC_CODE")
		{
			var	lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;

			if ( C_isNull(dataset.NameValue(row, "ACC_CODE")))
			{
				dataset.NameValue(row, "ACC_NAME") = "";
			}
			else
			{
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				
				
				lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "ACC_CODE"));
				lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
				
				if (lrRet == null) 
				{
					dataset.NameValue(row, "ACC_CODE") = oldData;
					
					return;
				}
				
				dataset.NameValue(row, "ACC_CODE")	= lrRet.get("ACC_CODE");
				dataset.NameValue(row, "ACC_NAME")	= lrRet.get("ACC_NAME");
			}	
		}		
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		//고정자산상각비계정
		if ( colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "ACC_NAME")	= lrRet.get("ACC_NAME");
	 
		}
	}
}

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsFIX_ASSET_CLS_CODE)
	{
		D_defaultLoad();	
	}
}

// 이벤트관련-------------------------------------------------------------------//
