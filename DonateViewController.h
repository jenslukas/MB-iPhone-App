//
//  DonateViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 8/9/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Donation view to select donation amount and pay with paypal


#import <UIKit/UIKit.h>
#import "PayPal.h"

@interface DonateViewController : UITableViewController <PayPalMEPDelegate> {
	NSString *amount;
}
@end
