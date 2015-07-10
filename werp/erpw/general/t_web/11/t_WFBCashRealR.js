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
	G_addDataSet(dsBANK, null, null, sSelectPageName+D_P1("ACT","BANK"), "은행코드조회");	
  G_addDataSet(dsMSG, null, null, sSelectPageName+D_P1("ACT","MSG"), "결과메세지");	
	G_addDataSet(dsACCOUNT, null, null, sSelectPageName+D_P1("ACT","ACCOUNT"), "계좌번호조회");
	
	gridMAIN.focus();
	
	G_addRel(dsBANK,dsACCOUNT);
	G_addRelCol(dsACCOUNT,"CODE","BANK_CODE");

	G_Load(dsBANK);
	G_Load(dsACCOUNT);

  //document.all.btnRealTime_Send.disabled = true;
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
											+ D_P2("PAY_DUE_DATE",txtDT_F.value)
											+ D_P2("BANK_CODE",strBANK_CODE)
											+ D_P2("ACCNO_CODE",strACCNO_CODE)
											+ D_P2("PAY_STATUS",txtPAY_STATUS.value);
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
	else if(dataset == dsMSG)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MSG")
										 + D_P2("PAY_SEQ",txtPAY_SEQ.value);
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
//	D_defaultLoad();
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

				dsMAIN.NameString(i,"SELECT_YN") = "T";
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

				dsMAIN.NameString(i,"SELECT_YN") = "F";
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
  if ( (txtPAY_STATUS.value == "2")|| (txtPAY_STATUS.value == "5")|| (txtPAY_STATUS.value == "6"))
  {
			document.all.btnRealTime_Send.disabled = false;
	}
	else
  {
			document.all.btnRealTime_Send.disabled = true;
	}			
}

//이체송신
function btnRealTime_Send_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var totalcnt = 0;
 	var successcnt = 0;
 	var failcnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
	var msg;
	
	if(dsMAIN.CountRow==0) return;
	
	if ( dsMAIN.NameValueRow("SELECT_YN" ,"T") == 0 )
	{
			C_msgOk("선택된 자료가 없습니다.","확인");
			return ;
	}
	//암호확인
	arrRtn2 = window.showModalDialog("t_PFBEdiCreateR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

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

	G_Load(dsCOPY);
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.ClearData();
				dsCOPY.AddRow();
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
				transCopy.Parameters = "ACT=COPY";
				G_saveData(dsCOPY);
				txtPAY_SEQ.value = dsCOPY.NameString(cnt,"PAY_SEQ");
				G_Load(dsMSG);
				if  ( dsMSG.NameString(1,"STATUS")== '4' )
				{
					successcnt++;
				}					
				else
				{
					failcnt++;
				}		
				totalcnt++;
			}		
	}
	
	msg = '총건수 : ' + totalcnt + '건' + "<BR>" ;
	msg = msg + '성공건수 : ' + successcnt + '건' +  "<BR>" ;
	msg = msg + '실패건수 : ' + failcnt + '건' + "<BR>" ;
	msg = msg + '이체송신 작업이 완료되었습니다.';
	C_msgOk(msg,"알림");
	G_Load(dsMAIN);

}

//합계값setting
function SUM_SET_onblur()
{
 	var dbSum_ALL = dsMAIN.NameSum("PAY_AMT",0,0); 
 	var dbCnt_ALL = dsMAIN.CountRow;

	txtTOTAL_SUM.value = C_toNumberFormatString(dbSum_ALL,false); //총금액
	txtTOTAL_CNT.value = dbCnt_ALL;                               //총건수

	txtSELECT_SUM.value = 0 ;
	txtSELECT_CNT.value = 0 ;

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
