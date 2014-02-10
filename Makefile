export PATH := node_modules/.bin:$(PATH)

source_files := $(shell find src/ -type f -name '*.coffee')
build_files  := $(source_files:%.coffee=.build/%.js)

app_bundle := public/script/app.js


.PHONY: all clean

all: $(app_bundle)

.build/%.js: %.coffee
	mkdir -p $(dir $@)
	coffee -co $(dir $@) $<


$(app_bundle): $(build_files)
	mkdir -p $(dir $@)
	browserify -o $@ $^

clean:
	rm -rf .build
