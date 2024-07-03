# Use the Amazon Linux 2 base image provided by AWS Lambda
FROM public.ecr.aws/lambda/python:3.12

# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

# Copy the function code into the container
COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# Add the ARG directives to pass environment variables during build
ARG DETECTOR_ID
ARG SNS_TOPIC_ARN

# Set environment variables from the build arguments
ENV DETECTOR_ID=$DETECTOR_ID
ENV SNS_TOPIC_ARN=$SNS_TOPIC_ARN

# Specify the entry point for the Lambda function
CMD [ "lambda_function.handler" ]
