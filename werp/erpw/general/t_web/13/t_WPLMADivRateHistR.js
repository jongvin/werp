/**************************************************************************/
/* 1. 프 로 그 램 id : t_WWorkCodeR.js(자동전표코드등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsLOV,  null,   null, null, "LOV");

	G_addDataSet(dsBATCH01, transBATCH01, null, null, "부서목록");

	G_addDataSet(dsMAIN,  trans,   gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "배부율변경차수");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "차수별배부율");

	G_addDataSet(dsSEQ,  null,   null, null, "SEQ");

	//txtCOMP_CODE.value = sCompCode;
	//txtCOMPANY_NAME.value = sCompName;
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"HIST_SEQ","HIST_SEQ");
	
	//G_setLovCol(gridSUB01,"ACC_CODE");
	G_setLovCol(gridMAIN,"APPL_DT");

	G_setReadOnlyCol(gridSUB01, "PRE_DIV_RATIO");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.TabToss = false;

	gridMAIN.focus();
	btnquery_onclick();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("HIST_SEQ", dsMAIN.NameString(dsMAIN.RowPosition, "HIST_SEQ"))
										 + D_P2("DVD_CODE", cboDVD_CODE.value);
	}
	else if(dataset == dsSEQ)
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


// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		D_defaultAdd();
		dsMAIN.NameString(dsMAIN.RowPosition,"HIST_SEQ") = (parseInt(dsMAIN.NameMax("HIST_SEQ",0,0))+1);
	}
	else if(G_FocusDataset == dsSUB01)
	{
		if(cboDVD_CODE.value=='%') {
			C_msgOk("배부기준을를 먼저 선택하세요.", "확인");
			return;
		}

		if(dsMAIN.CountRow==0) {
			C_msgOk("변경차수를 먼저 선택하세요.", "확인");
			return;
		}
		var lrArgs = new C_Dictionary();
		var lrRet = null;

		lrArgs.set("HIST_SEQ", dsMAIN.NameValue(dsMAIN.RowPosition,"HIST_SEQ"));
		lrArgs.set("DVD_CODE", cboDVD_CODE.value);
		lrArgs.set("COME_CODE", sCompCode);
		lrArgs.set("COST_DEPT_KND_TAG", 'B');
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV_NEW("T_DEPT_CODE11", null, lrArgs, "T", "T");
		
		if (lrRet == null) return;

		var idx = 0;
		for (idx = 0; idx < lrRet.length; idx++)
		{
			lrArgs = lrRet[idx];
			//D_defaultAdd();
			G_addRow(dsSUB01);
			dsSUB01.NameString(dsSUB01.RowPosition, "DVD_CODE") = cboDVD_CODE.value;
			dsSUB01.NameString(dsSUB01.RowPosition, "DVD_NAME") = cboDVD_CODE.options[cboDVD_CODE.options.selectedIndex].text;
			dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_CODE") = lrArgs.get("DEPT_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_NAME") = lrArgs.get("DEPT_NAME");
		}
	}
}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick()
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		D_defaultDelete();
	} else if(G_FocusDataset==dsSUB01) {
		//dsSUB01.DeleteMarked();
		G_MultiDeleteRow(dsSUB01)
	}
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
	if (asCalendarID == "APPL_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"APPL_DT") = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	var idx = 0;
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
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
	if(dataset == dsSUB01)
	{
		//if(dsSUB01.NameString(row,"UDT_TAG")=="O") dsSUB01.NameString(row,"UDT_TAG") = 'U';
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if( colid == "APPL_DT" )
		{
			var COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
	}
}

function OnPopup(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if( colid == "APPL_DT" )
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
	}

}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsSUB01)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"TAX_COMP_CODE") = dsSUB01.NameString(row-1,"TAX_COMP_CODE");
				dsSUB01.NameString(row,"TAX_COMP_NAME") = dsSUB01.NameString(row-1,"TAX_COMP_NAME");
			}
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function cboDVD_CODE_onchange()
{
	gridSUB01.focus();
	btnquery_onclick();
}

function btnBatchInput_onClick()
{
	if(dsMAIN.CountRow==0) {
		C_msgOk("배부율변경차수를 먼저 등록하세요.", "확인");
		return;
	}

	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var	vRet = C_msgYesNo("배부율변경차수 내역이 수정되었습니다. 저장하고 계속 진행하시겠습니까?", "경고");
		if (vRet != "Y") return;
		if(!G_saveData(dsMAIN)) return;
	}

	if(dsSUB01.CountRow!=0) {
		var	vRet = C_msgYesNo("현재차수에 배부율 내역이 존재합니다. 계속진행하면 현 데이터를 모두 삭제하고 재계산합니다.<br>계속 진행하시겠습니까?", "경고");
		if (vRet != "Y") return;
	}

	//var vTmp = "COMP_CODE:STRING(30),WORK_NO:DECIMAL";
	var vTmp = "HIST_SEQ:STRING(30),DVD_CODE:STRING(30)";
	dsBATCH01.ClearAll();
	dsBATCH01.SetDataHeader(vTmp);
	dsBATCH01.AddRow();
	dsBATCH01.NameString(1,"HIST_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition, "HIST_SEQ");
	dsBATCH01.NameString(1,"DVD_CODE") = cboDVD_CODE.value;

	transBATCH01.Parameters = "ACT=BATCH01";
	G_saveData(dsBATCH01);

	G_Load(dsSUB01, null);
}