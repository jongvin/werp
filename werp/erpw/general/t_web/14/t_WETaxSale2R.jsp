<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WEdiCreateR.jsp(현금이체파일생성)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-23) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null; 

//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strFileName = "./t_WETaxSale2R";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMP_NAME = "";
	String strPAY_KIND = "";	
	String strEMP_NO = "";	
	String strDate  = CITDate.getNow("yyyyMMdd");
	String strCOM_ID = "";
	String strEMP_ID = "";	
	String strREG_NUM = "";
	String strSECT_NAME = "";
	String strEMP_NAME = "";
	String strEMAIL = "";
	String strMOBILE = "";

	try
	{
		CITCommon.initPage(request, response, session);
		CITData		lrArgData = new CITData();		
		
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strEMP_NO = CITCommon.toKOR((String)session.getAttribute("emp_no"));		

		//회사코드
		lrArgData = new CITData();
 		try
		{
				lrArgData.addColumn("EMP_NO",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("EMP_NO", strEMP_NO);

				strSql  = " select com_id ,   \n"; 
				strSql += " 			 emp_id ,  	\n"; 
				strSql += " 			 reg_num ,  \n"; 
				strSql += " 			 sect_name ,\n"; 
				strSql += " 			 emp_name ,	\n"; 
				strSql += " 			 emp_no ,		\n"; 
				strSql += " 			 email ,		\n"; 
				strSql += " 			 mobile			\n"; 
				strSql += " from   tb_wt_user \n";
				strSql += " where  emp_no = ? \n";

				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOM_ID  		= lrReturnData.toString(0,"COM_ID");
					strEMP_ID  		= lrReturnData.toString(0,"EMP_ID");
					strREG_NUM 		= lrReturnData.toString(0,"REG_NUM");
					strSECT_NAME 	= lrReturnData.toString(0,"SECT_NAME");
					strEMP_NAME 	= lrReturnData.toString(0,"EMP_NAME");
					strEMAIL 			= lrReturnData.toString(0,"EMAIL");
					strMOBILE 		= lrReturnData.toString(0,"MOBILE"); 
				}	
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:회사코드 Select 오류 -> " + ex.getMessage());
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
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMP_NAME)%>";
			var			sComid 		= "<%=strCOM_ID%>";
			var			sEmpid 		= "<%=strEMP_ID%>";
			var			sRegnum 	= "<%=strREG_NUM%>";
			var			sSectname = "<%=strSECT_NAME%>";
			var			sEmpname 	= "<%=strEMP_NAME%>";
			var			sEmail 		= "<%=strEMAIL%>";
			var			sMobile 	= "<%=strMOBILE%>";
			var			sDate  		= "<%=strDate%>";
			
		// 이벤트관련-------------------------------------------------------------------//

		//-->
		</script>

		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSERIAL classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsITEM classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsREGNUM classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsUSER classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<iframe width="0" height="0" name="hidden" src="" frameborder="0" tabindex="-1"></iframe>
						<!-- 조건 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="110" class="font_green_bold" >공급자사업번호</td>
														<td width="152">
														<input id="txtSUP_REGNUM" type="text" class="han" style="width:150px" ></td>
														<input id="txtSUP_EMPLOYER" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_ADDRESS" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_BIZCOND" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_BIZITEM" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_ID" type="hidden" style="width:150px" ></td>
														<input id="txtDOC_COM_ID" type="hidden" style="width:150px" ></td>
														<td width="162">
														<input id="txtSUP_COMPANY" type="text" class="ro" readOnly style="width:160px" ></td>														
														<td width="50">
														<input id="btnSUP_REGNUM" type="button" class="img_btnFind" value="검색" onclick="btnSUP_REGNUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td>&nbsp; </td>			
													</tr>
												</table>
												<!-- 프로그래머 디자인 종료 //-->
											</td>
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
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr >
													<form name="fileUploadForm" method="post" target="hidden" enctype="multipart/form-data">														
															<td align=left width="15" height="20" ><img src="../images/bullet1.gif"></td>
															<td align=left class="font_green_bold"> 세금계산서</td>
															<td width="200">&nbsp;</td>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="122" class="font_green_bold">세금계산서 UPLOAD</td>
															<td width="400"><input type="file" name="fileCMS" length='8' value="">
															<input id="btnFileLoad" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="파일불러오기" onclick="btnFileLoad_onClick();" /></td>														 				
													</form>
															<td align="right" width="*" class="font_green_bold">
																<img src="../images/bullet3.gif">&nbsp;건수
																<input id="txtCOUNT_master" type="text" class="ro" center readOnly style="width:70px"/>
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="ViewSummary" 	VALUE=-1>
													<param name=UsingOneClick  value="1">
													<PARAM NAME="Format" VALUE=" 
														<C> Name=문서번호 ID=DOC_NUMBER  Align=Center  Edit='none' Width=150 
														</C>
														<C> Name=세무구분 ID=TAX_TYPE  Align=Center   Width=50 
														</C>
														<C> Name=받는자ID ID=BUY_ID Align=Left  Edit='none' Width=100
														</C>
														<C> Name=받는자사업번호 ID=BUY_REGNUM Align=Left   Width=100 
														</C>
														<C> Name=받는자회사명 ID=BUY_COMPANY Align=Left  Edit='none' Width=100
														</C>
														<C> Name=받는자담당사번 ID=BUY_EMPID  Align=Left  Width=100
														</C>
														<C> Name=받는자대표자 ID=BUY_EMPLOYER  Align=Left  Edit='none' Width=100
														</C>
														<C> Name=받는자주소 ID=BUY_ADDRESS  Align=Left  Edit='none' Width=200
														</C>
														<C> Name=받는자업태 ID=BUY_BIZCOND  Align=Left  Edit='none' Width=70
														</C>
														<C> Name=받는자종목 ID=BUY_BIZITEM  Align=Left  Edit='none' Width=70
														</C>
														<C> Name=받는자담당부서명 ID=BUY_SECTOR  Align=Left  Edit='none' Width=100
														</C>
														<C> Name=받는자담당자명 ID=BUY_EMPLOYEE  Align=Left  Edit='none' Width=100
														</C>														
														<C> Name=받는자이메일 ID=BUY_EMPEMAIL  Align=Left  Edit='none' Width=100
														</C>
														<C> Name=받는자모바일 ID=BUY_EMPMOBILE  Align=Left  Edit='none' Width=100
														</C>
														<C> Name=작성일자 ID=GEN_TM  Align=Left  Width=70
														</C>
														<C> Name=비고 ID=TAX_BIGO  Align=Left  Edit='none' Width=200
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
							<tr>
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 거래명세</td>
														<td align="right" width="*" class="font_green_bold">
															<img src="../images/bullet3.gif">&nbsp;건수
															<input id="txtCOUNT_detail" type="text" class="ro" center readOnly style="width:70px"/>
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" VALUE="dsSUB01">
														<PARAM NAME="Editable" VALUE="-1">
														<PARAM NAME="ColSelect" VALUE="-1">														
														<PARAM NAME="ColSizing" VALUE="-1">
														<PARAM NAME="ViewSummary" 	VALUE=1>
														<param name=UsingOneClick  value="1">
														<PARAM NAME="Format" VALUE=" 
															<C> Name=받는자사업자 ID=BUY_REGNUM  show=false Width=100  
															</C>														
															<C> Name=문서번호 ID=DOC_NUMBER  Align=Center   Edit='none' Width=150  
															</C>
															<C> Name=순번 ID=ITEM_SEQ  Align=Center   Width=40 
															</C>
															<C> Name=거래일자 ID=TAX_GENDATE  Align=Center   Width=70  
															</C>
															<C> Name=상품코드 ID=ITEM_CODE  Align=Center   Width=100  
															</C>
															<C> Name=상품명 ID=ITEM_NAME  Align=Left  Width=100
															</C>
															<C> Name=규격 ID=ITEM_UNIT  Align=Left  Width=70
															</C>
															<C> Name=수량 ID=ITEM_NUM Align=Right  Width=70
															</C>
															<C> Name=단가 ID=ITEM_DANGA  Align=Center  Width=100
															</C>
															<C> Name=공급가액 ID=TAX_SUPPRICE  Align=Center  Width=100
															</C>
															<C> Name=세액 ID=TAX_TAXPRICE  Align=Center  Width=100
															</C>
															<C> Name=비고 ID=ITEM_BIGO  Align=Center  Width=200
															</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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