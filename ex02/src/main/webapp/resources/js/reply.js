console.log("Reply Module..............");

var replyService = (function(){
	
	function add(reply, callback, error){
		
		console.log("add reply................");
		
		$.ajax({
			type :'post',
			url  : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset = utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error){
		
		console.log("param:"+ param.page);
		var bno = param.bno;
		var page = param.page || 1; // get에서 함수 선언할때 부여하는 객체 (말그대로 메소드 파라미터잖아 바보야!)
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
			function(data){
				if(callback){
					callback(data);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	function remove(rno, callback, error){
		
		$.ajax({
			
			type: 'delete',
			url : '/replies/' + rno,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				
				if(error){
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback, error){
		
		console.log("RNO: " + reply.rno);
		
		$.ajax({
			
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8", success : function(result, status, xhr){
				if (callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
		
		}
	
	function get(rno, callback, error){
		
		// url로받아서 함수에 제이슨 방식으로 넣는건가?
		
		$.get("/replies/" + rno + ".json", function(result){
			
			if(callback){
				
				callback(result);
			}
		})
		.fail(function(xhr, status, err){
			
			if(error){
				error();
			}
		});
	}	
	
	
	
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
		};




})();