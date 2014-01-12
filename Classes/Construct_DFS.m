//  Created by Allamaprabhu on 22/11/10.
#define READY 1
#define WAITING 2
#define PROCESSED 3
#define BOUNDERY 11
#import "Construct_DFS.h"
#import "Cell.h"
@interface Construct_DFS()
-(void)createEmptyDistMap:(NSMutableArray *)currWorld;
-(void)buildMap;
-(NSMutableArray *)getNeighbours:(DistCell *)topElement;
-(void)printDistanceMap;
@end

@implementation Construct_DFS
enum states
{
 	UNBLOCKED= NO,
	BLOCKED =YES
};
@synthesize _bBounderyMap;
-(id)init
{
	if(self=[super init])
	{
		_DistMap=[[NSMutableArray alloc] init];
		_Queue=[[NSMutableArray alloc] init];
		_EmptyBoard=[[NSMutableArray alloc] initWithCapacity:122];
		
		_Boundery=[[DistCell alloc] init];
		_Boundery.dist=(int)INFINITY;
		_Boundery._pos.x=BOUNDERY;
		_Boundery._pos.y=BOUNDERY;
		_Boundery.status=READY;
	}
	return self;
}
-(void)dealloc
{
	if(_DistMap){[_DistMap removeAllObjects];[_DistMap release];_DistMap=nil; }
  	if(_Queue){[_Queue removeAllObjects];[_Queue release];_Queue=nil; }
  	if(_EmptyBoard){[_EmptyBoard removeAllObjects];[_EmptyBoard release];_EmptyBoard=nil; }				
	[super dealloc];
}
-(NSMutableArray *)biuldDFSfor:(int)x :(int)y forTheWorld:(NSMutableArray *)currWorld
{
	printf("Build DFS\n");
	[self createEmptyDistMap:currWorld];
	//dfs for boundery
	if(x==11 && y==11)
	{
		_pivotCell=[_EmptyBoard lastObject];
		_bBounderyMap=YES;
	}
	//dfs for current position of cat
	else 
	{
		_pivotCell=[_EmptyBoard objectAtIndex:x*11+y];
		_bBounderyMap=NO;
	}
	_pivotCell.status=WAITING;
	_pivotCell.dist=0;
	[self buildMap];

	return _EmptyBoard;
}
//create EmptyDistMap and initilize it
-(void)createEmptyDistMap:(NSMutableArray *)currWorld
{
	for (int i=0; i<11; i++)
	{
		for (int j=0; j<11;j++) 
		{
			Cell *currWorldCell=[currWorld objectAtIndex:11*i+j];
				DistCell *pDistCell=[[DistCell alloc] init];
				pDistCell._pos.x=j;
				pDistCell._pos.y=i;
				pDistCell.b_state=currWorldCell.state;
				pDistCell.status=READY;
				pDistCell.dist=(int)INFINITY;
				[_EmptyBoard addObject:pDistCell];
		}
	}
	[_EmptyBoard addObject:_Boundery];
}
-(void)buildMap
{
	
//put the pivot node into queue
	[_Queue addObject:_pivotCell];
	
	while ([_Queue count])
	{
		//add the top element of queue into dist map
		DistCell *topElement=[_Queue objectAtIndex:0];
		//change the state to processed
		topElement.status=PROCESSED;

		[_DistMap addObject:topElement];
		
		//find the neighbours of top elemen and add it to queue
		
		NSMutableArray *neighbours=[self getNeighbours:(DistCell *)topElement];
		if(neighbours)
		[_Queue addObjectsFromArray:neighbours];
		neighbours=nil;
		//Remove 
//		printf("object to be Removed is for next time: x: %d  y:%d \n",topElement._pos.x,topElement._pos.y);
		[_Queue removeObjectAtIndex:0];
		topElement=nil;
	}
	[self printDistanceMap];
}
-(NSMutableArray *)getNeighbours:(DistCell *)pCell
{
//	printf("\npassed :%d ( %d ,%d )status is %d\n",cell._pos.y*11+cell._pos.x,cell._pos.x,cell._pos.y,cell.status);
	NSMutableArray *nArary=[[NSMutableArray alloc] init];
	int nextdistance=pCell.dist+1;
	//	check for boundery
	if(pCell._pos.x==BOUNDERY)
	{ 
		if(_bBounderyMap==NO)
			return nil;
		else
		{
			int l=0;
			int m=10;
			for (int i=0;i<11; i++)
			{
				DistCell *cell;
				cell=[_EmptyBoard objectAtIndex:i*11+l];
				if(cell.status==READY && cell.b_state==UNBLOCKED)
				{
					cell.status=WAITING;
					cell.dist=nextdistance;
					[nArary addObject:cell];
					cell=nil;
				}
				
				cell=[_EmptyBoard objectAtIndex:i*11+m];			
				if(cell.status==READY && cell.b_state==UNBLOCKED)
				{
					cell.status=WAITING;
					cell.dist=nextdistance;
					[nArary addObject:cell];
					cell=nil;
				}
				if(i>0 && i<10)
				{
					cell=[_EmptyBoard objectAtIndex:l*11+i];			
					if(cell.status==READY && cell.b_state==UNBLOCKED)
					{
						cell.status=WAITING;
						cell.dist=nextdistance;
						[nArary addObject:cell];
						cell=nil;
					}
					cell=[_EmptyBoard objectAtIndex:m*11+i];			
					if(cell.status==READY && cell.b_state==UNBLOCKED)
					{
						cell.status=WAITING;
						cell.dist=nextdistance;
						[nArary addObject:cell];
						cell=nil;
					}
				}
			}
			return nArary;
	   }
	}
//not a boundery	
	else
	{
//		int nextdistance=cell.dist+1;
		if(pCell._pos.x==10 || pCell._pos.y ==10 || pCell._pos.x==0 || pCell._pos.y==0 )
		{
			if(pCell.status==READY && pCell.b_state==UNBLOCKED)
			{
				_Boundery.status=WAITING;
				_Boundery.dist=nextdistance;
				[nArary addObject:_Boundery];
			}
		}
		int index;
		DistCell *tmpCell;
		//if even row
	   if(pCell._pos.y%2==0)
		{
			//1>LeftTop
			if(pCell._pos.y!=0 && pCell._pos.x!=0) 
			{
				index=(pCell._pos.y-1)*11+pCell._pos.x-1;
				tmpCell=[_EmptyBoard objectAtIndex:index];
				if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
				{
					tmpCell.status=WAITING;
					tmpCell.dist=nextdistance;
					[nArary addObject:tmpCell];
				}
				tmpCell=nil;
			}
			//Right Top
			if(pCell._pos.y!=0 )
			{
				index=(pCell._pos.y-1)*11+pCell._pos.x;
				tmpCell=[_EmptyBoard objectAtIndex:index];
				if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
				{
					tmpCell.status=WAITING;
					tmpCell.dist=nextdistance;
					[nArary addObject:tmpCell];
				}
				tmpCell=nil;
			}
			//Left 
			if(pCell._pos.x!=0)
			{
			
				index=(pCell._pos.y)*11+pCell._pos.x-1;
				tmpCell=[_EmptyBoard objectAtIndex:index];
				if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
				{
					tmpCell.status=WAITING;
					tmpCell.dist=nextdistance;
					[nArary addObject:tmpCell];
				}
				tmpCell=nil;
			}
			//Right
			if(pCell._pos.x!=10)
			{
				index=(pCell._pos.y)*11+pCell._pos.x+1;
				tmpCell=[_EmptyBoard objectAtIndex:index];
				if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
				{
					tmpCell.status=WAITING;
					tmpCell.dist=nextdistance;
					[nArary addObject:tmpCell];
				}
				tmpCell=nil;
			}
			//Left Below
			if(pCell._pos.y!=10 && pCell._pos.x!=0)
			{
				index=(pCell._pos.y+1)*11+pCell._pos.x-1;
				tmpCell=[_EmptyBoard objectAtIndex:index];
				if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
				{
					tmpCell.status=WAITING;
					tmpCell.dist=nextdistance;
					[nArary addObject:tmpCell];
				}
				tmpCell=nil;
				
			}
			//Right Below
			if(pCell._pos.y!=10)
			{
				index=(pCell._pos.y+1)*11+pCell._pos.x;
				tmpCell=[_EmptyBoard objectAtIndex:index];
				if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
				{
					tmpCell.status=WAITING;
					tmpCell.dist=nextdistance;
					[nArary addObject:tmpCell];
				}
				tmpCell=nil;
			}
		}
		//if odd row
	  else
	  {
		  //1>LeftTop
			  
		  index=(pCell._pos.y-1)*11+pCell._pos.x;
		  tmpCell=[_EmptyBoard objectAtIndex:index];
		  if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
		  {
			  tmpCell.status=WAITING;
			  tmpCell.dist=nextdistance;
			  [nArary addObject:tmpCell];
		  }
		  tmpCell=nil;
		  
		  //Right Top
		  if(pCell._pos.y!=0 && pCell._pos.x!=10)
		  {
			  index=(pCell._pos.y-1)*11+pCell._pos.x+1;
			  tmpCell=[_EmptyBoard objectAtIndex:index];
			  if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
			  {
				  tmpCell.status=WAITING;
				  tmpCell.dist=nextdistance;
				  [nArary addObject:tmpCell];
			  }
			  tmpCell=nil;
		  }
		  //Left 
		  if(pCell._pos.x!=0)
		  {
			  index=(pCell._pos.y)*11+pCell._pos.x-1;
			  tmpCell=[_EmptyBoard objectAtIndex:index];
			  if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
			  {
				  tmpCell.status=WAITING;
				  tmpCell.dist=nextdistance;
				  [nArary addObject:tmpCell];
			  }
			  tmpCell=nil;
		  }
		  //Right
		  if(pCell._pos.x!=10)
		  {
			  index=(pCell._pos.y)*11+pCell._pos.x+1;
			  tmpCell=[_EmptyBoard objectAtIndex:index];
			  if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
			  {
				  tmpCell.status=WAITING;
				  tmpCell.dist=nextdistance;
				  [nArary addObject:tmpCell];
			  }
			  tmpCell=nil;
		  }
		  //Left Below
		  index=(pCell._pos.y+1)*11+pCell._pos.x;
		  tmpCell=[_EmptyBoard objectAtIndex:index];
		  if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
		  {
			  tmpCell.status=WAITING;
			  tmpCell.dist=nextdistance;
			  [nArary addObject:tmpCell];
		  }
		  tmpCell=nil;
		  //Right Below
		  if(pCell._pos.y!=10 && pCell._pos.x!=10)
		  {
			  index=(pCell._pos.y+1)*11+pCell._pos.x+1;
			  tmpCell=[_EmptyBoard objectAtIndex:index];
			  if(tmpCell.status==READY && tmpCell.b_state==UNBLOCKED)
			  {
				  tmpCell.status=WAITING;
				  tmpCell.dist=nextdistance;
				  [nArary addObject:tmpCell];
			  }
			  tmpCell=nil;
		  }
	  }
	 return [nArary autorelease];
	}
}
-(void)printDistanceMap
{
//	printf("#######################################\n");
//	for(DistCell *pDCell in _EmptyBoard) 
//		printf("no :%d (%d,%d) %d distance:%d\n",pDCell._pos.y*11+pDCell._pos.x,pDCell._pos.x,pDCell._pos.y,pDCell.status,pDCell.dist);
	printf("########################################\n");
	for(DistCell *pDCell in _DistMap)
		printf("no :%d (%d,%d) %d distance:%d\n",pDCell._pos.y*11+pDCell._pos.x,pDCell._pos.x,pDCell._pos.y,pDCell.status,pDCell.dist);
}
@end
