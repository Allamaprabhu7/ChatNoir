//  Created by Allamaprabhu on 22/11/10.

#import <Foundation/Foundation.h>
#import "DistCell.h"
@interface Construct_DFS : NSObject 
{
	DistCell *_Boundery,*_pivotCell;
	NSMutableArray *_DistMap,*_Queue,*_EmptyBoard;
	BOOL _bBounderyMap;
}
@property BOOL _bBounderyMap;
-(NSMutableArray *)biuldDFSfor:(int)x :(int)y forTheWorld:(NSMutableArray *)currWorld;
@end
