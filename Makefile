BIN_PATH  = /usr/local/bin
NAME = hubo

install: $(NAME)
	cp $(NAME) $(BIN_PATH)
	chmod +x $(BIN_PATH)/$(NAME)

uninstall | clean:
	rm -f $(BIN_PATH)/$(NAME)
