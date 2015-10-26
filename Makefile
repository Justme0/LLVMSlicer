# OPTIMIZE: pattern match
SRCS		= ./src/Callgraph/Callgraph.cpp \
		  ./src/Kleerer.cpp \
		  ./src/Languages/LLVM.cpp \
		  ./src/ModStats.cpp \
		  ./src/Modifies/Modifies.cpp \
		  ./src/PointsTo/PointsTo.cpp \
		  ./src/Slicing/FunctionStaticSlicer.cpp \
		  ./src/Slicing/PostDominanceFrontier.cpp \
		  ./src/Slicing/Prepare.cpp \
		  ./src/Slicing/StaticSlicer.cpp

TARGET		= llvm-slicer.so

OBJS		= Callgraph.o \
		  Kleerer.o \
		  LLVM.o \
		  ModStats.o \
		  Modifies.o \
		  PointsTo.o \
		  Prepare.o \
		  PostDominanceFrontier.o \
		  FunctionStaticSlicer.o \
		  StaticSlicer.o

CC		= g++
CXXFLAGS	= -DDEBUG_DUMP -DDEBUG_SLICING -DDEBUG_SLICE -fPIC -g -Wall -Wextra -std=c++11 `llvm-config --cxxflags`

.PHONY		: all clean depend

all		: depend $(TARGET)

$(TARGET)	: $(OBJS)
	$(CC) $(OBJS) -shared -g -o $@

depend		: .depend

.depend		: $(SRCS)
	rm -f ./.depend
	$(CC) $(CXXFLAGS) -c -MM $^ > ./.depend;

%.o		:
	$(CC) $(CXXFLAGS) -c $< -o $@

include .depend

clean		:
	rm -f $(TARGET) *.o .depend
