/**
 * Created by Administrator on 2017/1/11.
 */
/**
 * Created by Administrator on 2017/1/3.
 */
$(function(){
    function autoSize(){var _height = $(window).height();
        $("body").css("height",_height);
    }
    autoSize();
    $(window).resize(function(){
        autoSize();
    })
});

//MyModule
!(function (global,$,factory) {
    //commonJs
    if ( typeof module === "object" && typeof module.exports === "object" ) {
        module.exports = global.document ?
            factory( global, true ) :
            function( w ) {
                if ( !w.document ) {
                    throw new Error( "_Z requires a window with a document" );
                }
                return factory( w );
            };
    } else {
        //regular
        factory( global );
    }
}(typeof window !== "undefined" ? window : this,jQuery,function(window,noGlobal){

    var wh = $(window).height();
    var _Z = function(){
        this.util = {
            //得到url参数
            getQueryString: function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null)return unescape(r[2]);
                return null;
            },
            //把数组拆分成num份，arr传原始一位数组，num为需要拆分的份数
            sliceArr:function (arr,num){
                perarr = [];//长度为num的数组每份的数量；
                var len = arr.length//数组的长度
                var perlen = Math.floor(len/num);//每份数量向下取余
                var newarr = [];//被分成num份的新数组
                //如果数组数量被均等分了直接push
                if(len%num==0){
                    for(var i = 0;i<num;i++){
                        perarr.push(perlen)
                    }
                }else{//否则进行剩余的数组长度判断重新push
                    for(var i = 0;i<num-1;i++){
                        perarr.push(perlen)
                    }
                    var allnum=0;
                    for(var j = 0;j<perarr.length;j++){
                        allnum+=parseInt(perarr[j])
                    }
                    var resnum = len-allnum;//剩余的数组个数
                    perarr.push(resnum);
                }
                var start = 0;//每次拆分开始的位置
                var stop = 0;//每次拆分结束的位置
                for(var k = 0;k<num;k++){
                    stop+=perarr[k];
                    var sliarr = arr.slice(start,stop)
                    start += perarr[k];
                    newarr.push(sliarr);
                }
                return newarr;//拆分成二维 数组
            }
        }

    };
    //虚拟键盘弹出界面调整
    //弹出前位置，弹出后位置,在windowresize事件中调用
    //$(window).resize(function(){
    //    openVirtualAdjust('20px','0px);
    //})
    _Z.prototype.openVirtualAdjust =  function(beloc,afloc){
        var hc = $(window).height();
        if(hc<wh){
            $('.checkInForm').css({'bottom':afloc})
        }else{
            $('.checkInForm').css({'bottom':beloc})
        }
    }
    //ajax提交动画
    _Z.prototype.showAjaxLayer = function(){
        $(".ajaxLayer").show()
    }
    _Z.prototype.hideAjaxLayer = function(){
        $(".ajaxLayer").hide()
    }
    //底部提示信息
    _Z.prototype.showTips = function(msg){
        $(".msgTips").html(msg).fadeIn(800);
        setTimeout(function(){
            $(".msgTips").fadeOut(1600);
        },2400)
    }
    //容器垂直居中
    _Z.prototype.verticalAlign = function(parobj,chlobj){
        var ph = $(parobj).height();
        var ch = $(chlobj).height();
        var mt = (ph-ch)/2;
        $(chlobj).css('marginTop',mt);
    }
    //预加载图片
    _Z.prototype.preloadImages = function(arr){
        //arr传图片路径的数组
        for(var i = 0;i<arr.length;i++){
            var img = document.createElement('img');
            img.src = arr[i]
        }
    }
    /*表单相关*/
    //记住密码功能
    _Z.prototype.remPassword = function(chk,accout,pwd,other){
        pwd=pwd||void(0);accout=accout||void(0);other=other||void(0);
        var isRem = $(chk).prop('checked')
        if(isRem){
            var uname = $(accout).val();//用户名
            var pwd = $(pwd).val();//密码
            localStorage.setItem('accout',uname);
            localStorage.setItem('pwd',pwd);
        }else{
            localStorage.removeItem('accout');
            localStorage.removeItem('pwd');
        }
    }
    //记住密码自动填充表单账户密码
    _Z.prototype.autoFillForm = function(lcaccount,lcpwd,accout,pwd){
        var accoutv = localStorage.getItem(lcaccount)
        var pwdv = localStorage.getItem(lcpwd)
        $(accout).val(accoutv);
        $(pwd).val(pwdv);
    }
    //测试
    //dom操作
    //可配置按钮反馈
    //作用对象，touchstart背景，touchend背景，touchstar颜色，touchend颜色
    _Z.prototype.btnFeed = function(obj,bebg,afbg,becolor,afcolor){
        obj=obj||void(0);bebg=bebg||void(0);afbg=afbg||void(0);becolor=becolor||void(0);afcolor=afcolor||void(0);
        var feedBtn = document.querySelectorAll(obj);
        ;[].forEach.call(feedBtn,function(item){
            item.addEventListener('touchstart',function(){
                this.style.backgroundColor = afbg;
                this.style.color = afcolor;
            })
            item.addEventListener('touchend',function(){
                this.style.backgroundColor = bebg;
                this.style.color = becolor;
            })
        })
    }
    //普通改变透明度按钮反馈
    !(function(){
        var feedBtn = document.querySelectorAll('.feedBtn');
        ;[].forEach.call(feedBtn,function(item){
            item.addEventListener('touchstart',function(){
                this.style.opacity = '0.618';
            })
            item.addEventListener('touchend',function(){
                this.style.opacity = '1';
            })
        })
    })()
    //水波纹按钮
    document.addEventListener('DOMContentLoaded',function(){
        var duration = 750;
        // 样式string拼凑
        var forStyle = function(position){
            var cssStr = '';
            for( var key in position){
                if(position.hasOwnProperty(key)) cssStr += key+':'+position[key]+';';
            };
            return cssStr;
        }
        // 获取鼠标点击位置
        var forRect = function(target){
            var position = {
                top:0,
                left:0
            }, ele = document.documentElement;
            'undefined' != typeof target.getBoundingClientRect && (position = target.getBoundingClientRect());
            return {
                top: position.top + window.pageYOffset - ele.clientTop,
                left: position.left + window.pageXOffset - ele.clientLeft
            }
        }
        var show = function(event){
            var pDiv = event.target,
                cDiv = document.createElement('div');
            pDiv.appendChild(cDiv);
            var rectObj = forRect(pDiv),
                _height = event.pageY - rectObj.top,
                _left = event.pageX - rectObj.left,
                _scale = 'scale(' + pDiv.clientWidth / 100 * 10 + ')';
            var position = {
                top: _height+'px',
                left: _left+'px'
            };
            cDiv.className = cDiv.className + " waves-animation",
                cDiv.setAttribute("style", forStyle(position)),
                position["-webkit-transform"] = _scale,
                position["-moz-transform"] = _scale,
                position["-ms-transform"] = _scale,
                position["-o-transform"] = _scale,
                position.transform = _scale,
                position.opacity = "1",
                position["-webkit-transition-duration"] = duration + "ms",
                position["-moz-transition-duration"] = duration + "ms",
                position["-o-transition-duration"] = duration + "ms",
                position["transition-duration"] = duration + "ms",
                position["-webkit-transition-timing-function"] = "cubic-bezier(0.250, 0.460, 0.450, 0.940)",
                position["-moz-transition-timing-function"] = "cubic-bezier(0.250, 0.460, 0.450, 0.940)",
                position["-o-transition-timing-function"] = "cubic-bezier(0.250, 0.460, 0.450, 0.940)",
                position["transition-timing-function"] = "cubic-bezier(0.250, 0.460, 0.450, 0.940)",
                cDiv.setAttribute("style", forStyle(position));
            var finishStyle = {
                opacity: 0,
                "-webkit-transition-duration": duration + "ms",  // 过渡时间
                "-moz-transition-duration": duration + "ms",
                "-o-transition-duration": duration + "ms",
                "transition-duration": duration + "ms",
                "-webkit-transform" : _scale,
                "-moz-transform" : _scale,
                "-ms-transform" : _scale,
                "-o-transform" : _scale,
                top: _height + "px",
                left: _left + "px",
            };
            setTimeout(function(){
                cDiv.setAttribute("style", forStyle(finishStyle));
                setTimeout(function(){
                    pDiv.removeChild(cDiv);
                },duration);
            },100)
        }
        var wavesbtn = document.querySelectorAll('.waves');
        ;[].forEach.call(wavesbtn,function(item){
            item.addEventListener('click',function(e){
                show(e)
            },!1)
        })
    },!1);

    //amd
    if ( typeof define === "function" && define.amd ) {
        define( "_Z", [], function() {
            return _Z;
        } );
    }
    if ( !noGlobal ) {
        window._Z = _Z;
    }

    return _Z;
}));
