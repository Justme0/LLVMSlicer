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
CXXFLAGS	= -g -Wall -Wextra -std=c++14 `llvm-config --cxxflags`
#CXXFLAGS	= -g -Wall -Wextra -std=c++14 `llvm-config --cxxflags` -DPS_DEBUG -DDEBUG_DUMP -DDEBUG_SLICING -DDEBUG_SLICE

.PHONY		: all clean

all		: .depend $(TARGET)

.depend		: $(SRCS)
	rm -f $@
	$(CC) $(CXXFLAGS) -c -MM $^ > $@

$(TARGET)	: $(OBJS)
	$(CC) $(OBJS) -shared -g -o $@

ifneq ($(MAKECMDGOALS),clean)
  -include .depend
endif

%.o		:
	$(CC) $(CXXFLAGS) -c $< -o $@

clean		:
	rm -f $(TARGET) *.o .depend
