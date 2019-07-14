.PHONY: all clean test

clean:
	rm -rf coverage
	rm -rf dist
	rm -rf build
	rm -rf doc/_build
	rm -rf doc/auto_examples
	rm -rf doc/generated
	rm -rf doc/modules
	rm -rf examples/.ipynb_checkpoints

test-code:
	pytest clover

test-doc:
	pytest doc/*.rst

test-coverage:
	rm -rf coverage .coverage
	pytest --cov=clover clover

test: test-coverage test-doc

html:
	export SPHINXOPTS=-W; make -C doc html

code-analysis:
	flake8 clover --max-line-length=88 | grep -v __init__
	pylint -E clover/ -d E1103,E0611,E1101

upload:
	python setup.py sdist bdist_wheel
	twine upload dist/*