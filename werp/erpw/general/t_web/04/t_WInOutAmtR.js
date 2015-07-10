/**************************************************************************/
/* 1. 프 로 그 램 id : t_WInOutAmtR(입금표수불대장)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-25)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "입금표목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsIN_NO,null,null,sSelectPageName+D_P1("ACT","IN_NO"), "IN_NO");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	
	gridMAIN.TabToss = false;
	
	G_setLovCol(gridMAIN,"GET_PERSON");
	G_setLovCol(gridMAIN,"NAME");
	
	
	G_setLovCol(gridMAIN,"IN_DT");
	G_setLovCol(gridMAIN,"OUT_DT");

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("IN_DT_F",txtDT_F.value)
											+ D_P2("IN_DT_T",txtDT_T.value);
	}
	else if(dataset == dsIN_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","IN_NO");
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
	if(!CheckCompCode()) return;
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
	if (asCalendarID == "IN_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"IN_DT") = asDate;
	}
	else if (asCalendarID == "OUT_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"OUT_DT") = asDate;
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
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
	if(dataset == dsMAIN)
	{
		G_Load(dsIN_NO);
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"IN_NO") = dsIN_NO.NameString(dsIN_NO.RowPosition,"IN_NO");
		dataset.NameString(row,"IN_DT") = sDate;
		dataset.NameString(row,"GET_PERSON") = sEmpNo;
		dataset.NameString(row,"NAME") = sName;
		
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

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid == "IN_DT" || colid == "OUT_DT")
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "GET_PERSON" || colid == "NAME")
		{
			var		liDataRow = row;
			var			lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"GET_PERSON") = "";
				dsMAIN.NameString(liDataRow,"NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"GET_PERSON") = lrRet.get("EMPNO");
					dsMAIN.NameString(liDataRow,"NAME") = lrRet.get("NAME");
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
		if(colid == "IN_DT")
		{
			C_Calendar("IN_DT", "D", dsMAIN.NameString(dsMAIN.RowPosition,"IN_DT"));
		}
		else if(colid == "OUT_DT")
		{
			C_Calendar("OUT_DT", "D", dsMAIN.NameString(dsMAIN.RowPosition,"OUT_DT"));
		}
		else if(colid == "GET_PERSON" || colid == "NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"GET_PERSON") = lrRet.get("EMPNO");
					dsMAIN.NameString(liDataRow,"NAME") = lrRet.get("NAME");
				}
			}
		}
	}
}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsMAIN)
	{
		if(colid == "GET_PERSON" || colid == "NAME")
		{
			if(row>=2)
			{
				dsMAIN.NameString(row,"GET_PERSON") = dsMAIN.NameString(row-1,"GET_PERSON");
				dsMAIN.NameString(row,"NAME") = dsMAIN.NameString(row-1,"NAME");
			}
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}
function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMPANY_NAME.value = "전체";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	return true;
}

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	S_nextFocus(btnDT_F);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}

