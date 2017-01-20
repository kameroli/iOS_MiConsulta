//
//  ConsultaRViewController.h
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;


@interface ConsultaRViewController : UIViewController <UIActionSheetDelegate> {
	
	
	IBOutlet UIScrollView *scrollView;
	UITextField *currentTextField;
	BOOL keyboardIsShown;
	
	IBOutlet UILabel *fecha;
	IBOutlet UITextView *motivo;
	IBOutlet UITextView *enfermedadAct;
	IBOutlet UILabel *temperatura;
	IBOutlet UILabel *tensionAr;
	IBOutlet UILabel *frecuCar;
	IBOutlet UILabel *frecuRes;
	IBOutlet UILabel *talla;
	IBOutlet UILabel *peso;
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
@property (nonatomic, retain) UILabel *temperatura;
@property (nonatomic, retain) UILabel *tensionAr;
@property (nonatomic, retain) UILabel *frecuCar;
@property (nonatomic, retain) UILabel *frecuRes;
@property (nonatomic, retain) UILabel *talla;
@property (nonatomic, retain) UILabel *peso;
@property (nonatomic, retain) UITextView *diagnostico;
@property (nonatomic, retain) UITextView *conducta;
@property (nonatomic, retain) NSManagedObject *paciente;
@property (nonatomic, retain) NSManagedObject *consulta;
@property (nonatomic, retain) RootViewController *rootController;


- (IBAction)atras:(id)sender;
- (IBAction)confirmDelete:(id)sender; 
- (id)initWithRootController:(RootViewController *)aRootController paciente:(NSManagedObject *)aPaciente consulta:(NSManagedObject *)aConsulta;



@end