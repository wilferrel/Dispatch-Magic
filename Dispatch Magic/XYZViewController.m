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

@interface SNAViewController ()


@end


@implementation SNAViewController

//@synthesize envPicker;
//@synthesize environments;
//@synthesize rideIDTextField;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Load the NSArray Object
   
    self.environments = @[@"trunk", @"release"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField ==  self.rideIDTextField) {
        [self.rideIDTextField resignFirstResponder];
    }
        return NO;
}

- (IBAction)assignAction:(UIButton *)sender {
    NSLog(@"I PRESSED THE Assign BUTTON");
 
    
//    // GET EXAMPLE
//    NSString *urlAsString = @"http://api.openweathermap.org/data/2.5/weather?id=2172797";
//    NSURL *url = [NSURL URLWithString:urlAsString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation
//        JSONRequestOperationWithRequest:request success:^(NSURLRequest *request,
//        NSHTTPURLResponse *response, id JSON)
//    {
//        //success
//        NSArray *info = [JSON valueForKeyPath:@"weather.description"];
//        NSLog(@"data output: %@", info);
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
//    {
//        //error
//        NSLog(@"Error contacting server: %@", [error localizedDescription]);
//    }];
// [operation start];
    

    
    int selectEnv = [self.envPicker selectedRowInComponent:0];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.trunk.ridecharge.com/"]];
    httpClient.requestSerializer = [AFJSONSerializer serializer];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                       URLString:[NSString stringWithFormat:@"http://www.%@.ridecharge.com/services/fleet_events/ride_charge/fake/1/aaeeff11",
                                                                  self.environments[selectEnv]
                                                                  ]
                                                        parameters:@{@"event":@"assign", @"latitude":@"38.8525", @"longitude":@"-77.038", @"ride_id":self.rideIDTextField.text, @"driver_id":@"1", @"vehicle_number":@"222", @"driver_phone_number":@"5555555555", @"driver_name":@"Mr. iOS"}];
   
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"App.net Global Stream: %@", JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error %@", error);
    }];

    [operation start];
    
    
}

- (IBAction)reDispatchAction:(id)sender {
    NSLog(@"I PRESSED THE Re-Dispatch BUTTON");
}

- (IBAction)onSiteAction:(id)sender {
    NSLog(@"I PRESSED THE On Site BUTTON");
}

- (IBAction)meterOnAction:(id)sender {
    NSLog(@"I PRESSED THE Meter On BUTTON");
}

- (IBAction)meterOffAction:(id)sender {
    NSLog(@"I PRESSED THE Meter Off BUTTON");
}

- (IBAction)providerCancelAction:(id)sender {
    NSLog(@"I PRESSED THE Meter Provider Cancel BUTTON");
}

- (IBAction)rideIDTextField:(id)sender {
    NSLog(@"Typing in the text field!!!");

}


#pragma mark - UIPickerView Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.environments.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.environments objectAtIndex:row];
}



@end
