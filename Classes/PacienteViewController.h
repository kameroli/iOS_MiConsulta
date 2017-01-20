//
//  PacienteViewController.h
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;


@interface PacienteViewController : UIViewController {
	
	IBOutlet UIScrollView *scrollView;
	UITextField *currentTextField;
	BOOL keyboardIsShown;
	
	IBOutlet UITextField *documento;
	IBOutlet UITextField *nombres;
	IBOutlet UITextField *apellidos;
	IBOutlet UITextField *edad;
	IBOutlet UITextField *sexo;
	IBOutlet UITextField *direccion;
	IBOutlet UITextField *telefono;
	IBOutlet UITextField *email;
	IBOutlet UITextView *descAntecedentes;
	
	NSManagedObject *paciente;
	RootViewController *rootController;
	
}


@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) UITextField *documento;
@property (nonatomic, retain) UITextField *nombres;
@property (nonatomic, retain) UITextField *apellidos;
@property (nonatomic, retain) UITextField *edad;
@property (nonatomic, retain) UITextField *sexo;
@property (nonatomic, retain) UITextField *direccion;
@property (nonatomic, retain) UITextField *telefono;
@property (nonatomic, retain) UITextField *email;
@property (nonatomic, retain) UITextView *descAntecedentes;
@property (nonatomic, retain) NSManagedObject *paciente;
@property (nonatomic, retain) RootViewController *rootController;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)doneEditing:(id)sender;
//- (IBAction)bgTouch:(id)sender;
- (id)initWithRootController:(RootViewController *)aRootController paciente:(NSManagedObject *)aPaciente;



@end