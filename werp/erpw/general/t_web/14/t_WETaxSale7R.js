/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxSale3R(매출발행)
/* 2. 유형(시나리오) : 사업장의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2005-11-11)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
var p;
var ph;
var peer;
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, null, "세금계산서");
	G_addDataSet(dsLOV, null, null, null, "LOV");

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DOC_COM_ID",sComid)
											+ D_P2("GEN_TM_S",txtDT_F.value.replace(/-/g,''))
											+ D_P2("GEN_TM_E",txtDT_T.value.replace(/-/g,''))
											+ D_P2("SUP_REGNUM",C_Trim(txtSUP_REGNUM.value))
											+ D_P2("DOC_NUMBER",C_Trim(txtDOC_NUMBER.value))
											+ D_P2("BUY_REGNUM",C_Trim(txtBUY_REGNUM.value));
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
	G_Load(dsMAIN);
}

// 추가
function btnadd_onclick()
{

}

// 삽입
function btninsert_onclick()
{

}

// 삭제
function btndelete_onclick()
{

}

// 저장
function btnsave_onclick()
{

}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
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
function OnDblClick(dataset, grid, row, colid)
{

}

// 이벤트관련-------------------------------------------------------------------//
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
}

//공급자사업번호찾기
function	btnSUP_REGNUM_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "SUP");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "SUP");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", "");

	lrRet = C_LOV("TB_WT_PLANT_COMPANY", lrArgs,"F");
	
	if (lrRet == null) return;

	txtSUP_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
	txtSUP_COMPANY.value	= lrRet.get("COMPANY");
	
}
function	btnSUP_REGNUM_onblur()
{
	var	lsNewData = txtSUP_REGNUM.value;
	if(C_isNull(lsNewData))
	{
		txtSUP_REGNUM.value	  = "";
		txtSUP_COMPANY.value	= "";
		return;
	}			
				
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "SUP");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "SUP");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", sComid);
	lrArgs.set("SET_CONDITION2", txtSUP_REGNUM.value);

	lrRet = C_AutoLov(dsLOV,"TB_WT_PLANT_COMPANY", lrArgs,"T");
	
	if (lrRet == null)
	{
		txtSUP_REGNUM.value	  = "";
		txtSUP_COMPANY.value	= "";
	}				
	else
	{
		txtSUP_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
		txtSUP_COMPANY.value	= lrRet.get("COMPANY");
	}

}
//공급받는자사업번호찾기
function	btnBUY_REGNUM_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "BUY");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "BUY");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", "");

	lrRet = C_LOV("TB_WT_PLANT_COMPANY", lrArgs,"F");
	
	if (lrRet == null) return;

	txtBUY_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
	txtBUY_COMPANY.value	= lrRet.get("COMPANY");

}
function	btnBUY_REGNUM_onblur()
{
	var	lsNewData = txtBUY_REGNUM.value;
	if(C_isNull(lsNewData))
	{
		txtBUY_REGNUM.value	  = "";
		txtBUY_COMPANY.value	= "";
		return;
	}			
				
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "BUY");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "BUY");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", txtBUY_REGNUM.value);

	lrRet = C_AutoLov(dsLOV,"TB_WT_PLANT_COMPANY", lrArgs,"T");
	
	if (lrRet == null)
	{
		txtBUY_REGNUM.value	  = "";
		txtBUY_COMPANY.value	= "";
	}				
	else
	{
		txtBUY_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
		txtBUY_COMPANY.value	= lrRet.get("COMPANY");
	}

}
//문서번호찾기
function	btnDOCU_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	del_status = null;
	
	lrArgs.set("DOC_COM_ID", sComid);
	lrArgs.set("GEN_TM", sDate.substr(0,6));
	lrArgs.set("STATUS", "INS");
	lrArgs.set("BUY_COMPANY", "");

	lrRet = C_LOV("TB_WT_SALE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtDOC_NUMBER.value	= lrRet.get("DOC_NUMBER");
	
}
//출력
function	btnPRINT_onclick()
{
	if(dsMAIN.CountRow == 0) return;	
	
	// 프로그래머 유효성검사 추가
	// 보고서 디렉토리
  var reportFile = "r_t_140002.rpt";
   	
	frmList.EXPORT_TAG.value = 'W';//cboExportTag.value;
	frmList.RUN_TAG.value = '1';//cboRunTag.value;
	frmList.REQUEST_NAME.value = '전자세금계산서리스트';//txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile ;
	
	var strTemp = "";
	var strgen_tm_s 	= txtDT_F.value.replace(/-/g,'') ;
	var strgen_tm_e 	= txtDT_T.value.replace(/-/g,'') ;
	var strsup_regnum = C_Trim(txtSUP_REGNUM.value) ;
	var strbuy_regnum = C_Trim(txtBUY_REGNUM.value) ;
	var strdoc_number = C_Trim(txtDOC_NUMBER.value) ;	
	var strdoc_com_id = sComid ;
	if ( C_isNull(strsup_regnum.value) ) strsup_regnum = '%';
	if ( C_isNull(strbuy_regnum.value) ) strbuy_regnum = '%';
	if ( C_isNull(strdoc_number.value) ) strdoc_number = '%';
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	strTemp += "P_GEN_TM_S__" + strgen_tm_s ;
	strTemp += "&&P_GEN_TM_E__" + strgen_tm_e ;
	strTemp += "&&P_SUP_REGNUM__" + strsup_regnum ;
	strTemp += "&&P_BUY_REGNUM__" + strbuy_regnum ;
	strTemp += "&&P_DOC_NUMBER__" + strdoc_number ;
	strTemp += "&&P_DOC_COM_ID__" + strdoc_com_id;

	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
