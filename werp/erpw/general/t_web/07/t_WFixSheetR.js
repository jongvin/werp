/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixSheetR.js(고정자산대장등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산대장등록 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "고정자산대장");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "자산종류");
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "상각완료구분");

	G_addDataSet(dsFIX_ASSET_SEQ, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_SEQ"), "자산취득순번");
	G_addDataSet(dsFIX_ASSET_NO, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_NO"), "자산순번");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_NO"), "LOV");
	
	G_addDataSet(dsFIX_SHEET_COPY,transFixSheetCopy,null,null,"자산복사");
	
	G_addDataSet(dsREMOVE, transREMOVE, null, sSelectPageName+D_P1("ACT","REMOVE"), "전표삭제");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	Value_Readonly(true);
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH");
	G_setReadOnlyCol(gridMAIN,"GET_DT"); 
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	gridMAIN.focus();
	G_Load(dsASSETCLS, null);
	G_Load(dsDEPREC_FINISH, null);
	G_Load(dsFIX_SHEET_COPY, null);
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE"))
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value)
									 + D_P2("DEPREC_FINISH",dsDEPREC_FINISH.NameString(dsDEPREC_FINISH.RowPosition,"CODE_LIST_ID"));
	}
	else if(dataset == dsASSETCLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ASSET_CLS_CODE");
										
	}
	else if(dataset == dsDEPREC_FINISH)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH");
										
	}
	else	if (dataset == dsFIX_ASSET_SEQ)	//자산취득순번  가져오기
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FIX_ASSET_SEQ");
	}
	else	if (dataset == dsFIX_ASSET_NO)	//자산순번  가져오기
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FIX_ASSET_NO")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE"))
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value);
									
	}
	else if(dataset == dsFIX_SHEET_COPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","FIX_SHEET_COPY");
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE");
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
function	Value_Readonly(abTag)
{
	document.all.txtGET_DT.readOnly			= abTag;
	document.all.txtASSET_NAME.readOnly		= abTag;
	document.all.txtASSET_SIZE.readOnly		= abTag;
	document.all.txtPRODUCTION.readOnly		= abTag;
	document.all.txtCUST_CODE.readOnly		= abTag;
	document.all.txtEST_CUST_CODE.readOnly	= abTag;
	document.all.txtUSAGE.readOnly			= abTag;
	document.all.txtSRVLIFE.readOnly			= abTag;
	document.all.txtASSET_CNT.readOnly		= abTag;
	document.all.txtESTIMATE_AMT1.readOnly	= abTag;
	document.all.txtESTIMATE_AMT2.readOnly	= abTag;
	document.all.txtFOREIGN_AMT.readOnly		= abTag;
	document.all.txtOLD_DEPREC_AMT.readOnly	= abTag;
	document.all.txtGET_COST_AMT.readOnly	= abTag;
	document.all.txtINC_SUM_AMT.readOnly	= abTag;
	document.all.txtSUB_SUM_AMT.readOnly	= abTag;
	document.all.txtDISPOSE_YEAR.readOnly	= abTag;
	document.all.txtMNG_DEPT_CODE.readOnly	= abTag;
	document.all.txtDEPT_CODE.readOnly		= abTag;
	document.all.txtSALE_DT.readOnly			= abTag;
	document.all.txtREMARK.readOnly			= abTag;
	
	
	//document.all.chkFIXED_CLS.readOnly		= abTag;
	document.all.chkFIXTURES_CLS.readOnly	= abTag;
	document.all.chkETC_ASSET_TAG.readOnly	= abTag;
	
	document.all.btnMNG_DEPT_CODE.disabled	= abTag;
	document.all.btnDEPT_CODE.disabled		= abTag;
	document.all.btnCUST_CODE.disabled		= abTag;
	document.all.btnEST_CUST_CODE.disabled	= abTag;
	


}
function chkInputItem()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을  선택하십시요.", "확인");
		return false;
	}
	
	if(C_isNull(txtGET_DT.value))
	{
		C_msgOk("취득일자를 입력하십시오.");
		return false;
	}
	if(C_isNull(txtASSET_NAME.value))
	{
		C_msgOk("자산명칭을 입력하십시오.");
		return false;
	}
	if(C_isNull(txtASSET_CNT.value))
	{
		C_msgOk("수량을 입력하십시오.");
		return false;
	}
	if(C_isNull(txtGET_COST_AMT.value))
	{
		C_msgOk("취득원가를 입력하십시오.");
		return false;
	}
	if(C_isNull(txtSRVLIFE.value))
	{
		C_msgOk("내용년수를 입력하십시오.");
		return false;
	}
	if(cbo_DEPREC_CLS.value == "")
	{
		C_msgOk("상각구분을 선택하십시오.");
		return;
	}
	else if(cbo_DEPREC_CLS.value != "3")
	{
		if(cbo_DEPREC_FINISH.value == "")
		{
			C_msgOk("완료구분을 선택하십시오.");
			return false;
		}
	}
	
	return true;	
}

function chkFIXED_CLS_onClick()
{
	if(chkFIXED_CLS.checked)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXED_CLS") 	= "T";
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXTURES_CLS") 	= "F";
	}
	else
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXED_CLS") 	= "F";
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXTURES_CLS") 	= "T";
	}
}

function chkFIXTURES_CLS_onClick()
{
	if(chkFIXED_CLS.checked)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXED_CLS") 	= "F";
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXTURES_CLS") 	= "T";
	}
	else
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXED_CLS") 	= "T";
		dsMAIN.NameString(dsMAIN.RowPosition,"FIXTURES_CLS") 	= "F";
	}
}
//조회시 체크
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을  선택하세요.", "확인");
		return;
	}
	
	return true;
}
function	chkSave()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("변경사항을 저장한 후 작업이 가능합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
			return true;
		}
		else
		{
			return false;
		}
	}
	return true;
}
function	makeInSlip()
{
	//if(!chkCondition()) return;
	
	//if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 전표를 발행할 행을 선택하십시오.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("이미 전표가 발행되어 있습니다.");
		return;
	}
	if( dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") !="1")
	{
		C_msgOk("상각완료 구분이 상각인 경우만 <br> 전표를 발행할 수 있습니다.");
		return;
	}
	
	
	var			lrObject = new Object();
	lrObject.fix_asset_seq = dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_SEQ");
     	lrObject.div = "D";   
	var	arrRtn2 = window.showModalDialog("./t_PSlipFixSheetR.jsp" , lrObject, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	removeSlip()
{
	if(!checkCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 상단의 작업 목록을 선택 하십시오.");
		return;
	}
	
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");

	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	
	G_Load(dsREMOVE);
	dsREMOVE.NameString(dsREMOVE.RowPosition,"FIX_ASSET_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_SEQ");
	transREMOVE.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("취득전표가 정상적으로 삭제되었습니다.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	dsMAIN.RowPosition = liRow;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!checkCondition()) return;
	Value_Readonly(false);
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	
	//if (txtITEM_NM_CODE.value == "")
	//{
		//C_msgOk("품명구분을 선택하세요.", "확인");
		//return;
	//}
	var curRow = dsMAIN.RowPosition;
	D_defaultAdd();
	if(curRow != dsMAIN.RowPosition) {
		txtSRVLIFE.value = txtSRVLIFE_H.value;
		cbo_DEPREC_CLS.value = txtDEPREC_CLS_H.value;
	}
}

// 삽입
function btninsert_onclick()
{
	var curRow = dsMAIN.RowPosition;
	btnadd_onclick();
	if(curRow != dsMAIN.RowPosition) {
		txtSRVLIFE.value = txtSRVLIFE_H.value;
		cbo_DEPREC_CLS.value = txtDEPREC_CLS_H.value;
	}
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{	
	
	//if(!chkInputItem()) return;
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
	if (txtITEM_CODE.value == "")
	{
		C_msgOk("품목구분을 선택하세요.", "확인");
		return false;
	}
	if (txtITEM_NM_CODE.value == "")
	{
		C_msgOk("품명구분을 선택하세요.", "확인");
		return false;
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	
	G_Load(dsFIX_ASSET_SEQ, null);
	G_Load(dsFIX_ASSET_NO, null);

	var		strFIX_ASSET_SEQ = dsFIX_ASSET_SEQ.NameString(dsFIX_ASSET_SEQ.RowPosition,"FIX_ASSET_SEQ");
	var		strFIX_ASSET_NO = dsFIX_ASSET_NO.NameString(dsFIX_ASSET_NO.RowPosition,"FIX_ASSET_NO");
	var		strCOMP_CODE 	= txtCOMP_CODE.value;
	var		strASSET_CLS_CODE = dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE");
	dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_SEQ") 	= strFIX_ASSET_SEQ;
	dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_NO") 		= strFIX_ASSET_NO;
	dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") 		= strCOMP_CODE;
	dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_CODE") 		= txtITEM_CODE.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_NM_CODE") 	= txtITEM_NM_CODE.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"ASSET_CLS_CODE") 	= strASSET_CLS_CODE;
	dsMAIN.NameString(dsMAIN.RowPosition,"FIXED_CLS") 	= "1";
	dsMAIN.NameString(dsMAIN.RowPosition,"FIXTURES_CLS") 	= "F";
	dsMAIN.NameString(dsMAIN.RowPosition,"ETC_ASSET_TAG") 	= "F"; 
	dsMAIN.NameString(dsMAIN.RowPosition,"GET_DT") = vDate;
	dsMAIN.NameString(dsMAIN.RowPosition,"GET_CLS") = 1;
	dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_CLS") = 1;
	dsMAIN.NameString(dsMAIN.RowPosition,"NEW_OLD_ASSET") = 1;
	dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") = 1;
	dsMAIN.NameString(dsMAIN.RowPosition,"INCNTRY_OUTCNTRY_CLS") = 1;
	
	dsMAIN.NameString(dsMAIN.RowPosition,"ASSET_CNT") = 1;
	
	dsMAIN.NameString(dsMAIN.RowPosition,"BASE_AMT") = 0;
	dsMAIN.NameString(dsMAIN.RowPosition,"OLD_DEPREC_AMT") = 0;
	dsMAIN.NameString(dsMAIN.RowPosition,"GET_COST_AMT") = 0;
	dsMAIN.NameString(dsMAIN.RowPosition,"INC_SUM_AMT") = 0;
	dsMAIN.NameString(dsMAIN.RowPosition,"SUB_SUM_AMT") = 0;

	var strzero ="";

	for(j=0;j<4-strFIX_ASSET_NO.length;j++) strzero+="0";

	var strFIX_ASSET_NO2 = strzero+strFIX_ASSET_NO;

	dsMAIN.NameString(dsMAIN.RowPosition,"ASSET_MNG_NO") = strASSET_CLS_CODE + txtITEM_CODE.value + txtITEM_NM_CODE.value + strFIX_ASSET_NO2;

	gridMAIN.focus();
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

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//품목코드
function txtITEM_CODE_onblur()
{
	if (C_isNull(txtITEM_CODE.value))
	{
		txtITEM_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", txtITEM_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}

function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}
//품명코드
function txtITEM_NM_CODE_onblur()
{
	if (!C_isNull(txtITEM_NM_CODE.value))
	{
		if (C_isNull(txtITEM_CODE.value))
		{
			C_msgOk("품목구분을 먼저 선택하세요.");
			return;
		}
	}
	
	if (C_isNull(txtITEM_NM_CODE.value))
	{
		txtITEM_NM_NAME.value = "";
		txtSRVLIFE_H.value = "";
		txtDEPREC_CLS_H.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
	txtSRVLIFE_H.value		= lrRet.get("SRVLIFE");
	txtDEPREC_CLS_H.value		= lrRet.get("DEPREC_CLS");
}

function btnITEM_NM_CODE_onClick()
{
	if (txtITEM_CODE.value == "")
	{
		C_msgOk("품목구분을 먼저 선택하세요.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
	txtSRVLIFE_H.value		= lrRet.get("SRVLIFE");
	txtDEPREC_CLS_H.value	= lrRet.get("DEPREC_CLS");
}//권한없는 부서현장(전사업장)

//구매부서
function txtMNG_DEPT_CODE_onblur()
{
	if (txtMNG_DEPT_CODE.value == "")
	{
		txtMNG_DEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtMNG_DEPT_CODE.value);
	
	//부서/현장 전사업장
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnMNG_DEPT_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
//배치현장
function txtDEPT_CODE_onblur()
{
	if (txtDEPT_CODE.value == "")
	{
		txtDEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	
	//부서/현장 전사업장
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
//거래처검색
function txtCUST_CODE_onblur()
{
	if (txtCUST_CODE.value == "")
	{
		txtCUST_NAME.value 	= "";
		hiCUST_SEQ.value		= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);
	

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}
function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}

//견적거래처검색
function txtEST_CUST_CODE_onblur()
{
	if (txtEST_CUST_CODE.value == "")
	{
		txtEST_CUST_NAME.value 	= "";
		hiCUST_SEQ2.value		= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtEST_CUST_CODE.value);
	

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtEST_CUST_CODE.value	= lrRet.get("CUST_CODE");
	txtEST_CUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ2.value			= lrRet.get("CUST_SEQ");
}
function btnEST_CUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtEST_CUST_CODE.value	= lrRet.get("CUST_CODE");
	txtEST_CUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ2.value			= lrRet.get("CUST_SEQ");
}

//자동전표발행
function btnAutoSlipMake_onClick()
{
	makeInSlip();
	
	//var arrRtn = null;
	//var arrRtn2 = null;
	
	//arrRtn2 = window.showModalDialog("t_PSlipFixSheetR.jsp", arrRtn, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");

	//if(arrRtn2 == null) return;
	alert('hello');
}

//고정자산 복사 추가
function btnFixSheetCopy_onClick()
{
	if (!G_isLoaded("dsMAIN"))
	{
		C_msgOk("먼저 조회를 수행하세요");
		return;	
	}		
	
	if (dsMAIN.CountRow  < 1)
	{
		C_msgOk("복사할 자산이 없습니다.");	
		return;
	}
	
	G_Load(dsFIX_SHEET_COPY);
	dsFIX_SHEET_COPY.NameString(dsFIX_SHEET_COPY.RowPosition,"FIX_ASSET_SEQ")      =  dsMAIN.NameValue(dsMAIN.RowPosition, "FIX_ASSET_SEQ");
	
	transFixSheetCopy.Parameters = "ACT=FIX_SHEET_COPY";
	if(!G_saveData(dsFIX_SHEET_COPY)) return;
	C_msgOk("자산이 복사되었습니다..");
	G_Load(dsMAIN);
}


//자동전표조회

function	btnMakeInSlip_onClick()	//
{
	makeInSlip();
}
function	btnRemoveSlip_onClick()	//
{
	removeSlip();
}
function	btnShowSlip_onClick()
{
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
function	btnPrintBarCode_onClick()
{
	ifrmBarCode.PrintBarCode(dsMAIN.NameString(dsMAIN.RowPosition,"ASSET_MNG_NO"),dsMAIN.NameString(dsMAIN.RowPosition,"ASSET_NAME"));
}