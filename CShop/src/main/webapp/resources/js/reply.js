/**
 * 
 */
 
 var replyService = (function() {
 
 	function add(reply, callback, error) {
 		
 		$.ajax({ 
 			type: 'post',
			url: '/clothes/replies/new',
			data: JSON.stringify(reply),
			dataType: 'json',
			contentType: "application/json; charset=utf-8",
			success: function(result) {
				if(callback) {
					callback(result);
				}
			},
			error: function(er) {
				if(error) {
					error(er);
				}
			}
 		})
	}  // add 
 
 	function get(rno, callback , error) {
 		
 		$.get("/clothes/replies/"+rno, function(result) {
 			if(callback) {
 				callback(result);
 			}
 		}).fail(function(er) {
			if(er) {
				error();
			}
		})
 	} // get
 	
 	function getList(param, callback, error) {
 		var page = param.page || 1;
 		var cno = param.cno;
 		
 		$.getJSON("/clothes/replies/"+cno+"/"+page+".json", function(result) {
 			if(callback) {
 				callback(result);
 			}
 		}).fail(function(er) {
			if(er) {
				error();
			}
		}) 
 	}
 	
 	function remove(rno, callback, error) {
 	
 		$.ajax({
 			type: 'delete',
 			url: '/clothes/replies/'+rno,
 			contentType: "application/json; charset=utf-8",
 			success: function(result) {
 				if(callback) {
 					callback(result);
 				}
 			},
 			error: function(er) {
 				error(er);
 			}
 		})
 	}
 	
 	function modify() {
 	
 	}
 	
 	function formatTime(time) {
 		
 		var today = new Date();
 		
 		var gap = today.getTime() - time;
 		
 		var dateObj = new Date(time);
 		
 		if( gap < 1000 * 60 * 60 * 24) {
 			var hh = dateObj.getHours();
 			var mi = dateObj.getMinutes();
 			var ss = dateObj.getSeconds();
 			var yy = dateObj.getFullYear();
 			var mm = dateObj.getMonth() + 1;
 			var dd = dateObj.getDate();
 			
 			return [ yy, '.', ( mm > 9 ? '' : '0' ) + mm , '.', (dd > 9 ? '' : '0' ) + dd , ". " ,
 			(hh > 9 ? '' : '0' ) + hh , ':', (mi > 9 ? '' : '0' ) + mi , ':' , (ss > 9 ? '' : '0' ) + ss].join('');
 		} 
 	}
 	
 	return {
 		
 		add : add,
 		get : get,
 		getList: getList,
 		remove: remove,
 		modify: modify,
 	 	formatTime: formatTime,	
 	}
 })();