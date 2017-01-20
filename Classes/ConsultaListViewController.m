//
//  ConsultaListViewController.m
//  MiConsulta
//
//  Created by Melissa Rojas on 6/17/11.
//  Copyright 2011 UPTC. All rights reserved.
//

#import "ConsultaListViewController.h"
#import "RootViewController.h"
#import "ConsultaViewController.h"
#import "ConsultaRViewController.h"


@implementation ConsultaListViewController


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


- (void)showConsultaView {
	
	ConsultaViewController *consultaViewController = [[ConsultaViewController alloc] initWithRootController:rootController paciente:paciente consulta:nil];
	[self presentModalViewController:consultaViewController animated:YES];
	[consultaViewController release];
	
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Historia Clínica";
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showConsultaView)];
	
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[super.tableView reloadData];
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


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return [(NSSet *)[paciente valueForKey:@"consultas"] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"ConsultaCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		
	}
	
	NSManagedObject *consulta = [[self sortConsultas] objectAtIndex:indexPath.row];
	//cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[consulta valueForKey:@"fecha"] description], [[consulta valueForKey:@"hora"] description]];
	
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	
	cell.textLabel.text = [formatter stringFromDate:[consulta valueForKey:@"timeStamp"]];
	
	[formatter release];
	
	return cell;
}

- (NSArray *)sortConsultas {
	
	NSSortDescriptor *sortfechaDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES] autorelease];
	
	NSArray *sortDescriptors = [NSArray arrayWithObjects:sortfechaDescriptor, nil];
	return [[(NSSet *)[paciente valueForKey:@"consultas"]allObjects] sortedArrayUsingDescriptors:sortDescriptors];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *consulta = [[self sortConsultas] objectAtIndex:indexPath.row];
	ConsultaRViewController *consultaRViewController = [[ConsultaRViewController alloc] initWithRootController:rootController paciente:paciente consulta:consulta];
	[self presentModalViewController:consultaRViewController animated:YES];
	[consultaRViewController release];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[rootController release];
	[paciente release];
}


@end

