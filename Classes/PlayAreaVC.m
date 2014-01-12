//  Created by Allamaprabhu on 23/11/10.

#import "PlayAreaVC.h"


@implementation PlayAreaVC

-(id)init
{
	if(self=[super init])
	{
		
	}
	return self;
}
- (void)loadView 
{
//	self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
//	self.view.backgroundColor=[UIColor greenColor];
	
//	_PlayBoard=[[UIView alloc] initWithFrame:CGRectMake(128, 0, 768, 748)];
	_PlayBoard=[[UIView alloc] initWithFrame:CGRectMake(-128, 0, 768, 748)];
	_PlayBoard.backgroundColor=[UIColor redColor];
	self.view=_PlayBoard;
//	[self.view addSubview:_PlayBoard];
}
- (void)dealloc 
{
	if(_PlayBoard){[_PlayBoard removeFromSuperview];[_PlayBoard release];_PlayBoard=nil;}
    [super dealloc];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
