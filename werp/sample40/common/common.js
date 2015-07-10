/**
===============================================================================
��  �� �� �� : ���� ����
����  �ý��� : ����
���α׷�  ID : Common.js
���α׷�  �� : ���� ��� Javascript
���α׷����� : ���������� ���Ǵ� Javascript�� �����Ѵ�
��   ��   �� :
��   ��   �� : 2002.11.10
===============================================================================
*/


/**
 * �Է°��� ���������� Ȯ���Ѵ�
 * param : sVal �Է½�Ʈ��
 * return : Boolean True�̸� ���ڰ�
 */
function isNumber(sVal)
{
  if(sVal.length < 1)
  {
    return false;
  }

  for(i=0; i<sVal.length; i++)
  {
    iBit = parseInt(sVal.substring(i,i+1));     //����(Char)�� ���ڷ� ����
    if(('0' < iBit) || ('9' > iBit))
    {
      //alert(i+':'+iBit+':'+'Mun');
    }
    else
    {
      //alert((i+1)+'��° ���ڴ� ���ڰ� �ƴմϴ�.');
      return false;
    }
  }
  return true;
}

/**
 * sVal ���� ���������� Ȯ���Ѵ�.(' '���� ������)
 * param : sVal �Է½�Ʈ��
 * return : Boolean  True�̸� ���ڰ�
 */
function isNumberSpace(sVal)
{
  if(sVal.length > 0)
  {
    for(var i=0;i<sVal.length;i++)
    {
      sBitData = sVal.substring(i,i+1);     //���ڿ��� ����(char)�� �ִ´�
      if(sBitData == ' ')
      {
      }
      else
      {
        iBit = parseInt(sVal.substring(i,i+1)); //����(char)�� ���ڷ�
        if(('0' < iBit) || ('9' > iBit) || (' ' == sBitData))
        {
        }
        else
        {
          return false;
        }
      }
    }
  }
  return true;
}



/**
 * sVal ���� ���������� Ȯ���Ѵ�.('.'���� ������), ���̳ʽ� ���� ���
 * param : sVal �Է½�Ʈ��
 * return : Boolean  True�̸� ���ڰ�
 */
function isNumberDot(sVal)
{

  var result;

  if(sVal.length < 1)
  {
    return false;
  }

  for(var i=0;i<sVal.length;i++)
  {
    sBitData = sVal.substring(i,i+1);       //���ڿ��� ����(char)�� �ִ´�

        if( i == 0 ) {
                if( sBitData == '-' ) { // ���̳ʽ��� ���
                } else {
                        if( sBitData >= '0' && sBitData <= '9' ) {

                        } else {
                                return false;
                        }
                }

        } else {

                if(sBitData == '.'){
                } else {
                  iBit = parseInt(sVal.substring(i,i+1));   //����(Char)�� ���ڷ�

                  if(('0' < iBit) || ('9' > iBit) || ('.' == sBitData)){
                  } else {
                        return false;
                  }
                } //end of if-else

        }//�߰�

  } //end of for

  return true;
}



/**
 * ù��° Zero ���� �ڸ���.
 * param : sVal �Է½�Ʈ��
 * return : String  Zero���� �ڸ� ��
 */
function trimZero(sVal)
{
  if(sVal.charAt(0) == '0')
  {
    return sVal.substring(1,sVal.length);
  }
  else
  {
    return sVal;
  }
}

/**
 * ���̰�1�� ��� �տ� "0"�� ���δ�.
 * param : sVal �Է½�Ʈ��
 * return : String  "0"���� �����ϴ� ��
 */
function addZero(sVal)
{
  var iLen = sVal.length;   //�μ����� ���̸� ���Ѵ�.
  if(iLen == 1)
  {
    sVal = "0"+sVal;
  }
  else if(iLen == 0)
  {
    return;
  }
  return sVal;
}

/**
 * ��¥ ���θ� Ȯ���Ѵ�.(���� or ��� or �����)
 * param : sYmd �Է½�Ʈ��(MMDD or YYYYMM or YYYYMMDD)
 * return : Boolean true�̸� ��¥ ������
 */
function isDate(sYmd)
{
  var bResult;  // ������� ��� ����(Boolean)
  switch (sYmd.length)
  {
    case 4://����
      bResult = isDateMD(sYmd);
      break;
    case 6://���
      bResult =  isDateYM(sYmd);
      break;
    case 8://�����
      bResult =  isDateYMD(sYmd);
      break;
    default:
      bResult = false;  // ��¥ ���� �ƴ�
      break;
  }
  return bResult;
}

/**
 * ��¥ ���θ� Ȯ���Ѵ�.(�����)
 * param : sYmd �Է½�Ʈ��(YYYYMMDD)
 * return : Boolean true�̸� ��¥ ������
 */
function isDateYMD(sYmd)
{
  // ���� Ȯ��
  if(!isNumber(sYmd))
  {
    alert('��¥�� ���ڸ� �Է��Ͻʽÿ�');
    return false;
  }

  // ���� Ȯ��
  if(sYmd.length != 8)
  {
    alert('���ڸ� ��� �Է��Ͻʽÿ�');
    return false;
  }
  var iYear = parseInt(sYmd.substring(0,4));  // �⵵ �Է�(YYYY)
  var iMonth = parseInt(trimZero(sYmd.substring(4,6)));   //���Է�(MM)
  var iDay = parseInt(trimZero(sYmd.substring(6,8)));     //�����Է�(DD)

  if((iMonth < 1) ||(iMonth >12))
  {
    alert(iMonth+'���� �Է��� �߸� �Ǿ����ϴ�.');
        return false;
  }

  //�� ���� �� ������ ���Ѵ�
  var iLastDay = lastDay(sYmd.substring(0,6));  // �ش���� �������� ���

  if((iDay < 1) || (iDay > iLastDay))
  {
    alert(iMonth+'���� ���ڴ� 1 - '+ iLastDay +'�����Դϴ�.');
    return false;
  }
  return true;
}


/**
 * ��¥ ���θ� Ȯ���Ѵ�.(����)
 * param : sMD �Է½�Ʈ��(MMDD)
 * return : Boolean true�̸� ��¥ ������
 */
function isDateMD(sMD)
{
  // ���� Ȯ��
  if(!isNumber(sMD))
  {
    alert('���ڸ� �Է��Ͻʽÿ�');
    return false;
  }

  // ���� Ȯ��
  if(sMD.length != 4)
  {
    alert('���ڸ� ��� �Է��Ͻʽÿ�');
    return false;
  }

  var iMonth = parseInt(trimZero(sMD.substring(0,2)));  //�ش���� ���ڰ�����
  var iDay = parseInt(trimZero(sMD.substring(2,4)));    //�ش����� ���ڰ�����

  if((iMonth < 1) ||(iMonth >12))
  {
    alert(iMonth+'���� �Է��� �߸� �Ǿ����ϴ�.');
    return false;
  }

  //�� ���� �� ������ ���Ѵ�
  if (iMonth < 8 )
   {
        var iLastDay = 30 + (iMonth%2);
   }
  else
   {
        var iLastDay = 31 - (iMonth%2);
   }

  if (iMonth == 2)
  {
    iLastDay = 29;
  }

  if((iDay < 1) || (iDay > iLastDay))
  {
    alert(iMonth+'���� ���ڴ� 1 - '+iLastDay+'�����Դϴ�.');
    return false;
  }
  return true;
}


/**
 * ��¥ ���θ� Ȯ���Ѵ�.(���)
 * param : sYM �Է½�Ʈ��(YYYYMM)
 * return : Boolean true�̸� ��¥ ������
 */
function isDateYM(sYM)
{
  // ���� Ȯ��
  if(!isNumber(sYM))
  {
    alert('��¥�� ���ڸ� �Է��Ͻʽÿ�');
    return false;
  }

  // ���� Ȯ��
  if(sYM.length != 6)
  {
    alert('���ڸ� ��� �Է��Ͻʽÿ�');
    return false;
  }

  var iYear = parseInt(sYM.substring(0,4)); //�⵵���� ���ڷ�
  var iMonth = parseInt(trimZero(sYM.substring(4,6)));  //���� ���ڷ�

  if((iMonth < 1) ||(iMonth >12))
  {
    alert(iMonth+'���� �Է��� �߸� �Ǿ����ϴ�.');
    return false;
  }
  return true;
}

/**
 * ����� �Է¹޾� ������ �ϸ� ��ȯ�Ѵ�(���)
 * param : sYM �Է½�Ʈ��(YYYYMM)
 * return : String �ش���� ��������
 */
function lastDay(sYM)
{
  if(sYM.length != 6)
  {
    alert("��Ȯ�� ����� �Է��Ͻʽÿ�.");
    return;
  }

  if(!isDateYM(sYM))
  {
     return;
  }

  daysArray = new makeArray(12);    // �迭�� �����Ѵ�.

  for (i=1; i<8; i++)
  {
    daysArray[i] = 30 + (i%2);
  }
  for (i=8; i<13; i++)
  {
    daysArray[i] = 31 - (i%2);
  }
  var sYear = sYM.substring(0, 4) * 1;
  var sMonth	= sYM.substring(4, 6) * 1;

  if (((sYear % 4 == 0) && (sYear % 100 != 0)) || (sYear % 400 == 0))
  {
                daysArray[2] = 29;
  }
  else
  {
                daysArray[2] = 28;
  }

  return daysArray[sMonth].toString();
}


/**
 * �ð� ���� Ȯ���Ѵ�.
 * param : sHm �Է½�Ʈ��(HHMM)
 * return : Boolean true�̸� �ð� ������
 */
function isTime(sHm)
{

  // ���� Ȯ��
  if(!isNumber(sHm))
  {
    alert('���ڸ� �Է��Ͻʽÿ�');
    return false;
  }

  // ���� Ȯ��
  if(sHm.length != 4)
  {
    alert('4�ڸ��� ��� �Է��Ͻʽÿ�(HHMM)');
    return false;
  }

  var iHH = parseInt(trimZero(sHm.substring(0,2))); //�ð��� ���ڷ�
  var iMM = parseInt(trimZero(sHm.substring(2,4))); //���� ���ڷ�

  if((iHH < 0) ||(iHH >23))
  {
    alert('�ð� �Է��� �߸� �Ǿ����ϴ�.');
    return false;
  }

  if((iMM < 0) ||(iMM >59))
  {
    alert('�� �Է��� �߸� �Ǿ����ϴ�.');
    return false;
  }
  return true;
}


/**
 * ��ҹ��ڸ� ������ ���������� Ȯ���Ѵ�.
 * param : sVal �Է¹��ڿ�
 * return : Boolean true�̸� ���ĺ�
 */
function isAlpha(sVal)
{
  // Alphabet ��
  var sAlphabet="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  var iLen=sVal.length;   //�Է°��� ����

  for(i=0;i<iLen;i++)
  {
    if(sAlphabet.indexOf(sVal.substring(i,i+1))<0)
    {
      alert("���� ���ڰ� �ƴմϴ�.\n�������� �Է��� �ֽʽÿ�");
      return false;
    }
  }
  return true;
}

/**
 * �����ڿ� ���� ������ ���ڿ����� Ȯ��
 * param : sVal �Է¹��ڿ�
 * return : Boolean true�̸� ������,���ڷ� ������ ���ڿ�
 */
function isAlphaNumeric(sVal)
{
  var sAlphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
  var iLen      = sVal.length;

  for ( i = 0; i < iLen; i++ )
  {
    if ( sAlphabet.indexOf(sVal.substring(i, i+1)) < 0 )
    {
      return false;
    }   // end of if
  } // end of for
  return true;
}   // end of isAlphaNumeric

/**
 * ���ڿ��� ���̸� return (�ѱ�:2��)
 * param : sVal �Է¹��ڿ�
 * return : int �Է¹��ڿ��� ����
 */
function strLength(sVal)
{
  var sBit = '';    // ���ڿ��� ����(Char)
  var iLen = 0; //���ڿ� ����

  for ( i = 0 ; i < sVal.length ; i++ )
  {
    sBit = sVal.charAt(i);
    if ( escape( sBit ).length > 4 )
    {
      iLen = iLen + 2;
    }
        else
        {
      iLen = iLen + 1;
    }
  }
  return iLen;
}


/**
 * �ѱ����� ���� üũ
 * param : sVal �Է¹��ڿ�
 * return : Boolean true�̸� �ѱ�
 */
function isHangul(sVal)
{
  var sBit = '';
  var iLen = 0;
  for(i=0;i<sVal.length;i++)
  {
    sBit = sVal.charAt(i);
    if(escape( sBit ).length <= 4)
    {
      return false;
    }
  }
  return true;
}

/**
 * �ֹε�� ���θ� Ȯ���Ѵ�.
 * param : sID �Է¹��ڿ�(�ֹι�ȣ 13�ڸ�)
 * return : Boolean true�̸� ������ �ֹι�ȣ
 */
function isIdentifyNo(sID)
{
  cBit = 0;
  sCode="234567892345";

  for(i=0;i<12;i++)
  {
    cBit = cBit+parseInt(sID.substring(i,i+1))*parseInt(sCode.substring(i,i+1));
  }

  cBit=11-(cBit%11);
  cBit=cBit%10;

  if(parseInt(sID.substring(12,13))==cBit)
  {
    return true;
  }
  else
  {
    return false;
  }
}


/**
 * �Է¹��� ��¥�κ��� ���� ���� ��¥�� ��ȯ�ϱ�
 * param : ObjDate��ü, �ϼ�, ���Data��ü
 * return :
 */
function calcDate(objDate,iDay,objResultDate)
{
  daysArray = new makeArray(12); //���� ������ ����

  for(i=1; i<13; i++)
  {
    daysArray[i] = 30 + (i%2);
  }

  var sYear  	= objDate.value.substring(0, 4) * 1;
  var sMonth 	= objDate.value.substring(4, 6) * 1;
  var sDay   	= objDate.value.substring(6, 8) * 1;

  daysArray[2] = lastDay(sYear + "02");

  var iMoveRemain = iDay * 1 + sDay;
  var iCurMonth   = sMonth;
  var iCurYear    = sYear;

  while (iMoveRemain > daysArray[iCurMonth])
  {
    iMoveRemain = iMoveRemain - daysArray[iCurMonth];

    iCurMonth = iCurMonth + 1;
    if (iCurMonth > 12)
    {
      iCurMonth = 1;
      iCurYear = iCurYear + 1;
      daysArray[2] = lastDay(iCurYear + "02");
    }
  } //end of while

  iCurMonth = addZero(iCurMonth.toString());
  iMoveRemain = addZero(iMoveRemain.toString());

  objResultDate.value = iCurYear + iCurMonth + iMoveRemain;
}



/**
 * ���� 0���� �ʱ�ȭ �� 1���� �迭�� �����Ѵ�.
 * param : iSize �迭 ũ��
 * return : this �迭
 */
function makeArray(iSize)
{
  this.length = iSize;

  for (i = 1; i <= iSize; i++)
  {
    this[i] = 0;
  }
  return this;
}


/**
 * ����� ��ȣ�� ��Ȯ���� Ȯ���Ѵ�.
 * param : iSaupNo ����ڹ�ȣ
 * return : Boolean true�̸� ������ ����ڹ�ȣ
 */
function isSaupNO(iSaupNo)
{
  if (!isNumber(iSaupNo))
  {
    alert("����� ��ȣ�� �ݵ�� ���ڷ� �����Ǿ�� �մϴ�.");
    return false;
  }
  else if (iSaupNo.length != 10)
  {
    alert("����� ��ȣ�� 10�ڸ� �Դϴ�.");
    return false;
  }

  var arr_saup = iSaupNo.split("");
  var wtArray = new Array(1,3,7,1,3,7,1,3,5);
  var iSaup_9 = 0;
  var iSum_saup = 0;
  var iCheck_digit = 0;

  //1~8�ڸ����� ����ġ�� ���Ͽ� ��� ���Ѵ�.
  for (i = 0; i < 8; i++)
  {
      iSum_saup +=  eval(arr_saup[i]) * eval(wtArray[i]);
  }

  iSum_saup = iSum_saup % 10;
  //9��° �ڸ� ���ڿ� 5�� ���Ѵ�.
  iSaup_9 = eval(arr_saup[8]) * 5

  //5�� ���� ���� 10���� ������  ��� �������� ���� 1~8�հ迡 ���Ѵ�.
  iSum_saup +=  Math.floor(iSaup_9 / 10) + iSaup_9 % 10;

  //��� ���� 10���� ����.
  iCheck_digit = 10 - (iSum_saup % 10);

  //��� ���� 10���� ���� �������� ���Ѵ�. (Check Digit)
  iCheck_digit = iCheck_digit % 10;

  if (iCheck_digit != arr_saup[9])
  {
    alert("����� ��ȣ�� ��Ȯ���� �ʽ��ϴ�.\n �ٽ� Ȯ���Ͻ��� �Է��Ͻʽÿ�.");
    return false;
  }
  return true;
}


/**
 * ���� ��ȣ�� ��Ȯ���� Ȯ���Ѵ�.
 * param : sRegNo ���ι�ȣ
 * return : Boolean true�̸� ������ ���ι�ȣ
 */
function isRegNo(sRegNo)
{
  if (!isNumber(sRegNo))
  {
    alert("���� ��ȣ�� �ݵ�� ���ڷ� �����Ǿ�� �մϴ�.");
    return false;
  }
  else if (sRegNo.length != 13)
  {
    alert("���� ��ȣ�� 13�ڸ� �Դϴ�.");
    return false;
  }

  var arr_regno = sRegNo.split("");
  var arr_wt = new Array(1,2,1,2,1,2,1,2,1,2,1,2);
  var iSum_regno = 0;
  var iCheck_digit = 0;

  //1~12�ڸ����� ����ġ�� ���Ͽ� ��� ���Ѵ�.
  for (i = 0; i < 12; i++)
  {
      iSum_regno +=  eval(arr_regno[i]) * eval(arr_wt[i]);
  }

  //�հ踦 10���� ���� �������� 10���� ����.
  iCheck_digit = 10 - (iSum_regno % 10);

  //��� ���� 10���� ���� �������� ���Ѵ�. (Check Digit)
  iCheck_digit = iCheck_digit % 10;

  if (iCheck_digit != arr_regno[12])
  {
      alert("���� ��ȣ�� ��Ȯ���� �ʽ��ϴ�.\n �ٽ� Ȯ���Ͻ��� �Է��Ͻʽÿ�.");
      return false;
  }

  return true;
}

/**
 * ���� �и���(,)(.)�� �ִ� �����̰ų� �Ϲݼ����������� �˻��Ѵ�.
 * param : sVal
 * return : Boolean
 */
function isMoneyNumber(sVal)
{
  var iAbit;

  if (sVal.length < 1) return true;
  for (i=0; i<sVal.length; i++)
  {
    iAbit = parseInt(sVal.substring(i,i+1));
    if (!(('0' < iAbit) || ('9' > iAbit)))
    {
      if (sVal.substring(i, i+1) == ',' || sVal.substring(i, i+1) == '.' )
      {
      }
      else
      {
        return false;
      }
    }
  }
  return true;
}


/**
 * �޸� ���� ǥ��. �߰��� ���� �̿��� ǥ���� ������.
 * param : val
 * return : String
 */
function getMoneyType(val)
{
  if (typeof val == "number")
  {
    val = val.toString();
  }

  var value = getOnlyNumberDot(val);

  var sResult = "";

  if (value.length == 0)
  {
    alert("���ڸ��� �Է��ϼ���.");
    return;
  }

  if (! isMoneyNumber(value))
  {
    alert("���ڸ��� �Է��ϼ���.");
    return;
  }

  var nI;
  var nJ = -1;
  var subOne;
  var flag = false;

  for (nI = value.length - 1; nI >= 0; nI--)
  {

    subOne = value.substring(nI, nI + 1);
    sResult = subOne + sResult;


        if (subOne == '.')
        {
                flag = true;
        }

        if (flag == true)
        {
                nJ = nJ + 1;
        }

    if ((nJ % 3 == 0) && (nI != 0) && (nJ != 0))
    {
      sResult = "," + sResult;
    }
  }
  return sResult;
}

/**
 * ��ȣ�� �ִ� �޸� ���� ǥ��. �߰��� ���� �̿��� ǥ���� ������
 * param : val
 * return : String
 */
function getSignMoneyType(val)
{
  if (typeof val == "number")
  {
         val = val.toString();
  }

  var s1		= val.substring(0,1);
  var slen	= val.length;
  var sign	= "";
  var ret		= "";
  if (val == "-Infinity")
  {
                return "0";
  }

  if(slen>1 )
  {
    if(s1 == "-")
    {
      sign = "-";
      ret = sign + getMoneyType(val.substring(1,slen));
     }
     else
     {
       ret = getMoneyType(val);
     }
   }
   else
   {
     ret = val;
   }
   return  ret;
}

/**
 * �޸��� ������ �������� ���ڿ��� ��ȯ
 * param : val
 * return : String
 */
function getOnlyNumber(val)
{
  var value = "";
  var abit;

  if (typeof val != "number" && typeof val !="string")
  {
    return "0";
  }
  if (val.length < 1 || val == "NaN" || val == "-Infinity")
  {
    return "0";
  }

  for (i=0;i<val.length;i++)
  {
    abit = parseInt(val.charAt(i));
    if (0 <= abit && 9 >= abit )
      value += abit;

  }
  return value;
}

function getOnlyNumberDot(val)
{
  var value = "";
  var abit;

  if (typeof val != "number" && typeof val !="string")
  {
    return "0";
  }
  if (val.length < 1 || val == "NaN" || val == "-Infinity")
  {
    return "0";
  }

  for (i=0;i<val.length;i++)
  {
          abit = val.charAt(i);
    switch (abit){
    case '.' :
      value += abit;
      break;
    default :
      if (0 <= parseInt(abit) && 9 >= parseInt(abit))
        value += abit;
    }

  }
  return value;
}

/**
 * �޸��� ������ ��ȣ�� �ִ� �������� ���ڿ��� ��ȯ
 * param : val
 * return : String
 */
function getOnlySignNumber(val)
{
  if (val == "-") return 0;
  var price = eval(getOnlyNumber(val));
  if (val.substring(0,1) == "-")
  {
    price *= -1;
  }
  return price;
}

/**
 * ��ȸ���� �����ϰ� ������ �Է� ��ȿ�� Ȯ�� - ����� �̿�
 * param : objFrom, objTo
 * return : String
 */
function chkPeriod(objFrom, objTo)
{
  if (!isDate(objFrom.value))
  {
    objFrom.focus();
    return false;
  }
  else if (!isDate(objTo.value))
  {
    objTo.focus();
    return false;
  }
  else if (objFrom.value > objTo.value)
  {
    alert("���������� �����Ϻ��� �۽��ϴ�");
    objFrom.focus();
    return false;
  }
  return true;
}

/**
 * �յ� ������ �����Ѵ�.
 * param : sVal
 * return : String
 */
function Trim(sVal)
{
  return(LTrim(RTrim(sVal)));
}

/**
 * �� ������ �����Ѵ�.
 * param : sVal
 * return : String
 */
function LTrim(sVal)
{
  var i;
  i = 0;
  while (sVal.substring(i,i+1) == ' ')
  {
    i++;
  }
  return sVal.substring(i);
}



/**
 * �� ������ �����Ѵ�.
 * param : sVal
 * return : String
 */
function RTrim(sVal)
{
  var i = sVal.length - 1;
  while (i >= 0 && sVal.substring(i,i+1) == ' ')
  {
    i--;
  }
  return sVal.substring(0,i+1);
}

/**
 * ���鸸 �����ϰų� �ƹ��͵� ������ Ȯ���Ѵ�.
 * param : sVal
 * return : boolean �����̳� Empty�̴�
 */
function isEmpty(sVal){
  if (Trim(sVal) == '')
  {
    return true;
  }
  return false;
}

/**
 * ���� ��Ʈ�Ѱ� MaxLength �޾Ƽ� MaxLength �Ǹ� ���� ��Ʈ�ѷ� �̵�
 * param : objCurrent, objNext
 */
function focusMove(objCurrent, objNext)
{
  if ( objCurrent.getAttribute("Maxlength") == objCurrent.value.length)
  {
    objNext.focus();
  }
}

/**
 * ���� ��Ʈ�Ѱ� MaxLength �޾Ƽ� MaxLength �Ǹ� ���� ��Ʈ�ѷ� �̵�(����)
 * param : objCurrent, objNext
 */
function focusMoveSelect(objCurrent, objNext)
{
  if ( objCurrent.getAttribute("Maxlength") == objCurrent.value.length)
  {
    objNext.focus();
    objNext.select();
  }
}

/**
 * ���� ��Ʈ�Ѱ� MaxLength �޾Ƽ� MaxLength �ǰų� EnterŰ�� ��������  ���� ��Ʈ�ѷ� �̵�
 * param : objCurrent, objNext
 */
function focusMoveEnter(objCurrent, objNext)
{
  if ( objCurrent.getAttribute("Maxlength") == objCurrent.value.length || event.keyCode==13)
  {
    objNext.focus();
  }
}

/**
 * ���� ��Ʈ�Ѱ� MaxLength �޾Ƽ� MaxLength  �ǰų� EnterŰ�� �������� ���� ��Ʈ�ѷ� �̵�(����)
 * param : objCurrent, objNext
 */
function focusMoveEnterSelect(objCurrent, objNext)
{
  if ( objCurrent.getAttribute("Maxlength") == objCurrent.value.length || event.keyCode==13)
  {
    objNext.focus();
    objNext.select();
  }
}

/**
 * ��ȸ����� validation�� check�Ѵ�(argument:control)
 * param : objFromY,objFormM,objToY,objToM,msg
 * return : boolean
 */
function checkPeriodYM(objFromY,objFromM,objToY,objToM,msg)
{
  if (typeof msg != "string")
  {
    msg = "��ȸ";
  }

  var fYYYY = Trim(objFromY.value);
  var fMM   = Trim(objFromM.value);
  var tYYYY = Trim(objToY.value);
  var tMM   = Trim(objToM.value);

  if(fYYYY.length<1||fYYYY.length!=4)
  {
    alert(msg + " ���۳��� 4�ڸ��Դϴ�!");
    objFromY.focus();
    return false;
  }
  if(fMM.length<1||fMM.length!=2)
  {
    alert(msg + " ���ۿ��� 2�ڸ��Դϴ�!");
    objFromM.focus();
    return false;
  }
  if(tYYYY.length<1||tYYYY.length!=4)
  {
    alert(msg + " ������� 4�ڸ��Դϴ�!");
    objToY.focus();
    return false;
  }
  if(tMM.length<1||tMM.length!=2)
  {
    alert(msg + " ������� 2�ڸ��Դϴ�!");
    objToM.focus();
    return false;
  }
  if(!isNumber(fYYYY))
  {
    alert("�⵵�� ���ڸ� �Է��Ͻʽÿ�!");
    objFromY.focus();
    return false;
  }
  if(!isNumber(fMM))
  {
    alert("���� ���ڸ� �Է��Ͻʽÿ�!");
    objFromM.focus();
    return false;
  }
  if(!isNumber(tYYYY))
  {
    alert("�⵵�� ���ڸ� �Է��Ͻʽÿ�!");
    objToY.focus();
    return false;
  }
  if(!isNumber(tMM))
  {
    alert("���� ���ڸ� �Է��Ͻʽÿ�!");
    objToM.focus();
    return false;
  }
  if(fYYYY>tYYYY)
  {
    alert("���۳��� ����⺸�� Ů�ϴ�!");
    objFromY.focus();
    return false;
  }
  if((fYYYY==tYYYY)&&(fMM>tMM))
  {
    alert("���ۿ��� ��������� Ů�ϴ�!");
    objFromM.focus();
    return false;
  }
  if((fMM == '00') ||(fMM >12))
  {
    alert(fMM+'���� �Է��� �߸� �Ǿ����ϴ�!');
    objFromM.focus();
    return false;
  }
  if(( tMM== '00') ||(tMM >12))
  {
    alert(tMM+'���� �Է��� �߸� �Ǿ����ϴ�!');
    objToM.focus();
    return false;
  }
  return true;
}

/**
 * ��ȸ��� validation checking (argument:control).
 * param : objYear,objMonth
 * return :
 */
function checkYM(objYear,objMonth)
{
  var sYear  = Trim(objYear.value);
  var sMonth = Trim(objMonth.value);

  if(sYear.length<1||sYear.length!=4)
  {
    alert("��ȸ���� 4�ڸ��Դϴ�!");
    objYear.focus();
    return false;
  }
  if(sMonth.length<1||sMonth.length!=2)
  {
    alert("��ȸ���� 2�ڸ��Դϴ�!");
    objMonth.focus();
    return false;
  }

  if(!isNumber(sYear))
  {
    alert("�⵵�� ���ڸ� �Է��Ͻʽÿ�!");
    objYear.focus();
    return false;
  }
  if(!isNumber(sMonth))
  {
    alert("���� ���ڸ� �Է��Ͻʽÿ�!");
    objMonth.focus();
    return false;
  }

  if((sMonth == '00') ||(sMonth >12))
  {
    alert(sMonth+'���� �Է��� �߸� �Ǿ����ϴ�!');
    objMonth.focus();
    return false;
  }
  return true;
}

/**
 * ��ȸ��� validation checking (argument:control).
 * param : objFromY,objFormM,objFromD,objToY,objToM,objToD,msg
 * return : boolean
 */
function checkYMD(objFromY,objFromM,objFromD,objToY,objToM,objToD,msg)
{
  if (typeof msg != "string")
  {
    msg = "��ȸ";
  }

  if(!checkPeriodYM(objFromY,objFromM,objToY,objToM,msg))
  {
    return false;
  }

  var fDD = Trim(objFromD.value);
  var tDD = Trim(objToD.value);

  if(fDD.length<1||fDD.length!=2)
  {
    alert(msg + " �������� 2�ڸ��Դϴ�!");
    objFromD.focus();
    return false;
  }
  if(tDD.length<1||tDD.length!=2)
  {
    alert(msg + " �������� 2�ڸ��Դϴ�!");
    objToD.focus();
    return false;
  }
  if(!isNumber(fDD))
  {
    alert("��¥�� ���ڸ� �Է��Ͻʽÿ�!");
    objFromD.focus();
    return false;
  }
  if(!isNumber(tDD))
  {
    alert("��¥�� ���ڸ� �Է��Ͻʽÿ�!");
    objToD.focus();
    return false;
  }

  var fDays = lastDay(objFromY.value + "" + objFromM.value);
  var tDays = lastDay(objToY.value + "" + objToM.value);

  if(fDD> fDays)
  {
    alert("�������� �Է��� �߸��Ǿ����ϴ�!");
    objFromD.focus();
    return false;
  }
  if(tDD> tDays)
  {
    alert("�������� �Է��� �߸��Ǿ����ϴ�!");
    objToD.focus();
    return false;
  }
  if((objFromY.value==objToY.value)&&(objFromM.value==objToM.value)&&(fDD>tDD))
  {
    alert("�������� �����Ϻ��� Ů�ϴ�!");
    objFromD.focus();
    return false;
  }
  return true;
}


/**
 * ����� validation checking
 * param : objYear,objMonth,objDay
 * return : boolean
 */
function checkDate(objYear,objMonth,objDay)
{

  var sYear = Trim(objYear.value);
  var sMonth = Trim(objMonth.value);
  var sDay = Trim(objDay.value);


  if(sYear.length<1||sYear.length!=4)
  {
    alert("�⵵�� 4�ڸ��Դϴ�!");
    objYear.focus();
    return false;
  }
  if(sMonth.length<1||sMonth.length!=2)
  {
    alert("���� 2�ڸ��Դϴ�!");
    objMonth.focus();
    return false;
  }
  if(sDay.length<1||sDay.length!=2)
  {
    alert("��¥�� 2�ڸ��Դϴ�!");
    objDay.focus();
    return false;
  }
  if(!isNumber(sYear))
  {
    alert("�⵵�� ���ڸ� �Է��Ͻʽÿ�!");
    objYear.focus();
    return false;
  }
  if(!isNumber(sMonth))
  {
    alert("���� ���ڸ� �Է��Ͻʽÿ�!");
    objMonth.focus();
    return false;
  }
  if(!isNumber(sDay))
  {
    alert("��¥�� ���ڸ� �Է��Ͻʽÿ�!");
    objDay.focus();
    return false;
  }

  var days = lastDay(sYear + sMonth);

  if((sMonth == '00')||(sMonth >12))
  {
    alert(objMonth+'���� �Է��� �߸� �Ǿ����ϴ�!');
    objMonth.focus();
    return false;
  }

  if((sDay > days)||(sDay == '00'))
  {
    alert(sDay+"���� �Է��� �߸��Ǿ����ϴ�!");
    objDay.focus();
    return false;
  }
  return true;
}

/**
 * �־��� ����� ��� ������ ����� ���Ѵ�.
 * param : yyyy,mm,how,anb
 * return : String
 */
function getYYYYMM(yyyy,mm,how,anb)
{
  var year = yyyy * 1;
  var month	= mm * 1;
  var cnt  = how * 1;

  for(var i=1; i< cnt+1; i++)
  {
    if(anb == '-')
    {
      month = month - 1;
      if(month==0)
      {
        year = year - 1;
        month = 12;
      }
    }
    else if(anb == '+')
    {
      month = month + 1;
      if(month>12)
      {
        year = year + 1;
        month = 1;
      }
    }
    else
    {
    }
  }
  return year.toString()+addZero(month.toString());
}

/**
 * ��ȸ��� validation checking
 * param : objYear, objMonth
 * return : boolean
 */
function isYearMonth(objYear,objMonth)
{
  var objYear = Trim(objYear.value);
  var objMonth	 = Trim(objMonth.value);

  if(objYear.length<1||objYear.length!=4)
  {
    return false;
  }
  if(objMonth.length<1||objMonth.length!=2)
  {
    return false;
  }
  if(!isNumber(objYear))
  {
    return false;
  }
  if(!isNumber(objMonth))
  {
    return false;
  }
  if((objMonth == '00') ||(objMonth >12))
  {
    return false;
  }
  return true;
}

/**
 * ��Ű ����.
 * param : name, value
 */
function setCookie(name, value)
{
  var path = "/";
  var expires = 1; 	//�Ϸ�.
  var domain = "";

  var today = new Date();
  today.setDate(today.getDate() + expires );

  document.cookie = name + "=" + escape(value)+ "; path=" + path ;
}

/**
 * �˾�â �ݱ�
 * param : element, name
 */
function closePopUp(element, name)
{
  if ( element.checked )
  {
    setCookie(name, "sleep");
  }
  window.close();
}

/**
 * ��Ű���� ��������
 * param : name
 */
function getCookie(name)
{
  var sCookieName = name + "=";
  var i = 0;
  var j;
  var endOfCookie;

  while ( i <= document.cookie.length )
  {
    j = (i+sCookieName.length);

    if ( document.cookie.substring(i,j) == sCookieName )
    {
      if ( (endOfCookie=document.cookie.indexOf( ";", j )) == -1 )
      {
        endOfCookie = document.cookie.length;
      }
      return unescape( document.cookie.substring( j, endOfCookie ) );
    }

    i = document.cookie.indexOf( " ", i ) + 1;
    if (i == 0)
    {
      break;
    }
  }
  return "";
}


/**
 * ��ġ����(����)
 * param : width
 */
function positionWidth(width)
{
  var x = (screen.width - width)/2;
  return x
}

/**
 * ��ġ����(����)
 * param : height
 */
function positionHeight(height)
{
  var y = (screen.height - height)/2;
  return y
}


/**
  * �޸��� �߰��� �������� ���ڿ��� ��ȯ
  * param : frm
  * return : String
  */

function CommaNum(frm)
{
alert("here");

                var me=frm;
         //var str=me.value;
         var fType="";

        if (me.value.length <= 3||me.value == "") return;

        var Len, TLen, i, j;
        var strFormat, varFormat, meValue, DotValue;

        if (fType == " ")
        {
                meValue = me.value;
                Tlen = meValue.length - 1;
                i = 0;
                varFormat = "";

                while (i <= Tlen)

                {

                        if (meValue.substr(i,1) != ",")
                                varFormat = varFormat + meValue.substr(i,1);

                        i = i + 1;

                }

                me.value = varFormat;

        }
        else
        {
                meValue = me.value;
                Tlen = meValue.length - 1;

                i = 0;

                varFormat = "";

                while (i <= Tlen)

                {
                        if (meValue.substr(i,1) != ",")
                        {
                                varFormat = varFormat + meValue.substr(i,1);
                        }

                        i = i + 1;

                }


                meValue = varFormat;
                Tlen = meValue.length - 1;
                i = 0;
                DotValue = "";

                while (i <= Tlen)

                {
                        if (meValue.substr(i,1) == ".")
                        {
                                DotValue = meValue.substr(i);
                                meValue  = meValue.substr(0, i);
                        }
                        i = i + 1
                }

                if(meValue.substr(0,1)=="-")
                {
                        meValue = meValue;
                }


                Tlen = meValue.length;

                i = Tlen - 1;

                varFormat = "";

                while (i > 2)

                {

                        strFormat = meValue.substr(i-2,3);

                        if (i == (Tlen -1))

                                varFormat = ","+strFormat;

                        else

                                varFormat = ","+strFormat+varFormat;

                        i = i - 3;

                }

                varFormat = meValue.substr(0,i+1)+varFormat;

                Tlen=varFormat.length;

                if(varFormat.substr(0,1) == "-"){
                        if (varFormat.substr(1,1)==","){

                                varFormat=varFormat.substr(0,1)+varFormat.substr(2,Tlen-2);

                                me.value = varFormat+DotValue;

                        }

                }

                //if (meValue.substr(0,1) == "-")

                //	varFormat = "-"+varFormat;

                me.value = varFormat+DotValue;
        }

    alert("here2");
}




// common message

/**
 * @type   : var
 * @access : public
 * @desc   : ���������� ���θ� Ȯ�ι޴� ���� �޼���
 */
var MSG_CONFIRM_SAVE = "�����Ͻðڽ��ϱ�?";

/**
 * @type   : var
 * @access : public
 * @desc   : ����ϷḦ �˸��� ���� �޼���
 */
var MSG_COMPLETE_SAVE = "���������� �����Ͽ����ϴ�.";

/**
 * @type   : var
 * @access : public
 * @desc   : ��������� ���θ� Ȯ�ι޴� ���� �޼���
 */
var MSG_CONFIRM_REGIST = "����Ͻðڽ��ϱ�?";

/**
 * @type   : var
 * @access : public
 * @desc   : ��ϿϷḦ �˸��� ���� �޼���
 */
var MSG_COMPLETE_REGIST = "���������� ����Ͽ����ϴ�.";

/**
 * @type   : var
 * @access : public
 * @desc   : ���������� ���θ� Ȯ�ι޴� ���� �޼���
 */
var MSG_CONFIRM_UPDATE = "�����Ͻðڽ��ϱ�?";

/**
 * @type   : var
 * @access : public
 * @desc   : �����ϷḦ �˸��� ���� �޼���
 */
var MSG_COMPLETE_UPDATE = "���������� �����Ͽ����ϴ�.";

/**
 * @type   : var
 * @access : public
 * @desc   : ���������� ���θ� Ȯ�ι޴� ���� �޼���
 */
var MSG_CONFIRM_DELETE = "�����Ͻðڽ��ϱ�?";

/**
 * @type   : var
 * @access : public
 * @desc   : �����ϷḦ �˸��� ���� �޼���
 */
var MSG_COMPLETE_DELETE = "���������� �����Ͽ����ϴ�.";

/**
 * @type   : var
 * @access : public
 * @desc   : ��������� ������ �˸��� ���� �޼���.
 */
var MSG_NOTIFY_NOT_UPDATED = "����� ������ �����ϴ�.";

/**
 * @type   : var
 * @access : public
 * @desc   : ��������� �ݿ����� �ʾ����� �˸��� Ȯ�� �޼���.
 */
var MSG_CONFIRM_CONTINUE_WITHOUT_APPLY_CHANGE = "��������� �ݿ����� �ʾҽ��ϴ�. ��� �Ͻðڽ��ϱ�?";

/**
 * @type   : var
 * @access : public
 * @desc   : �˻� ������ �Է����� �ʾ����� �˸��� Ȯ�� �޼���.
 */
var MSG_ERR_SEARCH = "�˻� ������ �Է��ϼ���.";

var MSG_PARAM_TEST        = "���޵� 3���� �Ķ���ʹ� @, @, @ �Դϴ�.";

// validation message
var VMSG_VALID            = "��ȿ�մϴ�.";
var VMSG_ITEMNAME         = "@ ��(��) ";
var VMSG_GRID             = "@�� @��° �����Ϳ��� ";
var VMSG_ERR_DUPLICATE    = "�ߺ��� �� �����ϴ�.";
var VMSG_ERR_LENGTH       = "@�ڸ�����ŭ �Է��Ͻʽÿ�.";
var VMSG_ERR_BYTE_LENGTH  = "@�ڸ�����ŭ �Է��Ͻʽÿ�. (�ѱ��� @�ڸ���)";
var VMSG_ERR_MIN_LENGTH   = "@�� �̻����� �Է��Ͻʽÿ�.";
var VMSG_ERR_MIN_BYTE_LENGTH   = "@�� �̻����� �Է��Ͻʽÿ�. (�ѱ��� @�� �̻�)";
var VMSG_ERR_MAX_LENGTH   = "@�� ���Ϸ� �Է��Ͻʽÿ�.";
var VMSG_ERR_MAX_BYTE_LENGTH   = "@�� ���Ϸ� �Է��Ͻʽÿ�. (�ѱ��� @�� ����)";
var VMSG_ERR_MIN_NUM      = "@ �̻����� �Է��Ͻʽÿ�.";
var VMSG_ERR_MAX_NUM      = "@ ���Ϸ� �Է��Ͻʽÿ�.";
var VMSG_ERR_IN_NUM       = "@���� @���̷� �Է��Ͻʽÿ�.";
var VMSG_ERR_NUMBER       = "���ڸ��� �Է��Ͻʽÿ�.";
var VMSG_ERR_ALPHA        = "���ڸ��� �Է��Ͻʽÿ�.";
var VMSG_ERR_REQUIRED     = "�ʼ� �Է� �׸��Դϴ�.";
var VMSG_ERR_SSN          = "��ȿ�� �ֹε�Ϲ�ȣ�� �ƴմϴ�.";
var VMSG_ERR_CSN          = "��ȿ�� ����ڵ�Ϲ�ȣ�� �ƴմϴ�.";
var VMSG_ERR_FILTER       = "���� ���ڰ� �� �� �����ϴ�.\n@";
var VMSG_ERR_DATE         = "��ȿ�� ��¥�� �ƴմϴ�.";
var VMSG_ERR_YEAR         = "�⵵�� �߸��Ǿ����ϴ�.";
var VMSG_ERR_MONTH        = "���� �߸��Ǿ����ϴ�.";
var VMSG_ERR_DAY          = "���� �߸��Ǿ����ϴ�.";
var VMSG_ERR_HOUR         = "�ð� �߸��Ǿ����ϴ�.";
var VMSG_ERR_MINUTE       = "���� �߸��Ǿ����ϴ�.";
var VMSG_ERR_SECOND       = "�ʰ� �߸��Ǿ����ϴ�.";
var VMSG_ERR_MIN_DATE     = "@�� @�� @�� �����̾�� �մϴ�.";
var VMSG_ERR_MAX_DATE     = "@�� @�� @�� �����̾�� �մϴ�.";
var VMSG_ERR_FORMAT       = "'@' �����̾�� �մϴ�.\n" +
                            "  - # : ���� Ȥ�� ����\n" +
                            "  - A : ������\n" +
                            "  - Z : ����(Z�� ����, �ѱ�����)\n" +                            
                            "  - 0, 9 : ����(9�� ��������)";

var PMSG_ERR_PAGE         = "������ ������ �߸��Ǿ����ϴ�.";
var PMSG_ERR_MAXPAGE      = "@������ �̻��� ��� �Ҽ� �����ϴ�";

//----------------------------- 2. ���� ��ũ��Ʈ �����Դϴ�. -----------------------------//

// Global ��������
var GLB_MONTH_IN_YEAR   = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var GLB_DAY_IN_WEEK     = ["Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday"];
var GLB_DAYS_IN_MONTH   = [31,28,31,30,31,30,31,31,30,31,30,31];
var GLB_URL_COMMON_PAGE = "./common/";  // common ���丮�� URL

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� simpleReplace �޼ҵ带 �߰��Ѵ�. simpleReplace �޼ҵ��
 *           ��Ʈ�� ���� �ִ� Ư�� ��Ʈ���� �ٸ� ��Ʈ������ ��� ��ȯ�Ѵ�. String ��ü�� replace �޼ҵ�� ������
 *           ����� ������ ������ ��Ʈ���� ġȯ�ÿ� ���� �����ϰ� ����� �� �ִ�.
 * <pre>
 *     var str = "abcde"
 *     str = str.simpleReplace("cd", "xx");
 * </pre>
 * ���� ������ str�� "abxxe"�� �ȴ�.
 * @sig    : oldStr, newStr
 * @param  : oldStr required �ٲ��� �� ������ ��Ʈ��
 * @param  : newStr required �ٲ���� ���ο� ��Ʈ��
 * @return : replaced String.
 */
String.prototype.simpleReplace = function(oldStr, newStr) {
        var rStr = oldStr;

        rStr = rStr.replace(/\\/g, "\\\\");
        rStr = rStr.replace(/\^/g, "\\^");
        rStr = rStr.replace(/\$/g, "\\$");
        rStr = rStr.replace(/\*/g, "\\*");
        rStr = rStr.replace(/\+/g, "\\+");
        rStr = rStr.replace(/\?/g, "\\?");
        rStr = rStr.replace(/\./g, "\\.");
        rStr = rStr.replace(/\(/g, "\\(");
        rStr = rStr.replace(/\)/g, "\\)");
        rStr = rStr.replace(/\|/g, "\\|");
        rStr = rStr.replace(/\,/g, "\\,");
        rStr = rStr.replace(/\{/g, "\\{");
        rStr = rStr.replace(/\}/g, "\\}");
        rStr = rStr.replace(/\[/g, "\\[");
        rStr = rStr.replace(/\]/g, "\\]");
        rStr = rStr.replace(/\-/g, "\\-");

          var re = new RegExp(rStr, "g");
    return this.replace(re, newStr);
}

// alert("abcde\.()-fgh$$?J+".simpleReplace("\\", ""));

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� trim �޼ҵ带 �߰��Ѵ�. trim �޼ҵ�� ��Ʈ���� �հ� �ڿ�
 *           �ִ� white space �� �����Ѵ�.
 * <pre>
 *     var str = " abcde "
 *     str = str.trim();
 * </pre>
 * ���� ������ str�� "abede"�� �ȴ�.
 * @return : trimed String.
 */
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� trimAll �޼ҵ带 �߰��Ѵ�. trim �޼ҵ�� ��Ʈ�� ����
 *           �ִ� white space �� ��� �����Ѵ�.
 * <pre>
 *     var str = " abc de "
 *     str = str.trimAll();
 * </pre>
 * ���� ������ str�� "abcde"�� �ȴ�.
 * @return : trimed String.
 */
String.prototype.trimAll = function() {
    return this.replace(/\s*/g, "");
}

// alert(" a b  d ".trimAll());

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� cut �޼ҵ带 �߰��Ѵ�. cut �޼ҵ�� ��Ʈ���� Ư�� ������
 *           �߶󳽴�.
 * <pre>
 *     var str = "abcde"
 *     str = str.cut(2, 2);
 * </pre>
 * ���� ������ str�� "abe"�� �ȴ�.
 * @sig    : start, length
 * @param  : start  required start index to cut
 * @param  : length required length to cut
 * @return : cutted String.
 */
String.prototype.cut = function(start, length) {
    return this.substring(0, start) + this.substr(start + length);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� insert �޼ҵ带 �߰��Ѵ�. insert �޼ҵ�� ��Ʈ���� Ư�� ������
 *           �־��� ��Ʈ���� �����Ѵ�.
 * <pre>
 *     var str = "abcde"
 *     str = str.insert(3, "xyz");
 * </pre>
 * ���� ������ str�� "abcxyzde"�� �ȴ�.
 * @sig    : start, length
 * @param  : index required ������ ��ġ. �ش� ��Ʈ���� index �ٷ� �տ� ���Եȴ�. index�� 0���� ����.
 * @param  : str   required ������ ��Ʈ��.
 * @return : inserted String.
 */
String.prototype.insert = function(index, str) {
    return this.substring(0, index) + str + this.substr(index);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : String.split() �� ������ �������� �ɼ��� �� �� �ִ�.
 * <pre>
 *     option list
 *
 *     - i : ignored split
 *         �տ� "\" �� ���� ���ڴ� deliminate��Ű�� �ʴ´�. ('\' ���ڸ� string���� ǥ���� ���� "\\" �� �ؾ���)
 *             var str = "abc,de\\,fg"
 *             var strArr = str.advancedSplit(",", "i");
 *         ���� ������ strArr[0]�� "abc", strArr[1]�� "de,fg"�� �ȴ�.
 *
 *     - t : trimed split
 *         split �Ŀ� splited string ���� trim ��Ų��.
 *             var str = "abc,  de,fg"
 *             var strArr = str.advancedSplit(",", "t");
 *         ���� ������ strArr[0]�� "abc", strArr[1]�� "de", strArr[2]�� "fg"�� �ȴ�.
 * </pre>
 * �ɼǵ��� ���������� ���� �� �ִ�.
 * <pre>
 *     var str = "abc,  de\\,fg"
 *     var strArr = str.advancedSplit(",", "it");
 * </pre>
 * ���� ������ strArr[0]�� "abc", strArr[1]�� "de,fg"�� �ȴ�.
 * @sig    : delim, options
 * @param  : delim   required delimenator
 * @param  : options required �ɼ��� ��Ÿ���� ���ڵ��� ������ ��Ʈ��
 * @return : splited string array.
 */
String.prototype.advancedSplit = function(delim, options) {
        if (options == null || options.trim() == "") {
                return this.split(delim);
        }

        var optionI = false;
        var optionT = false;

        options = options.trim().toUpperCase();

        for (var i = 0; i < options.length; i++) {
                if (options.charAt(i) == 'I') {
                        optionI = true;
                } else if (options.charAt(i) == 'T') {
                        optionT = true;
                }
        }

        var arr = new Array();
        var cnt = 0;
        var startIdx = 0;
        var delimIdx = -1;
        var str = this;
        var temp = 0;

        while ( (delimIdx = (str == null) ?
                 -1 : str.indexOf(delim, startIdx)
                ) != -1
              ) {

                if (optionI && str.charAt(delimIdx - 1) == '\\') {
                        str = str.cut(delimIdx - 1, 1);
                        startIdx = delimIdx;
                        continue;
                }

                arr[cnt++] = optionT ? str.substring(0, delimIdx).trim() :
                                       str.substring(0, delimIdx);

                str = str.substr(delimIdx + 1);
                startIdx = 0;
        }

        arr[cnt] = (str == null) ? "" : str;

        return arr;
}

/*
var splitTestStr = "abc  , de\\,  fg , f d".advancedSplit(",", "it");
for (var i = 0; i < splitTestStr.length; i++) {
        alert("'" + splitTestStr[i] + "'");
}
*/

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� toDate �޼ҵ带 �߰��Ѵ�. toDate �޼ҵ�� ��¥�� ǥ���ϴ�
 *           ��Ʈ�� ���� �ڹٽ�ũ��Ʈ�� ���� ��ü�� Date ��ü�� ��ȯ�Ѵ�.
 * <pre>
 *     var date = "2002-03-05".toDate("YYYY-MM-DD")
 * </pre>
 * ���� ������ date ������ ������ 2002�� 3�� 5���� ǥ���ϴ� Date ������Ʈ�� ����Ų��.
 * @sig    : [pattern]
 * @param  : pattern optional Date�� ǥ���ϰ� �ִ� ������ String�� pattern���� ǥ���Ѵ�. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : year(4�ڸ�)
 *       YY   : year(2�ڸ�)
 *       MM   : month in year(number)
 *       DD   : day in month
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *
 *     <font color=red>����)</font> YYYY(YY)�� �ݵ�� �־�� �Ѵ�. YYYY(YY) �� ����� ���� 1�� 1���� ��������
 *     �ϰ� YYYY�� MM ������� ���� 1���� �������� �Ѵ�.
 * </pre>
 * @return : ��ȯ�� Date Object.
 */
String.prototype.toDate = function(pattern) {
        var index = -1;
        var year;
        var month;
        var day;
        var hour = 0;
        var min  = 0;
        var sec  = 0;
        var ms   = 0;

        if (pattern == null) {
                pattern = "YYYYMMDD";
        }

        if ((index = pattern.indexOf("YYYY")) == -1 ) {
                index = pattern.indexOf("YY");
                year = "20" + this.substr(index, 2);
        } else {
                year = this.substr(index, 4);
        }

        if ((index = pattern.indexOf("MM")) != -1 ) {
                month = this.substr(index, 2);
        } else {
                month = 1;
        }

        if ((index = pattern.indexOf("DD")) != -1 ) {
                day = this.substr(index, 2);
        } else {
                day = 1;
        }

        if ((index = pattern.indexOf("HH")) != -1 ) {
                hour = this.substr(index, 2);
        }

        if ((index = pattern.indexOf("mm")) != -1 ) {
                min = this.substr(index, 2);
        }

        if ((index = pattern.indexOf("ss")) != -1 ) {
                sec = this.substr(index, 2);
        }

        if ((index = pattern.indexOf("SS")) != -1 ) {
                ms = this.substr(index, 2);
        }

        return new Date(year, month - 1, day, hour, min, sec, ms);
}

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� Date ��ü�� format �޼ҵ带 �߰��Ѵ�. format �޼ҵ�� Date ��ü�� ���� ��¥��
 *           ������ ������ ��Ʈ������ ��ȯ�Ѵ�.
 * <pre>
 *     var dateStr = new Date().format("YYYYMMDD");
 *
 *     ���� : Date ������Ʈ �����ڵ� - dateObj = new Date()
 *                                   - dateObj = new Date(dateVal)
 *                                   - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 * </pre>
 * ���� ������ ���ó�¥�� 2002�� 3�� 5���̶�� dateStr�� ���� "20020305"�� �ȴ�.
 * default pattern�� "YYYYMMDD"�̴�.
 * @sig    : [pattern]
 * @param  : pattern optional ��ȯ�ϰ��� �ϴ� ���� ��Ʈ��. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : hour in am/pm (1~12)
 *       MM   : month in year(number)
 *       MON  : month in year(text)  ��) "January"
 *       DD   : day in month
 *       DAY  : day in week  ��) "Sunday"
 *       hh   : hour in am/pm (1~12)
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *       a    : am/pm  ��) "AM"
 * </pre>
 * @return : Date�� ǥ���ϴ� ��ȯ�� String.
 */
Date.prototype.format = function(pattern) {
    var year      = this.getFullYear();
    var month     = this.getMonth() + 1;
    var day       = this.getDate();
    var dayInWeek = this.getDay();
    var hour24    = this.getHours();
    var ampm      = (hour24 < 12) ? 0 : 1;
    var hour12    = (hour24 > 12) ? (hour24 - 12) : hour24;
    var min       = this.getMinutes();
    var sec       = this.getSeconds();
    var YYYY = "" + year;
    var YY   = YYYY.substr(2);
    var MM   = (("" + month).length == 1) ? "0" + month : "" + month;
    var MON  = GLB_MONTH_IN_YEAR[month-1];
    var DD   = (("" + day).length == 1) ? "0" + day : "" + day;
    var DAY  = GLB_DAY_IN_WEEK[dayInWeek];
    var HH   = (("" + hour24).length == 1) ? "0" + hour24 : "" + hour24;
    var hh   = (("" + hour12).length == 1) ? "0" + hour12 : "" + hour12;
    var mm   = (("" + min).length == 1) ? "0" + min : "" + min;
    var ss   = (("" + sec).length == 1) ? "0" + sec : "" + sec;
    var SS   = "" + this.getMilliseconds();
    var a    = (a == 0) ? "AM" : "PM";

    var dateStr;
    var index = -1;

    if (typeof(pattern) == "undefined") {
            dateStr = "YYYYMMDD";
    } else {
            dateStr = pattern;
    }

        dateStr = dateStr.replace(/a/g,    a);
        dateStr = dateStr.replace(/YYYY/g, YYYY);
        dateStr = dateStr.replace(/YY/g,   YY);
        dateStr = dateStr.replace(/MM/g,   MM);
        dateStr = dateStr.replace(/MON/g,  MON);
        dateStr = dateStr.replace(/DD/g,   DD);
        dateStr = dateStr.replace(/DAY/g,  DAY);
        dateStr = dateStr.replace(/hh/g,   hh);
        dateStr = dateStr.replace(/HH/g,   HH);
        dateStr = dateStr.replace(/mm/g,   mm);
        dateStr = dateStr.replace(/ss/g,   ss);

        return dateStr;
}

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : ���� Date ��ü�� ��¥���� ���ĳ�¥�� ���� Date ��ü�� �����Ѵ�.
 *           ���� ��� ���� ��¥�� �������� ������ ���� �ϸ� �ȴ�.
 * <pre>
 *     var oneDayAfter = new Date.after(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional ���� ���
 * @param  : months  optional ���� ����
 * @param  : dates   optional ���� �ϼ�
 * @param  : hours   optional ���� �ð���
 * @param  : minutes optional ���� �м�
 * @param  : seconds optional ���� �ʼ�
 * @param  : mss     optional ���� �и��ʼ�
 * @return : ���ĳ�¥�� ǥ���ϴ� Date ��ü
 */
Date.prototype.after = function(years, months, dates, hours, miniutes, seconds, mss) {
    if (years == null)    years    = 0;
    if (months == null)   months   = 0;
    if (dates == null)    dates    = 0;
    if (hours == null)    hours    = 0;
    if (miniutes == null) miniutes = 0;
    if (seconds == null)  seconds  = 0;
    if (mss == null)      mss      = 0;

        return new Date(this.getFullYear() + years,
                        this.getMonth() + months,
                        this.getDate() + dates,
                        this.getHours() + hours,
                        this.getMinutes() + miniutes,
                        this.getSeconds() + seconds,
                        this.getMilliseconds() + mss
                       );
}
// alert(new Date().after(1, 1, 1, 1, 1, 1).format("YYYYMMDD HHmmss"));

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : ���� Date ��ü�� ��¥���� ������¥�� ���� Date ��ü�� �����Ѵ�.
 *           ���� ��� ���� ��¥�� �������� ������ ���� �ϸ� �ȴ�.
 * <pre>
 *     var oneDayBefore = new Date.before(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional �������� ���ư� ���
 * @param  : months  optional �������� ���ư� ����
 * @param  : dates   optional �������� ���ư� �ϼ�
 * @param  : hours   optional �������� ���ư� �ð���
 * @param  : minutes optional �������� ���ư� �м�
 * @param  : seconds optional �������� ���ư� �ʼ�
 * @param  : mss     optional �������� ���ư� �и��ʼ�
 * @return : ������¥�� ǥ���ϴ� Date ��ü
 */
Date.prototype.before = function(years, months, dates, hours, miniutes, seconds, mss) {
    if (years == null)    years    = 0;
    if (months == null)   months   = 0;
    if (dates == null)    dates    = 0;
    if (hours == null)    hours    = 0;
    if (miniutes == null) miniutes = 0;
    if (seconds == null)  seconds  = 0;
    if (mss == null)      mss      = 0;

        return new Date(this.getFullYear() - years,
                        this.getMonth() - months,
                        this.getDate() - dates,
                        this.getHours() - hours,
                        this.getMinutes() - miniutes,
                        this.getSeconds() - seconds,
                        this.getMilliseconds() - mss
                       );
}
//alert(new Date().before(1, 1, 1, 1, 1, 1).format("YYYYMMDD HHmmss"));


/**
 * @type   : function
 * @access : public
 * @desc   : �ʵ忡 �ִ� �ڸ����� �Է��� �� ������ �ٸ� �ʵ�� ��Ŀ���� �ڵ����� �̵��ȴ�.<br>
 *           html�� <Input type="text"> �� ���콺 EMEdit���� ��밡���ϴ�. <Input type="text"> �� ���
 *           maxLength �Ӽ��� �����Ǿ� �־�� �ϸ� EMEdit�� ��� MaxLength�� Format �Ӽ��� �ϳ��� �ݵ��
 *           ����Ǿ�� �Ѵ�.<br>
 *           byte length(�ѱ�)�� �������� �ʴ´�.<br>
 *           ������Ʈ ����� onkeydown �̺�Ʈ�� ������ ���� ����� �־�߸� �Ѵ�.
 * <pre>
 *     �ֹι�ȣ
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required ���� �Է��ʵ�
 * @param  : oNextElement required �ڵ����� ��Ŀ���� �̵��� �ʵ�
 */
/*
function cfAutoFocusNext(oElement, oNextElement) {
        if (event.keyCode == 8 ||   // backspace
            event.keyCode == 37 ||  // left key
            event.keyCode == 38 ||  // up key
            event.keyCode == 39 ||  // right key
            event.keyCode == 40 ||  // down key
            event.keyCode == 46     // delete key
           ) {
                   return;
        }

        var value;
        var maxLength = 0;

        switch (cfGetElementType(oElement)) {
                case "TEXT" :
                        value = oElement.value;
                        maxLength = oElement.maxLength;

                        if (value.length + 1 == maxLength) {
                                oElement.value = oElement.value + String.fromCharCode(event.keyCode);
                                event.returnValue = false;
                                oNextElement.focus();
                        }

                        break;
                case "GE" :
                        value = oElement.Text;

                        if (cfIsNull(oElement.Format)) {
                                maxLength = oElement.MaxLength;
                        } else {
                                for (var i = 0; i < oElement.Format.length; i++) {
                                        if (cfIsIn(oElement.Format.charAt(i), ['#', 'A', 'Z', '0', '9', 'Y', 'M', 'D'])) {
                                                maxLength++;
                                        }
                                }
                        }

                        if (value.length + 1 == maxLength) {
                                oElement.Text = oElement.Text + String.fromCharCode(event.keyCode);
                                event.returnValue = false;
                                oNextElement.focus();
                        }

                        break;
                default :
                        return;
        }
}
*/

/**
 * @type   : function
 * @access : public
 * @desc   : �ʵ忡 �ִ� �ڸ����� �Է��� �� ������ �ٸ� �ʵ�� ��Ŀ���� �ڵ����� �̵��ȴ�.<br>
 *           html�� <Input type="text"> �� ���콺 EMEdit���� ��밡���ϴ�. <Input type="text"> �� ���
 *           maxLength �Ӽ��� �����Ǿ� �־�� �ϸ� EMEdit�� ��� MaxLength�� Format �Ӽ��� �ϳ��� �ݵ��
 *           ����Ǿ�� �Ѵ�.<br>
 *           byte length(�ѱ�)�� �������� �ʴ´�.<br>
 *           ������Ʈ ����� onkeydown �̺�Ʈ�� ������ ���� ����� �־�߸� �Ѵ�.
 * <pre>
 *     �ֹι�ȣ
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required ���� �Է��ʵ�
 * @param  : oNextElement required �ڵ����� ��Ŀ���� �̵��� �ʵ�
 */
/*
function cfAutoFocusBefore(oElement, oBeforeElement) {
        if (event.keyCode != 8) {
                   return;
        }

        var value;

        switch (cfGetElementType(oElement)) {
                case "TEXT" :
                        value = oElement.value;
                        break;
                case "GE" :
                        value = oElement.Text;
                        break;
                default :
                        return;
        }

        if (value.length == 1) {
                oElement.value = "";
                event.returnValue = false;
                oBeforeElement.focus();
        }
}
*/




/**
 * @type   : function
 * @access : public
 * @desc   : ����޼����� ���ǵ� �޼����� confirm box�� ������ �� �����Ѵ�. cfGetMSG ����.
 * @sig    : msgId[, paramArray]
 * @param  : msgId      required common.js�� ���� �޼��� ������ ����� �޼��� ID
 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ��Ʈ�� Array. (Array�� index��
 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.)
 * @return : ġȯ�� �޼��� ��Ʈ��

 */
function cfConfirmMSG(msgId, paramArray) {
        return confirm(new coMessage().getMsg(msgId, paramArray));
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���콺�� �����ͼ� ������Ʈ ���� �����͸� �����Ѵ�. �������� �Ǵ� �����ͼ��� ������ �����ʹ� ��� �����ȴ�.
 *           features �Ķ���Ϳ��� copyHeader�� yes�� �� ��� DataSet�� �÷��������� ����ȴ�.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, "copyHeader=no");
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet[, features]
 * @param  : oOriginDataSet required ���� DataSet
 * @param  : oTargetDataSet required ����Ǿ��� DataSet
 * @param  : features       optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.
 * <pre>
 *     copyHeader : Header�� �������� ����. (default:yes)
 *     rowFrom    : ������ row�� ���� index. (default:1)
 *     rowCnt     : ������ row�� ���� index. (default:DataSet.CountRow �� ��)
 *     ��뿹) "copyHeader=yes,rowFrom=1,rowCnt=2"  -> 1�� row ���� 3�� row���� Header�� �Բ� ������.
 * </pre>
 */
function cfCopyDataSet(oOriginDataSet, oTargetDataSet, features) {
        var featureNames  = ["copyHeader", "rowFrom", "rowCnt"];
        var featureValues = [true, 1, oOriginDataSet.CountRow];
        var featureTypes  = ["boolean", "number", "number"];

        if (features != null) {
                cfParseFeature(features, featureNames, featureValues, featureTypes);
        }

        var copyHeader  = featureValues[0];
        var rowFrom     = featureValues[1];
        var rowCnt      = featureValues[2];

        if (copyHeader == true) {
                cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet);
        }

        oTargetDataSet.ClearData();
        if ( oOriginDataSet.CountRow > 0 ) {
                var temp = oTargetDataSet.dataid;  // importdata�� �� �� DataSet�� ������ dataid �Ӽ����� �������� ���� ����.
                oTargetDataSet.ImportData(oOriginDataSet.ExportData(rowFrom, rowCnt, true));
                oTargetDataSet.dataid = temp;
                oTargetDataSet.ResetStatus();
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���콺�� �����ͼ� ������Ʈ ���� �÷� ��� ������ �����Ѵ�.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS);
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet
 * @param  : oOriginDataSet required ���� DataSet
 * @param  : oTargetDataSet required ����Ǿ��� DataSet
 */
function cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet) {
        var DsHeader = "";
        var colId   = "";
        var colType = "";
        var colProp = "";
        var colSize = ""

        for (var i = 1; i <= oOriginDataSet.CountColumn; i++) {
                 colId   = oOriginDataSet.ColumnID(i);	     //column id
                colIndex= oOriginDataSet.ColumnIndex(colId);  //column id�� �ش��ϴ� index��
                colSize = oOriginDataSet.ColumnSize(colIndex);//column size

                /* column�� type ���� �ڵ�

                        Type  Description
                        -----------------
                         1    String
                         2    Integer
                         3    Decimal
                         4    Date
                         5    URL
                */

                //column type����
                switch (oOriginDataSet.ColumnType(colIndex)){
                     case 1 :
                              colType = 'String';
                              break;
                     case 2 :
                              colType = 'Integer';
                              break;
                     case 3 :
                              colType = 'Decimal';
                              break;
                     case 4 :
                              colType = 'Date';
                              break;
                     case 5 :
                              colType = 'URL';
                              break;

                     default :
                              colType = "";
                              break;
                }

                /* column�� property ����
                        0 : Normal (Key = No)
                        1 : Constant
                        2 : Key (Normal, Sequence)
                        3 : Sequence (Key = No) // ���� �ǹ̾���.
                */
                switch (oOriginDataSet.ColumnProp(i)) {
                     case 0 :
                              colProp = "NORMAL";
                              break;
                     case 1 :
                              colProp = "CONSTANT";
                              break;
                     case 2 :
                              colProp = "KEYVALUE";
                              break;
                     default :
                              colProp = "";
                              break;
                }

                //column id,column type,column size, column property
                DsHeader = DsHeader + colId + ":" + colType + "(" + colSize + ")" + ":" + colProp + ",";
        }

        DsHeader = DsHeader.substr(0, DsHeader.length - 1);
        oTargetDataSet.SetDataHeader(DsHeader);
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid�� ���õ� Row���� �����Ѵ�.
 * <pre>
 *     cfDeleteGridRow(oDomRegiRecevGDS);
 * </pre>
 * ���� ������ oDomRegiRecevGDS ��� id�� ���� Grid�� ���� ���õ� Row���� ��� �����ȴ�.
 * @sig    : dataSet
 * @param  : dataSet required DataSet ������Ʈ�� id
 */
function cfDeleteGridRows(dataSet) {
        for (var i = dataSet.CountRow; i > 0; i--) {
                if (dataSet.RowMark(i)) {
                        dataSet.DeleteRow(i);
                }
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� �տ� ������ �ڸ�����ŭ zero character �� �����Ѵ�.
 * <pre>
 *     cfDigitalNumber(5, 123);
 * </pre>
 * ���Ͱ��� ������� ��� "00123" �̶�� String�� �����Ѵ�.
 * @sig    : length, number
 * @param  : length required ���ڸ� ǥ���ϴ� ����
 * @param  : number required ��ȯ�� ����
 * @return : ��ȯ�� ��Ʈ��
 */
function cfDigitalNumber(length, number) {
        var numStr = number+ "";
        var zeroChars = "";

        for (var i = 0; i < (length - numStr.length); i++) {
                zeroChars = zeroChars + "0";
        }

        return (zeroChars + numStr);
}

/**
 * @type   : function
 * @access : public
 * @desc   : element�� disable ��Ų��.
 * <pre>
 *     cfDisable(oRegistBtn);
 * </pre>
 * @sig    : oElement
 * @param  : oElement required disable �ϰ��� �ϴ� element
 */
function cfDisable(oElement) {
        switch (cfGetElementType(oElement)) {
                case "BUTTON" :
                case "CHECKBOX" :
                case "FILE" :
                case "PASSWORD" :
                case "RADIO" :
                case "IMAGE" :
                case "RESET" :
                case "SUBMIT" :
                case "TEXT" :
                        oElement.disabled = true;
                        break;

                case "GE" :
                        oElement.Enable = false;

                        // EMEdit �� �ʼ��׸��� ��� �ʼ��׸� ���� color�� �����Ų��.
//			if (oElement.className == "txtEmeComnReq") {
//				oElement.DisabledBackColor = "#FFFFE9";
//			}

                        break;

                case "GCC" :
                case "GIF" :
                case "GRDO" :
                case "GTA" :
                case "GG"  :
                        oElement.Enable = false;
                        break;

                default :
                        break;
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : element�� enable ��Ų��.
 * <pre>
 *     cfEnable(oRegistBtn);
 * </pre>
 * @sig    : oElement
 * @param  : oElement required enable �ϰ��� �ϴ� element
 */
function cfEnable(oElement) {
        switch (cfGetElementType(oElement)) {
                case "BUTTON" :
                case "CHECKBOX" :
                case "FILE" :
                case "PASSWORD" :
                case "RADIO" :
                case "RESET" :
                case "SUBMIT" :
                case "IMAGE" :                
                case "TEXT" :
                        oElement.disabled = false;
                        break;

                case "GE" :
                        oElement.Enable = true;
                        break;

                case "GCC" :
                case "GIF" :
                case "GRDO" :
                case "GTA" :
                case "GG"  :
                        oElement.Enable = true;
                        break;

                default :
                        break;
        }
}


/**
 * @type   : function
 * @access : public
 * @desc   : Grid�� DataId�� ������ DataSet�� �����Ͱ� 0���� ��쿡�� "�����Ͱ� �����ϴ�." ��� �޽����� Grid�� �����ش�.
 *           ���� ȣ���ϵ��� ��������� ���� DataSet�� OnLoadCompleted �̺�Ʈ�� Transaction�� OnSuccess �̺�Ʈ���� ȣ���Ѵ�.
 * <pre>
 *     &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;
 *         cfFillGridHeader(oDelivRsltGGHeader, oDelivRsltGDS, "kpl.spl.common.svl.SplSVL", "kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD", "pageLinkCnt=3");
 *         <b>cfFillGridNoDataMsg(oDelivRsltGG, "gridColLineCnt=2");</b>
 *     &lt;/script&gt;
 * </pre>
 * @sig    : oGG[, features]
 * @param  : oGG      required Grid ������Ʈ
 * @param  : features optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.
 * <pre>
 *     gridColLineCnt : Grid�� �÷� ���� ��. �Ϲ������δ� �� �������� Grid�� Ÿ��Ʋ�� ���� 2�� �� ���̴�. �⺻���� 1�̴�.
 * </pre>
 */
function cfFillGridNoDataMsg(oGG, features) {
        var oGDS = document.all(oGG.DataId);

        var featureNames  = ["gridColLineCnt"];
        var featureValues = [1];
        var featureTypes  = ["number"];

        if (features != null) {
                cfParseFeature(features, featureNames, featureValues, featureTypes);
        }

        var gridColLineCnt = featureValues[0];
        var oNoDataMsg = document.createElement("<OBJECT>");
        var colHeight = 20;
        var msgWidth = 105;
        var marginTop = 10;

        oNoDataMsg.classid           = "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F";
        oNoDataMsg.width             = msgWidth;
        oNoDataMsg.Numeric           = false;
        oNoDataMsg.Border            = false;
        oNoDataMsg.Enable            = false;
        oNoDataMsg.DisabledBackColor = "#FFFFFF";
        oNoDataMsg.Text              = "�����Ͱ� �����ϴ�.";
        oNoDataMsg.style.fontSize    = "9pt";
        oNoDataMsg.style.position    = "absolute";
        oNoDataMsg.style.left        = (Number(cfIsNull(oGG.width) ? oGG.style.width.substring(0, oGG.style.width.length - 2) : oGG.width) - 105) / 2;
        oNoDataMsg.style.top         = Number(oGG.style.top.substring(0, oGG.style.top.length - 2)) +
                                       gridColLineCnt * colHeight + marginTop;

        oGG.insertAdjacentElement("beforeBegin", oNoDataMsg);

        if (oGDS.CountRow == 0) {
                oGG.style.zIndex = 1;
                oNoDataMsg.style.zIndex = 2;
        } else {
                oGG.style.zIndex = 2;
                oNoDataMsg.style.zIndex = 1;
        }
}



/**
 * @type   : function
 * @access : public
 * @desc   : �������� ����ð��� �о�ͼ� �ڹٽ�ũ��Ʈ�� Date ������Ʈ�� ��ȯ�Ѵ�.
 *           Date ������Ʈ�κ��� ��Ʈ�� ���·� ��¥ Ȥ�� �ð��� �������� Date.format() �޼ҵ带 ������ ��.
 * @return : Date ������Ʈ
 */
function cfGetCurrentDate() {
        var dataSet;
        var dateString;

        if (document.all("coCurrentDateGDS") == null) {
                dataSet = document.createElement("<OBJECT>");
                dataSet.classid = "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49";
                dataSet.id = "coCurrentDateGDS";
                dataSet.SyncLoad = "true";
                dataSet.DataId = "/servlet/kpl.common.svl.GauceChannelSVL?cmd=kpl.common.util.cmd.CurrentDateCMD";

                // </head> �±� ������ DataSet ����
                for (var i = 0; i < document.all.length; i++) {
                        if (document.all[i].tagName == "HEAD") {
                                document.all[i].insertAdjacentElement("beforeEnd", dataSet);
                                break;
                        }
                }
        } else {
                dataSet = document.all("coCurrentDateGDS");
        }

        dataSet.Reset();
        dateString = dataSet.NameValue(1, "dateString");
        dataSet.clearData();

        if (cfIsNull(dateString)) {
                return null;
        }

        return new Date(dateString.substr(0, 4),
                        Number(dateString.substr(4, 2)) -1,
                        dateString.substr(6, 2),
                        dateString.substr(8, 2),
                        dateString.substr(10, 2),
                        dateString.substr(12, 2)
                       )
}

/**
 * @type   : function
 * @access : public
 * @desc   : Element�� type�� �˷��ش�. ���ϵǴ� element type string�� ������ ����.
 * <pre>
 *     BUTTON   : html button input tag
 *     CHECKBOX : html checkbox input tag
 *     FILE     : html file input tag
 *     HIDDEN   : html hidden input tag
 *     IMAGE    : html image input tag
 *     PASSWORD : html password input tag
 *     RADIO    : html radio input tag
 *     RESET    : html reset input tag
 *     SUBMIT   : html submit input tag
 *     TEXT     : html text input tag
 *     SELECT   : html select tag
 *     TEXTAREA : html textarea tag
 *     GCC      : ���콺 CodeCombe
 *     GRDO     : ���콺 Radio
 *     GTA      : ���콺 TextArea
 *     GIF      : ���콺 InputFile
 *     GE       : ���콺 EMEdit
 *     GDS      : ���콺 DataSet
 *     GTR      : ���콺 Transaction
 *     GCHT     : ���콺 Chart
 *     GID      : ���콺 ImageData
 *     GG       : ���콺 Grid
 *     GTB      : ���콺 Tab
 *     GTV      : ���콺 TreeView
 *     GM       : ���콺 Menu
 *     GB       : ���콺 Bind
 *     GRPT     : ���콺 Report
 *     GS       : ���콺 Scale
 *     null     : ��Ÿ
 * </pre>
 * @sig    : oElement
 * @param  : oElement required element
 * @return : element�� type�� ǥ���ϴ� string
 */
function cfGetElementType(oElement) {
        if (oElement == null) {
                return null;
        }

        switch (oElement.tagName) {
                case "INPUT":
                        switch (oElement.type) {
                                case "button" :
                                        return "BUTTON";
                                case "checkbox" :
                                        return "CHECKBOX";
                                case "file" :
                                        return "FILE";
                                case "hidden" :
                                        return "HIDDEN";
                                case "image" :
                                        return "IMAGE";
                                case "password" :
                                        return "PASSWORD";
                                case "radio" :
                                        return "RADIO";
                                case "reset" :
                                        return "RESET";
                                case "submit" :
                                        return "SUBMIT";
                                case "text" :
                                        return "TEXT";
                                default :
                                        return null;
                        }
                case "SELECT":
                        return "SELECT"
                case "TEXTAREA":
                        return "TEXTAREA"
                case "OBJECT":
                            switch (oElement.attributes.classid.nodeValue.toUpperCase()) {
                                case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
                                        return "GCC"
                                case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component
                                        return "GRDO"
                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component
                                        return "GTA"
                                case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component
                                        return "GIF"
                                case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component
                                        return "GE"
                                case "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49": // DataSet Component
                                        return "GDS"
                                case "CLSID:0A2233AD-E771-11D2-973D-00104B15E56F": // Transaction Component
                                        return "GTR"
                                case "CLSID:B5F6727A-DD38-11D2-973D-00104B15E56F": // Chart Component
                                        return "GCHT"
                                case "CLSID:BCB3A52D-F8E7-11D3-973E-0060979E2A03": // ImageData Component
                                        return "GID"
                                case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // Grid Component
                                        return "GG"
                                case "CLSID:ED382953-E907-11D3-B694-006097AD7252": // Tab Component
                                        return "GTab"
                                case "CLSID:4401B994-DD33-11D2-B539-006097ADB678": // TreeView Component
                                        return "GTree"
                                case "CLSID:7A54CBF0-2CB4-11D4-973E-0060979E2A03": // Menu Component
                                        return "GM"
                                case "CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49": // Bind Component
                                        return "GB"
                                case "CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F": // Report Component
                                        return "GRPT"
                                case "CLSID:8D6D8F1E-2567-4916-8036-50D3F7F01563": // Scale Component
                                        return "GS"
                default:
                        return null;
                        }
                default :
                        return null;
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : ��Ʈ���� �ڸ����� Byte ������ ȯ���Ͽ� �˷��ش�. ����, ���ڴ� 1Byte�̰� �ѱ��� 2Byte�̴�.(��/�� �߿� �ϳ��� �ִ� ���ڵ� 2Byte�̴�.)
 * @sig    : value
 * @param  : value required ��Ʈ��
 * @return : ��Ʈ���� ����
  */
function cfGetByteLength(value){
        var byteLength = 0;

        if (cfIsNull(value)) {
                return 0;
        }

        var c;

        for(var i = 0; i < value.length; i++) {
                c = escape(value.charAt(i));

                if (c.length == 1) {
                        byteLength ++;
                } else if (c.indexOf("%u") != -1)  {
                        byteLength += 2;
                } else if (c.indexOf("%") != -1)  {
                        byteLength += c.length/3;
                }
        }

        return byteLength;
}

/**
 * @type   : function
 * @access : public
 * @desc   : ����޼����� ���ǵ� �޼����� �����Ѵ�.
 * <pre>
 * // ���� �޼��� ����
 * var MSG_NO_CHANGED        = "����� ������ �����ϴ�.";
 * var MSG_SUCCESS_LOGIN     = "@�� �ȳ��ϼ���?";
 * ...
 * var message1 = cfGetMSG(MSG_NO_CHANGED);
 * var message2 = cfGetMSG(MSG_SUCCESS_LOGIN, ["ȫ�浿"]);
 * </pre>
 * ���� ������ message2 �� ���� "ȫ�浿�� �ȳ��ϼ���?" �� �ȴ�.
 * @sig    : msgId[, paramArray]
 * @param  : msgId      required common.js�� ���� �޼��� ������ ����� �޼��� ID
 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ������ Array. Array�� index��
 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�. ġȯ�� �����ʹ� [] ���̿� �޸��� �����ڷ� �Ͽ� ����ϸ� Array �� �νĵȴ�.
 * @return : ġȯ�� �޼��� ��Ʈ��
 */
function cfGetMSG(msgId, paramArray) {
        return new coMessage().getMsg(msgId, paramArray);
}


/**
 * @type   : function
 * @access : private
 * @desc   : Object�� �ʱ�ȭ�Ѵ�.
 * @sig    : obj[, iniVal]
 * @param  : parentObj required �ʱ�ȭ�� ��� ������Ʈ
 * @param  : iniVal    optional �ʱⰪ
 */
function cfIniObject(obj, iniVal) {

        if (typeof(iniVal) == "undefined") {
                iniVal = "";
        }

        switch (obj.tagName) {
                case "DIV":

                case "TABLE":

                case "FIELDSET":
                        cfReset(obj, iniVal);
                        break;

                case "INPUT":
                        switch (obj.type) {
                                case "checkbox":
                                        if (typeof(iniVal) == "undefined")	{
                                                obj.checked = 0;
                                        } else {
                                                obj.checked = iniVal;
                                        }

                                        break;

                                case "button" :
                                        break;

                                case "image" :
                                        break;

                                default :
                                        obj.value = iniVal;
                                        break;
                        }

                        break;

                case "SELECT":
                case "TEXTAREA":
                        obj.value = iniVal;
                        break;

                case "OBJECT":
                        switch (obj.attributes.classid.nodeValue.toUpperCase()) {
                                case "CLSID:5FBAE1CD-A276-11D3-AF84-00C026DC3D95": // MEdit Component
                                        obj.Text = iniVal;

                                case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
                                        objGDS = eval(obj.ComboDataID);

                                        obj.Index = 0;

                                        for ( i = 1;i <= objGDS.CountRow; i++) {
                                                if (objGDS.NameValue(i, obj.CodeCColumn) == iniVal) {
                                                        obj.Index = i - 1;
                                                        break;
                                                }
                                        }

                    break;

                                case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component
                                case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component
                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component
                                        obj.Text = iniVal;
                                        break;

                                case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component
                    break;

                default :
                        break;
                        }
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : ����ڰ� ���� key�� enter key ���� ���θ� �˷��ش�.
 * <pre>
 *     function fncOnKeyPress() {
 *         ...
 *         if (cfIsEnterKey()) {
 *             ...
 *         }
 *     }
 *     ...
 *     &lt;input type="text" onkeypress="fncOnKeyPress()"&gt;
 * </pre>
 * @return : enter key ����
 */
function cfIsEnterKey() {
        if (event.keyCode == 13) {
                return true;
        }

        return false;
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���� null �̰ų� white space ���ڷθ� �̷���� ��� true�� �����Ѵ�.
 * <pre>
 *     cfIsNull("  ");
 * </pre>
 * ���Ͱ��� ������� ��� true�� �����Ѵ�.
 * @sig    : value
 * @param  : value required �Է°�
 * @return : boolean. null(Ȥ�� white space) ����
 */
function cfIsNull(value) {
        if (value == null ||
            (typeof(value) == "string" && value.trim() == "")
           ) {
                return true;
        }

        return false;
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���� ������ �׷쳻�� �����ϴ����� �˷��ش�.
 * <pre>
 *     cfIsIn(3, [1, 2, 3]);                     // -> true
 *     cfIsIn(3, [4, 5, 6]);                     // -> false
 *     cfIsIn('F', ['A', 'B', 'F']);             // -> true
 *     cfIsIn('F', ['A', 'B', 'C']);             // -> false
 *     cfIsIn("lim", ["lim", "kim", "park"]);    // -> true
 *     cfIsIn("lim", ["lee", "kim", "park"]);    // -> false
 * </pre>
 * @sig    : value, valueArray
 * @param  : value      required ���ϰ� ���� ��
 * @param  : valueArray required ���ϰ� ���� ���� ���� �� ����� �Ǵ� ������ ����. array Ÿ���̸� array
 *           ���� �� element�� ������ Ÿ���� value �Ķ������ Ÿ�԰� ��ġ�ؾ� �Ѵ�.
 * @return : boolean. ���� ������ �׷쳻�� �����ϴ��� ����.
 */
function cfIsIn(value, valueArray) {
        for (var i = 0; i < valueArray.length; i++) {
                if (value == valueArray[i]) {
                        return true;
                }
        }

        return false;
}



/**
 * @type   : function
 * @access : public
 * @desc   : window.open���� ����â�� ��� �� ����â�� ��ġ�� �����ϰ� ������ �� �ִ�.
 * @sig    : width, height, position, [sURL] [, sName] [, sFeatures] [, bReplace]
 * @param  : width - ����â�� ����
 * @param  : height - ����â�� ����
 * @param  : position  - ����â�� ��ġ (default : 5) <br><br>
 * <table border='1'>
 *     <tr>
 *         <td>1</td>
 *         <td>2</td>
 *         <td>3</td>
 *     </tr>
 *     <tr>
 *         <td>4</td>
 *         <td>5</td>
 *         <td>6</td>
 *     </tr>
 *     <tr>
 *         <td>7</td>
 *         <td>8</td>
 *         <td>9</td>
 *     </tr>
 * </table>
 * @param  : sURL      required window.open�� sURL �Ķ���Ϳ� ����
 * @param  : sName     required window.open�� sName �Ķ���Ϳ� ����
 * @param  : sFeatures required window.open�� sFeatures �Ķ���Ϳ� ����
 * @param  : bReplace  required window.open�� bReplace �Ķ���Ϳ� ����
 */
function cfOpen(width, height, position, sURL, sName, sFeatures, bReplace) {
        var left = 0;
        var top = 0;

/*
        var featureNames  = ["status", "menubar", "toolbar"];
        var featureValues = ["no", "no", "no"];
        var featureTypes  = ["boolean", "boolean", "boolean"];

        if (sFeatures != null) {
                cfParseFeature(sFeatures, featureNames, featureValues, featureTypes);
        }

        var status = featureValues[0];
        var menubar = featureValues[1];
        var toolbar = featureValues[2];
*/
        if (width != null && height != null) {
                width = width + 10; // window�� �¿� border 5px�� ����.
                height = height + 29; // titlebar�� �⺻���� ����.
/*
                if (status) {
                        height = height + 20;
                }

                if (menubar) {
                        height = height + 48;
                }

                if (toolbar) {
                        height = height + 27;
                }
*/
                switch (position) {
                        case 1 :
                                left = 0;
                                top = 0;
                                break;

                        case 2 :
                                left = (screen.availWidth - width) / 2;
                                top = 0;
                                break;

                        case 3 :
                                left = screen.availWidth - width;alert(width);
                                top = 0;
                                break;

                        case 4 :
                                left = 0;
                                top = (screen.availHeight - height) / 2;
                                break;

                        case 5 :
                                left = (screen.availWidth - width) / 2;
                                top = (screen.availHeight - height) / 2;
                                break;

                        case 6 :
                                left = screen.availWidth - width;
                                top = (screen.availHeight - height) / 2;
                                break;

                        case 7 :
                                left = 0;
                                top = screen.availHeight - height;
                                break;

                        case 8 :
                                left = (screen.availWidth - width) / 2;
                                top = screen.availHeight - height;
                                break;

                        case 9 :
                                left = screen.availWidth - width;
                                top = screen.availHeight - height;
                                break;

                        default :
                                left = (screen.availWidth - width) / 2;
                                top = (screen.availHeight - height) / 2;
                                break;
                }

                if (cfIsNull(sFeatures)) {
                        sFeatures = sFeatures + "left=" + left + ",top=" + top;
                } else {
                        sFeatures = sFeatures + ",left=" + left + ",top=" + top;
                }
        }

        window.open(sURL, sName, sFeatures, bReplace);
}

/**
 * @type   : function
 * @access : private
 * @desc   : features ��Ʈ���� �Ľ��Ͽ� array�� �����ϴ� ���� �Լ�
 * @sig    : features, fNameArray, fValueArray, fTypeArray
 * @param  : features    required features�� ǥ���� ��Ʈ��
 * @param  : fNameArray  required �����ؾ� �� feature�� �̸��� ���� array
 * @param  : fValueArray required �����ؾ� �� feature�� �⺻���� ���� array
 * @param  : fTypeArray  required �����ؾ� �� feature�� ������Ÿ�Կ� ���� array

 */
function cfParseFeature(features, fNameArray, fValueArray, fTypeArray) {
        if (features == null) {
                return;
        }

        var featureArray = features.split(",");
        var featurePair;

        for (var i = 0; i < featureArray.length; i++) {
                featurePair = featureArray[i].trim().split("=");

                for (var j = 0; j < fNameArray.length; j++) {
                        if (featurePair[0] == fNameArray[j]) {
                                switch (fTypeArray[j]) {
                                        case "string" :
                                                fValueArray[j] = featurePair[1];
                                                break;
                                        case "number" :
                                                fValueArray[j] = Number(featurePair[1]);
                                                break;
                                        case "boolean" :
                                                if (featurePair[1].toUpperCase() == "YES" || featurePair[1].toUpperCase() == "TRUE" || featurePair[1] == "1") {
                                                        fValueArray[j] = true;
                                                } else {
                                                        fValueArray[j] = false;
                                                }
                                                break;
                                }
                        }
                }
        }
}



/**
 * @type   : function
 * @access : public
 * @desc   : ����޼����� ���ǵ� �޼����� prompt box �� �����ش�. ���� �н����带 �Է¹޴� prompt box��
 *           ���鼭 ����޼����� ���ǵ� �޼����� �����ְ� �ʹٸ� ������ ���� �ϸ� �ȴ�.
 * <pre>
 *     // ����޼��� ����
 *     var MSG_INPUT_PASSWORD = "@��, �н����带 �Է��Ͻʽÿ�.";
 *     ...
 *     cfPromptMsg(MSG_INPUT_PASSWORD, ["ȫ�浿"], "�Է��ϼ���.");
 * </pre>
 * @sig    : msgId[, paramArray[, defaultVal]]
 * @param  : msgId      required common.js�� ���� �޼��� ������ ����� �޼��� ID
 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ��Ʈ�� Array. (Array�� index��
 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.)
 * @param  : defaultVal optional prompt box �� �Է��ʵ忡 ������ �⺻��.
 * @return : �Է¹��� String Ȥ�� Integer Ÿ���� �н����� ������
 */
function cfPromptMsg(msgId, paramArray, defaultVal) {
        return prompt(new coMessage().getMsg(msgId, paramArray), defaultVal);
}

/**
 * @type   : function
 * @access : public
 * @desc   : parent object (Div, Table, FieldSet �±�)�� ���� ��� child object�� ���� �ʱ�ȭ�Ѵ�.
 * @sig    : parentObj[, iniVal]
 * @param  : parentObj required �ʱ�ȭ�� �θ� ������Ʈ
 * @param  : iniVal    optional �ʱⰪ
 */
function cfReset(parentObj, iniVal) {
        if (typeof(iniVal) == "undefined") {
                iniVal = "";
        }

        switch (parentObj.tagName) {
                case "TABLE":
                        for (i in parentObj.all) {
                                cfIniObject(parentObj.all[i], iniVal);
                        }

                        break;

                case "DIV":
                        for (i in parentObj.children) {
                                cfIniObject(parentObj.children[i], iniVal);
                        }

                        break;

                case "FIELDSET":
                        for (i in parentObj.children) {
                                cfIniObject(parentObj.children[i], iniVal);
                        }

                        break;

                default:
                        cfIniObject(parentObj, iniVal);
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid�� ��ü�����Ѵ�.
 * <pre>
 *     cfSelectAllGridRows(oDomRegiRecevGDS, oDomRegiRecevGG);
 * </pre>
 * ���� ������ oDomRegiRecevGDS ��� id�� ���� DataSet�� �����͸� �����ִ�
 * oDomRegiRecevGG ��� id�� ���� Grid �󿡼� ��� Row���� �����Ѵ�.
 * @sig    : dataSet, grid
 * @param  : dataSet required DataSet ������Ʈ�� id
 * @param  : grid    required Grid ������Ʈ
 */
function cfSelectAllGridRows(oDataSet, oGrid) {
        oDataSet.MarkAll();
        oGrid.Focus();
}

/**
 * @type   : function
 * @access : public
 * @desc   : �������� ����ϴ� �޷�â�� ����.
 * <pre>
 * &lt;object id="calendarText" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="100"&gt;
 *     &lt;param name="Alignment" value="1"&gt;
 *     &lt;param name="format" value="YYYY-MM-DD"&gt;
 * &lt;/object&gt;
 *
 * &lt;input type="button" value="�޷¶���" onclick="cfShowCalendar(calendarText)"&gt;
 * </pre>
 * @sig    : item[, month[, year[, format]]]
 * @param  : item   required �޷�â���κ��� ���õ� ��¥�� Text������ ������ EMEdit ������Ʈ�� id
 * @param  : month  optional ���� ��Ÿ���� 0~11 ������ ����.
 * @param  : year   optional �⵵�� ��Ÿ���� 4�ڸ� ����
 * @param  : format optional ��¥�� ǥ���ϴ� ������ ��Ÿ���� ���� ��Ʈ��. item ������Ʈ�� Text������
 *                    ���õǴ� ���� format�� ��Ÿ����. �⺻���� YYYYMMDD �̴�.
 *                    Date ������Ʈ�� format �޼ҵ��� �Ķ���Ϳ� ������ �����Ƿ� ������ ��.
 */
function cfShowCalendar(item, month, year, format) {
        var oArgObj = new Object();
        var url     = GLB_URL_COMMON_PAGE + "calendar.html";

        oArgObj.item   = item;
        oArgObj.month  = month;
        oArgObj.year   = year;
        oArgObj.format = format;

        result = window.showModalDialog(url, oArgObj, "dialogHeight:244px; dialogWidth:190px; " +
                                             "resizable=no; help:no; status:no; center=true; ");
        return result;
}

/**
 * @type   : function
 * @access : public
 * @desc   : �������� ����ϴ� �����޼��� â�� ����.
 * @sig    : obj
 * @param  : obj required ������ �� ���콺 ������Ʈ(DataSet or Transaction ������Ʈ�� �ϳ�)
 */
function cfShowError(obj) {
        var errObj = new Object();
        errObj.errCd = obj.ErrorCode;
        errObj.errMsg = obj.ErrorMsg;

        if (obj.ErrorMsg.indexOf("[BizException]") != -1) {
           alert(obj.ErrorMsg.substr(obj.ErrorMsg.indexOf("[BizException]") + 14));
        } else if ( (obj.ErrorMsg.indexOf("[Exception]") != -1) ||
                    (obj.ErrorMsg.indexOf("[SysException]") != -1)
                  ) {
                window.showModalDialog(GLB_URL_COMMON_PAGE + "error.html", errObj, "dialogWidth:660px; dialogHeight:500px; help:no; status:no")
        } else {
                window.showModalDialog(GLB_URL_COMMON_PAGE + "error.html", errObj, "dialogWidth:660px; dialogHeight:500px; help:no; status:no")
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid�� �÷����� Ŭ������ �� �����͸� Sorting ���ִ� �Լ��̴�. Grid�� id�� oDelivRsltGG �̰�
 *           DataSet�� id�� oDelivRsltGDS ��� ������ ���� Grid�� OnClick �̺�Ʈ ��ũ��Ʈ�� ������ָ� �ȴ�.
 * <pre>
 * &lt;script language="javascript" for="oDelivRsltGG" event="OnClick(row, colid)"&gt;
 *     if (row == 0) {           // Grid �󿡼� �÷��� ������ Ŭ������ ���
 *         cfSortGrid(oDelivRsltGDS, colid);
 *     }
 * &lt;/script&gt;
 * </pre>
 * @sig    : oGDS, colid
 * @param  : oGDS  required Grid�� �����ͷ� ���Ǵ� DataSet ������Ʈ�� id
 * @param  : colid required Grid�� OnClick �̺�Ʈ �Լ��� colid �Ķ����
 */
function cfSortGrid(oGDS, colid) {
        oGDS.SortExpr.substring(0,1) == "+" ?
                oGDS.SortExpr = "-" + colid:
                oGDS.SortExpr = "+" + colid;
        oGDS.Sort();
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���콺 Grid�� Style�� ������ Style�� �ٲپ��ش�.
 * <pre>
 *     cfStyleGrid(oDelivRsltGG, "comn", features);
 * </pre>
 * @sig    : oGrid, styleName[, features]
 * @param  : oGrid     required Grid ������Ʈ
 * @param  : styleName required Grid�� style name. [RL_COMN : �������㰡, RF_COMN : ���Ļ���, RC_COMN : ��������]
 * @param  : features  optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.
 * <pre>
 *     indWidth : Grid�� indWidth �Ӽ� ����.
 *     ��뿹) "indWidth=12"
 * </pre>
 */
function cfStyleGrid(oGrid, styleName, features) {
        var rowHeight;
        var titleHeight;
        var bgColor;
        var fontSize;
        var fontFamily;
        var LineColor;

        var sumColor;
        var sumBgColor;
        var subColor;
        var subBgColor;
        var subpressBgColor;

        var color;
        var headAlign;
        var headColor;
        var headBgColor;

        // <C> �÷� �Ӽ�
        var CColor;
        var CHeadColor;
        var CHeadBgColor;

        // <FC> �÷� �Ӽ�
        var FCColor;
        var FCBgColor;
        var FCHeadColor;
        var FCHeadBgColor;

        // <G> �÷� �Ӽ�
        var GHeadColor;
        var GHeadBgColor;

        // <FG> �÷� �Ӽ�
        var FGHeadColor;
        var FGHeadBgColor;

        // <X> �÷� �Ӽ�
        var XHeadColor;
        var XHeadBgColor;

        // <FX> �÷� �Ӽ�
        var FXHeadColor;
        var FXHeadBgColor;

        var featureNames  = ["indWidth"];
        var featureValues = [null];
        var featureTypes  = ["number"];

        if (features != null) {
                cfParseFeature(features, featureNames, featureValues, featureTypes);
        }

        var indWidth = featureValues[0];

        // Grid Style �� ����
        switch (styleName) {
                case "comn":
                        // Grid �Ӽ�
                        titleHeight      = 20;
                        rowHeight        = 20;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "����";

                        // �÷� ���� �Ӽ�
                        sumColor         = "#78618D";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "464646";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // �÷��� �Ӽ�
                        CColor           = "#454648";
                        CBgColor         = "#FFFFFF";
                        CHeadColor       = "#1E3460";
                        CHeadBgColor     = "#DAE7F9";

                        FCColor          = "#454648";
                        FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#EDEDED',1,'#FFFFFF')}";
                        FCHeadColor      = "#1E3460";
                        FCHeadBgColor    = "#DAE7F9"

                        GHeadColor       = "#1E3460";
                        GHeadBgColor     = "#ACBDD7";

                        FGHeadColor      = "#1E3460";
                        FGHeadBgColor    = "#DAE7F9";

                        XHeadColor       = "#1E3460";
                        XHeadBgColor     = "#DAE7F9";

                        FXHeadColor      = "#1E3460";
                        FXHeadBgColor    = "#DAE7F9";

                        break;

                case "comnOnTab":
                        // Grid �Ӽ�
                        titleHeight      = 20;
                        rowHeight        = 20;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "����";

                        // �÷� ���� �Ӽ�
                        sumColor     = "#78618D";
                        sumBgColor   = "#DCDDEF";
                        subColor     = "464646";
                        subBgColor   = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // �÷��� �Ӽ�
                        CColor           = "#454648";
                        CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#EDEDED',1,'#FFFFFF')}"; //"#FCFCFC"
                        CHeadColor       = "#1E3460";
                        CHeadBgColor     = "#DAE7F9";
                        FCColor          = "#454648";
                        FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#EDEDED',1,'#FFFFFF')}"; //"#F0F0F0"
                        FCHeadColor      = "#1E3460";
                        FCHeadBgColor    = "#C6D1E3"
                        GHeadColor       = "#1E3460";
                        GHeadBgColor     = "#ACBDD7";
                        FGHeadColor      = "#1E3460";
                        FGHeadBgColor    = "#DAE7F9";
                        XHeadColor       = "#1E3460";
                        XHeadBgColor     = "#DAE7F9";
                        FXHeadColor      = "#1E3460";
                        FXHeadBgColor    = "#DAE7F9";
                        break;

//-------------------------------------------------------------------------------------------------------------
//            �������㰡
//-------------------------------------------------------------------------------------------------------------
                case "RL_COMM":
                        // Grid �Ӽ�
                        titleHeight      = 22;
                        rowHeight        = 22;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "����";
                        LineColor       = "#999999";

                        // �÷� ���� �Ӽ�
                        sumColor         = "#3D3D3D";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "#3D3D3D";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // �÷��� �Ӽ�
                        CColor           = "#000000";
                        CBgColor         = "#FFFFFF"

                        CHeadColor       = "#000000";
                        CHeadBgColor     = "#DDEEF6";

                        FCColor          = "#000000";
                        FCBgColor        = "#DDEEF6"
                        FCHeadColor      = "#000000";
                        FCHeadBgColor    = "#DDEEF6"

                        GHeadColor       = "#000000";
                        GHeadBgColor     = "#DDEEF6";

                        FGHeadColor      = "#000000";
                        FGHeadBgColor    = "#DDEEF6";

                        XHeadColor       = "#000000";
                        XHeadBgColor     = "#DDEEF6";

                        FXHeadColor      = "#000000";
                        FXHeadBgColor    = "#DDEEF6";
                        break;
//---------------------------------------------------------------------------------------------------------------
//            �������㰡
//-------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------
//            ���Ļ���
//-------------------------------------------------------------------------------------------------------------
                case "RF_COMM":
                        // Grid �Ӽ�
                        titleHeight      = 22;
                        rowHeight        = 22;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "����";
                        LineColor       = "#A7AD9F";

                        // �÷� ���� �Ӽ�
                        sumColor         = "#000000";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "#000000";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // �÷��� �Ӽ�
                        CColor           = "#000000";
                        CBgColor         = "#FFFFFF"

                        CHeadColor       = "#000000";
                        CHeadBgColor     = "#E8F2DA";

                        FCColor          = "#000000";
                        FCBgColor        = "#E8F2DA"
                        FCHeadColor      = "#000000";
                        FCHeadBgColor    = "#E8F2DA"

                        GHeadColor       = "#000000";
                        GHeadBgColor     = "#E8F2DA";

                        FGHeadColor      = "#000000";
                        FGHeadBgColor    = "#E8F2DA";

                        XHeadColor       = "#000000";
                        XHeadBgColor     = "#E8F2DA";

                        FXHeadColor      = "#000000";
                        FXHeadBgColor    = "#E8F2DA";
                        break;
//---------------------------------------------------------------------------------------------------------------
//            ���Ļ���
//-------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------
//            ǰ������
//-------------------------------------------------------------------------------------------------------------
                case "RC_COMM":
                        // Grid �Ӽ�
                        titleHeight      = 22;
                        rowHeight        = 22;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "����";
                        LineColor       = "#999999";

                        // �÷� ���� �Ӽ�
                        sumColor         = "#000000";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "#000000";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // �÷��� �Ӽ�
                        CColor           = "#000000";
                        CBgColor         = "#FFFFFF"

                        CHeadColor       = "#000000";
                        CHeadBgColor     = "#fff6db";

                        FCColor          = "#000000";
                        FCBgColor        = "#fff6db"
                        FCHeadColor      = "#000000";
                        FCHeadBgColor    = "#fff6db"

                        GHeadColor       = "#000000";
                        GHeadBgColor     = "#fff6db";

                        FGHeadColor      = "#000000";
                        FGHeadBgColor    = "#fff6db";

                        XHeadColor       = "#000000";
                        XHeadBgColor     = "#fff6db";

                        FXHeadColor      = "#000000";
                        FXHeadBgColor    = "#fff6db";
                        break;
//---------------------------------------------------------------------------------------------------------------
//            ǰ������
//-------------------------------------------------------------------------------------------------------------


                default:
                        return;
        }

        // Grid �Ӽ� ����
        {
                oGrid.RowHeight = rowHeight;
                oGrid.TitleHeight = titleHeight;
                oGrid.IndWidth = indWidth;
                oGrid.LineColor = LineColor;
                oGrid.style.fontSize    = fontSize;
                oGrid.style.fontFamily  = fontFamily;
        }

        var tagRE = /<(fc|c|g|fg|x|fx)>/i;
        var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;

        var gFormat = oGrid.Format;
        var newGFormat = "";
        var tagMatch;
        var tagName;
        var colAttrData;
        var colAttrMatch;
        var colAttrName;
        var colAttrValue;
        var insertStr;

        // Grid Format String �� �Ľ��Ͽ� �÷����� Style �� ���õ� �Ӽ��� �����Ѵ�.
        while ((tagMatch = gFormat.match(tagRE)) != null) {
                insertStr = "";
                tagName = tagMatch[1].trim().toUpperCase();

                // ����ڰ� ������ �÷� �Ӽ��� ���� ó��
                colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

                while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
                        colAttrName = colAttrMatch[1].toUpperCase();
                        colAttrValue = colAttrMatch[2];

                        if (colAttrName == "STYLE") {
                                if (colAttrValue.toUpperCase() == "TITLE") {
                                        headColor = "#FFFFFF";
                                        headBgColor = "#8AA1C2";
                                        headAlign = "Left";
                                }

                                if (colAttrValue.toUpperCase() == "REQUIRED") {
                                        headColor = "#1E3460";
                                }
                        }

                        if (colAttrName == "SUPPRESS") {
                                CBgColor = subpressBgColor;
                                FCBgColor = subpressBgColor;
                        }

                        colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
                }



                switch (tagName) {
                        case "C" :
                                headAlign = "Center";
                                headColor = CHeadColor;
                                headBgColor= CHeadBgColor;
                                insertStr = insertStr + " BgColor=" + CBgColor +
                                            " Color=" + CColor +
                                            " SumColor=" + sumColor +
                                            " SumBgColor=" + sumBgColor +
                                            " SubColor=" + subColor +
                                            " SubBgColor=" + subBgColor;
                                break;

                        case "FC" :
                                headAlign = "Center";
                                headColor= FCHeadColor;
                                headBgColor= FCHeadBgColor;
                                insertStr = insertStr + " BgColor=" + FCBgColor +
                                            " Color=" + FCColor +
                                            " SumColor=" + sumColor +
                                            " SumBgColor=" + sumBgColor +
                                            " SubColor=" + subColor +
                                            " SubBgColor=" + subBgColor;
                                break;

                        case "G" :
                                headAlign = "Center";
                                headColor= GHeadColor;
                                headBgColor= GHeadBgColor;
                                break;

                        case "FG" :
                                headAlign = "Center";
                                headColor= FGHeadColor;
                                headBgColor= FGHeadBgColor;
                                break;

                        case "X" :
                                headAlign = "Center";
                                headColor= XHeadColor;
                                headBgColor= XHeadBgColor;
                                break;

                        case "FX" :
                                headAlign = "Center";
                                headColor= FXHeadColor;
                                headBgColor= FXHeadBgColor;
                                break;

                        default :
                                break;
                }



                // Grid�� Format �� Style ���� �Ӽ������� �����Ѵ�.
                insertStr = insertStr +
                                " HeadColor=" + headColor +
                                " HeadBgColor=" + headBgColor +
                                " HeadAlign=" + headAlign + " ";

                newGFormat = newGFormat + gFormat.substring(0, tagMatch.lastIndex) + insertStr;
                gFormat = gFormat.substr(tagMatch.lastIndex);
        }

        newGFormat = newGFormat + gFormat;
        oGrid.Format = newGFormat;
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���콺 Tab�� Style�� ������ Style�� �ٲپ��ش�.
 * <pre>
 *     cfStyleTab(oDomRegiRecevGTab, "comn");
 * </pre>
 * @sig    : oTab, styleName
 * @param  : oGrid     required Tab ������Ʈ
 * @param  : styleName required Tab�� style name. ����� "comn" �� "comnOnTab" �� �ִ�.

 */
function cfStyleTab(oTab, styleName) {
        var backColor;
        var textColor;
        var disableBackColor;
        var disableTextColor;
        var format;

        switch (styleName) {
                case "comn" :
                        backColor = "#F4F4F4";
                        textColor = "#1E56C3";
                        disableBackColor = "#CFCFCD";
                        disableTextColor = "#222866";
                        format;

                case "comnOnTab" :
                        backColor = "#F4F4F4";
                        textColor = "#1E56C3";
                        disableBackColor = "#CFCFCD";
                        disableTextColor = "#222866";
                        format;

                default :
                        break;
        }

        oTab.style.fontSize = "9pt";

        oTab.BackColor = backColor;
        oTab.TextColor = textColor;
        oTab.DisableBackColor = disableBackColor;
        oTab.DisableTextColor = disableTextColor;
}

/**
 * @type   : function
 * @access : public
 * @desc   : ȭ����� �Է°� ���õ� ������Ʈ�� ���� ��ȿ�� �˻縦 �ǽ��Ѵ�. ��ȿ�� �˻縦 �޴� ������Ʈ���� "validExp" ���
 *           �Ӽ����� �����ؾ� �Ѵ�. "validExp" ��� �Ӽ��� ���� html ��ü���� ���ǵǾ� ���� ���� �Ӽ������� �ٸ� �Ӽ�����
 *           �����ϴ� �Ͱ� ���� ������� �����ϸ� �ڵ����� �ش� ������Ʈ�� �Ӽ����� �νĵȴ�.<br><br>
 *           - �ش� ������Ʈ�� ���� child ������Ʈ������� �˻��Ѵ�. �������, �˻���� ������Ʈ���� &lt;div&gt; �±׷� ���ΰ�
 *             &lt;div&gt; �±��� id�� �Ķ���ͷ� �شٸ� &lt;div&gt; �±׳��� ��� ������Ʈ���� �ڵ����� �˻�ް� �ȴ�. ��,
 *             &lt;table&gt;�ȿ� �Է��ʵ���� &lt;table&gt;�� id�� �Ķ���ͷ� �ָ� �ȴ�.<br><br>
 *           - �Է°��� �հ� ���� ������ ��ȿ�� �˻縦 �ϸ鼭 �ڵ����� trim�ȴ�.
 * <pre>
 *    ��1)
 *    ...
 *    function fncSave() {
 *        if (<b>cfValidate([oRecevInfo])</b>) {
 *            oDomRegiRecevGTR.post();
 *        }
 *    }
 *    ...
 *
 *    &lt;table <b>id="oRecevInfo"</b> ....&gt;
 *        ...
 *        &lt;object id="oRecevNo" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="50" <b>validExp="������ȣ:yes:length=6"</b>&gt;
 *            &lt;param name="Format"    value="000000"&gt;
 *        &lt;/object&gt;
 *        ...
 *    &lt;/table&gt;
 *    ...
 * </pre>
 * validExp �Ӽ����� ������ ���Ŀ� �°� �ۼ��Ǿ�� �ϴµ� ������ ������Ʈ�� ������ ���� �� ������ ������.<br>
 * <pre>
 *    1. �Ϲ� ������Ʈ�� ��� (��1 ����)
 *        "item_name:�ʼ�����:valid_expression"
 *
 *        - "item_name"���� �ش� �׸� ���� �̸��� ����Ѵ�.
 *        - "�ʼ�����"���� �ش� ������Ʈ�� �ʼ� �׸����� ���θ� yes|true|1 Ȥ�� no|false|0 Ÿ������ ����Ѵ�.
 *        - "valid_expression" ��  cfValidateValue �Լ��� ������ �����ϱ� �ٶ���.
 *        - �ʼ��׸������� üũ�Ϸ��� "valid_expression" �� ǥ������ ������ �ȴ�.
 *          ��)
 *          &lt;object id="oDelivYmd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="80" <b>validExp="�������:yes"</b>&gt;
 *              ...
 *			&lt;/object&gt;
 *        - validExp ���� ���Ƿ� ",", ":", "=", "&", ���ڸ� ����ϰ��� �Ѵٸ� "\\,", "\\:", "\\=", "\\&" ��� ǥ���ؾ� �Ѵ�.<br>
 *
 *
 *    2. ���콺 Grid ������Ʈ�� ���
 *        "column_id:item_name:�ʼ�����[:valid_expression[:key]][,column_name:item_name:�ʼ�����[:valid_expression[:key]]]..."
 *
 *        - column_id ����  Grid�� ����� DataSet�� ���� �÷� id �� �����ش�.
 *
 *        - <font color=red><b>dataName</b></font>�̶�� �Ӽ��� ����� �־�� �Ѵ�. dataName�� �ش� DataSet
 *        �� ǥ���ϴ� �̸��� ����� �ָ� �ȴ�.
 *
 *        ��)
 *
 *        cfValidate([oDomRegiRecevGG]);
 *        ...
 *        &ltobject id="oDomRegiRecevGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"
 *           width="174" height="233" style="position:absolute; left:10; top:73;"  <b>dataName="��ް������Ʈ"</b>
 *         <b>validExp="regiNo:����ȣ:yes:length=13:key,
 *                  sendPrsnZipNo:�߼��ο����ȣ:yes:length=6,
 *                  recPrsnZipNo:�����ο����ȣ:yes:length=6
 *                 "</b>
 *        &gt;
 *
 *        - ���� item_name�� ������� �ʾ��� ��쿡�� Grid�� column_id�� �ش��ϴ� �÷��� �÷������� �ڵ����� ��ü�ȴ�.
 *          ��) validExp="regiNo::yes:length=13, ..."
 *
 *        - ���� �÷��� key�÷��� ��쿡�� ���� key��� ����� �ش�. key��� ����� �ָ� �ٸ� Row�� �����Ͱ� �ߺ��Ǿ��� ��
 *          ������ �߻���Ų��. ��, key�� ����� �� ��쿡�� valid_expression �� �ݵ�� ������ �ְ� ������ �� ������ ������
 *          ':' �� �����ؾ� �Ѵ�.
 *          ��) validExp="regiNo:����ȣ:yes::key, ...
 *
 *        - �������� 1�� ���� ����.
 * </pre>
 * @sig    : objArr
 * @param  : objectArr required ��ȿ���˻縦 �ϰ��� �ϴ� ������Ʈ���� Array.
 * @return : boolean. ��ȿ�� ����.
  */
function cfValidate(objArr) {
        var oElement;
        var validYN = false;
        for (var objArrIdx = 0; objArrIdx < objArr.length; objArrIdx++) {
                oElement = objArr[objArrIdx];

                switch (oElement.tagName) {
                        case "TABLE":
                        case "DIV":
                        case "FIELDSET":
                                for (var i = 0; i < oElement.all.length; i++) {
                                        if (!cfValidateElement(oElement.all[i])) {
                                                return false;
                                        }
                                }

                                break;

                        default:
                                if (!cfValidateElement(oElement)) {
                                        return false;
                                }
                }
        }

        return true;
}

/**
 * @type   : function
 * @access : private
 * @desc   : ���콺�� html �� ��� ������Ʈ�� ���� ��ȿ�� �˻縦 �Ѵ�.
 * @sig    : oElement
 * @param  : oElement required �˻� ��� Element.
 * @return : boolean. ��ȿ�� ����.
 */
function cfValidateElement(oElement) {
        if (oElement.tagName == "OBJECT" &&
            oElement.attributes.classid.nodeValue.toUpperCase() == "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"
           ) {
                return cfValidateGrid(oElement);
        } else {
                return cfValidateItem(oElement);
        }
}


/**
 * @type   : function
 * @access : private
 * @desc   : ���콺 ������Ʈ �߿��� DataSet�� ������ ��� ������Ʈ�� html�� ��� ������Ʈ�� ���� ��ȿ�� �˻縦 �Ѵ�.
 * @sig    : oElement
 * @param  : oElement required �˻� ��� Element.
 * @return : boolean. ��ȿ�� ����.
  */
function cfValidateItem(oElement) {
        if (cfIsNull(oElement.validExp)) {
                return true;
        }

        var value;
        var itemValidExp = new covItemValidExp(oElement.validExp);

        switch (oElement.tagName) {
                case "INPUT":

                case "SELECT":

                case "TEXTAREA":
                        oElement.value = oElement.value.trim();  // element�� ���� trim �����ش�.
                        value = oElement.value;
                        break;

                case "OBJECT":
                        switch (oElement.attributes.classid.nodeValue.toUpperCase()) {
                                case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
                                case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component
                                        oElement.CodeValue = (oElement.CodeValue == null) ? null : oElement.CodeValue.trim();  // element�� ���� trim �����ش�.
                                        value = oElement.CodeValue;
                    break;

                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component
                                case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component
                                case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component
                                        oElement.Text = (oElement.Text == null) ? null : oElement.Text.trim();  // element�� ���� trim �����ش�.
                                        value = oElement.Text;
                    break;

                default:
                        break;
                        }

                        break;

                default:
                        return true;
        }

        if (!itemValidExp.validate(value)) {
                alert(new coMessage().getMsg(VMSG_ITEMNAME, [itemValidExp.itemName]) + itemValidExp.errMsg);
                oElement.focus();
                return false;
        }

        return true;
}

/**
 * @type   : function
 * @access : public
 * @desc   : ���콺�� Grid�� ���� ��ȿ�� �˻縦 �Ѵ�. ��ȿ�� �˻縦 ���ؼ��� Grid�� DataId�� ������ DataSet�� validExp �Ӽ���
 *           �����Ǿ� �־�� �Ѵ�. ��������� cfValidate �Լ��� ���� ������ �����ϱ� �ٶ���. (���������δ� Grid�� �˻��ϴ� ���� �ƴ϶�
 *           Grid�� DataId�� ������ DataSet�� ���� ��ȿ�� �˻��̴�.)
 * @sig    : oGrid[, row[, colId]]
 * @param  : oGrid required �˻� ��� Grid.
 * @param  : row   optional �˻��ϰ��� �ϴ� row ��ȣ
 * @param  : colId optional �˻��ϰ��� �ϴ� �÷��� id
 * @return : boolean. ��ȿ�� ����.
  */
function cfValidateGrid(oGrid, row, colId) {
        var dataName = oGrid.dataName;
        var key = oGrid.key;
        var oDataSet = document.all(oGrid.DataId);
        var gridValidExp = new covGridValidExp(oGrid);
        var errMsg = "";

        if (!gridValidExp.validate(row, colId)) {
                alert(new coMessage().getMsg(VMSG_GRID, [dataName, gridValidExp.errRow]) +
                      new coMessage().getMsg(VMSG_ITEMNAME, [gridValidExp.errItemName]) +
                      gridValidExp.errMsg
                     );

                oDataSet.RowPosition = gridValidExp.errRow;
                oDataSet.ClearAllMark();
                oGrid.SetColumn(gridValidExp.errColId);

                return false;
        }

        return true;
}

/**
 * @type   : function
 * @access : public
 * @desc   : ������� �Է°��� Byte�� ȯ��� �ִ���̸� ���� ��� �Է��� �ȵǵ��� �ϴ� �Լ�. ������Ʈ ����� onkeydown �̺�Ʈ�� ������
 *           ���� ����� �־�߸� �Ѵ�.
 * <pre>
 *     onkeydown="cfValidateMaxByteLength(this, max_byte_length)"
 *     (���⼭ max_byte_length �ڸ����� Byte�� ȯ��� �ִ���̸� ���ڷ� �����ش�.)
 *
 *     ��)
 *     &lt;input type="text" size="10" onkeydown="cfValidateMaxByteLength(this, 10)"&gt;
 * </pre>
 *           ����� html�� text input, textarea �� ���콺�� EMEdit ���� ����ȴ�.
 * @sig    : oElement, length
 * @param  : oElement required �Է��ʵ� ��ü
 * @param  : length   required max byte length
  */
function cfValidateMaxByteLength(oElement, length) {
        var value = "";

        if (event.keyCode == 8 ||   // backspace
            event.keyCode == 37 ||  // left key
            event.keyCode == 38 ||  // up key
            event.keyCode == 39 ||  // right key
            event.keyCode == 40 ||  // down key
            event.keyCode == 46     // delete key
           ) {
                   return true;
        }

        switch (cfGetElementType(oElement)) {
                case "TEXT" :
                case "TEXTAREA" :
                        value = oElement.value;
                        break;

                case "GE" :
                case "GTA" :
                        value = oElement.Text;
                        break;

                default :
                        return;
        }

        if (cfGetByteLength(value) + 1 > length ) {
                event.returnValue = false;

                //return false;
        } else {
                event.returnValue = true;
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : Ư�� ���� ���� ��ȿ���˻縦 �����Ѵ�.
 * <pre>
 *     cfValidateValue(50, "minNumber=100");
 * </pre>
 * ���� ��� 50�� �ּҰ� 100�� ���� �����Ƿ� false�� ���ϵȴ�.<br>
 * ��ȿ�� �˻縦 �����ϱ� ���ؼ��� �˻������� ����ؾ� �ϴµ�
 * �˻������� 'valid expression' �̶�� �Ҹ���� String ������ ǥ���ȴ�. valid expression�� ���� ǥ��������
 * ������ ����.
 * <pre>
 *  	validator_name=valid_value[&validator_name=valid_value]..
 *
 *  	��) "minNumber=100"
 * </pre>
 * - validator_name�� �˻������� �ǹ��ϸ� valid_value�� ���� ���� �ȴ�. <br>
 * - �˻��׸��� �ϳ� �̻��� �� ������ �˻��׸񰣿��� "&" ���ڷ� �����Ͽ� �ʿ��� ��ŭ �����ϸ� �ȴ�. <br>
 * - valid_value�� ",", ":", "=", "&", ���ڸ� ����ϰ��� �Ѵٸ� "\\,", "\\:", "\\=", "\\&" ��� ǥ���ؾ� �Ѵ�.<br>
 * - ���� �������� "minNumber" (�ּҰ�)��� ��ȿ�� �˻��׸��� ����Ͽ��� minNumber ������ ���ذ����� "100" �� �����Ǿ� �ִ�.
 * ���� 100���� ���� ���� �Է����� ���� 100 �̻��� ���� �Է��϶�� alert box�� �߰� �ȴ�.
 * - validator_name�� �̸� ���ǵǾ� �ִ� �͸� ����� �� �ְ� �� �˻��������� valid_value�� ���µ� �ٸ���.(valid_value�� ���� �͵� �ִ�.)
 * ���� ���ǵ� �˻������� ������ ����.
 * <br><br>
 * <table border=1 style="border-collapse:collapse; border-width:1pt; border-style:solid; border-color:000000;">
 * 		<tr>
 * 			<td align="center" bgcolor="#CCCCFFF">�˻�����</td>
 * 			<td align="center" bgcolor="#CCCCFFF">���ذ� ����</td>
 * 			<td align="center" bgcolor="#CCCCFFF">����</td>
 * 			<td align="center" bgcolor="#CCCCFFF">��</td>
 * 		</tr>
 * 		<tr>
 * 			<td>length</td>
 * 			<td>0���� ū ����</td>
 * 			<td>�ڸ��� �˻�. �Է°��� �ڸ����� ���ذ��� ��ġ�ϴ����� �˻��Ѵ�. �Ϲ������� HTML������ �ѱ�, ����, ���� ��� 1�ڸ��� �νĵȴ�.</td>
 * 			<td>length=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>byteLength</td>
 * 			<td>0���� ū ����</td>
 * 			<td>Byte�� ȯ��� �ڸ��� �˻�. �Է°��� �ڸ����� byte�� ȯ���Ͽ� �ڸ����� ���ذ��� ��ġ�ϴ����� �˻��Ѵ�.(���� �� ������ 1byte, �ѱ��� 2byte�̴�.)</td>
 * 			<td>byteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minLength</td>
 * 			<td>0���� ū ����</td>
 * 			<td>�ּ��ڸ��� �˻�. �Է°��� �ڸ����� ���ذ� �̻��� �Ǵ����� �˻��Ѵ�.</td>
 * 			<td>minLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minByteLength</td>
 * 			<td>0���� ū ����</td>
 * 			<td>Byte�� ȯ��� �ּ��ڸ��� �˻�. �Է°��� �ڸ����� byte�� ȯ���Ͽ� �ڸ����� ���ذ� �̻��� �Ǵ����� �˻��Ѵ�.(���� �� ������ 1byte, �ѱ��� 2byte�̴�.)</td>
 * 			<td>minByteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxLength</td>
 * 			<td>0���� ū ����</td>
 * 			<td>�ִ��ڸ��� �˻�. �Է°��� �ڸ����� ���ذ� ���ϰ� �Ǵ����� �˻��Ѵ�.</td>
 * 			<td>maxLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxByteLength</td>
 * 			<td>0���� ū ����</td>
 * 			<td>Byte�� ȯ��� �ִ��ڸ��� �˻�. �Է°��� �ڸ����� byte�� ȯ���Ͽ� �ڸ����� ���ذ� ���ϰ� �Ǵ����� �˻��Ѵ�.(���� �� ������ 1byte, �ѱ��� 2byte�̴�.)</td>
 * 			<td>maxByteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>number</td>
 * 			<td>None</td>
 * 			<td>���ڰ˻�. �Է°��� ���������� �˻��Ѵ�.</td>
 * 			<td>number</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minNumber</td>
 * 			<td>����</td>
 * 			<td>�ּҼ� �˻�. �Է°��� �ּ��� ���ذ� �̻��� �Ǵ����� �˻��Ѵ�.</td>
 * 			<td>minNumber=100</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxNumber</td>
 * 			<td>����</td>
 * 			<td>�ִ�� �˻�. �Է°��� ���ذ� ���������� �˻��Ѵ�.</td>
 * 			<td>maxNumber=300</td>
 * 		</tr>
 * 		<tr>
 * 			<td>inNumber</td>
 * 			<td>"����~����" �������� ǥ��.</td>
 * 			<td>������ �˻�. �Է°��� ������ �Ǵ� �� ���� ���ų� Ȥ�� �� �� ���̿� �����ϴ� �������� �˻��Ѵ�.</td>
 * 			<td>inNumber=100~300</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minDate</td>
 * 			<td>YYYYMMDD ������ ��¥ ��Ʈ��.</td>
 * 			<td>�ּҳ�¥ �˻�. �Էµ� ��¥�� ���س�¥�̰ų� ���س�¥ ���������� �˻��Ѵ�.</td>
 * 			<td>minDate=20020305</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxDate</td>
 * 			<td>YYYYMMDD ������ ��¥ ��Ʈ��. ��) maxDate=20020305</td>
 * 			<td>�ִ볯¥ �˻�. �Էµ� ��¥�� ���س�¥�̰ų� ���س�¥ ���������� �˻��Ѵ�.</td>
 * 			<td>maxDate=20020305</td>
 * 		</tr>
 * 		<tr>
 * 			<td>format</td>
 * 			<td>format character��� �ٸ� ���ڵ��� ������ ��Ʈ��.<br>
 * 				<table>
 * 					<tr>
 * 						<td><b>format character</b></td>
 * 						<td><b>desc</b></td>
 * 					</tr>
 * 					<tr>
 * 						<td>#</td>
 * 						<td>���ڿ� ����</td>
 * 					</tr>
 * 					<tr>
 * 						<td>A, Z</td>
 * 						<td>���� (Z�� ��������)</td>
 * 					</tr>
 * 					<tr>
 * 						<td>0, 9</td>
 * 						<td>���� (9�� ��������)</td>
 * 					</tr>
 * 				</table>
 * 			</td>
 * 			<td>���� �˻�. �Էµ� ���� ������ ���Ŀ� �´����� �˻��Ѵ�.</td>
 * 			<td>format=000-000</td>
 * 		</tr>
 * 		<tr>
 * 			<td>ssn</td>
 * 			<td>�ֹε�Ϲ�ȣ 13�ڸ�</td>
 * 			<td>�ֹε�Ϲ�ȣ �˻�. �Է��� �ֹε�Ϲ�ȣ�� ��ȿ������ �˻��Ѵ�.</td>
 * 			<td>ssn</td>
 * 		</tr>
 * 		<tr>
 * 			<td>csn</td>
 * 			<td>����ڵ�Ϲ�ȣ 10�ڸ�</td>
 * 			<td>����ڵ�Ϲ�ȣ �˻�. �Է��� ����ڵ�Ϲ�ȣ�� ��ȿ������ �˻��Ѵ�.
 *              (��, 2019009930)
 *          </td>
 * 			<td>csn</td>
 * 		</tr>
 * 		<tr>
 * 			<td>filter</td>
 * 			<td>���͸��ϰ� ���� ��Ʈ���� ";"���ڸ� �����ڷ� ����Ͽ� �����Ѵ�.(�� ";" ���ڸ� ���͸��ϰ� ���� �� "\\;"��� ǥ���Ѵ�.
 *          </td>
 * 			<td>�Է°��� Ư���� ���ڳ� ��Ʈ���� �ִ����� �˻��Ѵ�.
 *              (��, 2019009930)
 *          </td>
 * 			<td>filter=%;<;������;\\;;haha<br>(�Է°� ���� "%","<","������",";","haha" �߿� �ϳ��� �ִ��� �˻��Ѵ�.)
 *          </td>
 * 		</tr>
 * 		<tr>
 * 			<td>date</td>
 * 			<td>format character�� �������� �̷���� ���ڿ� ���� ���� ��Ʈ��.<br>
 * 				<table>
 * 					<tr>
 * 						<td><b>format character</b></td>
 * 						<td><b>desc</b></td>
 * 					</tr>
 * 					<tr>
 * 						<td>YYYY</td>
 * 						<td>4�ڸ� �⵵</td>
 * 					</tr>
 * 					<tr>
 * 						<td>YY</td>
 * 						<td>2�ڸ� �⵵. 2000�� ����</td>
 * 					</tr>
 * 					<tr>
 * 						<td>MM</td>
 * 						<td>2�ڸ� ������ ��</td>
 * 					</tr>
 * 					<tr>
 * 						<td>DD</td>
 * 						<td>2�ڸ� ������ ��</td>
 * 					</tr>
 * 					<tr>
 * 						<td>hh</td>
 * 						<td>2�ڸ� ������ �ð�. 12�� ����</td>
 * 					</tr>
 * 					<tr>
 * 						<td>HH</td>
 * 						<td>2�ڸ� ������ �ð�. 24�� ���� </td>
 * 					</tr>
 * 					<tr>
 * 						<td>mm</td>
 * 						<td>2�ڸ� ������ ��</td>
 * 					</tr>
 * 					<tr>
 * 						<td>ss</td>
 * 						<td>2�ڸ� ������ ��</td>
 * 					</tr>
 * 				</table>
 * 			</td>
 * 			<td>��¥ �˻�. �Էµ� ��Ʈ������ ��¥�� ȯ���Ͽ� ��ȿ�� ��¥������ �˻��Ѵ�.</td>
 * 			<td>date=YYYYMMDD  �� �� �Է°��� '20020328' �� ��� -> ��ȿ<br>
 *              date=YYYYMMDD  �� �� �Է°��� '20020230' �� ��� -> ����<br>
 *              date=Today is YY-MM-DD' �� �� �Է°��� 'Today is 02-03-28' �� ��� -> ��ȿ<br><br>
 * 				����) format���ڰ� �ߺ��ؼ� �������� ó�� ���� ���ڿ� ���ؼ��� format���ڷ� �νĵȴ�.
 *                    YYYY�� YY, hh�� HH �� �ߺ����� ����. ��¥�� ��,���� ������ ���� ��Ȯ�� üũ�ϰ�
 *                    ���� ��, ���� ���ٸ� 1 ~ 31 ���������� üũ�Ѵ�.
 * 			</td>
 * 		</tr>
 * </table>
 * @sig    : value, validExp
 * @param  : value    required �˻� ����� �Ǵ� ��.
 * @param  : validExp required ����ڰ� ������ Valid Expression String.
 * @return : boolean. ��ȿ�� ����.

 */
function cfValidateValue(value, validExp) {
        var valueValidExp = new covValueValidExp(validExp);

        if (!valueValidExp.validate(value)) {
                return false;
        }

        return true;
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid�� ���õ� Row���� ����Ѵ�.
 * <pre>
 *     cfUndoGridRows(oDomRegiRecevGDS);
 * </pre>
 * ���� ������ oDomRegiRecevGDS ��� id�� ���� Grid�� ���� ���õ� Row���� ��� ��ҵȴ�.
 * @sig    : dataSet
 * @param  : dataSet required DataSet ������Ʈ�� id

 */
function cfUndoGridRows(dataSet) {
        for (var i = dataSet.CountRow; i > 0; i--) {
                if (dataSet.RowMark(i)) {
                        dataSet.Undo(i);
                }
        }
}



//----- message ----------------

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : ����޼����� ���ǵ� �޼����� alert box�� ������ �� �����Ѵ�. cfGetMSG ����.
 * @sig    : msgId[, paramArray]
 * @param  : msgId required common.js�� ���� �޼��� ������ ����� �޼��� ID
 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ������ Array. Array�� index�� �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.
             ġȯ�� �����ʹ� [] ���̿� �޸��� �����ڷ� �Ͽ� ����ϸ� Array �� �νĵȴ�.
 * @return : ġȯ�� �޼��� ��Ʈ��
 */
function cfAlertMSG(msgId, paramArray) {
        var msg = new coMessage().getMsg(msgId, paramArray);

        alert(msg);

        return msg;
}


/**
 * @type   : prototype_function
 * @access : public
 * @desc   : ���뿡���޼��� â�� �����ش�.
 * @sig    : msgId[, paramArray]
 * @param  : MsgCase required : ��������
 * @param  : allSys required : ��������
 * @param  : MSGStr required : �����޼���
 */
function cfShowMSGBox(MsgCase, allSys, MSGStr) {

    var index = MSGStr.indexOf("[");
    var find_msg = MSGStr.substring(index+1,index+5);

    if (cfIsIn(find_msg, ["DSET", "GRID", "TRNS","COMB","MEDT","RDIO","TREE","TTAB","TEXT","MENU","CHRT","REPT"]))   {
        var index2 = MSGStr.indexOf("]");
        var tmp_msg = MSGStr.substring(index2+1);
        MSGStr = tmp_msg;
    }


    if (MsgCase == "ERROR") {
        var return_val = window.showModalDialog("/trms/cb/message/html/Message_Error.jsp?allSys="+allSys+"&ErrorStr="+MSGStr, "", "dialogWidth:356px; dialogHeight:225px; help:no; status:no");
        return return_val;
    }

    if (MsgCase == "WARNING") {
        var return_val = window.showModalDialog("/trms/cb/message/html/Message_Warning.jsp?allSys="+allSys+"&WarningStr="+MSGStr, "", "dialogWidth:356px; dialogHeight:225px; help:no; status:no");
        return return_val;
    }

    if (MsgCase == "CONFIRM") {
        var return_val = window.showModalDialog("/trms/cb/message/html/Message_Confirm.jsp?allSys="+allSys+"&ConfirmStr="+MSGStr, "", "dialogWidth:356px; dialogHeight:225px; help:no; status:no");
        return return_val;
   }

    if (MsgCase == "STATUS") {
        window.status = MSGStr;
        return;
    }

}



//2003.01.17 �߰�
function cfParentDisable(parentObj) {

        switch (parentObj.tagName) {
                case "TABLE":
                        for (i in parentObj.all) {
                                cfDisable(parentObj.all[i]);
                        }

                        break;

                case "DIV":
                        for (i in parentObj.children) {
                                cfDisable(parentObj.children[i]);
                        }

                        break;

                case "FIELDSET":
                        for (i in parentObj.children) {
                                cfDisable(parentObj.children[i]);
                        }

                        break;

                default:
                        cfDisable(parentObj);
        }
}

function cfParentEnable(parentObj) {

        switch (parentObj.tagName) {
                case "TABLE":
                        for (i in parentObj.all) {
                                cfEnable(parentObj.all[i]);
                        }

                        break;

                case "DIV":
                        for (i in parentObj.children) {
                                cfEnable(parentObj.children[i]);
                        }

                        break;

                case "FIELDSET":
                        for (i in parentObj.children) {
                                cfEnable(parentObj.children[i]);
                        }

                        break;

                default:
                        cfEnable(parentObj);
        }
}


//----- message ----------------














//---------------------------------------- ���� ��ü���� ---------------------------------------------//

///////////////////////////// coMessage /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : �޼����� �����ϴ� ��ü�̴�.

 */
function coMessage() {
        // method
        this.getMsg = coMessage_getMsg;
}

/**
 * @type   : method
 * @access : public
 * @object : coMessage
 * @desc   : ����޼����� ���ǵ� �޼����� ġȯ�Ͽ� �˷��ش�.
 * @sig    : message[, paramArray]
 * @param  : message    required common.js�� ���� �޼��� ������ ����� �޼��� ID
 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ��Ʈ�� Array. (Array�� index��
 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.)
 * @return : ġȯ�� �޼��� ��Ʈ��
 */
function coMessage_getMsg(message, paramArray) {
        var index = -1;
        var re = /@/g;
        var count = 0;

        if (paramArray == null) {
                return message;
        }

        while ( (index = message.indexOf("@")) != -1) {
                message = message.substr(0, index + 1).replace(re, paramArray[count++]) +
                          message.substring(index + 1);
        }

        return message;
}

///////////////////////////// coMap /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : String parameter �� ���� name�� value �ֵ��� ���� ��ü

 */
function coMap() {
        // fields

        this.names = new Array();
        this.values = new Array();
        this.count = 0;

        // methods
        this.getValue          = coMap_getValue;
        this.put               = coMap_put;
        this.getNameAt         = coMap_getNameAt;
        this.getValueAt        = coMap_getValueAt;
        this.size              = coMap_size;
        this.getMaxNameLength  = coMap_getMaxNameLength;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : name�� �´� �Ķ���Ͱ��� �����Ѵ�.
 * @sig    : name
 * @param  : name required map�� name���� ����� ��
 * @return : �Ķ���Ͱ�
 */
function coMap_getValue(name) {
        for (var i = 0; i < this.count; i++) {
                if (this.names[i] == name) {
                        return this.values[i];
                }
        }

        return null;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : ���ο� map�� �߰��Ѵ�. ���� name�� ������ ��� overwrite�Ѵ�.
 * @sig    : name, value
 * @param  : name  required map�� name�� ����� ��
 * @param  : value required map�� value�� ����� ��
 * @return : �Ķ���Ͱ�
 */
function coMap_put(name, value) {
        for (var i = 0; i < this.count; i++) {
                if (this.names[i] == name) {
                        this.values[i] = value;
                        return;
                }
        }

        this.names[this.count] = name;
        this.values[this.count++] = value;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : ������ index�� �ִ� map�� name�� �˷��ش�.
 * @sig    : index
 * @param  : index - map�� index
 * @return : name
 */
function coMap_getNameAt(index) {
        return this.names[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : ������ index�� �ִ� map�� value�� �˷��ش�.
 * @sig    : index
 * @param  : index required map�� index
 * @return : value
 */
function coMap_getValueAt(index) {
        return this.values[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : map�� name-value ���� ������ �˷��ش�.
 * @return : name-value ���� ����
 */
function coMap_size() {
        return this.count;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : map ���� name ������ String���� ȯ���Ͽ� �ִ���̸� �˷��ش�.
 * @return : max name length
 */
function coMap_getMaxNameLength() {
        var maxLength = 0;

        for (var i = 0; i < this.count; i++) {
                if (String(this.names[i]).length > maxLength) {
                        maxLength = String(this.names[i]).length;
                }
        }

        return maxLength;
}

///////////////////////////// coParameterMap /////////////////////////////
/**
 * @type   : object
 * @access : public
 * @desc   : String parameter �� ���� name�� value �ֵ��� ���� ��ü

 */
function coParameterMap() {
        // fields

        /**
         * @type   : field
         * @access : private
         * @object : coParameterMap
         * @desc   : �Ķ���� �̸��� ����ִ� array
         */
        this.names = new Array();

        /**
         * @type   : field
         * @access : private
         * @object : coParameterMap
         * @desc   : �Ķ���� ���� ����ִ� array
         */
        this.values = new Array();

        /**
         * @type   : field
         * @access : private
         * @object : coParameterMap
         * @desc   : �Ķ������ ����
         */
        this.count = 0;

        // methods
        this.getValue          = coParameterMap_getValue;
        this.put               = coParameterMap_put;
        this.getNameAt         = coParameterMap_getNameAt;
        this.getValueAt        = coParameterMap_getValueAt;
        this.size              = coParameterMap_size;
        this.getMaxNameLength  = coParameterMap_getMaxNameLength;
        this.getMaxValueLength = coParameterMap_getMaxValueLength;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : name�� �´� �Ķ���Ͱ��� �����Ѵ�.
 * @sig    : name
 * @param  : name required map�� name���� ����� ��
 * @return : �Ķ���Ͱ�
 */
function coParameterMap_getValue(name) {
        for (var i = 0; i < this.count; i++) {
                if (this.names[i] == name) {
                        return this.values[i];
                }
        }

        return null;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : ���ο� map�� �߰��Ѵ�. ���� name�� ������ ��� overwrite�Ѵ�.
 * @sig    : name, value
 * @param  : name  required map�� name�� ����� ��
 * @param  : value required map�� value�� ����� ��
 * @return : �Ķ���Ͱ�
 */
function coParameterMap_put(name, value) {
        for (var i = 0; i < this.count; i++) {
                if (this.names[i] == name) {
                        this.values[i] = value;
                        return;
                }
        }

        this.names[this.count] = name;
        this.values[this.count++] = value;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : ������ index�� �ִ� map�� name�� �˷��ش�.
 * @sig    : index
 * @param  : index required map�� index
 * @return : name
 */
function coParameterMap_getNameAt(index) {
        return this.names[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : ������ index�� �ִ� map�� value�� �˷��ش�.
 * @sig    : index
 * @param  : index required map�� index
 * @return : value
 */
function coParameterMap_getValueAt(index) {
        return this.values[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map�� name-value ���� ������ �˷��ش�.
 * @return : name-value ���� ����
 */
function coParameterMap_size() {
        return this.count;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map ���� name ������ String���� ȯ���Ͽ� �ִ���̸� �˷��ش�.
 * @return : max name length
 */
function coParameterMap_getMaxNameLength() {
        var maxLength = 0;

        for (var i = 0; i < this.count; i++) {
                if (String(this.names[i]).length > maxLength) {
                        maxLength = String(this.names[i]).length;
                }
        }

        return maxLength;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map ���� value ������ String���� ȯ���Ͽ� �ִ���̸� �˷��ش�.
 * @return : max value length
 */
function coParameterMap_getMaxValueLength() {
        var maxLength = 0;

        for (var i = 0; i < this.count; i++) {
                if (String(this.values[i]).length > maxLength) {
                        maxLength = String(this.values[i]).length;
                }
        }

        return maxLength;
}

//-------------------------- ��ȿ�� �˻縦 ���� ��ü ���� -----------------------------//
/*
 * @Validator ��ü�� ����
 *   - �Ӽ� : exception,   -> validity�� sub�Ӽ��̴�. validity�� true�� exception�� ������ false�̰�
 *                            validity�� false�� ��� false�� ������ exception���� ���θ� �˷��ش�.
 *                            exception�� ����� �Է¿� ���� ���� validation���� ������ ������ �ǹ��Ѵ�.
 *                            true/false �� �ϳ�.
 *            message,     -> �����޼����� ��� �ִ�.
 *            validity,    -> ��ȿ���˻����� ��� �ִ�. true/false �� �ϳ�.
 *            value        -> ��ȿ�� �˻� ��� ��.
 *
 *   - �޼ҵ� : validate() -> ��ȿ�� �˻縦 �����Ѵ�.
 *                            ��ȿ�� ���, validity�� true���ϰ� true�� return�ϰ�
 *                            ��ȿ���� ���� ���,  validity�� false���ϰ� false�� return�ϰ�
 *                            message�� �����޼����� ����Ѵ�.
 *                            exception�� ���� exception�� true�� �ϰ� message�� �޼����� ����Ѵ�.
 *
 *   - �߰��� ���� :
 *     1) validator��ü�� �����Ѵ�.
 *     2) covValidExp ��ü�� getValidators �޼ҵ忡 validator��ü�� ����Ѵ�.
 */

///////////////////////////// covValueValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : ��ȿ�� �˻翡 ���� ǥ��(expression)�� ��üȭ �Ͽ���.
 *             - expression ����<br>
 *               �׸��̸�:�ʼ��׸񿩺�:��ȿ���׸�<br>
 *               ��) "������ȣ:yes:length=6"
 *             - ��ȿ�� �׸� ����
 *               ��ȿ���׸��=��ȿ��[&��ȿ���׸��=��ȿ��]..
 *               ��) "length=13&ssn"
 * @sig    : expression
 * @param  : expression required valid expression string.

 */
function covValueValidExp(expression) {
    // data;
    this.validItems = new Array();
    this.errMsg = "";

    // method
    this.init = covValueValidExp_init;
    this.parse = covValueValidExp_parse;
    this.validate = covValueValidExp_validate;

    // initialize
    this.init(expression);
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : �ʱ�ȭ�� �����Ѵ�.
 * @sig    : expression
 * @param  : expression required valid expression string.

 */
function covValueValidExp_init(expression) {
        this.parse(expression);
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : covValidExp ��ü�� parse �޼ҵ�.
 *           valid expression�� parsing�Ѵ�.
 * @sig    : expression
 * @param  : expression required valid expression string.
 */
function covValueValidExp_parse(expression) {
        if (cfIsNull(expression)) {
                return;
        }

        var validItemExps = expression.advancedSplit("&", "i");
        var validItem;

        for (var i = 0; i < validItemExps.length; i++) {
                validItemPair = validItemExps[i].trim().advancedSplit("=", "i");
                validItem = new Object();
                validItem.name  = validItemPair[0].trim();
                validItem.value = validItemPair[1];  // parsedExp[1] �� �������� ���� ���� ������ �ڹٽ�ũ��Ʈ������
                this.validItems[i] = validItem;      // �̷� ��� "undefined" ��� ���� �����Ѵ�.
        }
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value required �˻���
 */
function covValueValidExp_validate(value) {
        var validators = new Array();
        var count = 0;

        for (var i = 0; i < this.validItems.length; i++) {
                switch (this.validItems[i].name) {
                        case "length" :
                                validators[count++] = new covLengthValidator(this.validItems[i].value);
                                break;

                        case "byteLength" :
                                validators[count++] = new covByteLengthValidator(this.validItems[i].value);
                                break;

                        case "minLength" :
                                validators[count++] = new covMinLengthValidator(this.validItems[i].value);
                                break;

                        case "minByteLength" :
                                validators[count++] = new covMinByteLengthValidator(this.validItems[i].value);
                                break;

                        case "maxLength" :
                                validators[count++] = new covMaxLengthValidator(this.validItems[i].value);
                                break;

                        case "maxByteLength" :
                                validators[count++] = new covMaxByteLengthValidator(this.validItems[i].value);
                                break;

                        case "number" :
                                validators[count++] = new covNumberValidator();
                                break;

                        case "minNumber" :
                                validators[count++] = new covMinNumberValidator(this.validItems[i].value);
                                break;

                        case "maxNumber" :
                                validators[count++] = new covMaxNumberValidator(this.validItems[i].value);
                                break;

                        case "inNumber" :
                                validators[count++] = new covInNumberValidator(this.validItems[i].value);
                                break;

                        case "minDate" :
                                validators[count++] = new covMinDateValidator(this.validItems[i].value);
                                break;

                        case "maxDate" :
                                validators[count++] = new covMaxDateValidator(this.validItems[i].value);
                                break;

                        case "format" :
                                validators[count++] = new covFormatValidator(this.validItems[i].value);
                                break;

                        case "ssn" :
                                validators[count++] = new covSsnValidator(this.validItems[i].value);
                                break;

                        case "csn" :
                                validators[count++] = new covCsnValidator(this.validItems[i].value);
                                break;

                        case "filter" :
                                validators[count++] = new covFilterValidator(this.validItems[i].value);
                                break;

                        case "date" :
                                validators[count++] = new covDateValidator(this.validItems[i].value);
                                break;

                        default :
                                break;
                }
        }

        for (var i = 0; i < validators.length; i++) {
                if (!validators[i].validate(value)) {
                        this.errMsg = validators[i].message;
                        return false;
                }
        }

        return true;
}

///////////////////////////// covItemValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : ��ȿ�� �˻翡 ���� ǥ��(expression)�� ��üȭ �Ͽ���.
 *             - expression ����<br>
 *               �׸��̸�:�ʼ��׸񿩺�:��ȿ���׸�<br>
 *               ��) "������ȣ:yes:length=6"
 *             - ��ȿ�� �׸� ����
 *               ��ȿ���׸��=��ȿ��[&��ȿ���׸��=��ȿ��]..
 *               ��) "length=13&ssn"
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required �����۸�

 */
function covItemValidExp(expression, itemName) {
    // data;
    this.itemName;
    this.required;
    this.valueValidExp;

    // method
    this.parse = covItemValidExp_parse;
    this.validate = covItemValidExp_validate;

    // initialize
    this.parse(expression, itemName);
}

/**
 * @type   : method
 * @access : public
 * @object : covItemValidExp
 * @desc   : valid expression�� parsing�Ѵ�.
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required �����۸�
 */
function covItemValidExp_parse(expression, itemName) {
        if (cfIsNull(expression)) {
                return;
        }

        var columns = expression.advancedSplit(":", "i");

        if (cfIsNull(columns[1])) {
                return;
        }

        if (cfIsNull(columns[0])) {
                if (!cfIsNull(itemName)) {
                        this.itemName = itemName.trim();
                } else {
                        return;
                }
        } else {
                this.itemName = columns[0].trim();
        }

        this.required = (columns[1].trim().toUpperCase() == "YES" ||
                         columns[1].trim().toUpperCase() == "TRUE" ||
                         columns[1].trim() == "1"
                        ) ? true : false;

        if ((columns[2]) != null) {
                this.valueValidExp = new covValueValidExp(columns[2].trim());
        }
}

/**
 * @type   : method
 * @access : public
 * @object : covItemValidExp
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value required �˻��� ��
 */
function covItemValidExp_validate(value) {
        // ǥ���Ŀ� �ʼ��׸��(�����۸�, �ʼ�����)�� ������� ���� ���� ǥ������ ���ٰ� ����.
        if (cfIsNull(this.itemName) || cfIsNull(this.required)) {
                return true;
        }

        if (this.required && cfIsNull(value)) {
                this.errMsg = VMSG_ERR_REQUIRED;
                return false;
        }

        if (!this.required && cfIsNull(value)) {
                return true;
        }

        if (this.valueValidExp == null) {
                return true;
        }

        if (!this.valueValidExp.validate(value)) {
                this.errMsg = this.valueValidExp.errMsg;
                return false;
        }

        return true;
}

///////////////////////////// covColumnValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid�� �÷� ��ȿ�� �˻� ǥ����
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required �˻��� Grid ������Ʈ

 */
function covColumnValidExp(expression, oGrid) {
    // data;
    this.colId;
    this.errMsg = "";
    this.errRow = -1;
    this.errItemName = "";
    this.itemValidExp;
    this.keyYN = false;

    // method
    this.parse    = covColumnValidExp_parse;
    this.validate = covColumnValidExp_validate;

    // initialize
    this.parse(expression, oGrid);
}

/**
 * @type   : method
 * @access : public
 * @object : covColumnValidExp
 * @desc   : valid expression�� parsing�Ѵ�.
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required �˻��� Grid ������Ʈ
 */
function covColumnValidExp_parse(expression, oGrid) {
        var index = -1;

        var expArr = expression.advancedSplit(":", "i");

        if (expArr.length < 4) {
                return;
        }

        this.colId = expArr[0].trim();
        this.itemValidExp = new covItemValidExp(expArr[1] + ":" + expArr[2] + ":" + expArr[3], oGrid.ColumnProp(this.colId, "Name"));
        if (!cfIsNull(expArr[4]) && expArr[4].toUpperCase().trim() == "KEY") {
                this.keyYN = true;
        }
}

/**
 * @type   : method
 * @access : public
 * @object : covColumnValidExp
 * @desc   : validation�� �����Ѵ�.
 * @sig    : oDataSet, row
 * @param  : oDataSet required �˻��� DataSet
 * @param  : row      required �˻��� DataSet�� Ư�� row ��ȣ
 */
function covColumnValidExp_validate(oDataSet, row) {
        if (oDataSet == null ||
            oDataSet.tagName != "OBJECT" ||
            oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ||
            oDataSet.CountRow < 1
           ) {
                   return true;
        }

        var startIdx = 1;
        var endIdx = oDataSet.CountRow;
        var value;
        var rowYN = false;

        if (row != null) {
                startIdx = row;
                endIdx = row;
                rowYN = true;
        }

        for (var i = startIdx; i <= endIdx; i++) {
                if (oDataSet.RowStatus(i) != 0) {
                        value = (oDataSet.NameValue(i, this.colId) == null) ?
                     null : oDataSet.NameString(i, this.colId).trim();  // DataSet�� data�� trim ��Ų��.

                        if (this.itemValidExp != null && !this.itemValidExp.validate(value)) {
                                this.errMsg = this.itemValidExp.errMsg;
                                this.errRow = i;
                                this.errItemName = this.itemValidExp.itemName;
                                return false;
                        }
                }
        }

        // �ߺ����� �˻�
        if (this.keyYN) {
                if (rowYN) {
                        for (var i = startIdx; i <= endIdx; i++) {
                                for (j = 1; j <= endIdx; j++) {
                                        if (i == j) {
                                                continue;
                                        }

                                        if (oDataSet.NameValue(i, this.colId) == oDataSet.NameValue(j, this.colId)
                                           ) {
                                                this.errMsg = cfGetMSG(VMSG_ERR_DUPLICATE);
                                                this.errRow = i;
                                                this.errItemName = this.itemValidExp.itemName;
                                                return false;
                                        }
                                }
                        }
                } else {
                        for (var i = startIdx; i <= endIdx - 1; i++) {
                                for (j = i + 1; j <= endIdx; j++) {
                                        if (oDataSet.NameValue(i, this.colId) == oDataSet.NameValue(j, this.colId)
                                           ) {
                                                this.errMsg = cfGetMSG(VMSG_ERR_DUPLICATE);
                                                this.errRow = j;
                                                this.errItemName = this.itemValidExp.itemName;
                                                return false;
                                        }
                                }
                        }
                }
        }

        return true;
}

///////////////////////////// covGridValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid�� ���� ��ȿ���˻� ǥ����
 * @sig    : oGrid
 * @param  : oGrid required �˻��� Grid

 */
function covGridValidExp(oGrid) {
    // data;
    this.oGrid = oGrid;
    this.columnValidExps = new Array();
        this.errMsg;
        this.errRow;
        this.errColId;
        this.errItemName;

    // method
    this.parse = covGridValidExp_parse;
    this.validate = covGridValidExp_validate;

    // initialize
    this.parse();
}

/**
 * @type   : method
 * @access : public
 * @object : covGridValidExp
 * @desc   : valid expression�� parsing�Ѵ�.
 */
function covGridValidExp_parse() {
        if (cfIsNull(this.oGrid) || cfIsNull(this.oGrid.validExp)) {
                return;
        }

        var columns = this.oGrid.validExp.trim().advancedSplit(",", "it");

        for (var i = 0; i < columns.length; i++) {
            this.columnValidExps[i] = new covColumnValidExp(columns[i], this.oGrid);
        }
}

/**
 * @type   : method
 * @access : public
 * @object : covGridValidExp
 * @desc   : validation�� �����Ѵ�.
 * @sig    : [row[, colId]]
 * @param  : row   optional �˻��� Grid�� Ư�� row ��ȣ
 * @param  : colId optional �˻��� Grid�� Ư�� �÷� id
 */
function covGridValidExp_validate(row, colId) {
        var oDataSet = document.all(this.oGrid.DataId);

        if (oDataSet == null ||
            oDataSet.tagName != "OBJECT" ||
            oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ||
            oDataSet.CountRow < 1
           ) {
                   return true;
        }

        startIdx = 1;
        endIdx = oDataSet.CountRow;
        var columnValidExp;

        if (row != null) {
                startIdx = row;
                endIdx = row;
        }

        for (var i = startIdx; i <= endIdx; i++) {
                if (oDataSet.RowStatus(i) != 0) {
                        for (var j = 0; j < this.columnValidExps.length; j++) {
                                columnValidExp = this.columnValidExps[j];

                                if (colId == null || columnValidExp.colId == colId) {
                                        if (!columnValidExp.validate(oDataSet, i)) {
                                                this.errMsg = columnValidExp.errMsg;
                                                this.errRow = i;
                                                this.errColId = columnValidExp.colId;
                                                this.errItemName = columnValidExp.errItemName;
                                                return false;
                                        }
                                }
                        }
                }
        }


        return true;
}

///////////////////////////// covLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'length' �׸� ���� validator. ���� ������ ���̸� ������ �ִ��� �˻��Ѵ�.
 * @param  : length required ��ȿ�� ���ر���.

 */
function covLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covLengthValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covLengthValidator_validate(value) {
        if (value.length != this.length) {
                this.message = new coMessage().getMsg(VMSG_ERR_LENGTH, [this.length]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covByteLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'byteLength' �׸� ���� validator. ���� ������ byte������ ���̸� ������ �ִ��� �˻��Ѵ�.
 * @param  : length required ��ȿ�� ���ر���.

 */
function covByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covByteLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covByteLengthValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covByteLengthValidator_validate(value) {
        if (cfGetByteLength(value) != this.length) {
                this.message = new coMessage().getMsg(VMSG_ERR_BYTE_LENGTH, [this.length, Math.floor(this.length / 2)]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMinLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minLength' �׸� ���� validator. ���� ������ ���� �̻������� �˻��Ѵ�.
 * @sig    : length
 * @param  : length required ��ȿ�� ���ر���.

 */
function covMinLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMinLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinLengthValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMinLengthValidator_validate(value) {
        if (value.length < this.length) {
                this.message = new coMessage().getMsg(VMSG_ERR_MIN_LENGTH, [this.length]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMinByteLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minByteLength' �׸� ���� validator. ���� ������ byte������ ���� �̻������� �˻��Ѵ�.
 * @sig    : length
 * @param  : length required ��ȿ�� ���ر���.

 */
function covMinByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMinByteLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinByteLengthValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMinByteLengthValidator_validate(value) {
        if (cfGetByteLength(value) < this.length) {
                this.message = new coMessage().getMsg(VMSG_ERR_MIN_LENGTH, [this.length, Math.floor(this.length / 2)]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMaxLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxLength' �׸� ���� validator. ���� ������ ���� �̻������� �˻��Ѵ�.
 * @sig    : length
 * @param  : length required ��ȿ�� ���ر���.

 */
function covMaxLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMaxLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxLengthValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMaxLengthValidator_validate(value) {
        if (value.length > this.length) {
                this.message = new coMessage().getMsg(VMSG_ERR_MAX_LENGTH, [this.length]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMaxByteLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxByteLength' �׸� ���� validator. ���� ������ byte������ ���� ���������� �˻��Ѵ�.
 * @sig    : length
 * @param  : length required ��ȿ�� ���ر���.

 */
function covMaxByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMaxByteLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxByteLengthValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMaxByteLengthValidator_validate(value) {
        if (cfGetByteLength(value) > this.length) {
                this.message = new coMessage().getMsg(VMSG_ERR_MAX_BYTE_LENGTH, [this.length, Math.floor(this.length / 2)]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'number' �׸� ���� validator. ���� ���������� �˻��Ѵ�.

 */
function covNumberValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covNumberValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covNumberValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covNumberValidator_validate(value) {
        if (isNaN(value)) {
                this.message = new coMessage().getMsg(VMSG_ERR_NUMBER);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMinNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minNumber' �׸� ���� validator. ���� ������ �ּҰ��� �Ѵ����� �˻��Ѵ�.
 * @sig    : minNumber
 * @param  : minNumber required ��ȿ�� ���� �ּҰ�.

 */
function covMinNumberValidator(minNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.minNumber = minNumber;

    // method
    this.validate = covMinNumberValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinNumberValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMinNumberValidator_validate(value) {
        // ���ذ��� ���ڰ� �ƴѰ�� ������ true;
        if (isNaN(this.minNumber)) {
                this.validity = true;
                return true;
        }

        if (isNaN(value)) {
                this.message = new coMessage().getMsg(VMSG_ERR_NUMBER);
                return false;
        }

        this.minNumber = Number(this.minNumber);
        value          = Number(value);

        if (value < this.minNumber) {
                this.message = new coMessage().getMsg(VMSG_ERR_MIN_NUM, [this.minNumber]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMaxNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxNumber' �׸� ���� validator. ���� ������ �ִ밪�� ���� �ʴ����� �˻��Ѵ�.
 * @sig    : maxNumber
 * @param  : maxNumber ��ȿ�� ���� �ִ밪.

 */
function covMaxNumberValidator(maxNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.maxNumber = (maxNumber == null) ? "" : maxNumber.trim();

    // method
    this.validate = covMaxNumberValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxNumberValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMaxNumberValidator_validate(value) {
        // ���ذ��� ���ڰ� �ƴѰ�� ������ true;
        if (isNaN(this.maxNumber)) {
                this.validity = true;
                return true;
        }

        if (isNaN(value)) {
                this.message = new coMessage().getMsg(VMSG_ERR_NUMBER);
                return false;
        }

        this.maxNumber = Number(this.maxNumber);
        value          = Number(value);

        if (value > this.maxNumber) {
                this.message = new coMessage().getMsg(VMSG_ERR_MAX_NUM, [this.maxNumber]);
                return false;
        }

        this.validity = true;
        return true;
}


///////////////////////////// covInNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'inNumber' �׸� ���� validator. ���� ������ ���� ���� �������� �˻��Ѵ�.
 * @sig    : inNumber
 * @param  : inNumber required ������ ������ ��Ÿ���� ��Ʈ��. ��) "1~100"

 */
function covInNumberValidator(inNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.minNumber;
    this.maxNumber;

    // method
    this.validate = covInNumberValidator_validate;

    // initialize
        this.minNumber = inNumber.substring(0, inNumber.indexOf("~"));
        this.maxNumber = inNumber.substr(inNumber.indexOf("~") + 1);

        this.minNumber = (this.minNumber == null) ? "" : this.minNumber.trim();
        this.maxNumber = (this.maxNumber == null) ? "" : this.maxNumber.trim();
}

/**
 * @type   : method
 * @access : public
 * @object : covInNumberValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covInNumberValidator_validate(value) {
        // ���ذ��� ���ڰ� �ƴѰ�� ������ true;
        if (isNaN(this.minNumber) || isNaN(this.maxNumber)) {
                this.validity = true;
                return true;
        }

        if (isNaN(value)) {
                this.message = new coMessage().getMsg(VMSG_ERR_NUMBER);
                return false;
        }

        this.minNumber = Number(this.minNumber);
        this.maxNumber = Number(this.maxNumber);
        value     = Number(value);

        if (value < this.minNumber || value > this.maxNumber) {
                this.message = new coMessage().getMsg(VMSG_ERR_IN_NUM, [this.minNumber, this.maxNumber]);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMinDateValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minDate' �׸� ���� validator. ���� ������ ��¥�� �Ѵ����� �˻��Ѵ�.
 *           'YYYYMMDD' �������� ��¥�� ǥ���ؾ� �Ѵ�.
 *             ��) minDate=20020315
 * @sig    : minDate
 * @param  : minDate required ��ȿ�� ���� �ּҰ�.

 */
function covMinDateValidator(minDate) {
    // data;
    this.message = "";
    this.validity = false;
    this.minDate = minDate;

    // method
    this.validate = covMinDateValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinDateValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMinDateValidator_validate(value) {
        if (!(new covDateValidator("YYYYMMDD").validate(value))) {
                this.message = new coMessage().getMsg(VMSG_ERR_DATE);
                return false;
        }

        if (value < this.minDate) {
                var msgParams = new Array(3);
                msgParams[0] = this.minDate.substring(0,4);
                msgParams[1] = this.minDate.substring(4,5) == "0" ? this.minDate.substring(5,6) : this.minDate.substring(4,6);
                msgParams[2] = this.minDate.substring(6,7) == "0" ? this.minDate.substring(7,8) : this.minDate.substring(6,8)
                this.message = new coMessage().getMsg(VMSG_ERR_MIN_DATE, msgParams);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covMaxDateValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxDate' �׸� ���� validator. ���� ������ �ִ밪�� ���� �ʴ����� �˻��Ѵ�.
 * @sig    : maxDate
 * @param  : maxDate required ��ȿ�� �ִ볯¥��.

 */
function covMaxDateValidator(maxDate) {
    // data;
    this.message = "";
    this.validity = false;
    this.maxDate = maxDate;

    // method
    this.validate = covMaxDateValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxDateValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covMaxDateValidator_validate(value) {
        if (!(new covDateValidator("YYYYMMDD").validate(value))) {
                this.message = new coMessage().getMsg(VMSG_ERR_DATE);
                return false;
        }

        if (value > this.maxDate) {
                var msgParams = new Array(3);
                msgParams[0] = this.maxDate.substring(0,4);
                msgParams[1] = this.maxDate.substring(4,5) == "0" ? this.maxDate.substring(5,6) : this.maxDate.substring(4,6);
                msgParams[2] = this.maxDate.substring(6,7) == "0" ? this.maxDate.substring(7,8) : this.maxDate.substring(6,8)
                this.message = new coMessage().getMsg(VMSG_ERR_MAX_DATE, msgParams);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covFormatValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'format' �׸� ���� validator. ���� ����ũ�� ǥ���� ���İ� ��ġ�ϴ��� �˻��Ѵ�.
 *             - format characters
 *               #    : ���ڿ� ����
 *               A, Z : ���� (Z�� ��������)
 *               0, 9 : ���� (9�� ��������)
 * @sig    : format
 * @param  : format required ���� ��Ʈ��.

 */
function covFormatValidator(format) {
    // data;
    this.message  = "";
    this.validity = false;
    this.format   = format

    // method
    this.validate = covFormatValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covFormatValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covFormatValidator_validate(value) {

        if (value.length != this.format.length) {
                this.message = new coMessage().getMsg(VMSG_ERR_FORMAT, this.format);
                return false;
        }

        for (var i = 0; i < this.format.length; i++) {
                switch(this.format.charAt(i)) {
                        case '0' :
                                if (isNaN(value.charAt(i)) || value.charAt(i) == " ") {
                                        this.message = new coMessage().getMsg(VMSG_ERR_FORMAT, [this.format]);
                                        return false;
                                }
                                break;

                        case '9' :
                                if (isNaN(value.charAt(i))) {
                                        if (value.charAt(i) != " ") {
                                                this.message = new coMessage().getMsg(VMSG_ERR_FORMAT, [this.format]);
                                                return false;
                                        }
                                }
                                break;

                        case 'A' : //�������� ���
                                if ( (value.charAt(i) == " ") || !isNaN(value.charAt(i)) ) {
                                        this.message = new coMessage().getMsg(VMSG_ERR_FORMAT, [this.format]);
                                        return false;
                                }
                                else if (((value.charCodeAt(i) >= 65) && (value.charCodeAt(i) <= 90)) || ((value.charCodeAt(i) >= 97) && (value.charCodeAt(i) <= 122))) {
                                }
                                else {
                                        this.message = new coMessage().getMsg(VMSG_ERR_FORMAT, [this.format]);
                                        return false;
                                }
                            
                                break;

                        case 'Z' : // ���� �ѱ� ����
                                if ( (value.charAt(i) != " ") && !isNaN(value.charAt(i)) ) {
                                        this.message = new coMessage().getMsg(VMSG_ERR_FORMAT, [this.format]);
                                        return false;
                                }
                                break;

                        case '#' :
                                break;

                        default :
                                if (value.charAt(i) != this.format.charAt(i)) {
                                        this.message = new coMessage().getMsg(VMSG_ERR_FORMAT, [this.format]);
                                        return false;
                                }
                                break;
                }
        }

        this.validity = true;
        return true;
}

///////////////////////////// covSsnValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'ssn' �׸� ���� validator. �Էµ� �ֹε�Ϲ�ȣ�� ��ȿ���� �˻��Ѵ�.

 */
function covSsnValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covSsnValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covSsnValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : ssn
 * @param  : ssn required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covSsnValidator_validate(ssn) {
        if ( ssn == null || ssn.trim().length != 13 || isNaN(ssn) )  {
                this.message = new coMessage().getMsg(VMSG_ERR_SSN);
                return false;
        }

        var jNum1 = ssn.substr(0, 6);
        var jNum2 = ssn.substr(6);

        /*
          �߸��� ��������� �˻��մϴ�.
          2000�⵵���� ������ ��ȣ�� �ٲ������ �������� 2���� �۴ٸ�
          1900�⵵ ���̵ǰ� 2���� ũ�ٸ� 2000�⵵ �̻���� �˴ϴ�.
          �� 1800�⵵ ���� ��꿡�� �����մϴ�.
        */
        bYear = (jNum2.charAt(0) <= "2") ? "19" : "20";

        // �ֹι�ȣ�� �տ��� 2�ڸ��� �̾ 4�ڸ��� ������ �����մϴ�.
        bYear += jNum1.substr(0, 2);

        // ���� ���մϴ�. 1�� ������ �ڹٽ�ũ��Ʈ������ 1���� 0���� ǥ���ϱ� �����Դϴ�.
        bMonth = jNum1.substr(2, 2) - 1;

        bDate = jNum1.substr(4, 2);

        bSum = new Date(bYear, bMonth, bDate);

        // ��������� Ÿ�缺�� �˻��Ͽ� ������ ������ �����޼����� ��Ÿ��
        if ( bSum.getYear() % 100 != jNum1.substr(0, 2) || bSum.getMonth() != bMonth || bSum.getDate() != bDate) {
                this.message = new coMessage().getMsg(VMSG_ERR_SSN);
                return false;
        }

        total = 0;
        temp = new Array(13);

        for (i = 1; i <= 6; i++) {
                temp[i] = jNum1.charAt(i-1);
        }

        for (i = 7; i <= 13; i++) {
                temp[i] = jNum2.charAt(i-7);
        }

        for (i = 1; i <= 12; i++) {
                k = i + 1;

                // �� ���� ���� ���� �̾Ƴ��ϴ�. ������ ���� 10���� ũ�ų� ���ٸ� ���Ŀ� ���� 2�� �ٽ� �����ϰ� �˴ϴ�.
                if(k >= 10) k = k % 10 + 2;

                // �� �ڸ����� ������ ���Ѱ��� ���� total�� �����ջ��ŵ�ϴ�.
                total = total + (temp[i] * k);
        }

        // ������ ������ ���� last_num�� �����մϴ�.
        last_num = (11- (total % 11)) % 10;

        // laster_num�� �ֹι�ȣ�Ǹ��������� ������ ���� Ʋ���� ������ ��ȯ�մϴ�.
        if(last_num != temp[13]) {
                this.message = new coMessage().getMsg(VMSG_ERR_SSN);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covCsnValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'csn' �׸� ���� validator. �Էµ� ����ڵ�Ϲ�ȣ�� ��ȿ���� �˻��Ѵ�.

 */
function covCsnValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covCsnValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covCsnValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : csn
 * @param  : csn required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covCsnValidator_validate(csn) {
        if ( csn == null || csn.length != 10 || isNaN(csn) )  {
                this.message = new coMessage().getMsg(VMSG_ERR_CSN);
                return false;
        }

        var sum = 0;
        var nam = 0;
        var checkDigit = -1;
        var checkArray = [1,3,7,1,3,7,1,3,5];

        for(i=0 ; i < 9 ; i++)
          sum += csn.charAt(i) * checkArray[i];

        sum = sum + ((csn.charAt(8) * 5 ) / 10);

        nam = Math.floor(sum) % 10;

        checkDigit = ( nam == 0 ) ? 0 : 10 - nam;

        if ( csn.charAt(9) != checkDigit) {
                this.message = new coMessage().getMsg(VMSG_ERR_CSN);
                return false;
        }

        this.validity = true;
        return true;
}

///////////////////////////// covFilterValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : ������ ��Ʈ������ ������� ��� ��ȿ���� ���������� �Ǵ��Ѵ�.
 *           �и��ڴ� ";"�� ����Ѵ�. ";" Ȥ�� ";"���ڰ� �� ��Ʈ���� ���͸��Ϸ� �� ����
 *           "\\;"��� ǥ���ؾ� �Ѵ�.
 * @sig    : fStr
 * @param  : fStr required filter�� ���� ǥ��

 */
function covFilterValidator(fStr) {
    // data;
    this.message = "";
    this.validity = false;
    this.fStrArr = fStr.advancedSplit(";", "i");

    // method
    this.validate = covFilterValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covFilterValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value required ��ȿ�� �˻� ���.
 * @return : boolean. ��ȿ�� ����.
 */
function covFilterValidator_validate(value) {
        for (var i = 0; i < this.fStrArr.length; i++) {
                if (value.indexOf(this.fStrArr[i]) != -1) {
                        this.message = new coMessage().getMsg(VMSG_ERR_FILTER, [this.fStrArr.toString()]);
                        return false;
                }
        }

        this.validity = true;
        return true;
}

///////////////////////////// covDateValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : ���� Date���������� �˻��Ѵ�.
 *
 *            format���� :  YYYY,  -> 4�ڸ� �⵵
 *                          YY,    -> 2�ڸ� �⵵. 2000�� ����.
 *                          MM,    -> 2�ڸ� ������ ��.
 *                          DD,    -> 2�ڸ� ������ ��.
 *                          hh,    -> 2�ڸ� ������ �ð�. 12�� ����
 *                          HH,    -> 2�ڸ� ������ �ð�. 24�� ����
 *                          mm,    -> 2�ڸ� ������ ��.
 *                          ss     -> 2�ڸ� ������ ��.
 *
 *            ��)
 *                'YYYYMMDD' -> '20020328'
 *                'YYYY/MM/DD' -> '2002/03/28'
 *                'Today : YY-MM-DD' -> 'Today : 02-03-28'
 *
 *            ����)
 *                  format���ڰ� �ߺ��ؼ� �������� ó�� ���� ���ڿ� ���ؼ���
 *                  format���ڷ� �νĵȴ�. YYYY�� YY, hh�� HH �� �ߺ����� ����.
 *                  ��¥�� ��,���� ������ ���� ��Ȯ�� üũ�ϰ� ���� ��, ���� ���ٸ�
 *                  1 ~ 31 ���������� üũ�Ѵ�.
 *
 * @sig    : dateExp
 * @param  : dateExp required Date Format expression.
 *             ��) 2002�� 3�� 12�� -> "YYYY-MM-DD"(Date Format Expression) -> "2002-03-12"

 */
function covDateValidator(dateExp) {
    // data;
    this.message = "";
    this.validity = false;
    this.dateExp = dateExp;
    this.year = null;
    this.month = null;

    // method
    this.validate = covDateValidator_validate;
    this.checkLength = covDateValidator_checkLength;
    this.checkYear = covDateValidator_checkYear;
    this.checkMonth = covDateValidator_checkMonth;
    this.checkDay = covDateValidator_checkDay;
    this.checkHour = covDateValidator_checkHour;
    this.checkMin = covDateValidator_checkMin;
    this.checkSec = covDateValidator_checkSec;
    this.checkRest = covDateValidator_checkRest;
}

/**
 * @type   : method
 * @access : public
 * @object : covDateValidator
 * @desc   : validation�� �����Ѵ�.
 * @sig    : value
 * @param  : value   required �˻����� �Ǵ� Date ��Ʈ�� ��.
 * @return : boolean - ��ȿ�� ����
 */
function covDateValidator_validate(value) {
        this.value = value;

        if ( this.checkLength(value) &&
                 this.checkYear(value) &&
                 this.checkMonth(value) &&
                 this.checkDay(value) &&
                 this.checkHour(value) &&
                 this.checkMin(value) &&
                 this.checkSec(value) &&
                 this.checkRest(value)
           ) {
                this.validity = true;
                return true;
        } else {
                this.validity = false;
                return false;
        }
}

function covDateValidator_checkLength() {
        if (this.value.length == this.dateExp.length) {
                return true;
        } else {
                this.message = new coMessage().getMsg(VMSG_ERR_LENGTH, [this.dateExp.length]);
                return false;
        }
}

function covDateValidator_checkYear() {
        var index = -1;

        if ( (index = this.dateExp.indexOf("YYYY")) != -1 ) {
                subValue = this.value.substr(index, 4);
                if ( !isNaN(subValue) &&
                         (subValue > 0)
                   ) {
                        this.dateExp = this.dateExp.cut(index, 4);
                        this.value = this.value.cut(index, 4);
                        this.year = subValue;
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_YEAR);
                        return false;
                }
        }

        if ( (index = this.dateExp.indexOf("YY")) != -1 ) {
                subValue = "20" + this.value.substr(index, 2);
                if ( !isNaN(subValue) &&
                         (subValue > 0)
                   ) {
                        this.dateExp = this.dateExp.cut(index, 2);
                        this.value = this.value.cut(index, 2);
                        this.year = subValue;
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_YEAR);
                        return false;
                }
        }

        return true;
}

function covDateValidator_checkMonth() {
        var index = -1;

        if ( (index = this.dateExp.indexOf("MM")) != -1 ) {
                subValue = this.value.substr(index, 2);
                if ( !isNaN(subValue) &&
                     (subValue > 0) &&
                     (subValue <= 12)
                   ) {
                        this.dateExp = this.dateExp.cut(index, 2);
                        this.value = this.value.cut(index, 2);
                        this.month = subValue;
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_MONTH);
                        return false;
                }
        }

        return true;
}

function covDateValidator_checkDay() {
        var index = -1;
        var days = 0;

        if ( (index = this.dateExp.indexOf("DD")) != -1 ) {
                if ( (this.year != null) && (this.month != null) ) {
                        days = (this.month != 2) ? GLB_DAYS_IN_MONTH[this.month-1] : (( (this.year % 4) == 0 && (this.year % 100) != 0 || (this.year % 400) == 0 ) ? 29 : 28 );
                } else {
                        days = 31;
                }

                subValue = this.value.substr(index, 2);
                if ( (!isNaN(subValue)) &&
                     (subValue > 0) &&
                     (subValue <= days)
                   ) {
                        this.dateExp = this.dateExp.cut(index, 2);
                        this.value = this.value.cut(index, 2);
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_DAY);
                        return false;
                }
        }

        return true;
}

function covDateValidator_checkHour() {
        var index = -1;

        if ( (index = this.dateExp.indexOf("hh")) != -1 ) {
                subValue = this.value.substr(index, 2);
                if ( !isNaN(subValue) &&
                     (subValue >= 0) &&
                     (subValue <= 12)
                   ) {
                        this.dateExp = this.dateExp.cut(index, 2);
                        this.value = this.value.cut(index, 2);
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_HOUR);
                        return false;
                }
        }

        if ( (index = this.dateExp.indexOf("HH")) != -1 ) {
                subValue = this.value.substr(index, 2);
                if ( !isNaN(subValue) &&
                     (subValue >= 0) &&
                     (subValue < 24)
                   ) {
                        this.dateExp = this.dateExp.cut(index, 2);
                        this.value = this.value.cut(index, 2);
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_HOUR);
                        return false;
                }
        }

        return true;
}

function covDateValidator_checkMin() {
        var index = -1;

        if ( (index = this.dateExp.indexOf("mm")) != -1 ) {
                subValue = this.value.substr(index, 2);
                if ( !isNaN(subValue) &&
                     (subValue >= 0) &&
                     (subValue < 60 )
                   ) {
                        this.dateExp = this.dateExp.cut(index, 2);
                        this.value = this.value.cut(index, 2);
                        this.month = subValue;
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_MINUTE);
                        return false;
                }
        }

        return true;
}

function covDateValidator_checkSec() {
        var index = -1;

        if ( (index = this.dateExp.indexOf("ss")) != -1 ) {
                subValue = this.value.substr(index, 2);
                if ( (!isNaN(subValue)) &&
                     (subValue >= 0) &&
                     (subValue < 60 )
                   ) {
                        this.dateExp = this.dateExp.cut(index, 2);
                        this.value = this.value.cut(index, 2);
                        this.month = subValue;
                        return true;
                } else {
                        this.message = new coMessage().getMsg(VMSG_ERR_SECOND);
                        return false;
                }
        }

        return true;
}

function covDateValidator_checkRest() {
        if (this.value == this.dateExp) {
                return true;
        }

        return false;
}


///////////////////////////// covNullValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : ������ valid�� ����� ���� validator.

 */
function covNullValidator() {
    // data;
    this.message = "";
    this.validity = true;

    // method
    this.validate = covNullValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covNullValidator
 * @desc   : validation�� �����Ѵ�.
 * @return : boolean - ������ true.
 */
function covNullValidator_validate() {
        this.message = new coMessage().getMsg(VMSG_VALID);
        return true;
}



