.PHONY: all clean release force_release

all: test


test:
	pytest

clean:
	rm -rf build/ dist/

release: clean
	# Check if latest tag is the current head we're releasing
	echo "Latest tag = $$(git tag | sort -nr | head -n1)"
	echo "HEAD SHA       = $$(git sha head)"
	echo "Latest tag SHA = $$(git tag | sort -nr | head -n1 | xargs git sha)"
	@test "$$(git sha head)" = "$$(git tag | sort -nr | head -n1 | xargs git sha)"
	make force_release

force_release: clean
	git push --tags
	python setup.py sdist bdist_wheel
	twine upload dist/*
