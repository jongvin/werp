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

	G_addDataSet(dsLIST02, null, null, sSelectPageName+D_P1("ACT","LIST02")	, "�μ���-���� ��û����");
	
	G_addDataSet(dsLOV, null, null,  null, "LOV");

	

	G_addRelCol(dsLIST00, "COMP_CODE", "COMP_CODE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	
	G_Load(dsLIST00, null);
	
	//gridLIST02.focus();
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
		
		//makeGridTitle(gridLIST02);
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
	var	sPrtDiv = selDiv.value;
   
  	
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
   
   	
   	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
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
		
		//G_Load(dsLIST02, null);
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
	
	
	D_defaultLoad();
	
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
function deptFlag_onChange()
{
	G_Load(dsLIST02,null);	
}
//���
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}