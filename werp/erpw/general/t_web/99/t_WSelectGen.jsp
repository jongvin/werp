<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";
	
    try
    {
    	CITCommon.initPage(request, response, session, false);
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>회계관리 - Select 페이지 생성</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var			CRLF = "\r\n";
			var			SPECIALCHARS = "`~!@#$%^&*()-=\\+|[]{};':\",./<>? 	\r\n";

			function Initialize()
			{
				txtCRTDATE.value=getNowDate();
				G_addDataSet(dsMAIN, null, null, "t_WSelectGen_q.jsp?ACT=MAIN", "인자목록");
				G_addDataSet(dsCOLUMN, null, null, "t_WSelectGen_q.jsp?ACT=COLUMN", "컬럼목록");
				
				G_Load(dsMAIN, null);
			}
			function OnLoadBefore(dataset)
			{
				if (dataset == dsMAIN)
				{
					dataset.DataID = "t_WSelectGen_q.jsp?ACT=MAIN";
				}
			}

			// 함수관련---------------------------------------------------------------------//
			function	getNowDate()
			{
				var			lddtNow;
				var			liYear;
				var			liMonth;
				var			liDay;
				var			lsYear;
				var			lsMonth;
				var			lsDay;
				lddtNow = new Date();
				liYear = lddtNow.getFullYear();
				liMonth = lddtNow.getMonth() + 1;
				liDay = lddtNow.getDate();
				lsYear = liYear.toString();
				if(liMonth>=10)
				{
					lsMonth = liMonth.toString();
				}
				else
				{
					lsMonth = "0"+liMonth.toString();
				}
				if(liDay>=10)
				{
					lsDay = liDay.toString();
				}
				else
				{
					lsDay = "0"+liDay.toString();
				}
				return lsYear+"-"+lsMonth+"-"+lsDay;
			}
			function	getConvText()
			{
				var			strHEADER;
				strHEADER = "<" + "%@ page import=\"com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*\" errorPage=\"../common/Error.jsp\" contentType=\"text/html;charset=euc-kr\"%" + ">";
				strHEADER += CRLF+ "<"+"%";
				strHEADER += CRLF+ "/**************************************************************************/";
				strHEADER += CRLF+ "/* 1. 프 로 그 램 id : ";
				strHEADER += CRLF+ "/* 2. 유형(시나리오) : Select Page";
				strHEADER += CRLF+ "/* 3. 기  능  정  의 : ";
				strHEADER += CRLF+ "/* 4. 변  경  이  력 : " + txtCRTUSERNAME.value + " 작성(" + txtCRTDATE.value + ")";
				strHEADER += CRLF+ "/* 5. 관련  프로그램 : ";
				strHEADER += CRLF+ "/* 6. 특  기  사  항 : ";
				strHEADER += CRLF+ "/**************************************************************************/";
				strHEADER += CRLF+ " ";
				strHEADER += CRLF+ "	CITGauceInfo GauceInfo = null;";
				strHEADER += CRLF+ "	";
				strHEADER += CRLF+ "	CITData lrReturnData = null;";
				strHEADER += CRLF+ "	GauceDataSet lrDataset = null;";
				strHEADER += CRLF;
				strHEADER += CRLF+ "	String	strSql = \"\";";
				strHEADER += CRLF+ "	String	strAct = \"\";";
				strHEADER += CRLF+ "	";
				strHEADER += CRLF+ "	try";
				strHEADER += CRLF+ "	{";
				strHEADER += CRLF+ "		GauceInfo = CITCommon.initServerPage(request, response, session);";
				strHEADER += CRLF+ "		";
				strHEADER += CRLF+ "		CITData lrArgData = new CITData();";
				strHEADER += CRLF+ "		";
				strHEADER += CRLF+ "		strAct = CITCommon.toKOR(request.getParameter(\"ACT\"));";
				strHEADER += CRLF+ "		";
				strHEADER += CRLF+ "		if (strAct.equals(\""+txtACT.value+"\"))";
				strHEADER += CRLF+ "		{";
				strHEADER += CRLF+ getRequestGetParam();
				strHEADER += CRLF+ "			";
				strHEADER += CRLF+ convSQL();
				strHEADER += CRLF+ "			";
				strHEADER += CRLF+ getArgSet();
				strHEADER += CRLF+ "			try";
				strHEADER += CRLF+ "			{";
				strHEADER += CRLF+ "				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);";
				strHEADER += CRLF+ "				";
				strHEADER += CRLF+ getKeySet();
				strHEADER += CRLF+ getNotNullSet();
				strHEADER += CRLF+ "				";
				strHEADER += CRLF+ "				lrDataset = CITCommon.toGauceDataSet(lrReturnData);";
				strHEADER += CRLF+ "				GauceInfo.response.enableFirstRow(lrDataset);";
				strHEADER += CRLF+ "				lrDataset.flush();";
				strHEADER += CRLF+ "			}";
				strHEADER += CRLF+ "			catch (Exception ex)";
				strHEADER += CRLF+ "			{";
				strHEADER += CRLF+ "				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);";
				strHEADER += CRLF+ "				GauceInfo.response.writeException(\"USER\", \"900001\",\""+txtACT.value+" Select 오류-> \"+ ex.getMessage());";
				strHEADER += CRLF+ "			}";
				strHEADER += CRLF+ "		}";
				strHEADER += CRLF+ "	}";
				strHEADER += CRLF+ "	catch (Exception ex)";
				strHEADER += CRLF+ "	{";
				strHEADER += CRLF+ "		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);";
				strHEADER += CRLF+ "		GauceInfo.response.writeException(\"SYS\", \"100001\", \"페이지 초기화 오류 -> \" + ex.getMessage());";
				strHEADER += CRLF+ "	}";
				strHEADER += CRLF+ "	finally";
				strHEADER += CRLF+ "	{";
				strHEADER += CRLF+ "		try";
				strHEADER += CRLF+ "		{";
				strHEADER += CRLF+ "			CITCommon.finalServerPage(GauceInfo);";
				strHEADER += CRLF+ "		}";
				strHEADER += CRLF+ "		catch (Exception ex)";
				strHEADER += CRLF+ "		{";
				strHEADER += CRLF+ "			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);";
				strHEADER += CRLF+ "			GauceInfo.response.writeException(\"SYS\", \"100002\", \"페이지 종료 오류 -> \" + ex.getMessage());";
				strHEADER += CRLF+ "		}";
				strHEADER += CRLF+ "	}";
				strHEADER += CRLF+ "%"+">";
				return strHEADER;
			}
			function	isSpecialChar(asChar)
			{
				return SPECIALCHARS.indexOf(asChar,0) >= 0;
			}
			function	addColumn(aiPos,asName,asType)
			{
				G_addRow(dsCOLUMN);
				dsCOLUMN.NameString(dsCOLUMN.RowPosition,"DATA_COLNO") = aiPos.toString();
				dsCOLUMN.NameString(dsCOLUMN.RowPosition,"DATA_ISKEY") = "F";
				dsCOLUMN.NameString(dsCOLUMN.RowPosition,"DATA_ISNOTNULL") = "F";
				dsCOLUMN.NameString(dsCOLUMN.RowPosition,"DATA_COLNAME") = asName;
				dsCOLUMN.NameString(dsCOLUMN.RowPosition,"DATA_TYPE") = asType;
			}
			function	addArg(aiPos,asName)
			{
				G_addRow(dsMAIN);
				dsMAIN.NameString(dsMAIN.RowPosition,"ARG_NO") = aiPos.toString();
				dsMAIN.NameString(dsMAIN.RowPosition,"ARG_TYPE") = "VARCHAR2";
				dsMAIN.NameString(dsMAIN.RowPosition,"DATA_ARG_NAME") = asName;
			}
			function	getKeySet()
			{
				var		strRET = "";
				var		iCount = 0;
				if(dsCOLUMN.CountRow < 1 ) return "";
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					var		strISKEY = dsCOLUMN.NameString(i,"DATA_ISKEY");
					if(strISKEY == "T")
					{
						iCount ++;
						if(iCount == 1)
						{
							strRET = "				lrReturnData.setKey(\""+dsCOLUMN.NameString(i,"DATA_COLNAME")+"\", true);";
						}
						else
						{
							strRET += CRLF+"				lrReturnData.setKey(\""+dsCOLUMN.NameString(i,"DATA_COLNAME")+"\", true);";
						}
					}
				}
				return strRET;
			}
			function	getNotNullSet()
			{
				var		strRET = "";
				var		iCount = 0;
				if(dsCOLUMN.CountRow < 1 ) return "";
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					var		strISKEY = dsCOLUMN.NameString(i,"DATA_ISNOTNULL");
					if(strISKEY == "T")
					{
						iCount ++;
						if(iCount == 1)
						{
							strRET = "				lrReturnData.setNotNull(\""+dsCOLUMN.NameString(i,"DATA_COLNAME")+"\", true);";
						}
						else
						{
							strRET += CRLF+"				lrReturnData.setNotNull(\""+dsCOLUMN.NameString(i,"DATA_COLNAME")+"\", true);";
						}
					}
				}
				return strRET;
			}
			
			function	getArgSet()
			{
				var			strRET1 = "";
				var			strRET2 = "";
				if(dsMAIN.CountRow < 1) return "";
				for(i = 1 ; i <= dsMAIN.CountRow ; i ++)
				{
					if(i == 1)
					{
						strRET1 = "			lrArgData.addColumn(\""+i+dsMAIN.NameString(i,"DATA_ARG_NAME") +"\", CITData."+
												dsMAIN.NameString(i, "ARG_TYPE")+");"
					}
					else
					{
						strRET1 += CRLF+ "			lrArgData.addColumn(\""+i+dsMAIN.NameString(i,"DATA_ARG_NAME") +"\", CITData."+
												dsMAIN.NameString(i, "ARG_TYPE")+");"
					}
					strRET2 += CRLF+ "			lrArgData.setValue(\""+i+dsMAIN.NameString(i,"DATA_ARG_NAME") +"\", str"+
												dsMAIN.NameString(i, "DATA_ARG_NAME")+");"
				}
				return strRET1+CRLF+ "			lrArgData.addRow();"+
						strRET2;
			}
			function	getRequestGetParam()
			{
				var strRET = "";
				var dicDAN = new C_Dictionary();

				for(i = 1 ; i <= dsMAIN.CountRow ; i ++)
				{
					if(dicDAN.get(dsMAIN.NameString(i,"DATA_ARG_NAME")) == null)
						dicDAN.set(dsMAIN.NameString(i,"DATA_ARG_NAME"), dsMAIN.NameString(i,"DATA_ARG_NAME"));
				}
				
				//alert(dicDAN.count());
				var aryDAN = dicDAN.items();
				//alert(aryDAN.length);

				
				for(i=0;i<aryDAN.length;i++){
					if(i == 0)
					{
						strRET = "			String str"+aryDAN[i]+" = CITCommon.toKOR(request.getParameter(\""+aryDAN[i]+"\"));";
					}
					else
					{
						strRET += CRLF+ "			String str"+aryDAN[i]+" = CITCommon.toKOR(request.getParameter(\""+aryDAN[i]+"\"));";
					}
				}
				return strRET;
			}
			
			function	parseColumn()
			{
				ifrmListHidden.parseSQL(txtSQL.value);
			}
			function	convSQL()
			{
				var			strRET;
				var			bInBlockComment;
				var			bInLineComment;
				var			bInDoubleQuot;
				var			bInSingleQuot;
				var			iArgStartPos;
				var			strTempChar;
				var			strTempLook;
				var			iArgCount;
				var			strSQL;
				var			strLineHead;
				var			strLineEnd;
				strLineHead = "			strSql += \" ";
				strLineEnd = " \\n\";";
				bInBlockComment = false;
				bInDoubleQuot = false;
				bInSingleQuot = false;
				bInLineComment = false;
				iArgStartPos = -1;
				iArgCount = 0;
				var			iLength = txtSQL.value.length;
				strSQL = txtSQL.value.toString();
				strRET = "			strSql  = \" ";
				for( i = 0 ; i < iLength ; i ++)
				{
					strTempChar = strSQL.substr(i,1);
					if(iArgStartPos < 0)
					{
						if(strTempChar == "\"")
						{
							strRET += "\\\"";
						}
						else if(strTempChar == "\n")
						{
							strRET += strLineEnd+CRLF+strLineHead;
						}
						else if(strTempChar == "\r")
						{
						}
						else if(strTempChar == ":")
						{
						}
						else
						{
							strRET += strTempChar;
						}
					}
					if(bInBlockComment || bInLineComment || bInDoubleQuot || bInSingleQuot)
					{
						if(bInBlockComment)
						{
							if(strTempChar == "*")
							{
								if(i + 1 >= iLength) break;
								strTempLook = strSQL.substr(i + 1,1);
								if(strTempLook == "/")
								{
									i ++;
									bInBlockComment = false;
									strRET += strTempLook;
									continue;
								}
								else
								{
									continue;
								}
							}
							else
							{
								continue;
							}
						}
						else if(bInLineComment)
						{
							if(strTempChar == "\n")
							{
								bInLineComment = false;
							}
							continue;
						}
						else if(bInDoubleQuot)
						{
							if(strTempChar == "\"")
							{
								bInDoubleQuot = false;
							}
							continue;
						}
						else if(bInSingleQuot)
						{
							if(strTempChar == "'")
							{
								if(i + 1 >= iLength)
								{
									bInSingleQuot = false;
									break;
								}
								else
								{
									strTempLook = strSQL.substr(i + 1,1);
									if(strTempLook == "'")
									{
										strRET += strTempLook;
										i ++;
										continue;
									}
									else
									{
										bInSingleQuot = false;
										continue;
									}
								}
							}
							else
							{
								continue;
							}
						}
					}
					if(iArgStartPos >= 0)
					{
						if(isSpecialChar(strTempChar))
						{
							strRET += " ? ";
							if(strTempChar == "\"")
							{
								strRET += "\\\"";
							}
							else if(strTempChar == "\n")
							{
								strRET += strLineEnd+CRLF+strLineHead;
							}
							else if(strTempChar == "\r")
							{
							}
							else if(strTempChar == ":")
							{
							}
							else
							{
								strRET += strTempChar;
							}
						}
						else
						{
							continue;
						}
					}
					iArgStartPos = -1;
					if(strTempChar == ":")
					{
						iArgStartPos = i;
						continue;
					}
					else if(strTempChar == "\"")
					{
						bInDoubleQuot = true;
						continue;
					}
					else if(strTempChar == "'")
					{
						bInSingleQuot = true;
						continue;
					}
					else if(strTempChar == "/")
					{
						if(i + 1 >= iLength) continue;
						strTempLook = strSQL.substr(i + 1,1);
						if(strTempLook == "*")
						{
							i ++;
							strRET += strTempLook;
							bInBlockComment = true;
						}
						else
						{
							continue;
						}
					}
					else if(strTempChar == "-")
					{
						if(i + 1 >= iLength) continue;
						strTempLook = strSQL.substr(i + 1,1);
						if(strTempLook == "-")
						{
							i ++;
							strRET += strTempLook;
							bInLineComment = true;
						}
						else
						{
							continue;
						}
					}
				}
				if(iArgStartPos >= 0)
				{
					var		strVarName = strSQL.substr(iArgStartPos + 1, iLength - iArgStartPos - 1 );
					iArgCount ++;
					strRET += " ? ";
				}
				strRET += " \";"
				return strRET;
			}
			function	parseArg()
			{
				var			bInBlockComment;
				var			bInLineComment;
				var			bInDoubleQuot;
				var			bInSingleQuot;
				var			iArgStartPos;
				var			strTempChar;
				var			strTempLook;
				var			iArgCount;
				var			strSQL;
				G_Load(dsMAIN, null);
				bInBlockComment = false;
				bInDoubleQuot = false;
				bInSingleQuot = false;
				bInLineComment = false;
				iArgStartPos = -1;
				iArgCount = 0;
				var			iLength = txtSQL.value.length;
				strSQL = txtSQL.value.toString();
				for( i = 0 ; i < iLength ; i ++)
				{
					strTempChar = strSQL.substr(i,1);
					if(bInBlockComment || bInLineComment || bInDoubleQuot || bInSingleQuot)
					{
						if(bInBlockComment)
						{
							if(strTempChar == "*")
							{
								if(i + 1 >= iLength) break;
								strTempLook = strSQL.substr(i + 1,1);
								if(strTempLook == "/")
								{
									i ++;
									bInBlockComment = false;
									continue;
								}
								else
								{
									continue;
								}
							}
							else
							{
								continue;
							}
						}
						else if(bInLineComment)
						{
							if(strTempChar == "\n")
							{
								bInLineComment = false;
							}
							continue;
						}
						else if(bInDoubleQuot)
						{
							if(strTempChar == "\"")
							{
								bInDoubleQuot = false;
							}
							continue;
						}
						else if(bInSingleQuot)
						{
							if(strTempChar == "'")
							{
								if(i + 1 >= iLength)
								{
									bInSingleQuot = false;
									break;
								}
								else
								{
									strTempLook = strSQL.substr(i + 1,1);
									if(strTempLook == "'")
									{
										i ++;
										continue;
									}
									else
									{
										bInSingleQuot = false;
										continue;
									}
								}
							}
							else
							{
								continue;
							}
						}
					}
					if(iArgStartPos >= 0)
					{
						if(isSpecialChar(strTempChar))
						{
							var		strVarName = strSQL.substr(iArgStartPos + 1, i - iArgStartPos - 1 );
							iArgCount ++;
							addArg(iArgCount,C_toUpperCase(strVarName));
						}
						else
						{
							continue;
						}
					}
					iArgStartPos = -1;
					if(strTempChar == ":")
					{
						iArgStartPos = i;
						continue;
					}
					else if(strTempChar == "\"")
					{
						bInDoubleQuot = true;
						continue;
					}
					else if(strTempChar == "'")
					{
						bInSingleQuot = true;
						continue;
					}
					else if(strTempChar == "/")
					{
						if(i + 1 >= iLength) continue;
						strTempLook = strSQL.substr(i + 1,1);
						if(strTempLook == "*")
						{
							i ++;
							bInBlockComment = true;
						}
						else
						{
							continue;
						}
					}
					else if(strTempChar == "-")
					{
						if(i + 1 >= iLength) continue;
						strTempLook = strSQL.substr(i + 1,1);
						if(strTempLook == "-")
						{
							i ++;
							bInLineComment = true;
						}
						else
						{
							continue;
						}
					}
				}
				if(iArgStartPos >= 0)
				{
					var		strVarName = strSQL.substr(iArgStartPos + 1, iLength - iArgStartPos - 1 );
					iArgCount ++;
					addArg(iArgCount,C_toUpperCase(strVarName));
				}
				if(dsMAIN.CountRow >= 1)
				{
					dsMAIN.RowPosition = 1;
				}
			}
			function	reportParse(arColumns)
			{
				if(arColumns.length < 1)
				{
					alert("컬럼 파싱에 실패했습니다.");
					return;
				}
				var		strSUCC;
				strSUCC = arColumns.substr(0,1);
				if(strSUCC == "F")
				{
					alert("컬럼 파싱에 실패했습니다.");
					alert(arColumns.substr(1,arColumns.length - 1));
					return;
				}
				var		strColumn;
				var		arrColumns;
				strColumn = arColumns.substr(1,arColumns.length - 1);
				arrColumns = strColumn.split(",");
				G_Load(dsCOLUMN,null);
				for(i = 0 ; i < arrColumns.length ; i ++)
				{
					var		arrColAndType;
					arrColAndType = arrColumns[i].split("|");
					addColumn(i + 1,arrColAndType[0],arrColAndType[1]);
				}
				if(dsCOLUMN.CountRow >= 1)
				{
					dsCOLUMN.RowPosition = 1;
				}

			}
			// 이벤트관련-------------------------------------------------------------------//
			function	btnTransForm_onClick()
			{
				txtJSP.value = getConvText();
			}
			
			function	btnArgCompile_onClick()
			{
				parseArg();
				parseColumn();
			}
		//-->
		</script>
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param name="SyncLoad" value="-1">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCOLUMN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param name="SyncLoad" value="-1">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
	</head>
	<body onload="C_Initialize()">
		<iframe width="0" height="0" name="ifrmListHidden" src="./t_WSelectGen_01.jsp" frameborder="0" tabindex="-1"></iframe>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr height="*"> 
				<td width="100%" align="left" valign="top">
					<!-- 표준 페이지의 고정 DIV 시작 : 크기(폭:800px, 높이:530px) //-->
					<div id="divMainFix" class="main_div">
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
						<tr valign="top">
							<td width="100%" >
								<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<!-- 현재위치 테이블 시작 //-->
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="60">
																	작성자 : 
																</td>
																<td width="65">
																	<input id="txtCRTUSERNAME" type="text" VALUE="홍길동"   style="width:60px">
																</td>
																<td width="60">
																	작성일 : 
																</td>
																<td width="80">
																	<input id="txtCRTDATE" type="text" datatype="DATE" VALUE=""   style="width:75px">
																</td>
																<td width="60">
																	ACT : 
																</td>
																<td width="80">
																	<input id="txtACT" type="text" VALUE="MAIN"   style="width:75px">
																</td>
																<td>&nbsp;</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td height="1" bgcolor="#CCCCCC"></td>
												</tr>
											</table>
											<!-- 현재위치 테이블 종료 //-->
										</td>
									</tr>
									<tr height="100%">
										<td  height="100%">
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
												<tr  height="100%">
													<td  height="100%" width="400" >
														<!-- 서브 테이블 시작 //-->
														<!-- 서브 본문 시작 //-->
														<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr> 
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> SQL</td>
																			<td align="right">
																				<input name="btnArgCompile" type="button" class="img_btn4_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="질의해석" onclick="btnArgCompile_onClick()"/>
																				<input name="btnTransForm" type="button" class="img_btn2_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="변환" onclick="btnTransForm_onClick()"/>
																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr height="100%">
																<td width="100%" height="100%">
																	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line"> 
																			<td width="*" height="3"></td>
																		</tr>
																		<tr  height="100%"> 
																			<td bgcolor="#FFFFFF" height="100%">
																				<textarea name="txtSQL" style="width:100% ; height:100% " wrap="off" tabindex="-1"></textarea>
																			</td>
																		</tr>
																		<tr class="head_line"> 
																			<td width="*" height="3" ></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr> 
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> SQL 인자 목록</td>
																			<td align="right">
																				
																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr >
																<td width="100%" >
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line"> 
																			<td width="*" height="3"></td>
																		</tr>
																		<tr> 
																			<td bgcolor="#FFFFFF" height="100%">
																				<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
																					<PARAM NAME="Editable" VALUE="-1">
																					<PARAM NAME="ColSelect" VALUE="-1">
																					<PARAM NAME="ColSizing" VALUE="-1">
																					<PARAM NAME="UsingOneClick" VALUE="-1">
																					<PARAM NAME="Format" VALUE=" 
																						<C> Name='인자번호' ID='ARG_NO' Align=Center HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=60 
																						</C> 
																						<C> Name='인자명' ID='DATA_ARG_NAME' Align=Left HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=130 
																						</C> 
																						<C> Name='데이타형' ID='ARG_TYPE' Align=Left HeadAlign=Center  EditStyle=Combo Data='VARCHAR2:VARCHAR2,NUMBER:NUMBER,DATE:DATE' HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=130 
																						</C> 
																						">
																					<PARAM NAME="DataID" VALUE="dsMAIN">
																				</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																			</td>
																		</tr>
																		<tr class="head_line"> 
																			<td width="*" height="3" ></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr> 
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> SQL 컬럼 목록</td>
																			<td align="right">
																				
																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr >
																<td width="100%" >
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line"> 
																			<td width="*" height="3"></td>
																		</tr>
																		<tr> 
																			<td bgcolor="#FFFFFF" height="100%">
																				<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridCOLUMN WIDTH="100%" HEIGHT="100" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
																					<PARAM NAME="Editable" VALUE="-1">
																					<PARAM NAME="ColSelect" VALUE="-1">
																					<PARAM NAME="ColSizing" VALUE="-1">
																					<PARAM NAME="UsingOneClick" VALUE="-1">
																					<PARAM NAME="Format" VALUE=" 
																						<C> Name='컬럼번호' ID='DATA_COLNO' Align=Center HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=60 
																						</C> 
																						<C> Name='컬럼명' ID='DATA_COLNAME' Align=Left HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=120 
																						</C> 
																						<C> Name='키여부' ID='DATA_ISKEY' Align=Center HeadAlign=Center EditStyle=CheckBox HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=50 
																						</C> 
																						<C> Name='필수?' ID='DATA_ISNOTNULL' Align=Center HeadAlign=Center EditStyle=CheckBox HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=50 
																						</C> 
																						<C> Name='데이타형' ID='DATA_TYPE' Align=Left Edit=None HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=80 
																						</C> 
																						">
																					<PARAM NAME="DataID" VALUE="dsCOLUMN">
																				</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																			</td>
																		</tr>
																		<tr class="head_line"> 
																			<td width="*" height="3" ></td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
														<!-- 서브 본문 종료 //-->
														<!-- 서브 테이블 종료 //-->
													</td>
													<td width="10">
														&nbsp;
													</td>
													<td  height="100%">
														<!-- 서브 테이블 시작 //-->
														<!-- 서브 본문 시작 //-->
														<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr> 
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> JSP</td>
																			<td align="right">
																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr height="100%">
																<td width="100%" height="100%">
																	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line"> 
																			<td width="*" height="3"></td>
																		</tr>
																		<tr  height="100%"> 
																			<td bgcolor="#FFFFFF" height="100%">
																				<textarea name="txtJSP" style="width:100% ; height:100% " wrap="off"></textarea>
																			</td>
																		</tr>
																		<tr class="head_line"> 
																			<td width="*" height="3"></td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
														<!-- 서브 본문 종료 //-->
														<!-- 서브 테이블 종료 //-->
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					</div>
					<!-- 표준 페이지의 고정 DIV 종료 //-->
				</td>
			</tr>
		</table>
	</body>
</html>
