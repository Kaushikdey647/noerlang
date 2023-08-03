CC = gcc
CFLAGS = -Wall -Wextra -Werror -g
LDFLAGS = -lm

SRCS = main.c token_dict.c tokens.c trie.c
OBJS = $(SRCS:.c=.o)

all: main

main: $(OBJS)
    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.o: %.c
    $(CC) $(CFLAGS) -c -o $@ $<

clean:
    rm -f $(OBJS) main