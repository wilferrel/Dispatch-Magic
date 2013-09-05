//
//  SNAViewController.m
//  Dispatcher Magic
//
//  Created by Justin Ison on 8/25/13.
//  Copyright (c) 2013 Justin Ison. All rights reserved.
//

#import "XYZViewController.h"
#import <AFNetworking/AFJSONRequestOperation.h>
#import <AFNetworking/AFNetworking.h>

#define XYZ_ENVIRONMENTS 0
#define XYZ_EVENTS 1
#define XYZ_LOCATIONS 2

@interface SNAViewController ()


@end


@implementation SNAViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.environments = @[@"trunk", @"release"];
    self.events = @[@"assign", @"on_site", @"meter_on", @"meter_off", @"provider_cancel", @"gps"];
    self.locations = @[@"DC", @"DCA", @"HQ", @"JFK", @"LA", @"LAX", @"LHR", @"LON", @"NYC", @"SF", @"SFO"];
    
    
    //CORRECT WAY TO DISMISS KEYBOARD
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(dismissKeyboard)];
    
    //recognizer.numberOfTapsRequired
    
    //.view is the actual view name the method will run on.
    [self.view addGestureRecognizer:recognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField ==  self.rideIDTextField) {
        [self.rideIDTextField resignFirstResponder];
    }
        return NO;
}

//THIS METHOD CLOSES KEYBOARD WHEN TOUCHED OUTSIDE OF TEXT FIELD
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.rideIDTextField resignFirstResponder];
//}


//Per Nic, this is the correct method to use to dismiss keyboard, see UITapGestureRecognizer above...
- (void)dismissKeyboard {
    [self.rideIDTextField resignFirstResponder];
}


- (IBAction)assignAction:(UIButton *)sender {
    NSLog(@"PRESSED THE SUBMIT BUTTON");
 
    //SET PICKER LOCATION VARIABLES
    int selectEnv = [self.picker selectedRowInComponent:0];
    int selectEvent = [self.picker selectedRowInComponent:1];
    int selectLocation = [self.picker selectedRowInComponent:2];
    
 
    //SET LAT AND LON FOR LOCATIONS IN PICKER
    if ([self.locations[selectLocation] isEqualToString: @"HQ"]) {
            self.latitude = @"38.79271";
            self.longitude = @"-77.06002";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"DC"]) {
            self.latitude = @"38.906";
            self.longitude = @"-77.036";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"DCA"]) {
        self.latitude = @"38.8496";
        self.longitude = @"-77.0425";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"JFK"]) {
        self.latitude = @"40.6461";
        self.longitude = @"-73.7821";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"LA"]) {
        self.latitude = @"34.105";
        self.longitude = @"-118.25";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"LAX"]) {
        self.latitude = @"33.9446";
        self.longitude = @"-118.4095";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"LHR"]) {
        self.latitude = @"51.4709";
        self.longitude = @"-0.452";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"LON"]) {
        self.latitude = @"51.527";
        self.longitude = @"-0.129";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"NYC"]) {
        self.latitude = @"40.70730";
        self.longitude = @"-74.01103";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"SF"]) {
        self.latitude = @"37.7799";
        self.longitude = @"-122.419";
    }
    else if ([self.locations[selectLocation] isEqualToString: @"SFO"]) {
        self.latitude = @"37.6218";
        self.longitude = @"-122.3810";
    }
    
    
    //RIDE EVENT POST
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.trunk.ridecharge.com/"]];
    httpClient.requestSerializer = [AFJSONSerializer serializer];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                       URLString:[NSString stringWithFormat:@"http://www.%@.ridecharge.com/services/fleet_events/ride_charge/fake/1/aaeeff11",
                                                                  self.environments[selectEnv]
                                                                  ]
                                                      parameters:@{@"event":self.events[selectEvent], @"latitude":self.latitude, @"longitude":self.longitude, @"ride_id":self.rideIDTextField.text, @"driver_id":@"1", @"vehicle_number":@"222", @"driver_phone_number":@"5555555555", @"driver_name":@"Mr. iOS"}
                                    ];
   
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSString *message = [NSString stringWithFormat:@"%@ event was successful for %@",
                             self.events[selectEvent], self.environments[selectEnv]
                             ];
        
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"SUCCESS" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        //call method with []
        [successAlert show];
        
        NSLog(@"%@", JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error %@", error);
    }];

    [operation start];
    
    
}


- (IBAction)rideIDTextField:(id)sender {
    NSLog(@"Typing in the text field!!!");

}


#pragma mark - UIPickerView Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == XYZ_ENVIRONMENTS)
        return self.environments.count;
    
    if (component == XYZ_EVENTS)
    return self.events.count;
    
    if (component == XYZ_LOCATIONS)
        return self.locations.count;
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == XYZ_ENVIRONMENTS)
    return [self.environments objectAtIndex:row];
    
    if (component == XYZ_EVENTS)
    return [self.events objectAtIndex:row];
    
    if (component == XYZ_LOCATIONS)
    return [self.locations objectAtIndex:row];
    
    return 0;
}



@end
