/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCashPay01.js(현금지급출납확인)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "현금출납");
	G_addDataSet(dsSUB, trans,  gridSUB, sSelectPageName+D_P1("ACT","SUB01"), "상환내역");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "저장store");	
	G_addDataSet(dsMAKE, transMake, null, sSelectPageName+D_P1("ACT","MAKE"), "데이타생성");	
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsBANK, null, null, sSelectPageName+D_P1("ACT","BANK"), "은행코드조회");	
	G_addDataSet(dsACCOUNT, null, null, sSelectPageName+D_P1("ACT","ACCOUNT"), "계좌번호조회");
	G_addDataSet(dsPASS, null, null, sSelectPageName+D_P1("ACT","PASS"), "암호확인");

	document.all.btnCASH_CONFIRM.disabled = false;
	document.all.btnCASH_CANCEL.disabled = true;	
	gridMAIN.focus();

	G_addRel(dsBANK,dsACCOUNT);
	G_addRelCol(dsACCOUNT,"CODE","BANK_CODE");

	G_addRel(dsMAIN,dsSUB);
	G_addRelCol(dsSUB,"PAY_SEQ","PAY_SEQ");


	G_Load(dsBANK);
	G_Load(dsACCOUNT);
	
}
function OnLoadBefore(dataset)
{
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	var	strACCNO_CODE = dsACCOUNT.NameString(dsACCOUNT.RowPosition,"CODE");		
	
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("PAY_GUBUN",txtPAY_GUBUN.value)
											+ D_P2("PAY_STATUS",txtPAY_STATUS.value)
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("CUST_CODE",txtCUST_SEQ.value)
											+ D_P2("BANK_CODE",strBANK_CODE)
											+ D_P2("ACCNO_CODE",strACCNO_CODE.replace(/-/g,''))
											+ D_P2("METHOD_CODE",txtMETHOD_CODE.value);
	}
	else if (dataset == dsSUB)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB")
											+ D_P2("PAY_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"PAY_SEQ"));
	}	
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}	
	else if (dataset == dsMAKE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE");
	}
	else if(dataset == dsBANK)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BANK")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value);
	}		
	else if(dataset == dsACCOUNT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ACCOUNT")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("BANK_CODE",strBANK_CODE);	
	}	
	else if (dataset == dsPASS)
	{
  	dataset.DataID = sSelectPageName + D_P1("ACT","PASS")
  										+ D_P2("EMP_NO",txtEMP_NO.value)
  										+ D_P2("MANAGER_PASS1",txtMANAGER_PASS1.value)
  										+ D_P2("MANAGER_PASS2",txtMANAGER_PASS2.value);
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
	gridMAIN.focus();
	G_Load(dsMAIN);	
	//D_defaultLoad();
	button_status_onblur();
	SUM_SET_onblur()
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

// 이벤트관련-------------------------------------------------------------------//
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
}

//거래처코드
function txtCUST_CODE_onblur()
{
	if (C_isNull(txtCUST_CODE.value))
	{
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		txtCUST_SEQ.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
	txtCUST_SEQ.value = lrRet.get("CUST_SEQ");
}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	if (C_isNull(txtCUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
	txtCUST_SEQ.value = lrRet.get("CUST_SEQ");
}

//전체선택
function btnSELECT_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if ((dsMAIN.NameString(i,"PAY_STATUS") == "0" )||(dsMAIN.NameString(i,"PAY_STATUS") == "1" ))
		  {
				dsMAIN.NameString(i,"SELECT_YN") = "T";
			}		
	}
}

//전체취소
function btnCANCEL_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if ((dsMAIN.NameString(i,"PAY_STATUS") == "0" )||(dsMAIN.NameString(i,"PAY_STATUS") == "1" ))
		  {
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}		
	}
	
}

//버튼 control
function button_status_onblur()
{
  if (txtPAY_STATUS.value == "0")
  {
			document.all.btnCASH_CONFIRM.disabled = false;
	    document.all.btnCASH_CANCEL.disabled = true;	
	}
	else if (txtPAY_STATUS.value == "1")
  {
			document.all.btnCASH_CONFIRM.disabled = true;
	    document.all.btnCASH_CANCEL.disabled = false;	
	}	
	else
  {
			document.all.btnCASH_CONFIRM.disabled = true;
	    document.all.btnCASH_CANCEL.disabled = true;	
	}			
}

//데이타생성
function btnDATA_MAKE_onClick()
{
 	var i = 0;
 	var cnt = 0;
		
	G_Load(dsMAKE);
	dsMAKE.ClearData()
	dsMAKE.AddRow()
	cnt = dsMAKE.CountRow;
	
	dsMAKE.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
	dsMAKE.NameString(cnt,"FROM_DATE") = txtDT_F.value.replace(/-/g,'');	
	dsMAKE.NameString(cnt,"TO_DATE") = txtDT_T.value.replace(/-/g,'');

	transMake.Parameters = "ACT=MAKE";

	if(G_saveData(dsMAKE))
	{
		C_msgOk("데이타생성 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
	}
}

//담당자확인
function btnCASH_CONFIRM_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
		
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
				cnt++;
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("선택된 자료가 없습니다.","확인")
		return;
	}	

	arrRtn2 = window.showModalDialog("t_PFBManagerconfR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{
		var	strMANAGER_PASS1 	= arrRtn2[1];
		var	strMANAGER_PASS2	= arrRtn2[2];

		txtMANAGER_PASS1.value = strMANAGER_PASS1 ;
		txtMANAGER_PASS2.value = strMANAGER_PASS2 ;
	}
	
	G_Load(dsPASS);
	
	var ret_msg = dsPASS.NameString(1,"RET_MSG");
	
	if ( ret_msg != "OK")
	{
		C_msgOk(ret_msg,"알림");
		return ;
	}		

	transCopy.Parameters = "ACT=COPY";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("담당자확인 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
	}
}

//담당자취소
function btnCASH_CANCEL_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
		
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
				cnt++;
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("선택된 자료가 없습니다.","확인")
		return;
	}	
	
	arrRtn2 = window.showModalDialog("t_PFBManagerconfR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{
		var	strMANAGER_PASS1 	= arrRtn2[1];
		var	strMANAGER_PASS2	= arrRtn2[2];

		txtMANAGER_PASS1.value = strMANAGER_PASS1 ;
		txtMANAGER_PASS2.value = strMANAGER_PASS2 ;
	}
	
	G_Load(dsPASS);
	
	var ret_msg = dsPASS.NameString(1,"RET_MSG");
	
	if ( ret_msg != "OK")
	{
		C_msgOk(ret_msg,"알림");
		return ;
	}			

	transCopy.Parameters = "ACT=COPY2";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("담당자취소 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
	}
}

//합계값setting
function SUM_SET_onblur()
{
 	var i = 0;
 	var dbSum_ALL = 0;
 	var dbSum_PAY = 0;
 	var dbSum_NON = 0;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		
			dbSum_ALL = dbSum_ALL + C_convSafeFloat(C_removeComma(dsMAIN.NameValue(i,"PAY_AMT"),false));
			
		  if (dsMAIN.NameString(i,"PAY_STATUS") == "4" )
		  {
				dbSum_PAY = dbSum_PAY + C_convSafeFloat(C_removeComma(dsMAIN.NameValue(i,"PAY_AMT"),false));
			}
			
			dbSum_NON = dbSum_ALL - dbSum_PAY ;
	}
	
	txtTOTAL_SUM.value = C_toNumberFormatString(dbSum_ALL,false);
	txtPAY_SUM.value = C_toNumberFormatString(dbSum_PAY,false);
	txtNOPAY_SUM.value = C_toNumberFormatString(dbSum_NON,false);
}

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN)
	{
		if(colid ==	"SELECT_YN")
		{

		}
	}
}
	
//출력
function btnCASH_PRINT_onClick()
{
	var		lnCnt = dsMAIN.CountRow;
	if(lnCnt == 0) return;
 
  var vDT_F   = txtDT_F.value.replace(/-/g,'');
  var vDT_T   = txtDT_T.value.replace(/-/g,'');
  var vDT_F1  = txtDT_F1.value.replace(/-/g,'');
  var vDT_T1  = txtDT_T1.value.replace(/-/g,'');  
 	var reportFile ="r_t_110005.rpt";
	var vcust_seq ;
	
	frmList.EXPORT_TAG.value ='W';
	frmList.RUN_TAG.value = '1';
	frmList.REQUEST_NAME.value = '현금출납확인리스트';
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile;
	
	var strTemp = "";
	if ( C_isNull(txtCUST_CODE.value) ) vcust_seq = '%';
	if ( C_isNull(vDT_F1) ) vDT_F1 = '1';
	if ( C_isNull(vDT_T1) ) vDT_T1 = '9';
	
	strTemp  = "P_COMP_CODE__" + txtCOMP_CODE.value;
	strTemp += "&&P_COMP_NAME__" + txtCOMP_NAME.value;
	strTemp += "&&P_PAY_GUBUN__" + txtPAY_GUBUN.value;
	strTemp += "&&P_PAY_STATUS__" + txtPAY_STATUS.value;
	strTemp += "&&P_DUE_DATE_F__" + vDT_F;
	strTemp += "&&P_DUE_DATE_T__" + vDT_T;
	strTemp += "&&P_CUST_SEQ__" + vcust_seq;
	strTemp += "&&P_PAY_DATE_F__" + vDT_F1;
	strTemp += "&&P_PAY_DATE_T__" + vDT_T1;
	strTemp += "&&P_PAY_METHOD__" + txtMETHOD_CODE.value;
	/*strTemp += "&&P_EMP_NO__" + sEmpNo;*/
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
function	btnSHOWSLIP_onClick()
{
	var pSLIP_ID        = dsSUB.NameString(dsSUB.RowPosition,"SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB.NameString(dsSUB.RowPosition,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsSUB.NameString(dsSUB.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSUB.NameString(dsSUB.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSUB.NameString(dsSUB.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSUB.NameString(dsSUB.RowPosition,"SLIP_KIND_TAG");
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