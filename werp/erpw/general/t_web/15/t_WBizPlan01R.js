/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLDeptForeR(���庰�濵��ȹ��������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
var			s1;
var			BesClseAccId;
var			AfsClseAccId;

function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, null, "���Ͱ�꼭",null,null,true);
	
	cboQUARTER_YEAR.value = sQUARTER_YEAR;
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	processGridTitle();
	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID_BF",BesClseAccId)
											+ D_P2("CLSE_ACC_ID_NW",sClseAccId)
											+ D_P2("CLSE_ACC_ID_AF",AfsClseAccId)
											+ D_P2("START_MM_MIN",vMon1)
											+ D_P2("START_MM_MID",vMon2)
											+ D_P2("START_MM_MAX",vMon3)
											+ D_P2("BASE_AMT",1000000);
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
function	processGridTitle()
{
	sClseAccId = txtCLSE_ACC_ID.value ;
	BesClseAccId = C_convSafeFloat(sClseAccId) - 1 ;
	AfsClseAccId = C_convSafeFloat(sClseAccId) + 1 ;
	var vBungi = cboQUARTER_YEAR.value;
		
 	if(vBungi=='1')
 	{
 		vMon1 ='01';
		vMon2 ='02';
		vMon3 ='03';	
 	}
 	else if(vBungi=='2')
 	{
 		vMon1 ='04';
		vMon2 ='05';
		vMon3 ='06';
 	}
 	else if(vBungi=='3')
 	{
 		vMon1 ='07';
		vMon2 ='08';
		vMon3 ='09';
 	}
 	else if(vBungi=='4')
 	{
 		vMon1 ='10';
		vMon2 ='11';
		vMon3 ='12';
 	}
	var vMon = vMon1 - 1 ;
		
	s1 = 
"	<FC> Name='�׸�' id='BIZ_PLAN_ITEM_NAME' Width=95 BgColor ='#ECF5EB' </FC>	\n" +
"	<FC> Name="+BesClseAccId+"'�����' id='BF_Y_EXEC_AMT' decao='4' Width=95 BgColor ='#FFFCE0' </FC>	\n" +
"	<G> Name="+sClseAccId+"'�� 1 ~ '"+vMon+"�� id='G1'   \n" +
"	<C> Name='����' ID=BF_Y_BM_EXEC_AMT	decao='4' Width=95 </C>	\n" +
"	<C> Name='��ȹ' ID=NW_Y_BM_PLAN_AMT	decao='4' Width=95 </C>	\n" +
"	<C> Name='����' ID=NW_Y_BM_EXEC_AMT	decao='4' Width=95 </C>	\n" +
"	<C> Name='��ȹ��' ID=NW_BM_P_E_SUB	decao='4' Width=95 </C>	\n" +
"	<C> Name='�����' ID=NW_BM_B_E_SUM	decao='4' Width=95 </C>	\n" +
"	</G> \n" +
"	<G> Name="+sClseAccId+"'�� �ش�б�' id='G2'   \n" +
"	<C> Name="+vMon1+"'�� ��ȹ' ID=NW_Y_NM_PLAN_AMT_01	 	decao='4' Width=95 </C>	\n" +
"	<C> Name="+vMon1+"'�� ����' ID=NW_Y_NM_FOR_AMT_01		 	decao='4'	Width=95 </C>	\n" +
"	<C> Name="+vMon2+"'�� ��ȹ' ID=NW_Y_NM_PLAN_AMT_02	 	decao='4'	Width=95 </C>	\n" +
"	<C> Name="+vMon2+"'�� ����' ID=NW_Y_NM_FOR_AMT_02		 	decao='4'	Width=95 </C>	\n" +
"	<C> Name="+vMon3+"'�� ��ȹ' ID=NW_Y_NM_PLAN_AMT_03	 	decao='4'	Width=95 </C>	\n" +
"	<C> Name="+vMon3+"'�� ����' ID=NW_Y_NM_FOR_AMT_03		 	decao='4'	Width=95 </C>	\n" +
"	</G> \n" +
"	<G> Name="+sClseAccId+"' �Ⱓ' id='G3'   \n" +
"	<C> Name='�Ⱓ��ȹ' ID=NW_Y_PLAN_AMT	decao='4' Width=95 </C>	\n" +
"	<C> Name='�Ⱓ����' ID=NW_Y_FOR_AMT		decao='4' Width=95 </C>	\n" +
"	<C> Name='��ȹ��' 	ID=NW_P_E_SUB			decao='4' Width=95 </C>	\n" +
"	<C> Name='�����' 	ID=NW_B_E_SUM			decao='4' Width=95 </C>	\n" +
"	</G> \n" +
"	<G> Name="+AfsClseAccId+"'��' id='G4'   \n" +
"	<C> Name='��ȹ' 	ID=AF_Y_PLAN_AMT	decao='4' Width=95 </C>	\n" +
"	<C> Name='�����' ID=AF_P_E_SUM	decao='4' Width=95 </C>	\n" +
"	</G> \n" ;	
	gridMAIN.Format = s1;

}
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("���� ȸ�⸦ �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!checkConditions()) return;
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
}

// ����
function btninsert_onclick()
{
	
}

// ����
function btndelete_onclick()
{
}

// ����
function btnsave_onclick()
{

}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}

function OnLoadCompleted(dataset, rowcnt)
{

}
function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
}

function OnRowDeleteBefore(dataset)
{
	return false;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{

}
function OnColumnChanged(dataset, row, colid)
{

}

function OnExit(dataset, grid, row, colid, olddata)
{
}
function OnClick(dataset, grid, row, colid)
{
}
	
function OnPopup(dataset, grid, row, colid, data)
{
}
function OnPostBefore(dataset, trans)
{
	return true;
}
function	OnSuccess(dataset,trans)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//

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
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";

	dsMAIN.ClearData();
}

function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
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
	
	processGridTitle();
	btnquery_onclick();

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
	
	dsMAIN.ClearData();
}

function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	processGridTitle();
	btnquery_onclick();

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
function	cboQUARTER_YEAR_onChange()
{
	processGridTitle();
	btnquery_onclick();
}
