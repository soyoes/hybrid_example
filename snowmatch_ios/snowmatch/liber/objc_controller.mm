//
//  objc_controller.mm
//  testapp
//
//  Created by soyoes on 8/19/14.
//  Copyright (c) 2014 soyoes. All rights reserved.
//

#include "liber.h"


using namespace std;

view_base_t __rootview;
str_t __controller = @"__DEFAULT__";
marr_t __linked_views = marr(nil);

bool controller_t::is_presenting = false;

controller_t::controller_t(){
    screensize();
    setStyle({@0,@0,@(SW),@(SH)});
}

value_t controller_t::value(){
    return [NSValue valueWithPointer:this];
}

str_t controller_t::controller_name() {
    if (ctl_name) return ctl_name;
    ctl_name = str(typeid(*this).name());
    return ctl_name;
}
$& controller_t::getById(str_t _id) {
    return $id(_id, controller_name());
}

void controller_t::present(effect_in_t instyle, anime_t animeOpts){
    return present(instyle, nil, animeOpts);
}

void controller_t::present(effect_in_t instyle, anime_end_f onEnd, anime_t animeOpts){
    style_t from={.x=@0}, to={.x=@0, .y=@0};
    anime_delta_t delta = kDeltaQuad5;
    anime_style_t style = kEaseOut;
    switch (instyle) {
        case kFadeIn: //ct_style_fadeIn
            from.alpha = @(1.0f);
            delta = kDeltaLinear;
            break;
        case kTopIn: //top to center:
            from.y = @(-SH);
            delta = kDeltaBounce; style = kEaseInOut;
            break;
        case kBottomIn: //bottom to center:
            from.y = @(SH);
            break;
        case kLeftIn: //from left to center:
            from.x = @(-SW);
            break;
        case kRightIn: //from right to center:
            from.x = @(SH);
            break;
        default:
            if(!__rootview){
                UIWindow * win = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
                __rootview = win.rootViewController.view;
            }
            setStyle(from) >> __rootview;
            return;
    }
    
    if(!animeOpts.delta)
        animeOpts.delta= delta;
    if(!animeOpts.style)
        animeOpts.style= style;
    if(onEnd)
        present(from, to, onEnd, animeOpts);
    else
        present(from, to, animeOpts);
}

void controller_t::present(style_t from, style_t to, anime_t animeOpts){
    present(from, to, nil, animeOpts);
}
void controller_t::present(style_t from, style_t to, anime_end_f onEnd, anime_t animeOpts){
    // close keyboard and scrollback
    if(__has_firstResponder && __firstResponder_idx>=0 && __firstResponder_idx < __idxmap.count) {
        view_t v = __idxmap[@(__firstResponder_idx)];
        [v switchEditingMode];
    }
    
//    StyleDef*ff = [StyleDef style:from], *tt = [StyleDef style:to];
    if(!__rootview){
        UIWindow * win = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        __rootview = win.rootViewController.view;
    }
    //update name space
    __controller =controller_name();
    if(__rootview) {
        is_presenting = true;
        (setStyle(from) >> __rootview).animate(500, to, ^($&v){
            is_presenting = false;
            if (onEnd) { onEnd(v); }
        }, animeOpts);
    }
}
void controller_t::dismiss(effect_out_t outstyle, anime_end_f onEnd, anime_t animeOpts){    
    style_t from={}, to={};
    anime_delta_t delta = kDeltaQuad5;
    anime_style_t style = kEaseOut;
    switch (outstyle) {
        case kFadeOut: //ct_style_fadeIn
            to.alpha = @(0.0f);
            delta = kDeltaLinear;
            break;
        case kTopOut: //ct_style_top:
            to.y = @(-SH);
            delta = kDeltaBounce; style = kEaseInOut;
            break;
        case kBottomOut: //ct_style_down:
            to.y = @(SH);
            break;
        case kLeftOut: //ct_style_left:
            to.x = @(-SW);
            break;
        case kRightOut: //ct_style_right:
            to.x = @(SH);
            break;
        default:
            if(!__rootview){
                UIWindow * win = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
                __rootview = win.rootViewController.view;
            }
            //setStyle(from) >> rootview;
            return;
    }
    if(!animeOpts.delta)
        animeOpts.delta= delta;
    if(!animeOpts.style)
        animeOpts.style= style;
    present(from, to, ^($&v){
        // fix current controller name
        [__linked_views removeLastObject];
        str_t cname =  (str_t)[__linked_views lastObject];
        __controller = cname;
        
        if (onEnd) { onEnd(v); }
    }, animeOpts);
    /*
    present(from, to, ^($&v){
        $::setControllerName(lastCtlName); // fix current controller name
        if (onEnd) { onEnd(v); }
    },animeOpts);
    */
}

void controller_t::show(dic_t params){
    $::show(0);
}
void controller_t::onpresented(){}
void controller_t::ondraw(dic_t params){}

void controller_t::onbackground(){}
void controller_t::onforeground(){}
str_t controller_t::name(){return @"__DEFAULT__";}
void controller_t::init() {
    __controller = controller_name();
    marr_add(__linked_views, __controller);
    set(@"__is_controller__", @YES);
}
/*
 remove all views from memory.
 be careful to use this.
 */
void controller_t::clearAll(){
    str_t cname = controller_name();
    if(__nodes && cname && __nodes[cname]){
        NSArray* keys = [__nodes[cname] allKeys];
        for (str_t va in keys) {
            view_t v = __nodes[cname][va];
            v.owner->remove();
            //delete(v.owner); // This cause memory leak.
        }
        [__nodes[cname] removeAllObjects];
    }
    
    // clear all not in __nodes
    view_t view = this->view();
    if(view && view.subviews.count > 0) {
        for (UIView *v in view.subviews) {
            [v removeFromSuperview];
        }
    }
}

/************************************************************************/
/** top_controller_t **/
void top_controller_t::init() {
    __linked_views = marr(nil);
    controller_t::init();
}
/************************************************************************/