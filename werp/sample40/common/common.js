/**
===============================================================================
주  시 스 템 : 공통 개발
서브  시스템 : 없음
프로그램  ID : Common.js
프로그램  명 : 공통 기능 Javascript
프로그램개요 : 공통적으로 사용되는 Javascript를 정의한다
작   성   자 :
작   성   일 : 2002.11.10
===============================================================================
*/


/**
 * 입력값이 숫자인지를 확인한다
 * param : sVal 입력스트링
 * return : Boolean True이면 숫자값
 */
function isNumber(sVal)
{
  if(sVal.length < 1)
  {
    return false;
  }

  for(i=0; i<sVal.length; i++)
  {
    iBit = parseInt(sVal.substring(i,i+1));     //문자(Char)를 숫자로 변경
    if(('0' < iBit) || ('9' > iBit))
    {
      //alert(i+':'+iBit+':'+'Mun');
    }
    else
    {
      //alert((i+1)+'번째 문자는 숫자가 아닙니다.');
      return false;
    }
  }
  return true;
}

/**
 * sVal 값이 숫자인지를 확인한다.(' '까지 괜찮음)
 * param : sVal 입력스트링
 * return : Boolean  True이면 숫자값
 */
function isNumberSpace(sVal)
{
  if(sVal.length > 0)
  {
    for(var i=0;i<sVal.length;i++)
    {
      sBitData = sVal.substring(i,i+1);     //문자열의 문자(char)를 넣는다
      if(sBitData == ' ')
      {
      }
      else
      {
        iBit = parseInt(sVal.substring(i,i+1)); //문자(char)를 숫자로
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
 * sVal 값이 숫자인지를 확인한다.('.'까지 괜찮음), 마이너스 값도 허용
 * param : sVal 입력스트링
 * return : Boolean  True이면 숫자값
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
    sBitData = sVal.substring(i,i+1);       //문자열의 문자(char)를 넣는다

        if( i == 0 ) {
                if( sBitData == '-' ) { // 마이너스값 허용
                } else {
                        if( sBitData >= '0' && sBitData <= '9' ) {

                        } else {
                                return false;
                        }
                }

        } else {

                if(sBitData == '.'){
                } else {
                  iBit = parseInt(sVal.substring(i,i+1));   //문자(Char)를 숫자로

                  if(('0' < iBit) || ('9' > iBit) || ('.' == sBitData)){
                  } else {
                        return false;
                  }
                } //end of if-else

        }//추가

  } //end of for

  return true;
}



/**
 * 첫번째 Zero 값을 자른다.
 * param : sVal 입력스트링
 * return : String  Zero값을 자른 값
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
 * 길이가1인 경우 앞에 "0"을 붙인다.
 * param : sVal 입력스트링
 * return : String  "0"값을 포함하는 값
 */
function addZero(sVal)
{
  var iLen = sVal.length;   //인수값의 길이를 구한다.
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
 * 날짜 여부를 확인한다.(월일 or 년월 or 년월일)
 * param : sYmd 입력스트링(MMDD or YYYYMM or YYYYMMDD)
 * return : Boolean true이면 날짜 범위임
 */
function isDate(sYmd)
{
  var bResult;  // 결과값을 담는 변수(Boolean)
  switch (sYmd.length)
  {
    case 4://월일
      bResult = isDateMD(sYmd);
      break;
    case 6://년월
      bResult =  isDateYM(sYmd);
      break;
    case 8://년월일
      bResult =  isDateYMD(sYmd);
      break;
    default:
      bResult = false;  // 날짜 값이 아님
      break;
  }
  return bResult;
}

/**
 * 날짜 여부를 확인한다.(년월일)
 * param : sYmd 입력스트링(YYYYMMDD)
 * return : Boolean true이면 날짜 범위임
 */
function isDateYMD(sYmd)
{
  // 숫자 확인
  if(!isNumber(sYmd))
  {
    alert('날짜는 숫자만 입력하십시오');
    return false;
  }

  // 길이 확인
  if(sYmd.length != 8)
  {
    alert('일자를 모두 입력하십시오');
    return false;
  }
  var iYear = parseInt(sYmd.substring(0,4));  // 년도 입력(YYYY)
  var iMonth = parseInt(trimZero(sYmd.substring(4,6)));   //월입력(MM)
  var iDay = parseInt(trimZero(sYmd.substring(6,8)));     //일자입력(DD)

  if((iMonth < 1) ||(iMonth >12))
  {
    alert(iMonth+'월의 입력이 잘못 되었습니다.');
        return false;
  }

  //각 달의 총 날수를 구한다
  var iLastDay = lastDay(sYmd.substring(0,6));  // 해당월의 마지말날 계산

  if((iDay < 1) || (iDay > iLastDay))
  {
    alert(iMonth+'월의 일자는 1 - '+ iLastDay +'까지입니다.');
    return false;
  }
  return true;
}


/**
 * 날짜 여부를 확인한다.(월일)
 * param : sMD 입력스트링(MMDD)
 * return : Boolean true이면 날짜 범위임
 */
function isDateMD(sMD)
{
  // 숫자 확인
  if(!isNumber(sMD))
  {
    alert('숫자만 입력하십시오');
    return false;
  }

  // 길이 확인
  if(sMD.length != 4)
  {
    alert('일자를 모두 입력하십시오');
    return false;
  }

  var iMonth = parseInt(trimZero(sMD.substring(0,2)));  //해당월을 숫자값으로
  var iDay = parseInt(trimZero(sMD.substring(2,4)));    //해당일을 숫자값으로

  if((iMonth < 1) ||(iMonth >12))
  {
    alert(iMonth+'월의 입력이 잘못 되었습니다.');
    return false;
  }

  //각 달의 총 날수를 구한다
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
    alert(iMonth+'월의 일자는 1 - '+iLastDay+'까지입니다.');
    return false;
  }
  return true;
}


/**
 * 날짜 여부를 확인한다.(년월)
 * param : sYM 입력스트링(YYYYMM)
 * return : Boolean true이면 날짜 범위임
 */
function isDateYM(sYM)
{
  // 숫자 확인
  if(!isNumber(sYM))
  {
    alert('날짜는 숫자만 입력하십시오');
    return false;
  }

  // 길이 확인
  if(sYM.length != 6)
  {
    alert('일자를 모두 입력하십시오');
    return false;
  }

  var iYear = parseInt(sYM.substring(0,4)); //년도값을 숫자로
  var iMonth = parseInt(trimZero(sYM.substring(4,6)));  //월을 숫자로

  if((iMonth < 1) ||(iMonth >12))
  {
    alert(iMonth+'월의 입력이 잘못 되었습니다.');
    return false;
  }
  return true;
}

/**
 * 년월을 입력받아 마지막 일를 반환한다(년월)
 * param : sYM 입력스트링(YYYYMM)
 * return : String 해당월의 마지막날
 */
function lastDay(sYM)
{
  if(sYM.length != 6)
  {
    alert("정확한 년월을 입력하십시요.");
    return;
  }

  if(!isDateYM(sYM))
  {
     return;
  }

  daysArray = new makeArray(12);    // 배열을 생성한다.

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
 * 시간 값을 확인한다.
 * param : sHm 입력스트링(HHMM)
 * return : Boolean true이면 시간 범위내
 */
function isTime(sHm)
{

  // 숫자 확인
  if(!isNumber(sHm))
  {
    alert('숫자만 입력하십시오');
    return false;
  }

  // 길이 확인
  if(sHm.length != 4)
  {
    alert('4자리를 모두 입력하십시오(HHMM)');
    return false;
  }

  var iHH = parseInt(trimZero(sHm.substring(0,2))); //시간을 숫자로
  var iMM = parseInt(trimZero(sHm.substring(2,4))); //분을 숫자로

  if((iHH < 0) ||(iHH >23))
  {
    alert('시간 입력이 잘못 되었습니다.');
    return false;
  }

  if((iMM < 0) ||(iMM >59))
  {
    alert('분 입력이 잘못 되었습니다.');
    return false;
  }
  return true;
}


/**
 * 대소문자를 포함한 영문자인지 확인한다.
 * param : sVal 입력문자열
 * return : Boolean true이면 알파벳
 */
function isAlpha(sVal)
{
  // Alphabet 값
  var sAlphabet="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  var iLen=sVal.length;   //입력값의 길이

  for(i=0;i<iLen;i++)
  {
    if(sAlphabet.indexOf(sVal.substring(i,i+1))<0)
    {
      alert("허용된 문자가 아닙니다.\n영문으로 입력해 주십시오");
      return false;
    }
  }
  return true;
}

/**
 * 영문자와 숫자 구성된 문자열인지 확인
 * param : sVal 입력문자열
 * return : Boolean true이면 영문자,숫자로 구성된 문자열
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
 * 문자열의 길이를 return (한글:2자)
 * param : sVal 입력문자열
 * return : int 입력문자열의 길이
 */
function strLength(sVal)
{
  var sBit = '';    // 문자열의 문자(Char)
  var iLen = 0; //문자열 길이

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
 * 한글이지 여부 체크
 * param : sVal 입력문자열
 * return : Boolean true이면 한글
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
 * 주민등록 여부를 확인한다.
 * param : sID 입력문자열(주민번호 13자리)
 * return : Boolean true이면 적합한 주민번호
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
 * 입력받은 날짜로부터 몇일 후의 날짜를 반환하기
 * param : ObjDate객체, 일수, 결과Data객체
 * return :
 */
function calcDate(objDate,iDay,objResultDate)
{
  daysArray = new makeArray(12); //월별 공간을 생성

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
 * 숫자 0으로 초기화 된 1차원 배열을 생성한다.
 * param : iSize 배열 크기
 * return : this 배열
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
 * 사업자 번호가 정확한지 확인한다.
 * param : iSaupNo 사업자번호
 * return : Boolean true이면 검증된 사업자번호
 */
function isSaupNO(iSaupNo)
{
  if (!isNumber(iSaupNo))
  {
    alert("사업자 번호는 반드시 숫자로 구성되어야 합니다.");
    return false;
  }
  else if (iSaupNo.length != 10)
  {
    alert("사업자 번호는 10자리 입니다.");
    return false;
  }

  var arr_saup = iSaupNo.split("");
  var wtArray = new Array(1,3,7,1,3,7,1,3,5);
  var iSaup_9 = 0;
  var iSum_saup = 0;
  var iCheck_digit = 0;

  //1~8자리까지 가중치를 곱하여 모두 더한다.
  for (i = 0; i < 8; i++)
  {
      iSum_saup +=  eval(arr_saup[i]) * eval(wtArray[i]);
  }

  iSum_saup = iSum_saup % 10;
  //9번째 자리 숫자에 5를 곱한다.
  iSaup_9 = eval(arr_saup[8]) * 5

  //5를 곱한 값을 10으로 나누어  몫과 나머지를 각각 1~8합계에 더한다.
  iSum_saup +=  Math.floor(iSaup_9 / 10) + iSaup_9 % 10;

  //결과 값을 10에서 뺀다.
  iCheck_digit = 10 - (iSum_saup % 10);

  //계산 값을 10으로 나눈 나머지를 구한다. (Check Digit)
  iCheck_digit = iCheck_digit % 10;

  if (iCheck_digit != arr_saup[9])
  {
    alert("사업자 번호가 정확하지 않습니다.\n 다시 확인하신후 입력하십시오.");
    return false;
  }
  return true;
}


/**
 * 법인 번호가 정확한지 확인한다.
 * param : sRegNo 법인번호
 * return : Boolean true이면 검증된 법인번호
 */
function isRegNo(sRegNo)
{
  if (!isNumber(sRegNo))
  {
    alert("법인 번호는 반드시 숫자로 구성되어야 합니다.");
    return false;
  }
  else if (sRegNo.length != 13)
  {
    alert("법인 번호는 13자리 입니다.");
    return false;
  }

  var arr_regno = sRegNo.split("");
  var arr_wt = new Array(1,2,1,2,1,2,1,2,1,2,1,2);
  var iSum_regno = 0;
  var iCheck_digit = 0;

  //1~12자리까지 가중치를 곱하여 모두 더한다.
  for (i = 0; i < 12; i++)
  {
      iSum_regno +=  eval(arr_regno[i]) * eval(arr_wt[i]);
  }

  //합계를 10으로 나눈 나머지를 10에서 뺀다.
  iCheck_digit = 10 - (iSum_regno % 10);

  //계산 값을 10으로 나눈 나머지를 구한다. (Check Digit)
  iCheck_digit = iCheck_digit % 10;

  if (iCheck_digit != arr_regno[12])
  {
      alert("법인 번호가 정확하지 않습니다.\n 다시 확인하신후 입력하십시오.");
      return false;
  }

  return true;
}

/**
 * 숫자 분리자(,)(.)가 있는 숫자이거나 일반숫자형태인지 검사한다.
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
 * 콤마 숫자 표현. 중간의 숫자 이외의 표현은 제거함.
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
    alert("숫자만을 입력하세요.");
    return;
  }

  if (! isMoneyNumber(value))
  {
    alert("숫자만을 입력하세요.");
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
 * 부호가 있는 콤마 숫자 표현. 중간의 숫자 이외의 표현은 제거함
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
 * 콤마를 제거한 숫자형태 문자열로 반환
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
 * 콤마를 제거한 부호가 있는 숫자형태 문자열로 반환
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
 * 조회조건 시작일과 종료일 입력 유효성 확인 - 컨드롤 이용
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
    alert("마지막일이 시작일보다 작습니다");
    objFrom.focus();
    return false;
  }
  return true;
}

/**
 * 앞뒤 공백을 제거한다.
 * param : sVal
 * return : String
 */
function Trim(sVal)
{
  return(LTrim(RTrim(sVal)));
}

/**
 * 앞 공백을 제거한다.
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
 * 뒤 공백을 제거한다.
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
 * 공백만 존재하거나 아무것도 없는지 확인한다.
 * param : sVal
 * return : boolean 공백이나 Empty이다
 */
function isEmpty(sVal){
  if (Trim(sVal) == '')
  {
    return true;
  }
  return false;
}

/**
 * 현재 컨트롤과 MaxLength 받아서 MaxLength 되면 다음 컨트롤로 이동
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
 * 현재 컨트롤과 MaxLength 받아서 MaxLength 되면 다음 컨트롤로 이동(선택)
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
 * 현재 컨트롤과 MaxLength 받아서 MaxLength 되거나 Enter키를 눌었을때  다음 컨트롤로 이동
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
 * 현재 컨트롤과 MaxLength 받아서 MaxLength  되거나 Enter키를 눌었을때 다음 컨트롤로 이동(선택)
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
 * 조회년월의 validation을 check한다(argument:control)
 * param : objFromY,objFormM,objToY,objToM,msg
 * return : boolean
 */
function checkPeriodYM(objFromY,objFromM,objToY,objToM,msg)
{
  if (typeof msg != "string")
  {
    msg = "조회";
  }

  var fYYYY = Trim(objFromY.value);
  var fMM   = Trim(objFromM.value);
  var tYYYY = Trim(objToY.value);
  var tMM   = Trim(objToM.value);

  if(fYYYY.length<1||fYYYY.length!=4)
  {
    alert(msg + " 시작년은 4자리입니다!");
    objFromY.focus();
    return false;
  }
  if(fMM.length<1||fMM.length!=2)
  {
    alert(msg + " 시작월은 2자리입니다!");
    objFromM.focus();
    return false;
  }
  if(tYYYY.length<1||tYYYY.length!=4)
  {
    alert(msg + " 종료년은 4자리입니다!");
    objToY.focus();
    return false;
  }
  if(tMM.length<1||tMM.length!=2)
  {
    alert(msg + " 종료월은 2자리입니다!");
    objToM.focus();
    return false;
  }
  if(!isNumber(fYYYY))
  {
    alert("년도는 숫자만 입력하십시요!");
    objFromY.focus();
    return false;
  }
  if(!isNumber(fMM))
  {
    alert("월은 숫자만 입력하십시요!");
    objFromM.focus();
    return false;
  }
  if(!isNumber(tYYYY))
  {
    alert("년도는 숫자만 입력하십시요!");
    objToY.focus();
    return false;
  }
  if(!isNumber(tMM))
  {
    alert("월은 숫자만 입력하십시요!");
    objToM.focus();
    return false;
  }
  if(fYYYY>tYYYY)
  {
    alert("시작년이 종료년보다 큽니다!");
    objFromY.focus();
    return false;
  }
  if((fYYYY==tYYYY)&&(fMM>tMM))
  {
    alert("시작월이 종료월보다 큽니다!");
    objFromM.focus();
    return false;
  }
  if((fMM == '00') ||(fMM >12))
  {
    alert(fMM+'월의 입력이 잘못 되었습니다!');
    objFromM.focus();
    return false;
  }
  if(( tMM== '00') ||(tMM >12))
  {
    alert(tMM+'월의 입력이 잘못 되었습니다!');
    objToM.focus();
    return false;
  }
  return true;
}

/**
 * 조회년월 validation checking (argument:control).
 * param : objYear,objMonth
 * return :
 */
function checkYM(objYear,objMonth)
{
  var sYear  = Trim(objYear.value);
  var sMonth = Trim(objMonth.value);

  if(sYear.length<1||sYear.length!=4)
  {
    alert("조회년은 4자리입니다!");
    objYear.focus();
    return false;
  }
  if(sMonth.length<1||sMonth.length!=2)
  {
    alert("조회월은 2자리입니다!");
    objMonth.focus();
    return false;
  }

  if(!isNumber(sYear))
  {
    alert("년도는 숫자만 입력하십시요!");
    objYear.focus();
    return false;
  }
  if(!isNumber(sMonth))
  {
    alert("월은 숫자만 입력하십시요!");
    objMonth.focus();
    return false;
  }

  if((sMonth == '00') ||(sMonth >12))
  {
    alert(sMonth+'월의 입력이 잘못 되었습니다!');
    objMonth.focus();
    return false;
  }
  return true;
}

/**
 * 조회년월 validation checking (argument:control).
 * param : objFromY,objFormM,objFromD,objToY,objToM,objToD,msg
 * return : boolean
 */
function checkYMD(objFromY,objFromM,objFromD,objToY,objToM,objToD,msg)
{
  if (typeof msg != "string")
  {
    msg = "조회";
  }

  if(!checkPeriodYM(objFromY,objFromM,objToY,objToM,msg))
  {
    return false;
  }

  var fDD = Trim(objFromD.value);
  var tDD = Trim(objToD.value);

  if(fDD.length<1||fDD.length!=2)
  {
    alert(msg + " 시작일은 2자리입니다!");
    objFromD.focus();
    return false;
  }
  if(tDD.length<1||tDD.length!=2)
  {
    alert(msg + " 종료일은 2자리입니다!");
    objToD.focus();
    return false;
  }
  if(!isNumber(fDD))
  {
    alert("날짜는 숫자만 입력하십시요!");
    objFromD.focus();
    return false;
  }
  if(!isNumber(tDD))
  {
    alert("날짜는 숫자만 입력하십시요!");
    objToD.focus();
    return false;
  }

  var fDays = lastDay(objFromY.value + "" + objFromM.value);
  var tDays = lastDay(objToY.value + "" + objToM.value);

  if(fDD> fDays)
  {
    alert("시작일의 입력이 잘못되었습니다!");
    objFromD.focus();
    return false;
  }
  if(tDD> tDays)
  {
    alert("종료일의 입력이 잘못되었습니다!");
    objToD.focus();
    return false;
  }
  if((objFromY.value==objToY.value)&&(objFromM.value==objToM.value)&&(fDD>tDD))
  {
    alert("시작일이 종료일보다 큽니다!");
    objFromD.focus();
    return false;
  }
  return true;
}


/**
 * 년월일 validation checking
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
    alert("년도는 4자리입니다!");
    objYear.focus();
    return false;
  }
  if(sMonth.length<1||sMonth.length!=2)
  {
    alert("월은 2자리입니다!");
    objMonth.focus();
    return false;
  }
  if(sDay.length<1||sDay.length!=2)
  {
    alert("날짜는 2자리입니다!");
    objDay.focus();
    return false;
  }
  if(!isNumber(sYear))
  {
    alert("년도는 숫자만 입력하십시요!");
    objYear.focus();
    return false;
  }
  if(!isNumber(sMonth))
  {
    alert("월은 숫자만 입력하십시요!");
    objMonth.focus();
    return false;
  }
  if(!isNumber(sDay))
  {
    alert("날짜는 숫자만 입력하십시요!");
    objDay.focus();
    return false;
  }

  var days = lastDay(sYear + sMonth);

  if((sMonth == '00')||(sMonth >12))
  {
    alert(objMonth+'월의 입력이 잘못 되었습니다!');
    objMonth.focus();
    return false;
  }

  if((sDay > days)||(sDay == '00'))
  {
    alert(sDay+"일의 입력이 잘못되었습니다!");
    objDay.focus();
    return false;
  }
  return true;
}

/**
 * 주어진 년월의 몇개월 전후의 년월을 구한다.
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
 * 조회년월 validation checking
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
 * 쿠키 설정.
 * param : name, value
 */
function setCookie(name, value)
{
  var path = "/";
  var expires = 1; 	//하루.
  var domain = "";

  var today = new Date();
  today.setDate(today.getDate() + expires );

  document.cookie = name + "=" + escape(value)+ "; path=" + path ;
}

/**
 * 팝업창 닫기
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
 * 쿠키정보 가져오기
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
 * 위치지정(가로)
 * param : width
 */
function positionWidth(width)
{
  var x = (screen.width - width)/2;
  return x
}

/**
 * 위치지정(세로)
 * param : height
 */
function positionHeight(height)
{
  var y = (screen.height - height)/2;
  return y
}


/**
  * 콤마를 추가한 숫자형태 문자열로 반환
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
 * @desc   : 저장할지의 여부를 확인받는 공통 메세지
 */
var MSG_CONFIRM_SAVE = "저장하시겠습니까?";

/**
 * @type   : var
 * @access : public
 * @desc   : 저장완료를 알리는 공통 메세지
 */
var MSG_COMPLETE_SAVE = "성공적으로 저장하였습니다.";

/**
 * @type   : var
 * @access : public
 * @desc   : 등록할지의 여부를 확인받는 공통 메세지
 */
var MSG_CONFIRM_REGIST = "등록하시겠습니까?";

/**
 * @type   : var
 * @access : public
 * @desc   : 등록완료를 알리는 공통 메세지
 */
var MSG_COMPLETE_REGIST = "성공적으로 등록하였습니다.";

/**
 * @type   : var
 * @access : public
 * @desc   : 수정할지의 여부를 확인받는 공통 메세지
 */
var MSG_CONFIRM_UPDATE = "수정하시겠습니까?";

/**
 * @type   : var
 * @access : public
 * @desc   : 수정완료를 알리는 공통 메세지
 */
var MSG_COMPLETE_UPDATE = "성공적으로 수정하였습니다.";

/**
 * @type   : var
 * @access : public
 * @desc   : 삭제할지의 여부를 확인받는 공통 메세지
 */
var MSG_CONFIRM_DELETE = "삭제하시겠습니까?";

/**
 * @type   : var
 * @access : public
 * @desc   : 삭제완료를 알리는 공통 메세지
 */
var MSG_COMPLETE_DELETE = "성공적으로 삭제하였습니다.";

/**
 * @type   : var
 * @access : public
 * @desc   : 변경사항이 없음을 알리는 공통 메세지.
 */
var MSG_NOTIFY_NOT_UPDATED = "변경된 사항이 없습니다.";

/**
 * @type   : var
 * @access : public
 * @desc   : 변경사항이 반영되지 않았음을 알리는 확인 메세지.
 */
var MSG_CONFIRM_CONTINUE_WITHOUT_APPLY_CHANGE = "변경사항이 반영되지 않았습니다. 계속 하시겠습니까?";

/**
 * @type   : var
 * @access : public
 * @desc   : 검색 조건을 입력하지 않았음을 알리는 확인 메세지.
 */
var MSG_ERR_SEARCH = "검색 조건을 입력하세요.";

var MSG_PARAM_TEST        = "전달된 3개의 파라미터는 @, @, @ 입니다.";

// validation message
var VMSG_VALID            = "유효합니다.";
var VMSG_ITEMNAME         = "@ 은(는) ";
var VMSG_GRID             = "@의 @번째 데이터에서 ";
var VMSG_ERR_DUPLICATE    = "중복될 수 없습니다.";
var VMSG_ERR_LENGTH       = "@자리수만큼 입력하십시오.";
var VMSG_ERR_BYTE_LENGTH  = "@자리수만큼 입력하십시오. (한글은 @자리수)";
var VMSG_ERR_MIN_LENGTH   = "@자 이상으로 입력하십시오.";
var VMSG_ERR_MIN_BYTE_LENGTH   = "@자 이상으로 입력하십시오. (한글은 @자 이상)";
var VMSG_ERR_MAX_LENGTH   = "@자 이하로 입력하십시오.";
var VMSG_ERR_MAX_BYTE_LENGTH   = "@자 이하로 입력하십시오. (한글은 @자 이하)";
var VMSG_ERR_MIN_NUM      = "@ 이상으로 입력하십시오.";
var VMSG_ERR_MAX_NUM      = "@ 이하로 입력하십시오.";
var VMSG_ERR_IN_NUM       = "@부터 @사이로 입력하십시오.";
var VMSG_ERR_NUMBER       = "숫자만을 입력하십시오.";
var VMSG_ERR_ALPHA        = "문자만을 입력하십시오.";
var VMSG_ERR_REQUIRED     = "필수 입력 항목입니다.";
var VMSG_ERR_SSN          = "유효한 주민등록번호가 아닙니다.";
var VMSG_ERR_CSN          = "유효한 사업자등록번호가 아닙니다.";
var VMSG_ERR_FILTER       = "다음 문자가 올 수 없습니다.\n@";
var VMSG_ERR_DATE         = "유효한 날짜가 아닙니다.";
var VMSG_ERR_YEAR         = "년도가 잘못되었습니다.";
var VMSG_ERR_MONTH        = "월이 잘못되었습니다.";
var VMSG_ERR_DAY          = "일이 잘못되었습니다.";
var VMSG_ERR_HOUR         = "시가 잘못되었습니다.";
var VMSG_ERR_MINUTE       = "분이 잘못되었습니다.";
var VMSG_ERR_SECOND       = "초가 잘못되었습니다.";
var VMSG_ERR_MIN_DATE     = "@년 @월 @일 이후이어야 합니다.";
var VMSG_ERR_MAX_DATE     = "@년 @월 @일 이전이어야 합니다.";
var VMSG_ERR_FORMAT       = "'@' 형식이어야 합니다.\n" +
                            "  - # : 문자 혹은 숫자\n" +
                            "  - A : 영문자\n" +
                            "  - Z : 문자(Z는 공백, 한글포함)\n" +                            
                            "  - 0, 9 : 숫자(9는 공백포함)";

var PMSG_ERR_PAGE         = "페이지 설정이 잘못되었습니다.";
var PMSG_ERR_MAXPAGE      = "@페이지 이상은 출력 할수 없습니다";

//----------------------------- 2. 공통 스크립트 영역입니다. -----------------------------//

// Global 변수선언
var GLB_MONTH_IN_YEAR   = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var GLB_DAY_IN_WEEK     = ["Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday"];
var GLB_DAYS_IN_MONTH   = [31,28,31,30,31,30,31,31,30,31,30,31];
var GLB_URL_COMMON_PAGE = "./common/";  // common 디렉토리의 URL

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 simpleReplace 메소드를 추가한다. simpleReplace 메소드는
 *           스트링 내에 있는 특정 스트링을 다른 스트링으로 모두 변환한다. String 객체의 replace 메소드와 동일한
 *           기능을 하지만 간단한 스트링의 치환시에 보다 유용하게 사용할 수 있다.
 * <pre>
 *     var str = "abcde"
 *     str = str.simpleReplace("cd", "xx");
 * </pre>
 * 위의 예에서 str는 "abxxe"가 된다.
 * @sig    : oldStr, newStr
 * @param  : oldStr required 바뀌어야 될 기존의 스트링
 * @param  : newStr required 바뀌어질 새로운 스트링
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
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 trim 메소드를 추가한다. trim 메소드는 스트링의 앞과 뒤에
 *           있는 white space 를 제거한다.
 * <pre>
 *     var str = " abcde "
 *     str = str.trim();
 * </pre>
 * 위의 예에서 str는 "abede"가 된다.
 * @return : trimed String.
 */
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 trimAll 메소드를 추가한다. trim 메소드는 스트링 내에
 *           있는 white space 를 모두 제거한다.
 * <pre>
 *     var str = " abc de "
 *     str = str.trimAll();
 * </pre>
 * 위의 예에서 str는 "abcde"가 된다.
 * @return : trimed String.
 */
String.prototype.trimAll = function() {
    return this.replace(/\s*/g, "");
}

// alert(" a b  d ".trimAll());

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 cut 메소드를 추가한다. cut 메소드는 스트링의 특정 영역을
 *           잘라낸다.
 * <pre>
 *     var str = "abcde"
 *     str = str.cut(2, 2);
 * </pre>
 * 위의 예에서 str는 "abe"가 된다.
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
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 insert 메소드를 추가한다. insert 메소드는 스트링의 특정 영역에
 *           주어진 스트링을 삽입한다.
 * <pre>
 *     var str = "abcde"
 *     str = str.insert(3, "xyz");
 * </pre>
 * 위의 예에서 str는 "abcxyzde"가 된다.
 * @sig    : start, length
 * @param  : index required 삽입할 위치. 해당 스트링의 index 바로 앞에 삽입된다. index는 0부터 시작.
 * @param  : str   required 삽입할 스트링.
 * @return : inserted String.
 */
String.prototype.insert = function(index, str) {
    return this.substring(0, index) + str + this.substr(index);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : String.split() 와 같지만 여러가지 옵션을 줄 수 있다.
 * <pre>
 *     option list
 *
 *     - i : ignored split
 *         앞에 "\" 가 붙은 문자는 deliminate시키지 않는다. ('\' 문자를 string으로 표현할 때는 "\\" 로 해야함)
 *             var str = "abc,de\\,fg"
 *             var strArr = str.advancedSplit(",", "i");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 *
 *     - t : trimed split
 *         split 후에 splited string 들을 trim 시킨다.
 *             var str = "abc,  de,fg"
 *             var strArr = str.advancedSplit(",", "t");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de", strArr[2]는 "fg"가 된다.
 * </pre>
 * 옵션들은 복합적으로 사용될 수 있다.
 * <pre>
 *     var str = "abc,  de\\,fg"
 *     var strArr = str.advancedSplit(",", "it");
 * </pre>
 * 위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 * @sig    : delim, options
 * @param  : delim   required delimenator
 * @param  : options required 옵션을 나타내는 문자들을 나열한 스트링
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
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 toDate 메소드를 추가한다. toDate 메소드는 날짜를 표현하는
 *           스트링 값을 자바스크립트의 내장 객체인 Date 객체로 변환한다.
 * <pre>
 *     var date = "2002-03-05".toDate("YYYY-MM-DD")
 * </pre>
 * 위의 예에서 date 변수는 실제로 2002년 3월 5일을 표현하는 Date 오브젝트를 가르킨다.
 * @sig    : [pattern]
 * @param  : pattern optional Date를 표현하고 있는 현재의 String을 pattern으로 표현한다. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : year(4자리)
 *       YY   : year(2자리)
 *       MM   : month in year(number)
 *       DD   : day in month
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *
 *     <font color=red>주의)</font> YYYY(YY)는 반드시 있어야 한다. YYYY(YY) 만 사용할 경우는 1월 1일을 기준으로
 *     하고 YYYY와 MM 만사용할 경우는 1일을 기준으로 한다.
 * </pre>
 * @return : 변환된 Date Object.
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
 * @desc   : 자바스크립트의 내장 객체인 Date 객체에 format 메소드를 추가한다. format 메소드는 Date 객체가 가진 날짜를
 *           지정된 포멧의 스트링으로 변환한다.
 * <pre>
 *     var dateStr = new Date().format("YYYYMMDD");
 *
 *     참고 : Date 오브젝트 생성자들 - dateObj = new Date()
 *                                   - dateObj = new Date(dateVal)
 *                                   - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 * </pre>
 * 위의 예에서 오늘날짜가 2002년 3월 5일이라면 dateStr의 값은 "20020305"가 된다.
 * default pattern은 "YYYYMMDD"이다.
 * @sig    : [pattern]
 * @param  : pattern optional 변환하고자 하는 패턴 스트링. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : hour in am/pm (1~12)
 *       MM   : month in year(number)
 *       MON  : month in year(text)  예) "January"
 *       DD   : day in month
 *       DAY  : day in week  예) "Sunday"
 *       hh   : hour in am/pm (1~12)
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *       a    : am/pm  예) "AM"
 * </pre>
 * @return : Date를 표현하는 변환된 String.
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
 * @desc   : 현재 Date 객체의 날짜보다 이후날짜를 가진 Date 객체를 리턴한다.
 *           예를 들어 내일 날짜를 얻으려면 다음과 같이 하면 된다.
 * <pre>
 *     var oneDayAfter = new Date.after(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional 이후 년수
 * @param  : months  optional 이후 월수
 * @param  : dates   optional 이후 일수
 * @param  : hours   optional 이후 시간수
 * @param  : minutes optional 이후 분수
 * @param  : seconds optional 이후 초수
 * @param  : mss     optional 이후 밀리초수
 * @return : 이후날짜를 표현하는 Date 객체
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
 * @desc   : 현재 Date 객체의 날짜보다 이전날짜를 가진 Date 객체를 리턴한다.
 *           예를 들어 어제 날짜를 얻으려면 다음과 같이 하면 된다.
 * <pre>
 *     var oneDayBefore = new Date.before(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional 이전으로 돌아갈 년수
 * @param  : months  optional 이전으로 돌아갈 월수
 * @param  : dates   optional 이전으로 돌아갈 일수
 * @param  : hours   optional 이전으로 돌아갈 시간수
 * @param  : minutes optional 이전으로 돌아갈 분수
 * @param  : seconds optional 이전으로 돌아갈 초수
 * @param  : mss     optional 이전으로 돌아갈 밀리초수
 * @return : 이전날짜를 표현하는 Date 객체
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
 * @desc   : 필드에 최대 자릿수를 입력한 후 지정된 다른 필드로 포커스가 자동으로 이동된다.<br>
 *           html의 <Input type="text"> 와 가우스 EMEdit에서 사용가능하다. <Input type="text"> 의 경우
 *           maxLength 속성이 지정되어 있어야 하며 EMEdit의 경우 MaxLength와 Format 속성중 하나가 반드시
 *           기술되어야 한다.<br>
 *           byte length(한글)은 지원하지 않는다.<br>
 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.
 * <pre>
 *     주민번호
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required 현재 입력필드
 * @param  : oNextElement required 자동으로 포커스가 이동될 필드
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
 * @desc   : 필드에 최대 자릿수를 입력한 후 지정된 다른 필드로 포커스가 자동으로 이동된다.<br>
 *           html의 <Input type="text"> 와 가우스 EMEdit에서 사용가능하다. <Input type="text"> 의 경우
 *           maxLength 속성이 지정되어 있어야 하며 EMEdit의 경우 MaxLength와 Format 속성중 하나가 반드시
 *           기술되어야 한다.<br>
 *           byte length(한글)은 지원하지 않는다.<br>
 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.
 * <pre>
 *     주민번호
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required 현재 입력필드
 * @param  : oNextElement required 자동으로 포커스가 이동될 필드
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
 * @desc   : 공통메세지에 정의된 메세지를 confirm box로 보여준 후 리턴한다. cfGetMSG 참조.
 * @sig    : msgId[, paramArray]
 * @param  : msgId      required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다.)
 * @return : 치환된 메세지 스트링

 */
function cfConfirmMSG(msgId, paramArray) {
        return confirm(new coMessage().getMsg(msgId, paramArray));
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 데이터셋 오브젝트 간에 데이터를 복사한다. 복사대상이 되는 데이터셋의 기존의 데이터는 모두 삭제된다.
 *           features 파라미터에서 copyHeader를 yes로 할 경우 DataSet의 컬럼정보까지 복사된다.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, "copyHeader=no");
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet[, features]
 * @param  : oOriginDataSet required 원본 DataSet
 * @param  : oTargetDataSet required 복사되어질 DataSet
 * @param  : features       optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     copyHeader : Header를 복사할지 여부. (default:yes)
 *     rowFrom    : 복사할 row의 시작 index. (default:1)
 *     rowCnt     : 복사할 row의 갯수 index. (default:DataSet.CountRow 의 값)
 *     사용예) "copyHeader=yes,rowFrom=1,rowCnt=2"  -> 1번 row 부터 3번 row까지 Header와 함께 복사함.
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
                var temp = oTargetDataSet.dataid;  // importdata를 한 후 DataSet의 기존의 dataid 속성값이 지워지는 것을 방지.
                oTargetDataSet.ImportData(oOriginDataSet.ExportData(rowFrom, rowCnt, true));
                oTargetDataSet.dataid = temp;
                oTargetDataSet.ResetStatus();
        }
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 데이터셋 오브젝트 간에 컬럼 헤더 정보를 복사한다.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS);
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet
 * @param  : oOriginDataSet required 원본 DataSet
 * @param  : oTargetDataSet required 복사되어질 DataSet
 */
function cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet) {
        var DsHeader = "";
        var colId   = "";
        var colType = "";
        var colProp = "";
        var colSize = ""

        for (var i = 1; i <= oOriginDataSet.CountColumn; i++) {
                 colId   = oOriginDataSet.ColumnID(i);	     //column id
                colIndex= oOriginDataSet.ColumnIndex(colId);  //column id에 해당하는 index값
                colSize = oOriginDataSet.ColumnSize(colIndex);//column size

                /* column의 type 정의 코드

                        Type  Description
                        -----------------
                         1    String
                         2    Integer
                         3    Decimal
                         4    Date
                         5    URL
                */

                //column type정의
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

                /* column의 property 정의
                        0 : Normal (Key = No)
                        1 : Constant
                        2 : Key (Normal, Sequence)
                        3 : Sequence (Key = No) // 현재 의미없음.
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
 * @desc   : Grid의 선택된 Row들을 삭제한다.
 * <pre>
 *     cfDeleteGridRow(oDomRegiRecevGDS);
 * </pre>
 * 위의 예에서 oDomRegiRecevGDS 라는 id를 가진 Grid의 현재 선택된 Row들은 모두 삭제된다.
 * @sig    : dataSet
 * @param  : dataSet required DataSet 오브젝트의 id
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
 * @desc   : 자바스크립트의 숫자 앞에 지정된 자릿수만큼 zero character 를 삽입한다.
 * <pre>
 *     cfDigitalNumber(5, 123);
 * </pre>
 * 위와같이 사용했을 경우 "00123" 이라는 String을 리턴한다.
 * @sig    : length, number
 * @param  : length required 숫자를 표현하는 길이
 * @param  : number required 변환될 숫자
 * @return : 변환된 스트링
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
 * @desc   : element를 disable 시킨다.
 * <pre>
 *     cfDisable(oRegistBtn);
 * </pre>
 * @sig    : oElement
 * @param  : oElement required disable 하고자 하는 element
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

                        // EMEdit 가 필수항목일 경우 필수항목에 대한 color를 적용시킨다.
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
 * @desc   : element를 enable 시킨다.
 * <pre>
 *     cfEnable(oRegistBtn);
 * </pre>
 * @sig    : oElement
 * @param  : oElement required enable 하고자 하는 element
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
 * @desc   : Grid의 DataId로 지정된 DataSet에 데이터가 0건일 경우에만 "데이터가 없습니다." 라는 메시지를 Grid상에 보여준다.
 *           언제 호출하든지 상관없지만 보통 DataSet의 OnLoadCompleted 이벤트나 Transaction의 OnSuccess 이벤트에서 호출한다.
 * <pre>
 *     &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;
 *         cfFillGridHeader(oDelivRsltGGHeader, oDelivRsltGDS, "kpl.spl.common.svl.SplSVL", "kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD", "pageLinkCnt=3");
 *         <b>cfFillGridNoDataMsg(oDelivRsltGG, "gridColLineCnt=2");</b>
 *     &lt;/script&gt;
 * </pre>
 * @sig    : oGG[, features]
 * @param  : oGG      required Grid 오브젝트
 * @param  : features optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     gridColLineCnt : Grid의 컬럼 줄의 수. 일반적으로는 한 줄이지만 Grid의 타이틀이 들어가면 2가 될 것이다. 기본값은 1이다.
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
        oNoDataMsg.Text              = "데이터가 없습니다.";
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
 * @desc   : 서버에서 현재시간을 읽어와서 자바스크립트의 Date 오브젝트로 변환한다.
 *           Date 오브젝트로부터 스트링 형태로 날짜 혹은 시간을 얻으려면 Date.format() 메소드를 참조할 것.
 * @return : Date 오브젝트
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

                // </head> 태그 직전에 DataSet 삽입
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
 * @desc   : Element의 type을 알려준다. 리턴되는 element type string은 다음과 같다.
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
 *     GCC      : 가우스 CodeCombe
 *     GRDO     : 가우스 Radio
 *     GTA      : 가우스 TextArea
 *     GIF      : 가우스 InputFile
 *     GE       : 가우스 EMEdit
 *     GDS      : 가우스 DataSet
 *     GTR      : 가우스 Transaction
 *     GCHT     : 가우스 Chart
 *     GID      : 가우스 ImageData
 *     GG       : 가우스 Grid
 *     GTB      : 가우스 Tab
 *     GTV      : 가우스 TreeView
 *     GM       : 가우스 Menu
 *     GB       : 가우스 Bind
 *     GRPT     : 가우스 Report
 *     GS       : 가우스 Scale
 *     null     : 기타
 * </pre>
 * @sig    : oElement
 * @param  : oElement required element
 * @return : element의 type을 표현하는 string
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
 * @desc   : 스트링의 자릿수를 Byte 단위로 환산하여 알려준다. 영문, 숫자는 1Byte이고 한글은 2Byte이다.(자/모 중에 하나만 있는 글자도 2Byte이다.)
 * @sig    : value
 * @param  : value required 스트링
 * @return : 스트링의 길이
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
 * @desc   : 공통메세지에 정의된 메세지를 리턴한다.
 * <pre>
 * // 공통 메세지 영역
 * var MSG_NO_CHANGED        = "변경된 사항이 없습니다.";
 * var MSG_SUCCESS_LOGIN     = "@님 안녕하세요?";
 * ...
 * var message1 = cfGetMSG(MSG_NO_CHANGED);
 * var message2 = cfGetMSG(MSG_SUCCESS_LOGIN, ["홍길동"]);
 * </pre>
 * 위의 예에서 message2 의 값은 "홍길동님 안녕하세요?" 가 된다.
 * @sig    : msgId[, paramArray]
 * @param  : msgId      required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 데이터 Array. Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다. 치환될 데이터는 [] 사이에 콤마를 구분자로 하여 기술하면 Array 로 인식된다.
 * @return : 치환된 메세지 스트링
 */
function cfGetMSG(msgId, paramArray) {
        return new coMessage().getMsg(msgId, paramArray);
}


/**
 * @type   : function
 * @access : private
 * @desc   : Object를 초기화한다.
 * @sig    : obj[, iniVal]
 * @param  : parentObj required 초기화할 대상 오브젝트
 * @param  : iniVal    optional 초기값
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
 * @desc   : 사용자가 누른 key가 enter key 인지 여부를 알려준다.
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
 * @return : enter key 여부
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
 * @desc   : 값이 null 이거나 white space 문자로만 이루어진 경우 true를 리턴한다.
 * <pre>
 *     cfIsNull("  ");
 * </pre>
 * 위와같이 사용했을 경우 true를 리턴한다.
 * @sig    : value
 * @param  : value required 입력값
 * @return : boolean. null(혹은 white space) 여부
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
 * @desc   : 값이 지정된 그룹내에 존재하는지를 알려준다.
 * <pre>
 *     cfIsIn(3, [1, 2, 3]);                     // -> true
 *     cfIsIn(3, [4, 5, 6]);                     // -> false
 *     cfIsIn('F', ['A', 'B', 'F']);             // -> true
 *     cfIsIn('F', ['A', 'B', 'C']);             // -> false
 *     cfIsIn("lim", ["lim", "kim", "park"]);    // -> true
 *     cfIsIn("lim", ["lee", "kim", "park"]);    // -> false
 * </pre>
 * @sig    : value, valueArray
 * @param  : value      required 비교하고 싶은 값
 * @param  : valueArray required 비교하고 싶은 값에 대한 비교 대상이 되는 값들의 집합. array 타입이며 array
 *           내의 각 element의 데이터 타입은 value 파라미터의 타입과 일치해야 한다.
 * @return : boolean. 값이 지정된 그룹내에 존재하는지 여부.
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
 * @desc   : window.open으로 서브창을 띄울 때 서브창의 위치를 간단하게 지정할 수 있다.
 * @sig    : width, height, position, [sURL] [, sName] [, sFeatures] [, bReplace]
 * @param  : width - 서브창의 넓이
 * @param  : height - 서브창의 높이
 * @param  : position  - 서브창의 위치 (default : 5) <br><br>
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
 * @param  : sURL      required window.open의 sURL 파라미터와 동일
 * @param  : sName     required window.open의 sName 파라미터와 동일
 * @param  : sFeatures required window.open의 sFeatures 파라미터와 동일
 * @param  : bReplace  required window.open의 bReplace 파라미터와 동일
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
                width = width + 10; // window의 좌우 border 5px씩 감안.
                height = height + 29; // titlebar는 기본으로 감안.
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
 * @desc   : features 스트링을 파싱하여 array에 셋팅하는 내부 함수
 * @sig    : features, fNameArray, fValueArray, fTypeArray
 * @param  : features    required features를 표현한 스트링
 * @param  : fNameArray  required 추출해야 할 feature의 이름에 대한 array
 * @param  : fValueArray required 추출해야 할 feature의 기본값에 대한 array
 * @param  : fTypeArray  required 추출해야 할 feature의 데이터타입에 대한 array

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
 * @desc   : 공통메세지에 정의된 메세지를 prompt box 로 보여준다. 만약 패스워드를 입력받는 prompt box를
 *           띄우면서 공통메세지에 정의된 메세지를 보여주고 싶다면 다음과 같이 하면 된다.
 * <pre>
 *     // 공통메세지 영역
 *     var MSG_INPUT_PASSWORD = "@님, 패스워드를 입력하십시오.";
 *     ...
 *     cfPromptMsg(MSG_INPUT_PASSWORD, ["홍길동"], "입력하세요.");
 * </pre>
 * @sig    : msgId[, paramArray[, defaultVal]]
 * @param  : msgId      required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다.)
 * @param  : defaultVal optional prompt box 의 입력필드에 보여줄 기본값.
 * @return : 입력받은 String 혹은 Integer 타입의 패스워드 데이터
 */
function cfPromptMsg(msgId, paramArray, defaultVal) {
        return prompt(new coMessage().getMsg(msgId, paramArray), defaultVal);
}

/**
 * @type   : function
 * @access : public
 * @desc   : parent object (Div, Table, FieldSet 태그)에 속한 모든 child object의 값을 초기화한다.
 * @sig    : parentObj[, iniVal]
 * @param  : parentObj required 초기화할 부모 오브젝트
 * @param  : iniVal    optional 초기값
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
 * @desc   : Grid를 전체선택한다.
 * <pre>
 *     cfSelectAllGridRows(oDomRegiRecevGDS, oDomRegiRecevGG);
 * </pre>
 * 위의 예에서 oDomRegiRecevGDS 라는 id를 가진 DataSet의 데이터를 보여주는
 * oDomRegiRecevGG 라는 id를 가진 Grid 상에서 모든 Row들을 선택한다.
 * @sig    : dataSet, grid
 * @param  : dataSet required DataSet 오브젝트의 id
 * @param  : grid    required Grid 오브젝트
 */
function cfSelectAllGridRows(oDataSet, oGrid) {
        oDataSet.MarkAll();
        oGrid.Focus();
}

/**
 * @type   : function
 * @access : public
 * @desc   : 공통으로 사용하는 달력창을 띄운다.
 * <pre>
 * &lt;object id="calendarText" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="100"&gt;
 *     &lt;param name="Alignment" value="1"&gt;
 *     &lt;param name="format" value="YYYY-MM-DD"&gt;
 * &lt;/object&gt;
 *
 * &lt;input type="button" value="달력띄우기" onclick="cfShowCalendar(calendarText)"&gt;
 * </pre>
 * @sig    : item[, month[, year[, format]]]
 * @param  : item   required 달력창으로부터 선택된 날짜를 Text값으로 가지는 EMEdit 컴포넌트의 id
 * @param  : month  optional 달을 나타내는 0~11 사이의 숫자.
 * @param  : year   optional 년도를 나타내는 4자리 숫자
 * @param  : format optional 날짜를 표현하는 형식을 나타내는 포멧 스트링. item 오브젝트의 Text값으로
 *                    셋팅되는 값의 format을 나타낸다. 기본값은 YYYYMMDD 이다.
 *                    Date 오브젝트의 format 메소드의 파라미터와 형식이 같으므로 참고할 것.
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
 * @desc   : 공통으로 사용하는 에러메세지 창을 띄운다.
 * @sig    : obj
 * @param  : obj required 에러가 난 가우스 오브젝트(DataSet or Transaction 오브젝트중 하나)
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
 * @desc   : Grid의 컬럼명을 클릭했을 때 데이터를 Sorting 해주는 함수이다. Grid의 id가 oDelivRsltGG 이고
 *           DataSet의 id가 oDelivRsltGDS 라면 다음과 같이 Grid의 OnClick 이벤트 스크립트에 기술해주면 된다.
 * <pre>
 * &lt;script language="javascript" for="oDelivRsltGG" event="OnClick(row, colid)"&gt;
 *     if (row == 0) {           // Grid 상에서 컬럼명 위에서 클릭했을 경우
 *         cfSortGrid(oDelivRsltGDS, colid);
 *     }
 * &lt;/script&gt;
 * </pre>
 * @sig    : oGDS, colid
 * @param  : oGDS  required Grid의 데이터로 사용되는 DataSet 오브젝트의 id
 * @param  : colid required Grid의 OnClick 이벤트 함수의 colid 파라미터
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
 * @desc   : 가우스 Grid의 Style을 정해진 Style로 바꾸어준다.
 * <pre>
 *     cfStyleGrid(oDelivRsltGG, "comn", features);
 * </pre>
 * @sig    : oGrid, styleName[, features]
 * @param  : oGrid     required Grid 오브젝트
 * @param  : styleName required Grid의 style name. [RL_COMN : 무선국허가, RF_COMN : 전파사용료, RC_COMN : 픔질인증]
 * @param  : features  optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     indWidth : Grid의 indWidth 속성 지정.
 *     사용예) "indWidth=12"
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

        // <C> 컬럼 속성
        var CColor;
        var CHeadColor;
        var CHeadBgColor;

        // <FC> 컬럼 속성
        var FCColor;
        var FCBgColor;
        var FCHeadColor;
        var FCHeadBgColor;

        // <G> 컬럼 속성
        var GHeadColor;
        var GHeadBgColor;

        // <FG> 컬럼 속성
        var FGHeadColor;
        var FGHeadBgColor;

        // <X> 컬럼 속성
        var XHeadColor;
        var XHeadBgColor;

        // <FX> 컬럼 속성
        var FXHeadColor;
        var FXHeadBgColor;

        var featureNames  = ["indWidth"];
        var featureValues = [null];
        var featureTypes  = ["number"];

        if (features != null) {
                cfParseFeature(features, featureNames, featureValues, featureTypes);
        }

        var indWidth = featureValues[0];

        // Grid Style 별 정의
        switch (styleName) {
                case "comn":
                        // Grid 속성
                        titleHeight      = 20;
                        rowHeight        = 20;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "굴림";

                        // 컬럼 공통 속성
                        sumColor         = "#78618D";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "464646";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // 컬럼별 속성
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
                        // Grid 속성
                        titleHeight      = 20;
                        rowHeight        = 20;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "굴림";

                        // 컬럼 공통 속성
                        sumColor     = "#78618D";
                        sumBgColor   = "#DCDDEF";
                        subColor     = "464646";
                        subBgColor   = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // 컬럼별 속성
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
//            무선국허가
//-------------------------------------------------------------------------------------------------------------
                case "RL_COMM":
                        // Grid 속성
                        titleHeight      = 22;
                        rowHeight        = 22;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "굴림";
                        LineColor       = "#999999";

                        // 컬럼 공통 속성
                        sumColor         = "#3D3D3D";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "#3D3D3D";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // 컬럼별 속성
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
//            무선국허가
//-------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------
//            전파사용료
//-------------------------------------------------------------------------------------------------------------
                case "RF_COMM":
                        // Grid 속성
                        titleHeight      = 22;
                        rowHeight        = 22;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "굴림";
                        LineColor       = "#A7AD9F";

                        // 컬럼 공통 속성
                        sumColor         = "#000000";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "#000000";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // 컬럼별 속성
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
//            전파사용료
//-------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------
//            품질인증
//-------------------------------------------------------------------------------------------------------------
                case "RC_COMM":
                        // Grid 속성
                        titleHeight      = 22;
                        rowHeight        = 22;
                        indWidth         = (indWidth == null) ? 15 : indWidth;
                        fontSize         = "9pt";
                        fontFamily       = "굴림";
                        LineColor       = "#999999";

                        // 컬럼 공통 속성
                        sumColor         = "#000000";
                        sumBgColor       = "#DCDDEF";
                        subColor         = "#000000";
                        subBgColor       = "#D8D8D8";
                        subpressBgColor  = "#FFFFFF";

                        // 컬럼별 속성
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
//            품질인증
//-------------------------------------------------------------------------------------------------------------


                default:
                        return;
        }

        // Grid 속성 설정
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

        // Grid Format String 을 파싱하여 컬럼별로 Style 과 관련된 속성을 삽입한다.
        while ((tagMatch = gFormat.match(tagRE)) != null) {
                insertStr = "";
                tagName = tagMatch[1].trim().toUpperCase();

                // 사용자가 지정한 컬럼 속성에 따른 처리
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



                // Grid의 Format 에 Style 관련 속성값들을 삽입한다.
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
 * @desc   : 가우스 Tab의 Style을 정해진 Style로 바꾸어준다.
 * <pre>
 *     cfStyleTab(oDomRegiRecevGTab, "comn");
 * </pre>
 * @sig    : oTab, styleName
 * @param  : oGrid     required Tab 오브젝트
 * @param  : styleName required Tab의 style name. 현재는 "comn" 과 "comnOnTab" 만 있다.

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
 * @desc   : 화면상의 입력과 관련된 오브젝트에 대한 유효성 검사를 실시한다. 유효성 검사를 받는 오브젝트들은 "validExp" 라는
 *           속성값을 설정해야 한다. "validExp" 라는 속성은 원래 html 객체에는 정의되어 있지 않은 속성이지만 다른 속성들을
 *           설정하는 것과 같은 방법으로 설정하면 자동으로 해당 오브젝트의 속성으로 인식된다.<br><br>
 *           - 해당 오브젝트에 대한 child 오브젝트들까지도 검사한다. 예를들어, 검사받을 오브젝트들을 &lt;div&gt; 태그로 감싸고
 *             &lt;div&gt; 태그의 id를 파라미터로 준다면 &lt;div&gt; 태그내의 모든 오브젝트들이 자동으로 검사받게 된다. 또,
 *             &lt;table&gt;안에 입력필드들은 &lt;table&gt;의 id를 파라미터로 주면 된다.<br><br>
 *           - 입력값의 앞과 뒤의 공백은 유효성 검사를 하면서 자동으로 trim된다.
 * <pre>
 *    예1)
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
 *        &lt;object id="oRecevNo" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="50" <b>validExp="접수번호:yes:length=6"</b>&gt;
 *            &lt;param name="Format"    value="000000"&gt;
 *        &lt;/object&gt;
 *        ...
 *    &lt;/table&gt;
 *    ...
 * </pre>
 * validExp 속성값은 정해진 형식에 맞게 작성되어야 하는데 형식은 오브젝트의 종류에 따라 두 가지로 나뉜다.<br>
 * <pre>
 *    1. 일반 오브젝트의 경우 (예1 참조)
 *        "item_name:필수여부:valid_expression"
 *
 *        - "item_name"에는 해당 항목에 대한 이름을 기술한다.
 *        - "필수여부"에는 해당 오브젝트가 필수 항목인지 여부를 yes|true|1 혹은 no|false|0 타입으로 기술한다.
 *        - "valid_expression" 은  cfValidateValue 함수의 설명을 참조하기 바란다.
 *        - 필수항목인지만 체크하려면 "valid_expression" 을 표기하지 않으면 된다.
 *          예)
 *          &lt;object id="oDelivYmd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="80" <b>validExp="배달일자:yes"</b>&gt;
 *              ...
 *			&lt;/object&gt;
 *        - validExp 내에 임의로 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>
 *
 *
 *    2. 가우스 Grid 오브젝트의 경우
 *        "column_id:item_name:필수여부[:valid_expression[:key]][,column_name:item_name:필수여부[:valid_expression[:key]]]..."
 *
 *        - column_id 에는  Grid와 연결된 DataSet의 실제 컬럼 id 를 적어준다.
 *
 *        - <font color=red><b>dataName</b></font>이라는 속성도 기술해 주어야 한다. dataName은 해당 DataSet
 *        을 표현하는 이름을 기술해 주면 된다.
 *
 *        예)
 *
 *        cfValidate([oDomRegiRecevGG]);
 *        ...
 *        &ltobject id="oDomRegiRecevGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"
 *           width="174" height="233" style="position:absolute; left:10; top:73;"  <b>dataName="배달결과리스트"</b>
 *         <b>validExp="regiNo:등기번호:yes:length=13:key,
 *                  sendPrsnZipNo:발송인우편번호:yes:length=6,
 *                  recPrsnZipNo:수취인우편번호:yes:length=6
 *                 "</b>
 *        &gt;
 *
 *        - 만약 item_name을 기술하지 않았을 경우에는 Grid의 column_id에 해당하는 컬럼의 컬럼명으로 자동으로 대체된다.
 *          예) validExp="regiNo::yes:length=13, ..."
 *
 *        - 만약 컬럼이 key컬럼일 경우에는 끝에 key라고 명시해 준다. key라고 명시해 주면 다른 Row와 데이터가 중복되었을 때
 *          에러를 발생시킨다. 단, key를 명시해 줄 경우에는 valid_expression 을 반드시 기입해 주고 기입해 줄 내용이 없더라도
 *          ':' 을 삽입해야 한다.
 *          예) validExp="regiNo:등기번호:yes::key, ...
 *
 *        - 나머지는 1의 경우와 같다.
 * </pre>
 * @sig    : objArr
 * @param  : objectArr required 유효성검사를 하고자 하는 오브젝트들의 Array.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 가우스와 html 의 모든 오브젝트에 대해 유효성 검사를 한다.
 * @sig    : oElement
 * @param  : oElement required 검사 대상 Element.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 가우스 컴포넌트 중에서 DataSet을 제외한 모든 오브젝트와 html의 모든 오브젝트에 대해 유효성 검사를 한다.
 * @sig    : oElement
 * @param  : oElement required 검사 대상 Element.
 * @return : boolean. 유효성 여부.
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
                        oElement.value = oElement.value.trim();  // element의 값을 trim 시켜준다.
                        value = oElement.value;
                        break;

                case "OBJECT":
                        switch (oElement.attributes.classid.nodeValue.toUpperCase()) {
                                case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
                                case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component
                                        oElement.CodeValue = (oElement.CodeValue == null) ? null : oElement.CodeValue.trim();  // element의 값을 trim 시켜준다.
                                        value = oElement.CodeValue;
                    break;

                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component
                                case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component
                                case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component
                                        oElement.Text = (oElement.Text == null) ? null : oElement.Text.trim();  // element의 값을 trim 시켜준다.
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
 * @desc   : 가우스의 Grid에 대해 유효성 검사를 한다. 유효성 검사를 위해서는 Grid의 DataId에 지정된 DataSet에 validExp 속성이
 *           지정되어 있어야 한다. 지정방법은 cfValidate 함수에 대한 설명을 참조하기 바란다. (내부적으로는 Grid를 검사하는 것이 아니라
 *           Grid의 DataId에 지정된 DataSet에 대한 유효성 검사이다.)
 * @sig    : oGrid[, row[, colId]]
 * @param  : oGrid required 검사 대상 Grid.
 * @param  : row   optional 검사하고자 하는 row 번호
 * @param  : colId optional 검사하고자 하는 컬럼의 id
 * @return : boolean. 유효성 여부.
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
 * @desc   : 사용자의 입력값이 Byte로 환산된 최대길이를 넘을 경우 입력이 안되도록 하는 함수. 오브젝트 선언시 onkeydown 이벤트에 다음과
 *           같이 기술해 주어야만 한다.
 * <pre>
 *     onkeydown="cfValidateMaxByteLength(this, max_byte_length)"
 *     (여기서 max_byte_length 자리에는 Byte로 환산시 최대길이를 숫자로 적어준다.)
 *
 *     예)
 *     &lt;input type="text" size="10" onkeydown="cfValidateMaxByteLength(this, 10)"&gt;
 * </pre>
 *           현재는 html의 text input, textarea 와 가우스의 EMEdit 에만 적용된다.
 * @sig    : oElement, length
 * @param  : oElement required 입력필드 객체
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
 * @desc   : 특정 값에 대한 유효성검사를 수행한다.
 * <pre>
 *     cfValidateValue(50, "minNumber=100");
 * </pre>
 * 위의 경우 50은 최소값 100을 넘지 않으므로 false가 리턴된다.<br>
 * 유효성 검사를 수행하기 위해서는 검사조건을 명시해야 하는데
 * 검사조건은 'valid expression' 이라고 불리우는 String 값으로 표현된다. valid expression에 대한 표기형식은
 * 다음과 같다.
 * <pre>
 *  	validator_name=valid_value[&validator_name=valid_value]..
 *
 *  	예) "minNumber=100"
 * </pre>
 * - validator_name은 검사유형을 의미하며 valid_value는 기준 값이 된다. <br>
 * - 검사항목은 하나 이상일 수 있으며 검사항목간에는 "&" 문자로 구분하여 필요한 만큼 나열하면 된다. <br>
 * - valid_value에 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>
 * - 위의 예에서는 "minNumber" (최소값)라는 유효성 검사항목을 명시하였고 minNumber 에대한 기준값으로 "100" 이 설정되어 있다.
 * 만일 100보다 작은 값을 입력했을 때는 100 이상의 값을 입력하라는 alert box가 뜨게 된다.
 * - validator_name은 미리 정의되어 있는 것만 사용할 수 있고 각 검사유형마다 valid_value의 형태도 다르다.(valid_value가 없는 것도 있다.)
 * 현재 정의된 검사유형은 다음과 같다.
 * <br><br>
 * <table border=1 style="border-collapse:collapse; border-width:1pt; border-style:solid; border-color:000000;">
 * 		<tr>
 * 			<td align="center" bgcolor="#CCCCFFF">검사유형</td>
 * 			<td align="center" bgcolor="#CCCCFFF">기준값 형태</td>
 * 			<td align="center" bgcolor="#CCCCFFF">설명</td>
 * 			<td align="center" bgcolor="#CCCCFFF">예</td>
 * 		</tr>
 * 		<tr>
 * 			<td>length</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>자릿수 검사. 입력값의 자릿수가 기준값과 일치하는지를 검사한다. 일반적으로 HTML에서는 한글, 영문, 숫자 모두 1자리씩 인식된다.</td>
 * 			<td>length=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>byteLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>Byte로 환산된 자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값과 일치하는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>
 * 			<td>byteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>최소자릿수 검사. 입력값의 자릿수가 기준값 이상이 되는지를 검사한다.</td>
 * 			<td>minLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minByteLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>Byte로 환산된 최소자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값 이상이 되는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>
 * 			<td>minByteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>최대자릿수 검사. 입력값의 자릿수가 기준값 이하가 되는지를 검사한다.</td>
 * 			<td>maxLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxByteLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>Byte로 환산된 최대자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값 이하가 되는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>
 * 			<td>maxByteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>number</td>
 * 			<td>None</td>
 * 			<td>숫자검사. 입력값이 숫자인지를 검사한다.</td>
 * 			<td>number</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minNumber</td>
 * 			<td>숫자</td>
 * 			<td>최소수 검사. 입력값이 최소한 기준값 이상이 되는지를 검사한다.</td>
 * 			<td>minNumber=100</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxNumber</td>
 * 			<td>숫자</td>
 * 			<td>최대수 검사. 입력값이 기준값 이하인지를 검사한다.</td>
 * 			<td>maxNumber=300</td>
 * 		</tr>
 * 		<tr>
 * 			<td>inNumber</td>
 * 			<td>"숫자~숫자" 형식으로 표기.</td>
 * 			<td>범위값 검사. 입력값이 기준이 되는 두 수와 같거나 혹은 두 수 사이에 존재하는 값인지를 검사한다.</td>
 * 			<td>inNumber=100~300</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minDate</td>
 * 			<td>YYYYMMDD 형식의 날짜 스트링.</td>
 * 			<td>최소날짜 검사. 입력된 날짜가 기준날짜이거나 기준날짜 이후인지를 검사한다.</td>
 * 			<td>minDate=20020305</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxDate</td>
 * 			<td>YYYYMMDD 형식의 날짜 스트링. 예) maxDate=20020305</td>
 * 			<td>최대날짜 검사. 입력된 날짜가 기준날짜이거나 기준날짜 이전인지를 검사한다.</td>
 * 			<td>maxDate=20020305</td>
 * 		</tr>
 * 		<tr>
 * 			<td>format</td>
 * 			<td>format character들과 다른 문자들을 조합한 스트링.<br>
 * 				<table>
 * 					<tr>
 * 						<td><b>format character</b></td>
 * 						<td><b>desc</b></td>
 * 					</tr>
 * 					<tr>
 * 						<td>#</td>
 * 						<td>문자와 숫자</td>
 * 					</tr>
 * 					<tr>
 * 						<td>A, Z</td>
 * 						<td>문자 (Z는 공백포함)</td>
 * 					</tr>
 * 					<tr>
 * 						<td>0, 9</td>
 * 						<td>숫자 (9는 공백포함)</td>
 * 					</tr>
 * 				</table>
 * 			</td>
 * 			<td>형식 검사. 입력된 값이 지정된 형식에 맞는지를 검사한다.</td>
 * 			<td>format=000-000</td>
 * 		</tr>
 * 		<tr>
 * 			<td>ssn</td>
 * 			<td>주민등록번호 13자리</td>
 * 			<td>주민등록번호 검사. 입력한 주민등록번호가 유효한지를 검사한다.</td>
 * 			<td>ssn</td>
 * 		</tr>
 * 		<tr>
 * 			<td>csn</td>
 * 			<td>사업자등록번호 10자리</td>
 * 			<td>사업자등록번호 검사. 입력한 사업자등록번호가 유효한지를 검사한다.
 *              (예, 2019009930)
 *          </td>
 * 			<td>csn</td>
 * 		</tr>
 * 		<tr>
 * 			<td>filter</td>
 * 			<td>필터링하고 싶은 스트링을 ";"문자를 구분자로 사용하여 나열한다.(단 ";" 문자를 필터링하고 싶을 땐 "\\;"라고 표기한다.
 *          </td>
 * 			<td>입력값에 특별한 문자나 스트링이 있는지를 검사한다.
 *              (예, 2019009930)
 *          </td>
 * 			<td>filter=%;<;임재현;\\;;haha<br>(입력값 내에 "%","<","임재현",";","haha" 중에 하나라도 있는지 검사한다.)
 *          </td>
 * 		</tr>
 * 		<tr>
 * 			<td>date</td>
 * 			<td>format character의 조합으로 이루어진 날자에 대한 패턴 스트링.<br>
 * 				<table>
 * 					<tr>
 * 						<td><b>format character</b></td>
 * 						<td><b>desc</b></td>
 * 					</tr>
 * 					<tr>
 * 						<td>YYYY</td>
 * 						<td>4자리 년도</td>
 * 					</tr>
 * 					<tr>
 * 						<td>YY</td>
 * 						<td>2자리 년도. 2000년 이후</td>
 * 					</tr>
 * 					<tr>
 * 						<td>MM</td>
 * 						<td>2자리 숫자의 달</td>
 * 					</tr>
 * 					<tr>
 * 						<td>DD</td>
 * 						<td>2자리 숫자의 일</td>
 * 					</tr>
 * 					<tr>
 * 						<td>hh</td>
 * 						<td>2자리 숫자의 시간. 12시 기준</td>
 * 					</tr>
 * 					<tr>
 * 						<td>HH</td>
 * 						<td>2자리 숫자의 시간. 24시 기준 </td>
 * 					</tr>
 * 					<tr>
 * 						<td>mm</td>
 * 						<td>2자리 숫자의 분</td>
 * 					</tr>
 * 					<tr>
 * 						<td>ss</td>
 * 						<td>2자리 숫자의 초</td>
 * 					</tr>
 * 				</table>
 * 			</td>
 * 			<td>날짜 검사. 입력된 스트링값을 날짜로 환산하여 유효한 날짜인지를 검사한다.</td>
 * 			<td>date=YYYYMMDD  일 때 입력값이 '20020328' 일 경우 -> 유효<br>
 *              date=YYYYMMDD  일 때 입력값이 '20020230' 일 경우 -> 오류<br>
 *              date=Today is YY-MM-DD' 일 때 입력값이 'Today is 02-03-28' 일 경우 -> 유효<br><br>
 * 				참고) format문자가 중복해서 나오더라도 처음 나온 문자에 대해서만 format문자로 인식된다.
 *                    YYYY와 YY, hh와 HH 도 중복으로 본다. 날짜는 년,월이 존재할 때만 정확히 체크하고
 *                    만일 년, 월이 없다면 1 ~ 31 사이인지만 체크한다.
 * 			</td>
 * 		</tr>
 * </table>
 * @sig    : value, validExp
 * @param  : value    required 검사 대상이 되는 값.
 * @param  : validExp required 사용자가 지정한 Valid Expression String.
 * @return : boolean. 유효성 여부.

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
 * @desc   : Grid의 선택된 Row들을 취소한다.
 * <pre>
 *     cfUndoGridRows(oDomRegiRecevGDS);
 * </pre>
 * 위의 예에서 oDomRegiRecevGDS 라는 id를 가진 Grid의 현재 선택된 Row들은 모두 취소된다.
 * @sig    : dataSet
 * @param  : dataSet required DataSet 오브젝트의 id

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
 * @desc   : 공통메세지에 정의된 메세지를 alert box로 보여준 후 리턴한다. cfGetMSG 참조.
 * @sig    : msgId[, paramArray]
 * @param  : msgId required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 데이터 Array. Array의 index와 메세지 내의 '@' 문자의 순서가 일치한다.
             치환될 데이터는 [] 사이에 콤마를 구분자로 하여 기술하면 Array 로 인식된다.
 * @return : 치환된 메세지 스트링
 */
function cfAlertMSG(msgId, paramArray) {
        var msg = new coMessage().getMsg(msgId, paramArray);

        alert(msg);

        return msg;
}


/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 공통에러메세지 창을 보여준다.
 * @sig    : msgId[, paramArray]
 * @param  : MsgCase required : 업무구분
 * @param  : allSys required : 업무구분
 * @param  : MSGStr required : 에러메세지
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



//2003.01.17 추가
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














//---------------------------------------- 이하 객체선언 ---------------------------------------------//

///////////////////////////// coMessage /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 메세지를 관리하는 객체이다.

 */
function coMessage() {
        // method
        this.getMsg = coMessage_getMsg;
}

/**
 * @type   : method
 * @access : public
 * @object : coMessage
 * @desc   : 공통메세지에 정의된 메세지를 치환하여 알려준다.
 * @sig    : message[, paramArray]
 * @param  : message    required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다.)
 * @return : 치환된 메세지 스트링
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
 * @desc   : String parameter 에 대한 name과 value 쌍들을 가진 객체

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
 * @desc   : name에 맞는 파라미터값을 리턴한다.
 * @sig    : name
 * @param  : name required map의 name으로 사용할 값
 * @return : 파라미터값
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
 * @desc   : 새로운 map을 추가한다. 같은 name가 존재할 경우 overwrite한다.
 * @sig    : name, value
 * @param  : name  required map의 name로 사용할 값
 * @param  : value required map의 value로 사용할 값
 * @return : 파라미터값
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
 * @desc   : 지정된 index에 있는 map의 name을 알려준다.
 * @sig    : index
 * @param  : index - map의 index
 * @return : name
 */
function coMap_getNameAt(index) {
        return this.names[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : 지정된 index에 있는 map의 value를 알려준다.
 * @sig    : index
 * @param  : index required map의 index
 * @return : value
 */
function coMap_getValueAt(index) {
        return this.values[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : map의 name-value 쌍의 갯수를 알려준다.
 * @return : name-value 쌍의 갯수
 */
function coMap_size() {
        return this.count;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : map 내의 name 값들을 String으로 환산하여 최대길이를 알려준다.
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
 * @desc   : String parameter 에 대한 name과 value 쌍들을 가진 객체

 */
function coParameterMap() {
        // fields

        /**
         * @type   : field
         * @access : private
         * @object : coParameterMap
         * @desc   : 파라미터 이름을 담고있는 array
         */
        this.names = new Array();

        /**
         * @type   : field
         * @access : private
         * @object : coParameterMap
         * @desc   : 파라미터 값을 담고있는 array
         */
        this.values = new Array();

        /**
         * @type   : field
         * @access : private
         * @object : coParameterMap
         * @desc   : 파라미터의 개수
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
 * @desc   : name에 맞는 파라미터값을 리턴한다.
 * @sig    : name
 * @param  : name required map의 name으로 사용할 값
 * @return : 파라미터값
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
 * @desc   : 새로운 map을 추가한다. 같은 name가 존재할 경우 overwrite한다.
 * @sig    : name, value
 * @param  : name  required map의 name로 사용할 값
 * @param  : value required map의 value로 사용할 값
 * @return : 파라미터값
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
 * @desc   : 지정된 index에 있는 map의 name을 알려준다.
 * @sig    : index
 * @param  : index required map의 index
 * @return : name
 */
function coParameterMap_getNameAt(index) {
        return this.names[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : 지정된 index에 있는 map의 value를 알려준다.
 * @sig    : index
 * @param  : index required map의 index
 * @return : value
 */
function coParameterMap_getValueAt(index) {
        return this.values[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map의 name-value 쌍의 갯수를 알려준다.
 * @return : name-value 쌍의 갯수
 */
function coParameterMap_size() {
        return this.count;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map 내의 name 값들을 String으로 환산하여 최대길이를 알려준다.
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
 * @desc   : map 내의 value 값들을 String으로 환산하여 최대길이를 알려준다.
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

//-------------------------- 유효성 검사를 위한 객체 선언 -----------------------------//
/*
 * @Validator 객체의 구조
 *   - 속성 : exception,   -> validity의 sub속성이다. validity가 true면 exception은 무조건 false이고
 *                            validity가 false인 경우 false의 원인이 exception인지 여부를 알려준다.
 *                            exception은 사용자 입력에 대한 실제 validation과는 무관한 에러를 의미한다.
 *                            true/false 중 하나.
 *            message,     -> 오류메세지를 담고 있다.
 *            validity,    -> 유효성검사결과를 담고 있다. true/false 중 하나.
 *            value        -> 유효성 검사 대상 값.
 *
 *   - 메소드 : validate() -> 유효성 검사를 수행한다.
 *                            유효할 경우, validity를 true로하고 true를 return하고
 *                            유효하지 않을 경우,  validity를 false로하고 false를 return하고
 *                            message에 오류메세지를 기술한다.
 *                            exception의 경우는 exception을 true로 하고 message에 메세지를 기술한다.
 *
 *   - 추가시 할일 :
 *     1) validator객체를 정의한다.
 *     2) covValidExp 객체의 getValidators 메소드에 validator객체를 등록한다.
 */

///////////////////////////// covValueValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 유효성 검사에 대한 표현(expression)을 객체화 하였다.
 *             - expression 형식<br>
 *               항목이름:필수항목여부:유효성항목<br>
 *               예) "접수번호:yes:length=6"
 *             - 유효성 항목 형식
 *               유효성항목명=유효값[&유효성항목명=유효값]..
 *               예) "length=13&ssn"
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
 * @desc   : 초기화를 수행한다.
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
 * @desc   : covValidExp 객체의 parse 메소드.
 *           valid expression을 parsing한다.
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
                validItem.value = validItemPair[1];  // parsedExp[1] 은 존재하지 않을 수도 있지만 자바스크립트에서는
                this.validItems[i] = validItem;      // 이런 경우 "undefined" 라는 값을 리턴한다.
        }
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 검사대상값
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
 * @desc   : 유효성 검사에 대한 표현(expression)을 객체화 하였다.
 *             - expression 형식<br>
 *               항목이름:필수항목여부:유효성항목<br>
 *               예) "접수번호:yes:length=6"
 *             - 유효성 항목 형식
 *               유효성항목명=유효값[&유효성항목명=유효값]..
 *               예) "length=13&ssn"
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required 아이템명

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
 * @desc   : valid expression을 parsing한다.
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required 아이템명
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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 검사할 값
 */
function covItemValidExp_validate(value) {
        // 표현식에 필수항목들(아이템명, 필수여부)을 기술하지 않을 경우는 표현식이 없다고 간주.
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
 * @desc   : Grid의 컬럼 유효성 검사 표현식
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required 검사대상 Grid 오브젝트

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
 * @desc   : valid expression을 parsing한다.
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required 검사대상 Grid 오브젝트
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
 * @desc   : validation을 수행한다.
 * @sig    : oDataSet, row
 * @param  : oDataSet required 검사대상 DataSet
 * @param  : row      required 검사대상 DataSet의 특정 row 번호
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
                     null : oDataSet.NameString(i, this.colId).trim();  // DataSet의 data를 trim 시킨다.

                        if (this.itemValidExp != null && !this.itemValidExp.validate(value)) {
                                this.errMsg = this.itemValidExp.errMsg;
                                this.errRow = i;
                                this.errItemName = this.itemValidExp.itemName;
                                return false;
                        }
                }
        }

        // 중복여부 검사
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
 * @desc   : Grid에 대한 유효성검사 표현식
 * @sig    : oGrid
 * @param  : oGrid required 검사대상 Grid

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
 * @desc   : valid expression을 parsing한다.
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
 * @desc   : validation을 수행한다.
 * @sig    : [row[, colId]]
 * @param  : row   optional 검사대상 Grid의 특정 row 번호
 * @param  : colId optional 검사대상 Grid의 특정 컬럼 id
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
 * @desc   : 'length' 항목에 대한 validator. 값이 지정된 길이를 가지고 있는지 검사한다.
 * @param  : length required 유효한 기준길이.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'byteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이를 가지고 있는지 검사한다.
 * @param  : length required 유효한 기준길이.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'minLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'minByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'maxLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'maxByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이하인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'number' 항목에 대한 validator. 값이 숫자인지를 검사한다.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'minNumber' 항목에 대한 validator. 값이 지정된 최소값을 넘는지를 검사한다.
 * @sig    : minNumber
 * @param  : minNumber required 유효한 기준 최소값.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinNumberValidator_validate(value) {
        // 기준값이 숫자가 아닌경우 무조건 true;
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
 * @desc   : 'maxNumber' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.
 * @sig    : maxNumber
 * @param  : maxNumber 유효한 기준 최대값.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxNumberValidator_validate(value) {
        // 기준값이 숫자가 아닌경우 무조건 true;
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
 * @desc   : 'inNumber' 항목에 대한 validator. 값이 지정된 범위 내의 값인지를 검사한다.
 * @sig    : inNumber
 * @param  : inNumber required 숫자의 범위를 나타내는 스트링. 예) "1~100"

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covInNumberValidator_validate(value) {
        // 기준값이 숫자가 아닌경우 무조건 true;
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
 * @desc   : 'minDate' 항목에 대한 validator. 값이 지정된 날짜를 넘는지를 검사한다.
 *           'YYYYMMDD' 형식으로 날짜를 표기해야 한다.
 *             예) minDate=20020315
 * @sig    : minDate
 * @param  : minDate required 유효한 기준 최소값.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'maxDate' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.
 * @sig    : maxDate
 * @param  : maxDate required 유효한 최대날짜값.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 'format' 항목에 대한 validator. 값이 마스크로 표현된 형식과 일치하는지 검사한다.
 *             - format characters
 *               #    : 문자와 숫자
 *               A, Z : 문자 (Z는 공백포함)
 *               0, 9 : 숫자 (9는 공백포함)
 * @sig    : format
 * @param  : format required 포멧 스트링.

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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

                        case 'A' : //영문자인 경우
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

                        case 'Z' : // 영문 한글 포함
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
 * @desc   : 'ssn' 항목에 대한 validator. 입력된 주민등록번호가 유효한지 검사한다.

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
 * @desc   : validation을 수행한다.
 * @sig    : ssn
 * @param  : ssn required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covSsnValidator_validate(ssn) {
        if ( ssn == null || ssn.trim().length != 13 || isNaN(ssn) )  {
                this.message = new coMessage().getMsg(VMSG_ERR_SSN);
                return false;
        }

        var jNum1 = ssn.substr(0, 6);
        var jNum2 = ssn.substr(6);

        /*
          잘못된 생년월일을 검사합니다.
          2000년도부터 성구별 번호가 바뀌였슴으로 구별수가 2보다 작다면
          1900년도 생이되고 2보다 크다면 2000년도 이상생이 됩니다.
          단 1800년도 생은 계산에서 제외합니다.
        */
        bYear = (jNum2.charAt(0) <= "2") ? "19" : "20";

        // 주민번호의 앞에서 2자리를 이어서 4자리의 생년을 저장합니다.
        bYear += jNum1.substr(0, 2);

        // 달을 구합니다. 1을 뺀것은 자바스크립트에서는 1월을 0으로 표기하기 때문입니다.
        bMonth = jNum1.substr(2, 2) - 1;

        bDate = jNum1.substr(4, 2);

        bSum = new Date(bYear, bMonth, bDate);

        // 생년월일의 타당성을 검사하여 거짓이 있을시 에러메세지를 나타냄
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

                // 각 수와 곱할 수를 뽑아냅니다. 곱수가 만일 10보다 크거나 같다면 계산식에 의해 2로 다시 시작하게 됩니다.
                if(k >= 10) k = k % 10 + 2;

                // 각 자리수와 계산수를 곱한값을 변수 total에 누적합산시킵니다.
                total = total + (temp[i] * k);
        }

        // 마지막 계산식을 변수 last_num에 대입합니다.
        last_num = (11- (total % 11)) % 10;

        // laster_num이 주민번호의마지막수와 같은면 참을 틀리면 거짓을 반환합니다.
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
 * @desc   : 'csn' 항목에 대한 validator. 입력된 사업자등록번호가 유효한지 검사한다.

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
 * @desc   : validation을 수행한다.
 * @sig    : csn
 * @param  : csn required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 지정된 스트링들이 들어있을 경우 유효하지 않은것으로 판단한다.
 *           분리자는 ";"를 사용한다. ";" 혹은 ";"문자가 들어간 스트링을 필터링하려 할 경우는
 *           "\\;"라고 표기해야 한다.
 * @sig    : fStr
 * @param  : fStr required filter에 대한 표현

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
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
 * @desc   : 값이 Date형식인지를 검사한다.
 *
 *            format문자 :  YYYY,  -> 4자리 년도
 *                          YY,    -> 2자리 년도. 2000년 이후.
 *                          MM,    -> 2자리 숫자의 달.
 *                          DD,    -> 2자리 숫자의 일.
 *                          hh,    -> 2자리 숫자의 시간. 12시 기준
 *                          HH,    -> 2자리 숫자의 시간. 24시 기준
 *                          mm,    -> 2자리 숫자의 분.
 *                          ss     -> 2자리 숫자의 초.
 *
 *            예)
 *                'YYYYMMDD' -> '20020328'
 *                'YYYY/MM/DD' -> '2002/03/28'
 *                'Today : YY-MM-DD' -> 'Today : 02-03-28'
 *
 *            참고)
 *                  format문자가 중복해서 나오더라도 처음 나온 문자에 대해서만
 *                  format문자로 인식된다. YYYY와 YY, hh와 HH 도 중복으로 본다.
 *                  날짜는 년,월이 존재할 때만 정확히 체크하고 만일 년, 월이 없다면
 *                  1 ~ 31 사이인지만 체크한다.
 *
 * @sig    : dateExp
 * @param  : dateExp required Date Format expression.
 *             예) 2002년 3월 12일 -> "YYYY-MM-DD"(Date Format Expression) -> "2002-03-12"

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
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 검사대상이 되는 Date 스트링 값.
 * @return : boolean - 유효성 여부
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
 * @desc   : 무조건 valid한 결과를 가진 validator.

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
 * @desc   : validation을 수행한다.
 * @return : boolean - 무조건 true.
 */
function covNullValidator_validate() {
        this.message = new coMessage().getMsg(VMSG_VALID);
        return true;
}



