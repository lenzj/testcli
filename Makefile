.POSIX:

PNAME = testcli

RTEMPLATE ?= ../repo-template

all: doc mkFile

doc: docMain

cleanDoc: cleanDocMain

.DEFAULT_GOAL := all

.PHONY: all doc cleanDoc

#---Test/Check Section---

TESTDIR = tests

check:
	cd $(TESTDIR) && go test -v

cleanCheck:
	find $(TESTDIR) -name '*.result' -delete

.PHONY: check cleanCheck

#---Generate Main Documents---

regenDocMain:
	pgot -i ":$(RTEMPLATE)" -o README.md template/README.md.got
	pgot -i ":$(RTEMPLATE)" -o LICENSE $(RTEMPLATE)/LICENSE.src/BSD-2-clause.got

.PHONY: regenDocMain

#---Generate Makefile---

Makefile: template/Makefile.got
	pgot -i ":$(RTEMPLATE)" -o $@ $<

regenMakefile:
	pgot -i ":$(RTEMPLATE)" -o Makefile template/Makefile.got

.PHONY: regenMakefile

#---Lint Helper Target---

lint:
	@find . -path ./.git -prune -or \
		-type f -and -not -name 'Makefile' \
		-exec grep -Hn '<no value>' '{}' ';'

#---TODO Helper Target---

todo:
	@find . -path ./.git -prune -or \
		-type f -and -not -name 'Makefile' \
		-exec grep -Hn TODO '{}' ';'

# vim:set noet tw=80:
