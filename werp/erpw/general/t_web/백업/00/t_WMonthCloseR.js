/**************************************************************************/
/* 1. 프 로 그 램 id : t_WMonthCloseR.js(마감등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "메인데이타셑");
	G_addDataSet(dsLIST, trans, gridLIST, sSelectPageName+D_P1("ACT","LIST"), "서브데이타셑");
	G_addDataSet(dsCLSE_ACC_ID, null, null, sSelectPageName+D_P1("ACT","CLSE_ACC_ID"), "회기년도");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_Load(dsCLSE_ACC_ID);
	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "COMP_CODE", "COMP_CODE");
	G_addRelCol(dsLIST, "CLSE_MONTH", "CLSE_MONTH");
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsCLSE_ACC_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CLSE_ACC_ID")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
	}
	else if(dataset == dsMAIN)
	{
	 
		var strCLSE_ACC_ID = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID"); 
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN") 
		               					 + D_P2("COMP_CODE",txtCOMP_CODE.value)
					   					 + D_P2("CLSE_ACC_ID",strCLSE_ACC_ID);
		
	}
	else if(dataset == dsLIST)
	{
		var strCLSE_ACC_ID = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID"); 
		
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("CLSE_ACC_ID",strCLSE_ACC_ID)
										 + D_P2("CLSE_MONTH",dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_MONTH"));
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

// 공통 재정의 이벤트관련-------------------------------------------------------//
function OnLoadCompleted(dataset, rowcnt)
{
		
}

function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		
		var startYMD = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"ACCOUNT_FDT");
		var endYMD 	 = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"ACCOUNT_EDT");
		var maxYMD 	 = "";
		
		if(dsMAIN.CountRow ==1)
		{
			maxYMD  = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID");
		}
		if(dsMAIN.CountRow >1)
		{
			maxYMD 	 = dsMAIN.Max(3,1,0);
		}
		
		if(maxYMD>=endYMD.substring(0,6))
		{
			C_msgOk("회기 내의 모든 년월이 모두 등록되었습니다", "확인");
			dsMAIN.deleteRow(dsMAIN.RowPosition);
			dsMAIN.RowPosition=1;
			return;
		}
	
		var curYYYYMM = "";
		if((dsMAIN.CountRow<1)){
			curYYYYMM = startYMD.substring(0,6);
		} 
		else 
		{
			var maxYYYY = (maxYMD.substring(0,4));
			var maxMM = (maxYMD.substring(4,6));
	
			maxMM++;
			if(maxMM>12){
				maxYYYY++;
				maxMM = 1;
				curYYYYMM = ""+maxYYYY+"0"+maxMM;
			} else if(maxMM>9){
				curYYYYMM = ""+maxYYYY+""+maxMM;
			} else {
				curYYYYMM = ""+maxYYYY+"0"+maxMM;
			}
		}
	
		dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_MONTH") = curYYYYMM;
		dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_CLS") = 'F';
		dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"COMP_CODE");
		dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID") = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID");
		
		ListRowInsert();
	}
		
}
function OnSetFocus(dataset, grid)
{
	if (grid == gridLIST)
	{
		parent.main_title.div_u.style.visibility = "hidden";
		parent.main_title.div_s.style.visibility = "visible";
	}
	else if (grid == gridMAIN)
	{
		parent.main_title.div_u.style.visibility ="visible";
		parent.main_title.div_s.style.visibility ="hidden";
	}
}
function OnRowDeleteBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dsLIST.ClearData();	
	}
	return true;
}

function OnColumnChanged(dataset, row, colid)
{
	if (dataset == dsMAIN)
	{
		
		if (colid == 'CLSE_CLS') 
		{
			//신청마감
			if(dsMAIN.NameString(row,colid) == "T")
			{
				//신청마감일자는 오늘일자로 세팅
				dsMAIN.NameString(row,"CLSE_DT") = vDate;
			} else {
				//신청마감일자를 지움
				dsMAIN.NameString(row,"CLSE_DT") = "";
			}
		}
	}
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
	if (!C_isNull(txtCOMP_CODE.value))
	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	G_Load(dsCLSE_ACC_ID);
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
	G_Load(dsCLSE_ACC_ID);

}

function ListRowInsert()
{
				
	var vClseMonth = dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_MONTH");
	var vClseYear  = vClseMonth.substring(0,4);
	var vClseM	   = vClseMonth.substring(4,6);		
	var vLastDay = C_getEndDay(vClseMonth);
	for(i=1;i<=vLastDay;i++)
	{
		G_addRow(dsLIST);
		if(i<10)
			dsLIST.NameString(dsLIST.RowPosition,"CLSE_DAY") = vClseYear+"-" +vClseM +"-0"+i;
		else
			dsLIST.NameString(dsLIST.RowPosition,"CLSE_DAY") = vClseYear+"-" +vClseM+"-"+i;
	
		dsLIST.NameString(dsLIST.RowPosition,"CLSE_CLS") = "F";
		dsLIST.NameString(dsLIST.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
		dsLIST.NameString(dsLIST.RowPosition,"CLSE_ACC_ID") = dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID");
		dsLIST.NameString(dsLIST.RowPosition,"CLSE_MONTH") = dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_MONTH");
	}

}