FROM python:3.7.7-buster

# ADD https://get.aquasec.com/microscanner .
# RUN chmod +x microscanner &&\
#     ./microscanner NGJmZTc1YTA0YmZi

## Step 1:
WORKDIR /app/

## Step 2:
COPY core-app/ /app/

## Step 3:
# hadolint ignore=DL3013
RUN pip install --upgrade pip &&\
    pip install --trusted-host pypi.python.org -r requirements.txt
	
## Step 4:
Expose 80

## Step 5:
CMD ["python", "run.py"]
