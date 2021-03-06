//
//  RootViewController.m
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import "RootViewController.h"
#import "PacienteViewController.h"
#import "ConsultaListViewController.h"


@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation RootViewController

@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;


#pragma mark -
#pragma mark Core Data

- (void)insertPacienteWithName:(NSString *)apellidos direccion:(NSString *)direccion documento:(NSString *)documento edad:(NSString *)edad email:(NSString *)email nombres:(NSString *)nombres sexo:(NSString *)sexo telefono:(NSString *)telefono descAntecedentes:(NSString *)descAntecedentes{
	
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	
	NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
	
	//Configurar el nuevo paciente
	
	
	[newManagedObject setValue:apellidos forKey:@"apellidos"];
	[newManagedObject setValue:direccion forKey:@"direccion"];
	[newManagedObject setValue:documento forKey:@"documento"];
	[newManagedObject setValue:edad forKey:@"edad"];
	[newManagedObject setValue:email forKey:@"email"];
	[newManagedObject setValue:nombres forKey:@"nombres"];
	[newManagedObject setValue:sexo forKey:@"sexo"];
	[newManagedObject setValue:telefono forKey:@"telefono"];
	[newManagedObject setValue:descAntecedentes forKey:@"descAntecedentes"];
	
	
	//Salvar el contexto
	
	[self saveContext];
	
}

- (void)insertConsultaWithPaciente:(NSManagedObject *)paciente motivo:(NSString *)motivo enfermedadAct:(NSString *)enfermedadAct temperatura:(NSString *)temperatura tensionAr:(NSString *)tensionAr frecuCar:(NSString *)frecuCar frecuRes:(NSString *)frecuRes talla:(NSString *)talla peso:(NSString *)peso diagnostico:(NSString *)diagnostico conducta:(NSString *)conducta {
	
	//Create the Consulta
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	
	NSManagedObject *consulta = [NSEntityDescription insertNewObjectForEntityForName:@"Consulta" inManagedObjectContext:context];
	
	[consulta setValue:motivo forKey:@"motivo"];
	[consulta setValue:enfermedadAct forKey:@"enfermedadAct"];
	[consulta setValue:temperatura forKey:@"temperatura"];
	[consulta setValue:tensionAr forKey:@"tensionAr"];
	[consulta setValue:frecuCar forKey:@"frecuCar"];
	[consulta setValue:frecuRes forKey:@"frecuRes"];
	[consulta setValue:talla forKey:@"talla"];
	[consulta setValue:peso forKey:@"peso"];
	[consulta setValue:diagnostico forKey:@"diagnostico"];
	[consulta setValue:conducta forKey:@"conducta"];
	[consulta setValue:paciente forKey:@"paciente"];
	
	[consulta setValue:[NSDate date] forKey:@"timeStamp"];
	
	
	
	[self saveContext];
}



- (void)saveContext {
	
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	
	NSError *error = nil;
	if (![context save:&error]) {
		/* Replace the code*/
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

- (void)showPacienteView {
	
	PacienteViewController *pacienteViewController = [[PacienteViewController alloc]initWithRootController:self paciente:nil];
	
	[self presentModalViewController:pacienteViewController animated:YES];
	[pacienteViewController release];
	
}

-(void)deleteConsulta:(NSManagedObject *)consulta {
	
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	
	[context deleteObject:consulta];
	[self saveContext];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Pacientes";

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showPacienteView)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *paciente = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	ConsultaListViewController *consultaListViewController = [[ConsultaListViewController alloc] initWithRootController:self paciente:paciente];
	[self.navigationController pushViewController:consultaListViewController animated:YES];
	[consultaListViewController release];
}



// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[managedObject valueForKey:@"nombres"] description],[[managedObject valueForKey:@"apellidos"] description]]; 
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
}


#pragma mark -
#pragma mark Add a new object
/*
- (void)insertNewObject {
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
      /*  NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}*/


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {

    // Prevent new objects being added when in editing mode.
    [super setEditing:(BOOL)editing animated:(BOOL)animated];
    self.navigationItem.rightBarButtonItem.enabled = !editing;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"TableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		
		[self saveContext];
        
        // Save the context.
       /* NSError *error = nil;
        if (![context save:&error]) {
        
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }*/
    }   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *paciente = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	PacienteViewController *pacienteViewController = [[PacienteViewController alloc]initWithRootController:self paciente:paciente];
	
	[self presentModalViewController:pacienteViewController animated:YES];
	[pacienteViewController release];
	
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
    
    /*
     Set up the fetched results controller.
    */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Paciente" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nombres" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController_;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [fetchedResultsController_ release];
    [managedObjectContext_ release];
    [super dealloc];
}


@end

