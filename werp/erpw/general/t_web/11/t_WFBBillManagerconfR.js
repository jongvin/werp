/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCashPay01.js(현금지급승인확인)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-20)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "현금승인");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "저장store");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsPASS, null, null, sSelectPageName+D_P1("ACT","PASS"), "암호확인");
	
	document.all.btnCASH_CONFIRM.disabled = false;
	document.all.btnCASH_CANCEL.disabled = true;	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("PAY_GUBUN",txtPAY_GUBUN.value)
											+ D_P2("PAY_STATUS",txtPAY_STATUS.value)
											+ D_P2("BANK_CODE",txtBANK_CODE.value)
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("CUST_CODE",txtCUST_SEQ.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
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
 	var dbSum_ALL = dsMAIN.NameSum("PAY_AMT",0,0); 
 	var dbCnt_ALL = dsMAIN.CountRow;	
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if ((dsMAIN.NameString(i,"PAY_STATUS") == "1" )||(dsMAIN.NameString(i,"PAY_STATUS") == "2" ))
		  {
				dsMAIN.NameString(i,"SELECT_YN") = "T";
			}		
	}
	
	if ( txtPAY_STATUS.value == "1" || txtPAY_STATUS.value == "2" )
	{	
		txtSELECT_SUM.value = dbSum_ALL;
		txtSELECT_CNT.value = dbCnt_ALL;
	}	
}

//전체취소
function btnCANCEL_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if ((dsMAIN.NameString(i,"PAY_STATUS") == "1" )||(dsMAIN.NameString(i,"PAY_STATUS") == "2" ))
		  {
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}		
	}
	
	if ( txtPAY_STATUS.value == "1" || txtPAY_STATUS.value == "2" )
	{	
		txtSELECT_SUM.value = 0;
		txtSELECT_CNT.value = 0;
	}		
}

//버튼 control
function button_status_onblur()
{
  if (txtPAY_STATUS.value == "1")
  {
			document.all.btnCASH_CONFIRM.disabled = false;
	    document.all.btnCASH_CANCEL.disabled = true;	
	}
	else if (txtPAY_STATUS.value == "2")
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

//팀장승인
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

	arrRtn2 = window.showModalDialog("t_PFBBillManagerconfR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

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
		C_msgOk("팀장승인 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
	}
}

//팀장승인취소
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

	arrRtn2 = window.showModalDialog("t_PFBBillManagerconfR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

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
		C_msgOk("팀장승인취소 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
	}
}

//합계값setting
function SUM_SET_onblur()
{
 	var dbSum_ALL = dsMAIN.NameSum("PAY_AMT",0,0); 
 	var dbCnt_ALL = dsMAIN.CountRow;

	txtTOTAL_SUM.value = C_toNumberFormatString(dbSum_ALL,false); //총금액
	txtTOTAL_CNT.value = dbCnt_ALL;                               //총건수
	
	txtPAY_SUM.value = 0 ;
	txtPAY_CNT.value = 0 ;
	txtNOPAY_SUM.value = 0 ;
	txtNOPAY_CNT.value = 0 ;
	txtSELECT_SUM.value = 0 ;
	txtSELECT_CNT.value = 0 ;
	
	if (txtPAY_STATUS.value != '1')
	{
		txtPAY_SUM.value = C_toNumberFormatString(dbSum_ALL,false);	//승인완료금액
		txtPAY_CNT.value = dbCnt_ALL;                               //승인건수
	}
	
	if (txtPAY_STATUS.value == '1')
	{
		txtNOPAY_SUM.value = C_toNumberFormatString(dbSum_ALL,false);//미승인금액
		txtNOPAY_CNT.value = dbCnt_ALL;                              //미승인건수
	}
}

function OnColumnChanged(dataset, row, colid)
{
	var dbSum_SELECT = C_convSafeFloat(C_removeComma(txtSELECT_SUM.value,false),false);
	var dbCnt_SELECT = C_convSafeFloat(txtSELECT_CNT.value,false);	

	if(colid ==	"SELECT_YN")
	{
		if ( dsMAIN.NameString(row,"SELECT_YN")== 'T' )
		{
			 txtSELECT_SUM.value = dbSum_SELECT +  dsMAIN.NameValue(row,"PAY_AMT");
			 txtSELECT_CNT.value = dbCnt_SELECT + 1 ;
		}	 
		else
		{	
			 txtSELECT_SUM.value = dbSum_SELECT - dsMAIN.NameValue(row,"PAY_AMT");
			 txtSELECT_CNT.value = dbCnt_SELECT - 1 ;				 
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
 	var reportFile ="r_t_110008.rpt";
	var vcust_seq ;
	
	frmList.EXPORT_TAG.value ='W';
	frmList.RUN_TAG.value = '1';
	frmList.REQUEST_NAME.value = '전자어음승인리스트';
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile;
	
	var strTemp = "";
	if ( C_isNull(txtCUST_CODE.value) ) vcust_seq = '%';
	
	strTemp  = "P_COMP_CODE__" + txtCOMP_CODE.value;
	strTemp += "&&P_COMP_NAME__" + txtCOMP_NAME.value;
	strTemp += "&&P_PAY_GUBUN__" + txtPAY_GUBUN.value;
	strTemp += "&&P_PAY_STATUS__" + txtPAY_STATUS.value;
	strTemp += "&&P_DUE_DATE_F__" + vDT_F;
	strTemp += "&&P_DUE_DATE_T__" + vDT_T;
	strTemp += "&&P_CUST_SEQ__" + vcust_seq;
	strTemp += "&&P_OUT_BANK__" + txtBANK_CODE.value;
	/*strTemp += "&&P_EMP_NO__" + sEmpNo;*/
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}