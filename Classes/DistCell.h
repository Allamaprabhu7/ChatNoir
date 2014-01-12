//  Created by Allamaprabhu on 22/11/10.
#import <Foundation/Foundation.h>
#import "Cell.h"
@interface DistCell : NSObject 
{
	pos *_pos;
	BOOL b_state;
	int status;
	int dist;
}
@property (nonatomic,assign) pos *_pos;
@property (nonatomic,assign) BOOL b_state;
@property (nonatomic,assign) int status;
@property (nonatomic,assign) int dist;
@end
