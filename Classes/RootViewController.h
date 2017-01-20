//
//  RootViewController.h
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)insertPacienteWithName:(NSString *)apellidos direccion:(NSString *)direccion documento:(NSString *)documento edad:(NSString *)edad email:(NSString *)email nombres:(NSString *)nombres sexo:(NSString *)sexo telefono:(NSString *)telefono descAntecedentes:(NSString *)descAntecedentes;
- (void)saveContext;
- (void)showPacienteView;
- (void)insertConsultaWithPaciente:(NSManagedObject *)paciente motivo:(NSString *)motivo enfermedadAct:(NSString *)enfermedadAct temperatura:(NSString *)temperatura tensionAr:(NSString *)tensionAr frecuCar:(NSString *)frecuCar frecuRes:(NSString *)frecuRes talla:(NSString *)talla peso:(NSString *)peso diagnostico:(NSString *)diagnostico conducta:(NSString *)conducta;
- (void)deleteConsulta:(NSManagedObject *)consulta;

@end
