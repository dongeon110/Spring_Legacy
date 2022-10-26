console.log("Reply Module.......");

var replyService = (function(){ // ( )안에서 선언된 함수 = 즉시 실행 함수
        // return {name:"AAAA"}; // replyService라는 변수에 AAAA라는 이름을 가진 객체를 할당

        function add(reply, callback, error) {
                console.log("add reply........");

                $.ajax({
                        type:'post',
                        url:'/replies/new',
                        data:JSON.stringify(reply),
                        contentType:"application/json; charset=utf-8",
                        success:function(result, status, xhr) {
                                if(callback) {
                                        callback(result);
                                }
                        },
                        error:function(xhr, status, er) {
                                if(error) {
                                        error(er);
                                }
                        }
                })
        }

        function getList(param, callback, error) {

                var pno = param.pno;
                var page = param.page || 1; // param.page가 없으면 1을 반환 있으면 param.page반환

                $.getJSON("/replies/pages/" + pno + "/" + page + ".json",
                    function(data) {
                        if (callback) {
                                callback(data.replyCnt, data.list);
                        }
                    }).fail(function(xhr, status, err) {
                        if(error) {
                                error();
                        }
                });
        }

        function remove(rno, replyer, callback, error) {
                $.ajax({
                        type:'delete',
                        url:'/replies/' + rno,

                        data: JSON.stringify({rno:rno, replyer:replyer}),

                        contentType: "application/json; charset=utf-8",

                        success: function(deleteResult, status, xhr) {
                                if (callback) {
                                        callback(deleteResult);
                                }
                        },
                        error: function(xhr, status, er) {
                                if(error) {
                                        error(er);
                                }
                        }
                });
        }

        function update(reply, callback, error) {
                console.log("RNO: " + reply.rno);

                $.ajax({
                        type:'put',
                        url:'/replies/' + reply.rno,
                        data:JSON.stringify(reply),
                        contentType:"application/json; charset=utf-8",
                        success:function(result, status, xhr) {
                                if(callback) {
                                        callback(result);
                                }
                        },
                        error:function(xhr, status, er) {
                                if(error) {
                                        error(er);
                                }
                        }
                });
        }

        function get(rno, callback, error) {
                $.get("/replies/" + rno + ".json", function(result) {
                        if (callback) {
                                callback(result);
                        }
                }).fail(function(xhr, status, err) {
                        if(error) {
                                error();
                        }
                });
        }

        function displayTime(timeValue) {
                var today = new Date();

                var gap = today.getTime() - timeValue;

                var dateObj = new Date(timeValue);
                var str = "";

                if (gap < (1000 * 60 * 60 * 24)) {
                        var hh = dateObj.getHours();
                        var mm = dateObj.getMinutes();
                        var ss = dateObj.getSeconds();

                        if (hh > 12) {
                                return [ 'PM ' + (hh-12 > 9 ? '' : '0') + (hh-12), ':', (mm > 9 ? '' : '0') + mm, ':'
                                        , (ss > 9 ? '' : '0') + ss ].join('');
                        } else if (hh === 12) {
                                return [ 'PM ' + '12', ':', (mm > 9 ? '' : '0') + mm, ':'
                                        , (ss > 9 ? '' : '0') + ss ].join('');
                        } else if (hh === 0) {
                                return [ 'AM ' + '12', ':', (mm > 9 ? '' : '0') + mm, ':'
                                        , (ss > 9 ? '' : '0') + ss ].join('');
                        } else {
                                return [ 'AM ' + (hh > 9 ? '' : '0') + hh, ':', (mm > 9 ? '' : '0') + mm, ':'
                                        , (ss > 9 ? '' : '0') + ss ].join('');
                        }

                } else {
                        var yy = dateObj.getFullYear();
                        var mm = dateObj.getMonth() + 1; // getMonth() 는 0부터 시작함
                        var dd = dateObj.getDate();

                        return [ yy, '/', (mm>9 ? '':'0') + mm, '/', (dd>9 ? '':'0') + dd ].join('');
                }
        };

        return {
                add:add,
                getList:getList,
                remove:remove,
                update:update,
                get:get,
                displayTime:displayTime
        };
})();