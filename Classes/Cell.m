//  Created by ;; on 19/11/10.
#import "Cell.h"
@implementation pos
@synthesize x,y;
-(id)init
{
	if(self=[super init])
	{
		
	}
	return self;
}
@end

@implementation Cell
@synthesize _pos,state;
-(id)init
{
	if(self=[super init])
	{
		_pos=[[pos alloc] init];
	}
	return self;
}
-(void)dealloc
{
	[super dealloc];
}
@end
