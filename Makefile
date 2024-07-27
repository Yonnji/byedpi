TARGET = ciadpi
CC ?= gcc
CFLAGS += -std=c99 -O2 -D_XOPEN_SOURCE=500 
SOURCES = packets.c main.c conev.c proxy.c desync.c mpool.c extend.c
WIN_SOURCES = win_service.c

all:
	$(CC) $(CFLAGS) $(SOURCES) -I . -o $(TARGET)

windows:
	$(CC) $(CFLAGS) $(SOURCES) $(WIN_SOURCES) -I . -lws2_32 -lmswsock -o $(TARGET).exe

clean:
	rm -f $(TARGET) *.o

install:
	install -DZv ciadpi.service -t /etc/systemd/system
	install -DZv ciadpi -t /usr/local/bin
	systemctl daemon-reload

uninstall:
	systemctl disable --now ciadpi.service
	rm -fv /etc/systemd/system/ciadpi.service
	rm -fv /usr/local/bin/ciadpi
	systemctl daemon-reload
