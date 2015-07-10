//----------------------------------------------------------------------
function gf_key_make(arg_key)   // 
//----------------------------------------------------------------------
{
	var pwd
	Cipher.DeriveSecretKeyFromPassword(pwd,arg_key);
	pwd = Cipher.returnArg(1);

	return pwd
}
