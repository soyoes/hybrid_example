
$app.drawHeader = function(layer){
    layer.innerHTML = "";
    window.SW = window.SW || $ui.screenWidth();
    window.SH = window.SH || $ui.screenHeight();
    var header = $div([
        $button({id:"h_left"}),
        $h1({id:"h_title"}),
        $button({id:"h_right"}),
    ],layer).attr({id:"header"});
    return header;
};


var top_view = {
    // drawHeader:function(header){

    // },
    drawContent:function(wrapper, layer){
        //$img("images/i1.jpg",wrapper);
        $button({"class":"btn_r",html:"募集中の予定",url:"pairs_view"},wrapper);
        $button({"class":"btn_r",html:"予定を追加",url:"new_view"},wrapper);
    }

};

var pairs_view = {
    drawHeader:function(header){
        header.childNodes[0].addClass("back").attr({"url":"top_view"});
        header.childNodes[1].innerHTML = "募集中の予定";
    },
    drawContent:function(wrapper, layer){   
        layer.addClass("anime_t");
        for(var i=0;i<40;i++){
            $img({src:"i"+($.rand(1,12))+".jpg",y:100+i*5},wrapper).css({float:"left",width:"75px",height:"75px",marginTop:(100+i*10)+"px",opacity:0})
                .animate({duration:250,delay:i*25,style:"easeOut",step:function(ae,delta){
                    ae.style.opacity = delta;
                    ae.style.marginTop = parseInt(ae.attr("y"))*(1-delta) + "px";
                }});
        }

    }
    
};

var new_view = {
    drawHeader:function(header){
        header.childNodes[0].addClass("back").attr({"url":"top_view"});
        header.childNodes[1].innerHTML = "予定を追加";
    },
    drawContent:function(wrapper, layer){
        layer.addClass("anime_l");
        wrapper.id = "new_view";
        $h2("同行する仲間", wrapper);
        $div([
            $img("i1.jpg", wrapper),
            $img("user_m.png", wrapper),
        ],wrapper).attr({"class":"pair"});
        $h2("探すペア", wrapper);
        $div([
            $img("user_f.png", wrapper),
            $img("user_f.png", wrapper),
        ],wrapper).attr({"class":"pair"});

        $h2("移動手段", wrapper);
        $dl([
            $dd("相乗り希望").bind('click', new_view.switch_trans),
            $dd("マイカー").bind('click', new_view.switch_trans),
            $dd("電車など").bind('click', new_view.switch_trans)
        ],wrapper).attr({"class":"trans"});

        $ul([
            $li([$label("出発日"), $span({html:"未定",url:"cal_view"})]),
            $li([$label("目的地"), $span({html:"未定",url:"cal_view"})])
        ],wrapper).attr({className:"list"});

        $button({"class":"btn",html:"決　定"},wrapper);
    },

    switch_trans:function(e){
        var t = e.target;
        var ts = e.target.parentNode.childNodes;
        if(ts)
        for(var i=0;i<ts.length;i++){
            ts[i].className = (ts[i].innerHTML==t.innerHTML) ? "on":"";
        }
    }
    
};

var cal_view = {
    drawHeader:function(header){
        header.childNodes[0].addClass("back").attr({"url":"new_view"});
        header.childNodes[1].innerHTML = "出発日";
    },
    drawContent:function(wrapper, layer){
        layer.addClass("anime_l");
        $calendar = $ui.calendar(wrapper,{},{oncreate:function(cell){
            
        },onclick : function(date, cell){
            
        }});
    }
};