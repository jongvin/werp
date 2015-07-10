/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFinPayChkBillR.js(지급수표관리)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 지급수표관리
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			liInterval;
function Initialize()
{
	G_addDataSet(dsMAIN01, trans,  gridMAIN01, sSelectPageName+D_P1("ACT","MAIN01"), "미발행");
	G_addDataSet(dsMAIN02, null,  gridMAIN02, sSelectPageName+D_P1("ACT","MAIN02"), "발행");
	G_addDataSet(dsMAIN03, trans,  gridMAIN03, sSelectPageName+D_P1("ACT","MAIN03"), "견질어음");
    G_addDataSet(dsLOV, null, null, "", "LOV");




	//gridMAIN.focus();
	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtF_PUBL_DT.value = sDTF;
	txtE_PUBL_DT.value = sDTT;
	
	getCOMPANY_CODE();

	G_setLovCol(gridMAIN01,"CUST_CODE");
	G_setLovCol(gridMAIN01,"CUST_NAME");
	G_setLovCol(gridMAIN03,"CUST_CODE");
	G_setLovCol(gridMAIN03,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN01,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN03,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN03,"CHG_EXPR_DT");

	gridMAIN01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN01.TabToss = false;
	gridMAIN03.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN03.TabToss = false;

	selectTab(1,3);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN01)
	{
		var arrRtn = getCOMPANY_CODE();

		var		strCOMP_CODE 	= arrRtn[0];
		var		strBANK_CODE 	= arrRtn[1];
		var		strCHK_BILL_CLS = arrRtn[2];

		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN01")
										 + D_P2("COMP_CODE",strCOMP_CODE)
										 + D_P2("BANK_CODE",strBANK_CODE)
										 + D_P2("CHK_BILL_CLS",strCHK_BILL_CLS);
	}
	else if(dataset == dsMAIN02)
	{
		var arrRtn = getCOMPANY_CODE();

		var		strCOMP_CODE 	= arrRtn[0];
		var		strBANK_CODE 	= arrRtn[1];
		var		strCHK_BILL_CLS = arrRtn[2];
		var		strF_PUBL_DT = txtF_PUBL_DT.value;
		var		strE_PUBL_DT = txtE_PUBL_DT.value;

		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN02")
										 + D_P2("COMP_CODE",strCOMP_CODE)
										 + D_P2("BANK_CODE",strBANK_CODE)
										 + D_P2("PUBL_DT_F",strF_PUBL_DT)
										 + D_P2("PUBL_DT_T",strE_PUBL_DT)
										 + D_P2("CHK_BILL_CLS",strCHK_BILL_CLS);
	}
	else if(dataset == dsMAIN03)
	{
		var arrRtn = getCOMPANY_CODE();

		var		strCOMP_CODE 	= arrRtn[0];
		var		strBANK_CODE 	= arrRtn[1];
		var		strCHK_BILL_CLS = arrRtn[2];

		var		strF_PUBL_DT = txtF_PUBL_DT.value;
		var		strE_PUBL_DT = txtE_PUBL_DT.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN03")
										 + D_P2("COMP_CODE",strCOMP_CODE)
										 + D_P2("BANK_CODE",strBANK_CODE)
										 + D_P2("CHK_BILL_CLS",strCHK_BILL_CLS)
										 + D_P2("PUBL_DT_F",strF_PUBL_DT)
										 + D_P2("PUBL_DT_T",strE_PUBL_DT);
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
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("상단의 사업장을 선택하여 주십시오.");
		return false;
	}
	if(C_isNull(txtBANK_CODE.value))
	{
		C_msgOk("상단의 은행코드를 선택하여 주십시오.");
		return false;
	}
	if(!D_checkIsLoadedInternal(dsMAIN01)) return false;
	return true;
}
function	focusControl(grid)
{
	window.clearInterval(liInterval);
	grid.focus();
}
function	HideAllTabPage()
{
	divTabPage1.style.display = "none";
	divTabPage2.style.display = "none";
	divTabPage3.style.display = "none";
	divSBox3.style.display = "none";
	divInnerBox1.style.display ="none";
	divInnerBox2.style.display ="none";
}
function selectTab(index, totcount)
{
	// 탭페이지의 이미지 변환 공통함수
	if (!C_selectTab(index, totcount)) return;
	HideAllTabPage();
	switch (index)
	{
		case 1:
			divTabPage1.style.display = "";
			divInnerBox1.style.display ="";
			sTab = "1";
			liInterval = window.setInterval("focusControl(gridMAIN01)", 1);
			break;
		case 2:
			divTabPage2.style.display = "";
			divSBox3.style.display = "";
			divInnerBox2.style.display ="";
			sTab = "2";
			liInterval = window.setInterval("focusControl(gridMAIN02)", 1);
			break;
		case 3:
			divTabPage3.style.display = "";
			divSBox3.style.display = "";
			divInnerBox2.style.display ="";
			sTab = "3";
			liInterval = window.setInterval("focusControl(gridMAIN03)", 1);
			break;

	}
}


// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if (sTab =="3")
	{
		if(C_isNull(txtF_PUBL_DT.value || txtE_PUBL_DT.value))
		{
			C_msgOk("조회 기준일(발행일)을 입력하십시오.");
			return;
		}
		else if(txtF_PUBL_DT.value > txtE_PUBL_DT.value)
		{
			C_msgOk("조회 기준(발행일) 시작일이 종료일보다 클 수 없습니다.");
			return;
		}
	}
	D_defaultLoad();

}

// 추가
function btnadd_onclick()
{
	if(G_FocusDataset == dsMAIN03)
	{
		C_msgOk("견질수표는 추가하실 수 없습니다. 미발행 수표를 생성 후 견질발행을 선택하여 작업하십시오.");
		return;
	}
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN03)
	{
		C_msgOk("견질수표는 입력하실 수 없습니다. 미발행 수표를 생성 후 견질발행을 선택하여 작업하십시오.");
		return;
	}
	D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset == dsMAIN03)
	{
		C_msgOk("견질수표는 삭제하실 수 없습니다.");
		return;
	}
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
	if (asCalendarID == dsMAIN01.id+"."+"ACPT_DT")
	{
		dsMAIN01.NameString(dsMAIN01.RowPosition,"ACPT_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN01.id+"."+"PUBL_DT")
	{
		dsMAIN01.NameString(dsMAIN01.RowPosition,"PUBL_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN01.id+"."+"EXPR_DT")
	{
		dsMAIN01.NameString(dsMAIN01.RowPosition,"EXPR_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN01.id+"."+"CUST_DOUT_DT")
	{
		dsMAIN01.NameString(dsMAIN01.RowPosition,"CUST_DOUT_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN01.id+"."+"DUSE_DT")
	{
		dsMAIN01.NameString(dsMAIN01.RowPosition,"DUSE_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN01.id+"."+"RETURN_DT")
	{
		dsMAIN01.NameString(dsMAIN01.RowPosition,"RETURN_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN03.id+"."+"PUBL_DT")
	{
		dsMAIN03.NameString(dsMAIN03.RowPosition,"PUBL_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN03.id+"."+"EXPR_DT")
	{
		dsMAIN03.NameString(dsMAIN03.RowPosition,"EXPR_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN03.id+"."+"CUST_DOUT_DT")
	{
		dsMAIN03.NameString(dsMAIN03.RowPosition,"CUST_DOUT_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN03.id+"."+"COLL_DT")
	{
		dsMAIN03.NameString(dsMAIN03.RowPosition,"COLL_DT") = asDate;
	}
	else if (asCalendarID == "F_PUBL_DT")
	{
		txtF_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "E_PUBL_DT")
	{
		txtE_PUBL_DT.value = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN01)
	{
		if(!chkTopCondition()) return false;
		return true;
	}
	return false;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN01)
	{
		dataset.NameValue(row,"BANK_CODE") =   txtBANK_CODE.value;
		dataset.NameValue(row,"BANK_NAME") 	= txtBANK_NAME.value;
		dataset.NameValue(row,"COMP_CODE")   = txtCOMP_CODE.value;
		dataset.NameValue(row,"CHK_BILL_CLS")= hiCHK_BILL_CLS.value;
		dataset.NameString(row,"STAT_CLS")  = "1";		//미발행
	}
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
	if(dataset == dsMAIN01)
	{
		if(colid == "STAT_CLS")
		{
			var		lsColData = dataset.NameString(row,colid);
			if(lsColData == "3" || lsColData == "4")
			{
				dataset.NameString(row,"DUSE_DT")=sDTT;
			}
			else if(lsColData == "9" )
			{
				dataset.NameString(row,"RETURN_DT")=sDTT;
			}
			else if(lsColData == "0" )
			{
				dataset.NameString(row,"PUBL_DT")=sDTT;
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			searchCustCodeName(dataset,row,colid,COL_DATA);
		}
		else if(colid == "ACPT_DT"||colid == "PUBL_DT"||colid == "EXPR_DT"||colid == "CUST_DOUT_DT"||colid == "DUSE_DT"||colid == "RETURN_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	if (dataset == dsMAIN03)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			searchCustCodeName(dataset,row,colid,COL_DATA);
		}
		else if(colid == "PUBL_DT"||colid == "EXPR_DT"||colid == "CUST_DOUT_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(grid == gridMAIN01 && colid == "CUST_CODE")
	{
		searchCustCode(dsMAIN01);
	}
	if (dataset == dsMAIN01)
	{
		if(colid == "ACPT_DT"||colid == "PUBL_DT"||colid == "EXPR_DT"||colid == "CUST_DOUT_DT"||colid == "DUSE_DT"||colid == "RETURN_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}
	if (dataset == dsMAIN03)
	{
		if(colid == "CUST_CODE"||colid == "CUST_NAME")
		{
			searchCustCode(dsMAIN03);
		}
		if(colid == "PUBL_DT" || colid == "EXPR_DT" || colid == "CUST_DOUT_DT" || colid == "COLL_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}

}


// 이벤트관련-------------------------------------------------------------------//
function	searchCustCodeName(dataset,row,colid,COL_DATA)
{
	if(C_isNull(COL_DATA))
	{
		dataset.NameString(row,"CUST_SEQ") = "";
		dataset.NameString(row,"CUST_CODE") = "";
		dataset.NameString(row,"CUST_NAME") = "";
		return ;
	}
	else
	{
		var		lrArgs = new C_Dictionary();
		var		strCUST_CODE = COL_DATA.replace(/-/g, "");
		lrArgs.set("SEARCH_CONDITION", strCUST_CODE);
		var		lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1",lrArgs);
		if (lrRet != null)
		{
			dataset.NameString(row,"CUST_SEQ")	= lrRet.get("CUST_SEQ");
			dataset.NameString(row,"CUST_CODE")	= lrRet.get("CUST_CODE");
			dataset.NameString(row,"CUST_NAME")	= lrRet.get("CUST_NAME");
		}
		else
		{
			dataset.NameString(row,colid)	= olddata;
		}
	}
}

function	searchCustCode(dataset)
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");

	if(lrRet == null) return;

	dataset.NameString(dataset.RowPosition,"CUST_SEQ") = lrRet.get("CUST_SEQ");
	dataset.NameString(dataset.RowPosition,"CUST_CODE") = lrRet.get("CUST_CODE");
	dataset.NameString(dataset.RowPosition,"CUST_NAME") = lrRet.get("CUST_NAME");
}
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

	txtCOMP_CODE.value	  = lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value = lrRet.get("COMPANY_NAME");
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
	getCOMPANY_CODE();
	D_defaultLoad();
}
//은행코드검색
function txtBANK_CODE_onblur()
{
	if (C_isNull(txtBANK_CODE.value))
	{
		txtBANK_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BANK_CODE2", lrArgs,"T");	//당좌거래은행

	if (lrRet == null) return;

	txtBANK_CODE.value	= lrRet.get("BANK_CODE");
	txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	getCOMPANY_CODE();

}

function btnBANK_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_BANK_CODE2", lrArgs,"T");	//당좌거래은행

	if (lrRet == null) return;

	txtBANK_CODE.value	= lrRet.get("BANK_CODE");
	txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	getCOMPANY_CODE();

}
function getCOMPANY_CODE()
{
	var arrRec = new Array();

	arrRec[0] = txtCOMP_CODE.value;
	arrRec[1] = txtBANK_CODE.value;
	arrRec[2] = hiCHK_BILL_CLS.value;
	arrRec[3] = txtBANK_NAME.value;
	return 	arrRec;
}
//수표등록
function 	btnInsertPopup_onClick()
{
	if(!chkTopCondition()) return;

	var arrRtn = getCOMPANY_CODE();

	var		strCOMP_CODE  = arrRtn[0];
	var		strBANK_CODE  = arrRtn[1];
	var		strCHK_BILL_CLS  = arrRtn[2];
	var		strBANK_NAME = arrRtn[3];

	var arrRtn2 = null;

	arrRtn2 = window.showModalDialog("t_PFinPayCheckBillR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{

		var	strBANK_CODE 	= arrRtn2[1];
		var	strACPT_DT 		= arrRtn2[2];
		var	strCHK_BILL_NM 	= arrRtn2[3];
		var	strCHK_BILL_NO 	= arrRtn2[4];
		var	strCOUNT 		= arrRtn2[5];
		var	strBANK_NAME 	= arrRtn2[6];

		var count = 0;
		count = dsMAIN01.CountRow + 1;

		var strCHK_BILL_NO2 =  parseInt(strCHK_BILL_NO,10) + parseInt(strCOUNT,10);
		for (var i = strCHK_BILL_NO; i < strCHK_BILL_NO2; i++)
		{
			var stri = ""+i;
			var strzero ="";

			for(j=0;j<8-stri.length;j++) strzero+="0";

			var strBillNo = strCHK_BILL_NM+strzero+stri;//strCHK_BILL_NM+i;

			G_addRow(dsMAIN01);

			dsMAIN01.NameValue(count,"CHK_BILL_NO") = strBillNo;
			dsMAIN01.NameValue(count,"ACPT_DT") 	= strACPT_DT;

			count++;
		}
		gridMAIN01.focus();
	}
}

//대량삭제
function 	btnMultiDel_onClick()
{
	if(dsMAIN01.CountRow < 1)
	{
		C_msgOk("삭제할 자료가 없습니다.");
		return;
	}
	if(dsMAIN01.RowPosition < 1)
	{
		C_msgOk("삭제할 행을 선택하십시오.");
		return;
	}
	if(C_msgYesNo("정말 삭제하시겠습니까?", "삭제확인") == "N") return;
	G_MultiDeleteRow(dsMAIN01);
	gridMAIN01.focus();
}

function	btnF_PUBL_DT_onClick()
{
	C_Calendar("F_PUBL_DT", "D", txtF_PUBL_DT.value);
}
function	btnE_PUBL_DT_onClick()
{
	C_Calendar("E_PUBL_DT", "D", txtE_PUBL_DT.value);
}
