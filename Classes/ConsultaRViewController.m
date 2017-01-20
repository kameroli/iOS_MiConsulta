//
//  ConsultaRViewController.m
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import "ConsultaRViewController.h"
#import "RootViewController.h"


@implementation ConsultaRViewController


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
#pragma mark Core Data

- (id)initWithRootController:(RootViewController *)aRootController paciente:(NSManagedObject *)aPaciente consulta:(NSManagedObject *)aConsulta {
	
	if ((self = [super init])) {
		self.rootController = aRootController;
		self.paciente = aPaciente;
		self.consulta = aConsulta;
	}
	return self;
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
	
	scrollView.frame = CGRectMake(0, 0, 320, 460);//460
	[scrollView setContentSize:CGSizeMake(320, 600)];
	motivo.font = [UIFont systemFontOfSize:14.0];
	enfermedadAct.font = [UIFont systemFontOfSize:14.0];
	diagnostico.font = [UIFont systemFontOfSize:14.0];
	conducta.font = [UIFont systemFontOfSize:14.0];
	
	
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

- (IBAction)atras:(id)sender {
	
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)confirmDelete:(id)sender {
	
	if (consulta != nil) {
		UIActionSheet *confirm = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:@"Borrar Consulta" otherButtonTitles:nil];
		confirm.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
		[confirm showInView:self.view];
		[confirm release];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0 && rootController != nil) {
		//The Delete button was clicked
		[rootController deleteConsulta:consulta];
		[self dismissModalViewControllerAnimated:YES];
	}
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
