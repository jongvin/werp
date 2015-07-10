/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFinProcessPayR.js(대금지급관리)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 대금지급관리
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-13) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sTARGET_SLIP_ID = "";
var			sTARGET_SLIP_IDSEQ = "";
var			sACCNO_CLS = "";
var			sSLIP_ID = "";
var			sSLIP_IDSEQ = "";
var			liInterval;
function Initialize()
{
	G_addDataSet(dsMASTER, trans,  gridMASTER, sSelectPageName+D_P1("ACT","MASTER"), "대금지급목록");
	G_addDataSet(dsDETAIL, trans,  gridDETAIL, sSelectPageName+D_P1("ACT","DETAIL"), "전표발행목록");
	G_addDataSet(dsMAIN, trans,  gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "대금지급대상");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "예금목록");
	G_addDataSet(dsSUB02, trans,  gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "구매카드목록");
	G_addDataSet(dsSUB03, trans,  gridSUB03, sSelectPageName+D_P1("ACT","SUB03"), "실물어음목록");
	G_addDataSet(dsSUB04, trans,  gridSUB04, sSelectPageName+D_P1("ACT","SUB04"), "현금목록");
	G_addDataSet(dsSUB05, trans,  gridSUB05, sSelectPageName+D_P1("ACT","SUB05"), "전체목록");
	G_addDataSet(dsSEQ, null,  null, sSelectPageName+D_P1("ACT","LOAN_REFUND_SEQ"), "상환내역순번");

	G_addDataSet(dsMAKE, transMAKE,  null, sSelectPageName+D_P1("ACT","MAKE"), "대금지급생성");
	G_addDataSet(dsREMOVE, transREMOVE,  null, sSelectPageName+D_P1("ACT","REMOVE"), "전표삭제");
	
	G_addDataSet(dsMAKE_SLIP_INFO, transMAKE_SLIP,  null, sSelectPageName+D_P1("ACT","MAKE_SLIP_INFO"), "전표생성대상목록");
	G_addDataSet(dsMAKE_SLIP, transMAKE_SLIP,  null, sSelectPageName+D_P1("ACT","MAKE_SLIP"), "전표생성");

	G_addDataSet(dsMAKE_PAY_INFO, transMAKE_PAY,  null, sSelectPageName+D_P1("ACT","MAKE_PAY_INFO"), "FBS자료생성대상목록");
	G_addDataSet(dsMAKE_PAY, transMAKE_PAY,  null, sSelectPageName+D_P1("ACT","MAKE_PAY"), "FBS자료생성");

    G_addDataSet(dsLOV, null, null, "", "LOV");
    G_addDataSet(dsCUST_ACC, null, null, "", "CUST_ACC");
    G_addDataSet(dsSLIP_INFO, null, null, "", "SLIP_INFO");
    G_addDataSet(dsACC_INFO, null, null, "", "SLIP_INFO");
    
	
    

	txtF_PUBL_DT.value = sDTF;
	txtE_PUBL_DT.value = sDTT;


	G_addRel(dsMASTER,dsMAIN);
	G_addRelCol(dsMAIN,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsMAIN,"WORK_DT","WORK_DT");

	G_addRel(dsMASTER,dsDETAIL);
	G_addRelCol(dsDETAIL,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsDETAIL,"WORK_DT","WORK_DT");

	G_addRel(dsMASTER,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"WORK_DT","WORK_DT");

	G_addRel(dsMASTER,dsSUB02);
	G_addRelCol(dsSUB02,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB02,"WORK_DT","WORK_DT");

	G_addRel(dsMASTER,dsSUB03);
	G_addRelCol(dsSUB03,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB03,"WORK_DT","WORK_DT");

	G_addRel(dsMASTER,dsSUB04);
	G_addRelCol(dsSUB04,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB04,"WORK_DT","WORK_DT");

	G_addRel(dsMASTER,dsSUB05);
	G_addRelCol(dsSUB05,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB05,"WORK_DT","WORK_DT");

	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	G_setReadOnlyCol(gridMAIN,"CUST_CODE");
	G_setReadOnlyCol(gridMAIN,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN,"ACC_KIND_NAME");
	G_setReadOnlyCol(gridMAIN,"ACC_NAME");
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridMAIN,"SET_AMT");
	G_setReadOnlyCol(gridMAIN,"PRE_RESET_AMT");
	G_setReadOnlyCol(gridMAIN,"REMAIN_AMT");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"N_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"SLIP_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"N_SLIP_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"SUMMARY");
	
	G_setReadOnlyCol(gridDETAIL,"MAKE_SLIPNO");

	G_setReadOnlyCol(gridSUB01,"CUST_CODE");
	G_setReadOnlyCol(gridSUB01,"CUST_NAME");
	G_setReadOnlyCol(gridSUB01,"ACC_KIND_NAME");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME");
	G_setReadOnlyCol(gridSUB01,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB01,"PAY_MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB01,"SUMMARY");

	G_setLovCol(gridSUB01,"IN_ACC_NO");

	G_setReadOnlyCol(gridSUB02,"CUST_CODE");
	G_setReadOnlyCol(gridSUB02,"CUST_NAME");
	G_setReadOnlyCol(gridSUB02,"ACC_KIND_NAME");
	G_setReadOnlyCol(gridSUB02,"ACC_NAME");
	G_setReadOnlyCol(gridSUB02,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB02,"PAY_MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB02,"SUMMARY");

	G_setLovCol(gridSUB02,"IN_ACC_NO");

	G_setReadOnlyCol(gridSUB03,"CUST_CODE");
	G_setReadOnlyCol(gridSUB03,"CUST_NAME");
	G_setReadOnlyCol(gridSUB03,"ACC_KIND_NAME");
	G_setReadOnlyCol(gridSUB03,"ACC_NAME");
	G_setReadOnlyCol(gridSUB03,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB03,"PAY_MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB03,"SUMMARY");

	G_setLovCol(gridSUB03,"CHK_BILL_NO");

	G_setReadOnlyCol(gridSUB04,"CUST_CODE");
	G_setReadOnlyCol(gridSUB04,"CUST_NAME");
	G_setReadOnlyCol(gridSUB04,"ACC_KIND_NAME");
	G_setReadOnlyCol(gridSUB04,"ACC_NAME");
	G_setReadOnlyCol(gridSUB04,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB04,"PAY_MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB04,"SUMMARY");


	G_setReadOnlyCol(gridSUB05,"CUST_CODE");
	G_setReadOnlyCol(gridSUB05,"CUST_NAME");
	G_setReadOnlyCol(gridSUB05,"ACC_KIND_NAME");
	G_setReadOnlyCol(gridSUB05,"ACC_NAME");
	G_setReadOnlyCol(gridSUB05,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB05,"PAY_MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB05,"EXEC_AMT");
	G_setReadOnlyCol(gridSUB05,"OUT_ACC_NO");
	G_setReadOnlyCol(gridSUB05,"IN_ACC_NO");
	G_setReadOnlyCol(gridSUB05,"IN_BANK_MAIN_CODE");
	G_setReadOnlyCol(gridSUB05,"ACCNO_OWNER");
	G_setReadOnlyCol(gridSUB05,"SUMMARY");
	G_setReadOnlyCol(gridSUB05,"CHK_BILL_NO");
	G_setReadOnlyCol(gridSUB05,"EXEC_KIND_TAG_NM");


	gridMASTER.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;
	gridSUB02.RejectEnterkeyOnPopupStyle = true;
	gridSUB03.RejectEnterkeyOnPopupStyle = true;
	gridSUB04.RejectEnterkeyOnPopupStyle = true;
	gridSUB05.RejectEnterkeyOnPopupStyle = true;

//	selectTab(1,5);
	chkMatchAccNo.checked = true;
	
	gridMASTER.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMASTER)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MASTER")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("WORK_DT_F",txtF_PUBL_DT.value)
										 + D_P2("WORK_DT_T",txtE_PUBL_DT.value);
	}
	else if(dataset == dsMAIN)
	{
		var	sWORK_DT = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
		if(C_isNull(sWORK_DT))
		{
			sWORK_DT = "0000-01-01";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
										 + D_P2("ACC_KIND_CODE",cboSUM_ACC_GROUP.value)
										 + D_P2("WORK_DT",sWORK_DT);
	}
	else if(dataset == dsDETAIL)
	{
		var	sWORK_DT = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
		if(C_isNull(sWORK_DT))
		{
			sWORK_DT = "0000-01-01";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","DETAIL")
										 + D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
										 + D_P2("WORK_DT",sWORK_DT);
	}
	else if(dataset == dsSUB01)
	{
		var	sWORK_DT = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
		if(C_isNull(sWORK_DT))
		{
			sWORK_DT = "0000-01-01";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
										 + D_P2("ACC_KIND_CODE",cboSUM_ACC_GROUP.value)
										 + D_P2("WORK_DT",sWORK_DT);
	}
	else if(dataset == dsSUB02)
	{
		var	sWORK_DT = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
		if(C_isNull(sWORK_DT))
		{
			sWORK_DT = "0000-01-01";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
										 + D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
										 + D_P2("ACC_KIND_CODE",cboSUM_ACC_GROUP.value)
										 + D_P2("WORK_DT",sWORK_DT);
	}
	else if(dataset == dsSUB03)
	{
		var	sWORK_DT = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
		if(C_isNull(sWORK_DT))
		{
			sWORK_DT = "0000-01-01";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB03")
										 + D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
										 + D_P2("ACC_KIND_CODE",cboSUM_ACC_GROUP.value)
										 + D_P2("WORK_DT",sWORK_DT);
	}
	else if(dataset == dsSUB04)
	{
		var	sWORK_DT = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
		if(C_isNull(sWORK_DT))
		{
			sWORK_DT = "0000-01-01";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB04")
										 + D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
										 + D_P2("ACC_KIND_CODE",cboSUM_ACC_GROUP.value)
										 + D_P2("WORK_DT",sWORK_DT);
	}
	else if(dataset == dsSUB05)
	{
		var	sWORK_DT = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
		if(C_isNull(sWORK_DT))
		{
			sWORK_DT = "0000-01-01";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB05")
										 + D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
										 + D_P2("ACC_KIND_CODE",cboSUM_ACC_GROUP.value)
										 + D_P2("WORK_DT",sWORK_DT);
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
	}
	else if(dataset == dsMAKE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE");
	}
	else if(dataset == dsCUST_ACC)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CUST_ACC")
										 + D_P2("SLIP_ID",sTARGET_SLIP_ID)
										 + D_P2("SLIP_IDSEQ",sTARGET_SLIP_IDSEQ)
										 + D_P2("ACCNO_CLS",sACCNO_CLS);
	}
	else if(dataset == dsACC_INFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ACC_INFO")
										 + D_P2("SLIP_ID",sTARGET_SLIP_ID)
										 + D_P2("SLIP_IDSEQ",sTARGET_SLIP_IDSEQ);
	}
	else if(dataset == dsSLIP_INFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_INFO")
										 + D_P2("SLIP_ID",sSLIP_ID)
										 + D_P2("SLIP_IDSEQ",sSLIP_IDSEQ);
	}
	else if(dataset == dsMAKE_SLIP_INFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE_SLIP_INFO");
	}
	else if(dataset == dsMAKE_SLIP)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE_SLIP");
	}
	else if(dataset == dsMAKE_PAY_INFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE_PAY_INFO");
	}
	else if(dataset == dsMAKE_PAY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE_PAY");
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REMOVE");
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
function	focusControl(grid)
{
	window.clearInterval(liInterval);
	grid.focus();
}
function	RemoveSlip(slip_id,slip_idseq)
{
	if(!chkTopCondition()) return;
	if(dsMASTER.RowPosition < 1)
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(C_isNull(dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT" )))
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsREMOVE);
	dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_DT") = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
	dsREMOVE.NameString(dsREMOVE.RowPosition,"SLIP_ID") = slip_id;
	dsREMOVE.NameString(dsREMOVE.RowPosition,"SLIP_IDSEQ") = slip_idseq;
	transREMOVE.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("지급전표가 정상적으로 삭제되었습니다.");
	G_Load(dsMAIN);
	G_Load(dsDETAIL);
	G_Load(dsSUB01);
	G_Load(dsSUB02);
	G_Load(dsSUB03);
	G_Load(dsSUB04);
	G_Load(dsSUB05);
}
function	RetrieveSlipInfo(slip_id,slip_idseq)
{
	sSLIP_ID = slip_id;
	sSLIP_IDSEQ = slip_idseq;
	G_Load(dsSLIP_INFO);
}
function	GetPayConExprDt(slip_id,slip_idseq)
{
	RetrieveSlipInfo(slip_id,slip_idseq);
	return dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"PAY_CON_EXPR_DT");
}
function	copyToMakeSlipInfo(dataset,row)
{
	G_addRow(dsMAKE_SLIP_INFO);
	for(var i = 1 ; i <= dsMAKE_SLIP_INFO.CountColumn ; i ++)
	{
		dsMAKE_SLIP_INFO.NameString(dsMAKE_SLIP_INFO.RowPosition,dsMAKE_SLIP_INFO.ColumnID(i)) = 
					dataset.NameString(row,dsMAKE_SLIP_INFO.ColumnID(i));
	}
}
function	copyToMakePayInfo(dataset,row)
{
	G_addRow(dsMAKE_PAY_INFO);
	for(var i = 1 ; i <= dsMAKE_PAY_INFO.CountColumn ; i ++)
	{
		dsMAKE_PAY_INFO.NameString(dsMAKE_PAY_INFO.RowPosition,dsMAKE_PAY_INFO.ColumnID(i)) = 
					dataset.NameString(row,dsMAKE_PAY_INFO.ColumnID(i));
	}
}
function	makeSlipCore(dataset)
{
	if(!chkTopCondition()) return;
	if(dsMASTER.RowPosition < 1)
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(C_isNull(dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT" )))
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsMAKE_SLIP_INFO);
	G_Load(dsMAKE_SLIP);
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"WORK_DT") = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"CRTUSERNO") = sEmpNo;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"DEPT_CODE") = sDeptCode;
	var			lnCnt = dataset.CountRow;
	for(i = 1 ; i <= lnCnt ; ++ i)
	{
		if(dataset.NameString(i,"CHK_TAG") == "T")
		{
			if(!C_isNull(dataset.NameString(i,"SLIP_ID")))
			{
				//C_msgOk("이미 전표가 발행된 행을 다시 전표를 발행하려 하였습니다.");
				//dataset.RowPosition = i;
				//return;
				continue;
			}
			copyToMakeSlipInfo(dataset,i);
		}
	}
	if(dsMAKE_SLIP_INFO.CountRow < 1)
	{
		C_msgOk("전표를 발행할 내용이 없습니다.");
		return;
	}
	transMAKE_SLIP.Parameters = "ACT=MAKE_SLIP";
	if(!G_saveData(dsMAKE_SLIP))return;
	C_msgOk("지급전표가 정상적으로 생성되었습니다.");
	G_Load(dsMAIN);
	G_Load(dataset);
	if(dataset == dsSUB05)
	{
	}
	else
	{
		G_Load(dsSUB05);
	}
	G_Load(dsDETAIL);
}

function	updateConfirm()
{
	if (dsMASTER.IsUpdated || G_isChanged(dsMASTER.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMASTER)) return false;
		}
		else if(ret == "N")
		{
			return false;
		}
	}
	return true;
}

function	chkTopCondition()
{
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("상단의 사업장을 선택하여 주십시오.");
		return false;
	}
	return true;
}
function	setDefaultCustAccNo(dataset,accno_cls)
{
	sTARGET_SLIP_ID = dataset.NameString(dataset.RowPosition,"TARGET_SLIP_ID");
	sTARGET_SLIP_IDSEQ = dataset.NameString(dataset.RowPosition,"TARGET_SLIP_IDSEQ");
	sACCNO_CLS = accno_cls;
	G_Load(dsCUST_ACC);
	if(dsCUST_ACC.CountRow > 0)
	{
		dataset.NameString(dataset.RowPosition,"IN_BANK_MAIN_CODE") = dsCUST_ACC.NameString(1,"BANK_MAIN_CODE");
		dataset.NameString(dataset.RowPosition,"IN_ACC_NO") = dsCUST_ACC.NameString(1,"ACCNO");
		dataset.NameString(dataset.RowPosition,"ACCNO_OWNER") = dsCUST_ACC.NameString(1,"ACCNO_OWNER");
	}
}

function	chkNullDatasetColumn(aDataset,aColumnName)
{
	return C_isNull(aDataset.NameString(aDataset.RowPosition,aColumnName));
}
function	chkMainColumnNull(aColumnName)
{
	return chkNullDatasetColumn(dsMAIN,aColumnName);
}
function	HideAllTabPage()
{
	divTabPage1.style.display = "none";
	divTabPage2.style.display = "none";
	divTabPage3.style.display = "none";
	divTabPage4.style.display = "none";
	divTabPage5.style.display = "none";
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
			sTab = "1";
			liInterval = window.setInterval("focusControl(gridSUB01)", 1);
			break;
		case 2:
			divTabPage2.style.display = "";
			sTab = "2";
			liInterval = window.setInterval("focusControl(gridSUB02)", 1);
			break;
		case 3:
			divTabPage3.style.display = "";
			sTab = "3";
			liInterval = window.setInterval("focusControl(gridSUB03)", 1);
			break;
		case 4:
			divTabPage4.style.display = "";
			sTab = "4";
			liInterval = window.setInterval("focusControl(gridSUB04)", 1);
			break;
		case 5:
			divTabPage5.style.display = "";
			sTab = "5";
			liInterval = window.setInterval("focusControl(gridSUB05)", 1);
			break;

	}
}


// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();

}

// 추가
function btnadd_onclick()
{
	if(G_FocusDataset == dsMAIN) return;
	if(G_FocusDataset == dsSUB01) return;
	if(G_FocusDataset == dsSUB02) return;
	if(G_FocusDataset == dsSUB03) return;
	if(G_FocusDataset == dsSUB04) return;
	if(G_FocusDataset == dsSUB05) return;
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN) return;
	if(G_FocusDataset == dsSUB01) return;
	if(G_FocusDataset == dsSUB02) return;
	if(G_FocusDataset == dsSUB03) return;
	if(G_FocusDataset == dsSUB04) return;
	if(G_FocusDataset == dsSUB05) return;
	D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset == dsMAIN) return;
	if(G_FocusDataset == dsSUB01) return;
	if(G_FocusDataset == dsSUB02) return;
	if(G_FocusDataset == dsSUB03) return;
	if(G_FocusDataset == dsSUB04) return;
	if(G_FocusDataset == dsSUB05) return;
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
	if (asCalendarID == "F_PUBL_DT")
	{
		txtF_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "E_PUBL_DT")
	{
		txtE_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "WORK_DT")
	{
		dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT") = asDate;
	}
	else if (asCalendarID == "dsSUB02.EXPR_DT")
	{
		dsSUB02.NameString(dsSUB02.RowPosition,"EXPR_DT") = asDate;
	}
	else if (asCalendarID == "dsSUB03.EXPR_DT")
	{
		dsSUB03.NameString(dsSUB03.RowPosition,"EXPR_DT") = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		return false;
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMASTER)
	{
		dataset.NameValue(row,"COMP_CODE")   = txtCOMP_CODE.value;
		dataset.NameValue(row,"WORK_DT")   = vDATE;
	}
	if(dataset == dsSUB01)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
	}
	if(dataset == dsSUB02)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
	}
	if(dataset == dsSUB03)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
	}
	if(dataset == dsSUB04)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
	}
	if(dataset == dsSUB05)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
	}
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		return false;
	}
	else if(dataset == dsSUB01)
	{
		if(dataset.RowPosition < 1) return true;
		if(!C_isNull(dataset.NameString(dataset.RowPosition,"PAY_MAKE_SLIPNO")))
		{
			C_msgOk("전표가 발행된 것은 삭제가 불가능합니다.");
			return false;
		}
	}
	else if(dataset == dsSUB02)
	{
		if(dataset.RowPosition < 1) return true;
		if(!C_isNull(dataset.NameString(dataset.RowPosition,"PAY_MAKE_SLIPNO")))
		{
			C_msgOk("전표가 발행된 것은 삭제가 불가능합니다.");
			return false;
		}
	}
	else if(dataset == dsSUB03)
	{
		if(dataset.RowPosition < 1) return true;
		if(!C_isNull(dataset.NameString(dataset.RowPosition,"PAY_MAKE_SLIPNO")))
		{
			C_msgOk("전표가 발행된 것은 삭제가 불가능합니다.");
			return false;
		}
	}
	else if(dataset == dsSUB04)
	{
		if(dataset.RowPosition < 1) return true;
		if(!C_isNull(dataset.NameString(dataset.RowPosition,"PAY_MAKE_SLIPNO")))
		{
			C_msgOk("전표가 발행된 것은 삭제가 불가능합니다.");
			return false;
		}
	}
	else if(dataset == dsSUB05)
	{
		if(dataset.RowPosition < 1) return true;
		if(!C_isNull(dataset.NameString(dataset.RowPosition,"PAY_MAKE_SLIPNO")))
		{
			C_msgOk("전표가 발행된 것은 삭제가 불가능합니다.");
			return false;
		}
	}
	else if(dataset == dsMASTER)
	{
		dsMAIN.ClearData();
	}
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
}
function	AutoPopAccNo(dataset, grid, row, colid, olddata,tag)
{
	sTARGET_SLIP_ID = dataset.NameString(row,"TARGET_SLIP_ID");
	sTARGET_SLIP_IDSEQ = dataset.NameString(row,"TARGET_SLIP_IDSEQ");
	G_Load(dsACC_INFO);
	COL_DATA = dataset.NameString(row,colid);
	var		lsTag = dsACC_INFO.NameString(dsACC_INFO.RowPosition,"PAY_TAR_TAG");
	if(lsTag == "2" || lsTag == "3")		//사원 경비 사원 법인카드
	{
		var		lrArgs = new C_Dictionary();
		lrArgs.set("EMP_NO", dsACC_INFO.NameString(dsACC_INFO.RowPosition,"EMP_NO"));
		var		lrRet = C_AutoLov(dsLOV,"T_EMP_ACCNO_CODE",lrArgs,"T");
		if (lrRet != null)
		{
			dataset.NameString(row,"IN_BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dataset.NameString(row,"IN_ACC_NO")	= lrRet.get("ACCNO");
			dataset.NameString(row,"ACCNO_OWNER")	= lrRet.get("ACCNO_OWNER");
		}
		else
		{
			dataset.NameString(row,colid)	= COL_DATA;
		}
	}
	else
	{
		var		lrArgs = new C_Dictionary();
		lrArgs.set("CUST_SEQ", dataset.NameString(row,"CUST_SEQ"));
		lrArgs.set("ACCNO_CLS", tag);
		lrArgs.set("SEARCH_CONDITION", COL_DATA);
		var		lrRet = C_AutoLov(dsLOV,"T_CUST_ACCNO_CODE",lrArgs,"T");
		if (lrRet != null)
		{
			dataset.NameString(row,"IN_BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dataset.NameString(row,"IN_ACC_NO")	= lrRet.get("ACCNO");
			dataset.NameString(row,"ACCNO_OWNER")	= lrRet.get("ACCNO_OWNER");
		}
		else
		{
			dataset.NameString(row,colid)	= COL_DATA;
		}
	}
}
function	PopAccNo(dataset, grid, row, colid, data,tag)
{
	sTARGET_SLIP_ID = dataset.NameString(row,"TARGET_SLIP_ID");
	sTARGET_SLIP_IDSEQ = dataset.NameString(row,"TARGET_SLIP_IDSEQ");
	G_Load(dsACC_INFO);
	COL_DATA = dataset.NameString(row,colid);
	var		lsTag = dsACC_INFO.NameString(dsACC_INFO.RowPosition,"PAY_TAR_TAG");

	if(lsTag == "2" || lsTag == "3")		//사원 경비 사원 법인카드
	{
		var		lrArgs = new C_Dictionary();
		lrArgs.set("EMP_NO", dsACC_INFO.NameString(dsACC_INFO.RowPosition,"EMP_NO"));
		var		lrRet = C_LOV("T_EMP_ACCNO_CODE",lrArgs,"F");
		if (lrRet != null)
		{
			dataset.NameString(row,"IN_BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dataset.NameString(row,"IN_ACC_NO")	= lrRet.get("ACCNO");
			dataset.NameString(row,"ACCNO_OWNER")	= lrRet.get("ACCNO_OWNER");
		}
	}
	else
	{
		var		lrArgs = new C_Dictionary();
		lrArgs.set("CUST_SEQ", dataset.NameString(row,"CUST_SEQ"));
		lrArgs.set("ACCNO_CLS", tag);
		lrArgs.set("SEARCH_CONDITION", "");
		var		lrRet = C_LOV("T_CUST_ACCNO_CODE",lrArgs,"F");
		if (lrRet != null)
		{
			dataset.NameString(row,"IN_BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dataset.NameString(row,"IN_ACC_NO")	= lrRet.get("ACCNO");
			dataset.NameString(row,"ACCNO_OWNER")	= lrRet.get("ACCNO_OWNER");
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	if (dataset == dsMASTER)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "WORK_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "IN_ACC_NO")
		{
			AutoPopAccNo(dataset, grid, row, colid, olddata,"1");
		}
	}
	else if(dataset == dsSUB02)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "IN_ACC_NO")
		{
			AutoPopAccNo(dataset, grid, row, colid, olddata,"3");
		}
		else if(colid == "EXPR_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB03)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CHK_BILL_NO")
		{
			var		lrArgs = new C_Dictionary();
			lrArgs.set("COMP_CODE", dataset.NameString(row,"COMP_CODE"));
			lrArgs.set("ACCNO", dataset.NameString(row,"OUT_ACC_NO"));
			lrArgs.set("SEARCH_CONDITION", "");
			var		lrRet = C_AutoLov(dsLOV,"T_BILL_NO_FIN",lrArgs,"T");
			if (lrRet != null)
			{
				dataset.NameString(row,"CHK_BILL_NO")	= lrRet.get("CHK_BILL_NO");
			}
			else
			{
				dataset.NameString(row,colid)	= COL_DATA;
			}
		}
		else if(colid == "EXPR_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMASTER)
	{
		if(colid == "WORK_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "IN_ACC_NO")
		{
			PopAccNo(dataset, grid, row, colid, data,"1");
		}
	}
	else if(dataset == dsSUB02)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "IN_ACC_NO")
		{
			PopAccNo(dataset, grid, row, colid, data,"3");	//구매카드
		}
		else if(colid == "EXPR_DT")
		{
			C_Calendar(dataset.id + "." + colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB03)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CHK_BILL_NO")
		{
			var		lrArgs = new C_Dictionary();
			lrArgs.set("COMP_CODE", dataset.NameString(row,"COMP_CODE"));
			lrArgs.set("ACCNO", dataset.NameString(row,"OUT_ACC_NO"));
			lrArgs.set("SEARCH_CONDITION", "");
			var		lrRet = C_LOV("T_BILL_NO_FIN",lrArgs,"F");
			if (lrRet != null)
			{
				dataset.NameString(row,"CHK_BILL_NO")	= lrRet.get("CHK_BILL_NO");
			}
		}
		else if(colid == "EXPR_DT")
		{
			C_Calendar(dataset.id + "." + colid, "D", dataset.NameString(row,colid));
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
	D_defaultLoad();
}

function	btnMakeDestList_onClick()
{
	if(!chkTopCondition()) return;
	if(dsMASTER.RowPosition < 1)
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(C_isNull(dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT" )))
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsMAKE);
	dsMAKE.NameString(dsMAKE.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsMAKE.NameString(dsMAKE.RowPosition,"WORK_DT") = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
	
	transMAKE.Parameters = "ACT=MAKE";
	if(!G_saveData(dsMAKE))return;
	C_msgOk("대금지급 대상이 정상적으로 생성되었습니다.");
	G_Load(dsMAIN);
}
function	btnF_PUBL_DT_onClick()
{
	C_Calendar("F_PUBL_DT", "D", txtF_PUBL_DT.value);
}
function	btnE_PUBL_DT_onClick()
{
	C_Calendar("E_PUBL_DT", "D", txtE_PUBL_DT.value);
}
function	cboSUM_ACC_GROUP_onChange()
{
	updateConfirm();
	G_Load(dsMAIN);
	G_Load(dsSUB01);
	G_Load(dsSUB02);
	G_Load(dsSUB03);
	G_Load(dsSUB04);
	G_Load(dsSUB05);
}
function	SelectAllClick(dataset)
{
	var			lnCnt = dataset.CountRow;
	if(lnCnt < 1) return;
	var			sCHK = dataset.NameString(1,"CHK_TAG") == "F" ? "T":"F";
	for(i = 1 ; i <= lnCnt ; ++i)
	{
		dataset.NameString(i,"CHK_TAG") = sCHK;
	}
}
function	btnSelectAll1_onClick()
{
	SelectAllClick(dsMAIN);
}
function	btnShowListSlip_onClick()
{
		var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_SLIP_ID");
		var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowPaySlip_onClick()
{
		var pSLIP_ID        = dsDETAIL.NameString(dsDETAIL.RowPosition,"SLIP_ID");
		var pSLIP_IDSEQ     = dsDETAIL.NameString(dsDETAIL.RowPosition,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsDETAIL.NameString(dsDETAIL.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsDETAIL.NameString(dsDETAIL.RowPosition,"MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsDETAIL.NameString(dsDETAIL.RowPosition,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsDETAIL.NameString(dsDETAIL.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowListSlipR1_onClick()
{
		var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"TARGET_SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"TARGET_SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowListSlipP1_onClick()
{
		var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB01.NameString(dsSUB01.RowPosition,"PAY_MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB01.NameString(dsSUB01.RowPosition,"PAY_MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB01.NameString(dsSUB01.RowPosition,"PAY_MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB01.NameString(dsSUB01.RowPosition,"PAY_SLIP_KIND_TAG");
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
function	btnSelectAllC1_onClick()
{
	SelectAllClick(dsSUB01);
}
function	cboACCNO1_onChange()
{
}
function	btnSet1_onClick()
{
	var			lnCnt = dsMAIN.CountRow;
	if(lnCnt < 1) return;
	for(i = 1 ; i <= lnCnt ; ++i)
	{
		if(dsMAIN.NameString(i,"CHK_TAG") == "T")
		{
			var		lfSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"SET_AMT"));
			var		lfReSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"PRE_RESET_AMT"));
			var		lfExceptAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXCEPT_AMT"));
			var		lfPreExecAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXEC_AMT"));
			var		lfCash = C_convSafeFloat(dsMAIN.NameString(i,"C_RATIO"));
			var		lfBill = C_convSafeFloat(dsMAIN.NameString(i,"B_RATIO"));
			var		lfAssignAmt = lfSetAmt - lfReSetAmt - lfExceptAmt;
			if(lfAssignAmt - lfPreExecAmt <= 0 ) continue;
			if(lfCash == 0 ) continue;
			if(lfCash + lfBill == 0 ) continue;
			lfAssignAmt = Math.round(lfAssignAmt * lfCash / (lfCash + lfBill));
			if(lfAssignAmt == 0 ) continue;
			var Row = dsSUB01.NameValueRow("TARGET_SLIP_IDSEQ",dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ"));
			if(Row > 0) continue;
			G_addRow(dsSUB01);
			dsSUB01.NameString(dsSUB01.RowPosition,"EXEC_KIND_TAG") = "1";
			dsSUB01.NameString(dsSUB01.RowPosition,"TARGET_SLIP_ID") = dsMAIN.NameString(i,"TARGET_SLIP_ID");
			dsSUB01.NameString(dsSUB01.RowPosition,"TARGET_SLIP_IDSEQ") = dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ");
			dsSUB01.NameString(dsSUB01.RowPosition,"EXEC_AMT") = lfAssignAmt;
			dsSUB01.NameString(dsSUB01.RowPosition,"OUT_ACC_NO") = cboACCNO1.value;
			dsSUB01.NameString(dsSUB01.RowPosition,"CUST_CODE") = dsMAIN.NameString(i,"CUST_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"CUST_NAME") = dsMAIN.NameString(i,"CUST_NAME");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SLIPNO") = dsMAIN.NameString(i,"MAKE_SLIPNO");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_COMP_CODE") = dsMAIN.NameString(i,"MAKE_COMP_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DT_TRANS") = dsMAIN.NameString(i,"MAKE_DT_TRANS");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SEQ") = dsMAIN.NameString(i,"MAKE_SEQ");
			dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_KIND_TAG") = dsMAIN.NameString(i,"SLIP_KIND_TAG");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_NAME") = dsMAIN.NameString(i,"ACC_NAME");
			dsSUB01.NameString(dsSUB01.RowPosition,"SUMMARY") = dsMAIN.NameString(i,"SUMMARY");
			dsSUB01.NameString(dsSUB01.RowPosition,"CUST_SEQ") = dsMAIN.NameString(i,"CUST_SEQ");
			dsSUB01.NameString(dsSUB01.RowPosition,"CHK_TAG") = "F";
			setDefaultCustAccNo(dsSUB01,"1");
		}
	}
	if(!G_saveAllData(dsSUB01)) return;
	G_Load(dsSUB01);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnRemove1_onClick()
{
	var			lnCnt = dsSUB01.CountRow;
	if(lnCnt < 1) return;
	for(i = lnCnt ; i >= 1 ; --i)
	{
		if(dsSUB01.NameString(i,"CHK_TAG") == "T")
		{
			if(!C_isNull(dsSUB01.NameString(i,"PAY_MAKE_SLIPNO")))
			{
				C_msgOk("이미 전표가 발행된 자료는 내역에서 제거가 불가능합니다.");
				dsSUB01.RowPosition = i;
				return;
			}
			G_deleteRow(dsSUB01);
		}
	}
	if(!G_saveAllData(dsSUB01)) return;
	G_Load(dsSUB01);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnMakeSlip1_onClick()
{
	makeSlipCore(dsSUB01);
}
function	btnRemoveSlip1_onClick()
{
	var			dataset = dsSUB01;
	if(dataset.RowPosition < 1)
	{
		C_msgOk("먼저 삭제할 전표가 있는 행을 선택하여 주십시오.");
		return;
	}
	if(C_isNull(dataset.NameString(dataset.RowPosition,"SLIP_ID")))
	{
		C_msgOk("해당행의 자료는 전표가 생성된 자료가 아닙니다.");
		return;
	}
	RemoveSlip(dataset.NameString(dataset.RowPosition,"SLIP_ID"),dataset.NameString(dataset.RowPosition,"SLIP_IDSEQ"));
}
function	btnShowListSlipR2_onClick()
{
		var pSLIP_ID        = dsSUB02.NameString(dsSUB02.RowPosition,"TARGET_SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB02.NameString(dsSUB02.RowPosition,"TARGET_SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB02.NameString(dsSUB02.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB02.NameString(dsSUB02.RowPosition,"MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB02.NameString(dsSUB02.RowPosition,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB02.NameString(dsSUB02.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowListSlipP2_onClick()
{
		var pSLIP_ID        = dsSUB02.NameString(dsSUB02.RowPosition,"SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB02.NameString(dsSUB02.RowPosition,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB02.NameString(dsSUB02.RowPosition,"PAY_MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB02.NameString(dsSUB02.RowPosition,"PAY_MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB02.NameString(dsSUB02.RowPosition,"PAY_MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB02.NameString(dsSUB02.RowPosition,"PAY_SLIP_KIND_TAG");
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
function	btnSelectAllC2_onClick()
{
	SelectAllClick(dsSUB02);
}
function	cboACCNO2_onChange()
{
}
function	btnSet2_onClick()
{
	var			lnCnt = dsMAIN.CountRow;
	if(lnCnt < 1) return;
	for(i = 1 ; i <= lnCnt ; ++i)
	{
		if(dsMAIN.NameString(i,"CHK_TAG") == "T")
		{
			var		lfSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"SET_AMT"));
			var		lfReSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"PRE_RESET_AMT"));
			var		lfExceptAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXCEPT_AMT"));
			var		lfPreExecAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXEC_AMT"));
			var		lfCash = C_convSafeFloat(dsMAIN.NameString(i,"C_RATIO"));
			var		lfBill = C_convSafeFloat(dsMAIN.NameString(i,"B_RATIO"));
			var		lfAssignAmt = lfSetAmt - lfReSetAmt - lfExceptAmt;
			if(lfAssignAmt - lfPreExecAmt <= 0 ) continue;
			if(lfBill == 0 ) continue;
			if(lfCash + lfBill == 0 ) continue;
			lfAssignAmt = Math.round(lfAssignAmt * lfBill / (lfCash + lfBill));
			if(lfAssignAmt == 0 ) continue;
			var Row = dsSUB02.NameValueRow("TARGET_SLIP_IDSEQ",dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ"));
			if(Row > 0) continue;
			if(chkMatchAccNo.checked)
			{
				if(dsMAIN.NameString(i,"OUT_ACCNO3") == cboACCNO2.value)
				{
				}
				else
				{
					continue;
				}
			}
			G_addRow(dsSUB02);
			dsSUB02.NameString(dsSUB02.RowPosition,"EXEC_KIND_TAG") = "2";
			dsSUB02.NameString(dsSUB02.RowPosition,"TARGET_SLIP_ID") = dsMAIN.NameString(i,"TARGET_SLIP_ID");
			dsSUB02.NameString(dsSUB02.RowPosition,"TARGET_SLIP_IDSEQ") = dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ");
			dsSUB02.NameString(dsSUB02.RowPosition,"EXEC_AMT") = lfAssignAmt;
			dsSUB02.NameString(dsSUB02.RowPosition,"OUT_ACC_NO") = cboACCNO2.value;
			dsSUB02.NameString(dsSUB02.RowPosition,"CUST_CODE") = dsMAIN.NameString(i,"CUST_CODE");
			dsSUB02.NameString(dsSUB02.RowPosition,"CUST_NAME") = dsMAIN.NameString(i,"CUST_NAME");
			dsSUB02.NameString(dsSUB02.RowPosition,"MAKE_SLIPNO") = dsMAIN.NameString(i,"MAKE_SLIPNO");
			dsSUB02.NameString(dsSUB02.RowPosition,"MAKE_COMP_CODE") = dsMAIN.NameString(i,"MAKE_COMP_CODE");
			dsSUB02.NameString(dsSUB02.RowPosition,"MAKE_DT_TRANS") = dsMAIN.NameString(i,"MAKE_DT_TRANS");
			dsSUB02.NameString(dsSUB02.RowPosition,"MAKE_SEQ") = dsMAIN.NameString(i,"MAKE_SEQ");
			dsSUB02.NameString(dsSUB02.RowPosition,"SLIP_KIND_TAG") = dsMAIN.NameString(i,"SLIP_KIND_TAG");
			dsSUB02.NameString(dsSUB02.RowPosition,"ACC_NAME") = dsMAIN.NameString(i,"ACC_NAME");
			dsSUB02.NameString(dsSUB02.RowPosition,"SUMMARY") = dsMAIN.NameString(i,"SUMMARY");
			dsSUB02.NameString(dsSUB02.RowPosition,"CUST_SEQ") = dsMAIN.NameString(i,"CUST_SEQ");
			dsSUB02.NameString(dsSUB02.RowPosition,"CHK_TAG") = "F";
			dsSUB02.NameString(dsSUB02.RowPosition,"EXPR_DT") = GetPayConExprDt(dsMAIN.NameString(i,"TARGET_SLIP_ID"),dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ"));
			setDefaultCustAccNo(dsSUB02,"3");
		}
	}
	if(!G_saveAllData(dsSUB02)) return;
	G_Load(dsSUB02);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnRemove2_onClick()
{
	var			lnCnt = dsSUB02.CountRow;
	if(lnCnt < 1) return;
	for(i = lnCnt ; i >= 1 ; --i)
	{
		if(dsSUB02.NameString(i,"CHK_TAG") == "T")
		{
			if(!C_isNull(dsSUB02.NameString(i,"PAY_MAKE_SLIPNO")))
			{
				C_msgOk("이미 전표가 발행된 자료는 내역에서 제거가 불가능합니다.");
				dsSUB02.RowPosition = i;
				return;
			}
			G_deleteRow(dsSUB02);
		}
	}
	if(!G_saveAllData(dsSUB02)) return;
	G_Load(dsSUB02);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnMakeSlip2_onClick()
{
	makeSlipCore(dsSUB02);
}
function	btnRemoveSlip2_onClick()
{
	var			dataset = dsSUB02;
	if(dataset.RowPosition < 1)
	{
		C_msgOk("먼저 삭제할 전표가 있는 행을 선택하여 주십시오.");
		return;
	}
	if(C_isNull(dataset.NameString(dataset.RowPosition,"SLIP_ID")))
	{
		C_msgOk("해당행의 자료는 전표가 생성된 자료가 아닙니다.");
		return;
	}
	RemoveSlip(dataset.NameString(dataset.RowPosition,"SLIP_ID"),dataset.NameString(dataset.RowPosition,"SLIP_IDSEQ"));
}
function	btnShowListSlipR3_onClick()
{
		var pSLIP_ID        = dsSUB03.NameString(dsSUB03.RowPosition,"TARGET_SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB03.NameString(dsSUB03.RowPosition,"TARGET_SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB03.NameString(dsSUB03.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB03.NameString(dsSUB03.RowPosition,"MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB03.NameString(dsSUB03.RowPosition,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB03.NameString(dsSUB03.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowListSlipP3_onClick()
{
		var pSLIP_ID        = dsSUB03.NameString(dsSUB03.RowPosition,"SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB03.NameString(dsSUB03.RowPosition,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB03.NameString(dsSUB03.RowPosition,"PAY_MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB03.NameString(dsSUB03.RowPosition,"PAY_MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB03.NameString(dsSUB03.RowPosition,"PAY_MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB03.NameString(dsSUB03.RowPosition,"PAY_SLIP_KIND_TAG");
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
function	btnSelectAllC3_onClick()
{
	SelectAllClick(dsSUB03);
}
function	cboACCNO3_onChange()
{
}
function	btnSet3_onClick()
{
	var			lnCnt = dsMAIN.CountRow;
	if(lnCnt < 1) return;
	for(i = 1 ; i <= lnCnt ; ++i)
	{
		if(dsMAIN.NameString(i,"CHK_TAG") == "T")
		{
			var		lfSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"SET_AMT"));
			var		lfReSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"PRE_RESET_AMT"));
			var		lfExceptAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXCEPT_AMT"));
			var		lfPreExecAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXEC_AMT"));
			var		lfCash = C_convSafeFloat(dsMAIN.NameString(i,"C_RATIO"));
			var		lfBill = C_convSafeFloat(dsMAIN.NameString(i,"B_RATIO"));
			var		lfAssignAmt = lfSetAmt - lfReSetAmt - lfExceptAmt;
			if(lfAssignAmt - lfPreExecAmt <= 0 ) continue;
			if(lfBill == 0 ) continue;
			if(lfCash + lfBill == 0 ) continue;
			lfAssignAmt = Math.round(lfAssignAmt * lfBill / (lfCash + lfBill));
			if(lfAssignAmt == 0 ) continue;
			var Row = dsSUB03.NameValueRow("TARGET_SLIP_IDSEQ",dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ"));
			if(Row > 0) continue;
			G_addRow(dsSUB03);
			dsSUB03.NameString(dsSUB03.RowPosition,"EXEC_KIND_TAG") = "3";
			dsSUB03.NameString(dsSUB03.RowPosition,"TARGET_SLIP_ID") = dsMAIN.NameString(i,"TARGET_SLIP_ID");
			dsSUB03.NameString(dsSUB03.RowPosition,"TARGET_SLIP_IDSEQ") = dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ");
			dsSUB03.NameString(dsSUB03.RowPosition,"EXEC_AMT") = lfAssignAmt;
			dsSUB03.NameString(dsSUB03.RowPosition,"OUT_ACC_NO") = cboACCNO3.value;
			dsSUB03.NameString(dsSUB03.RowPosition,"CUST_CODE") = dsMAIN.NameString(i,"CUST_CODE");
			dsSUB03.NameString(dsSUB03.RowPosition,"CUST_NAME") = dsMAIN.NameString(i,"CUST_NAME");
			dsSUB03.NameString(dsSUB03.RowPosition,"MAKE_SLIPNO") = dsMAIN.NameString(i,"MAKE_SLIPNO");
			dsSUB03.NameString(dsSUB03.RowPosition,"MAKE_COMP_CODE") = dsMAIN.NameString(i,"MAKE_COMP_CODE");
			dsSUB03.NameString(dsSUB03.RowPosition,"MAKE_DT_TRANS") = dsMAIN.NameString(i,"MAKE_DT_TRANS");
			dsSUB03.NameString(dsSUB03.RowPosition,"MAKE_SEQ") = dsMAIN.NameString(i,"MAKE_SEQ");
			dsSUB03.NameString(dsSUB03.RowPosition,"SLIP_KIND_TAG") = dsMAIN.NameString(i,"SLIP_KIND_TAG");
			dsSUB03.NameString(dsSUB03.RowPosition,"ACC_NAME") = dsMAIN.NameString(i,"ACC_NAME");
			dsSUB03.NameString(dsSUB03.RowPosition,"SUMMARY") = dsMAIN.NameString(i,"SUMMARY");
			dsSUB03.NameString(dsSUB03.RowPosition,"CUST_SEQ") = dsMAIN.NameString(i,"CUST_SEQ");
			dsSUB03.NameString(dsSUB03.RowPosition,"CHK_TAG") = "F";
			dsSUB03.NameString(dsSUB03.RowPosition,"EXPR_DT") = GetPayConExprDt(dsMAIN.NameString(i,"TARGET_SLIP_ID"),dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ"));
			setDefaultCustAccNo(dsSUB03,"2");
		}
	}
	if(!G_saveAllData(dsSUB03)) return;
	G_Load(dsSUB03);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnRemove3_onClick()
{
	var			lnCnt = dsSUB03.CountRow;
	if(lnCnt < 1) return;
	for(i = lnCnt ; i >= 1 ; --i)
	{
		if(dsSUB03.NameString(i,"CHK_TAG") == "T")
		{
			if(!C_isNull(dsSUB03.NameString(i,"PAY_MAKE_SLIPNO")))
			{
				C_msgOk("이미 전표가 발행된 자료는 내역에서 제거가 불가능합니다.");
				dsSUB03.RowPosition = i;
				return;
			}
			G_deleteRow(dsSUB03);
		}
	}
	if(!G_saveAllData(dsSUB03)) return;
	G_Load(dsSUB03);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnMakeSlip3_onClick()
{
	makeSlipCore(dsSUB03);
}
function	btnRemoveSlip3_onClick()
{
	var			dataset = dsSUB03;
	if(dataset.RowPosition < 1)
	{
		C_msgOk("먼저 삭제할 전표가 있는 행을 선택하여 주십시오.");
		return;
	}
	if(C_isNull(dataset.NameString(dataset.RowPosition,"SLIP_ID")))
	{
		C_msgOk("해당행의 자료는 전표가 생성된 자료가 아닙니다.");
		return;
	}
	RemoveSlip(dataset.NameString(dataset.RowPosition,"SLIP_ID"),dataset.NameString(dataset.RowPosition,"SLIP_IDSEQ"));
}
function	btnShowListSlipR4_onClick()
{
		var pSLIP_ID        = dsSUB04.NameString(dsSUB04.RowPosition,"TARGET_SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB04.NameString(dsSUB04.RowPosition,"TARGET_SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB04.NameString(dsSUB04.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB04.NameString(dsSUB04.RowPosition,"MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB04.NameString(dsSUB04.RowPosition,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB04.NameString(dsSUB04.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowListSlipP4_onClick()
{
		var pSLIP_ID        = dsSUB04.NameString(dsSUB04.RowPosition,"SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB04.NameString(dsSUB04.RowPosition,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB04.NameString(dsSUB04.RowPosition,"PAY_MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB04.NameString(dsSUB04.RowPosition,"PAY_MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB04.NameString(dsSUB04.RowPosition,"PAY_MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB04.NameString(dsSUB04.RowPosition,"PAY_SLIP_KIND_TAG");
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
function	btnSelectAllC4_onClick()
{
	SelectAllClick(dsSUB04);
}
function	btnSet4_onClick()
{
	var			lnCnt = dsMAIN.CountRow;
	if(lnCnt < 1) return;
	for(i = 1 ; i <= lnCnt ; ++i)
	{
		if(dsMAIN.NameString(i,"CHK_TAG") == "T")
		{
			var		lfSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"SET_AMT"));
			var		lfReSetAmt = C_convSafeFloat(dsMAIN.NameString(i,"PRE_RESET_AMT"));
			var		lfExceptAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXCEPT_AMT"));
			var		lfPreExecAmt = C_convSafeFloat(dsMAIN.NameString(i,"EXEC_AMT"));
			var		lfCash = C_convSafeFloat(dsMAIN.NameString(i,"C_RATIO"));
			var		lfBill = C_convSafeFloat(dsMAIN.NameString(i,"B_RATIO"));
			var		lfAssignAmt = lfSetAmt - lfReSetAmt - lfExceptAmt;
			if(lfAssignAmt - lfPreExecAmt <= 0 ) continue;
			if(lfCash == 0 ) continue;
			if(lfCash + lfBill == 0 ) continue;
			lfAssignAmt = Math.round(lfAssignAmt * lfCash / (lfCash + lfBill));
			if(lfAssignAmt == 0 ) continue;
			var Row = dsSUB04.NameValueRow("TARGET_SLIP_IDSEQ",dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ"));
			if(Row > 0) continue;
			G_addRow(dsSUB04);
			dsSUB04.NameString(dsSUB04.RowPosition,"EXEC_KIND_TAG") = "4";
			dsSUB04.NameString(dsSUB04.RowPosition,"TARGET_SLIP_ID") = dsMAIN.NameString(i,"TARGET_SLIP_ID");
			dsSUB04.NameString(dsSUB04.RowPosition,"TARGET_SLIP_IDSEQ") = dsMAIN.NameString(i,"TARGET_SLIP_IDSEQ");
			dsSUB04.NameString(dsSUB04.RowPosition,"EXEC_AMT") = lfAssignAmt;
			dsSUB04.NameString(dsSUB04.RowPosition,"CUST_CODE") = dsMAIN.NameString(i,"CUST_CODE");
			dsSUB04.NameString(dsSUB04.RowPosition,"CUST_NAME") = dsMAIN.NameString(i,"CUST_NAME");
			dsSUB04.NameString(dsSUB04.RowPosition,"MAKE_SLIPNO") = dsMAIN.NameString(i,"MAKE_SLIPNO");
			dsSUB04.NameString(dsSUB04.RowPosition,"MAKE_COMP_CODE") = dsMAIN.NameString(i,"MAKE_COMP_CODE");
			dsSUB04.NameString(dsSUB04.RowPosition,"MAKE_DT_TRANS") = dsMAIN.NameString(i,"MAKE_DT_TRANS");
			dsSUB04.NameString(dsSUB04.RowPosition,"MAKE_SEQ") = dsMAIN.NameString(i,"MAKE_SEQ");
			dsSUB04.NameString(dsSUB04.RowPosition,"SLIP_KIND_TAG") = dsMAIN.NameString(i,"SLIP_KIND_TAG");
			dsSUB04.NameString(dsSUB04.RowPosition,"ACC_NAME") = dsMAIN.NameString(i,"ACC_NAME");
			dsSUB04.NameString(dsSUB04.RowPosition,"SUMMARY") = dsMAIN.NameString(i,"SUMMARY");
			dsSUB04.NameString(dsSUB04.RowPosition,"CUST_SEQ") = dsMAIN.NameString(i,"CUST_SEQ");
			dsSUB04.NameString(dsSUB04.RowPosition,"CHK_TAG") = "F";
		}
	}
	if(!G_saveAllData(dsSUB04)) return;
	G_Load(dsSUB04);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnRemove4_onClick()
{
	var			lnCnt = dsSUB04.CountRow;
	if(lnCnt < 1) return;
	for(i = lnCnt ; i >= 1 ; --i)
	{
		if(dsSUB04.NameString(i,"CHK_TAG") == "T")
		{
			if(!C_isNull(dsSUB04.NameString(i,"PAY_MAKE_SLIPNO")))
			{
				C_msgOk("이미 전표가 발행된 자료는 내역에서 제거가 불가능합니다.");
				dsSUB04.RowPosition = i;
				return;
			}
			G_deleteRow(dsSUB04);
		}
	}
	if(!G_saveAllData(dsSUB04)) return;
	G_Load(dsSUB04);
	G_Load(dsMAIN);
	G_Load(dsSUB05);
}
function	btnMakeSlip4_onClick()
{
	makeSlipCore(dsSUB04);
}
function	btnRemoveSlip4_onClick()
{
	var			dataset = dsSUB04;
	if(dataset.RowPosition < 1)
	{
		C_msgOk("먼저 삭제할 전표가 있는 행을 선택하여 주십시오.");
		return;
	}
	if(C_isNull(dataset.NameString(dataset.RowPosition,"SLIP_ID")))
	{
		C_msgOk("해당행의 자료는 전표가 생성된 자료가 아닙니다.");
		return;
	}
	RemoveSlip(dataset.NameString(dataset.RowPosition,"SLIP_ID"),dataset.NameString(dataset.RowPosition,"SLIP_IDSEQ"));
}
function	btnShowListSlipR5_onClick()
{
		var pSLIP_ID        = dsSUB05.NameString(dsSUB05.RowPosition,"TARGET_SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB05.NameString(dsSUB05.RowPosition,"TARGET_SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB05.NameString(dsSUB05.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB05.NameString(dsSUB05.RowPosition,"MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB05.NameString(dsSUB05.RowPosition,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB05.NameString(dsSUB05.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowListSlipP5_onClick()
{
		var pSLIP_ID        = dsSUB05.NameString(dsSUB05.RowPosition,"SLIP_ID");
		var pSLIP_IDSEQ     = dsSUB05.NameString(dsSUB05.RowPosition,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsSUB05.NameString(dsSUB05.RowPosition,"PAY_MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsSUB05.NameString(dsSUB05.RowPosition,"PAY_MAKE_DT_TRANS");
		var pMAKE_SEQ     	 = dsSUB05.NameString(dsSUB05.RowPosition,"PAY_MAKE_SEQ");
		var pSLIP_KIND_TAG  = dsSUB05.NameString(dsSUB05.RowPosition,"PAY_SLIP_KIND_TAG");
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
function	btnSelectAllC5_onClick()
{
	SelectAllClick(dsSUB05);
}
function	btnMakeSlip5_onClick()
{
	makeSlipCore(dsSUB05);
}
function	btnRemoveSlip5_onClick()
{
	var			dataset = dsSUB05;
	if(dataset.RowPosition < 1)
	{
		C_msgOk("먼저 삭제할 전표가 있는 행을 선택하여 주십시오.");
		return;
	}
	if(C_isNull(dataset.NameString(dataset.RowPosition,"SLIP_ID")))
	{
		C_msgOk("해당행의 자료는 전표가 생성된 자료가 아닙니다.");
		return;
	}
	RemoveSlip(dataset.NameString(dataset.RowPosition,"SLIP_ID"),dataset.NameString(dataset.RowPosition,"SLIP_IDSEQ"));
}
function	btnRemoveSlipDetail_onClick()
{
	var			dataset = dsDETAIL;
	if(dataset.RowPosition < 1)
	{
		C_msgOk("먼저 삭제할 전표가 있는 행을 선택하여 주십시오.");
		return;
	}
	if(C_isNull(dataset.NameString(dataset.RowPosition,"SLIP_ID")))
	{
		C_msgOk("해당행의 자료는 전표가 생성된 자료가 아닙니다.");
		return;
	}
	RemoveSlip(dataset.NameString(dataset.RowPosition,"SLIP_ID"),dataset.NameString(dataset.RowPosition,"SLIP_IDSEQ"));
}
function	btnMakeFBS1_onClick()
{
	var			dataset = dsSUB01;
	if(!chkTopCondition()) return;
	if(dsMASTER.RowPosition < 1)
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(C_isNull(dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT" )))
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsMAKE_PAY_INFO);
	G_Load(dsMAKE_PAY);
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"WORK_DT") = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"CRTUSERNO") = sEmpNo;
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"DEPT_CODE") = sDeptCode;
	var			lnCnt = dataset.CountRow;
	for(i = 1 ; i <= lnCnt ; ++ i)
	{
		if(dataset.NameString(i,"CHK_TAG") == "T")
		{
			copyToMakePayInfo(dataset,i);
		}
	}
	if(dsMAKE_PAY_INFO.CountRow < 1)
	{
		C_msgOk("FBS자료를 생성하기 위한 자료를 선택하여 주십시오.");
		return;
	}
	transMAKE_PAY.Parameters = "ACT=MAKE_PAY";
	if(!G_saveData(dsMAKE_PAY_INFO))return;
	C_msgOk("FBS자료가 정상적으로 생성되었습니다.");
}
function	btnMakeFBS2_onClick()
{
	var			dataset = dsSUB02;
	if(!chkTopCondition()) return;
	if(dsMASTER.RowPosition < 1)
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(C_isNull(dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT" )))
	{
		C_msgOk("먼저 대금지금목록에 작업일을 입력하십시오.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsMAKE_PAY_INFO);
	G_Load(dsMAKE_PAY);
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"WORK_DT") = dsMASTER.NameString(dsMASTER.RowPosition,"WORK_DT");
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"CRTUSERNO") = sEmpNo;
	dsMAKE_PAY.NameString(dsMAKE_PAY.RowPosition,"DEPT_CODE") = sDeptCode;
	var			lnCnt = dataset.CountRow;
	for(i = 1 ; i <= lnCnt ; ++ i)
	{
		if(dataset.NameString(i,"CHK_TAG") == "T")
		{
			copyToMakePayInfo(dataset,i);
		}
	}
	if(dsMAKE_PAY_INFO.CountRow < 1)
	{
		C_msgOk("FBS자료를 생성하기 위한 자료를 선택하여 주십시오.");
		return;
	}
	transMAKE_PAY.Parameters = "ACT=MAKE_PAY";
	if(!G_saveData(dsMAKE_PAY_INFO))return;
	C_msgOk("FBS자료가 정상적으로 생성되었습니다.");
}
