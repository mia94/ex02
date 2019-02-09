<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
	table {
		border-collapse: collapse;
	}
	td{
		border: 1px solid #ccc;
		padding: 5px;
	}
</style>
<title>Insert title here</title>
</head>
<body>

<div class="container">

 	<!-- <form class="" action="post"> -->
    <div class="form-group">
      <label class="control-label col-sm-2" for="id">아이디</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="userid" name="userid">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="name">이름</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="username" name="username">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd">비밀번호</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="userpw" name="userpw">
      </div>
    </div>
     <div class="form-group">
      <label class="control-label col-sm-2" for="email">이메일</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="email" name="email">
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="button" class="btn btn-default btnAdd">추가</button>
        <button type="button" class="btn btn-default">리스트 가져오기</button>
      </div>
    </div>
  <!-- </form> -->
  
  <!-- 리스트 -->
  <div id="memberlist">
  	
  </div>
  <script>

  
	  function getPageList(){
		  $.ajax({
				url:"${pageContext.request.contextPath}/member/list",
				type:"get",
				dataType:"json",
				success:function(json){
					console.log(json);
					$("#memberlist").empty();//안에만 비우기
				
				var source = $("#template1").html();
				var f = Handlebars.compile(source);
				var result = f(json);
				$("#memberlist").append(result);
				/* 	$(json).each(function(i,obj){
					var divTag = $("<p>").text(obj.username);
					$("#memberlist").append(divTag);
				})  */
				}
			})
	  }
	  
	  
	  $(function(){
		  getPageList();
		  
		  $(".btnAdd").click(function(){
				//값 넘겨주기
				var userid = $("#userid").val();
				var username = $("#username").val();
				var userpw = $("#userpw").val();
				var email = $("#email").val();
				//@RequestBody를 사용했기때문에
				var jsonBody = {userid:userid, username:username, userpw:userpw, email:email};
				//@RequestBody를 사용했으면headers, JSON.stringify를 반드시 사용해야함
				$.ajax({
					url:"member/",
					type:"post",
					headers:{
						"Content-Type":"application/json",
						"X-HTTP-Method-Override":"POST"
					},
					data:JSON.stringify(jsonBody),/*JSON.stringify는 {bno:bno, replyer:replyer, replytext:replytext}이런 스트링으로 변환*/
					dataType:"text",/*String으로 반환되면 객체가 아니기때문에 json이 아닌 text로 받아야함*/
					success:function(json){
						console.log(json);
						if(json=="success"){
							alert("등록하였습니다.");
							getPageList(1);
						}
					}
				})
			})
	  })
  </script>
  <script id="template1" type="text/x-handlebars-template"> 
 	<table>
		<tr>
			<td>{{userid}}</td>
			<td>{{username}}</td>
			<td>{{userpw}}</td>
			<td>{{email}}</td>
			<td>
				<button type="button" class="btn btn-default">수정</button>
        		<button type="button" class="btn btn-default">삭제</button>
			</td>
		</tr>
	</table>
  </script>
</div>
</body>
</html>