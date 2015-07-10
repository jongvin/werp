/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFinPayChkBillR.js(지급어음관리)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 지급어음관리
/* 4. 변  경  이  력 : 한재원 작성(2005-12-01)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			liInterval;
function Initialize()
{
	G_addDataSet(dsMAIN01, trans,  gridMAIN01, sSelectPageName+D_P1("ACT","MAIN01"), "미발행");
	G_addDataSet(dsMAIN02, trans,  gridMAIN02, sSelectPageName+D_P1("ACT","MAIN02"), "발행");
	G_addDataSet(dsMAIN03, trans,  gridMAIN03, sSelectPageName+D_P1("ACT","MAIN03"), "견질어음");
	G_addDataSet(dsMAIN04, null,  gridMAIN04, sSelectPageName+D_P1("ACT","MAIN04"), "만기일");
	G_addDataSet(dsMAIN05, trans,  gridMAIN05, sSelectPageName+D_P1("ACT","MAIN05"), "어음명세");
	G_addDataSet(dsSETSLIP, null,  gridSETSLIP, sSelectPageName+D_P1("ACT","SETSLIP"), "설정반제내역");
	G_addDataSet(dsLIST05, trans,  gridLIST05, sSelectPageName+D_P1("ACT","LIST05"), "만기일변경내역");
	G_addDataSet(dsSEQ, null, null, null, "변경만기일");
    G_addDataSet(dsLOV, null, null, "", "LOV");

	G_addRel(dsMAIN02, dsSETSLIP);
	G_addRelCol(dsSETSLIP, "CHK_BILL_NO", "CHK_BILL_NO");

	G_addRel(dsMAIN05, dsLIST05);
	G_addRelCol(dsLIST05, "CHK_BILL_NO", "CHK_BILL_NO");
	
	getCOMPANY_CODE();

	G_setLovCol(gridMAIN01,"CUST_CODE");
	G_setLovCol(gridMAIN01,"CUST_NAME");
	G_setLovCol(gridMAIN03,"CUST_CODE");
	G_setLovCol(gridMAIN03,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN01,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN02,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN02,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN03,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN03,"CHG_EXPR_DT");
	G_setReadOnlyCol(gridMAIN04,"CUST_CODE");
	G_setReadOnlyCol(gridMAIN04,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN04,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN05,"ACPT_DT");
	G_setReadOnlyCol(gridMAIN05,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN05,"CUST_CODE");
	G_setReadOnlyCol(gridMAIN05,"BILL_KIND");
	G_setReadOnlyCol(gridMAIN05,"STAT_CLS");
	G_setReadOnlyCol(gridMAIN05,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN05,"CHG_EXPR_DT");
	G_setReadOnlyCol(gridMAIN05,"DUSE_DT");
	G_setReadOnlyCol(gridLIST05,"PRE_EXPR_DT");

	//gridMAIN.focus();
	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	txtF_PUBL_DT.value = sDTF;
	txtE_PUBL_DT.value = sDTT;
	txtF_EXPR_DT.value = sDTF;
	txtE_EXPR_DT.value = sDTT;
	txtACPT_DT_FROM.value = sDTF;
	txtACPT_DT_TO.value = sDTT;

	gridMAIN01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN01.TabToss = false;
	gridMAIN03.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN03.TabToss = false;
	gridLIST05.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridLIST05.TabToss = false;

	G_addDateCol(gridMAIN01,"PUBL_DT","D");
	G_addDateCol(gridMAIN01,"EXPR_DT","D");
	G_addDateCol(gridMAIN01,"CUST_DOUT_DT","D");
	G_addDateCol(gridMAIN01,"DUSE_DT","D");
	G_addDateCol(gridMAIN01,"RETURN_DT","D");
	G_addDateCol(gridMAIN01,"ACPT_DT","D");

	G_addDateCol(gridMAIN03,"PUBL_DT","D");
	G_addDateCol(gridMAIN03,"EXPR_DT","D");
	G_addDateCol(gridMAIN03,"CUST_DOUT_DT","D");

	G_addDateCol(gridMAIN05,"PUBL_DT","D");
	G_addDateCol(gridMAIN05,"EXPR_DT","D");
	G_addDateCol(gridMAIN05,"CUST_DOUT_DT","D");
	G_addDateCol(gridMAIN05,"COLL_DT","D");

	G_addDateCol(gridLIST05,"CHG_DT","D");
	G_addDateCol(gridLIST05,"CHG_EXPR_DT","D");


	selectTab(1,5);
}
function	focusControl(grid)
{
	window.clearInterval(liInterval);
	grid.focus();
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
	else if(dataset == dsMAIN04)
	{
		var arrRtn = getCOMPANY_CODE();

		var		strCOMP_CODE 	= arrRtn[0];
		var		strBANK_CODE 	= arrRtn[1];
		var		strCHK_BILL_CLS = arrRtn[2];

		var		strF_EXPR_DT = txtF_EXPR_DT.value;
		var		strE_EXPR_DT = txtE_EXPR_DT.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN04")
										 + D_P2("COMP_CODE",strCOMP_CODE)
										 + D_P2("BANK_CODE",strBANK_CODE)
										 + D_P2("CHK_BILL_CLS",strCHK_BILL_CLS)
										 + D_P2("F_EXPR_DT",strF_EXPR_DT)
										 + D_P2("E_EXPR_DT",strE_EXPR_DT);
	}
	else if(dataset == dsMAIN05)
	{
		var arrRtn = getCOMPANY_CODE();

		var		strCOMP_CODE 	= arrRtn[0];
		var		strBANK_CODE 	= arrRtn[1];
		var		strCHK_BILL_CLS = arrRtn[2];

		var		strACPT_DT_FROM 	= txtACPT_DT_FROM.value;
		var		strACPT_DT_TO 		= txtACPT_DT_TO.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN05")
										 + D_P2("COMP_CODE",strCOMP_CODE)
										 + D_P2("BANK_CODE",strBANK_CODE)
										 + D_P2("CHK_BILL_CLS",strCHK_BILL_CLS)
										 + D_P2("ACPT_DT_FROM",strACPT_DT_FROM)
										 + D_P2("ACPT_DT_TO",strACPT_DT_TO);
	}
	else if(dataset == dsSETSLIP)
	{
		var strCHK_BILL_NO  = dsMAIN02.NameString(dsMAIN02.RowPosition,"CHK_BILL_NO");
		dataset.DataID = sSelectPageName + D_P1("ACT","SETSLIP")
										 + D_P2("CHK_BILL_NO",strCHK_BILL_NO);
	}
	else if(dataset == dsLIST05)
	{
		var strCHK_BILL_NO 		= dsMAIN05.NameString(dsMAIN05.RowPosition,"CHK_BILL_NO");
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST05")
										 + D_P2("CHK_BILL_NO",strCHK_BILL_NO);
	}
	else	if (dataset == dsSEQ)
	{

		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");

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
function	HideAllTabPage()
{
	divTabPage1.style.display = "none";
	divTabPage2.style.display = "none";
	divTabPage3.style.display = "none";
	divTabPage4.style.display = "none";
	divTabPage5.style.display = "none";
	divSBox3.style.display = "none";
	divSBox4.style.display = "none";
	divSBox5.style.display = "none";
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
			//gridMAIN01.focus();
			liInterval = window.setInterval("focusControl(gridMAIN01)", 1);
			break;
		case 2:
			divTabPage2.style.display = "";
			divSBox3.style.display = "";
			divInnerBox2.style.display ="";
			sTab = "2";
			//gridMAIN02.focus();
			liInterval = window.setInterval("focusControl(gridMAIN02)", 1);
			break;
		case 3:
			divTabPage3.style.display = "";
			divSBox3.style.display = "";
			divInnerBox2.style.display ="";
			sTab = "3";
			//gridMAIN03.focus();
			liInterval = window.setInterval("focusControl(gridMAIN03)", 1);
			break;
		case 4:
			divTabPage4.style.display = "";
			divSBox4.style.display = "";
			divInnerBox2.style.display ="";
			sTab = "4";
			//gridMAIN04.focus();
			liInterval = window.setInterval("focusControl(gridMAIN04)", 1);
			break;
		case 5:
			divTabPage5.style.display = "";
			divTabPage1.style.display = "none";
			divTabPage3.style.display = "none";
			divTabPage4.style.display = "none";
			divTabPage2.style.display = "none";
			divSBox3.style.display = "none";
			divSBox4.style.display = "none";
			divSBox5.style.display = "";
			divInnerBox1.style.display ="none";
			divInnerBox2.style.display ="";
			sTab = "5";
			//gridMAIN05.focus();
			liInterval = window.setInterval("focusControl(gridMAIN05)", 1);
			break;

	}
}
function	getPreExprDate(row,dt)
{
	var			liUpperBound = parseInt(dt.replace(/-/g, ""));
	var			liLowerBound = 0;
	var			i;
	var			liCountRow = dsLIST05.CountRow;
	var			lsPreDt = dsMAIN05.NameString(dsMAIN05.RowPosition,"EXPR_DT");
	for(i = 1 ; i <= liCountRow ; ++ i)
	{
		if(i == row) continue;
		var		lsChdDt = dsLIST05.NameString(i,"CHG_DT");
		if(C_isNull(lsChdDt)) continue;
		var		liChgDt = parseInt(lsChdDt.replace(/-/g, ""));
		if(liChgDt > liUpperBound) continue;
		if(liChgDt > liLowerBound)
		{
			liLowerBound = liChgDt;
			lsPreDt = dsLIST05.NameString(i,"CHG_EXPR_DT");
		}
	}
	return lsPreDt;
}
function	setPreExprDate(row)
{
	if(dsLIST05.CountRow == 1)
	{
		dsLIST05.NameString(dsLIST05.RowPosition,"PRE_EXPR_DT") = dsMAIN05.NameString(dsMAIN05.RowPosition,"EXPR_DT");
		return;
	}
	if(C_isNull(dsLIST05.NameString(dsLIST05.RowPosition,"CHG_DT")))
	{
		dsLIST05.NameString(dsLIST05.RowPosition,"PRE_EXPR_DT") = getPreExprDate(row,"99999999");
		return;
	}
	else
	{
		dsLIST05.NameString(dsLIST05.RowPosition,"PRE_EXPR_DT") = getPreExprDate(row,dsLIST05.NameString(dsLIST05.RowPosition,"CHG_DT"));
		return;
	}
}
function	setLastExprDate()
{
	var			liLowerBound = 0;
	var			i;
	var			liCountRow = dsLIST05.CountRow;
	var			lsPreDt = "";
	if(liCountRow < 1)
	{
		dsMAIN05.NameString(dsMAIN05.RowPosition,"CHG_EXPR_DT") = "";
		return;
	}
	for(i = 1 ; i <= liCountRow ; ++ i)
	{
		var		lsChdDt = dsLIST05.NameString(i,"CHG_DT");
		if(C_isNull(lsChdDt)) continue;
		var		liChgDt = parseInt(lsChdDt.replace(/-/g, ""));
		if(liChgDt > liLowerBound)
		{
			liLowerBound = liChgDt;
			lsPreDt = dsLIST05.NameString(i,"CHG_EXPR_DT");
		}
	}
	dsMAIN05.NameString(dsMAIN05.RowPosition,"CHG_EXPR_DT") = lsPreDt;
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
	if (sTab =="4")
	{
		if(C_isNull(txtF_EXPR_DT.value || txtE_EXPR_DT.value))
		{
			C_msgOk("조회 기준일(만기일)을 입력하십시오.");
			return;
		}
		else if(txtF_EXPR_DT.value > txtE_EXPR_DT.value)
		{
			C_msgOk("조회 기준(만기일) 시작일이 종료일보다 클 수 없습니다.");
			return;
		}
	}
	if (sTab =="5")
	{
		if(C_isNull(txtACPT_DT_FROM.value || txtACPT_DT_TO.value))
		{
			C_msgOk("조회 기준일(수령일)을 입력하십시오.");
			return;
		}
		else if(txtACPT_DT_FROM.value > txtACPT_DT_TO.value)
		{
			C_msgOk("조회 기준(수령일) 시작일이 종료일보다 클 수 없습니다.");
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
		C_msgOk("견질어음은 추가하실 수 없습니다. 미발행 어음을 생성 후 견질발행을 선택하여 작업하십시오.");
		return;
	}
	if(G_FocusDataset == dsMAIN05)
	{
		C_msgOk("어음명세에서는 추가하실 수 없습니다. 미발행 어음을 생성 후 작업하십시오.");
		return;
	}
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN03)
	{
		C_msgOk("견질어음은 입력하실 수 없습니다. 미발행 어음을 생성 후 견질발행을 선택하여 작업하십시오.");
		return;
	}
	if(G_FocusDataset == dsMAIN05)
	{
		C_msgOk("어음명세에서는 입력하실 수 없습니다. 미발행 어음을 생성 후 작업하십시오.");
		return;
	}
	D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset == dsMAIN03)
	{
		C_msgOk("견질어음은 삭제하실 수 없습니다.");
		return;
	}
	if(G_FocusDataset == dsMAIN05)
	{
		C_msgOk("어음명세에서는 삭제하실 수 없습니다.");
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
	G_CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay);
	if (asCalendarID == dsLIST05.id+"."+"CHG_DT")
	{
		setPreExprDate(dsLIST05.RowPosition);
		setLastExprDate();
	}
	else if (asCalendarID == dsLIST05.id+"."+"CHG_EXPR_DT")
	{
		setLastExprDate();
	}
	else if (asCalendarID == "F_PUBL_DT")
	{
		txtF_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "E_PUBL_DT")
	{
		txtE_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "F_EXPR_DT")
	{
		txtF_EXPR_DT.value = asDate;
	}
	else if (asCalendarID == "E_EXPR_DT")
	{
		txtE_EXPR_DT.value = asDate;
	}
	else if (asCalendarID == "ACPT_DT_FROM")
	{
		txtACPT_DT_FROM.value = asDate;
	}
	else if (asCalendarID == "ACPT_DT_TO")
	{
		txtACPT_DT_TO.value = asDate;
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
		dataset.NameString(row,"BILL_KIND")  = sDfltBillKind;
		dataset.NameString(row,"STAT_CLS")  = "1";		//미발행
		dataset.NameString(row,"CHK_BILL_CLS") = "B";
	}
	else if(dataset == dsLIST05)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"CHG_SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"CHG_SEQ");
		dataset.NameString(row,"CHG_DT") = sDTT;
		
		setPreExprDate(row);
		setLastExprDate();
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
			searchCustCodeName(dataset,row,colid,COL_DATA, olddata);
		}
	}
	if (dataset == dsMAIN03)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			searchCustCodeName(dataset,row,colid,COL_DATA, olddata);
		}
	}

	if (dataset == dsLIST05)
	{
		var		COL_DATA;
		COL_DATA = dsLIST05.NameString(row,colid);
		if (colid == "CHG_DT")
		{
			setPreExprDate(row);
			setLastExprDate();
		}
		else	if (colid == "CHG_EXPR_DT")
		{
			setLastExprDate();
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{



	if(grid == gridMAIN01 && (colid == "CUST_CODE"||colid == "CUST_NAME" ))
	{
		searchCustCode(dsMAIN01);
	}
	if (dataset == dsMAIN01)
	{
	}
	if (dataset == dsMAIN03)
	{
		if(colid == "CUST_CODE"||colid == "CUST_NAME")
		{
			searchCustCode(dsMAIN03);
		}
	}
}


// 이벤트관련-------------------------------------------------------------------//
function	searchCustCodeName(dataset,row,colid,COL_DATA, olddata)
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
		var		lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1",lrArgs,"T");
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

	lrRet = C_LOV("T_CUST_CODE1", lrArgs);

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
	getCOMPANY_CODE();
	
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

	lrRet = C_AutoLov(dsLOV,"T_BANK_CODE3", lrArgs,"T"); //어음거래은행

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

	lrRet = C_LOV("T_BANK_CODE3", lrArgs,"T"); //어음거래은행

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
	arrRec[2] = 'B';
	arrRec[3] = txtBANK_NAME.value;
	return 	arrRec;
}
//어음등록
function 	btnInsertPopup_onClick()
{
	if(!chkTopCondition()) return;
	var arrRtn = getCOMPANY_CODE();
	
	var		strCOMP_CODE  = arrRtn[0];
	var		strBANK_CODE  = arrRtn[1];
	var		strCHK_BILL_CLS  = arrRtn[2];
	var		strBANK_NAME = arrRtn[3];

	if(C_isNull(strBANK_CODE))
	{
		C_msgOk("은행명을 입력하십시오.");
		return;
	}
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

			dsMAIN01.NameValue(dsMAIN01.RowPosition,"CHK_BILL_NO") = strBillNo;
			dsMAIN01.NameValue(dsMAIN01.RowPosition,"ACPT_DT") 	= strACPT_DT;
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
function	btnF_EXPR_DT_onClick()
{
	C_Calendar("F_EXPR_DT", "D", txtF_EXPR_DT.value);
}
function	btnE_EXPR_DT_onClick()
{
	C_Calendar("E_EXPR_DT", "D", txtE_EXPR_DT.value);
}
function	btnACPT_DT_FROM_onClick()
{
	C_Calendar("ACPT_DT_FROM", "D", txtACPT_DT_FROM.value);
}
function	btnACPT_DT_TO_onClick()
{
	C_Calendar("ACPT_DT_TO", "D", txtACPT_DT_TO.value);
}
