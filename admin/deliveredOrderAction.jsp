
<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");
String email = request.getParameter("email");
String status = "Delivered";

try{

        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

        String sql = "update cart set status ='"+status+"' where product_id='"+id+"' and email = '"+email+"' and address is not null";
        Statement stmt = con.createStatement();
        stmt.executeUpdate(sql);
        response.sendRedirect("ordersReceived.jsp?msg=delivered");


}
catch(Exception e){

    System.out.println(e);
    response.sendRedirect("ordersRecieved.jsp?msg=wrong");


}



%>