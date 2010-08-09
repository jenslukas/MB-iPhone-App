//
//  LabelSearchController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays results of label search

#import "LabelSearchController.h"
#import	"LabelViewController.h"
#import "Label.h"

@implementation LabelSearchController
@synthesize labels;

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [labels count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
    Label *label = [labels objectAtIndex:indexPath.row];
	cell.textLabel.text = label.name;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// show detail page for selected label
	Label *label = [labels objectAtIndex:indexPath.row];
	
	LabelViewController *labelController = [[LabelViewController alloc] initWithStyle:UITableViewStyleGrouped];
	
	// get details for label
	ServiceFacade *serviceFacade = [ServiceFacade alloc];
	serviceFacade.delegate = labelController;
	[serviceFacade getLabel:label.mbid];
	
	[self.navigationController pushViewController:labelController	animated:YES];
	[labelController release];	
}

- (void) finishedRequest:(NSArray *) results {
	self.labels = [NSArray arrayWithArray:results];
	[self.tableView reloadData];
}

- (void)dealloc {
	labels = nil;
	[labels release];
    [super dealloc];
}


@end

