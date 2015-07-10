<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixDeprecSum.jsp(감가상각 집계현황)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 감가상각 집계현황 
/* 4. 변  경  이  력 :  한재원 작성(2006-01-23)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	String  strDATE  = CITDate.getNow("yyyyMMdd");
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFixDeprecSum2";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	CITData		lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String  strYear = "";
	try
	{
		CITCommon.initPage(request, response, session);
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				strSql = " select a.COMP_CODE,b.COMPANY_NAME from t_dept_code a,t_company b where a.DEPT_CODE = ? and a.COMP_CODE = b.COMP_CODE (+) ";

				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
					strCOMPANY_NAME = lrReturnData.toString(0,"COMPANY_NAME");
	
					session.setAttribute("comp_code", strCOMP_CODE);
					session.setAttribute("comp_name", strCOMPANY_NAME);
				}
				
			}
			catch (Exception ex)
			{
				throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
			}
		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//사업장 설정 종료
		
		try
		{
			lrArgData = new CITData();
			
			strSql  = "Select distinct \n";
			strSql += "		to_char(work_from_dt,'YYYY') AS CODE, \n";
			strSql += "		to_char(work_from_dt,'YYYY') AS NAME \n";
			strSql += "From	T_FIX_DEPREC_CAL a \n";
			strSql += "Order by	to_char(work_from_dt,'YYYY') \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strYear = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:감가상각년도  Select 오류 -> " + ex.getMessage());
		}
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>회계관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var			olddata1 ="";
			var			olddata2 ="";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			vDATE = "<%=strDATE%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- 조건 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65"  class="font_green_bold" >사 업 장</td>
											<td width="70">  <input name="txtCOMP_CODE" 		type="text" datatype="han" style="width:68px" 	VALUE="" onblur="txtCOMP_CODE_onblur()"></td>
											<td width="200"> <input name="txtCOMPANY_NAME"	type="text" class="ro"	readOnly style="width:198px"	VALUE=""></td>
											<td width="40">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="20">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65" class="font_green_bold" >기준년도</td>
											<td width="82">
												<select id="cboYEAR" style="WIDTH: 80px" class="input_listbox_default"><%=strYear%></select>
											</td>
											<td width="25">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="85" class="font_green_bold">감가상각구분</td>
											<td width="82">
												 <select id=cboDEPREC_DIV style="WIDTH: 80px" class="input_listbox_default">
												 	<option value=S>실상각
												 	<option value=L>모의상각
												 </select>
											</td>
											<td>&nbsp;</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
						</table>
						<!-- 조건 테이블 종료 //-->
						<!-- 간격조정 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 종료 //-->
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 감가상각집계현황</td>
											<td align="right" width="*">
												&nbsp;
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<param name=SuppressOption value="3">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=월 			ID=MM					Align=CENTER		 Width=30   	Edit='none' 	Show='true' Suppress=1 BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=자산종류 		ID=ASSET_CLS_NAME		Align=CENTER		 Width=160   	Edit='none' 	Show='true'		SumText=' 합  계 :' SubColor='RED' BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=기초자산가액 	ID=START_ASSET_AMT		Align=Right	 Width=100   	Edit='none' 	SumText=@sum	SumColor=Black	SumBgColor=#FFF270  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=당기자산증가 	ID=CURR_ASSET_INC_AMT	Align=Right	 Width=100   	Edit='none' 	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=당기자산감소 	ID=CURR_ASSET_SUB_AMT	Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#F2A6A6  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=기말자산가액 	ID=LAST_AMT				Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#BFB448  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name='기초충당금'	ID=BEFORE_OLD_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#FFF270  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=충당금감소액   ID=CURR_APPROP_SUB_AMT	Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=감가상각액 	ID=CURR_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#F2A6A6  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=충당금누계액 	ID=OLD_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#BFB448  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=장부가액 		ID=BASE_AMT			Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#A8C9FF  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name=취득원가 		ID=GET_COST_AMT			Align=Right	 Width=100   	Edit='none'     Show='false'	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											<C> Name='증액누계' 	ID=INC_SUM_AMT			Align=Right	 Width=100   	Edit='none'     Show='false'	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right BgColor={Decode(div,'12','gray', '13','blue',)}
											</C>
											
											
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- 프로그래머 디자인 종료 //-->
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!-- 가우스 Bind 객체정의 종료 //-->
	</body>
</html>
<%
	try
	{
		CITCommon.finalPage();
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 종료 오류 -> " + ex.getMessage());
	}
%>