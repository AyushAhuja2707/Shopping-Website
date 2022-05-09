<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<%-- <link rel="stylesheet" href="css/signup-style.css"> --%>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="./css/signup_dani.css" />
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
/>
<link
  href="https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600"
  rel="stylesheet"
  type="text/css"
/>
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
<script>

function verifyPassword() {  
  var pw = document.getElementById("pwd").value;  
  //check empty password field  
  //minimum password length validation  
  if(pw.length < 6) {  
     alert("**Password length must be atleast 6 characters");  
     return false;  
  }  
  
//maximum length of password validation  
  if(pw.length > 15) {  
     alert("**Password length must not exceed 15 characters");  
     return false;  
  }
  
 
 
  

}  

      function show() {
        var password = document.getElementById("pwd");
        var icon = document.querySelector(".fas");

        // ========== Checking type of password ===========
        if (password.type === "password") {
          password.type = "text";
        } else {
          password.type = "password";
        }
      }
</script>
<title>Signup</title>
</head>
<body class="body">
<div class="login-page">
        <div class="form">
          <form onsubmit ="return verifyPassword()" method="post" >
            <lottie-player
              src="https://assets4.lottiefiles.com/datafiles/XRVoUu3IX4sGWtiC3MPpFnJvZNq7lVWDCa8LSqgS/profile.json"
              background="transparent"
              speed="1"
              style="justify-content: center"
              loop
              autoplay
            ></lottie-player>
            <input type="text" name = "name" placeholder="Enter Name:" required>
        <input type="email" name = "email" placeholder="Enter Email:" required>
        <input type="text" name = "mobileNumber" placeholder="Enter Mobile  No.:" minlength="10" pattern="[0-9]{10}" required>
        <select name="securityQuestion" required>
          <option values='What was your First Car?'>What was your First Car?</option>
          <option values='First Pet Name?'>First Pet Name?</option>
          <option values='Born City?'>Born City?</option>
        </select>
        <input type="text" name = "answer" placeholder="Enter Security Answer" required>
        <input type="password" name = "password" id="pwd" placeholder="Enter Password:" minlength="6" required>
            <i class="fas fa-eye" onclick="show()"></i>
            <br><br>
            <button  name = "b1" >
              SIGN UP
            </button>
            <br>
          </form>

          <form class="login-form">
          
          <button type="button" onclick="window.location.href='login.jsp'">
              LOGIN
            </button>
            
          </form>
          <%
            String msg = request.getParameter("msg");
            if("valid".equals(msg))
            {
              %>

            <h1>Successfully Registered</h1>
            <%}%>
            <%if("invalid".equals(msg))
           {
            %>
            <h1>Some thing Went Wrong! Try Again !</h1>
            <%}%>
              <%-- <h3>Hell</h3> --%>
        </div>
      </div>
  <div class='whysign'>
<%
  if(request.getParameter("b1")!=null ){
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String mobileNumber = request.getParameter("mobileNumber");
    String securityQuestion = request.getParameter("securityQuestion");
    String answer = request.getParameter("answer");
    String password = request.getParameter("password");
    String address="";
    String city="";
    String state = "";
    String country ="";
    try{
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

                String sql = "insert into users values(?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1,name);
                pst.setString(2,email);
                pst.setString(3,mobileNumber);
                pst.setString(4,securityQuestion);
                pst.setString(5,answer);
                pst.setString(6,password);
                pst.setString(7,address);
                pst.setString(8,city);
                pst.setString(9,state);
                pst.setString(10,country);
                
                pst.executeUpdate();
                response.sendRedirect("signup.jsp?msg=valid");
    }catch(Exception e){
                out.println(e);
                response.sendRedirect("signup.jsp?msg=invalid");
                
    }

  }


%>

  </div>
</div>

</body>
</html>