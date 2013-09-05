//
//  SNAViewController.h
//  Dispatcher Magic
//
//  Created by Justin Ison on 8/25/13.
//  Copyright (c) 2013 Justin Ison. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SNAViewController : UIViewController
<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) NSArray* environments;

@property (strong, nonatomic) NSArray* events;

@property (strong, nonatomic) NSArray* locations;

@property (strong, nonatomic) id latitude;
@property (strong, nonatomic) id longitude;

@property (strong, nonatomic) IBOutlet UITextField *rideIDTextField;


@end


