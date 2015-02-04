<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="net.sms.db.*" %>
<%
response.setContentType("text/html; charset=utf-8");
System.out.println("파일읽으러 들어옴");
String savePath = request.getServletContext().getRealPath("file");
// 파일 크기 15MB로 제한
int sizeLimit = 1024 * 1024 * 15;

MultipartRequest multi = new MultipartRequest(request, savePath,
		sizeLimit, "utf-8", new DefaultFileRenamePolicy());

System.out.println(savePath);
//대화상자에서 보낸 파일정보 받아오기
String fileName = multi.getFilesystemName("fileName");

// 업로드한 파일의 전체 경로담기
String m_fileFullPath = savePath + "/" + fileName;
ArrayList<String> list = new ArrayList<String>();
int index =0;

//파일내용읽기
try {
	System.out.println("파일읽기");
	BufferedReader br  =  new BufferedReader(new InputStreamReader(new FileInputStream(m_fileFullPath),"UTF-8"));
	String line = null;
	while ((line = br.readLine()) != null) { // 라인단위 읽기
		System.out.println(line);
		String[] data = line.split("/");
		for(int i=0; i<data.length; i++){
			data[i] = data[i].replaceAll("-", "");
			if(data[i].matches("[0-9]{10,11}")){  
				list.add(data[i]);
			} 
		}
	}
	//업로드해서 읽은파일 바로 삭제	
	File f = new File(m_fileFullPath);
	if( f.exists() ){
		f.delete();
	}
} catch (IOException e) {
	System.out.println(e.toString()); // 에러 발생시 메시지 출력
}
//리스트에 들어갈내용 확인
for(int i=0; i<list.size(); i++){
	System.out.println(list.get(i));
}
%>
<!-- 셀렉트박스에 읽은내용 추가 -->
<script>
var list = [];
<%for(int i=0; i<list.size(); i++){%>
list[<%=i%>]=String("<%=list.get(i)%>");
<%}%>
for(var i=0; i<list.length; i++){
window.opener.addOption(list[i], list[i]);
self.close(); 
}
window.close();
</script>