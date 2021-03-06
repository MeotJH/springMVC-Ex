<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">Board Read</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

          <div class="form-group">
          <label>Bno</label> <input class="form-control" name='bno'
            value='<c:out value="${board.bno }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Title</label> <input class="form-control" name='title'
            value='<c:out value="${board.title }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Text area</label>
          <textarea class="form-control" rows="3" name='content'
            readonly="readonly"><c:out value="${board.content}" /></textarea>
        </div>

        <div class="form-group">
          <label>Writer</label> <input class="form-control" name='writer'
            value='<c:out value="${board.writer }"/>' readonly="readonly">
        </div>

<%-- 		<button data-oper='modify' class="btn btn-default">
        <a href="/board/modify?bno=<c:out value="${board.bno}"/>">Modify</a></button>
        <button data-oper='list' class="btn btn-info">
        <a href="/board/list">List</a></button> --%>


<button data-oper='modify' class="btn btn-default">Modify</button>
<button data-oper='list' class="btn btn-info">List</button>

<%-- <form id='operForm' action="/boad/modify" method="get">
  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
</form> --%>


<form id='operForm' action="/boad/modify" method="get">

  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
  <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
  <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>

 
</form>


<div class='row'>


	<div class="col-lg-12">
	
		<div class="panel panel-default">
				
		
			<div class = "panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			</div>
			<div class="panel-body">
				
				<ul class="chat">
					<!--  start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2018-01-01 13:13</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
				</ul>
			
			</div>
			
		</div>
	
	</div>
	
</div>
      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<!--  모달창 코드 -->
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name="reply" value="New Reply!!!!">
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name="replyDate" value=''>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">close</button>
				<button id='modalClassBtn' type="button" class="btn btn-default" data-dismiss='modal'>close</button>
			</div>
		</div>
	</div>
</div>

<!--  모달창 코드  끝 --> 
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

$(document).ready(function(){

	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
		showList(1);
		
	function showList(page){
		
		replyService.getList({bno:bnoValue,page: page || 1}, function(list){
		
			var str="";
			
			if(list == null || list.length == 0 ){
				
				replyUL.html("");
				
				return;
			}
			
			for ( var i = 0 , len = list.length || 0 ; i< len ; i ++){
				
				str+= "<li class='left clearfix' data-rno = '"+list[i].rno+"'>";
				str+= " <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
				str+= "   <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str+= "  <p>"+list[i].reply+"</p></div></li>"
				
				
				
			}
			
			replyUL.html(str);
			
			//클래스 chat의 내용을 str로 채우는데 str 내용에 DB에 저장된 값들을 가져오는 코드가 되어있음
			
		});// end function
	}//end showList
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name.'reply']");
	
	
});

</script>

<!--  <script>

console.log("=================");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';


//댓글 리스트 불러오는제이쿼
replyService.getList({bno:bnoValue, page:1}, function(list){
	
	for(var i = 0, len = list.length||0 ; i < len ; i ++){
		console.log(list[i]);
	}
	
});

//댓글 추가하는 제이쿼리
replyService.add(
		{reply:"JS test", replyer:"tester", bno:bnoValue}
		,
		function(result){
			alert("Result:" + result);
		}
	);

//댓글 삭제하는 코드
replyService.remove(31, function(count){

	console.log(count);
	
	if( count === "success"){
		alert("REMOVE");
	}
}, function(err){
	
	alert("ERROR....");
});

//댓글 수정하는 코드
replyService.update({rno : 22, bno:bnoValue, reply : "modified Reply......"}, function(result){

	alert("수정 완료...")
});

replyService.get(10, function(data){
	
	console.log(data);
});


</script>-->

<script type="text/javascript">
$(document).ready(function() {
  
  var operForm = $("#operForm"); 
  
  $("button[data-oper='modify']").on("click", function(e){
    
    operForm.attr("action","/board/modify").submit();
    
  });
  
    
  $("button[data-oper='list']").on("click", function(e){
    
    operForm.find("#bno").remove();
    operForm.attr("action","/board/list")
    operForm.submit();
    
  });  
});
</script>


<%@include file="../includes/footer.jsp"%>
