all: nosync.so
ascii: nosync.txt nosync.gz.txt

nosync.so: nosync.c
	$(CC) -fPIC -shared -Wall -Wextra -Os $< -o $@
	chmod +x $@

TOHEX := od -v -w1 -tx1 | sed 's/^[0-9]\+ \?//;/^$$/d;s/^/\\x/g' | tr -d '\n'

# suitable for bash: printf "$(cat nosync.txt)" > nosync.so
nosync.txt: nosync.so
	strip -s $<
	cat $< | $(TOHEX) > $@

# suitable for: printf "$(cat nosync.gz.txt)" | gzip -d > nosync.so
nosync.gz.txt: nosync.so
	strip -s $<
	gzip -9 < $< | $(TOHEX) > $@

.PHONY: clean
clean:
	rm -f nosync.so nosync.txt nosync.gz.txt
