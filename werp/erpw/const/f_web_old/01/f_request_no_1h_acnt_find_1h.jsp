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
	query = query +  "and( account_code BETWEEN '111311' AND '111339' "; //유가증권
	query = query +  "Or account_code = '111511' "; //단기대여금
	query = query +  "Or account_code = '112711' "; //예치보증금
	query = query +  "Or account_code = '151411' "; //전세권
	query = query +  "Or account_code = '151412' "; //임차보증금
	query = query +  "Or account_code  BETWEEN '151451' AND '151479' "; //영업보증금
	query = query +  "Or account_code = '731119' "; //외주비(기타)
	query = query +  "Or account_code = '741312' "; //공)지급입차료(M/H)
	query = query +  "Or account_code  BETWEEN '741711' AND '741713' "; //공)연구비(기술개발비)
	query = query +  "Or account_code  BETWEEN '742611' AND '742615' "; //공)견본비
	query = query +  "Or account_code = '743112' "; //공)보상비(사)
	query = query +  "Or account_code  BETWEEN '743211' AND '743213' "; //공)설계감리비
	query = query +  "Or account_code  BETWEEN '743516' AND '743519' "; //공)공사부담금
	query = query +  "Or account_code  BETWEEN '743711' AND '743715' "; //공)이자비용
	query = query +  "Or account_code  BETWEEN '744111' AND '744113' "; //공)광고선전비
	query = query +  "Or account_code = '744211' "; //공)수주활동비
	query = query +  "Or account_code = '744411' "; //공)간접비
	query = query +  "Or account_code Like '2118%' "; //예수금
	query = query +  "Or account_code = '151322' "; //매도가능채권
	query = query +  "Or account_code = '461114' "; //매도가능채권(이자)
	query = query +  "Or account_code IN ('472211','472213','472219') "; //기부금

	query = query +  ")";
	

	if (arg_gubn.equals("1"))
		query = query + "  and account_code like " + "'" + arg_acntname + "%'";
	else
		query = query + "  and account_name like " + "'%" + arg_acntname + "%'";
	query = query + " order by account_code asc       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%> 