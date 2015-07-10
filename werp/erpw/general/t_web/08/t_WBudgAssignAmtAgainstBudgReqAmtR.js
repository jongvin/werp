/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgAssignAmtAgainstBudgReqAmtR.js(��û�������ݾ�)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ��û�������ݾ�
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-1-03)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "����庰 �μ����");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "�μ���-���� ��û����");

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	G_addDataSet(dsDATE, null, null,  null, "DATE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_Load(dsDATE, null);
	txtBUDG_YYYY_MM_FR.value = dsDATE.NameValue(dsDATE.RowPosition, "CDATE");
	txtBUDG_YYYY_MM_TO.value= dsDATE.NameValue(dsDATE.RowPosition, "CDATE");

	G_Load(dsLIST00, null);
	
	gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsLIST00)
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

	var vDeptFlag = selDeptFlag.value;

	var gridTitle = "";

	
	if(vDeptFlag !="ALL"){
		gridTitle += "<FC> Name=��  ID=chk_dept_name Sort=true Align=Left HeadAlign=Center     Width=80 suppress=3";
		gridTitle += "</FC>                                                                                                                               ";
	}
	if(vDeptFlag !="ALL" && vDeptFlag !="CHK_DEPT" ){
		gridTitle += "<FC> Name=�μ�  ID=DEPT_NAME Sort=true Align=Left HeadAlign=Center     Width=80 suppress=2";
		gridTitle += "</FC>                                                                                                                               ";
	}
	gridTitle += "<FC> Name=�������� ID=p_acc_name Sort=true Align=left HeadAlign=Center    Width=100    suppress=1           ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<FC> Name=���� ID=ACC_NAME Sort=true Align=Left HeadAlign=Center    Width=250               ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "	<C> Name=��û�� ID=re1 Align=Right HeadAlign=Center  Width=150 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=������ ID=as1 Align=Right HeadAlign=Center  Width=150 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r1 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";

	grid.Format = gridTitle;
}
//�˻�����üũ
function CheckCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	
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
	
	if( txtBUDG_YYYY_MM_FR.value.substr(0,4) != txtBUDG_YYYY_MM_TO.value.substr(0,4))
	{
		C_msgOk("������ �۾��⵵�� �Է��ϼ���.", "Ȯ��");
		return false;	
	}
	return true;
	
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
//�μ�
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	if(!CheckCondition()) return;
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	 
   	var vBudgYyyyMmFr   = txtBUDG_YYYY_MM_FR.value;
   	var vBudgYyyyMmTo   = txtBUDG_YYYY_MM_TO.value;
       var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
      
   	var vDeptFlag = selDeptFlag.value;
   
  	var arg_temp;
   
   
   	var reportFile ="";
   
   	
   	reportFile ="r_t_080020";  //��ü

   	arg_temp = arg_temp + reportFile ;   // ������ 
   	
   	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value = "1";
	frmList.REQUEST_NAME.value = "��û�������ݾ�";
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";

	strTemp += "P_COMP_CODE__" + vCompCode;
	strTemp  += "&&P_BUDG_YYYY_MM_FR__" + vBudgYyyyMmFr;
	strTemp += "&&P_BUDG_YYYY_MM_TO__" + vBudgYyyyMmTo;
	
	strTemp += "&&P_DEPT_CODE__" + vDeptCode;
	strTemp += "&&P_DEPT_FLAG__" + vDeptFlag;
	strTemp  += "&&P_COMP_NAME__" + vCompName;
	
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
   	
}
// ��ȸ
function btnquery_onclick()
{
	if(!CheckCondition()) return;
	D_defaultLoad();
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
       if (dataset == dsLIST00)
	{
		//�μ�
		var vDeptCode = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		
		selDeptFlag.options.length = "0"; 
		var i = 0;
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("�� ü","ALL");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("����","CHK_DEPT");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("�μ���","DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("����","CHK_DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("�μ���","DEPT");
		
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
 

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "M", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "M", txtBUDG_YYYY_MM_TO.value);
	
}
 
//���
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}
 

