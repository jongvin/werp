/**************************************************************************/
/* 1. �� �� �� �� id : t_WLastYearBudgResultCompR.js(�����������Ȳ)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �μ���������������Ȳ(��)
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-29)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "����庰 �μ����");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "�μ���-���� ��û����");

	G_addDataSet(dsLOV, null, null,  null, "LOV");


	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	G_Load(dsLIST00, null);
	
	gridLIST02.focus();
	
}
function OnLoadBefore(dataset)
{


	 if (dataset == dsLIST00)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vBudgYyyy = txtCLSE_ACC_ID.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST00")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("BUDG_YYYY",vBudgYyyy);
	}

	else if (dataset == dsLIST02)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vBudgYyyy = txtCLSE_ACC_ID.value;
		var vBudgYyyyB4 =	 parseInt(txtCLSE_ACC_ID.value.replace(/-/gi,""))-1;
		var vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		var vDeptFlag = selDeptFlag.value;
		var vAct ="";
		
		var vDeptFlag = selDeptFlag.value;
		

		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									  + D_P2("BUDG_YYYY_B4",vBudgYyyyB4)
									 + D_P2("BUDG_YYYY",vBudgYyyy)
									 + D_P2("DEPT_CODE",vDEPT_CODE)
									 + D_P2("DEPT_FLAG",vDeptFlag);
									
									 

		makeGridTitle(gridLIST02);
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

function makeGridTitle(grid)
{
	var vBudgFlagName = "";
	var vDeptFlag = selDeptFlag.value;
	var vDeptFlagName = "";

	

	var gridTitle = "";

	
	if(vDeptFlag !="ALL"){
		gridTitle += "<FC> Name=��  ID=chk_dept_name Sort=true Align=Left HeadAlign=Center     Width=80 suppress=3";
		gridTitle += "</FC>                                                                                                                               ";
	}
	if(vDeptFlag !="ALL" && vDeptFlag !="CHK_DEPT" ){
		gridTitle += "<FC> Name=�μ�  ID=DEPT_NAME Sort=true Align=Left HeadAlign=Center     Width=140 suppress=2";
		gridTitle += "</FC>                                                                                                                               ";
	}
	gridTitle += "<FC> Name=�������� ID=P_ACC_NAME Sort=true Align=Left HeadAlign=Center  SumBgColor=#d4d0c8 Width=100  suppress=1             ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<FC> Name=���� ID=ACC_NAME Sort=true Align=Left HeadAlign=Center  SumBgColor=#d4d0c8 Width=250            ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<G>name={'1��'} ID=MON1                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb1 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> 	";
	gridTitle += "	<C> Name=��� ID=cb1 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb1 Align=Right HeadAlign=Center  Width=120</C>               ";
	gridTitle += "	<C> Name=%    ID=r_cb1 Align=Right HeadAlign=Center  Width=40</C>                   ";
	gridTitle += "</G>         																			";
	gridTitle += "<G>name={'2��'} ID=MON2                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb2 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> 	";
	gridTitle += "	<C> Name=��� ID=cb2 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb2 Align=Right HeadAlign=Center  Width=120</C>               ";
	gridTitle += "	<C> Name=%    ID=r_cb2 Align=Right HeadAlign=Center  Width=40</C>                   ";
	gridTitle += "</G>         																			";
	gridTitle += "<G>name={'3��'} ID=MON3                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb3 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> 	";
	gridTitle += "	<C> Name=��� ID=cb3 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb3 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb3 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																			";
	gridTitle += "<G>name={'4��'} ID=MON4                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb4 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> 	";
	gridTitle += "	<C> Name=��� ID=cb4 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb4 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb4 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																			";
	gridTitle += "<G>name={'5��'} ID=MON5                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb5 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb5 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb5 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb5 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";
	gridTitle += "<G>name={'6��'} ID=MON6                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb6 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb6 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb6 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb6 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";
	gridTitle += "<G>name={'7��'} ID=MON7                                                                                                                             ";
	gridTitle += "	<C> Name=���� ID=b_cb7 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb7 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb7 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb7 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";
	gridTitle += "<G>name={'8��'} ID=MON8                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb8 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb8 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb8 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb8 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";
	gridTitle += "<G>name={'9��'} ID=MON9                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb9 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb9 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb9 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb9 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";
	gridTitle += "<G>name={'10��'} ID=MON10                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb10 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb10 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb10 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb10 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";
	gridTitle += "<G>name={'11��'} ID=MON11                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb11 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb11 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb11 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb11 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";
	gridTitle += "<G>name={'12��'} ID=MON12                                                                                                                             ";
	gridTitle += "	<C> Name=����  ID=b_cb12 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C> ";
	gridTitle += "	<C> Name=��� ID=cb12 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>       ";
	gridTitle += "	<C> Name=��    ID=sub_cb12 Align=Right HeadAlign=Center  Width=120</C>                        ";
	gridTitle += "	<C> Name=%    ID=r_cb12 Align=Right HeadAlign=Center  Width=40</C>                              ";
	gridTitle += "</G>         																	";

	grid.Format = gridTitle;
}
//�˻�����üũ
function condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vClseAccId   = txtCLSE_ACC_ID.value;
   	
   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("������� �����ϼ���");
   		return;
   	}
   	
   	if ( C_isNull(vClseAccId))
   	{
   		C_msgOk("ȸ�⸦  �����ϼ���");
   		return;
   	}
   	
   	return true;
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//

//�μ�
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	if (!condition_check()) return;
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
   	var vBudgYyyy   = txtCLSE_ACC_ID.value;
   	var vBudgYyyyB4 =	 parseInt(txtCLSE_ACC_ID.value.replace(/-/gi,""))-1;
       var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
   	var vDeptFlag = selDeptFlag.value;
   
  
   
   	var reportFile ="";
   
   	reportFile ="r_t_080030"; 

   	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value = "1";
	frmList.REQUEST_NAME.value = "������������Ȳ";
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	var strTemp = "";

	
	strTemp += "P_COMP_CODE__" + vCompCode;
	strTemp  += "&&P_CLSE_ACC_ID__" + vBudgYyyy;
	strTemp += "&&P_CLSE_ACC_ID_B4__" + vBudgYyyyB4;
	
	strTemp += "&&P_DEPT_CODE__" + vDeptCode;
	strTemp += "&&P_DEPT_FLAG__" + vDeptFlag;
	strTemp  += "&&P_COMP_NAME__" + vCompName;
	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// ��ȸ
function btnquery_onclick()
{
	if (!condition_check()) return;
	D_defaultLoad();
}



// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//

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

	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
}

function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");

	if (lrRet == null) return;

	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
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

	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");

	if (lrRet == null) return;

	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");

	
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


//���
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}