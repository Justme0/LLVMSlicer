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
#CXXFLAGS	= -DPS_DEBUG -DDEBUG_DUMP -DDEBUG_SLICING -DDEBUG_SLICE -fPIC -g -Wall -Wextra -std=c++14 `llvm-config --cxxflags`
CXXFLAGS	= -fPIC -g -Wall -Wextra -std=c++14 `llvm-config --cxxflags`

.PHONY		: all clean depend

all		: depend $(TARGET)

$(TARGET)	: $(OBJS)
	$(CC) $(OBJS) -shared -g -o $@

depend		: .depend

.depend		: $(SRCS)
	rm -f $@
	$(CC) $(CXXFLAGS) -c -MM $^ > $@

# http://stackoverflow.com/questions/3714041/why-does-this-makefile-execute-a-target-on-make-clean
# http://stackoverflow.com/questions/28895439/the-function-of-the-ifneq-makecmdgoals-clean-part-in-the-makefile
ifneq ($(MAKECMDGOALS),clean)
-include .depend
endif

%.o		:
	$(CC) $(CXXFLAGS) -c $< -o $@

clean		:
	rm -f $(TARGET) *.o .depend
