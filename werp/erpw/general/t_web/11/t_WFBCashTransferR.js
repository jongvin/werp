/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCashPay01.js(현금지급승인확인)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-20)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var vAccClse = false;
var vMonClse = false;
var vDayClse = false;
var vDeptClse = false;

var vMAKE_COMP_CODE = "";
var vMAKE_DEPT_CODE = "";
var vMAKE_DT_TRANS  = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "현금승인");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "저장store");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsDAY_CLOSE, null, null, null, "마감정보");
	G_addDataSet(dsAUTO_FBS_CASH_TRANS_SEQ, null, null, null, "FBS_예금이체_자동전표_작업번호");
	
	gridMAIN.focus();
//	document.all.btnSeq_Create.disabled = true;

	// 자동전표	start...
	txtSLIP_MAKE_DT_F.value	= sDate;
	txtSLIP_MAKE_DT.value	= sDate;

	txtSLIP_MAKE_COMP_CODE.value = sCompCode;
	txtSLIP_MAKE_COMP_NAME.value = sCompName;

	txtSLIP_MAKE_DEPT_CODE.value = sDeptCode;
	txtSLIP_MAKE_DEPT_NAME.value = sDeptName;

	txtSLIP_INOUT_DEPT_CODE.value = sInout_DeptCode;
	txtSLIP_INOUT_DEPT_NAME.value = sInout_DeptName;
	
	txtSLIP_CHARGE_PERS.value		= sCHARGE_PERS;
	txtSLIP_CHARGE_PERS_NAME.value	= sCHARGE_PERS_NAME;
	// 자동전표	end...

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("REQUEST_YMD",txtDT_F.value)
											+ D_P2("TRANSFER_STATUS",txtTRANSFER_STATUS.value)
											+ D_P2("OUTACCNO_CODE",txtOUTACCOUNT_CODE.value)
											+ D_P2("OUTBANK_CODE",txtOUTBANK_CODE.value)
											+ D_P2("INACCNO_CODE",txtINACCOUNT_CODE.value)
											+ D_P2("INBANK_CODE",txtINBANK_CODE.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}
	else if(dataset == dsDAY_CLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DAY_CLOSE")
											+ D_P2("COMP_CODE",vMAKE_COMP_CODE)
											+ D_P2("DEPT_CODE",vMAKE_DEPT_CODE)
											+ D_P2("CLSE_DAY",vMAKE_DT_TRANS);
	}
	else if(dataset == dsAUTO_FBS_CASH_TRANS_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","AUTO_FBS_CASH_TRANS_SEQ");
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
	if (dsCOPY.CountRow > 0)
	{
		var ret = C_msgYesNoCancel("변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			btnsave_onclick();
			return ;
		}
		else if(ret == "C")
		{
			return ;
		}
	}
	
	dsCOPY.ClearData();
	
	//자료를 읽습니다.	
	if(!G_Load(dsMAIN)) return ;
	button_status_onblur()
}

// 추가
function btnadd_onclick()
{
 	var arrRtn = Array(12);
	var arrRtn2 = null;

	if (dsCOPY.CountRow > 0)
	{
		var ret = C_msgYesNoCancel("변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			btnsave_onclick();
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			//자료를 읽습니다.	
			if(!G_Load(dsMAIN)) return ;
		}			
	}		

	arrRtn[0] = txtCOMP_CODE.value;
	arrRtn[1] = '';
	arrRtn[2] = '';
	arrRtn[3] = '';	
	arrRtn[4] = '';
	arrRtn[5] = '';
	arrRtn[6] = '';
	arrRtn[7] = '';
	arrRtn[8] = '';
	arrRtn[9] = '';
	arrRtn[10] = '';
	arrRtn[11] = '';		
	arrRtn2 = window.showModalDialog("t_PCashTransferR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:400px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{
		var	strREQUEST_YMD 	   = arrRtn2[1];
		var	strOUTACCOUNT_CODE = arrRtn2[2];
		var	strOUTBANK_CODE 	 = arrRtn2[3];
		var	strINACCOUNT_CODE	 = arrRtn2[4];
		var	strINBANK_CODE 	   = arrRtn2[5];
		var	strTRANSFER_AMT 	 = arrRtn2[6];
		var	strDESCRIPTION 	   = arrRtn2[7];
	}

	G_Load(dsCOPY);
	dsCOPY.ClearData()
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	
	dsCOPY.NameString(cnt,"REQUEST_YMD") = C_Replace(strREQUEST_YMD,"-","");
	dsCOPY.NameString(cnt,"OUTACCOUNT_CODE") = strOUTACCOUNT_CODE;
	dsCOPY.NameString(cnt,"OUTBANK_CODE") = strOUTBANK_CODE;
	dsCOPY.NameString(cnt,"INACCOUNT_CODE") = strINACCOUNT_CODE;
	dsCOPY.NameString(cnt,"INBANK_CODE") = strINBANK_CODE;
	dsCOPY.NameString(cnt,"TRANSFER_AMT") = C_convSafeFloat(C_removeComma(strTRANSFER_AMT,false),false);
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value ;
	dsCOPY.NameString(cnt,"DESCRIPTION") = strDESCRIPTION ;
	
	transCopy.Parameters = "ACT=COPY1";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("저장이 완료되었습니다.","알림");		
		G_Load(dsMAIN);
	}
			
  dsCOPY.ClearData()
}

// 삽입
function btninsert_onclick()
{
}

// 삭제
function btndelete_onclick()
{
  var i = 0;
 	var cnt = 0;
	
	if(dsMAIN.CountRow==0) return;
	if(dsCOPY.CountRow==0) 
	{
		G_Load(dsCOPY);
		dsCOPY.ClearData()
  }		
  
	for (i=1;i<=dsMAIN.CountRow;i++) {

		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				if (dsMAIN.NameString(i,"TRANSFER_STATUS") == "S" )
				{
					C_msgOk("삭제할수 없습니다.","알림");
				  return;
				}  
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"TRANSFER_SEQ") = dsMAIN.NameString(i,"TRANSFER_SEQ");
				dsMAIN.DeleteRow(i);
				i = i-1;
			}
	}				
}

// 저장
function btnsave_onclick()
{
	if(dsCOPY.CountRow==0) return;
	
	transCopy.Parameters = "ACT=COPY2";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("저장이 완료되었습니다.","알림");		
		G_Load(dsMAIN);
	}
	
	dsCOPY.ClearData()
}

// 취소
function btncancel_onclick()
{	
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "SLIP_MAKE_DT")
	{
		txtSLIP_MAKE_DT.value = asDate;
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
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
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
}

//버튼 control
function button_status_onblur()
{
//  if ( (txtTRANSFER_STATUS.value == "S") || (txtTRANSFER_STATUS.value == "%"))
//  {
//			document.all.btnSeq_Create.disabled = true;
//	}
//	else
//  {
//			document.all.btnSeq_Create.disabled = false;
//	}			
}

//이체생성
function btnSeq_Create_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var MakeSelCnt = 0;
 	var StatusCnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
	
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData();
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				if (dsMAIN.NameString(i,"KEEP_CLS") == "F" )
				{ 
					MakeSelCnt++;
					dsMAIN.NameString(i,"SELECT_YN") = "F" ;
				}
				else if ( dsMAIN.NameString(i,"TRANSFER_STATUS") == "S" )
				{ 
					StatusCnt++;
					dsMAIN.NameString(i,"SELECT_YN") = "F" ;
				}				
			  else
			  {	
					dsCOPY.AddRow();
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"TRANSFER_SEQ") = dsMAIN.NameString(i,"TRANSFER_SEQ");
					cnt++;
				}	
			}		
	}
	
	if (MakeSelCnt > 0)
	{
		C_msgOk("전표확정이 안된 항목이 선택되어 있어 선택을 해제하였습니다.");
	}	
	
	if (StatusCnt > 0)
	{
		C_msgOk("이체생성이 완료된 항목이 선택되어 있어 선택을 해제하였습니다.");
	}		
	
	if ( cnt == 0 )
	{
		C_msgOk("선택된 자료가 없습니다.","확인")
		return;
	}	

	transCopy.Parameters = "ACT=COPY3";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("이체생성 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
	}
	
	dsCOPY.ClearData()
}
function OnDblClick(dataset, grid, row, colid)
{
 	var arrRtn  = Array(12);
	var arrRtn2 = null;

	if (dsCOPY.CountRow > 0)
	{
		var ret = C_msgYesNoCancel("변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			btnsave_onclick();
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			//자료를 읽습니다.	
			if(!G_Load(dsMAIN)) return ;
		}			
	}
	if (dsMAIN.NameString(row,"TRANSFER_STATUS") == "S" )
	{
		C_msgOk("수정할수 없습니다.","알림");
	  return;
	}  
			
	arrRtn[0] = txtCOMP_CODE.value;
	arrRtn[1] = dsMAIN.NameString(row,"REQUEST_YMD");
	arrRtn[2] = dsMAIN.NameString(row,"OUT_ACCOUNT_NO");
	arrRtn[3] = dsMAIN.NameString(row,"OUT_BANK_CODE");	
	arrRtn[4] = dsMAIN.NameString(row,"OUT_BANK_NAME");
	arrRtn[5] = dsMAIN.NameString(row,"IN_ACCOUNT_NO");
	arrRtn[6] = dsMAIN.NameString(row,"IN_BANK_CODE");
	arrRtn[7] = dsMAIN.NameString(row,"IN_BANK_NAME");
	arrRtn[8] = dsMAIN.NameString(row,"REMAIN_AMT");
	arrRtn[9] = dsMAIN.NameString(row,"STD_YMD");
	arrRtn[10] = dsMAIN.NameString(row,"TRANSFER_AMT");	
	arrRtn[11] = dsMAIN.NameString(row,"DESCRIPTION");	
	
	arrRtn2 = window.showModalDialog("t_PCashTransferR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:400px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{
		var	strREQUEST_YMD 	   = arrRtn2[1];
		var	strOUTACCOUNT_CODE = arrRtn2[2];
		var	strOUTBANK_CODE 	 = arrRtn2[3];
		var	strINACCOUNT_CODE	 = arrRtn2[4];
		var	strINBANK_CODE 	   = arrRtn2[5];
		var	strTRANSFER_AMT 	 = arrRtn2[6];
		var	strDESCRIPTION 	   = arrRtn2[7];
	}

	G_Load(dsCOPY);
	dsCOPY.ClearData()
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	
	dsCOPY.NameString(cnt,"TRANSFER_SEQ") = dsMAIN.NameString(row,"TRANSFER_SEQ");
	dsCOPY.NameString(cnt,"REQUEST_YMD") = C_Replace(strREQUEST_YMD,"-","");
	dsCOPY.NameString(cnt,"OUTACCOUNT_CODE") = strOUTACCOUNT_CODE;
	dsCOPY.NameString(cnt,"OUTBANK_CODE") = strOUTBANK_CODE;
	dsCOPY.NameString(cnt,"INACCOUNT_CODE") = strINACCOUNT_CODE;
	dsCOPY.NameString(cnt,"INBANK_CODE") = strINBANK_CODE;
	dsCOPY.NameString(cnt,"TRANSFER_AMT") = C_convSafeFloat(C_removeComma(strTRANSFER_AMT,false),false);
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value ;
	dsCOPY.NameString(cnt,"DESCRIPTION") = strDESCRIPTION ;
	
	transCopy.Parameters = "ACT=COPY4";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("저장이 완료되었습니다.","알림");		
		G_Load(dsMAIN);
	}		
	
	dsCOPY.ClearData()
}
function OnColumnChanged(dataset, row, colid)
{

}
//출금계좌찾기
function txtOUTACCOUNT_CODE_onblur()
{
	if (C_isNull(txtOUTACCOUNT_CODE.value))
	{
		txtOUTACCOUNT_CODE.value = '';
		txtOUTBANK_NAME.value = '';
		txtOUTBANK_CODE.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtOUTACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", 'T');

	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	
	txtOUTACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtOUTBANK_NAME.value = lrRet.get("BANK_NAME");
	txtOUTBANK_CODE.value = lrRet.get("BANK_CODE");
}
function btnOUTACCOUNT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtOUTACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", 'T');
	
	lrRet = C_LOV("T_ACCNO_CODE3", lrArgs,"F");

	if (lrRet == null) return;

	txtOUTACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtOUTBANK_NAME.value = lrRet.get("BANK_NAME");
	txtOUTBANK_CODE.value = lrRet.get("BANK_CODE");
}
//입금계좌찾기
function txtINACCOUNT_CODE_onblur()
{
	if (C_isNull(txtINACCOUNT_CODE.value))
	{
		txtINACCOUNT_CODE.value = '';
		txtINBANK_NAME.value = '';
		txtINBANK_CODE.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtINACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", '%');
	lrArgs.set("ACCT_CLS", '%');

	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtINACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtINBANK_NAME.value = lrRet.get("BANK_NAME");
	txtINBANK_CODE.value = lrRet.get("BANK_CODE");
}
function btnINACCOUNT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtINACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", '%');
	lrArgs.set("ACCT_CLS", '%');

	lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");

	if (lrRet == null) return;

	txtINACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtINBANK_NAME.value = lrRet.get("BANK_NAME");
	txtINBANK_CODE.value = lrRet.get("BANK_CODE");
}

//발의일자
function btnSLIP_MAKE_DT_onClick()
{
	txtSLIP_MAKE_DT_F.value = txtSLIP_MAKE_DT.value;
	
	C_Calendar("SLIP_MAKE_DT", "D", txtSLIP_MAKE_DT.value);
}

function Input_Clear()
{	
	if (C_isNull(txtSLIP_MAKE_COMP_CODE.value))
	{
		txtSLIP_MAKE_COMP_NAME.value = "";
		txtSLIP_MAKE_DEPT_CODE.value = "";
	}

	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value))
	{
		txtSLIP_MAKE_DEPT_NAME.value = "";
	}
	
}

// 발의사업장
function btnSLIP_MAKE_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("WORK_CODE", vWORK_CODE);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE2", lrArgs,"T");
	
	if (lrRet == null) return;
	txtSLIP_MAKE_COMP_CODE.value	= "";
	Input_Clear();
	txtSLIP_MAKE_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtSLIP_MAKE_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
	txtSLIP_CHARGE_PERS.value		= lrRet.get("CHARGE_PERS");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("CHARGE_PERS_NAME");
}

//발의부서
function btnSLIP_MAKE_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_MAKE_DEPT_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_MAKE_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_MAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_MAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	Input_Clear();
}

//출납부서
function btnSLIP_INOUT_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	//lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	lrRet = C_LOV_NEW("T_DEPT_CODE3", btnSLIP_INOUT_DEPT_CODE, lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_INOUT_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_INOUT_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_INOUT_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

//관리담당
function btnSLIP_CHARGE_PERS_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_CHARGE_PERS.value);

	lrRet = C_LOV("Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_CHARGE_PERS.value	= "";
	Input_Clear();

	txtSLIP_CHARGE_PERS.value	= lrRet.get("EMPNO");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("NAME");
}

// 이체전표생성
function	btnSlipCreate_onClick()
{
	if(!chkDayClose(true)) return;
	//수정
	if (txtSLIP_MAKE_DT.value == "")
	{
		C_msgOk("작성일자를 입력하여 주십시오.");
		txtSLIP_MAKE_DT.focus();
		return;
	}

	if (txtSLIP_MAKE_COMP_CODE.value == "")
	{
		C_msgOk("사업장 입력하여 주십시오.");
		return;
	}
	
	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value || txtSLIP_MAKE_DEPT_NAME.value))
	{
		C_msgOk("작성부서를 입력하여 주십시오.");
		return;
	}
	
	if (C_isNull(txtSLIP_CHARGE_PERS.value || txtSLIP_CHARGE_PERS_NAME.value))
	{
		C_msgOk("관리담당이 입력되지 않았습니다.<BR>*[기초정보>자동전표코드]에서 자동전표별 사업장 관리담당이 등록됐는지 확인해주시기 바랍니다.");
		return;
	}
	
	if (C_isNull(txtSLIP_INOUT_DEPT_CODE.value || txtSLIP_INOUT_DEPT_NAME.value))
	{
		C_msgOk("출납부서를 입력하여 주십시오.");
		return;
	}

	var	strAMT_TAG = 0;
	var	strMakeSelCnt = 0;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if (dsMAIN.NameString(i,"SELECT_YN") == "T")
		{
			if (dsMAIN.NameString(i,"MAKE_CLS") == "T")
			{
				strMakeSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}
			else {
				strAMT_TAG++;
			}
		}
	}

	if (strMakeSelCnt > 0)
	{
		C_msgOk("이미 전표발행된 항목이 선택되있어 선택을 해제하였습니다.");
	}
	
	if (strAMT_TAG == 0)
	{
		C_msgOk("선택된 항목이 없습니다.");
		return;
	}

	G_Load(dsAUTO_FBS_CASH_TRANS_SEQ, null);
	
	trans.Parameters = "";
	trans.Parameters += "ACT=AUTO_FBS_CASH_TRANS";
	trans.Parameters += ",AUTO_FBS_CASH_TRANS_SEQ="+dsAUTO_FBS_CASH_TRANS_SEQ.NameString(1,"AUTO_FBS_CASH_TRANS_SEQ");
	trans.Parameters += ",SLIP_MAKE_DT="+C_Replace(txtSLIP_MAKE_DT.value,"-","");
	trans.Parameters += ",SLIP_KIND_TAG=B";
	trans.Parameters += ",SLIP_MAKE_COMP_CODE="+txtSLIP_MAKE_COMP_CODE.value;
	trans.Parameters += ",SLIP_MAKE_DEPT_CODE="+txtSLIP_MAKE_DEPT_CODE.value;
	trans.Parameters += ",SLIP_CHARGE_PERS="+txtSLIP_CHARGE_PERS.value;
	trans.Parameters += ",SLIP_INOUT_DEPT_CODE="+txtSLIP_INOUT_DEPT_CODE.value;
	
	//alert(trans.Parameters);

	if(!G_saveDataMsg(dsMAIN)) return;;
	btnquery_onclick();
	/*
	btnRetrieve_onClick();
	
	txtBANK_CODE.value = "";
	txtBANK_NAME.value = "";
	txtACCNO.value = "";
	txtSLIP_ID.value = "";
	txtACC_CODE01.value	 = "";
	txtACC_NAME01.value	 = "";
	*/
}

// 이체전표삭제
function	btnSlipDelete_onClick()
{
	if(!chkDayClose(true)) return;
	
	var	strAMT_TAG = 0;
	var	strKeepSelCnt = 0;
	var	strNotMakeSelCnt = 0;

	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if (dsMAIN.NameString(i,"SELECT_YN") == "T")
		{
			if (dsMAIN.NameString(i,"KEEP_CLS") == "T")
			{
				strKeepSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}
			else if (dsMAIN.NameString(i,"MAKE_CLS") != "T")
			{
				strNotMakeSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}

			else {
				strAMT_TAG++;
			}
		}
	}

	if (strKeepSelCnt > 0)
	{
		C_msgOk("발행된 전표가 확정된 항목이 선택되있어 선택을 해제하였습니다.");
	}

	if (strNotMakeSelCnt > 0)
	{
		C_msgOk("전표 미발행 항목이 선택되있어 선택을 해제하였습니다.");
	}
	
	if (strAMT_TAG == 0)
	{
		C_msgOk("선택된 항목이 없습니다.");
		return;
	}
	
	trans.Parameters = "";
	trans.Parameters += "ACT=DELETE_FBS_CASH_TRANS";
	
	//alert(trans.Parameters);
	
	if(!G_saveDataMsg(dsMAIN)) return;;
	btnquery_onclick();
	/*
	btnRetrieve_onClick();
	
	txtBANK_CODE.value = "";
	txtBANK_NAME.value = "";
	txtACCNO.value = "";
	txtSLIP_ID.value = "";
	txtACC_CODE01.value	 = "";
	txtACC_NAME01.value	 = "";
	*/
}

//회기마감
function chkDayClose(bMsgView)
{
	//var vMsg = "( 전표번호 : "+dsMAIN.NameString(row,"MAKE_SLIPNO") + " )";
	var vMsg = "";
	vMAKE_COMP_CODE = txtSLIP_MAKE_COMP_CODE.value;
	vMAKE_DEPT_CODE = txtSLIP_MAKE_DEPT_CODE.value;
	vMAKE_DT_TRANS  = txtSLIP_MAKE_DT.value;
	G_Load(dsDAY_CLOSE, null);
	if(dsDAY_CLOSE.CountRow==0) {
		if(bMsgView) C_msgOk("해당일자의 사업장별 마감정보가 등록되지 않았습니다.<BR>"+vMsg, "확인");
		vAccClse = false;
		vMonClse = false;
		vDayClse = false;
		vDeptClse = false;
		return false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "ACC_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 회기마감되었습니다.<BR>"+vMsg, "확인");
		vAccClse = true;
		return false;
	} else {
		vAccClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "MON_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 월마감되었습니다.<BR>"+vMsg, "확인");
		vMonClse = true;
		return false;
	} else {
		vMonClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DAY_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 일마감되었습니다.<BR>"+vMsg, "확인");
		vDayClse = true;
		return false;
	} else {
		vDayClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DEPT_CLSE_CLS") == "T")
	{		
		if(bMsgView) C_msgOk(txtMAKE_DEPT_NAME.value+"의 전표입력기간이 종료되었습니다.<BR>"+vMsg+"<BR>* 전표입력가능기간 : ("+dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "INPUT_DT")+")", "확인");
		vDeptClse = true;
		return false;
	} else {
		vDeptClse = false;
	}
	
	return true;
}

// 전체선택
function btnAllSelect_onClick()
{
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
//		if(dsMAIN.NameString(i,"KEEP_CLS") != "T") 
		dsMAIN.NameString(i,"SELECT_YN") = "T";
	}
}

// 전체선택취소
function btnAllSelCancle_onClick()
{
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
//		if(dsMAIN.NameString(i,"KEEP_CLS") != "T") 
		dsMAIN.NameString(i,"SELECT_YN") = "F";
	}
}

//전 표 조 회
function btnSlipRetrieve_onClick()
{
	var vRow = dsMAIN.RowPosition;
	if(dsMAIN.NameString(vRow,"MAKE_CLS") != "T") {
		C_msgOk("전표가 발행되지 않았습니다.","알림");
		return;
	}

	var pSLIP_ID        = dsMAIN.NameString(vRow,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(vRow,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(vRow,"MAKE_COMP_CODE");
	var pMAKE_DT 	    = dsMAIN.NameString(vRow,"MAKE_DT").replace(/-/gi,"");
	var pMAKE_SEQ     	= dsMAIN.NameString(vRow,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(vRow,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";

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