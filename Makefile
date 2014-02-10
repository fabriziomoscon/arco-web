export PATH := node_modules/.bin:$(PATH)

source_files := $(shell find src/ -type f -name '*.coffee')
app_bundle := public/script/app.js


.PHONY: all clean

all: $(app_bundle)

$(app_bundle):
	mkdir -p $(dir $@)
	watchify $(source_files) -o $@ -t coffeeify -v --extension=".coffee" &

clean:
	rm -rf $(app_bundle)
