/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixDeprecSum.js(감가상각 집계현황)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 감가상각 집계현황 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-23)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "감가상각집계현황");
	G_addDataSet(dsLOV, null, null, "", "LOV");
	
	txtWORK_DT_FROM.value 	= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-01";
	txtWORK_DT_TO.value 		= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-"+vDATE.substr(6,2);
	txtCOMP_CODE.value		= sCompCode;
	txtCOMPANY_NAME.value	= sCompName;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var 	strCOMP_CODE	= txtCOMP_CODE.value;
		var 	strWORK_SEQ		= hiWORK_SEQ.value;
		var   strDEPREC_DIV	= cboDEPREC_DIV.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("WORK_SEQ",strWORK_SEQ)
									 + D_P2("DEPREC_DIV",strDEPREC_DIV);
									
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

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
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
