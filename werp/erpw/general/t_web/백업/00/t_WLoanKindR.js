/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLoanKindR.js(차입종류등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "차입종류목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	G_setLovCol(gridMAIN,"LOAN_ACC_CODE");
	G_setLovCol(gridMAIN,"ITR_ACC_CODE");
	G_setLovCol(gridMAIN,"PE_ITR_ACC_CODE");
	G_setLovCol(gridMAIN,"AE_ITR_ACC_CODE");
	G_setLovCol(gridMAIN,"LOAN_ACC_CODE_NAME");
	G_setLovCol(gridMAIN,"ITR_ACC_CODE_NAME");
	G_setLovCol(gridMAIN,"PE_ITR_ACC_CODE_NAME");
	G_setLovCol(gridMAIN,"AE_ITR_ACC_CODE_NAME");
	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.

	gridMAIN.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
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

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "LOAN_ACC_CODE" || colid == "LOAN_ACC_CODE_NAME" || colid == "ITR_ACC_CODE" || colid == "ITR_ACC_CODE_NAME"||
				colid == "PE_ITR_ACC_CODE" || colid == "PE_ITR_ACC_CODE_NAME" ||
				colid == "AE_ITR_ACC_CODE" || colid == "AE_ITR_ACC_CODE_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode ="";
			var			lsTargetName ="";
			if (colid == "LOAN_ACC_CODE" || colid == "LOAN_ACC_CODE_NAME")
			{
				lsTargetCode = "LOAN_ACC_CODE";
				lsTargetName = "LOAN_ACC_CODE_NAME";
			}
			else if(colid == "ITR_ACC_CODE" || colid == "ITR_ACC_CODE_NAME")
			{
				lsTargetCode = "ITR_ACC_CODE";
				lsTargetName = "ITR_ACC_CODE_NAME";
			}
			else if(colid == "PE_ITR_ACC_CODE" || colid == "PE_ITR_ACC_CODE_NAME")
			{
				lsTargetCode = "PE_ITR_ACC_CODE";
				lsTargetName = "PE_ITR_ACC_CODE_NAME";
			}
			else if(colid == "AE_ITR_ACC_CODE" || colid == "AE_ITR_ACC_CODE_NAME")
			{
				lsTargetCode = "AE_ITR_ACC_CODE";
				lsTargetName = "AE_ITR_ACC_CODE_NAME";
			}
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,lsTargetCode) = "";
				dsMAIN.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
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
		if(colid == "LOAN_ACC_CODE" || colid == "LOAN_ACC_CODE_NAME" || 
				colid == "ITR_ACC_CODE" || colid == "ITR_ACC_CODE_NAME" ||
				colid == "PE_ITR_ACC_CODE" || colid == "PE_ITR_ACC_CODE_NAME" ||
				colid == "AE_ITR_ACC_CODE" || colid == "AE_ITR_ACC_CODE_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					if(colid == "LOAN_ACC_CODE" || colid == "LOAN_ACC_CODE_NAME")
					{
						dsMAIN.NameString(liDataRow,"LOAN_ACC_CODE") = lrRet.get("ACC_CODE");
						dsMAIN.NameString(liDataRow,"LOAN_ACC_CODE_NAME") = lrRet.get("ACC_NAME");
					}
					else if(colid == "ITR_ACC_CODE" || colid == "ITR_ACC_CODE_NAME")
					{
						dsMAIN.NameString(liDataRow,"ITR_ACC_CODE") = lrRet.get("ACC_CODE");
						dsMAIN.NameString(liDataRow,"ITR_ACC_CODE_NAME") = lrRet.get("ACC_NAME");
					}
					else if(colid == "PE_ITR_ACC_CODE" || colid == "PE_ITR_ACC_CODE_NAME")
					{
						dsMAIN.NameString(liDataRow,"PE_ITR_ACC_CODE") = lrRet.get("ACC_CODE");
						dsMAIN.NameString(liDataRow,"PE_ITR_ACC_CODE_NAME") = lrRet.get("ACC_NAME");
					}
					else if(colid == "AE_ITR_ACC_CODE" || colid == "AE_ITR_ACC_CODE_NAME")
					{
						dsMAIN.NameString(liDataRow,"AE_ITR_ACC_CODE") = lrRet.get("ACC_CODE");
						dsMAIN.NameString(liDataRow,"AE_ITR_ACC_CODE_NAME") = lrRet.get("ACC_NAME");
					}
				}
			}
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(colid == "LOAN_ACC_CODE")
	{
		dataset.NameString(row,"LOAN_ACC_CODE_NAME") = dataset.NameString(row - 1,"LOAN_ACC_CODE_NAME");
	}
	else if(colid == "LOAN_ACC_CODE_NAME")
	{
		dataset.NameString(row,"LOAN_ACC_CODE") = dataset.NameString(row - 1,"LOAN_ACC_CODE");
	}
	else if(colid == "ITR_ACC_CODE")
	{
		dataset.NameString(row,"ITR_ACC_CODE_NAME") = dataset.NameString(row - 1,"ITR_ACC_CODE_NAME");
	}
	else if(colid == "ITR_ACC_CODE_NAME")
	{
		dataset.NameString(row,"ITR_ACC_CODE") = dataset.NameString(row - 1,"ITR_ACC_CODE");
	}
	else if(colid == "PE_ITR_ACC_CODE")
	{
		dataset.NameString(row,"PE_ITR_ACC_CODE_NAME") = dataset.NameString(row - 1,"PE_ITR_ACC_CODE_NAME");
	}
	else if(colid == "PE_ITR_ACC_CODE_NAME")
	{
		dataset.NameString(row,"PE_ITR_ACC_CODE") = dataset.NameString(row - 1,"PE_ITR_ACC_CODE");
	}
	else if(colid == "AE_ITR_ACC_CODE")
	{
		dataset.NameString(row,"AE_ITR_ACC_CODE_NAME") = dataset.NameString(row - 1,"AE_ITR_ACC_CODE_NAME");
	}
	else if(colid == "AE_ITR_ACC_CODE_NAME")
	{
		dataset.NameString(row,"AE_ITR_ACC_CODE") = dataset.NameString(row - 1,"AE_ITR_ACC_CODE");
	}
}
// 이벤트관련-------------------------------------------------------------------//
