/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSudCdR.jsp(수당계정등록)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 수당계정등록
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "부문코드목록");

	G_setLovCol(gridMAIN,"ACC_CODE");
	G_setLovCol(gridMAIN,"ACC_NAME_1");
	G_setLovCol(gridMAIN,"ACC_CODE2");
	G_setLovCol(gridMAIN,"ACC_NAME_2");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_setReadOnlyCol(gridMAIN,"SUDANGCD");
	G_setReadOnlyCol(gridMAIN,"HNAME");
	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
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
	D_defaultInsert();
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

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
}

function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "ACC_CODE" || colid == "ACC_NAME_1" )
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "ACC_CODE";
			var			lsTargetName = "ACC_NAME_1";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE_MAIN", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "ACC_CODE2" || colid == "ACC_NAME_2" )
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "ACC_CODE2";
			var			lsTargetName = "ACC_NAME_2";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE_MAIN", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "ACC_CODE" || colid == "ACC_NAME_1" )
		{
			var			lsTargetCode = "ACC_CODE";
			var			lsTargetName = "ACC_NAME_1";
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE_MAIN", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
		}
		else if(colid == "ACC_CODE2" || colid == "ACC_NAME_2" )
		{
			var			lsTargetCode = "ACC_CODE2";
			var			lsTargetName = "ACC_NAME_2";
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE_MAIN", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
		}
		
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "ACC_CODE")
		{
			dataset.NameString(row,"ACC_NAME_1") = dataset.NameString(row - 1,"ACC_NAME_1");
		}
		else if(colid == "ACC_NAME_1")
		{
			dataset.NameString(row,"ACC_CODE") = dataset.NameString(row - 1,"ACC_CODE");
		}
		else if(colid == "ACC_CODE2")
		{
			dataset.NameString(row,"ACC_NAME_2") = dataset.NameString(row - 1,"ACC_NAME_2");
		}
		else if(colid == "ACC_NAME_2")
		{
			dataset.NameString(row,"ACC_CODE2") = dataset.NameString(row - 1,"ACC_CODE2");
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
