package net.sms.db;

import java.util.HashMap;
/*
 * SMS발송관련 에러코드작성표
 */
public class SmsErrorCodeMap {
	private HashMap<String, String> map = new HashMap<String, String>();

	public void setErrorCodeMap() {
		map.put("0", "발송성공");
		map.put("1", "타임아웃");
		map.put("A", "핸드폰 호 처리중");
		map.put("B", "음영지역");
		map.put("C", "Power off");
		map.put("D", "메시지 저장개수 초과");
		map.put("2", "잘못된 전화번호");
		map.put("a", "일시 서비스 정지");
		map.put("b", "기타 단말기 문제");
		map.put("c", "착신거절");
		map.put("d", "기타");
		map.put("e", "이통사 SMC 형식 오류");
		map.put("s", "메시지 스팸차단(NPro 내부)");
		map.put("n", "수신번호 스팸차단(NPro 내부)");
		map.put("r", "회신번호 스팸차단(NPro 내부)");
		map.put("t", "스팸차단 중 2개 이상 중복 차단(NPro 내부)");
		map.put("Z", "메시지 접수시 기타 실패");
		map.put("f", "아이하트 자체 형식 오류");
		map.put("g", "SMS/LMS/MMS 서비스 불가 단말기");
		map.put("h", "핸드폰 호 불가 상태");
		map.put("i", "SMC 운영자가 메시지 삭제");
		map.put("j", "이통사 내부 메시지 Que Full");
		map.put("k", "이통사에서 spam 처리");
		map.put("l", "www.nospam.go.kr에 등록된 번호에 대해 아이하트에서 spam 처리한 건");
		map.put("m", "아이하트에서 spam 처리한 건");
		map.put("n", "건수제안에 걸린 경우(건수제안 계약이 되어 있는 경우)");
		map.put("o", "메시지의 길이가 제안된 길이를 벗어난 경우");
		map.put("p", "폰 번호가 형식에 어긋난 경우");
		map.put("Q", "필드 형식이 잘못된 경우(예:데이터 내통이 없는 경우)");
		map.put("x", "MMS 콘텐트의 정보를 참조할 수 없음");
		map.put("u", "BARCODE 생성 실패");
		map.put("q", "메시지 중복키 체크(NPro 내부)");
		map.put("y", "하루에 한 수신번호에 보낼수 있는 메시지 수량초과(NPro 내부)");
		map.put("w", "SMS 전송문자에 특정키워드가 없으면 SPAM 처리하여 메시지 전송제한(NPro 내부)");
		map.put("z", "처리 되지 않은 기타오류");
	}
	public HashMap<String,String> getErrorCodeMap(){
		return map;
	}
}