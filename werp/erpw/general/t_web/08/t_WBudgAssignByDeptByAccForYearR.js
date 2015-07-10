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
		var vBudgYyyy    = txtCLSE_ACC_ID.value;
		var vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		var vDeptFlag = selDeptFlag.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
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
		gridTitle += "<FC> Name=�μ�  ID=DEPT_NAME Sort=true Align=Left HeadAlign=Center     Width=80 suppress=2";
		gridTitle += "</FC>                                                                                                                               ";
	}
	
	gridTitle += "<FC> Name=�������� ID=p_acc_name Sort=true Align=left HeadAlign=Center    Width=100    suppress=1           ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<FC> Name=���� ID=ACC_NAME Sort=true Align=Left HeadAlign=Center   Width=200               ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<G>name={'1��'}    ID=MON_1                                                                                                                  ";
	gridTitle += "	<C> Name=���� ID=pb1 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s1 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r1 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'2��'}    ID=MON_2                                                                                                                ";
	gridTitle += "	<C> Name=���� ID=pb2 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s2 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r2 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'3��'}  ID=MON_3                                                                                                                    ";
	gridTitle += "	<C> Name=���� ID=pb3 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s3 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r3 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'1/4 �б�'}   ID=MON_14                                                                                                              ";
	gridTitle += "	<C> Name=���� ID=pb14 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=��� ID=s14 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r14 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'4��'}  ID=MON_4                                                                                                                    ";
	gridTitle += "	<C> Name=���� ID=pb4 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s4 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r4 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'5��'}   ID=MON_5                                                                                                                   ";
	gridTitle += "	<C> Name=���� ID=pb5 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s5 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r5 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'6��'}   ID=MON_6                                                                                                                   ";
	gridTitle += "	<C> Name=���� ID=pb6 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s6 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r6 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'2/4 �б�'}     ID=MON_24                                                                                                            ";
	gridTitle += "	<C> Name=���� ID=pb24 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=��� ID=s24 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r24 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'���ݱ�'}     ID=MON_b                                                                                                              ";
	gridTitle += "	<C> Name=���� ID=pb012 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=��� ID=s012 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=%    ID=r012 Align=Right HeadAlign=Center  Width=40</C>                                                                 ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'7��'}       ID=MON_7                                                                                                              ";
	gridTitle += "	<C> Name=���� ID=pb7 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s7 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r7 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'8��'}       ID=MON_8                                                                                                               ";
	gridTitle += "	<C> Name=���� ID=pb8 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s8 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r8 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'9��'}        ID=MON_9                                                                                                              ";
	gridTitle += "	<C> Name=���� ID=pb9 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=��� ID=s9 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r9 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'3/4 �б�'}     ID=MON_34                                                                                                            ";
	gridTitle += "	<C> Name=���� ID=pb34 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=��� ID=s34 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r34 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'10��'}          ID=MON_10                                                                                                           ";
	gridTitle += "	<C> Name=���� ID=pb10 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=��� ID=s10 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r10 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'11��'}     ID=MON_11                                                                                                                ";
	gridTitle += "	<C> Name=���� ID=pb11 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=��� ID=s11 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r11 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'12��'}             ID=MON_12                                                                                                       ";
	gridTitle += "	<C> Name=���� ID=pb12 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=��� ID=s12 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r12 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'4/4 �б�'}       ID=MON_44                                                                                                          ";
	gridTitle += "	<C> Name=���� ID=pb44 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=��� ID=s44 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r44 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'�Ĺݱ�'}           ID=MON_p                                                                                                        ";
	gridTitle += "	<C> Name=���� ID=pb022 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=��� ID=s022 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=%    ID=r022 Align=Right HeadAlign=Center  Width=40</C>                                                                 ";
	gridTitle += "</G>                                                                                                                                ";
	grid.Format = gridTitle;
}
//�˻�����üũ
function print_condition_check()
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
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//

//�μ�
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	print_condition_check();
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	var vClseAccId   = txtCLSE_ACC_ID.value;
	var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
	var vDeptFlag = selDeptFlag.value;

	var strTemp = "";
   
  	if (sPrtDiv=='1')
  	{
  		if(vDeptFlag == "ALL")
  		{
	   		reportFile ="r_t_080000_a";  //��ݱ�
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
  		else if(vDeptFlag == "CHK_DEPT")
  		{
	   		reportFile ="r_t_080000_b";  //��ݱ�
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
  		else if(vDeptFlag == "DEPT")
  		{
	   		reportFile ="r_t_080000_c";  //��ݱ�
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
   	}
   	else
   	{
  		if(vDeptFlag == "ALL")
  		{
	   		reportFile ="r_t_080000_2_a";  //�Ϲݱ�
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
	   	}
  		else if(vDeptFlag == "CHK_DEPT")
  		{
	   		reportFile ="r_t_080000_2_b";  //�Ϲݱ�
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
  		else if(vDeptFlag == "DEPT")
  		{
	   		reportFile ="r_t_080000_2_c";  //�Ϲݱ�
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
	}
   
   	
   	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value = "1";
	frmList.REQUEST_NAME.value = "�μ���������������Ȳ";
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	

	
	
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
function btnPreView_onClick(div)
{
	sPrtDiv = div;
	btnquery_prt_onclick();
}