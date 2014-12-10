
$app.drawHeader = function(layer){
    layer.innerHTML = "";
    window.SW = window.SW || $ui.screenWidth();
    window.SH = window.SH || $ui.screenHeight();
    var header = $div({id:"header"},layer);
    var wrapper = $div({className:"wrapper"},header);
    return header;
};


var top_view = {
    
    drawContent:function(wrapper, layer){
        //$img("images/i1.jpg",wrapper);
        $button({"class":"btn_r",html:"募集中の予定",url:"#pairs_view"},wrapper);
        $button({"class":"btn_r",html:"予定を追加",url:"#new_view"},wrapper);
    }

};

var pairs_view = {
    drawHeader:function(header){
        
    },
    drawContent:function(wrapper, layer){
        //$img("images/i1.jpg",wrapper);
        $button({"class":"btn_r",html:"募集中の予定",url:"#pairs_view"},wrapper);
        $button({"class":"btn_r",html:"予定を追加",url:"#new_view"},wrapper);
    }
    
};

var new_view = {
    drawHeader:function(header){
        
    },
    drawContent:function(wrapper, layer){
        //$img("images/i1.jpg",wrapper);
        $button({"class":"btn_r",html:"募集中の予定",url:"#pairs_view"},wrapper);
        $button({"class":"btn_r",html:"予定を追加",url:"#new_view"},wrapper);
    }
    
};