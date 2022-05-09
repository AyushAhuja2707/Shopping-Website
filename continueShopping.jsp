<%@ page import="java.sql.*" %>
<%@ include file="footer.jsp"%>

<%
String email = session.getAttribute("email").toString();
String status="processing";

try{
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
  Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
  PreparedStatement pst = con.prepareStatement("update cart set status = ? where email = ? and status = 'bill'");
  pst.setString(1,status);
  pst.setString(2,email);
  pst.executeUpdate();
  response.sendRedirect("home.jsp");


}catch(Exception e){
    System.out.println(e);
}



%>