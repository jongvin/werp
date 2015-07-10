/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgAssignByDeptByAccForYearR.js(�μ���������������Ȳ(��))
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �μ���������������Ȳ(��)
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-29)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	//G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ڵ���ǥ�ڵ�");

	G_addDataSet(dsMAIN, null, null, sSelectPageName+D_P1("ACT","MAIN"), "�����");
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "����庰 �μ����");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "�μ���-���� ��û����");

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	G_addDataSet(dsDATE, null, null,  null, "DATE");

	G_addRel(dsMAIN, dsLIST00);

	G_addRelCol(dsLIST00, "COMP_CODE", "COMP_CODE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_Load(dsDATE, null);
	txtBUDG_YYYY_MM_FR.value = dsDATE.NameValue(dsDATE.RowPosition, "CDATE");
	txtBUDG_YYYY_MM_TO.value= dsDATE.NameValue(dsDATE.RowPosition, "CDATE");
	G_Load(dsMAIN, null);
	G_Load(dsLIST00, null);
	
	gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}

	if (dataset == dsMAIN)
	{
		//����庰 �μ����
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");

	}

	else if (dataset == dsLIST00)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST00")
									 + D_P2("COMP_CODE",vCOMP_CODE);
	}

	else if (dataset == dsLIST02)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vBudgYyyyMmFr = txtBUDG_YYYY_MM_FR.value;
		var vBudgYyyyMmTo = txtBUDG_YYYY_MM_TO.value;
		var vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		var vDeptFlag = selDeptFlag.value;

		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("BUDG_YYYY_MM_FR",vBudgYyyyMmFr)
									 + D_P2("BUDG_YYYY_MM_TO",vBudgYyyyMmTo)
									 + D_P2("DEPT_CODE",vDEPT_CODE)
									 + D_P2("DEPT_FLAG",vDeptFlag);

		makeGridTitle(gridLIST02);
	}
	
	if (dataset == dsDATE)
	{
		//����庰 �μ����
		dataset.DataID = sSelectPageName + D_P1("ACT","DATE");

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

// �Լ�����---------------------------------------------------------------------//
function btnSch2_onClick()
{
	G_Load(dsLIST02, null);
}
function makeGridTitle(grid)
{
	var vBudgFlagName = "";
	var vDeptFlag = selDeptFlag.value;
	var vDeptFlagName = "";

	//if(vBudgFlag == 'BUDG') {
		vBudgFlagName = "����";
	//} else if(vBudgFlag == 'APPEND_BUDG') {
	//
	//}

	if(vDeptFlag == 'CHK_DEPT') {
		vDeptFlagName = "�����μ�";
	}else if(vDeptFlag == 'DEPT') {
		vDeptFlagName = "�μ�";
	}

	var gridTitle = "";

	
	if(vDeptFlag !="ALL"){
		gridTitle += "<FC> Name="+vDeptFlagName+" ID=DEPT_TITLE Sort=true Align=Left HeadAlign=Center     Width=140 suppress=1";
		gridTitle += "</FC>                                                                                                                               ";
	}
	gridTitle += "<FC> Name=�����ڵ� ID=ACC_CODE Sort=true Align=Center HeadAlign=Center     Width=80              ";
	gridTitle += "	 Show=false                                                                                                                       ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<FC> Name=������Ī ID=ACC_NAME Sort=true Align=Left HeadAlign=Center    Width=250               ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "	<C> Name="+vBudgFlagName+" ID=pb1 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s1 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r1 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";

	grid.Format = gridTitle;
}
//�˻�����üũ
function print_condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vBudgYyyyMmFr   = txtBUDG_YYYY_MM_FR.value;
   	var vBudgYyyyMmTo   = txtBUDG_YYYY_MM_TO.value;
   	
   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("������� �����ϼ���");
   		return;
   	}
   	
   	if ( C_isNull(vBudgYyyyMmFr))
   	{
   		C_msgOk("�۾������ �Է��ϼ���");
   		return;
   	}
   	
   	if ( C_isNull(vBudgYyyyMmTo))
   	{
   		C_msgOk("�۾������ �Է��ϼ���");
   		return;
   	}
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
//�μ�
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	print_condition_check();
	
	var vCompCode  = txtCOMP_CODE.value;
	 
   	var vBudgYyyyMmFr   = txtBUDG_YYYY_MM_FR.value;
   	var vBudgYyyyMmTo   = txtBUDG_YYYY_MM_TO.value;
       var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
      
   	var vDeptFlag = selDeptFlag.value;
   
  	var arg_temp;
   	arg_temp ="general_rpt/t_web/08r/" ;       // ���� ���丮
   
   	var reportFile ="";
   	if (vDeptFlag =='ALL')  
   	{
   		reportFile ="r_t_080011";  //��ü
   	} 
   	else if (vDeptFlag =='CHK_DEPT')
   	{
   		reportFile ="r_t_080012"; //�����μ���
   	}
   	else if (vDeptFlag =='DEPT') 
   	{
   		reportFile ="r_t_080013"; //�μ���
   	} 
   	
   	arg_temp = arg_temp + reportFile ;   // ������ 
   	
   	arg_temp = arg_temp +  "&RptParams=" + vBudgYyyyMmFr + "&RptParams=" + vBudgYyyyMmTo+   
   	                      "&RptParams=" + vCompCode + "&RptParams=" + vDeptCode +  "&RptParams=" + vDeptFlag;
   	f_crystal_report(arg_temp) ;  //���� ȣ��
}
// ��ȸ
function btnquery_onclick()
{
	CheckBudgYyyyMm();
	D_defaultLoad();
}

// ����
function btnsave_onclick()
{
	D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "BUDG_YYYY_MM_FR")
	{
		txtBUDG_YYYY_MM_FR.value = asDate;
	}
	else if (asCalendarID == "BUDG_YYYY_MM_TO")
	{
		txtBUDG_YYYY_MM_TO.value = asDate;
	}
	
	 if( parseInt(txtBUDG_YYYY_MM_FR.value.replace(/-/g, "")) > parseInt(txtBUDG_YYYY_MM_TO.value.replace(/-/g, "")) )
	 {
	 	C_msgOk("���ۿ��� ��������� Ů�ϴ�");
	 	txtBUDG_YYYY_MM_TO.value="";
	 	btnBUDG_YYYY_MM_TO.focus();
	 	return false;	
	 }
	
}
function OnRowPosChanged(dataset, row)
{
	if(row==0) return;
	if (dataset == dsMAIN) {
		//�������
	}
	else if (dataset == dsLIST00)
	{
		//�μ�
		var vDeptCode = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		
		selDeptFlag.options.length = "0"; 
		var i = 0;
		if(vDeptCode == "***") selDeptFlag.options.options[i++] = new Option("�� ü","ALL");
		if(vDeptCode == "***") selDeptFlag.options.options[i++] = new Option("�����μ���","CHK_DEPT");
		if(vDeptCode == "***") selDeptFlag.options.options[i++] = new Option("�μ���","DEPT");
		if(vDeptCode != "***") selDeptFlag.options.options[i++] = new Option("�μ���","DEPT");
		G_Load(dsLIST02, null);
	}

}

// �̺�Ʈ����-------------------------------------------------------------------//
function deptFlag_onChange()
{
	G_Load(dsLIST02,null);	
}
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");

	dsMAIN.ClearData();
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

	dsMAIN.ClearData();
}
 
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

function	CheckBudgYyyyMm()
{
	if (C_isNull(txtBUDG_YYYY_MM_FR.value))
	{
		C_msgOk("�۾����ۿ��� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	if (C_isNull(txtBUDG_YYYY_MM_TO.value))
	{
		C_msgOk("�۾�������� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "M", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "M", txtBUDG_YYYY_MM_TO.value);
	
}
function deptFlag_onChange()
{
	G_Load(dsLIST02,null);	
}
//���
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}
 

