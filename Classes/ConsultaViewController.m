//
//  ConsultaViewController.m
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import "ConsultaViewController.h"
#import "RootViewController.h"


@implementation ConsultaViewController

@synthesize scrollView;

@synthesize fecha;
@synthesize motivo;
@synthesize enfermedadAct;
@synthesize temperatura;
@synthesize tensionAr;
@synthesize frecuCar;
@synthesize frecuRes;
@synthesize talla;
@synthesize peso;
@synthesize diagnostico;
@synthesize conducta;
@synthesize paciente;
@synthesize consulta;
@synthesize rootController;

#pragma mark -
#pragma mark Core Data.


- (id)initWithRootController:(RootViewController *)aRootController paciente:(NSManagedObject *)aPaciente consulta:(NSManagedObject *)aConsulta {
	
	if ((self = [super init])) {
		self.rootController = aRootController;
		self.paciente = aPaciente;
		self.consulta = aConsulta;
	}
	return self;
}

- (IBAction)save:(id)sender {
	
	if (rootController != nil) {
		if (consulta != nil) {
			[consulta setValue:motivo.text forKey:@"motivo"];
			[consulta setValue:enfermedadAct.text forKey:@"enfermedadAct"];
			[consulta setValue:temperatura.text forKey:@"temperatura"];
			[consulta setValue:tensionAr.text forKey:@"tensionAr"];
			[consulta setValue:frecuCar.text forKey:@"frecuCar"];
			[consulta setValue:frecuRes.text forKey:@"frecuRes"];
			[consulta setValue:talla.text forKey:@"talla"];
			[consulta setValue:peso.text forKey:@"peso"];
			[consulta setValue:diagnostico.text forKey:@"diagnostico"];
			[consulta setValue:conducta.text forKey:@"conducta"];
			[consulta setValue:[NSDate date] forKey:@"timeStamp"];
			[rootController saveContext];
			
		}else {
			[rootController insertConsultaWithPaciente:paciente motivo:motivo.text enfermedadAct:enfermedadAct.text temperatura:temperatura.text tensionAr:tensionAr.text frecuCar:frecuCar.text frecuRes:frecuRes.text talla:talla.text peso:peso.text diagnostico:diagnostico.text conducta:conducta.text];
			
		}
	}
	
	UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Consulta" 
													message:@"Los datos han sido almacenados correctamente" 
												   delegate:self 
										  cancelButtonTitle:@"Listo" 
										  otherButtonTitles:nil];
	[alerta show];
	[alerta release];
	
	[self dismissModalViewControllerAnimated:YES];
	
}

- (IBAction)cancel:(id)sender {
	
	[self dismissModalViewControllerAnimated:YES];
}





// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	scrollView.frame = CGRectMake(0, -20, 320, 460);//460
	[scrollView setContentSize:CGSizeMake(320, 600)];
	
	motivo.font = [UIFont systemFontOfSize:12.0];
	enfermedadAct.font = [UIFont systemFontOfSize:12.0];
	diagnostico.font = [UIFont systemFontOfSize:12.0];
	conducta.font = [UIFont systemFontOfSize:12.0];
	
	if (consulta != nil) {
		motivo.text = [consulta valueForKey:@"motivo"];
		enfermedadAct.text = [consulta valueForKey:@"enfermedadAct"];
		temperatura.text = [consulta valueForKey:@"temperatura"];
		tensionAr.text = [consulta valueForKey:@"tensionAr"];
		frecuCar.text = [consulta valueForKey:@"frecuCar"];
		frecuRes.text = [consulta valueForKey:@"frecuRes"];
		talla.text = [consulta valueForKey:@"talla"];
		peso.text = [consulta valueForKey:@"peso"];
		diagnostico.text = [consulta valueForKey:@"diagnostico"];
		conducta.text = [consulta valueForKey:@"conducta"];
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterShortStyle];
		[formatter setTimeStyle:NSDateFormatterShortStyle];
		fecha.text = [formatter stringFromDate:[consulta valueForKey:@"timeStamp"]];
		[formatter release];
	}
	
}

- (void)viewWillAppear:(BOOL)animated{
	
	[[NSNotificationCenter defaultCenter] 
	 addObserver:self 
	 selector:@selector(keyboardDidShow:)
	 name:UIKeyboardDidShowNotification
	 object:self.view.window];
	
	[[NSNotificationCenter defaultCenter] 
	 addObserver:self 
	 selector:@selector(keyboardDidHide:)
	 name:UIKeyboardDidHideNotification
	 object:nil];
	
}

//cuando un textfield view comienza a ser editado
- (void) textFieldDidBeginEditing:(UITextField *) textFieldView {
	currentTextField = textFieldView;
}

//cuando el usuario oprime enter en el teclado
- (BOOL) textFieldShouldReturn:(UITextField *) textFieldView {
	[textFieldView resignFirstResponder];
	return NO;
}

//cuando un textfieldview esta editado
- (void) textFieldDidEndEditing:(UITextField *) textFieldView {
	currentTextField = nil;
}

//cuando el teclado aparece
- (void) keyboardDidShow:(NSNotification *) notification {
	if (keyboardIsShown) return;
	
	NSDictionary* info = [notification userInfo];
	
	//conocer el tamano del teclado
	NSValue *aValue =
	[info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardRect =
	[self.view convertRect:[aValue CGRectValue] fromView:nil];
	
	NSLog(@"%f", keyboardRect.size.height);
	
	//ajustar el scroll view (con teclado)
	CGRect viewFrame = [scrollView frame];
	viewFrame.size.height -= keyboardRect.size.height;
	scrollView.frame = viewFrame;
	
	//scroll al textfield actual
	CGRect textFieldRect = [currentTextField frame];
	[scrollView scrollRectToVisible:textFieldRect animated:YES];
	
	keyboardIsShown = YES;
}

//cuando el teclado desaparece
- (void) keyboardDidHide:(NSNotification *) notification {
	NSDictionary* info = [notification userInfo];
	
	//conocer el tamaño del teclado
	NSValue* aValue =
	[info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardRect =
	[self.view convertRect:[aValue CGRectValue] fromView:nil];
	
	//ajustar el scrollview al tamaño original sin el teclado
	CGRect viewFrame = [scrollView frame];
	viewFrame.size.height += keyboardRect.size.height;
	scrollView.frame = viewFrame;
	
	keyboardIsShown = NO;
}


- (IBAction)doneEditing:(id)sender {
	
	[sender resignFirstResponder];
	
}

- (void) viewWillDisappear:(BOOL)animated {
	//remueve las notoficaciones del teclado
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillShowNotification
	 object:nil];
	
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillHideNotification
	 object:nil];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[scrollView release];
	[fecha release];
	[motivo release];
	[enfermedadAct release];
	[temperatura release];
	[tensionAr release];
	[frecuCar release];
	[frecuRes release];
	[talla release];
	[peso release];
	[diagnostico release];
	[conducta release];
	
	[paciente release];
	[consulta release];
}


@end
