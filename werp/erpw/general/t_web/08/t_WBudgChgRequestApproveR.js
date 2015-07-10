/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgChgRequestApproveR.js(예산변경승인)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 예산변경승인 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-20)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "예산신청내역");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "월별예산", null, null, true);
	G_addDataSet(dsSUB02, trans, gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "변경내역사유"); 
	
	G_addDataSet(dsCHG_SEQ, null, null, null, "예산변경차수");
	
	G_addDataSet(dsBUDG_APPLY_YM, null, null, null, "예산변경적용년월");
	
	G_addDataSet(dsCONFIRM_KIND_ALL, transConfirmKindAll, null,null, "확정구분변경일괄처리");
	G_addDataSet(dsCONFIRM_TAG, transConfirmTag, null,null, "확정처리");
	G_addDataSet(dsCONFIRM_TAG_ALL, transConfirmTagAll, null,null, "일괄확정처리");
	G_addDataSet(dsCONFIRM_KIND, transConfirmKind, null,null, "확정구분처리");
	
	G_addDataSet(dsREASON_NO, null, null,null, "사유순번");
	G_addDataSet(dsLOV, null, null,null, "LOV");
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	
	G_addRel(dsSUB01,dsSUB02);
	G_addRelCol(dsSUB02,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB02,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB02,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsSUB02,"BUDG_CODE_NO","BUDG_CODE_NO");
	G_addRelCol(dsSUB02,"CHG_SEQ","CHG_SEQ");
	G_addRelCol(dsSUB02,"RESERVED_SEQ","RESERVED_SEQ");
	G_addRelCol(dsSUB02,"BUDG_YM","BUDG_YM");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	G_Load(dsBUDG_APPLY_YM,null);
	G_Load(dsMAIN,null);
	
	
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridMAIN,"CHG_SEQ");
	G_setReadOnlyCol(gridMAIN,"BUDG_APPLY_YM");
	G_setReadOnlyCol(gridMAIN,"REQUEST_TAG");
	G_setReadOnlyCol(gridMAIN,"CONFIRM_TAG"); 
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME"); 
	
	G_setReadOnlyCol(gridSUB01,"CHG_AMT");
	G_setReadOnlyCol(gridSUB01,"BUDG_CODE_NAME");
	G_setReadOnlyCol(gridSUB01,"FULL_PATH");
	G_setReadOnlyCol(gridSUB01,"BUDG_MONTH_REQ_AMT");
	G_setReadOnlyCol(gridSUB01,"BUDG_MONTH_ASSIGN_AMT");
	G_setReadOnlyCol(gridSUB01,"CONFIRM_KIND_NAME"); 
	G_setReadOnlyCol(gridSUB01,"REASON_CODE_NAME"); 
	
	G_setReadOnlyCol(gridSUB02,"R_BUDG_YM");
	G_setReadOnlyCol(gridSUB02,"BUDG_MONTH_REQ_AMT");
	G_setReadOnlyCol(gridSUB02,"BUDG_MONTH_ASSIGN_AMT");
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("CONFIRM_TAG",cboCONFIRM_TAG.value)
									 + D_P2("BUDG_APPLY_YM",dsBUDG_APPLY_YM.NameString(dsBUDG_APPLY_YM.RowPosition,"BUDG_APPLY_YM"));
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"))
										 + D_P2("CLSE_ACC_ID",dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID"))
										 + D_P2("DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"))
										 + D_P2("CHG_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"CHG_SEQ"))
										 + D_P2("RESERVED_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"RESERVED_SEQ"))
										 + D_P2("BUDG_CODE_NO",dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NO"));
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
									+ D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("DEPT_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"))
									 + D_P2("CHG_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"CHG_SEQ"))
									 + D_P2("RESERVED_SEQ",dsSUB01.NameString(dsSUB01.RowPosition,"RESERVED_SEQ"))
									 + D_P2("BUDG_CODE_NO",dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_CODE_NO"))
									 + D_P2("BUDG_YM",dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM"));
	}
	else if(dataset == dsREASON_NO) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REASON_NO");
									
	}
	else if(dataset == dsBUDG_APPLY_YM)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BUDG_APPLY_YM")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("CONFIRM_TAG",cboCONFIRM_TAG.value);
	}
	else if(dataset == dsCONFIRM_KIND_ALL) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CONFIRM_KIND_ALL");
									
	}
	else if(dataset == dsCONFIRM_TAG) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CONFIRM_TAG");
									
	}
	else if(dataset == dsCONFIRM_TAG_ALL) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CONFIRM_TAG_ALL");
									
	}
	else if(dataset == dsCONFIRM_KIND) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CONFIRM_KIND");
									
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

function	chkTopCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("먼저 회기를 선택하세요.", "확인");
		return false;
	}
	
	return true;
}
function getCOMPANY_CODE()
{
	var arrRec = new Array();

	arrRec[1] = txtCOMP_CODE.value;
	arrRec[2] = txtCLSE_ACC_ID.value;
	
	
	return 	arrRec;
}

function getCHG_SEQ()
{
	var arrRec = new Array();
	
	G_Load(dsCHG_SEQ, null);
	arrRec[1] = dsCHG_SEQ.NameString(dsCHG_SEQ.RowPosition, "CHG_SEQ");

	return 	arrRec;
}
function selectBUDG_APPLY_YM()
{	
	G_Load(dsBUDG_APPLY_YM, null);
	G_Load(dsMAIN, null);
}

function calChgAmt()
{
	var tempCHG_AMT = 0;
	for(var i=1; i <= dsSUB02.CountRow; i++)
	{
		tempCHG_AMT= tempCHG_AMT + parseInt(dsSUB02.NameValue(i, "CHG_AMT"));	
	}
	return tempCHG_AMT;
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

	D_defaultSave();
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
	if (dataset == dsSUB01)
	{
		var strCONFIRM_TAG = dsMAIN.NameValue(dsMAIN.RowPosition, "CONFIRM_TAG");
		var strREQUEST_TAG =  dsMAIN.NameValue(dsMAIN.RowPosition, "REQUEST_TAG");
		
		if (strREQUEST_TAG == 'T')
		{
			C_msgOk('신청완료되어 추가할 수 없습니다');
			return false;
		}
		
		if (strCONFIRM_TAG == 'T')
		{
			C_msgOk('확정되어 추가할 수 없습니다');
			return false;
		}
		
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		dataset.NameValue(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameValue(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		dataset.NameValue(row,"DEPT_CODE")  = txtDEPT_CODE.value;
		dataset.NameValue(row,"CONFIRM_TAG")  = 'F';
		dataset.NameValue(row,"REQUEST_TAG")  = 'F';
	}
	
	if (dataset == dsSUB01)
	{
		dataset.NameValue(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameValue(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		dataset.NameValue(row,"DEPT_CODE")  = txtDEPT_CODE.value;
		dataset.NameValue(row,"CHG_SEQ")  = dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ");
		dataset.NameString(row, "REASON_CODE") = "1";	
		dataset.NameString(row, "CONFIRM_KIND_NAME") = "신청";
		dataset.NameString(row, "CONFIRM_KIND") = "0";
	}
	
	if (dataset == dsSUB02)
	{
		G_Load(dsREASON_NO, null);
		dataset.NameString(row, "REASON_NO") = dsREASON_NO.NameString(dsREASON_NO.RowPosition, "REASON_NO");
		
		if (dsSUB01.NameValue(dsSUB01.RowPosition,"REASON_CODE") == "4")
		{	
			dataset.NameValue(row,"R_COMP_CODE") = txtCOMP_CODE.value;
			dataset.NameValue(row,"R_CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dataset.NameValue(row,"R_DEPT_CODE")  = txtDEPT_CODE.value;
			dataset.NameValue(row,"R_CHG_SEQ")  = dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ");
			dataset.NameValue(row,"R_BUDG_CODE_NO")  = dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_CODE_NO");
			dataset.NameValue(row,"R_RESERVED_SEQ")  = dsSUB01.NameValue(dsSUB01.RowPosition,"RESERVED_SEQ");
		}
		
	}
}

function OnRowDeleteBefore(dataset)
{
	if ( dataset = dsSUB02)
	{			
		dsSUB01.NameValue(dsSUB01.RowPosition,"CHG_AMT") =  dsSUB01.NameValue(dsSUB01.RowPosition,"CHG_AMT")  - dsSUB02.NameValue(dsSUB02.RowPosition,"CHG_AMT");
	}	
	return true;
}

function OnRowDeleted(dataset, row)
{
	
}

function OnColumnChanged(dataset, row, colid)
{
	 if ( dataset == dsSUB02)
	{
		
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if ( dataset== dsSUB02)
	{	
		if ( colid =="R_BUDG_YM")
		{
			if ( dataset.NameValue(dataset.RowPosition,"R_BUDG_YM")=="")
			{
				dataset.NameValue(dataset.RowPosition,"BUDG_MONTH_REQ_AMT")=="";
			}	
		}
		else if ( colid =="CHG_AMT")
		{
			if ( dsSUB01.NameValue(dsSUB01.RowPosition,"REASON_CODE")==4)
			{
				if ( dataset.NameValue(dataset.RowPosition,"R_BUDG_YM")=="")
				{
					C_msgOk("원천예산월을 입력하세요");
					dataset.NameValue(row,"CHG_AMT") = 0;
					return false;
				}
				if ( dataset.NameValue(row,"BUDG_MONTH_REQ_AMT") > 0 && (dataset.NameValue(row,"BUDG_MONTH_REQ_AMT") < dataset.NameValue(row,"CHG_AMT")))
				{
					C_msgOk("변경금액이 원천신청금액을 초과할 수 없습니다.");
					dataset.NameValue(row,"CHG_AMT") = 0;
					return false;
				}
			}
			dsSUB01.NameValue(dsSUB01.RowPosition,"CHG_AMT") =  calChgAmt();
			dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_MONTH_ASSIGN_AMT") = dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_MONTH_REQ_AMT") + dsSUB01.NameValue(dsSUB01.RowPosition,"CHG_AMT");
		}
		
	}
}
function OnPostBefore(dataset, trans)
{
	if ( dataset== dsSUB02)
	{	
		if ( dataset.NameValue(dataset.RowPosition,"CHG_AMT")==0)
		{
			C_msgOk("변경금액을 입력하세요");
			return false;
		}
	}
	return true;
}
function OnPopup(dataset, grid, row, colid, data)
{
	if ( dataset ==dsSUB01)
	{
		
		if(!CheckCompCode()) return;
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
		lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);
		lrArgs.set("CHG_SEQ", dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ"));
		//lrArgs.set("BUDG_YM", getYearMonth("-"));
		lrArgs.set("BUDG_YM", "2005-10");
		lrArgs.set("SEARCH_CONDITION", "");
		
	
		lrRet = C_LOV("T_BUDG_DEPT_CODE3", lrArgs,"T");
		
		if (lrRet == null) return;
		
		dataset.NameValue(row,"BUDG_YM")	= lrRet.get("BUDG_YM");
		dataset.NameValue(row,"BUDG_CODE_NAME")	= lrRet.get("BUDG_CODE_NAME");
		dataset.NameValue(row,"FULL_PATH")	= lrRet.get("FULL_PATH");
		dataset.NameValue(row,"BUDG_MONTH_REQ_AMT")	= lrRet.get("BUDG_MONTH_REQ_AMT");
		dataset.NameValue(row,"BUDG_MONTH_ASSIGN_AMT")	= lrRet.get("BUDG_MONTH_ASSIGN_AMT");
		dataset.NameValue(row,"BUDG_CODE_NO")	= lrRet.get("BUDG_CODE_NO");
		dataset.NameValue(row,"RESERVED_SEQ")	= lrRet.get("RESERVED_SEQ");	
	}
	
	if ( dataset ==dsSUB02)
	{
		
		if(!CheckCompCode()) return;
		if (dsSUB01.NameValue(dsSUB01.RowPosition,"REASON_CODE") != "4")
		{
			C_msgOk("차월이월시만 입력하세요");
			return;
		}
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
		lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);
		lrArgs.set("CHG_SEQ", dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ"));
		//lrArgs.set("BUDG_YM", getYearMonth("-"));
		lrArgs.set("BUDG_YM", "2005-10");
		lrArgs.set("SEARCH_CONDITION", "");
		
	
		lrRet = C_LOV("T_BUDG_DEPT_CODE3", lrArgs,"T");
		
		if (lrRet == null) return;
		var strR_BUDG_YM = lrRet.get("BUDG_YM");
		if ( strR_BUDG_YM ==  dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_YM"))
		{
				C_msgOk("원천월을 변경예산월보다 크게 지정하세요");
				dataset.NameValue(row,"R_COMP_CODE") = "";
				dataset.NameValue(row,"R_CLSE_ACC_ID") = "";
				dataset.NameValue(row,"R_DEPT_CODE")  = "";
				dataset.NameValue(row,"R_CHG_SEQ")  = "";
				dataset.NameValue(row,"R_BUDG_CODE_NO")  = "";
				dataset.NameValue(row,"R_RESERVED_SEQ")  = "";
				dataset.NameValue(row,"R_BUDG_YM")	= "";
				return false;
		}	
		dataset.NameValue(row,"BUDG_MONTH_REQ_AMT")		= lrRet.get("BUDG_MONTH_REQ_AMT");
		dataset.NameValue(row,"R_BUDG_YM")					= lrRet.get("BUDG_YM");
		
	}
}
function OnClick(dataset, grid, row, colid)
{
	
}
// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}

function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	
	D_defaultLoad();
	
}
function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");

	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}

function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	D_defaultLoad();
	
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

//예산변경신청
function 	btnBudgChgRequest_onClick()
{
	if(!chkTopCondition()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return false;
		}
	}
	
	var arrRtn = getCHG_SEQ();
	if( arrRtn[1] == -1)
	{
		C_msgOk("이전차수 예산이 미확정되어 변경신청이 불가능합니다");
		return false; 	
	}
	var arrRtn2 = null;

	arrRtn2 = window.showModalDialog("t_PBudgChgRequestR.jsp", arrRtn, "center:yes; dialogWidth:245px; dialogHeight:235px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	
	if(arrRtn2[0]=="TRUE")
	{
		
		G_addRow(dsMAIN);
		
		dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ") 			= arrRtn2[1];
		dsMAIN.NameValue(dsMAIN.RowPosition,"BUDG_APPLY_YM")  	= arrRtn2[2];

		gridMAIN.focus();
	}
}

//예산변경신청취소
function 	btnRequestCancel_onClick()
{
	
	G_Load(dsCHANGE_CANCEL);
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"CHG_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition, "CHG_SEQ");
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	
	transChangeCancel.Parameters = "ACT=CHANGE_CANCEL";
	
	if(!G_saveData(dsCHANGE_CANCEL))return;
	
	G_Load(dsMAIN, null);
	C_msgOk("예산변경취소가 정상적으로 수행되었습니다.");
	gridMAIN.focus();
}

//확정구분변경처리(일괄)
function budgChgRequestConfirmKindChangeAll(CONFIRM_KIND, MSG)
{
	G_Load(dsCONFIRM_KIND_ALL);
	dsCONFIRM_KIND_ALL.NameString(dsCONFIRM_KIND_ALL.RowPosition,"COMP_CODE")     = txtCOMP_CODE.value;
	dsCONFIRM_KIND_ALL.NameString(dsCONFIRM_KIND_ALL.RowPosition,"CLSE_ACC_ID")    = txtCLSE_ACC_ID.value;
	dsCONFIRM_KIND_ALL.NameString(dsCONFIRM_KIND_ALL.RowPosition,"DEPT_CODE")      =  dsMAIN.NameString(dsMAIN.RowPosition, "DEPT_CODE");
	dsCONFIRM_KIND_ALL.NameString(dsCONFIRM_KIND_ALL.RowPosition,"CHG_SEQ")          = dsMAIN.NameString(dsMAIN.RowPosition, "CHG_SEQ");
	dsCONFIRM_KIND_ALL.NameString(dsCONFIRM_KIND_ALL.RowPosition,"CONFIRM_KIND")   =CONFIRM_KIND;
	
	transConfirmKindAll.Parameters = "ACT=CONFIRM_KIND_ALL";
	
	if(!G_saveData(dsCONFIRM_KIND_ALL))return;
	
	G_Load(dsSUB01, null);
	C_msgOk( MSG +  " 정상적으로 수행되었습니다.");
	dsSUB01.focus();
}
//확정처리
function budgChgRequestConfirm(CONFIRM_TAG, MSG)
{
	G_Load(dsCONFIRM_TAG);
	dsCONFIRM_TAG.NameString(dsCONFIRM_TAG.RowPosition,"COMP_CODE")  	= txtCOMP_CODE.value;
	dsCONFIRM_TAG.NameString(dsCONFIRM_TAG.RowPosition,"CLSE_ACC_ID") 	= txtCLSE_ACC_ID.value;
	dsCONFIRM_TAG.NameString(dsCONFIRM_TAG.RowPosition,"CHG_SEQ")      	= dsMAIN.NameString(dsMAIN.RowPosition, "CHG_SEQ");
	dsCONFIRM_TAG.NameString(dsCONFIRM_TAG.RowPosition,"DEPT_CODE")  	=  dsMAIN.NameString(dsMAIN.RowPosition, "DEPT_CODE");
	dsCONFIRM_TAG.NameString(dsCONFIRM_TAG.RowPosition,"CONFIRM_TAG") 	= CONFIRM_TAG;
	
	transConfirmTag.Parameters = "ACT=CONFIRM_TAG";
	
	if(!G_saveData(dsCONFIRM_TAG))return;
	
	G_Load(dsMAIN, null);
	C_msgOk( MSG +  " 정상적으로 수행되었습니다.");
	gridMAIN.focus();
}
//확정처리(일괄)
function budgChgRequestConfirmAll(CONFIRM_TAG, MSG)
{
	G_Load(dsCONFIRM_TAG_ALL);
	dsCONFIRM_TAG_ALL.NameString(dsCONFIRM_TAG_ALL.RowPosition,"COMP_CODE")  = txtCOMP_CODE.value;
	dsCONFIRM_TAG_ALL.NameString(dsCONFIRM_TAG_ALL.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsCONFIRM_TAG_ALL.NameString(dsCONFIRM_TAG_ALL.RowPosition,"CONFIRM_TAG") = CONFIRM_TAG;
	
	transConfirmTagAll.Parameters = "ACT=CONFIRM_TAG_ALL";
	
	if(!G_saveData(dsCONFIRM_TAG_ALL))return;
	
	G_Load(dsMAIN, null);
	C_msgOk( MSG +  " 정상적으로 수행되었습니다.");
	gridMAIN.focus();
}
//확정구분처리
function  budgChgRequestConfirmKindChange(CONFIRM_KIND, MSG)
{

	G_Load(dsCONFIRM_KIND);
	for(var i = 1 ; i <= dsSUB01.CountRow ; ++i)
	{
		if (dsSUB01.RowMark(i) =="1")
		{
			dsCONFIRM_KIND.AddRow();
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"COMP_CODE")  = txtCOMP_CODE.value;
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"CHG_SEQ")      = dsSUB01.NameString(dsSUB01.RowPosition, "CHG_SEQ");
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"DEPT_CODE")  =  dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_CODE");
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"RESERVED_SEQ")      = dsSUB01.NameString(dsSUB01.RowPosition, "RESERVED_SEQ");
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"BUDG_CODE_NO")      = dsSUB01.NameString(dsSUB01.RowPosition, "BUDG_CODE_NO");
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"BUDG_YM")      		= dsSUB01.NameString(dsSUB01.RowPosition, "BUDG_YM");
			dsCONFIRM_KIND.NameString(dsCONFIRM_KIND.RowPosition,"CONFIRM_KIND") = CONFIRM_KIND;
		}
	}
	
	transConfirmKind.Parameters = "ACT=CONFIRM_KIND";

	if(!G_saveData(dsCONFIRM_KIND))return;

	G_Load(dsSUB01, null);
	C_msgOk( MSG +  " 정상적으로 수행되었습니다.");
	gridSUB01.focus();
}


//일괄승인
function 	btnBudgChgRequestSignAll_onClick()
{
	budgChgRequestConfirmKindChangeAll("1","일괄승인이");
}
//일괄승인취소
function 	btnBudgChgRequestSignAllCancel_onClick()
{
	budgChgRequestConfirmKindChangeAll("0","일괄승인취소가");
}
//일괄조정
function 	btnBudgChgRequestSettlementAll_onClick()
{
	budgChgRequestConfirmKindChangeAll("2","일괄조정이");
}
//일괄기각
function 	btnBudgChgRequestRejectAll_onClick()
{
	budgChgRequestConfirmKindChangeAll("3","일괄기각이");
}

//예산변경확정
function 	btnBudgChgRequestConfirm_onClick()
{
	budgChgRequestConfirm("T", "예산변경확정이");
}
//예산변경확정취소
function 	btnBudgChgRequestConfirmCancel_onClick()
{
	budgChgRequestConfirm("F", "예산변경확정취소가");
}
//예산변경일괄확정
function 	btnBudgChgRequestConfirmAll_onClick()
{
	budgChgRequestConfirmAll("T", "예산변경일괄확정이");
}
//예산변경확정일괄취소
function 	btnBudgChgRequestConfirmCancelAll_onClick()
{
	budgChgRequestConfirmAll("F", "예산변경일괄확정취소가");
}
//신청승인
function 	btnBudgChgRequestSign_onClick()
{
	budgChgRequestConfirmKindChange("1", "신청승인이");
}
//신청승인취소
function 	btnBudgChgRequestSignCancel_onClick()
{
	budgChgRequestConfirmKindChange("0", "신청승인취소가");
}
//신청조정
function 	btnBudgChgRequestSettlement_onClick()
{
	budgChgRequestConfirmKindChange("2", "신청조정이");	
}
//신청기각
function 	btnBudgChgRequestReject_onClick()
{
	budgChgRequestConfirmKindChange("3", "신청기각이");
}

