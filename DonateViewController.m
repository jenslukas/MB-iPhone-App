//
//  DonateViewController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 8/9/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Donation view to select donation amount and pay with paypal

#import "DonateViewController.h"

// PayPal imports
#import "PayPal.h"
#import "MEPAmounts.h"
#import "MEPAddress.h"
#import "PayPalMEPPayment.h"

@implementation DonateViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	[PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX];
	self.title = @"Donate";
	[self.navigationController setNavigationBarHidden:NO];		

	// initial amount
	amount = @"10.0";
	
	UIButton *button = [[PayPal getInstance] getPayButton:self buttonType:BUTTON_278x43 startCheckOut:@selector(payWithPayPal) PaymentType:DONATION withLeft:20 withTop:240];	
	[self.view addSubview:button];
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"$10";
			cell.accessoryType = UITableViewCellAccessoryCheckmark;			
			break;
		case 1:
			cell.textLabel.text = @"$25";
			break;		
		case 2:
			cell.textLabel.text = @"$50";
			break;
		case 3:
			cell.textLabel.text = @"$100";
			break;	
		case 4:
			cell.textLabel.text = @"$500";
			break;
		default:
			break;
	}
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// reset previous checkmark
	for (int i = 0; i < 5; i++) {
		NSIndexPath *oldSelectionIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:oldSelectionIndexPath];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	// set new checkmark
	NSIndexPath *newSelectionIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:newSelectionIndexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark
	;	
	
	// set new amount
    switch (indexPath.row) {
		case 0:
			amount = @"10.0";			
			break;
		case 1:
			amount = @"25.0";
			break;
		case 2:
			amount = @"50.0";
			break;
		case 3:
			amount = @"100.0";
			break;
		case 4:
			amount = @"500.0";
			break;
		default:
			break;
	}
}


#pragma mark -
#pragma mark PayPal Delegates

-(void)payWithPayPal {
	PayPal *pp = [PayPal getInstance]; 
	[pp DisableShipping]; 
	[pp feePaidByReceiver];
	
	PayPalMEPPayment *payment =[[PayPalMEPPayment alloc] init]; 
	payment.paymentCurrency= @"USD"; 
	payment.paymentAmount= [NSString stringWithString:amount]; 
	payment.itemDesc = @"Musicbrainz Donation"; 
	payment.recipient = @"jenslu_1279886203_biz@googlemail.com"; 
	payment.merchantName = @"Jens Lukas's Test Store"; 
	[pp Checkout:payment]; 
	[payment release];	
}

-(void)paymentSuccess:(NSString*)transactionID {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Donation successful" 
													message:@"Thank you for your donation." 
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)paymentCanceled {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Donation canceled" 
													message:@"You canceled your donation." 
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)paymentFailed:(PAYPAL_FAILURE)errorType {
	//NSLog("%@", errorType);
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


- (void)dealloc {
    [super dealloc];
}


@end

