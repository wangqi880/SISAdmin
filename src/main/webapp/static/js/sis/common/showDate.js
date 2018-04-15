/**
 * Created by 13046 on 2017/11/2.
 */
$(function () {

    $(document.body).css({
        "overflow-x":"hidden",
        "overflow-y":"hidden"
    });

    $(".date").css("color","#DCDCDC");

    window.setInterval(showTime,1000);

    function showTime(){
        $(".date").html(getDate()).css("color","#8bc816");

    }

    function getDate(){
        var myDate = new Date();
        var month= myDate.getMonth() +1;
        var ri = myDate.getDate().toString();
        if(ri.length==1){
        	ri = "0"+ri;
        }
        var xiaoshi = myDate.getHours().toString();
        if(xiaoshi.length==1){
        	xiaoshi= "0"+xiaoshi;
        }
        var fengz = myDate.getMinutes().toString();
        if(fengz.length==1){
        	fengz = "0"+fengz;
        }
        
        var sec = myDate.getSeconds().toString();
        if(sec.length==1){
        	sec = "0"+sec;
        }
        
        var showDate = myDate.getFullYear()+"年"+month+"月"+ri+"日"+"&nbsp"+xiaoshi+":"+fengz+":"+sec+"&nbsp"+getWeekDay(myDate.getDay());
        return showDate;
    }

    function getWeekDay(day) {
        var weekday=new Array(7);
        weekday[0]="星期天";
        weekday[1]="星期一";
        weekday[2]="星期二";
        weekday[3]="星期三";
        weekday[4]="星期四";
        weekday[5]="星期五";
        weekday[6]="星期六";
        return weekday[day];
    }
});
