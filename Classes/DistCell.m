//  Created by Allamaprabhu on 22/11/10.
#import "DistCell.h"
@implementation DistCell
@synthesize _pos,b_state,status,dist;
-(id)init
{
	if(self=[super init])
	{
		_pos=[[pos alloc] init];
	}
	return self;
}

@end
