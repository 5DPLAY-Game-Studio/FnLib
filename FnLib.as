/**
 * Copyright (C) 2021, 5DPLAY Game Studio
 * All rights reserved.
 * 
 * This software is distributed under the MIT license.
 * Any person or organization may use this library free of charge, 
 * but it must follow the following points :
 * 
 * 1. No person or organization may claim to 
 *    have written the original source code.
 * 
 * 2. In any case, the author is not liable for 
 *    any consequences caused by the use of part 
 *    of the code of this software.
 * 
 * 3. This section shall not be deleted or altered 
 *    from any source.
 * 
 */

var isPrint:Boolean = false;

const VERSION:String = "0.0.1";			// 版本
const AUTHOR :String = "5dplay";		// 作者
const DATE   :String = "2024.03.22";	// 日期



//////////////////////////////////////////////////////////////////////////////////////////
// 获取所需全部包名引用

const PKG_NAME_FIGHTER       :String = "net.play5d.game.bvn.fighter::"
const PKG_NAME_CTRL_GAMECTRLS:String = "net.play5d.game.bvn.ctrl.game_ctrls::"

//////////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////
// 获取类引用

import flash.utils.getDefinitionByName;

var FighterMain    :Class = getDefinitionByName(PKG_NAME_FIGHTER + _TYPE_FIGHTER_MAIN    );
var Assister       :Class = getDefinitionByName(PKG_NAME_FIGHTER + _TYPE_ASSISTER        );
var Bullet         :Class = getDefinitionByName(PKG_NAME_FIGHTER + _TYPE_BULLET          );
var FighterAttacker:Class = getDefinitionByName(PKG_NAME_FIGHTER + _TYPE_FIGHTER_ATTACKER);

var GameCtrl:Class = getDefinitionByName(PKG_NAME_CTRL_GAMECTRLS + "GameCtrl");

//////////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////
// 私有变量及函数，以【_】开头，不推荐使用，仅作为【FnLib.as】文件内部使用

import flash.utils.getQualifiedClassName;

// 自身引用
var _this:MovieClip = this;

const _TYPE_FIGHTER_MAIN    :String = "FighterMain";
const _TYPE_ASSISTER        :String = "Assister";
const _TYPE_BULLET          :String = "Bullet";
const _TYPE_FIGHTER_ATTACKER:String = "FighterAttacker";
const _TYPE_UNKNOWN         :String = "UNKNOWN";

/**
 * 初始化
 */
function _initialize():void {
	_print();
}

/**
 * 打印自身信息
 */
function _print():void {
	if (!isPrint) {
		return;
	}
	
	var text:String = 
		"[FnLib]::{\n\t" + 
			"Ver:" + VERSION + ", Author:" + AUTHOR + ", Date:" + DATE + "\n\t" + 
			"SelfType:" + _getSelfType() + "\n" + 
		"}"
	;
	
	trace(text);
}

var _selfType:String = null;
/**
 * 获取自身类型
 */
function _getSelfType():String {
	if (_selfType) {
		return _selfType;
	}
	
	_selfType = _TYPE_UNKNOWN;
	
	var gameStage:* = GameCtrl.I.gameState;
	var gameSprites:* = gameStage.getGameSprites();
	
	for each (var sp:* in gameSprites) {
		var d:DisplayObject = sp.getDisplay();
		
		// 等于 this 可获取 FighterAttacker Bullet Assister
		// 等于 this.parent 可获取 FighterMain
		if (d == _this || d == _this.parent) {
			var className:String = getQualifiedClassName(sp);
			
			if (className.indexOf(_TYPE_FIGHTER_MAIN) != -1) {
				_selfType = _TYPE_FIGHTER_MAIN;
			}
			else if (className.indexOf(_TYPE_ASSISTER) != -1) {
				_selfType = _TYPE_ASSISTER;
			}
			else if (className.indexOf(_TYPE_BULLET) != -1) {
				_selfType = _TYPE_BULLET;
			}
			else if (className.indexOf(_TYPE_FIGHTER_ATTACKER) != -1) {
				_selfType = _TYPE_FIGHTER_ATTACKER;
			}
			
			break;
		}
	}
	
	return _selfType;
}

//////////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////
// 公有函数，对外接口

var _self:* = null;
/**
 * 获得自身类引用
 */
function get $self():* {
	if (_self) {
		return _self;
	}
	
	var gameStage:* = GameCtrl.I.gameState;
	var gameSprites:* = gameStage.getGameSprites();
	
	for each (var sp:* in gameSprites) {
		var d:DisplayObject = sp.getDisplay();
		
		// 等于 this 可获取 FighterAttacker Bullet Assister
		// 等于 this.parent 可获取 FighterMain
		if (d == _this || d == _this.parent) {
			_self = sp;
			
			break;
		}
	}
	
	return _self;
}

//////////////////////////////////////////////////////////////////////////////////////////




//////////////////////////////////////////////////////////////////////////////////////////
// 初始化

_initialize();

//////////////////////////////////////////////////////////////////////////////////////////