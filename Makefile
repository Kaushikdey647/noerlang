# Define the source and object directories
SRCDIR := src
OBJDIR := obj

# Define the source and object files
LEXSRC := $(SRCDIR)/bas.l
YACCSRC := $(SRCDIR)/bas.y
YACCHDR := $(OBJDIR)/y.tab.h
BIN := bin

# Define the compiler and flags
CC := gcc
CFLAGS := -Wall -Wextra -Wpedantic

# Create the bin and object directories if they do not exist
$(shell mkdir -p $(OBJDIR))
$(shell mkdir -p $(BIN))

# Define the targets and dependencies
all: $(BIN)

$(BIN): $(YACCHDR)
	$(CC) $(CFLAGS) $(YACCSRC) -ll -o $@

$(YACCHDR): $(YACCSRC)
	yacc -v -d -o $(OBJDIR)/y.tab.c $<

.PHONY: clean

clean:
	rm -rf $(OBJDIR) $(BIN)