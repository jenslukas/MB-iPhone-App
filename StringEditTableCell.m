//
//  StringEditView.m
//  Edit cell for the EditDetailView
//
//  Created by Jens Lukas on 3/17/10.
//  Copyright 2010 itelligence Ag. All rights reserved.
//

#import "StringEditTableCell.h"


@implementation StringEditTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if(self == nil) {
		return nil;
	}
	
    CGRect bounds = [[self contentView] bounds];
    CGRect rect = CGRectInset(bounds, 20.0, 10.0);
    cellTextField = [[UITextField alloc] initWithFrame:rect];
	cellTextField.delegate = self;
	
	//  Set the keyboard's return key label to DONE.
    [cellTextField setReturnKeyType:UIReturnKeyDone];
    
    //  Make the clear button appear automatically.
    [cellTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [cellTextField setBackgroundColor:[UIColor whiteColor]];
    [cellTextField setOpaque:YES];
    
    [[self contentView] addSubview:cellTextField];

	return self;
}

/*
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return NO;
}
*/

- (void)dealloc {
	[cellTextField release];
    [super dealloc];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

-(NSString *)getText {
	return cellTextField.text;
}

-(void)setText:(NSString *)text {
	cellTextField.text = text;
}

-(void)setType:(NSString *)type {
	if([type isEqualToString:@"String"]) {
		cellTextField.keyboardType = UIKeyboardTypeDefault;
	} else if([type isEqualToString:@"Double"]) {
		cellTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	} else if([type isEqualToString:@"Integer"]) {
		cellTextField.keyboardType = UIKeyboardTypeNumberPad;
	}
}

@end
