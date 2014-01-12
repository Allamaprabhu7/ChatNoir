//  Created by Allamaprabhu on 19/11/10.

#import <Foundation/Foundation.h>
@interface pos :NSObject
{
	int x;
	int y;
}
@property int x;
@property int y;
@end
@interface Cell : NSObject 
{
	pos *_pos;
	BOOL b_state;
}
@property (nonatomic,assign) pos *_pos;
@property (nonatomic,assign) BOOL state;
@end
