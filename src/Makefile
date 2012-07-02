.PHONY: html js img css

OUT = ../public

JADE = index.jade
JADE_DEPS = projects/*.jade  about.jade
JADE_OUT = $(addprefix $(OUT)/, $(JADE:.jade=.html))

COFFEE = $(shell find script -name *.coffee)
COFFEE_OUT = $(addprefix $(OUT)/, $(COFFEE:.coffee=.js))

JS = $(shell find . -name *.js)
JS_OUT = $(addprefix $(OUT)/, $(JS))

IMG = $(shell find . -name *.jpg) $(shell find . -name *.png)
IMG_OUT = $(addprefix $(OUT)/, $(IMG))

CSS = $(shell find style -type f)
CSS_OUT = $(addprefix $(OUT)/, $(CSS))

all: html js img css

clean:
	rm -rf ../public/*

html: $(JADE_OUT)

$(JADE_OUT): $(JADE) $(JADE_DEPS)
	jade < $< --path $< > $@

js: $(COFFEE_OUT) $(JS_OUT)

$(COFFEE_OUT): $(COFFEE)
	coffee -c -o $(dir $(@)) $<

$(JS_OUT): $(JS)
	@mkdir -p $(dir $(@))
	cp $< $@

img: $(IMG_OUT)

$(IMG_OUT): $(IMG)
	@mkdir -p $(dir $(@))
	cp $< $@

css: $(CSS_OUT)

$(CSS_OUT): $(CSS)
	@mkdir -p $(dir $(@))
	cp $< $@


#$(OUT)/%.html: %.jade $(JADE_DEPS)
#  jade < $< --path $< > $@

#$(OUT)/%.js: %.coffee
#  coffee -c -o $@ $<

#$(OUT)/%.js: %.js
#  cp -r $< $@
