##############
# parameters #
##############
# do you want to see the commands executed ?
DO_MKDBG:=0
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1
# do you want to convert mermaid diagrams into png?
DO_MERMAID_PNG:=1
# do you want to convert mermaid diagrams into pdf?
DO_MERMAID_PDF:=1
# do you want to convert mermaid diagrams into svg?
DO_MERMAID_SVG:=1

########
# code #
########
ALL:=
OUT:=docs

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

MERMAID_SRC:=$(shell find mermaid -type f -and -name "*.mmd")
MERMAID_BAS:=$(basename $(MERMAID_SRC))
MERMAID_PNG:=$(addprefix $(OUT)/,$(addsuffix .png,$(MERMAID_BAS)))
MERMAID_PDF:=$(addprefix $(OUT)/,$(addsuffix .pdf,$(MERMAID_BAS)))
MERMAID_SVG:=$(addprefix $(OUT)/,$(addsuffix .svg,$(MERMAID_BAS)))

ifeq ($(DO_MERMAID_PNG),1)
ALL+=$(MERMAID_PNG)
endif # DO_MERMAID_PNG

ifeq ($(DO_MERMAID_PDF),1)
ALL+=$(MERMAID_PDF)
endif # DO_MERMAID_PDF

ifeq ($(DO_MERMAID_SVG),1)
ALL+=$(MERMAID_SVG)
endif # DO_MERMAID_SVG

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: debug
debug:
	$(info doing [$@])
	$(info MERMAID_SRC is $(MERMAID_SRC))
	$(info MERMAID_BAS is $(MERMAID_BAS))
	$(info MERMAID_PNG is $(MERMAID_PNG))
	$(info MERMAID_PDF is $(MERMAID_PDF))
	$(info MERMAID_SVG is $(MERMAID_SVG))

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd

############
# patterns #
############
$(MERMAID_PNG): $(OUT)/%.png: %.mmd .mmdc.config.json
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)pymakehelper only_print_on_error node_modules/.bin/mmdc -p .mmdc.config.json -i $< -o $@
$(MERMAID_PDF): $(OUT)/%.pdf: %.mmd .mmdc.config.json
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)pymakehelper only_print_on_error node_modules/.bin/mmdc -p .mmdc.config.json -i $< -o $@
$(MERMAID_SVG): $(OUT)/%.svg: %.mmd .mmdc.config.json
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)pymakehelper only_print_on_error node_modules/.bin/mmdc -p .mmdc.config.json -i $< -o $@

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
