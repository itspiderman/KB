package com.tool.demo;

import com.jcraft.jsch.UserInfo;

public class localUserInfo implements UserInfo {
	String passwd;
	String passphrase;
	public String getPassword(){ return passwd; }
	public boolean promptYesNo(String str){return true;}
	public String getPassphrase(){ return null; }
	public boolean promptPassphrase(String message){return true; }
	public boolean promptPassword(String message){return true;}
	public void showMessage(String message){}
	localUserInfo(String pwd,String pwdp){
		this.passwd=pwd;
		this.passphrase=pwdp;
	}
}
