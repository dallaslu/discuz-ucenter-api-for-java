<%
/**
 * ================================================
 * Discuz! Ucenter API for JAVA
 * ================================================
 * JSP 调用示例
 * 
 * 更多信息：http://code.google.com/p/discuz-ucenter-api-for-java/
 * 作者：梁平 (no_ten@163.com) 
 * 创建时间：2009-2-20
 */
%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.fivestars.interfaces.bbs.util.XMLHelper"%>
<%@page import="com.fivestars.interfaces.bbs.client.Client"%>
<%
Client uc = new Client();
String result = uc.uc_user_login("liangping2", "liangping");

LinkedList<String> rs = XMLHelper.uc_unserialize(result);
if(rs.size()>0){
	int $uid = Integer.parseInt(rs.get(0));
	String $username = rs.get(1);
	String $password = rs.get(2);
	String $email = rs.get(3);
	if($uid > 0) {
		response.addHeader("P3P"," CP=\"CURa ADMa DEVa PSAo PSDo OUR BUS UNI PUR INT DEM STA PRE COM NAV OTC NOI DSP COR\"");

		out.println("登录成功");
		out.println($username);
		out.println($password);
		out.println($email);
		
		String $ucsynlogin = uc.uc_user_synlogin($uid);
		out.println("登录成功"+$ucsynlogin);

		//本地登陆代码
		//TODO ... ....
		
		Cookie auth = new Cookie("auth", uc.uc_authcode($password+"\t"+$uid, "ENCODE"));
		auth.setMaxAge(31536000);
		//auth.setDomain("localhost");
		response.addCookie(auth);
		
		Cookie user = new Cookie("uchome_loginuser", $username);
		response.addCookie(user);
		
	} else if($uid == -1) {
		out.println("用户不存在,或者被删除");
	} else if($uid == -2) {
		out.println("密码错");
	} else {
		out.println("未定义");
	}
}else{
	out.println("Login failed");
	System.out.println(result);
}
%>