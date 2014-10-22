package com.rr.personage {
	import com.rr.personage.events.PersonageActionEvent;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	
	[SWF(frameRate="31")]
	
	public class Test extends Sprite {
		
		private var buttons:Dictionary = new Dictionary();
		private var personageView:PersonageView;
		private var currentButton:Sprite;
		
		public function Test() {
			super();
			
			var modelObj:Object = {
				name: "Заяц",
				nickname: "Вася",
				sex: PersonageSex.MALE,
				color: "0x9b5eff",
				drunkLevel: 3,
				isPoisoned: true,
				path: "rabbit.swf"
				
			}
			
			buttons[PersonageActions.WAVING] = getButton(PersonageActions.WAVING);
			buttons[PersonageActions.STROKING_BELLY] = getButton(PersonageActions.STROKING_BELLY);
			buttons[PersonageActions.SHAKING] = getButton(PersonageActions.SHAKING);
			buttons[PersonageActions.SCARED] = getButton(PersonageActions.SCARED);
			buttons[PersonageActions.PLEASURE] = getButton(PersonageActions.PLEASURE);
			buttons[PersonageActions.LOOKS_ARROUND] = getButton(PersonageActions.LOOKS_ARROUND);
			buttons[PersonageActions.JOY] = getButton(PersonageActions.JOY);
			buttons[PersonageActions.GIGGLES] = getButton(PersonageActions.GIGGLES);
			buttons[PersonageActions.EATING] = getButton(PersonageActions.EATING);
			buttons[PersonageActions.DRINKING] = getButton(PersonageActions.DRINKING);
			buttons[PersonageActions.DISSATISFIED] = getButton(PersonageActions.DISSATISFIED);
			
			var i:int = 0;
			const coloumns:int = 5;
			
			for each(var button:Sprite in buttons) {
				button.x = 50 + (button.width + 10) * (i % coloumns);
				button.y = 50 + (button.height + 10) * Math.floor(i / coloumns);
				button.addEventListener(MouseEvent.CLICK, onPoseSelected);
				addChild(button);
				i++;
			}
			
			var personageModel:PersonageModel = new PersonageModel(modelObj);
			personageView = new PersonageView(personageModel);
			addChild(personageView);
			
			//personageView.showAction(PersonageActions.RESURRECTED);
			//personageView.showAction(PersonageActions.DRUNK);
			//personageView.showAction(PersonageActions.DRINKING);
			//personageView.showAction(PersonageActions.STROKING_BELLY);
			//personageView.showAction(PersonageActions.EATING);
			//personageView.showAction(PersonageActions.CONTUSED_BY_BOMB_DEATH);
			//personageView.showAction(PersonageActions.CONTUSED_BY_BOMB);
			//personageView.showAction(PersonageActions.POISONED_DEATH);
			//personageView.showAction(PersonageActions.POISONED);
			//personageView.showAction(PersonageActions.SHAKING);
			//personageView.showAction(PersonageActions.SCARED);
			//personageView.showAction(PersonageActions.LOOKS_ARROUND);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_DEATH);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOT_DEATH);
			//personageView.showAction(PersonageActions.DISSATISFIED);
			//personageView.showAction(PersonageActions.GIGGLES);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_SURVIVED);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOT_SURVIVED);
			//personageView.showAction(PersonageActions.SHOOT_SHOT_SURVIVED);
			//personageView.showAction(PersonageActions.CONTUSED);
			//personageView.showAction(PersonageActions.REVOLVING);
			//personageView.showAction(PersonageActions.JOY);
			//personageView.showAction(PersonageActions.PLEASURE);
			//personageView.showAction(PersonageActions.CARDIAC_ARREST);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOOT_MISFIRE);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_MISFIRE);
			//personageView.showAction(PersonageActions.SHOOT_MISFIRE);
			//personageView.showAction(PersonageActions.TOOK_OUT_GUN_FOR_REVOLVE);
			//personageView.showAction(PersonageActions.TOOK_OUT_GUN_FOR_SHOT);
			//personageView.showAction(PersonageActions.WAVING);
			//personageView.showAction(PersonageActions.SHOOT_SHOT_DEATH);
			
			personageView.x = stage.stageWidth / 2;
			personageView.y = stage.stageHeight / 2;
			personageView.scaleX = personageView.scaleY = 2//4.5;
			
		}
		
		private function onPoseSelected(event:MouseEvent):void {
			var button:Sprite = event.target as Sprite;
			var actionName:String;
			
			if (currentButton) {
				currentButton.alpha = 1;
				currentButton.mouseEnabled = true;
			}
			
			currentButton = button;
			
			for (actionName in buttons) {
				if (button == buttons[actionName]) {
					break;
				}
			}
			
			button.mouseEnabled = false;
			button.alpha = .3;
			personageView.showAction(actionName);
		}
		
		private function getButton(label:String):Sprite {
			const alphaDefault:Number = .75;
			const alphaOver:Number = .45;
			const alphaPress:Number = .9;
			const stateDefault:String = "default";
			const stateOver:String = "over";
			const statePress:String = "press";
			
			var button:Sprite = new Sprite();
			var buttonBG:Shape = new Shape();
			var textfield:TextField = new TextField();
			var state:String = stateDefault;
			var tfFormat:TextFormat = new TextFormat(null, 25);
			
			textfield.defaultTextFormat = tfFormat;
			
			buttonBG.graphics.beginFill(0xCCCCCC);
			buttonBG.graphics.drawRect(0, 0, 200, 45);
			buttonBG.graphics.endFill();
			textfield.text = label;
			textfield.autoSize = TextFieldAutoSize.LEFT;
			textfield.x = Math.round((buttonBG.width - textfield.width) / 2);
			textfield.y = Math.round((buttonBG.height - textfield.height) / 2);
			button.addChild(buttonBG);
			button.addChild(textfield);
			textfield.mouseEnabled = false;
			
			button.buttonMode = true;
			
			buttonBG.alpha = alphaDefault;
			
			
			button.addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent):void {
				if (state !== statePress) {
					state = stateOver;
					buttonBG.alpha = alphaOver;
				}
			});
			
			button.addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent):void {
				if (state !== statePress) {
					state = stateDefault;
					buttonBG.alpha = alphaDefault;
				}
			});
			
			button.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void {
				buttonBG.alpha = alphaPress;
				state = statePress;
				stage.addEventListener(MouseEvent.MOUSE_UP, function(event:MouseEvent):void {
					stage.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
					if (event.target === button) {
						state = stateOver;
						buttonBG.alpha = alphaOver;
					} else {
						state = stateDefault;
						buttonBG.alpha = alphaDefault;
					}
				});
			});
			return button;
		}
		
	}

}