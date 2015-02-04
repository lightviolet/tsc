package net.sms.db;

import java.sql.Timestamp;
/*
 * SMS발송 객체 클래스
 */
public class SmsSendInfoBean {
	String id;
	Timestamp sendDate;
	String fromNumber;
	String message;
	String etc;
	int sendTotal;
	int sendSuccess;
	int sendFailure;
	public int getSendTotal() {
		return sendTotal;
	}
	public void setSendTotal(int sendTotal) {
		this.sendTotal = sendTotal;
	}
	public int getSendSuccess() {
		return sendSuccess;
	}
	public void setSendSuccess(int sendSuccess) {
		this.sendSuccess = sendSuccess;
	}
	public int getSendFailure() {
		return sendFailure;
	}
	public void setSendFailure(int sendFailure) {
		this.sendFailure = sendFailure;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Timestamp getSendDate() {
		return sendDate;
	}
	public void setSendDate(Timestamp sendDate) {
		this.sendDate = sendDate;
	}
	public String getFromNumber() {
		return fromNumber;
	}
	public void setFromNumber(String fromNumber) {
		this.fromNumber = fromNumber;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}

}
