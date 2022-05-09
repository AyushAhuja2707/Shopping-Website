<%@ page import="java.sql.*" %>
<%@ include file="changeDetailsHeader.jsp"%>
<%@ include file="footer.jsp"%>
<html>
<head>
<link rel="stylesheet" href="css/changeDetails.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Add or Change Address</title>

<style>
body{
  background-image: url('https://ordinaryfaith.net/wp-content/uploads/2016/03/Gray-plain-website-background.jpg');
  background-repeat: no-repeat;
  background-size: cover;

}
</style>
</head>
<body>
<%
String msg = request.getParameter("msg");
if("valid".equals(msg)){

%>
<h3 class="alert">Address Successfully Updated !</h3>
<%}
if("invalid".equals(msg)){
    %>
<h3 class="alert">Some thing Went Wrong! Try Again!</h3>
<%
}%>
<%
 try{
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from users where email ='"+email+"'");
        while(rs.next()){

%>
<form method="post">
<h3>Enter Address</h3>
<%
String addr = rs.getString(7)+"";
 if(addr.equals("null")) {
%>
<input class="input-style" type="text" name="address" value="" placeholder="Enter Address " required>
 <%}
  else{
  %>

 <input class="input-style" type="text" name="address" value="<%=rs.getString(7)%>" placeholder="Enter Address " required>
 <%}%>
 <hr>
 <h3>Enter city</h3>
<%
String cit = rs.getString(8)+"";
 if(cit.equals("null")) {
%>
<input class="input-style" type="text" name="city" value="" placeholder="Enter City " required>
 <%}
  else{
  %>

 <input class="input-style" type="text" name="city" value="<%=rs.getString(8)%>" placeholder="Enter City " required>
 <%}%>
<hr>
<h3>Enter State</h3>
<%
String sta = rs.getString(9)+"";
 if(sta.equals("null")) {
%>
<input class="input-style" type="text" name="state" value="" placeholder="Enter State " required>


<%}
  else{
  %>

 <input class="input-style" type="text" name="state" value="<%=rs.getString(9)%>" placeholder="Enter State " required>
<%}%>
<hr>
<h3>Enter country</h3>
<%
String ctry = rs.getString(10)+"";
 if(ctry.equals("null")) {
%>

<input class="input-style" type="text" name="country" value="" placeholder="Enter Country " required>
<%}
  else{
  %>
 <input class="input-style" type="text" name="country" value="<%=rs.getString(10)%>" placeholder="Enter Country " required>
<%}%>
<hr>
 <button class="button" type="submit" name="b1">Save<i class='far fa-arrow-alt-circle-right'></i></button>
 </form>
<%
    }
    }catch(Exception e){
        System.out.println(e);
    }
%>
</body>
<br><br><br>
<br><br><br>
</html>

<%
   
if(request.getParameter("b1")!=null){
  String email1 = session.getAttribute("email").toString();
  String address = request.getParameter("address");
  String city = request.getParameter("city");
  String state = request.getParameter("state");
  String country = request.getParameter("country");

  try{
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
        PreparedStatement ps = con.prepareStatement("update users set address =? ,city=? ,state=? , country = ? where email =?");
        ps.setString(1,address);
        ps.setString(2,city);
        ps.setString(3,state);
        ps.setString(4,country);
        ps.setString(5,email1);
        ps.executeUpdate();
        response.sendRedirect("addChangeAddress.jsp?msg=valid");

}catch(Exception e){
    System.out.println(e);
    response.sendRedirect("addChangeAddress.jsp?msg=invalid");

}
}

%>



