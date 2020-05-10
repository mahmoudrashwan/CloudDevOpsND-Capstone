## The Makefile includes instructions on environment setup and lint tests

setup:
	# Create python virtualenv
	python3 -m venv ~/.capstone

install:
	python3 -m pip install --upgrade pip &&\
	python3 -m pip install -r core-app/requirements.txt

test:
	#Currently, there is no tests available as it's just a demo.
lint:
	#lint Html
	tidy -q -e core-app/app/home/templates/index.html
	#lint Dockerfile
	hadolint --ignore=DL3013 Dockerfile
	# lint python files
	python3 -m pylint --disable=R,C,W1203 core-app/run.py

all: install lint test
