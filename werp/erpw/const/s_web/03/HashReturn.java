import java.io.FileInputStream;
import java.security.DigestInputStream;
import java.security.MessageDigest;

 class HashReturn {

	private static final char[] S_BASE64CHAR = {
		'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
		'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
		'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
		'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
		'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
		'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7',
		'8', '9', '+', '/'
	};

	private static final char   S_BASE64PAD = '=';


	/**
	 * Returns base64 representation of specified byte array.
	 */
	public static String encode(byte[] data, int off, int len) {
		if (len <= 0)  return "";
		char[] out = new char[len/3*4+4];
		int rindex = off;
		int windex = 0;
		int rest = len-off;
		while (rest >= 3) {
			int i = ((data[rindex]&0xff)<<16)
				+((data[rindex+1]&0xff)<<8)
				+(data[rindex+2]&0xff);
			out[windex++] = S_BASE64CHAR[i>>18]; 
			out[windex++] = S_BASE64CHAR[(i>>12)&0x3f];
			out[windex++] = S_BASE64CHAR[(i>>6)&0x3f];
			out[windex++] = S_BASE64CHAR[i&0x3f];
			rindex += 3;
			rest -= 3;
		}
		if (rest == 1) {
			int i = data[rindex]&0xff;
			out[windex++] = S_BASE64CHAR[i>>2];
			out[windex++] = S_BASE64CHAR[(i<<4)&0x3f];
			out[windex++] = S_BASE64PAD;
			out[windex++] = S_BASE64PAD;
		} else if (rest == 2) {
			int i = ((data[rindex]&0xff)<<8)+(data[rindex+1]&0xff);
			out[windex++] = S_BASE64CHAR[i>>10];
			out[windex++] = S_BASE64CHAR[(i>>4)&0x3f];
			out[windex++] = S_BASE64CHAR[(i<<2)&0x3f];
			out[windex++] = S_BASE64PAD;
		}
		return new String(out, 0, windex);
	}


	public static String getHashFile(String fileName) throws Exception {
		
		MessageDigest md = MessageDigest.getInstance("SHA1") ;
		

		DigestInputStream in = new DigestInputStream(new FileInputStream(fileName), md)  ;

		byte[] buffer = new byte[8192];
		
		while ( in.read(buffer) != -1) ;
		
		byte[] raw = md.digest();
		
		return encode(raw,0,raw.length) ;
	}



}


