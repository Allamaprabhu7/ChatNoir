//  Created by Allamaprabhu on 19/11/10.
#import "DesignClass.h"
#import "Construct_DFS.h"
#import "Cell.h"
@interface  DesignClass()
-(void)createEmptyBoard;
-(void)displayBoard;
-(void)findNeighBours:(Cell *)cell;
-(void)printParticularCell:(Cell *)cell;
-(void)findTheShortesstPathWith_Boundery:(NSMutableArray *)b CatPosn:(NSMutableArray *)c Neighbours:(NSMutableArray *)n;
-(void)geerateRandomBlockedCells;
@end


@implementation DesignClass
enum states
{
 	UNBLOCKED= NO,
	BLOCKED =YES
};
-(id)init
{
	if(self=[super init])
	{
		_cellsList=[[NSMutableArray alloc] init];
		_neighbours=[[NSMutableArray alloc] init];
		srand(0);
	}
	return self;
}
-(void)dealloc
{
	[super dealloc];
}
-(void)startInitilising
{
	
	[self createEmptyBoard];
	[self geerateRandomBlockedCells];
//	[self displayBoard];
	
	Construct_DFS *forBoundery=[[Construct_DFS alloc] init];
	NSMutableArray *bounderyMap=[forBoundery biuldDFSfor:11 :11 forTheWorld:_cellsList];
	
	Construct_DFS *forCatPosn=[[Construct_DFS alloc] init];
	NSMutableArray *CatPosnMap=[forCatPosn biuldDFSfor:5 :5 forTheWorld:_cellsList];
	

	Cell *catPosn=[[Cell alloc] init];
	catPosn._pos.x=5;
	catPosn._pos.y=5;
//depending upon the touch event need to remove the objects from neighobours
	[self findNeighBours:catPosn];
}
-(void)createEmptyBoard
{
	Cell *_CellObj=[[Cell alloc] init];
	_CellObj._pos.x=10;
	for (int i=0; i<11; i++)
	{
		for (int j=0; j<11;j++) 
		{
			Cell *_CellObj=[[Cell alloc] init];
			_CellObj._pos.x=j;
			_CellObj._pos.y=i;
			_CellObj.state=UNBLOCKED;
			[_cellsList addObject:_CellObj];
		}
	}
}
-(void)displayBoard
{
	int i=0;
	for (Cell *cell in _cellsList)
	{
		if(i%11==0) printf("\n");
		printf("%5d(%d,%d)",i++,cell._pos.x,cell._pos.y);
		
	}
//	Cell *pCell=[[Cell alloc] init];
//	pCell._pos.x=4;
//	pCell._pos.y=8;
//	[self findNeighBours:pCell];
}
//Its to find the neighbours of passed cell
-(void)findNeighBours:(Cell *)cell
{
	printf("passed cell x:%d y:%d\n",cell._pos.x,cell._pos.y);
	//check for boundery
//	if(cell._pos.x==10 || cell._pos.y ==10 || cell._pos.x==0 || cell._pos.y==0)
	
	//if even row
	if(cell._pos.y%2==0)
	{
		//1>LeftTop
		if(cell._pos.y!=0 && cell._pos.x!=0) 
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y-1)*11+cell._pos.x-1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Right Top
		if(cell._pos.y!=0 )
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y-1)*11+cell._pos.x];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Left 
		if(cell._pos.x!=0)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y)*11+cell._pos.x-1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Right
		if(cell._pos.x!=10)
		{	
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y)*11+cell._pos.x+1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Left Below
		if(cell._pos.y!=10 && cell._pos.x!=0)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y+1)*11+cell._pos.x-1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Right Below
		if(cell._pos.y!=10)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y+1)*11+cell._pos.x];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
	}
	//if odd row
	else
	{
		//1>LeftTop
		Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y-1)*11+cell._pos.x];
		if(pCell.state==UNBLOCKED)
		{
			[_neighbours addObject:pCell];
			[self printParticularCell:pCell];
		}
		//Right Top
		if(cell._pos.y!=0 && cell._pos.x!=10)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y-1)*11+cell._pos.x+1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Left 
		if(cell._pos.x!=0)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y)*11+cell._pos.x-1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Right
		if(cell._pos.x!=10)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y)*11+cell._pos.x+1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
		//Left Below
		if(pCell.state==UNBLOCKED)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y+1)*11+cell._pos.x];
			[_neighbours addObject:pCell];
			[self printParticularCell:pCell];
		}
		//Right Below
		if(cell._pos.y!=10 && cell._pos.x!=10)
		{
			Cell *pCell=[_cellsList objectAtIndex:(cell._pos.y+1)*11+cell._pos.x+1];
			if(pCell.state==UNBLOCKED)
			{
				[_neighbours addObject:pCell];
				[self printParticularCell:pCell];
			}
		}
	}
}
-(void)printParticularCell:(Cell *)cell
{
	printf("cell no:%4d x:%2d y:%2d\n",11*cell._pos.y+cell._pos.x,cell._pos.x,cell._pos.y);
}
-(void)findTheShortesstPathWith_Boundery:(NSMutableArray *)b CatPosn:(NSMutableArray *)c Neighbours:(NSMutableArray *)n
{
//code to find shortest path comparing two arrays depending upon neghbours	
}
-(void)geerateRandomBlockedCells
{
	unsigned int rand;
	rand=arc4random()%14;
	while(rand<5)
		rand=arc4random()%14;
	printf("rand is:%d\n",rand);
	for(int j=0;j<rand;j++)
	{
		Cell *pCell=[_cellsList objectAtIndex:arc4random()%11*11+arc4random()%11];
		pCell.state=BLOCKED;
	}
}
@end
