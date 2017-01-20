//
//  PacienteViewController.m
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import "PacienteViewController.h"
#import "RootViewController.h"


@implementation PacienteViewController

@synthesize scrollView;

@synthesize documento;
@synthesize nombres;
@synthesize apellidos;
@synthesize edad;
@synthesize sexo;
@synthesize direccion;
@synthesize telefono;
@synthesize email;
@synthesize descAntecedentes;
@synthesize paciente;
@synthesize rootController;


#pragma mark -
#pragma mark Core Data

- (id)initWithRootController:(RootViewController *)aRootController paciente:(NSManagedObject *)aPaciente {
	
	if ((self = [super init])) {
		self.rootController = aRootController;
		self.paciente = aPaciente;
	}
	return self;
}


- (IBAction)save:(id)sender {
	
	
	if (rootController != nil) {
		if (paciente != nil) {
			[paciente setValue:documento.text forKey:@"documento"];
			[paciente setValue:nombres.text forKey:@"nombres"];
			[paciente setValue:apellidos.text forKey:@"apellidos"];
			[paciente setValue:edad.text forKey:@"edad"];
			[paciente setValue:sexo.text forKey:@"sexo"];
			[paciente setValue:direccion.text forKey:@"direccion"];
			[paciente setValue:telefono.text forKey:@"telefono"];
			[paciente setValue:email.text forKey:@"email"];
			[paciente setValue:descAntecedentes.text forKey:@"descAntecedentes"];
			[rootController saveContext];
			
		}else {
			[rootController insertPacienteWithName:apellidos.text direccion:direccion.text documento:documento.text edad:edad.text email:email.text nombres:nombres.text sexo:sexo.text telefono:telefono.text descAntecedentes:descAntecedentes.text];
		}
		
	}
	
	
	UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Paciente" 
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


- (void)viewDidLoad {
    
	[super viewDidLoad];

	scrollView.frame = CGRectMake(0, 0, 320, 460);
	[scrollView setContentSize:CGSizeMake(320, 500)];
	descAntecedentes.font = [UIFont systemFontOfSize:12.0];
	
	if (paciente != nil) {
		documento.text = [paciente valueForKey:@"documento"];
		nombres.text = [paciente valueForKey:@"nombres"];
		apellidos.text = [paciente valueForKey:@"apellidos"];
		edad.text = [paciente valueForKey:@"edad"];
		sexo.text = [paciente valueForKey:@"sexo"];
		direccion.text = [paciente valueForKey:@"direccion"];
		telefono.text = [paciente valueForKey:@"telefono"];
		email.text = [paciente valueForKey:@"email"];
		descAntecedentes.text = [paciente valueForKey:@"descAntecedentes"];
	}
	
	
	[super viewDidLoad];
	
}

#pragma mark -
#pragma mark Scroller

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

//Cuando un textfield view comienza a ser editado
- (void) textFieldDidBeginEditing:(UITextField *) textFieldView {
	currentTextField = textFieldView;
}

//Cuando el usuario oprime enter en el teclado
- (BOOL) textFieldShouldReturn:(UITextField *) textFieldView {
	[textFieldView resignFirstResponder];
	return NO;
}

//Cuando un textfieldview esta editado
- (void) textFieldDidEndEditing:(UITextField *) textFieldView {
	currentTextField = nil;
}


//Cuando el teclado aparece
- (void) keyboardDidShow:(NSNotification *) notification {
	if (keyboardIsShown) return;
	
	NSDictionary* info = [notification userInfo];
	
	//Conocer el tamano del teclado
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

//Cuando el teclado desaparece
- (void) keyboardDidHide:(NSNotification *) notification {
	NSDictionary* info = [notification userInfo];
	
	//Conocer el tamano del teclado
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

//antes que view window desaparezca
- (void) viewWillDisappear:(BOOL)animated {
	//remueve las notificaciones del teclado
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillShowNotification
	 object:nil];
	
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillHideNotification
	 object:nil];
}

- (IBAction)doneEditing:(id)sender {
	
	[sender resignFirstResponder];
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
	/*[documento release];
	[nombres release];
	[apellidos release];
	[edad release];
	[sexo release];
	[direccion release];
	[telefono release];
	[email release]; */
	[scrollView release];
	[paciente release];
	[rootController release];
}


@end
