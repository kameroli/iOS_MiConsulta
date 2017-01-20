//
//  ConsultaListViewController.h
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//


#import <UIKit/UIKit.h>

@class RootViewController;


@interface ConsultaListViewController : UITableViewController {
	NSManagedObject *paciente;
	RootViewController *rootController;
	
}
@property (nonatomic, retain) NSManagedObject *paciente;
@property (nonatomic, retain) RootViewController *rootController;

- (id)initWithRootController:(RootViewController *)aRootController paciente:(NSManagedObject *)aPaciente;
- (void)showConsultaView;
- (NSArray *)sortConsultas;


@end
