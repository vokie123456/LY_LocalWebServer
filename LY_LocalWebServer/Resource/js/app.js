(function($){
    //tab选项卡
    $.fn.table=function(options){
        var settings = $.extend({
            'tarObj':'ul.tabBar li.tabBarItem',
            'tarEqlObj':'main.mainContent .navPartCon',
            'relaObj':'li',
            'relaEqObj':'.navPartCon',
        },options);
        return this.click(function(){
            var _index = $(this).index();
            $(this).addClass('active').siblings(settings.relaObj).removeClass('active');
            $(settings.tarEqlObj).eq(_index).removeClass('hide').siblings(settings.relaEqObj).addClass('hide');
        })
    }
    //sticknavbar
    $.fn.stick = function(options){
        var settings = $.extend({
            tarobj:'.searchArea',
            relaobj:'.pollyEle'
        },options);
        return this.ready(function(){
            $(window).scroll(function(){
                var offtop = $(settings.relaobj).offset().top;
                var bft = $(document).scrollTop();
                if(offtop==bft||offtop<bft){
                    if($(settings.tarobj).hasClass('sticknav')) return;
                    $(settings.tarobj).addClass('sticknav');
                    return;
                }
                if(!$(settings.tarobj).hasClass('sticknav')) return;
                $(settings.tarobj).removeClass('sticknav');
            });
        })
    }
    //
})(jQuery)

function log(msg){
    console.log(msg)
}

function IndexLoad(){
    this.types = 0;//默认为推荐类型
    this.seltype = 0;//默认网游分类为综合
}
//页面到达底部
IndexLoad.prototype.pullBot = function(){
    var wh = $(window).height();
    var sct = $(window).scrollTop();
    var dh = $(document).height();
    if(wh+sct>dh-180){
        //到达底部
        return true;
    }
    //没有
    return false;
}
//加载数据
var isload = false;
var type0pgm = 1;//推荐
var type1pgm = 1;//礼包
var type2pgm = 1;//活动
//var type3pgm = 1;//活动
var types = 0;//大分类推荐
var seltype = 0;//推荐小分类综合
var searchconfig = {
    pagenum:type0pgm,//页数
    types:0,//默认为推荐类型
    seltype:0//默认网游分类为综合
}
//切换大分类
$('.tabBar li').click(function(){
    var index = $(this).index()
    types = index;
    if(types==0){
        searchconfig.pagenum = type0pgm
    }else if(types==1){
        searchconfig.pagenum = type1pgm
    }else{
        searchconfig.pagenum = type2pgm
    }
    if(types!=0){
        seltype = null;
    }
})

IndexLoad.prototype.getData = function(types,seltype,pgnum){
    var pgnum = pgnum||null;
    if(pgnum){
        type0pgm = 1;
    }
    var url = '#';
    var that = this;
    searchconfig.types = types;
    searchconfig.seltype = seltype;
    if(!isload){
        isload = true;
        $.ajax({
            url:url,
            type:'POST',
            data:searchconfig,
            success:function(datas){
                log('加载成功')
                if(types==0){
                    type0pgm++
                }else if(types==1){
                    type1pgm++
                }else{
                    type2pgm++
                }
                isload = false;
            },
            error:function(){
                log('加载数据失败')
            }
        })
    }
}
//实例化
var Load = new IndexLoad();
Load.getData(0,0);//推荐
Load.getData(1,null);//礼包
Load.getData(2,null);//活动

//切换网游分类小分类
$('.sortSelector div').click(function(){
    $(this).addClass('seled').siblings('div').removeClass('seled');
    var index = $(this).index();
    //log(index);
    seltype = index;
    Load.getData(types,seltype,1)
    log(searchconfig)
})

$(window).scroll(function(){
    var isbot = Load.pullBot();
    if(isbot){
        Load.getData(types,seltype);
    }
})


$(function(){
    $(".searchArea").stick();
    //导航选项卡
    $(".tabBar li").table({
        'tarObj':'ul.tabBar li.tabBarItem',
        'tarEqlObj':'main.mainContent .navPartCon',
        'relaObj':'li',
        'relaEqObj':'.navPartCon',
    })
    //预告部分选项卡
    $('.foreCastTabCon li').table({
        'tarObj':'ul.tabBar li.tabBarItem',
        'tarEqlObj':'.foreTar',
        'relaObj':'li',
        'relaEqObj':'.foreTar',
    })
    !function(z){

    }(new _Z())
    var myswiper = new Swiper('.bannerCon.swiper-container', {//启动swiper
        slidesPerView:'auto',
        autoplay:3000,
        speed:2000,
    })
    //选项卡

})