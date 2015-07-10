/**************************************************************************/
/* 1. 프 로 그 램 id : t_RFixDeprecSumByAcc.js(감가상각비 계정별 명세서)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 감가상각비 계정별 명세서 
/* 4. 변  경  이  력 : 한재원 작성(2006-02-02)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsLOV, null, null, "", "LOV");
	
	txtWORK_DT_FROM.value 	= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-01";
	txtWORK_DT_TO.value 		= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-"+vDATE.substr(6,2);
	txtCOMP_CODE.value		= sCompCode;
	txtCOMPANY_NAME.value	= sCompName;
	
	

	 
}
function OnLoadBefore(dataset)
{
	 
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
//조회시 체크
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을  선택하십시요.", "확인");
		return;
	}

	
	if (C_isNull(hiWORK_SEQ.value))
	{
		C_msgOk("작업명을 선택하세요", "확인");
		return;
	}
	return true;
}


// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
 function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
       if(!checkCondition()) return;
       var   strDEPREC_DIV	= cboDEPREC_DIV.value;
       if (strDEPREC_DIV =='S')
       {
   		var reportFile ="r_t_070007";
   	}
   	else
   	{
   		var reportFile ="r_t_070007_T";
   	}
  	
   	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	//alert(frmList.REPORT_FILE_NAME.value);
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	
	strITEM_CODE = txtITEM_CODE.value;
	if ( strITEM_CODE=="")
	{
		strITEM_CODE="%";
	}

	strTemp += "CompCode__" + txtCOMP_CODE.value + "&&";
	strTemp += "AssetClsCode__" + cboASSET_CLS_CODE.value + "&&";
	strTemp += "ItemCode__" + strITEM_CODE + "&&";
	strTemp += "WorkSeq__" + hiWORK_SEQ.value;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	//strTemp ="";
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

 

// 이벤트관련-------------------------------------------------------------------//

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
//계정코드
function txtACC_CODE_onblur()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	
	lrArgs.set("SEARCH_CONDITION", "txtACC_CODE.value");

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
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
function txtITEM_CODE_onblur()
{
	if (txtITEM_CODE.value == "")
	{
		txtITEM_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", cboASSET_CLS_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtITEM_CODE.value);

	var		lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE2",lrArgs,'T');

	if (lrRet != null)
	{
		txtITEM_CODE.value			= lrRet.get("ITEM_CODE");
		txtITEM_NAME.value			= lrRet.get("ITEM_NAME");
	}
}
function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", cboASSET_CLS_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_FIX_ITEM_CODE2", lrArgs);

	if (lrRet != null)
	{
		txtITEM_CODE.value			= lrRet.get("ITEM_CODE");
		txtITEM_NAME.value			= lrRet.get("ITEM_NAME");
	}
}