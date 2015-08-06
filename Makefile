target		= LLVMSlicer

OBJS		= Callgraph.o Kleerer.o LLVM.o ModStats.o Modifies.o PointsTo.o FunctionStaticSlicer.o PostDominanceFrontier.o Prepare.o StaticSlicer.o dump-points-to.o field-sensitive-test.o
CC		= g++
CXXFLAGS	= -Wall -Wextra -std=c++11 -c
#LDFLAGS		= -L/home/justme0/Download/llvm-3.6.1.src

all		: $(target)

$(target)	: $(OBJS)
	$(CC) -o $@ $(OBJS)

Callgraph.o	: ./src/Callgraph/Callgraph.cpp
	$(CC) $(CXXFLAGS) ./src/Callgraph/Callgraph.cpp

Kleerer.o	: ./src/Kleerer.cpp
	$(CC) $(CXXFLAGS) ./src/Kleerer.cpp

LLVM.o		: ./src/Languages/LLVM.cpp
	$(CC) $(CXXFLAGS) ./src/Languages/LLVM.cpp

ModStats.o	: ./src/ModStats.cpp
	$(CC) $(CXXFLAGS) ./src/ModStats.cpp

Modifies.o	: ./src/Modifies/Modifies.cpp
	$(CC) $(CXXFLAGS) ./src/Modifies/Modifies.cpp

PointsTo.o	: ./src/PointsTo/PointsTo.cpp
	$(CC) $(CXXFLAGS) ./src//PointsTo/PointsTo.cpp

FunctionStaticSlicer.o	: ./src/Slicing/FunctionStaticSlicer.cpp
	$(CC) $(CXXFLAGS) ./src/Slicing/FunctionStaticSlicer.cpp

PostDominanceFrontier.o	: ./src/Slicing/PostDominanceFrontier.cpp
	$(CC) $(CXXFLAGS) ./src/Slicing/PostDominanceFrontier.cpp

Prepare.o	: ./src/Slicing/Prepare.cpp
	$(CC) $(CXXFLAGS) ./src/Slicing/Prepare.cpp

StaticSlicer.o	: ./src/Slicing/StaticSlicer.cpp
	$(CC) $(CXXFLAGS) ./src/Slicing/StaticSlicer.cpp

dump-points-to.o	: ./test/dump-points-to.cpp
	$(CC) $(CXXFLAGS) ./test/dump-points-to.cpp
