<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.replyLi .item{
		border-bottom:1px solid #ddd;
		padding: 5px;
		width: 400px;
	}
	.reply .rno{
		font-weight: bold;
	}
	.pagination li{
		list-style: none;
		float: left;
		padding: 3px;
		border: 1px solid black;
		margin: 3px;
	}
	.pagination li a{
		margin: 3px;
		text-decoration: none;
		color: black;
	}
	.pagination .active a{
		color:blue;
		background-color: yellow;
	}
	#modDiv{
		width:300px;
		height: 100px;
		background-color: gray;
		position: absolute;
		left: 40%;
		top: 40%;
		padding: 10px;
		z-index: 1000;
		display: none;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="template1" type="text/x-handlebars-template"> 
{{#each.}}
<li data-rno="{{rno}}" class="replyLi">
<div class="item">
	<span class="rno">{{rno}}</span> : <span class="writer">{{replyer}}</span><br>
	<span>{{replytext}}</span>
	<div class="btnWrap">
		<button class="modify">수정</button>
		<button class="delete">삭제</button>
	</div>
</div>
</li>
{{/each}}
</script>
<script>
	var bno = 2049;
	function getPageList(page){
		$.ajax({
			url:"replies/"+bno+"/"+page,
			type:"get",
			dataType:"json",
			success:function(json){
				console.log(json);
				
			/* <li data-rno="1" class="replyLi">
				<div class="item">
					<span class="rno">1</span> : <span class="writer">user</span><br>
					<span>댓글내용</span>
					<div class="btnWrap">
						<button class="modify">수정</button>
						<button class="delete">삭제</button>
					</div>
				</div>
			</li> */
			$("#replies").empty();
			
			var source = $("#template1").html();
			var f = Handlebars.compile(source);
			var result = f(json.list);
			$("#replies").append(result);
			/*이제 핸들바즈로 이용할 것 
		
			$(json.list).each(function(i,obj){
				var liTag = $("<li>").attr("data-rno",obj.rno).attr("class","replyLi");
				var divTag = $("<div>").addClass("item");
				var rnoSpanTag = $("<span>").addClass("rno").text(obj.rno);
				var writerSpanTag = $("<span>").addClass("writer").text(obj.replyer);
				var contentSpanTag = $("<span>").text(obj.replytext);
				var btnDivTag = $("<div>").addClass("btnWrap");
				var btnModifyTag = $("<button>").addClass("modify").text("수정");
				var btnDeleteTag = $("<button>").addClass("delete").text("삭제");
				
				liTag.append(divTag);
				divTag.append(rnoSpanTag).append(" : ").append(writerSpanTag).append("<br>");
				divTag.append(contentSpanTag);
				divTag.append(btnDivTag);
				btnDivTag.append(btnModifyTag).append(btnDeleteTag);
				
				$("#replies").append(liTag);
			}) */
			//pagination
			/* <li class="active"><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li> */
			$(".pagination").empty();
			for(var i=json.pageMaker.startPage;i<=json.pageMaker.endPage;i++){
				var liTag = $("<li>");
				var aTag = $("<a>").attr("href","#").text(i);
				if(i==json.pageMaker.cri.page){
					liTag.attr("class","active");
				}
				liTag.append(aTag);
				$(".pagination").append(liTag);
			}
			

			}
		})
	}
	$(function(){
		getPageList(1);
		
		$("#bno").val(bno);
		
		$("#btnAdd").click(function(){
			//bno, replyer, replytext넘겨주기
			var bno = $("#bno").val();
			var replyer = $("#replyer").val();
			var replytext = $("#replytext").val();
			//@RequestBody를 사용했기때문에
			var jsonBody = {bno:bno, replyer:replyer, replytext:replytext};
			//@RequestBody를 사용했으면headers, JSON.stringify를 반드시 사용해야함
			$.ajax({
				url:"replies/",
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
		
		$(document).on("click",".modify",function(){
			var rno = $(this).parents(".replyLi").attr("data-rno");
			$("#modDiv").find(".modal-title").text(rno);
			
			var text = $(this).parent().prev().text();
			$("#replyModText").val(text);
			
			$("#modDiv").show();
		})
		
		$("#btnCancel").click(function(){
			$("#modDiv").hide();
		})
		
		$("#btnReplyMod").click(function(){
			var rno = $(".modal-title").text();
			var replytext = $("#replyModText").val();
			var jsonBody = {replytext:replytext};
			$.ajax({
				url:"replies/"+rno,
				type:"put",
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"PUT"
				},
				data:JSON.stringify(jsonBody),
				dataType:"text",
				success:function(json){
					console.log(json);
					if(json == "success"){
						alert(rno+"가 수정되었습니다.");
					}
					//수정완료되면 창 닫기
					$("#modDiv").hide();
					getPageList(1);
				}
			})
		})
		//삭제
		$(document).on("click",".delete",function(){
			var rno = $(this).parents(".replyLi").attr("data-rno");
			$.ajax({
				url:"replies/"+rno,
				type:"delete",
				dataType:"text",
				success:function(json){
					console.log(json);
					if(json == "success"){
						alert(rno+"가 삭제되었습니다.");
					}
					getPageList(1);
				}
			})
		})
		
		$(document).on("click","pagination a",function(e){
			e.preventDefault();
			
			var num = $(this).text();
			getPageList(num);
		})
		
	})
</script>
</head>
<body>
	<div id="modDiv">
		<div class="modal-title">rno</div>
		<div>
			<input type="text" id="replyModText" size=30>
		</div>
		<div>
			<button id="btnReplyMod">수정</button>
			<button id="btnCancel">취소</button>
		</div>
	</div>
	
	<h2>Ajax Test Page</h2>
	
	<div>
		<div>
			bno : <input type="text" name="bno" id="bno">
		</div>
		<div>
			replyer : <input type="text" name="replyer" id="replyer">
		</div>
		<div>
			replytext : <input type="text" name="replytext" id="replytext">
		</div>
		<button id="btnAdd">ADD REPLY</button>
	</div>
	
	<ul id="replies"> <!-- list -->
		<!-- <li data-rno="1" class="replyLi">
			<div class="item">
				<span class="rno">1</span> : <span class="writer">user</span><br>
				<span>댓글내용</span>
				<div class="btnWrap">
					<button class="modify">수정</button>
					<button class="delete">삭제</button>
				</div>
			</div>
		</li> -->
	</ul>
	
	<ul class="pagination"><!-- page번호 -->
		<!-- <li class="active"><a href="#">1</a></li>
		<li><a href="#">2</a></li>
		<li><a href="#">3</a></li> -->
	</ul>
</body>
</html>













