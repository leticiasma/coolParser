
ASSN = parser
CLASS= dcc053
CLASSDIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))../..
AR= ar
ARCHIVE_NEW= -cr
RANLIB= ar -qs

SRC= cool.y cool-tree.handcode.h good.cl bad.cl README
CSRC= parser-phase.cc utilities.cc stringtab.cc dumptype.cc \
      tree.cc cool-tree.cc tokens-lex.cc  handle_flags.cc 
TSRC= myparser mycoolc coolc spim cool-tree.aps
CGEN= cool-parse.cc
HGEN= cool-parse.h
LIBS= lexer semant cgen
CFIL= ${CSRC} ${CGEN}
HFIL= cool-tree.h cool-tree.handcode.h 
LSRC= Makefile
OBJS= ${CFIL:.cc=.o}
OUTPUT= good.output bad.output


CPPINCLUDE= -I. -I${CLASSDIR}/include/${ASSN} -I${CLASSDIR}/src/${ASSN}

BFLAGS = -d -v -y -b cool --debug -p cool_yy

CC=g++
CFLAGS=-g -Wall -Wno-unused -DDEBUG ${CPPINCLUDE}
FLEX=flex ${FFLAGS}
BISON= bison ${BFLAGS}
DEPEND = ${CC} -MM ${CPPINCLUDE}

source: ${SRC} ${TSRC} ${LIBS} parser lsource

lsource: ${LSRC}

${OUTPUT}:	parser good.cl bad.cl
	@rm -f ${OUTPUT}
	./myparser good.cl >good.output 2>&1 
	-./myparser bad.cl >bad.output 2>&1 

parser: ${OBJS}
	${CC} ${CFLAGS} ${OBJS} ${LIB} -o parser

.cc.o:
	${CC} ${CFLAGS} -c $<

cool-parse.cc cool-parse.h: cool.y
	bison ${BFLAGS} cool.y
	mv -f cool.tab.c cool-parse.cc

dotest:	parser good.cl bad.cl
	@echo "\nRunning parser on good.cl\n"
	-./myparser good.cl 
	@echo "\nRunning parser on bad.cl\n"
	-./myparser bad.cl

${LIBS}:
	${CLASSDIR}/etc/link-object ${ASSN} $@

# These dependencies allow you to get the starting files for
# the assignment.  They will not overwrite a file you already have.

${SRC} :								
	-${CLASSDIR}/etc/copy-skel ${ASSN} ${SRC}

${LSRC} :
	-${CLASSDIR}/etc/link-shared ${ASSN} ${LSRC}

${TSRC} ${CSRC}:
	-ln -s ${CLASSDIR}/src/${ASSN}/$@ $@

${HSRC}:
	-ln -s ${CLASSDIR}/include/${ASSN}/$@ $@

submit-clean: ${OUTPUT}
	-rm -f *.s core ${OBJS} ${CGEN} ${HGEN} lexer *~ parser cgen semant

clean :
	-rm -f ${OUTPUT} *.s core ${OBJS} ${CGEN} ${HGEN} lexer parser cgen semant *~ *.a *.o 

clean-compile:
	@-rm -f core ${OBJS} ${CGEN} ${HGEN} ${LSRC}

%.d: %.cc ${LSRC}
	${SHELL} -ec '${DEPEND} $< | sed '\''s/\($*\.o\)[ :]*/\1 $@ : /g'\'' > $@'

-include ${CFIL:.cc=.d}
