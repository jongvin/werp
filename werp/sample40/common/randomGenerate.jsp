<%@ page import="java.util.*"%><%!
public int getRandomInt(int iMax) {
	int n;
	int _num_max = iMax; 
	Random r = new Random();
	n = (r.nextInt())%_num_max;
	if (n<0) n = -n;
	return n;
}

public long getRandomLong(long lMax) {
	long n = 0;
	long _num_max = lMax; 
	Random r = new Random();
	n = (r.nextLong())%_num_max;
	if (n < 0) n = -n;
	return n;
}

public void mathRandom() {
	double ranValue  = 0d;
	long   longValue = 0L;
	ranValue = java.lang.Math.random();
	ranValue = ranValue * 10000000L;
}

public int getMathRandomInt(int levelVal) {
	double rtnValue = java.lang.Math.random() * levelVal;	
	Long temp = new Long(java.lang.Math.round(rtnValue));
	return temp.intValue();
}
%>