<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_acntname = req.getParameter("arg_acntname") + "%";
	String arg_gubn = req.getParameter("arg_gubn");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("account_code",GauceDataColumn.TB_STRING,8));
	dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,30));
	String query = "  SELECT  account_code ," + 
	"         		      account_name  " + 
	"         		 FROM efin_accounts_v " +
	"               where enabled_flag = 'Y'" +
	"                 and summary_flag = 'N'" +
	"                 and hierarchy_level = 6 ";
	query = query +  "and account_code not LIKE '155%' "; //고정자산
	query = query +  "and (account_code not LIKE '9%' or account_code = '915100' or account_code = '911070' or account_code = '911071' " +
	                      "or account_code = '911082' or account_code = '911083' or account_code = '911084' " +
						  "or account_code = '911085') "; //크리어링
	query = query +  "and account_code not LIKE  '1153%' "; //재료, 가설재
	query = query +  "and account_code <> '711111' and account_code <> '947010' "; //재료비

	query = query +  "and account_code <> '743411' "; //공)가설재손료
	query = query +  "and account_code <> '793111' "; //공사(원가대체)
	query = query +  "and account_code <> '151511' "; //장기선급비용
	query = query +  "and account_code <> '111114' "; //전도금(보통예금)
	query = query +  "and account_code <> '111113' "; //미수금
	query = query +  "and account_code NOT LIKE '1116%' "; //미수금
	query = query +  "and account_code NOT LIKE '1117%' "; //미수금
	query = query +  "and (account_code NOT LIKE '1118%' Or account_code = '111829') "; //미수금
	query = query +  "and account_code NOT LIKE '1121%' "; //미수금
	query = query +  "and account_code NOT LIKE '151%' "; //보증금
	query = query +  "and account_code <> '112711' and account_code <> '251511' "; //예치보증금
	query = query +  "and account_code NOT LIKE '1115%' "; //대여금

//미실행분
	query = query +  "and account_code NOT BETWEEN '111311' AND '111339' "; //유가증권
	query = query +  "and account_code <> '111511' "; //단기대여금
	query = query +  "and account_code <> '112711' "; //예치보증금
	query = query +  "and account_code <> '151411' "; //전세권
	query = query +  "and account_code <> '151412' "; //임차보증금
	query = query +  "and account_code NOT BETWEEN '151451' AND '151479' "; //영업보증금
	query = query +  "and account_code <> '731119' "; //외주비(기타)
	query = query +  "and account_code <> '741312' "; //공)지급입차료(M/H)
	query = query +  "and account_code NOT BETWEEN '741711' AND '741713' "; //공)연구비(기술개발비)
	//query = query +  "and account_code NOT BETWEEN '742611' AND '742615' "; //공)견본비
	query = query +  "and account_code <> '743112' "; //공)보상비(사)
	query = query +  "and account_code NOT BETWEEN '743211' AND '743213' "; //공)설계감리비
	query = query +  "and account_code NOT BETWEEN '743516' AND '743519' "; //공)공사부담금
	query = query +  "and account_code NOT BETWEEN '743711' AND '743715' "; //공)이자비용
	query = query +  "and account_code NOT BETWEEN '744111' AND '744113' "; //공)광고선전비
	query = query +  "and account_code <> '744211' "; //공)수주활동비
	query = query +  "and account_code <> '744411' "; //공)간접비
	
	if (arg_gubn.equals("1"))
		query = query + "  and account_code like " + "'" + arg_acntname + "%'";
	else
		query = query + "  and account_name like " + "'%" + arg_acntname + "%'";
	query = query + " order by account_code asc       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%> 