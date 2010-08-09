//
//  LabelViewController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for label entity

#import "LabelViewController.h"
#import "TagListViewController.h"


@implementation LabelViewController
@synthesize label;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Label";	
	parsed = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(parsed) {
		return 3;
	} else {
		return 0;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	switch(indexPath.row) {
		case 0:
			cell.detailTextLabel.text = @"Title";
			cell.textLabel.text = self.label.name;
			break;
		case 1:
			cell.detailTextLabel.text = @"Type";
			cell.textLabel.text = self.label.type;
			break;
		case 2: {
			NSString *tags = [[self.label.tags valueForKey:@"description"] componentsJoinedByString:@", "];			
			cell.detailTextLabel.text = @"Tags";
			cell.textLabel.text = tags;
			break;
		}
	}
	
    return cell;
}

-(NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
	return @"General information";
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 0) {
		if(indexPath.row == 3) {
			TagListViewController *tagListViewController = [[TagListViewController alloc] initWithStyle:UITableViewStyleGrouped];
			tagListViewController.entity = self.label;
			
			[self.navigationController pushViewController:tagListViewController animated:YES];
			[tagListViewController release];
		}
	}
}

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

-(void) finishedRequest:(id)results {
	self.label = [results objectAtIndex:0];
	parsed = YES;
	[self.tableView reloadData];
}

- (void)dealloc {
    [super dealloc];
}


@end

