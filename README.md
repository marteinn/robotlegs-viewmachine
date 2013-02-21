robotlegs-viewmachine
=====================

View Machine is a light weight state handling tool for RobotLegs, heavily influenced by Django it uses regular expressions to control the states in a application.
Taking advantage of RobotLegs mapView and its own bindToView, you will be up and ready in a heartbeat.

Usage
-------
	// Basically you start off with using your RobotLegs context.
	_context = new ExampleContext( this, true );


	// This is how your context might look like
	package com.example
	{	
		import org.robotlegs.mvcs.SignalContext;
	
		import com.example.mvc.controls.commands.PrepControllerCommand;
		import com.example.mvc.controls.commands.PrepModelCommand;
		import com.example.mvc.controls.commands.PrepServiceCommand;
		import com.example.mvc.controls.commands.PrepViewCommand;
		import com.example.mvc.controls.commands.StartupCommand;
		import com.example.mvc.signals.ApplicationStartSignal;
	
		public class ExampleContext extends SignalContext
		{
			public function ExampleContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
			{
				super(contextView, autoStartup);
			}
		
			override public function startup() : void
			{
				// map prep commands
				signalCommandMap.mapSignalClass( ApplicationStartSignal, PrepModelCommand, true );
				signalCommandMap.mapSignalClass( ApplicationStartSignal, PrepControllerCommand, true );
				signalCommandMap.mapSignalClass( ApplicationStartSignal, PrepServiceCommand, true );
				signalCommandMap.mapSignalClass( ApplicationStartSignal, PrepViewCommand, true );
			
				// run startup
				ApplicationStartSignal(signalCommandMap.mapSignalClass( ApplicationStartSignal, StartupCommand, true )).dispatch();
			
			}
		}
	}
	
Prep ViewMachine commands
-------

	package com.example.mvc.controls.commands
	{
		import org.robotlegs.mvcs.SignalCommand;
	
		import se.birth.robotlegs.viewmachine_signals.controls.commands.PrepViewMachineCommand;
		import se.birth.robotlegs.viewmachine_signals.controls.signals.DrawStateSignal;
		import se.birth.robotlegs.viewmachine_signals.signals.PrepViewMachineSignal;
	
		import com.example.mvc.controls.signals.BindViewsSignal;
		import com.example.mvc.controls.signals.InitApplicationSignal;
	
		public class PrepControllerCommand extends SignalCommand
		{
			override public function execute() : void
			{
				// Everyone needs a InitApplicationCommand, right?
				signalCommandMap.mapSignalClass( InitApplicationSignal, InitApplicationCommand, true );
			
				// These two are ViewMachine specific
				signalCommandMap.mapSignalClass( PrepViewMachineSignal, PrepViewMachineCommand, true );
				signalCommandMap.mapSignalClass( DrawStateSignal, DrawStateCommand );
			
				// This is a project based command used to bind views to ViewMachine
				signalCommandMap.mapSignalClass( BindViewsSignal, BindViewsCommand, true );
			
				// Add your other command preps here
			}
		}
	}

This is the command where we bind your state views to ViewMachine
-------
	package com.example.mvc.controls.commands
	{
		import org.robotlegs.mvcs.Command;
	
		import se.birth.robotlegs.viewmachine_signals.models.actors.BindingActor;
		import com.example.mvc.views.components.states.BlogView;
		import com.example.mvc.views.components.states.PageView;
	
		public class BindViewsCommand extends Command
		{
			[Inject]
			public var bindings:BindingActor;
		
			override public function execute() : void
			{		
				// States
				bindings.bindToView( 
					BlogView
					, "^/blog/<page_id>/"
					, [
						"^/blog/<page_id>/$"
						, "^/blog/<page_id>/post/<post_id>/$"
					]       
				);

				bindings.bindToView( 
					PageView
					, "^/(default|textpage)/<page_id>/"
					, [
						"^/textpage/<page_id>/$"
						, "^/default/<page_id>/$"
					] 
				);		
			}
		}
	}

StartupCommand
-------
	package com.example.mvc.controls.commands
	{
		import org.robotlegs.mvcs.Command;
	
		import se.birth.robotlegs.viewmachine_signals.signals.PrepViewMachineSignal;
		import se.birth.robotlegs.viewmachine_signals.signals.vo.ViewMachinePropertiesVO;
	
		public class StartupCommand extends Command
		{
			[Inject]
			public var prepViewMachine:PrepViewMachineSignal;
		
			override public function execute() : void
			{
				// In startup view you can add background, preloader, config loading
				// contextView.addChild( new BackgroundView() );
				// contextView.addChild( new PreloadView() );
				// loadConfig.dispatch();
			
				// And start prepping view machine with the default state (if no state is present) and error state (state is not found)
				prepViewMachine.dispatch( new ViewMachinePropertiesVO( "", "" ) );	
			
			}
		}
	}


InitApplication
-------
	package com.example.mvc.controls.commands
	{	
		import org.robotlegs.mvcs.Command;
	
		import se.birth.robotlegs.viewmachine_signals.controls.signals.DefineDefaultStateSignal;
		import se.birth.robotlegs.viewmachine_signals.controls.signals.DefineErrorStateSignal;
		import se.birth.robotlegs.viewmachine_signals.controls.signals.RunViewMachineSignal;
		import com.example.mvc.controls.signals.BindViewsSignal;
	
		public class InitApplicationCommand extends Command
		{
			[Inject]
			public var defineDefaultState:DefineDefaultStateSignal;
		
			[Inject]
			public var defineErrorState:DefineErrorStateSignal;
		
			[Inject]
			public var bindViews:BindViewsSignal;
		
			[Inject]
			public var runViewMachine:RunViewMachineSignal;
		
			override public function execute() : void
			{
				// Excellent oppertunity to add menu views etc.
				// contextView.addChild( new MenuView() );
				// contextView.addChild( new FooterView() );
				// contextView.addChild( new LeftNoteView() );
				// contextView.addChild( new LinesView() );
				// contextView.addChild( new ShareView() );
			
				// You can also define default state and error state using these two, although not required
				defineDefaultState.dispatch( "/welcome/" );
				defineErrorState.dispatch( "/error/" );
			
				// Bind your custom views to ViewMachine
				bindViews.dispatch();
			
				// Start view machine!
				runViewMachine.dispatch();
			}
		}
	}



And a example of a state mediator
-------
	package com.example.mvc.views.mediators.states
	{
		import flash.display.Sprite;
	
		import org.robotlegs.core.IMediator;
		import org.robotlegs.mvcs.Mediator;
	
		import se.birth.robotlegs.viewmachine_signals.controls.signals.RefreshStateSignal;
		import se.birth.robotlegs.viewmachine_signals.controls.signals.RemoveStateSignal;
		import se.birth.robotlegs.viewmachine_signals.models.actors.StateActor;
		import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
		public class BlogView extends Mediator implements IMediator
		{
		
			[Inject]
			public var stateActor:StateActor;
		
			[Inject(name="stateData")]
			public var initStateVO:StateVO;
		
			[Inject]
			public var refreshState:RefreshStateSignal;
		
			[Inject]
			public var removeState:RemoveStateSignal;
		
			override public function onRegister() : void
			{
				init ();
				draw ();
			}
		
			override public function onRemove () : void
			{
				destroy ();
			}
		
			protected function init () : void
			{
				refreshState.add( refreshStateHandler );
				removeState.addOnce( removeStateHandler );
			
				currentStateActor.state = this;
			}
		
			protected function draw () : void
			{
		
			}
		
			protected function destroy () : void
			{
				var view:Sprite;
			
				view = viewComponent as Sprite;
				view.parent.removeChild( view );
			
				// Remove handlers
				refreshState.remove( refreshStateHandler );
				removeState.remove( removeStateHandler );
			}

			/**
			 * Handlers
			 */

			// If ViewMachine has detected new params for the view, run refresh		
			protected function refreshStateHandler ( state:StateVO ) : void
			{
		
				// StateVO delivers the updated values (such as post_id)
				// from the binded url -> view "^/blog/<page_id>/post/<post_id>/$"
				if( state.values.post_id != null )
				{
					// do something
				}
			}
		
			// Remove when state is no longer active
			protected function removeStateHandler ( state:StateVO  ) : void
			{
				// View Ma
				mediatorMap.removeMediator( this );
			}
		}
	}

Requires
-------
SWFAddress, RobotLegs 1, Signals and Flash Player 10.
