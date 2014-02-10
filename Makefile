export PATH := node_modules/.bin:$(PATH)

source_files := $(shell find src/ -type f -name '*.coffee')
build_files  := $(source_files:%.coffee=.build/%.js)

app_bundle := public/script/app.js


.PHONY: all clean coffee-compile

all: $(app_bundle)

.build/%.js: %.coffee
	mkdir -p $(dir $@)
	coffee -co $(dir $@) $<

$(app_bundle): $(build_files)
	mkdir -p $(dir $@)
	browserify -o $@ $^

coffee-compile:
	coffee $(filename) -co $(filename:%.coffee=.build/%.js)
	browserify -o $(app_bundle) $(build_files)

clean:
	rm -rf .build/$(filename) $(app_bundle)
