/**************************************************************************/
/* 1. 프 로 그 램 id : t_WAccCodeR.js(계정과목등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명
/* 4. 변  경  이  력 : 최언회 작성(2005-10-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "계정과목");
	G_addDataSet(dsACC_REMAIN_POSITION, null, null, null, "잔액위치");
	
	G_Load(dsACC_REMAIN_POSITION,null);
	gridMAIN.focus();
	
	//G_Load(dsMAIN,null);
}

function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
								+ D_P2("ACC_GRP",cboACC_GRP.value)
								+ D_P2("ACC_NAME",txtACC_NAME.value);
	}
	else if(dataset == dsACC_REMAIN_POSITION)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ACC_REMAIN_POSITION");
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
	D_defaultSave(dsMAIN);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}
//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check
	
       var  vACC_GRP = cboACC_GRP.value;
   	var reportFile ="";
	
   	reportFile ="r_t_000001";  
	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	
	if(vACC_GRP=='%')
	{
		vACC_GRP_NAME ='전체';	
	}
	else if(vACC_GRP=='1')
	{
		vACC_GRP_NAME ='자산';	
	}
	else if(vACC_GRP=='2')
	{
		vACC_GRP_NAME ='부채';	
	}
	else if(vACC_GRP=='3')
	{
		vACC_GRP_NAME ='자본';	
	}
	else if(vACC_GRP=='4')
	{
		vACC_GRP_NAME ='손익';	
	}
	else if(vACC_GRP=='5')
	{
		vACC_GRP_NAME ='원가';	
	}

	strTemp += "P_ACC_GRP__" + vACC_GRP;
	strTemp += "&&P_ACC_GRP_NAME__" + vACC_GRP_NAME;

	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnLoadCompleted(dataset, rowcnt)
{
	if (dataset == dsMAIN)
	{
		CboControl();
	}
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		dsMAIN.NameString(dsMAIN.RowPosition, 'COMPUTER_ACC')			= "10000000";
		dsAutoSetting();
	}
}
function	CanColumnPosChange(dataset, grid, row, colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "ACC_CODE")
		{
			var			strACC_CODE = dataset.NameString(row,colid);
			if(strACC_CODE.length != 9)
			{
				C_msgOk("계정코드는 9자리 입니다.","알림");
				return false;
			}
			else if (strACC_CODE == "000000000")
			{
				C_msgOk("계정코드로 (000000000) 을 사용할 수 없습니다.","알림");
				return false;
			}
		}
	}
	return true;
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
	if (dataset == dsMAIN)
	{
		if ((colid == "FUND_INPUT_CLS") && (dsMAIN.NameString(dsMAIN.RowPosition, 'FUND_INPUT_CLS') == "T"))
		{
			From_Initialize('F');
		}
		else if ((colid == "FUND_INPUT_CLS") && (dsMAIN.NameString(dsMAIN.RowPosition, 'FUND_INPUT_CLS') == "F"))
		{
			From_Initialize('T');
			dsAutoSetting();
		}
		else
		{
			CboControl();
			
			if (dsMAIN.NameString(dsMAIN.RowPosition, 'FUND_INPUT_CLS') == "T")
			{
				//잔액관리
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'ACC_REMAIN_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG') = "T";
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG') = "T";
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG_TG') = "T";
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG_TG') = "T";
				}
				
				//예산
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'BUDG_EXEC_CLS') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BUDG_MNG') = "T";
				}
				
				//거래처코드
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG') = "T";
				}
				else
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG_TG') = "F";
				}
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG_TG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG_TG') = "T";
				}
	
				//거래처명
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG_TG') = "F";
				}
				
				//은행코드
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG') = "F";
				}
				
				//계좌번호
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') = "T";
				}
				else
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG_TG') = "F";
				}
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG_TG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG') = "T";
				}
				
				//수표번호
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CHK_NO_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') = "T";
					dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG') = "T";
				}
				else
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CHK_NO_MNG_TG') = "F";
				}
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CHK_NO_MNG_TG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG') = "T";
					dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG_TG') = "T";
				}
				
				//어음번호
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_NO_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') = "T";
				}
				else
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_NO_MNG_TG') = "F";
				}
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_NO_MNG_TG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG') = "T";
				}
				
				//받을어음
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'REC_BILL_NO_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') = "T";
				}
				else
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'REC_BILL_NO_MNG_TG') = "F";
				}
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'REC_BILL_NO_MNG_TG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG') = "T";
				}
				
				//유가증권
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'SECU_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'SECU_MNG_TG') = "F";
				}
				
				//CP번호
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CP_NO_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') = "T";
				}
				else
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CP_NO_MNG_TG') = "F";
				}
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CP_NO_MNG_TG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG') = "T";
				}
				
				//차입금번호
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'LOAN_NO_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'LOAN_NO_MNG_TG') = "F";
				}
				
				//고정자산
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'FIXED_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'FIXED_MNG_TG') = "F";
				}
				
				//예적금
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'DEPOSIT_PAY_MNG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') = "T";
					dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG') = "T";
				}
				else
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'DEPOSIT_PAY_MNG_TG') = "F";
				}
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'DEPOSIT_PAY_MNG_TG') == "T")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG') = "T";
					dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG_TG') = "T";
				}
				
				//지급희망일
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'ANTICIPATION_DT_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'ANTICIPATION_DT_MNG_TG') = "F";
				}
				
				//사원번호
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'EMP_NO_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'EMP_NO_MNG_TG') = "F";
				}

				//카드번호
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'CARD_SEQ_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'CARD_SEQ_MNG_TG') = "F";
				}
				
				//대금지급조건
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'PAY_CON_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'PAY_CON_MNG_TG') = "F";
				}
				
				//대금어음만기일
				if (dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_EXPR_MNG') == "F")
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_EXPR_MNG_TG') = "F";
				}
				
				//관리항목1(문자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR1')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR1') = "F";
				}
				
				//관리항목2(문자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR2')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR2') = "F";
				}
				
				//관리항목3(문자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR3')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR3') = "F";
				}
				
				//관리항목4(문자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR4')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR4') = "F";
				}
				
				//관리항목1(숫자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM1')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM1') = "F";
				}
				
				//관리항목2(숫자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM2')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM2') = "F";
				}
				//관리항목3(숫자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM3')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM3') = "F";
				}
				
				//관리항목4(숫자)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM4')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM4') = "F";
				}
				
				//관리항목1(날짜)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT1')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT1') = "F";
				}
				
				//관리항목2(날짜)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT2')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT2') = "F";
				}
				
				//관리항목3(날짜)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT3')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT3') = "F";
				}
				
				//관리항목4(날짜)
				if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT4')))
				{
					dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT4') = "F";
				}
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid == "ACC_CODE")
		{
			var		strAccCode = dataset.NameString(row,colid);
			var		strAccCode11 = strAccCode.substr(0,1);
			var		strAccCode1 = strAccCode.substr(0,1) + "00000000";
			var		strAccCode2 = strAccCode.substr(0,2) + "0000000";
			var		strAccCode3 = strAccCode.substr(0,3) + "000000";
			var		strAccCode4 = strAccCode.substr(0,5) + "0000";
			var		strAccCode5 = strAccCode.substr(0,7) + "00";
			if(strAccCode.substr(1,8) == "00000000")
			{
				dsMAIN.NameString(row,"ACC_LVL") = "1";

				dsMAIN.NameString(row,"COMPUTER_ACC") = "000000000";
			}
			else if(strAccCode.substr(2,7) == "0000000")
			{
				dsMAIN.NameString(row,"ACC_LVL") = "2";


				for(i=1;i<=dsMAIN.CountRow;++i)
				{
					if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode1)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode1;
					}
				}

				if(dsMAIN.NameString(row,"COMPUTER_ACC") == "")
				{
					dsMAIN.NameString(row,"COMPUTER_ACC") = "000000000";
				}
			}
			else if(strAccCode.substr(3,6) == "000000")
			{
				dsMAIN.NameString(row,"ACC_LVL") = "3";


				for(i=1;i<=dsMAIN.CountRow;i++)
				{
					if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode2)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode2;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode1)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode1;
					}
				}

				if(dsMAIN.NameString(row,"COMPUTER_ACC") == "")
				{
					dsMAIN.NameString(row,"COMPUTER_ACC") = "000000000";
				}
			}
			else if(strAccCode.substr(5,4) == "0000")
			{
				dsMAIN.NameString(row,"ACC_LVL") = "4";


				for(i=1;i<=dsMAIN.CountRow;i++)
				{
					if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode3)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode3;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode2)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode2;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode1)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode1;
					}
				}

				if(dsMAIN.NameString(row,"COMPUTER_ACC") == "")
				{
					dsMAIN.NameString(row,"COMPUTER_ACC") = "000000000";
				}
			}
			else if(strAccCode.substr(7,2) == "00")
			{
				dsMAIN.NameString(row,"ACC_LVL") = "5";


				for(i=1;i<=dsMAIN.CountRow;i++)
				{
					if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode4)
					{

						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode4;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode3)
					{

						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode3;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode2)
					{

						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode2;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode1)
					{

						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode1;
					}
				}
				if(dsMAIN.NameString(row,"COMPUTER_ACC") == "")
				{
					dsMAIN.NameString(row,"COMPUTER_ACC") = "000000000";
				}
			}
			else
			{
				dsMAIN.NameString(row,"ACC_LVL") = "6";


				for(i=1;i<=dsMAIN.CountRow;i++)
				{
					if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode5)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode5;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode4)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode4;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode3)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode3;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode2)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode2;
					}
					else if(i != row && dsMAIN.NameString(i,"ACC_CODE") == strAccCode1)
					{
						dsMAIN.NameString(row,"COMPUTER_ACC") = strAccCode1;
					}
				}
				if(dsMAIN.NameString(row,"COMPUTER_ACC") == "")
				{
					dsMAIN.NameString(row,"COMPUTER_ACC") = "000000000";
				}
			}
			
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
}

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsMAIN)
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition, 'FUND_INPUT_CLS') == "T")
		{
			From_Initialize("F");
		}
		else
		{
			From_Initialize("T");
		}
	}
}

function From_Initialize(asFromTG)
{
	if(asFromTG == "T")
	{
		D_Div_ReadOnly(divFreeForm, true);
		CboControl();
	}
	else
	{
		D_Div_ReadOnly(divFreeForm, false);
		CboControl();
	}
}

function CboControl()
{
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG') == "F")
	{
		document.all.cboCUST_CODE_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboCUST_CODE_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG') == "F")
	{
		document.all.cboCUST_NAME_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboCUST_NAME_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG') == "F")
	{
		document.all.cboBANK_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboBANK_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG') == "F")
	{
		document.all.cboACCNO_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboACCNO_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'CHK_NO_MNG') == "F")
	{
		document.all.cboCHK_NO_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboCHK_NO_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_NO_MNG') == "F")
	{
		document.all.cboBILL_NO_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboBILL_NO_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'REC_BILL_NO_MNG') == "F")
	{
		document.all.cboREC_BILL_NO_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboREC_BILL_NO_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'SECU_MNG') == "F")
	{
		document.all.cboSECU_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboSECU_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'CP_NO_MNG') == "F")
	{
		document.all.cboCP_NO_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboCP_NO_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'LOAN_NO_MNG') == "F")
	{
		document.all.cboLOAN_NO_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboLOAN_NO_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'FIXED_MNG') == "F")
	{
		document.all.cboFIXED_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboFIXED_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'DEPOSIT_PAY_MNG') == "F")
	{
		document.all.cboDEPOSIT_PAY_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboDEPOSIT_PAY_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'ANTICIPATION_DT_MNG') == "F")
	{
		document.all.cboANTICIPATION_DT_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboANTICIPATION_DT_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'EMP_NO_MNG') == "F")
	{
		document.all.cboEMP_NO_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboEMP_NO_MNG_TG.disabled	= false;
	}

	if (dsMAIN.NameString(dsMAIN.RowPosition, 'CARD_SEQ_MNG') == "F")
	{
		document.all.cboCARD_SEQ_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboCARD_SEQ_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'PAY_CON_MNG') == "F")
	{
		document.all.cboPAY_CON_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboPAY_CON_MNG_TG.disabled	= false;
	}
	
	if (dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_EXPR_MNG') == "F")
	{
		document.all.cboBILL_EXPR_MNG_TG.disabled	= true;
	}
	else
	{
		document.all.cboBILL_EXPR_MNG_TG.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR1')))
	{
		document.all.cboMNG_TG_CHAR1.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_CHAR1.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR2')))
	{
		document.all.cboMNG_TG_CHAR2.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_CHAR2.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR3')))
	{
		document.all.cboMNG_TG_CHAR3.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_CHAR3.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR4')))
	{
		document.all.cboMNG_TG_CHAR4.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_CHAR4.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM1')))
	{
		document.all.cboMNG_TG_NUM1.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_NUM1.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM2')))
	{
		document.all.cboMNG_TG_NUM2.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_NUM2.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM3')))
	{
		document.all.cboMNG_TG_NUM3.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_NUM3.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM4')))
	{
		document.all.cboMNG_TG_NUM4.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_NUM4.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT1')))
	{
		document.all.cboMNG_TG_DT1.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_DT1.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT2')))
	{
		document.all.cboMNG_TG_DT2.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_DT2.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT3')))
	{
		document.all.cboMNG_TG_DT3.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_DT3.disabled	= false;
	}
	
	if (C_isNull(dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT4')))
	{
		document.all.cboMNG_TG_DT4.disabled	= true;
	}
	else
	{
		document.all.cboMNG_TG_DT4.disabled	= false;
	}
}

function dsAutoSetting()
{
	dsMAIN.NameString(dsMAIN.RowPosition, 'FUND_INPUT_CLS')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'PRINT_SHEET_TAG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'ACC_REMAIN_MNG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BUDG_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BUDG_EXEC_CLS')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'SUMMARY_CLS')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CHK_NO_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_NO_MNG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'REC_BILL_NO_MNG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'SECU_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CP_NO_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'LOAN_NO_MNG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'FIXED_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'DEPOSIT_PAY_MNG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'ANTICIPATION_DT_MNG')	= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'EMP_NO_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CARD_SEQ_MNG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'PAY_CON_MNG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_EXPR_MNG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR1')         = "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR2')         = "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR3')         = "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_CHAR4')         = "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM1')			= "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM2')			= "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM3')			= "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_NUM4')			= "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT1')			= "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT2')			= "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT3')			= "";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_NAME_DT4')			= "";
	
	dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_CODE_MNG_TG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CUST_NAME_MNG_TG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BANK_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'ACCNO_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CHK_NO_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_NO_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'REC_BILL_NO_MNG_TG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CP_NO_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'SECU_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'LOAN_NO_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'FIXED_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'DEPOSIT_PAY_MNG_TG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'PAY_CON_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'BILL_EXPR_MNG_TG')		= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'ANTICIPATION_DT_MNG_TG')	= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'EMP_NO_MNG_TG')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'CARD_SEQ_MNG_TG')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR1')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR2')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR3')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_CHAR4')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM1')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM2')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM3')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_NUM4')			= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT1')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT2')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT3')				= "F";
	dsMAIN.NameString(dsMAIN.RowPosition, 'MNG_TG_DT4')				= "F";
}

// 이벤트관련-------------------------------------------------------------------//
//출력
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}

