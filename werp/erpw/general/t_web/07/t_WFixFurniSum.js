/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixFurniSum.js(부서별 상각액)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 부서별 상각액
/* 4. 변  경  이  력 : 한재원 작성(2006-01-23)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "감가상각집계현황");
	G_addDataSet(dsMAIN2, null, gridMAIN2, sSelectPageName+D_P1("ACT","MAIN2"), "부서별상각액");
	G_addDataSet(dsLOV, null, null, "", "LOV");
	
	G_addRel(dsMAIN, dsMAIN2);
	G_addRelCol(dsMAIN2, "WORK_SEQ", "WORK_SEQ");
	G_addRelCol(dsMAIN2, "FIX_ASSET_SEQ", "FIX_ASSET_SET");
	
	txtWORK_DT_FROM.value 	= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-"+vDATE.substr(6,2);
	txtWORK_DT_TO.value 		= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-"+vDATE.substr(6,2);
	txtCOMP_CODE.value		= sCompCode;
	txtCOMPANY_NAME.value	= sCompName;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var 	strCOMP_CODE		= txtCOMP_CODE.value;
		var 	strWORK_SEQ			= hiWORK_SEQ.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("WORK_SEQ",strWORK_SEQ);
									
	}
	else if(dataset == dsMAIN2)
	{
		
		var 	strWORK_SEQ			= hiWORK_SEQ.value;
		var 	strFIX_ASSET_SEQ		= dsMAIN.NameValue(dsMAIN.RowPosition, "FIX_ASSET_SEQ");
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN2")
									 + D_P2("WORK_SEQ", strWORK_SEQ.value)
									 + D_P2("FIX_ASSET_SEQ",strFIX_ASSET_SEQ)
									 + D_P2("DEPT_CODE",txtDEPT_CODE.value)
									 + D_P2("SUM_DT_FROM",txtSUM_DT_FROM.value)
									 + D_P2("SUM_DT_T0",txtSUM_DT_T0.value);
									 
									
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
function setDate_onFocus(div)
{
	if (div=="1")
	{
		olddata1 = txtWORK_DT_FROM.value;
	}
	else
	{
		olddata2 = txtWORK_DT_TO.value;	
	}
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if (txtCOMP_CODE.value == "")
	{
		C_msgOk("사업장을 입력 하십시오.", "확인");
		return;
	}
	if (hiWORK_SEQ.value == "" || txtWORK_NAME.value == "" )
	{
		C_msgOk("작업내역을 입력 하십시오.", "확인");
		return;
	}
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "WORK_DT_FROM")
	{
		txtWORK_DT_FROM.value = asDate;
		if ( !C_isNull(txtWORK_DT_FROM.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				txtWORK_DT_FROM.value = olddata1;
				return;
			}
		}	
	}
	else if (asCalendarID == "WORK_DT_TO")
	{
		txtWORK_DT_TO.value = asDate;
		if ( !C_isNull(txtWORK_DT_TO.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				txtWORK_DT_TO.value = olddata2;
				return;
			}
		}	
	}
	else if (asCalendarID == "SUM_DT_FROM")
	{
		txtSUM_DT_FROM.value = asDate;
		if ( !C_isNull(txtSUM_DT_FROM.value))
		{
			strSumDtFrom = txtSUM_DT_FROM.value.replace(/-/gi,"");
			strSumDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				txtSUM_DT_FROM.value = olddata3;
				return;
			}
		}	
	}
	else if (asCalendarID == "SUM_DT_TO")
	{
		txtSUM_DT_TO.value = asDate;
		if ( !C_isNull(txtSUM_DT_TO.value))
		{
			strSUMDtFrom = txtSUM_DT_FROM.value.replace(/-/gi,"");
			strSUMDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				txtSUM_DT_TO.value = olddata4;
				return;
			}
		}	
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
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
function txtDEPT_CODE_onblur()
{
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function txtWORK_DT_FROM_onBlur()
{
		
	if ( !C_isNull(txtWORK_DT_FROM.value))
	{
		strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
		strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtWORK_DT_FROM.value = olddata1;
			return;
		}
	}	
}
function btnWORK_DT_FROM_onClick()
{
	olddata1 = txtWORK_DT_FROM.value;
	C_Calendar("WORK_DT_FROM", "D", txtWORK_DT_FROM.value);
}
function txtWORK_DT_TO_onBlur()
{	
	
	if ( !C_isNull(txtWORK_DT_TO.value))
	{
		strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
		strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtWORK_DT_TO.value = olddata2;
			return;
		}
	}		
}
function btnWORK_DT_TO_onClick()
{
	olddata2 = txtWORK_DT_TO.value; 
	C_Calendar("WORK_DT_TO", "D", txtWORK_DT_TO.value);
}

function btnIWORK_onClick()
{
	if (txtWORK_DT_FROM.value == "" || txtWORK_DT_TO.value == "" )
	{
		C_msgOk("작업일자를 입력 하십시오.", "확인");
		return;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("WORK_DT_FROM", txtWORK_DT_FROM.value);
	lrArgs.set("WORK_DT_TO", txtWORK_DT_TO.value);

	lrRet = C_LOV("T_FIX_DEPREC_CAL", lrArgs);

	if (lrRet != null)
	{
		hiWORK_SEQ.value			= lrRet.get("WORK_SEQ");
		txtWORK_NAME.value		= lrRet.get("WORK_NAME");
	}
}

function txtSUM_DT_FROM_onBlur()
{
		
	if ( !C_isNull(txtSUM_DT_FROM.value))
	{
		strSumDtFrom = txtSUM_DT_FROM.value.replace(/-/gi,"");
		strSumDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtSUM_DT_FROM.value = olddata3;
			return;
		}
	}	
}
function btnSUM_DT_FROM_onClick()
{
	olddata3 = txtSUM_DT_FROM.value;
	C_Calendar("SUM_DT_FROM", "D", txtSUM_DT_FROM.value);
}
function txtSUM_DT_TO_onBlur()
{	
	
	if ( !C_isNull(txtSUM_DT_TO.value))
	{
		strSumDtFrom = txtSUM_DT_FROM.value.replace(/-/gi,"");
		strSumDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtSUM_DT_TO = olddata4;
			return;
		}
	}		
}
function btnSUM_DT_TO_onClick()
{
	olddata4 = txtSUM_DT_TO.value; 
	C_Calendar("SUM_DT_TO", "D", txtSUM_DT_TO.value);
}
