package net.common.constants;
//로그인에 대한 정보인터페이스
public interface MemberLoginCheck
{
	int LOGIN_SUCCESS		= 0;
	int ID_NOT_FOUND 		= 1;
	int PASSWORD_MISMATCH 	= 2;
	int ALREADY_LOGIN       = 3;
}
