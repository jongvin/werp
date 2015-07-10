/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgDeptMapR(예산편성부서정보설정)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			fgManager = null;
var			arTF = null;
var			arControlTag = null;
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, null, null, sSelectPageName+D_P1("ACT","MAIN"), "부서");
	G_addDataSet(dsMAIN_D, null, null, sSelectPageName+D_P1("ACT","MAIN_D"), "부서");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	arTF = new Array();

	
	fgManager = F_addFlexGrid(fg,dsMAIN,dsMAIN_D,1,"DEPT_NAME","LV","DEPT_CODE","DEPT_CODE","P_DEPT_CODE","부서");
	//항상 label column을 제일 먼저 설정해야 한다.
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_NAME",STRING_DATA,EDITSTYLE_NORMAL,null,3600,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_CODE",STRING_DATA,EDITSTYLE_NORMAL,null,1000,true,null,null));
	
	
	fgManager.initGrid();
	
	fg.FrozenCols = 1;
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_NAME"),"부서명");
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_CODE"),"부서코드");
	
      
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_NAME")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_CODE")) = FlexAlignCenterCenter;
	
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_NAME")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_CODE")) = FlexAlignCenterCenter;
	


	fg.focus();
	
	// 삭제해야함.
	var aa = CM_createContextMenu("TestContextMenu", fg);
	
	aa.addMenu("Menu1", "N", "조회", false);

	
	//CM_ContextMenuShow("TestContextMenu");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
}





function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
	}
	else if(dataset == dsMAIN_D)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN_D")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
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

//함수관련---------------------------------------------------------------------//
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	
	//자료를 읽습니다.
	if(!G_Load(dsMAIN)) return false;
	fg.focus();
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
		fgManager.displayData();
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
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");

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

}