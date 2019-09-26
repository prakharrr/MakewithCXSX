#
# MAKEFILE STRAND
#

## COMPILER FLAGS ##
CXX = g++

## Source Files ##
OBJFILES = ConcatStrand.o NullStrand.o Strand.o StrandBody.o TextStrand.o SubStrand.o watcher.o

HFILES = $(OBJFILES:.o=.h) error.h

CPFILES = $(OBJFILES:.o=.cpp) strandtest1.cpp strandtest2.cpp strandtest3.cpp strandtest4.cpp

SRCFILES = $(HFILES) ${CPFILES}
DEP = $(OBJFILES:.o=.d)

.PRECIOUS: SRCFILES

## COMPILE TIME FLAGS ##
CMP = -c -g -Wall -Wextra -Wpedantic -std=c++14
LNK = -o
DBG = -ggdb
## RCS FLAGS ##
RCS_CHECKOUT = co -l
RCS_CHECKIN = ci -m

## PHONY TARGETS ##
.PHONY: all clean realclean checkin checkout
all: checkout strandtest1 strandtest2 strandtest3 strandtest4

## Checking out source files ##
checkout:
	${RCS_CHECKOUT} ${HFILES}

# Pull files ##
ConcatStrand.cpp:; if [ ! -s ConcatStrand.cpp ]; then $(RCS_CHECKOUT) ConcatStrand.cpp; fi 
NullStrand.cpp:;   if [ ! -s NullStrand.cpp   ]; then $(RCS_CHECKOUT) NullStrand.cpp;   fi
Strand.cpp:;       if [ ! -s Strand.cpp       ]; then $(RCS_CHECKOUT) Strand.cpp;       fi
StrandBody.cpp:;   if [ ! -s StrandBody.cpp   ]; then $(RCS_CHECKOUT) StrandBody.cpp;   fi
SubStrand.cpp:;    if [ ! -s SubStrand.cpp    ]; then $(RCS_CHECKOUT) SubStrand.cpp;    fi
TextStrand.cpp:;   if [ ! -s TextStrand.cpp   ]; then $(RCS_CHECKOUT) TextStrand.cpp;   fi
strandtest1.cpp:;  if [ ! -s strandtest1.cpp  ]; then $(RCS_CHECKOUT) strandtest1.cpp;  fi
strandtest2.cpp:;  if [ ! -s strandtest2.cpp  ]; then $(RCS_CHECKOUT) strandtest2.cpp;  fi
strandtest3.cpp:;  if [ ! -s strandtest3.cpp  ]; then $(RCS_CHECKOUT) strandtest3.cpp;  fi
strandtest4.cpp:;  if [ ! -s strandtest4.cpp  ]; then $(RCS_CHECKOUT) strandtest4.cpp;  fi
watcher.cpp:;      if [ ! -s watcher.cpp      ]; then $(RCS_CHECKOUT) watcher.cpp;      fi

## Create object files ##
Strand.o: Strand.h Strand.cpp StrandBody.h ConcatStrand.h SubStrand.h TextStrand.h NullStrand.h
	${CXX} ${CMP} ${DBG} Strand.cpp
strandtest1.o: strandtest1.cpp Strand.h
	${CXX} ${CMP} ${DBG} strandtest1.cpp
strandtest2.o: strandtest2.cpp Strand.h
	${CXX} ${CMP} ${DBG} strandtest2.cpp
strandtest3.o: strandtest3.cpp Strand.h
	${CXX} ${CMP} ${DBG} strandtest3.cpp
strandtest4.o: strandtest4.cpp Strand.h
	${CXX} ${CMP} ${DBG} strandtest4.cpp
ConcatStrand.o: ConcatStrand.cpp ConcatStrand.h StrandBody.cpp
	${CXX} ${CMP} ${DBG} ConcatStrand.cpp
NullStrand.o: NullStrand.cpp NullStrand.h
	${CXX} ${CMP} ${DBG} NullStrand.cpp
watcher.o: watcher.cpp watcher.h
	${CXX} ${CMP} ${DBG} watcher.cpp
StrandBody.o: StrandBody.cpp StrandBody.h SubStrand.h NullStrand.h ConcatStrand.h
	${CXX} ${CMP} ${DBG} StrandBody.cpp
SubStrand.o: SubStrand.h SubStrand.cpp StrandBody.h
	${CXX} ${CMP} ${DBG} SubStrand.cpp
TextStrand.o: TextStrand.h TextStrand.cpp 
	${CXX} ${CMP} ${DBG} TextStrand.cpp

## BUILD ##
strandtest1: strandtest1.o ${OBJFILES} 
	${RCS_CHECKOUT} strandtest1.cpp ${HFILES}
	${CXX} ${LNK} strandtest1 ${DBG} strandtest1.o ${OBJFILES} 
strandtest2: strandtest2.o ${OBJFILES} 
	${RCS_CHECKOUT} strandtest2.cpp ${HFILES}
	${CXX} ${LNK} strandtest2 ${DBG} strandtest2.o ${OBJFILES} 
strandtest3: strandtest3.o ${OBJFILES} 
	${RCS_CHECKOUT} strandtest3.cpp ${HFILES}
	${CXX} ${LNK} strandtest3 ${DBG} strandtest3.o ${OBJFILES} 
strandtest4: strandtest4.o ${OBJFILES} 
	${RCS_CHECKOUT} strandtest4.cpp ${HFILES}
	${CXX} ${LNK} strandtest4 ${DBG} strandtest4.o ${OBJFILES} 


checkin: all
	mkdir -p "StrandRCS"
	rcs -l *.cpp *.h
	$(RCS_CHECKIN) ${SRCFILES}

#Removes all build files and core file except executables
clean:
	rcs -l *.cpp *.h
	$(RM) core *.o *.cpp *.h
realclean: clean
	@echo "DELETING BY REAL CLEAN"
	$(RM) strandtest1 strandtest2 strandtest3 strandtest4 code.pdf


## Publish all cpp files to a pdf ##
code.pdf:
	enscript -Ecpp --color -p - *.h *.cpp | ps2pdf - code.pdf
