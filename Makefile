# Makefile for compiling bas.l and bas.y using flex, yacc, and gcc

SRC_DIR := src
BIN_DIR := bin
LEX_FILE := bas.l
YACC_FILE := bas.y
OUTPUT_BINARY := $(BIN_DIR)/bas
SAMPLE_DIR := sample_source
TEST_SAMPLE :=

.PHONY: all clean run

all: $(OUTPUT_BINARY)

$(OUTPUT_BINARY): $(SRC_DIR)/$(LEX_FILE) $(SRC_DIR)/$(YACC_FILE) | $(BIN_DIR)
	flex -o $(BIN_DIR)/lex.yy.c $(SRC_DIR)/$(LEX_FILE)
	yacc -o $(BIN_DIR)/y.tab.c -d $(SRC_DIR)/$(YACC_FILE)
	cp $(SRC_DIR)/ast.c $(BIN_DIR)
	cp $(SRC_DIR)/ast.h $(BIN_DIR)
	gcc -o $(OUTPUT_BINARY) $(BIN_DIR)/y.tab.c -ll

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

run-cli:
	./$(OUTPUT_BINARY)

run-file: $(OUTPUT_BINARY)
	./$(OUTPUT_BINARY) $(SAMPLE_DIR)/$(TEST_SAMPLE)

clean:
	rm -rf $(BIN_DIR)