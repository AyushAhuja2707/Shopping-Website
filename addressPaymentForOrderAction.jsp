<%@ page import="java.sql.*" %>

<%
String email = session.getAttribute("email").toString();
String address = request.getParameter("address");

String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("country");

String mobileNumber = request.getParameter("mobileNumber");

String paymentMethod = request.getParameter("paymentMethod");

String transactionId = "";
transactionId = request.getParameter("transactionid");
String status = "bill";

try{
    
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

        String sql = "update users set address = ?,city =?,state=?,country=?,mobileNumber=? where email=?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1,address);
        pst.setString(2,city);
        pst.setString(3,state);
        pst.setString(4,country);
        pst.setString(5,mobileNumber);
        pst.setString(6,email);
        pst.executeUpdate();

        PreparedStatement ps1 = con.prepareStatement("update cart set address = ?,city =?,state=?,country=?,mobileNumber=?,orderDate=TO_CHAR(SYSDATE, 'yyyy/mm/dd'),deliveryDate= TO_CHAR(SYSDATE + INTERVAL '10' DAY,'yyyy/mm/dd')  ,paymentMethod = ?,transactionId = ?,status='"+ status +"' where email = ? and address is NULL");
        ps1.setString(1,address);
        ps1.setString(2,city);
        ps1.setString(3,state);
        ps1.setString(4,country);
        ps1.setString(5,mobileNumber);
        ps1.setString(6,paymentMethod);
        ps1.setString(7,transactionId);
        ps1.setString(8,email);
        ps1.executeUpdate();
        response.sendRedirect("bill.jsp");
}
catch(Exception e){
    System.out.println(e);
}


%>