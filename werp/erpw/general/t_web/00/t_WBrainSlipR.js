/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBrainSlipR.js(전표_표준적요_대분류등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 전표_표준적요_대분류등록 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "표준적요대분류");
	G_addDataSet(dsLIST, trans, gridLIST, sSelectPageName+D_P1("ACT","LIST"), "표준적요중분류");
	G_addDataSet(dsBRAIN_SLIP_SEQ1, null, null, null, "BRAIN_SLIP_SEQ1");
	G_addDataSet(dsBRAIN_SLIP_SEQ2, null, null, null, "BRAIN_SLIP_SEQ2");
	
	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "BRAIN_SLIP_SEQ1", "BRAIN_SLIP_SEQ1");
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsLIST)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST")
										+ D_P2("BRAIN_SLIP_SEQ1",dsMAIN.NameString(dsMAIN.RowPosition,"BRAIN_SLIP_SEQ1"));
	}
	else if(dataset == dsBRAIN_SLIP_SEQ1)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ1");
	}
	else if(dataset == dsBRAIN_SLIP_SEQ2)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ2");
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
	
       //var  vACC_GRP = cboACC_GRP.value;
   	var reportFile ="";

   	reportFile ="r_t_080050";  

	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";

	
	//strTemp += "P_ACC_GRP__" + vACC_GRP;


	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 공통 재정의 이벤트관련-------------------------------------------------------//
function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		G_Load(dsBRAIN_SLIP_SEQ1, null);
		dataset.NameString(row,"BRAIN_SLIP_SEQ1") = dsBRAIN_SLIP_SEQ1.NameString(dsBRAIN_SLIP_SEQ1.RowPosition,"BRAIN_SLIP_SEQ1");
	}
	else if (dataset == dsLIST)
	{
		G_Load(dsBRAIN_SLIP_SEQ2, null);
		dataset.NameString(row,"BRAIN_SLIP_SEQ2") = dsBRAIN_SLIP_SEQ2.NameString(dsBRAIN_SLIP_SEQ2.RowPosition,"BRAIN_SLIP_SEQ2");
		dataset.NameString(row,"USE_CLS") = "T";
	}
}

// 이벤트관련-------------------------------------------------------------------//
//출력
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}