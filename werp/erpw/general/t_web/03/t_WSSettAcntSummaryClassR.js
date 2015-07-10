/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSSettAcntSummaryR(재무제표집계및조회(사업장별부서))
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			vACCOUNT_EDT;
var			L_findCol = "";
var			L_findText = "";
var			L_findUpper = false;
var			autopopval;
var			autopopval2;
var			strSheetFormat =
	"<FC> Name=코드 ID=ITEM_CODE Width=80 show='false'\n"+
	"</FC>\n"+
	"<C> Name=항목명 ID='ITEM_NAME' Width=280 Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'black',5,'black',6,'black')} \n"+
	"</C>\n"+
	"<G> Name='당기' id=G1 \n"+
	"	<C> Name='당기금액(좌)' ID='CURR_LEFT' Width=120 BgColor=#FFECEC VALUE={Decode(CURR_LEFT,0,'', CURR_LEFT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='당기금액(우)' ID='CURR_RIGHT' Width=120 BgColor=#FFECEC VALUE={Decode(CURR_RIGHT ,0,'', CURR_RIGHT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"</G>\n"+
	"<G> Name='전기' id=G2 \n"+
	"	<C> Name='전기금액(좌)' ID='PAST_LEFT' Width=120 BgColor=#E0F4FF VALUE={Decode(PAST_LEFT ,0,'', PAST_LEFT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='전기금액(우)' ID='PAST_RIGHT' Width=120 BgColor=#E0F4FF VALUE={Decode(PAST_RIGHT ,0,'', PAST_RIGHT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"</G>";
var			strSheetFormat1 =
	"<FC> Name=코드 ID=ITEM_CODE Width=80 show='false'\n"+
	"</FC>\n"+
	"<C> Name=항목명 ID='ITEM_NAME' Width=280 Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'black',4,'black',5,'black',6,'black')} \n"+
	"</C>\n"+
	"<G> Name='당기' id=G1 \n"+
	"	<C> Name='당기금액(좌)' ID='CURR_LEFT' Width=120 BgColor=#FFECEC VALUE={Decode(CURR_LEFT,0,'', CURR_LEFT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='당기금액(우)' ID='CURR_RIGHT' Width=120 BgColor=#FFECEC VALUE={Decode(CURR_RIGHT ,0,'', CURR_RIGHT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"</G>\n"+
	"<G> Name='전기' id=G2 \n"+
	"	<C> Name='전기금액(좌)' ID='PAST_LEFT' Width=120 BgColor=#E0F4FF VALUE={Decode(PAST_LEFT ,0,'', PAST_LEFT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='전기금액(우)' ID='PAST_RIGHT' Width=120 BgColor=#E0F4FF VALUE={Decode(PAST_RIGHT ,0,'', PAST_RIGHT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"</G>";
var			strSheetFormat2 =
	"<FC> Name=코드 ID=ITEM_CODE Width=80 show='false'\n"+
	"</FC>\n"+
	"<C> Name=항목명 ID='ITEM_NAME' Width=280 Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} \n"+
	"</C>\n"+
	"<G> Name='당기' id=G1 \n"+
	"	<C> Name='당기금액(좌)' ID='CURR_LEFT' Width=120 BgColor=#FFECEC VALUE={Decode(CURR_LEFT,0,'', CURR_LEFT)} Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='당기금액(우)' ID='CURR_RIGHT' Width=120 BgColor=#FFECEC VALUE={Decode(CURR_RIGHT ,0,'', CURR_RIGHT)} Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"</G>\n"+
	"<G> Name='전기' id=G2 \n"+
	"	<C> Name='전기금액(좌)' ID='PAST_LEFT' Width=120 BgColor=#E0F4FF VALUE={Decode(PAST_LEFT ,0,'', PAST_LEFT)} Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='전기금액(우)' ID='PAST_RIGHT' Width=120 BgColor=#E0F4FF VALUE={Decode(PAST_RIGHT ,0,'', PAST_RIGHT)} Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"</G>";
var			strSheetFormat3 =
	"<FC>id=ITEM_NAME	name='항목명' width=230 Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} </FC> \n"+
	"<R> \n"+
	"   <G>name=$xkeyname_$$ id=G1$xkeyname_$$\n"+
	"	   <C>id=CURR_AMT_$$	name='당기금액'	width=120 BgColor=#FFECEC Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} </C> \n"+
	"	   <C>id=PAST_AMT_$$	name='전기금액'	width=120 BgColor=#E0F4FF Color={Decode(ITEM_LVL,1,'#FF0000',2,'black',3,'black',4,'black',5,'black',6,'black')} </C> \n"+
	"	</G> \n"+
	"</R>";
var			strTChartFormat =
	"<FC> Name=코드 ID=ITEM_CODE Width=80 show='false'\n"+
	"</FC>\n"+
	"<G> Name='차변' id=G1 \n"+
	"	<C> Name='잔액' ID='CURR_LEFT_REM' Width=120 BgColor=#FFFCE0 VALUE={Decode(CURR_LEFT_REM,0,'', CURR_LEFT_REM)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='합계' ID='CURR_LEFT' Width=120 BgColor=#FFECEC VALUE={Decode(CURR_LEFT,0,'', CURR_LEFT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"</G>\n"+
	"<C> Name=항목명 ID='ITEM_NAME' Width=280 Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'black',6,'black')} \n"+
	"</C>\n"+
	"<G> Name='대변' id=G2 \n"+
	"	<C> Name='합계' ID='CURR_RIGHT' Width=120 BgColor=#E0F4FF VALUE={Decode(CURR_RIGHT ,0,'', CURR_RIGHT)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'black',6,'black')} \n"+
	"	</C>\n"+
	"	<C> Name='잔액' ID='CURR_RIGHT_REM' Width=120 BgColor=#FFFCE0 VALUE={Decode(CURR_RIGHT_REM ,0,'', CURR_RIGHT_REM)} Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'black',6,'black')} \n"+
	"	</C>"+
	"</G>\n";
function Initialize()
{
	G_addDataSet(dsSHEET_CODE, null, null, null, "재무제표종류");
	G_addDataSet(dsHEAD, trans, null, null, "재무제표작성정보");
	G_addDataSet(dsCOMPANY, null, null, null, "사업장");
	G_addDataSet(dsACC_ID, null, null, null, "회기");
	G_addDataSet(dsSEARCH, null, null, "", "LOV");
	G_addDataSet(dsMAIN, null, gridMAIN, null, "재무제표");
	G_addDataSet(dsFULL_PROJ, null, null, null, "전부서원가명세서");
	G_addDataSet(dsMAKE, transMake, null, null, "재무제표작성");
	G_addDataSet(dsCLASS_CODE, null, null, null, "부서코드");
	G_addDataSet(dsSHEET_DEL, null, null, null, "HEAD삭제");

	G_Load(dsSHEET_CODE, null);
	G_Load(dsMAKE, null);


	autopopval = new AutoPopWhenChange(dsSEARCH,"T_CLASS_CODE2",txtCLASS_CODE_NAME,"autopopval",true);
	autopopval.SetArgBind("SEARCH_CONDITION",txtCLASS_CODE_NAME,"value");
	autopopval.SetReturnBind("CLASS_CODE",txtCLASS_CODE,"value");
	autopopval.SetReturnBind("CLASS_CODE_NAME",txtCLASS_CODE_NAME,"value");

	autopopval2 = new AutoPopWhenChange(dsSEARCH,"T_CLASS_CODE2",txtCLASS_CODE,"autopopval2",true);
	autopopval2.SetArgBind("SEARCH_CONDITION",txtCLASS_CODE,"value");
	autopopval2.SetReturnBind("CLASS_CODE",txtCLASS_CODE,"value");
	autopopval2.SetReturnBind("CLASS_CODE_NAME",txtCLASS_CODE_NAME,"value");

	txtCLASS_CODE.attachEvent ("onblur", txtCLASS_CODE_onBlur);
	txtCLASS_CODE_NAME.attachEvent ("onblur", txtCLASS_CODE_NAME_onBlur);
	EnableDisableProjCode();

	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	if(chkCLASS_CODE.checked)
	{
		txtCLASS_CODE.value ="";
		txtCLASS_CODE_NAME.value ="";
		txtCLASS_CODE.readOnly=true;
		txtCLASS_CODE.style.backgroundColor = "#EFEFEF";
		btnSearchProj.disabled  = true;
		document.all.divgridMAIN.style.display 	= 'none';
		document.all.divgridMAIN1.style.display 	= '';
	}
	else
	{
		txtCLASS_CODE.readOnly=false;
		txtCLASS_CODE.style.backgroundColor = "#ffffff";
		btnSearchProj.disabled = false;
		document.all.divgridMAIN.style.display 	= '';
		document.all.divgridMAIN1.style.display 	= 'none';
	}
	
	gridMAIN1.attachEvent ("OnCommand", new Function("code", "text", "L_OnCommand(" + dsCFULL_PROJ.id + ", " + gridMAIN1.id + ", code, text);"));
	gridMAIN1.attachEvent ("OnRButtonDown", new Function("row", "colid", "xpos", "ypos", "G_OnRButtonDown(" + dsCFULL_PROJ.id + ", " + gridMAIN1.id + ", row, colid, xpos, ypos);"));
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("SHEET_CODE",cboSHEET_CODE.BindColVal)
										+ D_P2("COMP_CODE",txtCOMP_CODE.value)
										+ D_P2("CLASS_CODE",(C_isNull(txtCLASS_CODE.value)? "%":txtCLASS_CODE.value));
	}
	else if(dataset == dsFULL_PROJ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FULL_PROJ")
										+ D_P2("SHEET_CODE",cboSHEET_CODE.BindColVal)
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
	}
	else if(dataset == dsSHEET_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SHEET_CODE");
	}
	else if(dataset == dsCOMPANY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COMPANY");
	}
	else if(dataset == dsMAKE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE");
	}
	else if(dataset == dsHEAD)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","HEAD")
										+ D_P2("SHEET_CODE",cboSHEET_CODE.BindColVal)
										+ D_P2("COMP_CODE",txtCOMP_CODE.value)
										+ D_P2("CLASS_CODE",(C_isNull(txtCLASS_CODE.value)? "%":txtCLASS_CODE.value));
	}
	else if(dataset == dsACC_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ACC_ID")
										+ D_P2("ACCOUNT_FDT",vACCOUNT_EDT);
	}
	else if(dataset == dsCLASS_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CLASS_CODE");
	}
	else if(dataset == dsSHEET_DEL)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SHEET_DEL")
										+ D_P2("SHEET_CODE",cboSHEET_CODE.BindColVal)
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

// 함수관련---------------------------------------------------------------------//
function L_OnCommand(dataset, grid, code, text)
{
	try
	{
		// 개발자 정의 함수 Call
		OnCommand(dataset, grid, code, text);
	}
	catch (e)
	{
		// 아래 코드는 평상시에는 반드시 주석 처리한다. 디버깅 목적으로 사용.
		//C_msgOk("G_OnCommand 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		if (typeof(OnCommand) == "function")
		{
			C_msgOk("G_OnCommand 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}

	try
	{
		if (code == "14")
		{
			var datasetinfo = G_searchDataSetInfo(dataset.id);
			
			gridMAIN1.RunExcel("재무제표");
		}
	}
	catch (e)
	{
		C_msgOk("G_OnCommand 이벤트 에러 : " + e.message, "에러");
	}
}

function L_findWindow(dataset, grid)
{
	try
	{
		var args = new Array();
		var ret = null;
		
		args[0] = dataset;
		args[1] = grid;
		
		ret = window.showModalDialog("alertFind.jsp?COL=" + gridMAIN1.GetColumn() + "&TEXT=" + L_findText + "&UPPER=" + L_findUpper, args, "center:yes; dialogWidth:378px; dialogHeight:186px; status:no; help:no; scroll:no");
		
		if (ret == null || ret.length < 4) return;
		
		L_findCol = ret[1];
		L_findText = ret[2];
		L_findUpper = ret[3];
		
		L_find(dataset, L_findCol, L_findText, L_findUpper, false);
		gridMAIN1.Focus();
	}
	catch (e)
	{
		C_msgOk("L_findWindow 에러 : " + e.message, "에러");
	}
}

function	AutoPopWhenChange(arDataSet,asLOVName,arTextControl,varName,abIfNullClear)
{
	this.Dataset = arDataSet;
	this.LOVName = asLOVName;
	this.VarName = varName;
	this.TextControl = arTextControl;
	this.OldValue = arTextControl.value;
	this.OldOnBlur = arTextControl.onblur;
	this.OldOnFocus = arTextControl.onfocus;
	this.NewOnBlur = autoPopOnBlur;
	this.NewOnFocus = autoPopOnFocus;
	arTextControl.attachEvent ("onblur", new Function("autoPopOnBlur("+arTextControl.id+"," + varName + ");"));
	arTextControl.attachEvent ("onfocus", new Function("autoPopOnFocus("+arTextControl.id+"," + varName + ");"));
	this.Args = new C_Dictionary();
	this.ArgInfo = new C_Dictionary();
	this.ReturnInfo = new C_Dictionary();
	this.SetArgBind = setArgBind;
	this.SetReturnBind = setReturnBind;
	this.SetArgConst = setArgConst;
	this.NullClear = abIfNullClear;
}
function	AutoPopArgInfo(arControl,arControlAttribute,asArgName,abConst)
{
	this.RelControl = arControl;
	this.RelControlAttr = arControlAttribute;
	this.ArgName = asArgName;
	this.IsConst = abConst;
}
function	setArgConst(asArgName,asConst)
{
	this.ArgInfo.set(asArgName,new AutoPopArgInfo(null,asConst,asArgName,true));
}
function	setArgBind(asArgName,arControl,arControlAttribute)
{
	this.ArgInfo.set(asArgName,new AutoPopArgInfo(arControl,arControlAttribute,asArgName,false));
}
function	setReturnBind(asArgName,arControl,arControlAttribute)
{
	this.ReturnInfo.set(asArgName,new AutoPopArgInfo(arControl,arControlAttribute,asArgName,false));
}
function	autoPopOnFocus(objtarget,objvar)
{
	objvar.OldValue = objtarget.value;
}
function	autoPopOnBlur(objtarget,objvar)
{
	var			strOldBack = objvar.OldValue;
	var			arrKeys;
	var			arrItems;
	if(objtarget.value == objvar.OldValue)
	{
		return;
	}
	if(C_isNull(objtarget.value) && objvar.NullClear)
	{
		arrKeys = objvar.ReturnInfo.keys();
		arrItems = objvar.ReturnInfo.items();
		for (var i = 0; i < arrKeys.length; i++)
		{
			var		lrInfo = arrItems[i];
			lrInfo.RelControl.setAttribute(lrInfo.RelControlAttr,"");
		}
		return;
	}
	arrKeys = objvar.ArgInfo.keys();
	arrItems = objvar.ArgInfo.items();
	objvar.Args.removeAll();
	for (var i = 0; i < arrKeys.length; i++)
	{
		var		lrInfo = arrItems[i];
		if(lrInfo.IsConst)
		{
			objvar.Args.set(lrInfo.ArgName,lrInfo.RelControlAttr);
		}
		else
		{
			objvar.Args.set(lrInfo.ArgName,lrInfo.RelControl.getAttribute(lrInfo.RelControlAttr));
		}
	}
	var		lrRet = C_AutoLov(objvar.Dataset,objvar.LOVName,objvar.Args);
	if(lrRet == null)
	{
		objtarget.value = strOldBack;
		objtarget.focus();
		return;
	}
	arrKeys = objvar.ReturnInfo.keys();
	arrItems = objvar.ReturnInfo.items();
	for (var i = 0; i < arrKeys.length; i++)
	{
		var		lrInfo = arrItems[i];
		lrInfo.RelControl.setAttribute(lrInfo.RelControlAttr,lrRet.get(lrInfo.ArgName));
	}

}
function	SafeToNumber(asValue)
{
	try
	{
		return parseInt(asValue);
	}
	catch(e)
	{
		return 0;
	}
}
function	Retrieve()
{
	G_Load(dsHEAD, null);
	txtCURR_ACC_ID.value    = dsHEAD.NameString(dsHEAD.CountRow,"CURR_ACC_ID");
	txtCURR_ACC_FDT.value   = dsHEAD.NameString(dsHEAD.CountRow,"CURR_ACC_FDT");
	txtCURR_ACC_EDT.value   = dsHEAD.NameString(dsHEAD.CountRow,"CURR_ACC_EDT");
	txtPAST_ACC_ID.value    = dsHEAD.NameString(dsHEAD.CountRow,"PAST_ACC_ID");
	txtPAST_ACC_FDT.value   = dsHEAD.NameString(dsHEAD.CountRow,"PAST_ACC_FDT");
	txtPAST_ACC_EDT.value   = dsHEAD.NameString(dsHEAD.CountRow,"PAST_ACC_EDT");
	txtEDIT_DT.value        = dsHEAD.NameString(dsHEAD.CountRow,"EDIT_DT");
}

function	EnableDisableProjCode()
{
	if(txtCOMP_CODE.value == "%")
	{
		txtCLASS_CODE.readOnly = true;
		txtCLASS_CODE.value = "";
		txtCLASS_CODE_NAME.value = "";
	}
	else
	{
		txtCLASS_CODE.readOnly = false;
	}
}
function	ChangeFormat()
{
	var			strSHEET_TYPE;
	strSHEET_TYPE = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE");
	if(strSHEET_TYPE == "3")	//T_Chart
	{
		gridMAIN.Format = strTChartFormat;
	}
	else if(strSHEET_TYPE == "1")
	{
		gridMAIN.Format = strSheetFormat;
	}
	else if(strSHEET_TYPE == "2")
	{
		gridMAIN.Format = strSheetFormat1;
	}
	else if(strSHEET_TYPE == "4")
	{
		gridMAIN.Format = strSheetFormat2;
		gridMAIN1.Format = strSheetFormat3;
	}
}
function	InsertIntoHead()
{
	dsHEAD.ClearData();
	G_Load(dsSHEET_DEL);
	if(chkCLASS_CODE.checked)
	{
		for(i = 1; i <= dsCLASS_CODE.CountRow; i++)
		{
			G_addRow(dsHEAD);
			dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE")     = dsCLASS_CODE.NameString(i,"CLASS_CODE");
			dsHEAD.NameString(dsHEAD.RowPosition,"CURR_ACC_ID")   = txtCURR_ACC_ID.value;
			dsHEAD.NameString(dsHEAD.RowPosition,"CURR_ACC_FDT")  = txtCURR_ACC_FDT.value;
			dsHEAD.NameString(dsHEAD.RowPosition,"CURR_ACC_EDT")  = txtCURR_ACC_EDT.value;
			dsHEAD.NameString(dsHEAD.RowPosition,"PAST_ACC_ID")   = txtPAST_ACC_ID.value;
			dsHEAD.NameString(dsHEAD.RowPosition,"PAST_ACC_FDT")  = txtPAST_ACC_FDT.value;
			dsHEAD.NameString(dsHEAD.RowPosition,"PAST_ACC_EDT")  = txtPAST_ACC_EDT.value;
			dsHEAD.NameString(dsHEAD.RowPosition,"EDIT_DT")       = txtEDIT_DT.value;
		}
		G_addRow(dsHEAD);
		dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE")     = "%";
		dsHEAD.NameString(dsHEAD.RowPosition,"CURR_ACC_ID")   = txtCURR_ACC_ID.value;
		dsHEAD.NameString(dsHEAD.RowPosition,"CURR_ACC_FDT")  = txtCURR_ACC_FDT.value;
		dsHEAD.NameString(dsHEAD.RowPosition,"CURR_ACC_EDT")  = txtCURR_ACC_EDT.value;
		dsHEAD.NameString(dsHEAD.RowPosition,"PAST_ACC_ID")   = txtPAST_ACC_ID.value;
		dsHEAD.NameString(dsHEAD.RowPosition,"PAST_ACC_FDT")  = txtPAST_ACC_FDT.value;
		dsHEAD.NameString(dsHEAD.RowPosition,"PAST_ACC_EDT")  = txtPAST_ACC_EDT.value;
		dsHEAD.NameString(dsHEAD.RowPosition,"EDIT_DT")       = txtEDIT_DT.value;
	}
	else
	{
		if(dsHEAD.CountRow >= 1) return;
		G_addRow(dsHEAD);
		dsHEAD.NameString(dsHEAD.CountRow,"CLASS_CODE") = C_isNull(txtCLASS_CODE.value)? "%":txtCLASS_CODE.value ;
		dsHEAD.NameString(dsHEAD.CountRow,"CURR_ACC_ID")   = txtCURR_ACC_ID.value;
		dsHEAD.NameString(dsHEAD.CountRow,"CURR_ACC_FDT")  = txtCURR_ACC_FDT.value;
		dsHEAD.NameString(dsHEAD.CountRow,"CURR_ACC_EDT")  = txtCURR_ACC_EDT.value;
		dsHEAD.NameString(dsHEAD.CountRow,"PAST_ACC_ID")   = txtPAST_ACC_ID.value;
		dsHEAD.NameString(dsHEAD.CountRow,"PAST_ACC_FDT")  = txtPAST_ACC_FDT.value;
		dsHEAD.NameString(dsHEAD.CountRow,"PAST_ACC_EDT")  = txtPAST_ACC_EDT.value;
		dsHEAD.NameString(dsHEAD.CountRow,"EDIT_DT")       = txtEDIT_DT.value;
	}
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check
	//if (!condition_check()) return;
		
	var vCompName  = txtCOMPANY_NAME.value;

       var strSHEET_CODE;
	strSHEET_CODE = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_CODE");

	if(dsHEAD.NameString(dsHEAD.RowPosition,"COMP_CODE")=="") {
		C_msgOk("집계데이터가 먼저 조회(생성)되어야 합니다.","알림");
		return;
	}
  
   	var reportFile ="";
   	var strTemp = "";

	strTemp += "pCOMP_CODE__" + dsHEAD.NameString(dsHEAD.RowPosition,"COMP_CODE");
   	strTemp += "&&pSHEET_CODE__" + dsHEAD.NameString(dsHEAD.RowPosition,"SHEET_CODE");
	//strTemp += "pCOMP_CODE__" + txtCOMP_CODE.value;
   	//strTemp += "&&pSHEET_CODE__" + cboSHEET_CODE.BindColVal;
   	
	if ((strSHEET_CODE == "01"))
	{
   		reportFile ="r_t_030006"; 
   		frmList.REQUEST_NAME.value = "대차대조표"; 
   		strTemp += "&&pCLASS_CODE__" + dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE");	
	}
	else if ((strSHEET_CODE == "02"))
	{
		reportFile ="r_t_030007"; 
   		frmList.REQUEST_NAME.value = "손익계산서";
   		strTemp += "&&pCLASS_CODE__" + dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE");	
	}
	else if ((strSHEET_CODE == "03"))
	{
		reportFile ="r_t_030005"; 
   		frmList.REQUEST_NAME.value = "합계잔액시산표";
   		strTemp += "&&pCLASS_CODE__" + dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE");	
	}	
	else if ((strSHEET_CODE == "04"))
	{
		reportFile ="r_t_030008"; 
   		frmList.REQUEST_NAME.value = "공사원가명세서";
	}
	else if ((strSHEET_CODE == "05"))
	{
		reportFile ="r_t_030008"; 
   		frmList.REQUEST_NAME.value = "분양원가명세서";
   	}
	
	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value = "1";
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 조회
function btnquery_onclick()
{
	Retrieve();
}

// 추가
function btnadd_onclick()
{
}

// 삽입
function btninsert_onclick()
{
}

// 삭제
function btndelete_onclick()
{
}

// 저장
function btnsave_onclick()
{
	D_defaultSave(dsHEAD);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "CURR_ACC_FDT")
	{
		txtCURR_ACC_FDT.value = asDate;
		txtCURR_ACC_FDT_onchange();
	}
	else if (asCalendarID == "CURR_ACC_EDT")
	{
		txtCURR_ACC_EDT.value = asDate;
		txtCURR_ACC_EDT_onchange();
	}
	else if (asCalendarID == "PAST_ACC_FDT")
	{
		txtPAST_ACC_FDT.value = asDate;
		txtPAST_ACC_FDT_onchange();
	}
	else if (asCalendarID == "PAST_ACC_EDT")
	{
		txtPAST_ACC_EDT.value = asDate;
		txtPAST_ACC_EDT_onchange();
	}
	else if (asCalendarID == "EDIT_DT")
	{
		txtEDIT_DT.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsHEAD)
	{
		if(chkCLASS_CODE.checked)
		{
			G_Load(dsFULL_PROJ);
		}
		else
		{
			G_Load(dsMAIN);
		}
		
		var			strSHEET_TYPE;
		strSHEET_TYPE = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE");
		if(strSHEET_TYPE != "3")	//T_Chart
		{
			var pRowIdx = dsMAIN.ValueRow(20,'9999999999');
			if (pRowIdx != 0)
			{
				G_deleteRow(dsMAIN,pRowIdx);
			}
		}
	}
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if(row < 1) return;
	if(dataset == dsHEAD)
	{
		dsHEAD.NameString(row,"SHEET_CODE") = cboSHEET_CODE.BindColVal;
		dsHEAD.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
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
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}
function	OnRowPosChanged(dataset, row)
{
	if(dataset == dsSHEET_CODE)
	{
		if(row < 1) return;
		if ((dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE") == "1")
				|| (dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE") == "3"))
		{
			document.all.txtCURR_ACC_FDT.readOnly	         = true;
			document.all.txtCURR_ACC_FDT.style.background	= "#EFEFEF";
			document.all.txtCURR_ACC_EDT.readOnly	         = false;
			document.all.txtCURR_ACC_EDT.style.background	= "white";
			document.all.txtPAST_ACC_FDT.readOnly	         = true;
			document.all.txtPAST_ACC_FDT.style.background	= "#EFEFEF";
			document.all.txtPAST_ACC_EDT.readOnly	         = true;
			document.all.txtPAST_ACC_EDT.style.background	= "#EFEFEF";
		}
		else
		{
			document.all.txtCURR_ACC_FDT.readOnly	         = false;
			document.all.txtCURR_ACC_FDT.style.background	= "white";
			document.all.txtCURR_ACC_EDT.readOnly	         = false;
			document.all.txtCURR_ACC_EDT.style.background	= "white";
			document.all.txtPAST_ACC_FDT.readOnly	         = false;
			document.all.txtPAST_ACC_FDT.style.background	= "white";
			document.all.txtPAST_ACC_EDT.readOnly	         = false;
			document.all.txtPAST_ACC_EDT.style.background	= "white";
		}
		
		if (dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE") == "4")
		{
			chkCLASS_CODE.checked   = false;
			chkCLASS_CODE.disabled  = false;
		}
		else
		{
			chkCLASS_CODE.checked   = false;
			chkCLASS_CODE.disabled  = true;
		}
		if(chkCLASS_CODE.checked)
		{
			txtCLASS_CODE.value ="";
			txtCLASS_CODE_NAME.value ="";
			txtCLASS_CODE.readOnly=true;
			txtCLASS_CODE.style.backgroundColor = "#EFEFEF";
			btnSearchProj.disabled  = true;
			document.all.divgridMAIN.style.display 	= 'none';
			document.all.divgridMAIN1.style.display 	= '';
		}
		else
		{
			txtCLASS_CODE.readOnly=false;
			txtCLASS_CODE.style.backgroundColor = "#ffffff";
			btnSearchProj.disabled = false;
			document.all.divgridMAIN.style.display 	= '';
			document.all.divgridMAIN1.style.display 	= 'none';
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function	btnMake_onClick()
{
	if(C_isNull(txtEDIT_DT.value))
	{
		C_msgOk("작성일을 입력하십시오.","알림");
		return;
	}
	if(C_isNull(txtCURR_ACC_ID.value))
	{
		C_msgOk("회기를 입력하십시오.","알림");
		return;
	}
	if(C_isNull(txtCURR_ACC_FDT.value))
	{
		C_msgOk("회기시작일을 입력하십시오.","알림");
		return;
	}
	if(C_isNull(txtCURR_ACC_EDT.value))
	{
		C_msgOk("회기종료일을 입력하십시오.","알림");
		return;
	}
	if (txtCURR_ACC_FDT.value.replace(/-/gi,"").substr(0,4) != txtCURR_ACC_EDT.value.replace(/-/gi,"").substr(0,4))
	{
		C_msgOk("집계 및 조회범위를 벗어났습니다.","알림");
		txtCURR_ACC_EDT.value = "";
		return;
	}
	
	if(chkCLASS_CODE.checked)
	{
		G_Load(dsCLASS_CODE,null);
	}
	
	InsertIntoHead();
	
	if(!G_saveData(dsHEAD)) return;
	
	G_Load(dsMAKE,null);
	dsMAKE.NameString(dsMAKE.RowPosition,"SHEET_CODE") = dsHEAD.NameString(dsHEAD.RowPosition,"SHEET_CODE");
	
	if(chkCLASS_CODE.checked)
	{
		dsMAKE.NameString(dsMAKE.RowPosition,"CLASS_CODE") = "%";
	}
	else
	{
		dsMAKE.NameString(dsMAKE.RowPosition,"CLASS_CODE") = dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE");
	}
	
	dsMAKE.NameString(dsMAKE.RowPosition,"COMP_CODE") = dsHEAD.NameString(dsHEAD.RowPosition,"COMP_CODE");
	if(chkCLASS_CODE.checked)
	{
		dsMAKE.NameString(dsMAKE.RowPosition,"PROJ_TAG") = "T";
	}
	else
	{
		dsMAKE.NameString(dsMAKE.RowPosition,"PROJ_TAG") = "F";
	}
	transMake.Parameters = "ACT=MAKE";
	G_saveData(dsMAKE);
	Retrieve();
}

function	btnSearchProj_onClick()
{
	if(txtCLASS_CODE.readOnly)
	{
		C_msgOk("전체 사업장을 선택하셨습니다.특정 사업장을 선택하셔야 부서/현장을 선택하실 수 있습니다.","알림");
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCLASS_CODE.value);

	lrRet = C_LOV("T_CLASS_CODE2", lrArgs,"F");

	if (lrRet == null) return;

	txtCLASS_CODE.value	= lrRet.get("CLASS_CODE");
	txtCLASS_CODE_NAME.value	= lrRet.get("CLASS_CODE_NAME");
}


function	btnPreview_onClick()
{
	btnquery_prt_onclick();
}

function checkCommon()
{
	return true;
}
function	txtCLASS_CODE_onBlur()
{
	var			strCLASS_CODE = C_isNull(txtCLASS_CODE.value)?"%":txtCLASS_CODE.value;

	if(strCLASS_CODE != dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE"))
	{
		Retrieve();
	}
}
function	txtCLASS_CODE_NAME_onBlur()
{
	var			strCLASS_CODE = C_isNull(txtCLASS_CODE.value)?"%":txtCLASS_CODE.value;

	if(strCLASS_CODE != dsHEAD.NameString(dsHEAD.RowPosition,"CLASS_CODE"))
	{
		Retrieve();
	}
}

function txtCURR_ACC_FDT_onchange()
{
	txtEDIT_DT.value = vDATE;
	vACCOUNT_EDT = txtCURR_ACC_FDT.value.replace(/-/gi,"");
	G_Load(dsACC_ID, null);
	if (dsACC_ID.CountRow < 1)
	{
		C_msgOk("회기가 등록되어 있지 않습니다.","알림");
		txtCURR_ACC_FDT.value = txtCURR_ACC_FDT_H.value;
		return;
	}
	else
	{
		var vPRIV_ACC_FDT = parseInt(dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT").substr(0,4)) - 1;
		var vPRIV_ACC_EDT = parseInt(dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").substr(0,4)) - 1;
		txtPAST_ACC_FDT.value = vPRIV_ACC_FDT + dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT").substr(4,6);
		txtPAST_ACC_EDT.value = vPRIV_ACC_EDT + dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").substr(4,6);
		txtCURR_ACC_ID.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"CLSE_ACC_ID");
		txtPAST_ACC_ID.value = parseInt(txtCURR_ACC_ID.value) - 1;
	}
}

function txtCURR_ACC_EDT_onchange()
{
	txtEDIT_DT.value = vDATE;
	vACCOUNT_EDT = txtCURR_ACC_EDT.value;
	G_Load(dsACC_ID, null);
	if (dsACC_ID.CountRow < 1)
	{
		C_msgOk("회기가 등록되어 있지 않습니다.","알림");
		txtCURR_ACC_EDT.value = txtCURR_ACC_EDT_H.value;
		txtCURR_ACC_EDT.focus();
		return;
	}
	else
	{
		if ((dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE") == '1')
			|| (dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE") == '3'))
		{
			txtCURR_ACC_FDT.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT");
			var vPRIV_ACC_FDT = parseInt(dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT").substr(0,4)) - 1;
			var vPRIV_ACC_EDT = parseInt(dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").substr(0,4)) - 1;
			txtPAST_ACC_FDT.value = vPRIV_ACC_FDT + dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT").substr(4,6);
			txtPAST_ACC_EDT.value = vPRIV_ACC_EDT + dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").substr(4,6);
			txtCURR_ACC_ID.value
			txtCURR_ACC_ID.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"CLSE_ACC_ID");
			txtPAST_ACC_ID.value = parseInt(txtCURR_ACC_ID.value) - 1;
		}
		else
		{
			if (txtCURR_ACC_EDT.value.replace(/-/gi,"") > dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").replace(/-/gi,""))
			{
				C_msgOk("회기를 벗어났습니다.","알림");
				txtCURR_ACC_EDT.value = txtCURR_ACC_EDT_H.value;
				txtCURR_ACC_EDT.focus();
				return;
			}
			else
			{
				txtCURR_ACC_FDT.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT");
				var vPRIV_ACC_FDT = parseInt(dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT").substr(0,4)) - 1;
				var vPRIV_ACC_EDT = parseInt(dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").substr(0,4)) - 1;
				txtPAST_ACC_FDT.value = vPRIV_ACC_FDT + dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_FDT").substr(4,6);
				txtPAST_ACC_EDT.value = vPRIV_ACC_EDT + dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").substr(4,6);
				txtCURR_ACC_ID.value
				txtCURR_ACC_ID.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"CLSE_ACC_ID");
				txtPAST_ACC_ID.value = parseInt(txtCURR_ACC_ID.value) - 1;
			}
		}
	}
}

function txtPAST_ACC_FDT_onchange()
{
	vACCOUNT_EDT = txtPAST_ACC_FDT.value;
	G_Load(dsACC_ID, null);
	if (dsACC_ID.CountRow < 1)
	{
		C_msgOk("회기가 등록되어 있지 않습니다.","알림");
		txtPAST_ACC_FDT.value = txtPAST_ACC_FDT_H.value;
		return;
	}
	else
	{
		txtPAST_ACC_EDT.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT");
		txtPAST_ACC_ID.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"CLSE_ACC_ID");
	}
}

function txtPAST_ACC_EDT_onchange()
{
	vACCOUNT_EDT = txtPAST_ACC_EDT.value;
	G_Load(dsACC_ID, null);
	if (dsACC_ID.CountRow < 1)
	{
		C_msgOk("회기가 등록되어 있지 않습니다.","알림");
		txtPAST_ACC_EDT.value = txtPAST_ACC_EDT_H.value;
		return;
	}
	else
	{
		if ((dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE") != "1")
			&& (dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE") != "3"))
		{
			if (txtPAST_ACC_EDT.value.replace(/-/gi,"") > dsACC_ID.NameString(dsACC_ID.RowPosition,"ACCOUNT_EDT").replace(/-/gi,""))
			{
				C_msgOk("회기를 벗어났습니다.","알림");
				txtPAST_ACC_EDT.value = txtCURR_ACC_EDT_H.value;
				txtPAST_ACC_EDT.focus();
				return;
			}
			else
			{
				txtPAST_ACC_ID.value = dsACC_ID.NameString(dsACC_ID.RowPosition,"CLSE_ACC_ID");
			}
		}
	}
}

function	chkCLASS_CODE_onclick()
{
	if(chkCLASS_CODE.checked)
	{
		txtCLASS_CODE.value ="";
		txtCLASS_CODE_NAME.value ="";
		txtCLASS_CODE.readOnly=true;
		txtCLASS_CODE.style.backgroundColor = "#EFEFEF";
		btnSearchProj.disabled  = true;
		document.all.divgridMAIN.style.display 	= 'none';
		document.all.divgridMAIN1.style.display 	= '';
	}
	else
	{
		txtCLASS_CODE.readOnly=false;
		txtCLASS_CODE.style.backgroundColor = "#ffffff";
		btnSearchProj.disabled = false;
		document.all.divgridMAIN.style.display 	= '';
		document.all.divgridMAIN1.style.display 	= 'none';
	}
	Retrieve();
}
function	btnCURR_ACC_FDT_onClick()
{
	if(txtCURR_ACC_FDT.readOnly)
	{
		return;
	}
	txtCURR_ACC_FDT_H.value = txtCURR_ACC_FDT.value;
	C_Calendar("CURR_ACC_FDT", "D", txtCURR_ACC_FDT.value);
}
function	btnCURR_ACC_EDT_onClick()
{
	if(txtCURR_ACC_EDT.readOnly)
	{
		return;
	}
	txtCURR_ACC_EDT_H.value = txtCURR_ACC_EDT.value;
	C_Calendar("CURR_ACC_EDT", "D", txtCURR_ACC_EDT.value);
}
function	btnPAST_ACC_FDT_onClick()
{
	if(txtPAST_ACC_FDT.readOnly)
	{
		return;
	}
	txtPAST_ACC_FDT_H.value = txtPAST_ACC_FDT.value;
	C_Calendar("PAST_ACC_FDT", "D", txtPAST_ACC_FDT.value);
}
function	btnPAST_ACC_EDT_onClick()
{
	if(txtPAST_ACC_EDT.readOnly)
	{
		return;
	}
	txtPAST_ACC_EDT_H.value = txtPAST_ACC_EDT.value;
	C_Calendar("PAST_ACC_EDT", "D", txtPAST_ACC_EDT.value);
}
function	btnEDIT_DT_onClick()
{
	C_Calendar("EDIT_DT", "D", txtEDIT_DT.value);
}
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		EnableDisableProjCode();
		Retrieve();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	  = lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value = lrRet.get("COMPANY_NAME");
	
	EnableDisableProjCode();
	Retrieve();
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
	
	EnableDisableProjCode();
	Retrieve();
}
