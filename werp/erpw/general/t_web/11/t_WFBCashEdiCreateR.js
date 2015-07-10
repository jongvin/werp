/**************************************************************************/
/* 1. 프 로 그 램 id : t_WEdiCreateR.jsp(현금이체파일생성)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 현금이체파일생성 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-23)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize() 
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "이체파일생성자료");
	G_addDataSet(dsSUB01, null, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "이체파일생성이력");
  G_addDataSet(dsBANK, null, null, sSelectPageName+D_P1("ACT","BANK"), "은행코드조회");	
	G_addDataSet(dsACCOUNT, null, null, sSelectPageName+D_P1("ACT","ACCOUNT"), "계좌번호조회");
	G_addDataSet(dsPASS, null, null, sSelectPageName+D_P1("ACT","PASS"), "암호확인");
	G_addDataSet(dsDateChk, null, null, sSelectPageName+D_P1("ACT","DateChk"), "날짜체크");
  G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "저장store");	
	
	gridMAIN.focus();
		
	G_addRel(dsBANK,dsACCOUNT);
	G_addRelCol(dsACCOUNT,"CODE","BANK_CODE");

	G_Load(dsBANK);
	G_Load(dsACCOUNT);
	
//	document.all.btnREC_SEND.disabled = true;
}
function OnLoadBefore(dataset)
{
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	var	strACCNO_CODE = dsACCOUNT.NameString(dsACCOUNT.RowPosition,"CODE");
	
	if(dataset == dsMAIN)
	{		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("PAY_GUBUN",txtPAY_GUBUN.value)
										 + D_P2("PAY_DUE_DATE",txtDT_F.value)
										 + D_P2("BANK_CODE",strBANK_CODE)
										 + D_P2("ACCNO_CODE",strACCNO_CODE);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("BANK_CODE",strBANK_CODE);
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
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}
	else if (dataset == dsDateChk)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DateChk")
											+ D_P2("DT_T",txtDT_T.value);
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
	//D_defaultLoad();
	G_Load(dsMAIN);
	G_Load(dsSUB01);
	SUM_SET_onblur()	
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
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
		
	  G_Load(dsDateChk);
	
		if ( dsDateChk.NameValue(1,"DAYS") > 10 ||dsDateChk.NameValue(1,"DAYS") < 0 )
		{
			txtDT_T.value = '' ;
			C_msgOk("예약일자는 현재일자를 기준으로 10일을 초과할수 없습니다.","알림");
			return;
		}	
	}	
}

function OnRowInsertBefore(dataset)
{
}
function OnRowInserted(dataset, row)
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
	
	txtSELECT_SUM.value = dbSum_ALL;
	txtSELECT_CNT.value = dbCnt_ALL;
}
//전체취소
function btnCANCEL_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
			dsMAIN.NameString(i,"SELECT_YN") = "F";
	}
	
	txtSELECT_SUM.value = 0;
	txtSELECT_CNT.value = 0;
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

	if ( dataset == dsMAIN )
	{
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
	else
	{
			if ( dsSUB01.NameString(row,"SELECT_YN") == 'T')
			{
				for (i=1;i<=dsSUB01.CountRow;i++) {
	
					  if (i != row )
					  {
							dsSUB01.NameString(i,"SELECT_YN") = 'F';
						}		
				}	
			}	
	}				
}
//이체파일생성
function 	btnEDI_CREATE_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	var	strACCNO_CODE = dsACCOUNT.NameString(dsACCOUNT.RowPosition,"CODE");
	
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	

	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
				dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
				dsCOPY.NameString(cnt,"PAY_GUBUN") = txtPAY_GUBUN.value;
				dsCOPY.NameString(cnt,"PAY_YMD") = txtDT_F.value;
				dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;
				dsCOPY.NameString(cnt,"ACCOUNT_NO") = strACCNO_CODE;
				cnt++;
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("선택된 자료가 없습니다.","확인");
		return;
	}	

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

  transCopy.Parameters = "ACT=COPY";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("이체파일생성 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
		G_Load(dsSUB01);
		SUM_SET_onblur()
	}
	
}
//이체파일삭제
function 	btnEDIDELETE_onClick()
{
 	var i = 0;
 	var cnt = 0;
	
	if(dsSUB01.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	
	for (i=1;i<=dsSUB01.CountRow;i++) {
		  if (dsSUB01.NameString(i,"SELECT_YN") == "T" )
		  {
				if (C_isNull(dsSUB01.NameString(i,"SEND_DATE")))
				{
					dsCOPY.AddRow()
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"PAY_SEQ") = dsSUB01.NameString(i,"EDI_HISTORY_SEQ");
					cnt++;
				}
			  else	
			  {	
					C_msgOk("해당자료는 삭제가 불가능 합니다.","에러");
				  dsSUB01.NameString(i,"SELECT_YN")= "F" ;
				  return;
				}
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("선택된 자료가 없습니다.","확인");
		return;
	}	

  transCopy.Parameters = "ACT=COPY2";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("이체파일삭제 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
		G_Load(dsSUB01);
		SUM_SET_onblur()	
	}
	
}
//이체파일송신
function 	btnEDISEND_onClick()
{
 	var i = 0;
 	var cnt = 0;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	
	if(dsSUB01.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	
	for (i=1;i<=dsSUB01.CountRow;i++) {
		  if (dsSUB01.NameString(i,"SELECT_YN") == "T" )
		  {
				if (C_isNull(dsSUB01.NameString(i,"SEND_DATE")))
				{
					dsCOPY.AddRow()
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"FILE_NAME") = dsSUB01.NameString(i,"SEND_FILE_NAME");
					dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
					dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;				
					dsCOPY.NameString(cnt,"PAY_SEQ") = dsSUB01.NameString(i,"EDI_HISTORY_SEQ");
					dsCOPY.NameString(cnt,"PAY_YMD") = dsSUB01.NameString(i,"STD_YMD");
					cnt++;
				}
			  else	
			  {	
					C_msgOk("해당자료는 이미 송신되었습니다.","에러");
				  dsSUB01.NameString(i,"SELECT_YN")= "F" ;
				  return;
				}
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("선택된 자료가 없습니다.","확인");
		return;
	}	

  transCopy.Parameters = "ACT=COPY3";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("이체파일송신 작업이 완료되었습니다.","알림");
		G_Load(dsSUB01);
	}
	
}
//처리결과수신
function 	btnRESULTRECV_onClick()
{
 	var i = 0;
 	var cnt = 0;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	
	if(dsSUB01.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
  dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;				

  transCopy.Parameters = "ACT=COPY4";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("처리결과수신 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
		G_Load(dsSUB01);
		SUM_SET_onblur()	
	}
	
}
//예약송신
function 	btnRECSEND_onClick()
{
 	var i = 0;
 	var cnt = 0;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	
	if(dsSUB01.CountRow==0) return;
	if ( C_isNull(txtDT_T.value))
	{
		C_msgOk("예약일자를 입력하세요.","확인");
		txtDT_T.focus
		return;
	}	
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
		
	for (i=1;i<=dsSUB01.CountRow;i++) {
		  if (dsSUB01.NameString(i,"SELECT_YN") == "T" )
		  {
				if (C_isNull(dsSUB01.NameString(i,"SEND_DATE")))
				{
					dsCOPY.AddRow()
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;				
					dsCOPY.NameString(cnt,"FILE_NAME") = dsSUB01.NameString(i,"SEND_FILE_NAME");
					dsCOPY.NameString(cnt,"PAY_SEQ")   = dsSUB01.NameString(i,"EDI_HISTORY_SEQ");
					dsCOPY.NameString(cnt,"PAY_YMD")   = txtDT_T.value;
					cnt++;
				}
			  else	
			  {	
					C_msgOk("해당자료는 이미 송신되었습니다.","에러");
				  dsSUB01.NameString(i,"SELECT_YN")= "F" ;
				  return;
				}
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("선택된 자료가 없습니다.","확인");
		return;
	}	

  transCopy.Parameters = "ACT=COPY5";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("예약송신 작업이 완료되었습니다.","알림");
		G_Load(dsSUB01);
	}
	
}
//버튼control
function 	btncontrol_onclick()
{
//	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
//	var strPAY_GUBUN = txtPAY_GUBUN.value ;
	
//	if ( strPAY_GUBUN == '4' && strBANK_CODE.value == '20' )
//	{
//		document.all.btnREC_SEND.disabled = false;
//	}		
//	else
//	{
//		document.all.btnREC_SEND.disabled = true;
//	}			
}
