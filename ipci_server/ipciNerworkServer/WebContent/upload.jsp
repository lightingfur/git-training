<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
/*
	String mobile_str1 = request.getParameter("mobile_str1");
	String mobile_str2 = request.getParameter("mobile_str2");
	
	System.out.println("mobile_str1 : " + mobile_str1);
	System.out.println("mobile_str2 : " + mobile_str2);
*/
	//upload폴더까지의 경로를 얻어온다 
	String path = getServletContext().getRealPath("upload");
	System.out.println(path);
	//최대파일 용량 
	int max = 1024*1024*10; //100mb
	//이름 변경정책
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	//업로드 처리
	MultipartRequest mr = new MultipartRequest(request,path,max,"utf-8",policy);
	
	String mobile_str1 = mr.getParameter("mobile_str1");
	String mobile_str2 = mr.getParameter("mobile_str2");
	String mobile_image = mr.getParameter("mobile_image");
	
	String mobile_see = mr.getParameter("see");
	String mobile_right = mr.getParameter("right");
	int see = Integer.parseInt(mobile_see);
	int right = Integer.parseInt(mobile_right);
	
	
/*	
	System.out.println("mobile_str1 : " + mobile_str1);
	System.out.println("mobile_str2 : " + mobile_str2);
	System.out.println("mobile_image : " + mobile_image);
*/
	//JDBC 드라이버 로딩 
	Class.forName("oracle,jdbc.OracleDriver");
	String url ="db주소 ";
	String id = "이름";
	String pw="1234";
	
	//데이터베이스 접속 
	Connection db = DriverManager.getConnection(url,id,pw);
	
	//쿼리문 
	String sql = "insert into mobile_table "
				+"(mobile_idx,mobile_img,mobile_str1,mobile_str2,mobile_see,mobile_right)"
				+"values (mobile_seq.nextval,?,?,?,?,?)";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, mobile_image);
	pstmt.setString(2, mobile_str1);
	pstmt.setString(3, mobile_str2);
	pstmt.setInt(4, see);
	pstmt.setInt(5, right);
	
	pstmt.execute();
	db.close();

%>
OK



