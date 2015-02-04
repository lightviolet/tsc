package net.sms.db;

import java.sql.Timestamp;
/*
 * SMS결과객체 클래스
 */
public class SmsReportInfoBean {
	String toNumber;
	Timestamp sentDate;
	Timestamp receiveDate;
	String resultCode;
	String etc;
	public String getToNumber() {
		return toNumber;
	}
	public void setToNumber(String toNumber) {
		this.toNumber = toNumber;
	}
	public Timestamp getSentDate() {
		return sentDate;
	}
	public void setSentDate(Timestamp sentDate) {
		this.sentDate = sentDate;
	}
	public Timestamp getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(Timestamp receiveDate) {
		this.receiveDate = receiveDate;
	}
	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
}
