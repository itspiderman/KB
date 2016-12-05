package com.tool.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;
import java.util.Vector;
import java.awt.Robot;
import java.awt.event.KeyEvent;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;


/**
 * @author YangHua ???????:http://www.xfok.net/2009/10/124485.html
 */
public class MySFTP {

	/**
	 * connect sftp server
	 * 
	 * @param host
	 * @param port
	 * @param username
	 * @param password
	 * @return
	 */
	public ChannelSftp connect(String host, int port, String username,
			String password) {
		ChannelSftp sftp = null;
		try {
			JSch jsch = new JSch();
			//jsch.getSession(username, host, port);
			Session sshSession = jsch.getSession(username, host, port);
			System.out.println("Session created.");
			sshSession.setPassword(password);
			
			localUserInfo lui=new localUserInfo(password,null);			
			sshSession.setUserInfo(lui);
			
			Properties sshConfig = new Properties();
			sshConfig.put("StrictHostKeyChecking", "no");
			sshSession.setConfig(sshConfig);
			System.out.println("session connect");	
			
			//Press ENTER
	        Robot r = new Robot();
	        

			r.keyPress(KeyEvent.VK_ENTER);
	        r.keyRelease(KeyEvent.VK_ENTER);
			sshSession.connect();
			r.keyPress(KeyEvent.VK_ENTER);
	        r.keyRelease(KeyEvent.VK_ENTER);
			
			System.out.println("Session connected.");
			System.out.println("Opening Channel.");
			Channel channel = sshSession.openChannel("sftp");
			channel.connect();
			sftp = (ChannelSftp) channel;
			System.out.println("Connected to " + host + ".");
		}
			catch(JSchException ex){
			System.out.println(ex.toString());			
		}		
		catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();

		}
		return sftp;
	}

	/**
	 * upload file
	 * 
	 * @param directory : upload destination folder
	 * @param uploadFile : upload file name
	 * @param sftp
	 */
	public void upload(String directory, String uploadFile, ChannelSftp sftp) {
		try {
			sftp.cd(directory);
			File file = new File(uploadFile);
			sftp.put(new FileInputStream(file), file.getName());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * download file
	 * 
	 * @param directory : download path
	 * @param downloadFile : downlaod file name
	 * @param saveFile : local path to save the dowload file
	 * @param sftp
	 */
	public void download(String directory, String downloadFile,
			String saveFile, ChannelSftp sftp) {
		try {
			sftp.cd(directory);
			File file = new File(saveFile);
			sftp.get(downloadFile, new FileOutputStream(file));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * delete file
	 * 
	 * @param directory : delet file path
	 * @param deleteFile: delete file name
	 * @param sftp
	 */
	public void delete(String directory, String deleteFile, ChannelSftp sftp) {
		try {
			sftp.cd(directory);
			sftp.rm(deleteFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * list file detail
	 * 
	 * @param directory : folder path
	 * @param sftp
	 * @return
	 * @throws SftpException
	 */
	public Vector listFiles(String directory, ChannelSftp sftp)
			throws SftpException {
		return sftp.ls(directory);
	}

	public static void main(String[] args) {
		MySFTP sf = new MySFTP();
		String host = "130.36.186.168";
		int port = 22;
		String username = "zgwaspla";
		String password = "GplSep23";
		String directory = "/home/users/zgwaspla/kv/";		
		String downloadFile = "linux.txt";
		String uploadFile = "C:/Ddriver/project/tmp/sftp/window.txt";
		String saveFile = "C:/Ddriver/project/tmp/sftp/linux_d.txt";
		//String deleteFile = "delete.txt";
		ChannelSftp sftp = sf.connect(host, port, username, password);
		sf.upload(directory, uploadFile, sftp);
		sf.download(directory, downloadFile, saveFile, sftp);
		// sf.delete(directory, deleteFile, sftp);
		try {
			sftp.cd(directory);
			//sftp.mkdir("ss");
			System.out.println("finished");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
