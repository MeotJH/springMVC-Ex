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
	
		
	function displayTime(timeValue){
		
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		
		var str = "";
		
		if ( gap < (1000 * 60 * 60 * 24 )){
			
			// 갭이 저 숫자들보다 작다는게 무슨 의미지? -> 60*60*24 는 하루를 초로 계산한거고 *1000은 밀리세컨드로 변환한것 즉 gap(지금날짜 - timevalue)이게 밀리세컨드로 값을 가지고 있나봄 그러니,
			// if문 조건은 하루보다 gap이라는 변수가 작다면 라는 뜻
			
			var hh = dateObj.getHours();
			var mm = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mm > 9 ? '' : '0') + mm , ':' , ( ss > 9 ? '' : '0') + ss ].join('');
		} else {
			
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1 ; 
			var dd = dateObj.getDate();
			
			return [ yy, '/', ( mm > 9 ?'' : '0') + mm, '/', ( dd > 9 ? '' : '0') + dd].join('');
			
		}
	};
	
	
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
		};




})();