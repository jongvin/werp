/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLDeptForeR(���庰�濵��ȹ��������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
var			s1 = 
"	<FG> Name='�⺻����' id='G1' \n" +
"	<C> Name=����� ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=�׸�� ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=���� ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='��������' id='G2' \n" +
"		<C> Name='��    ��' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='1��' id='G3' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='2��' id='G4'  \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='3��'  id='G5' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

var			s2 = 
"	<FG> Name='�⺻����' id='G1' \n" +
"	<C> Name=����� ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=�׸�� ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=���� ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='��������' id='G2' \n" +
"		<C> Name='��    ��' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='4��'  id='G3' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='5��'  id='G4' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='6��'  id='G5' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

var			s3 = 
"	<FG> Name='�⺻����' id='G1' \n" +
"	<C> Name=����� ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=�׸�� ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=���� ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='��������' id='G2' \n" +
"		<C> Name='��    ��' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='7��'  id='G3' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='8��'  id='G4' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='9��'  id='G5' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

var			s4 = 
"	<FG> Name='�⺻����' id='G1' \n" +
"	<C> Name=����� ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=�׸�� ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=���� ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='��������' id='G2' \n" +
"		<C> Name='��    ��' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='10��'  id='G3' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='11��'  id='G4' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='12��'  id='G5' \n" +
"		<C> Name='��ȹ�ݾ�' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='�����ݾ�' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='����+����' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "���庰�濵��ȹ����",null,null,true);
	
	G_addDataSet(dsCOPY,transCopy,null,null,"����");
	G_addDataSet(dsREMOVE,transRemove,null,null,"����");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLOSE, null, null, null, "CLOSE");
	
	
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
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("QUARTER_YEAR",cboQUARTER_YEAR.value)
											+ D_P2("DEPT_NAME",txtDEPT_NAME.value);
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","COPY");
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE");
	}
	else if (dataset == dsCLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CLOSE")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("QUARTER_YEAR",cboQUARTER_YEAR.value);
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
	if(cboQUARTER_YEAR.value == "1")
	{
		gridMAIN.Format = s1;
	}
	else if(cboQUARTER_YEAR.value == "2")
	{
		gridMAIN.Format = s2;
	}
	else if(cboQUARTER_YEAR.value == "3")
	{
		gridMAIN.Format = s3;
	}
	else if(cboQUARTER_YEAR.value == "4")
	{
		gridMAIN.Format = s4;
	}
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"LEVELED_NAME");
	G_setReadOnlyCol(gridMAIN,"SUBTITLE_NAME");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_01");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_02");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_03");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_01");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_02");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_03");
}
function	CalcSum(row,colid)
{
	if(dsMAIN.NameString(row,"LV") != "2") return;
	if(dsMAIN.NameString(row,"IS_LEAF_TAG") != "T") return;
	dsMAIN.NameString(row + 1,colid) = C_convSafeFloat(dsMAIN.NameString(row - 1,colid)) + C_convSafeFloat(dsMAIN.NameString(row ,colid));
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
function	isClose()
{
	return false;
}
function	checkClose()
{
	if(isClose())
	{
		C_msgOk("�̹� �����Ǿ����ϴ�.");
		return true;
	}
	else
	{
		return false;
	}
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
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
}

// ����
function btnsave_onclick()
{
	var			lbRet = D_defaultSave(dsMAIN);
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
	if(dataset == dsMAIN)
	{
		G_Load(dsCLOSE);
		if(checkClose())
		{
			gridMAIN.Editable = false;
		}
		else
		{
			gridMAIN.Editable = true;
		}
	}
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
	if(colid != 'LEVELED_NAME' && colid != 'SUBTITLE_NAME' && colid != 'EXEC_AMT' && colid != 'PLAN_AMT_01' && colid != 'PLAN_AMT_02' && colid != 'PLAN_AMT_03')
	{
		if(dataset.NameString(row,"IS_LEAF_TAG") == "T" && dataset.NameString(row,"LV") == "2")
		{
			grid.ColumnProp(colid,'Edit') = 'Numeric';
		}
		else
		{
			grid.ColumnProp(colid,'Edit') = 'None';
		}
	}
}
function OnColumnChanged(dataset, row, colid)
{
	if(bEnter) return;
	bEnter = true;
	if(dataset == dsMAIN)
	{
		try
		{
			CalcSum(row,colid);
		}
		catch(e)
		{
		}
	}
	bEnter = false;
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
function	btnGetConsInfo_onClick()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("�� �۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return ;
		}
	}
	G_Load(dsCOPY);
	var			lsDeptCode = "";
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++i)
	{
		if(dsMAIN.NameString(i,"DEPT_CODE") == lsDeptCode)
		{
		}
		else
		{
			lsDeptCode = dsMAIN.NameString(i,"DEPT_CODE");
			G_addRow(dsCOPY);
			dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
			dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = lsDeptCode;
		}
	}
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("�����Ͽ� �������Ⱑ ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	btnRemoveAll()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	var	ret = C_msgYesNo("�� �۾��� �����Ͻø� ���� ���õ� ������ �濵��ȹ ������ ������ �����˴ϴ�.<br> ���� �۾��� �����Ͻðڽ��ϱ�?","���");
	if(ret == "N") return;
	G_Load(dsREMOVE);
	var			lsDeptCode = "";
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++i)
	{
		if(dsMAIN.NameString(i,"DEPT_CODE") == lsDeptCode)
		{
		}
		else
		{
			lsDeptCode = dsMAIN.NameString(i,"DEPT_CODE");
			G_addRow(dsREMOVE);
			dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
			dsREMOVE.NameString(dsREMOVE.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsREMOVE.NameString(dsREMOVE.RowPosition,"DEPT_CODE") = lsDeptCode;
		}
	}
	transRemove.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("�濵��ȹ���������� ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	cboQUARTER_YEAR_onChange()
{
	processGridTitle();
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
}
