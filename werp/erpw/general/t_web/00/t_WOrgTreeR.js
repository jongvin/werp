/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgDeptMapR(�������μ���������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-21)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			fgManager = null;
var			arTF = null;
var			arControlTag = null;
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, null, null, sSelectPageName+D_P1("ACT","MAIN"), "�μ�");
	G_addDataSet(dsMAIN_D, null, null, sSelectPageName+D_P1("ACT","MAIN_D"), "�μ�");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	arTF = new Array();

	
	fgManager = F_addFlexGrid(fg,dsMAIN,dsMAIN_D,1,"DEPT_NAME","LV","DEPT_CODE","DEPT_CODE","P_DEPT_CODE","�μ�");
	//�׻� label column�� ���� ���� �����ؾ� �Ѵ�.
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_NAME",STRING_DATA,EDITSTYLE_NORMAL,null,3600,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_CODE",STRING_DATA,EDITSTYLE_NORMAL,null,1000,true,null,null));
	
	
	fgManager.initGrid();
	
	fg.FrozenCols = 1;
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_NAME"),"�μ���");
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_CODE"),"�μ��ڵ�");
	
      
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_NAME")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_CODE")) = FlexAlignCenterCenter;
	
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_NAME")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_CODE")) = FlexAlignCenterCenter;
	


	fg.focus();
	
	// �����ؾ���.
	var aa = CM_createContextMenu("TestContextMenu", fg);
	
	aa.addMenu("Menu1", "N", "��ȸ", false);

	
	//CM_ContextMenuShow("TestContextMenu");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
}





function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
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

// ���ǰ��� �Լ�----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

//�Լ�����---------------------------------------------------------------------//
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	
	//�ڷḦ �н��ϴ�.
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
// �̺�Ʈ����-------------------------------------------------------------------//
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