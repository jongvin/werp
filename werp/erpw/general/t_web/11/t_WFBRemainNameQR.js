/**************************************************************************/
/* 1. 프 로 그 램 id : t_WChangeBillPwR.js(개인암호관리)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "예금주명");
	G_addDataSet(dsSUB, null, null, sSelectPageName+D_P1("ACT","SUB"), "잔액");
	G_addDataSet(dsSTR, null, null, sSelectPageName+D_P1("ACT","STR"), "자르기");
	G_addDataSet(dsLOV,null,null,null);

  txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
}

function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
		                                  + D_P2("COMP_CODE",txtCOMP_CODE.value)
		                                  + D_P2("BANK_CD",txtBANK_CD.value)
		                                  + D_P2("ACCNO_CD",txtACCNO_CD.value)
		                                  + D_P2("BASE_NO",'98191010667505');
	}
	else if (dataset == dsSUB)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB")
		                                 + D_P2("BANK_CODE",txtBANK_CODE.value)
		                                 + D_P2("ACCNO_CODE",txtACCNO_CODE.value);		
	}		
	else if (dataset == dsSTR)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","STR")
		                                 + D_P2("GUBUN",sGubun)
		                                 + D_P2("RET_VAL",sRetValue);
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

function btnquery_onclick()
{
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

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnKeyPress(dataset, grid, kcode)
{
}

function OnDblClick(dataset, grid, row, colid)
{
}

// 이벤트관련-------------------------------------------------------------------//
//계좌번호
function txtACCNO_CODE_onblur()
{	
	if (C_isNull(txtACCNO_CODE.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	
	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE4", lrArgs,"T");

	if (lrRet == null) return;
	txtBANK_NAME.value = lrRet.get("BANK_MAIN_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_MAIN_CODE");
	txtACCNO_CODE.value = lrRet.get("ACCNO");
}
function btnACCNO_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);

	lrRet = C_LOV("T_ACCNO_CODE4", lrArgs,"F");

	if (lrRet == null) return;

	txtBANK_NAME.value = lrRet.get("BANK_MAIN_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_MAIN_CODE");
	txtACCNO_CODE.value = lrRet.get("ACCNO");
}

function	btnGetData_Remain_onClick()
{
	if(C_isNull(txtACCNO_CODE.value))
	{
		C_msgOk("계좌를 선택하십시오.");
		return;
	}

	G_Load(dsSUB);
  sRetValue = dsSUB.NameString(1,"RET_VAL");
  sGubun = "Remain";
	G_Load(dsSTR);
	txtREMAIN_AMT.value = C_toNumberFormatString(dsSTR.NameString(1,"VALUE1"));
	txtENABLE_AMT.value = C_toNumberFormatString(dsSTR.NameString(1,"VALUE2"));
	txtRESULT_TEXT2.value = dsSTR.NameString(1,"VALUE3");
}
function	btnGetData_Name_onClick()
{
	if(C_isNull(txtACCNO_CD.value))
	{
		C_msgOk("계좌번호를 입력하십시오.");
		return;
	}

	G_Load(dsMAIN);
	sRetValue = dsMAIN.NameString(1,"RET_VAL");
	sGubun = "Name";
	G_Load(dsSTR);
	txtACCT_NAME.value = dsSTR.NameString(1,"VALUE1");
	txtRESULT_TEXT1.value = dsSTR.NameString(1,"VALUE2");
}
function	juminchk_oncblur()
{
	if(C_isNull(txtJUMIN_NO.value))
	return ;

  if(C_isValidRegNo(txtJUMIN_NO.value))
  return ;
  
  if(C_isValidCustNo(txtJUMIN_NO.value)) 
  return ;
  	
  C_msgOk("주민/사업자번호가 올바르지 않습니다.","알림");
  txtJUMIN_NO.value = '';
  txtJUMIN_NO.focus();
  return;
	
}
function	acctno_oncblur()
{
	if(C_isNull(txtACCNO_CD.value))
	return ;

  if(C_isNum(txtACCNO_CD.value))
  return ;
  	
  C_msgOk("계좌번호는 숫자입니다.","알림");
  txtACCNO_CD.value = '';
  txtACCNO_CD.focus();
  return;	
}