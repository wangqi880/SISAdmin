$.ajaxSetup({ cache: false });
var schedule = { };

//===课程表加载===
schedule.days = 5;
schedule.classToday = -1;
schedule.InitTable = function(need7Days) {
    var days = 5;
    schedule.days = 5;
    var colWidth = "18%";
    if(need7Days) {
        days = 7;
        colWidth = "12%";
        schedule.days = 7;
    }
    var lines = 30;

    var $tb = $("#tb");
    $tb.find("tr[data-id]").remove();

    $tb.find("tr").eq(0).find("td").attr("colspan", (days + 1));
    $tb.find("tr").eq(1).html("");
    $tb.find("tr").eq(1).append('<td width="8%"><em class="date">Date</em></td>');

    var today = new Date();
    var classToday = today.getDay();
    if(classToday==0) {
        classToday = 7;
    }
    schedule.classToday = classToday;

    for(var i=1;i<=days;i++) {
        var date=new Date();
        date.setDate(today.getDate() + i - classToday);
        $tb.find("tr").eq(1).append('<td style="vertical-align: middle;" width="'+colWidth+'">'+schedule.getWeekShow(date)+'.'+date.format("dd/MM")+'</td>');
    }

    for (var j = 1; j <= lines; j++) {
        $tb.append('<tr data-id="'+j+'"></tr>');
        if(j%2==1) {
            $tb.find("tr").eq(j + 1).append('<td rowspan="2"  style="vertical-align: middle;">'+parseInt(j/2+8)+':00</td>');
        } else {
        }
        for (var k = 1; k <= days; k++) {
            $tb.find("tr").eq(j + 1).append('<td data-id="'+k+'"></td>');
        }
    }

    //设置当天颜色
    $("table#tb tr").eq(1).find("td").eq(classToday).append("<b class='today'>Today</b>");
    if(schedule.days===7) {
        $("table#tb tr").eq(1).find("td").eq(classToday).css("padding-right", "4px");
    }
};

schedule.getWeekShow = function(date) {
    var weekday=new Array(7);
    weekday[0]="Sun";
    weekday[1]="Mon";
    weekday[2]="Tue";
    weekday[3]="Wed";
    weekday[4]="Thu";
    weekday[5]="Fri";
    weekday[6]="Sat";

    return weekday[date.getDay()];
};

schedule.lesson = {
    loading: function () {
        var $tb = $("#tb");
        $tb.find("tr[data-id]").remove();
        $tb.append('<tr data-id="0"><td><div><div id="schedule-loading-container" style="margin:0 auto;width: 40px; height: 40px;"></div></div></td></tr>');
        var cols = $tb.find("tr").eq(0).find("td").attr("colspan");
        $tb.find("tr").eq(2).find("td").attr("colspan", cols);

        var loader = new CanvasLoader("schedule-loading-container", { id: "schedule-loading" });
        loader.show();
        return loader;
    },
    load: function () {
        this.loading();
        $("#tb").removeAttr("loaded");

        var url = orgUrl + "schedule?view=json";
        $.ajax({
            url: url,
            type: "get",
            dataType: "json",
            cache: false,
            error: function (xml) {
                alert("网络错误" + xml);
            },
            success: function (data) {
                schedule.InitTable(data["courseschedule"] == null ? 5 : data["courseschedule"].Need7Days);
                if (data["courseschedule"] != null) {
                    $(data["courseschedule"].Lessons).each(function (index, item) {
                        var lesson = schedule.lesson.createLesson(item);

                        //设置有课程天数样式
                        $("table#tb tr").eq(1).find("td").eq(parseInt(lesson.classDay)).addClass("ocpd");

                        if (lesson.courseName != "") {
                            var $td = $("table#tb tr[data-id='" + lesson.startClock + "'] td[data-id='" + lesson.classDay + "']");
                            if ($td != undefined && $td.length > 0 && $.trim($td.html()) == "") {
                                schedule.lesson.lessonPosition($td, lesson);
                            } else {
                                $("table#tb tr[data-id]").each(function (f, tempTr) {
                                    var $tempTr = $(tempTr);
                                    if (parseInt($tempTr.attr("data-id")) > parseInt(lesson.startClock)) {
                                        return false;
                                    }

                                    var $tmpTd = $tempTr.find("td[data-id='" + lesson.classDay + "']");
                                    if ($tmpTd != undefined && $tmpTd.attr("data-cons") != undefined) {
                                        var tmpArr = $tmpTd.attr("data-cons").split(",");
                                        var tmpI = $.inArray(lesson.startClock + "", tmpArr);
                                        if (tmpI >= 0) {
                                            var tmpTotal = parseInt(parseInt(lesson.clocks) + tmpI);
                                            lesson.clocks = tmpTotal > tmpArr.length ? tmpTotal : tmpArr.length;
                                            lesson.startClock = $tempTr.attr("data-id");
                                            schedule.lesson.lessonPosition($tmpTd, lesson);
                                            return false;
                                        }
                                    }
                                });
                            }
                        }
                    });
                }

                /*IE7 兼容*/
                $("#tb td").each(function () {
                    if ($(this).html() == "") {
                        $(this).append("&nbsp;");
                    }
                });

                $("#tb").attr("loaded", "1");
                if (!($(".week").hasClass("on"))) {
                    $(".week").addClass("on");
                    $(".week").click();
                }
            }
        });
    },
    createLesson: function (item) {
        var lesson = {};

        lesson.courseId = item.CourseId;
        lesson.courseName = item.CourseName;
        lesson.teacherId = item.TeacherId;
        lesson.teacherCode = item.TeacherCode;
        lesson.teacherName = item.TeacherName == undefined ? "" : item.TeacherName;
        lesson.startClock = item.StartClock;
        if(parseInt(lesson.startClock)>30) {
            lesson.startClock = 30;
        }
        lesson.clocks = item.Clocks;
        lesson.sourceClocks = item.Clocks;
        lesson.thisWeek = item.ThisWeek;
        lesson.lessonType = item.LessonType;
        lesson.color = item.Color;

        lesson.classRoom = "";
        lesson.lessonTime = "";
        lesson.classDay = -1;
        lesson.beginTime = "";
        lesson.endTime = "";
        if (item.RelatedInfo != undefined) {
            lesson.classRoom = item.RelatedInfo.ClassRoom;
            lesson.lessonTime = item.RelatedInfo.Lesson;
            lesson.classDay = item.RelatedInfo.ClassDay;
            lesson.beginTime = item.RelatedInfo.BeginTimeLocalTime;
            lesson.endTime = item.RelatedInfo.EndTimeLocalTime;
            lesson.isSingleWeek = item.RelatedInfo.IsSingleWeek;
            lesson.weekShowText = item.RelatedInfo.WeekShowText;
        }

        lesson.openCourseCode = "";
        if (item.OpenCourseInfo != undefined) {
            lesson.openCourseCode = item.OpenCourseInfo.OpenCourseCode;
        }

        return lesson;
    },
    lessonPosition: function ($td, lesson) {
        $td.attr("rowspan", lesson.clocks);
        $td.append(schedule.lesson.createLessonProp(lesson));

        if (lesson.color != undefined && lesson.color != "") {
            $td.find("div.tb-base:last").css("border-color", lesson.color);
        }

        var lines = new Array();
        var tempObj = {};
        lines.push(lesson.startClock);
        var length = parseInt(lesson.clocks);
        var startLine = parseInt(lesson.startClock);
        for (var j = 1; j < length; j++) {
            var line = (startLine + j);

            var $tempTd = $("table#tb tr[data-id='" + line + "'] td[data-id='" + lesson.classDay + "']");
            if ($tempTd != undefined && $.trim($tempTd.html()) != "") {
                var tmpH = parseInt(lesson.clocks) + parseInt($tempTd.attr("rowspan") - line);
                $td.attr("rowspan", tmpH);
                $td.append($tempTd.html());

                if ($tempTd.attr("data-cons") != undefined) {
                    var tempLines = $tempTd.attr("data-cons").split(",");
                    for (var i = 0; i < tempLines.length; i++) {
                        lines.push(tempLines[i]);
                        tempObj[tempLines[i]] = tempLines[i];
                    }
                }
            }
            $tempTd.remove();

            if (tempObj[line] == undefined) {
                tempObj[line] = line;
                lines.push(line);
            }
        }

        $td.attr("data-cons", lines);

        //课程分列展示
        var $cur = $td.find("div.tb-base:last");
        $cur.css("position", "absolute");

        var topmins=schedule.lesson.setLessonTop($td, $cur);
        var mins = (Date.parseExtend(lesson.endTime).getTime() - Date.parseExtend(lesson.beginTime).getTime()) / (60 * 1000);
        var height = mins * 21 / 30-3;
        if(height>$td.height()&&topmins<0) {
            height=(mins+topmins) * 21 / 30-3;
        }

        lesson.height = height;
        $td.find("div.tb-base:last").css("height", (height + "px"));
        if (height <= 60) {
            $td.find("div.tb-base:last").children("h4").css("padding-top", "0");
        }

        var lessonCount = $td.find("div.tb-base").length;
        var width = schedule.lesson.getLessonWidth(lessonCount,lesson);
        var canCount = 25;
        if (schedule.days == 7) {
            canCount = 18;
        }
        $td.find("div.tb-base").each(function (index, item) {
            var $item = $(item);
            $item.css("width", (width + "px"));
            $item.css("left", (index * (width + 5) + "px"));
            if (width < 40) {
                $item.children("h4").css("padding-top", "0");
            }

            if (canCount - index - 1 < 0) {
                $item.css("display", "none");
            }
        });

        //课程重叠展示
        /*var lessonCount = $td.find("div.tb-base").length;
        if(lessonCount==2) {
        $td.find("div.tb-base").addClass("w40");
        }*/

        /*if(lessonCount>2) {
        var tempCons = $td.attr("data-cons").split(",");

        var dateTop = new Date(1900, 1, 1, 8, 0, 0);
        dateTop.setMinutes(dateTop.getMinutes() + (parseInt(tempCons[0]) - 1) * 30);

        var tdHeight = tempCons.length * 21;

        var arr = [];
        $td.find("div.tb-base").each(function(index,item) {
        var $item = $(item);
        var itemDate = Date.parseExtend($item.attr("data-beginTime"));
        itemDate.setFullYear(1900);
        itemDate.setMonth(1);
        itemDate.setDate(1);

        var itemLess = { };
        if(itemDate<=dateTop) {
        itemLess.top = 0;
        } else {
        var mins=(itemDate.getTime() - dateTop.getTime()) / (60 * 1000);
        itemLess.top = mins * 21 / 30;
        }

        var result = schedule.lesson.getLessonTop(arr, itemLess);

        $td.find("div.tb-base").removeClass("w40");
        $item.css("position","absolute");
        $item.css("top", result.lesson.top);

        var itemHeight = parseInt($item.attr("data-height"));
        if((itemHeight+result.lesson.top)>tdHeight) {
        tdHeight = itemHeight + result.lesson.top;
        $td.css("height", tdHeight+"px");
        }
        });
        }*/
    },
    getLessonWidth: function (lessonCount,lesson) {
        var width = 0;
        var totalWidth = 130;
        if (schedule.days == 7) {
            if(lesson.classDay===schedule.classToday) {
                totalWidth = 106;
            } else {
                totalWidth = 90;
            }
        }

        if (totalWidth > lessonCount * 5) {
            width = (totalWidth - lessonCount * 5) / lessonCount;
        }

        return width;
    },
    setLessonTop: function ($td, $item) {
        var tempCons = $td.attr("data-cons").split(",");

        var dateTop = new Date(1900, 1, 1, 8, 0, 0);
        dateTop.setMinutes(dateTop.getMinutes() + (parseInt(tempCons[0]) - 1) * 30);

        var itemDate = Date.parseExtend($item.attr("data-beginTime"));
        itemDate.setDate(1);
        itemDate.setMonth(1);
        itemDate.setFullYear(1900);

        var top = 0;
        var mins = (itemDate.getTime() - dateTop.getTime()) / (60 * 1000);
        if (mins>0) {
            top = mins * 21 / 30;
        }

        $item.css("top", (top + "px"));

        return mins;
    },
    getLessonTop: function (arr, lesson) {
        var newTop = lesson.top;
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] > newTop || (arr[i] + 10) >= newTop) {
                newTop = arr[i] + 10;
                continue;
            }
        }

        arr.push(newTop);
        arr.sort(function (a, b) { return a - b; });
        lesson.top = newTop;

        return { arr: arr, lesson: lesson };
    },
    createLessonProp: function (lesson) {
        var html = "";
        if (lesson.lessonType == "0") {
            var courseUrl = orgUrl + "course_detail?courseId=" + lesson.courseId;
            var teacherUrl = orgUrl + "teacher_detail?teachercode=" + lesson.teacherCode;
            var weekText = "";
            var isSingleWeek = parseInt(lesson.isSingleWeek);
            if (isSingleWeek == 0) {
                weekText = "双周";
            } else if (isSingleWeek == 1) {
                weekText = "单周";
            }

            html = '<div class="pr  pr-ie7"><div class="tb-base tb-blue hs" data-lessonType="' + lesson.lessonType + '" data-courseId=' + lesson.courseId + ' data-thisweek=' + lesson.thisWeek + ' data-beginTime="' + lesson.beginTime + '" data-height="' + lesson.height + '">' +
                '<h4>' + lesson.courseName + '</h4>' +
                '<p>教师：' + lesson.teacherName + '</p>' +
                '<p>地点：' + lesson.classRoom + '</p>' +
                '<div class="tb-detail">' +
                '<div class="tb-info">' +
                '<h4>课程名称：<a target="_blank" href="' + courseUrl + '">' + lesson.courseName + '</a></h4>' +
                '<p>课程编号：<a target="_blank" href="' + courseUrl + '">' + lesson.openCourseCode + '</a></p>' +
                '<p>时间：周' + arabiaToChinese(lesson.classDay) + lesson.lessonTime + '节</p>' +
                '<p>教师：<a target="_blank" href="' + teacherUrl + '">' + lesson.teacherName + '</a></p>' +
                '<p>地点：' + lesson.classRoom + '</p>' +
                '<p>上课周：' + lesson.weekShowText + '周&nbsp;' + weekText + '</p>' +
                '<h4>教参</h4>' +
                '<ul data-reslist="1">' +
                '</ul>' +
                '<h4>教师推荐<i data-rec-count="1">0</i></h4>' +
                '<h4>评论<i data-comment-count="1">0</i></h4>' +
                '</div>' +
                '</div>' +

                '</div></div>';
        } else if (lesson.lessonType == "1") {
            html = '<div class="pr pr-ie7"><div class="tb-base tb-blue hs" data-courseId=' + lesson.courseId + ' data-thisweek=' + lesson.thisWeek + ' data-beginTime="' + lesson.beginTime + '" data-height="' + lesson.height + '">' +
                '<h4>' + lesson.courseName + '</h4>' +
                '<p>开始时间：' + Date.parseExtend(lesson.beginTime).format("hh:mm") + '</p>' +
                '<p>结束时间：' + Date.parseExtend(lesson.endTime).format("hh:mm") + '</p>' +
                '<div class="tb-detail">' +
                '<div class="tb-info">' +
                '<h4>课程名称：' + lesson.courseName + '</h4>' +
                '<p>开始时间：</p>' +
                '<p>' + Date.parseExtend(lesson.beginTime).format("yyyy-MM-dd hh:mm") + '</p>' +
                '<p>结束时间：</p>' +
                '<p>' + Date.parseExtend(lesson.endTime).format("yyyy-MM-dd hh:mm") + '</p>' +
                '</div>' +
                '</div>' +

                '</div></div>';
        }
        return html;
    },
    loadCourseExtra: function ($item) {
        if ($item.attr("data-lessonType") == undefined || $item.attr("data-lessonType") != "0") {
            return;
        }
        if ($item.attr("data-loaded") != undefined && $item.attr("data-loaded") == "1") {
            return;
        }
        if ($item.attr("data-loading") != undefined && $item.attr("data-loading") == "1") {
            return;
        }

        $item.attr("data-loading", "1");

        var courseId = $item.attr("data-courseId");
        var url = orgUrl + "course_extra?view=json";
        $.get(url, { courseid: courseId, maxcount: 3 }, function (data) {
            $item.attr("data-loaded", "1");
            if (data["course_extra"] != undefined) {
                var retObj = data["course_extra"];
                var RecommendedCount = parseInt(retObj.RecommendedCount) > 100 ? "99+" : retObj.RecommendedCount;
                var CommentCount = parseInt(retObj.CommentCount) > 100 ? "99+" : retObj.CommentCount;
                $item.find("i[data-rec-count]").text(RecommendedCount);
                $item.find("i[data-comment-count]").text(CommentCount);

                var $ul = $item.find("ul[data-reslist]");
                $ul.html("");
                $.each(retObj.Resources, function (index, resource) {
                    var detailUrl = orgUrl + "book_detail?rescode=" + encodeURIComponent(resource.ResCode);
                    $ul.append('<li><a target="_blank" href="' + detailUrl + '" title="' + resource.Creator + '  ' + resource.Publisher  + '">' + resource.Title + '</a></li>');
                });
            }
        }, "json");

        $item.removeAttr("data-loading");
    }
};

$(function() {

    /* 委托绑定动态添加的课表信息 */
    $("#tb").delegate(".hs", "mouseenter", function () {
        $(this).addClass("ontb");
        $(this).children("div").show();
        $(this).css("overflow", "visible");
        $(this).css("font-size", "0");

        var top = 30;
        if($(this).height()<60) {
            top = $(this).height() / 2;
        }
        $(this).children("div").css("top", (top+"px"));

        $(this).css("z-index", "99");
        $(this).parent().parent().css("z-index", "98");

        schedule.lesson.loadCourseExtra($(this));
    });
    $("#tb").delegate(".hs", "mouseleave", function () {
        $(this).removeClass("ontb");
        $(this).css("overflow", "hidden");
        $(this).css("font-size", "12px");
        $(this).children("div").css("top", "-999em");

        $(this).css("z-index", "");
        $(this).parent().parent().css("z-index", "");
    });
    /*收缩课程表*/
    $(".hide").click(function(){
        var expires = new Date();
        expires.setDate(expires.getDate() + 300);
        if(!($(this).hasClass("show"))){
            $(this).addClass("show");
            $(".timetable").css({"height":"73px","overflow":"hidden"});

            var loaded = $("#tb").attr("loaded");
            if(loaded==undefined||loaded!="1") {
                schedule.lesson.load();
            }

            $.cookie("ishideschedule", "1", { expires: expires });
            return false;
        }

        $(this).removeClass("show");
        $(".timetable").css({"height":"auto","overflow":"visible","zoom":"1"});

        $.cookie("ishideschedule", "0", { expires: expires });
        return false;
    });
    /*本周课程展示*/
    $(".week").click(function () {
        var expires = new Date();
        expires.setDate(expires.getDate() + 300);
        if (!($(this).hasClass("on"))) {
            $(this).addClass("on");
            $(".tb-base").each(function() { $(this).show(); });

            $.cookie("isthisweek", "0", { expires: expires });
        } else {
            $(this).removeClass("on");
            $(".tb-base").each(function() { if ($(this).attr("data-thisweek") == "false") { $(this).hide(); }; });

            $.cookie("isthisweek", "1", { expires: expires });
        }
    });
    /*本周课表的选中状态*/
    if($.cookie("isthisweek")=="1") {
        $(".week").removeClass("on");
    }
    /*根据课表的隐藏状态加载课表*/
    if($.cookie("ishideschedule")=="1") {
        $(".hide").click();
    } else {
        schedule.lesson.load();
    }
});