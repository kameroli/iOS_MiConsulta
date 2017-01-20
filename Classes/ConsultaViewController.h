//
//  ConsultaViewController.h
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface ConsultaViewController : UIViewController <UIActionSheetDelegate> {
	
	
	IBOutlet UIScrollView *scrollView;
	UITextField *currentTextField;
	BOOL keyboardIsShown;
	
	IBOutlet UILabel *fecha;
	IBOutlet UITextView *motivo;
	IBOutlet UITextView *enfermedadAct;
	IBOutlet UITextField *temperatura;
	IBOutlet UITextField *tensionAr;
	IBOutlet UITextField *frecuCar;
	IBOutlet UITextField *frecuRes;
	IBOutlet UITextField *talla;
	IBOutlet UITextField *peso;
	IBOutlet UITextView *diagnostico;
	IBOutlet UITextView *conducta;
	NSManagedObject *paciente;
	NSManagedObject *consulta;
	RootViewController *rootController;
	
}
@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) UILabel *fecha;
@property (nonatomic, retain) UITextView *motivo;
@property (nonatomic, retain) UITextView *enfermedadAct;
@property (nonatomic, retain) UITextField *temperatura;
@property (nonatomic, retain) UITextField *tensionAr;
@property (nonatomic, retain) UITextField *frecuCar;
@property (nonatomic, retain) UITextField *frecuRes;
@property (nonatomic, retain) UITextField *talla;
@property (nonatomic, retain) UITextField *peso;
@property (nonatomic, retain) UITextView *diagnostico;
@property (nonatomic, retain) UITextView *conducta;
@property (nonatomic, retain) NSManagedObject *paciente;
@property (nonatomic, retain) NSManagedObject *consulta;
@property (nonatomic, retain) RootViewController *rootController;


- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)doneEditing:(id)sender;
//- (IBAction)bgTouch:(id)sender;
- (id)initWithRootController:(RootViewController *)aRootController paciente:(NSManagedObject *)aPaciente consulta:(NSManagedObject *)aConsulta;



@end