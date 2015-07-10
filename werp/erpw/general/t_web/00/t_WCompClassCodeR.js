/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompClassCodeR.js(사업장별 부문코드 등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 사업장별 부문코드 등록 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-02)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null,   gridMAIN, null, "사업장목록");
	G_addDataSet(dsMAIN01, null, gridMAIN01, null, "사업장별 부서목록");
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "사업장별부문코드목록");
	G_addDataSet(dsSUB02, null,  gridSUB02, null, "부문코드목록");

	G_addRel(dsMAIN, dsMAIN01);
	G_addRelCol(dsMAIN01, "COMP_CODE", "COMP_CODE");
	
	G_addRel(dsMAIN01, dsSUB01);
	G_addRelCol(dsSUB01, "DEPT_CODE", "DEPT_CODE");
	
	G_addRel(dsMAIN01, dsSUB02);
	G_addRelCol(dsSUB02, "DEPT_CODE", "DEPT_CODE");
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
					
	}
	else if(dataset == dsMAIN01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN01")
										+ D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"));
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										+ D_P2("DEPT_CODE",dsMAIN01.NameString(dsMAIN01.RowPosition,"DEPT_CODE"));
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
					                     + D_P2("DEPT_CODE",dsMAIN01.NameString(dsMAIN01.RowPosition,"DEPT_CODE"));
										
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

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	//D_defaultLoad();
	G_Load(dsMAIN);
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	dsSUB02.ResetStatus()
	D_defaultSave(dsSUB01);
}
// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//


function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}

var bLock = false;
function OnColumnChanged(dataset, row, colid)
{
	if( dataset == dsSUB01 )
	{
		if(colid == "DFLT_TAG") {
			if(bLock) return;bLock = true;
			if(dataset.NameString(row, colid)=="T"){
				for(var i=1;i<=dataset.CountRow;i++){
					if(i!=row) dataset.NameString(i, colid)="F";
				}
			} else {
				var vDFLT_TAG = dsSUB01.NameMax("DFLT_TAG",0,0);
				if(dataset.CountRow>0){
					if(vDFLT_TAG == "F") {
						C_msgOk("부문코드 한개는 항상 선택되어 있어야 합니다.");
						dataset.NameString(row,"DFLT_TAG") = 'T';
					}
				}
			}
			bLock = false;
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function	btnGrantClassCode_onClick()
{
	if(bLock) return;bLock = true;

	if(dsSUB02.Countrow < 1)
	{
		C_msgOk("먼저 부문코드를 선택하여야 합니다.");
		return;
	}
	var			lrArray = new Array();
	var			liCnt = 0;
	for(var i = 1 ; i <= dsSUB02.CountRow ; i ++)
	{
		if(dsSUB02.RowMark(i))
		{
			lrArray[liCnt] = i;
			liCnt ++;
		}
	}
	for( var i = 0 ; i < lrArray.length ; i ++)
	{
		var			liRow = lrArray[i];
		G_addRow(dsSUB01);
		dsSUB01.NameString(dsSUB01.RowPosition,"CLASS_CODE") = dsSUB02.NameString(liRow,"CLASS_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition,"CLASS_CODE_NAME") = dsSUB02.NameString(liRow,"CLASS_CODE_NAME");
		dsSUB01.NameString(dsSUB01.RowPosition,"DFLT_TAG") = 'F';
	}
	for( var i = lrArray.length - 1 ; i >= 0  ; i --)
	{
		var			liRow = lrArray[i];
		G_deleteRow(dsSUB02,liRow);
	}
	setClassCodeOne();

	bLock = false;
}
function	btnRevokeClassCode_onClick()
{
	if(dsSUB01.Countrow < 1)
	{
		C_msgOk("먼저 사업장별부문코드를 선택하여야 합니다.");
		return;
	}
	var			lrArray = new Array();
	var			liCnt = 0;
	for(var i = 1 ; i <= dsSUB01.CountRow ; i ++)
	{
		if(dsSUB01.RowMark(i))
		{
			lrArray[liCnt] = i;
			liCnt ++;
		}
	}
	for( var i = 0 ; i < lrArray.length ; i ++)
	{
		var			liRow = lrArray[i];
		G_addRow(dsSUB02);
		dsSUB02.NameString(dsSUB02.RowPosition,"CLASS_CODE") = dsSUB01.NameString(liRow,"CLASS_CODE");
		dsSUB02.NameString(dsSUB02.RowPosition,"CLASS_CODE_NAME") = dsSUB01.NameString(liRow,"CLASS_CODE_NAME");
		
	}
	//dsSUB02.ClearAllMark()

	for( var i = lrArray.length - 1 ; i >= 0  ; i --)
	{
		var			liRow = lrArray[i];
		G_deleteRow(dsSUB01,liRow);
	}
	setClassCodeOne();
}

function	setClassCodeOne()
{
	var vDFLT_TAG = dsSUB01.NameMax("DFLT_TAG",0,0);
	if(dsSUB01.CountRow>0){
		if(vDFLT_TAG == "F") dsSUB01.NameString(1,"DFLT_TAG") = 'T';
	}
}

