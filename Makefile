export PATH := node_modules/.bin:$(PATH)

source_files := $(shell find src/ -type f -name '*.coffee')
build_files  := $(source_files:%.coffee=build/%.js)

app_bundle := build/app.js


.PHONY: all clean

all: $(app_bundle)

build/%.js: %.coffee
	mkdir -p $(dir $@)
	coffee -co $(dir $@) $<


$(app_bundle): $(build_files)
	browserify -o $@ $^

clean:
	rm -rf build
