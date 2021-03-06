#####################################
# @author: Abdullah Emad 			#
# Makefile for The binary tree test #
#####################################

# compiler to use
CC = clang

# flags to pass compiler
CFLAGS = -ggdb3 -O0 -Qunused-arguments -std=c11 -Wall -Werror

# name for executable
EXE = bin/cranbtree

# space-separated list of header files
HDRS = include/cranbtree.h

# space-separated list of libraries, if any,
# each of which should be prefixed with -l
LIBS = -lcunit

# space-separated list of source files
SRCS = src/cranbtree.c


# Included folders
INCLUDES = include


# automatically generated list of object files
OBJS = $(SRCS:.c=.o)



###########################################
#   Compile object files into a library   #
###########################################

# default target make
default: compile createlib indexlib
	
# creates the object file
compile:
	$(CC) $(CFLAGS) -c $(SRCS) -I $(INCLUDES)

#creates the library
createlib: 
	ar rc libcranbtree.a cranbtree.o

#create index on the library
indexlib: 
	ranlib libcranbtree.a

# dependencies 
$(OBJS): $(HDRS) Makefile



###################################
# Install in the correct locations#
###################################
install: 
	mkdir -p /usr/local/include/cranberry && \
	cp $(HDRS) /usr/local/include/cranberry/cranbtree.h && \
	cp libcranbtree.a /usr/local/lib/libcranbtree.a

uninstall: 
	rm -f /usr/local/include/cranberry/cranbtree.h && \
	rm -f /usr/local/lib/libcranbtree.a && \
	rmdir --ignore-fail-on-non-empty /usr/local/include/cranberry

###############################
#		Test and cli		  #
#	   for developers		  #
###############################


#Creates binary for the test in /bin
test: mkbin
	$(CC) $(CFLAGS) test/test.c $(LIBS) -o bin/test -I $(INCLUDES)

#Creates binary for the cli in /bin
cli: mkbin
	$(CC) $(CFLAGS) $(SRCS) cli/cli.c  -o bin/cli -I $(INCLUDES)

#creates the bin directory if it does not exist
mkbin:
	mkdir -p bin

#Fix any code styling issue
beautiful: 
	indent -bad -bap -nbc -bbo -hnl -brs -c33 -cd33 -ncdb -ci4 -cli0 -d0 -bls -di1 -nfc1 -i8 -ip0 -l80 -lp -npcs -nprs -npsl -sai -saf -saw -ncs -nsc -sob -nfca -cp33 -ss -ts8 -il1 -bli0 src/*.c src/lib/* src/compacted/*.c include/*.h test/*.c && rm -rf include/*~* src/*~* src/lib/*~* src/compacted/*~* test/*~*

# housekeeping
clean:
	rm -f core *.o *.a bin/cli bin/test

.PHONY: test cli

