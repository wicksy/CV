#!/usr/bin/env python
#
# Clear down CV S3 bucket and upload fresh copy of site to S3
#

# Imports
#
import boto3
import mimetypes
import os
import re
import sys

# Functions
#

# Clean up and exit
#
def die(code):

  print("Cleaning up")
  print("Exit with code " + str(code))
  sys.exit(code)

# Make a directory
#
def ensure_dir(MKDIR):
  DIR = os.path.dirname(MKDIR)
  if not os.path.exists(DIR):
    os.makedirs(DIR)

# Test for debug switch
#
try:
  ARG = sys.argv[1]
except:
  ARG = ""

if ARG == '-d':
  DEBUG=True
else:
  DEBUG=False

# Get and set variables
#
AWS_ACCESS_KEY_ID = str(os.environ.get('AWS_ACCESS_KEY'))
AWS_SECRET_ACCESS_KEY = str(os.environ.get('AWS_SECRET_KEY'))
AWS_DEFAULT_REGION = str(os.environ.get('AWS_DEFAULT_REGION'))
CV_SOURCE_DIR = "../mkdocs/site"
CV_S3_BUCKET = "wicksy-cv"

# Exit codes
#
EXIT_ALL_OK = 0
EXIT_AWS_ACCESS_KEY_ID = 100
EXIT_AWS_SECRET_ACCESS_KEY = 110
EXIT_BAD_SOURCE_DIR = 120
EXIT_BOTO3_CLIENT = 130
EXIT_LIST_S3 = 140
EXIT_DELETE_S3 = 150
EXIT_UPLOAD_S3 = 160

# Check AWS keys are set
#
print("Checking AWS credentials")
if AWS_ACCESS_KEY_ID == "None" or not AWS_ACCESS_KEY_ID.strip():
  print("AWS_ACCESS_KEY not set or empty")
  die(EXIT_AWS_ACCESS_KEY_ID)
if AWS_SECRET_ACCESS_KEY == "None" or not AWS_SECRET_ACCESS_KEY.strip():
  print("AWS_SECRET_KEY not set or empty")
  die(EXIT_AWS_SECRET_ACCESS_KEY)

# Set default region if not set already
#
if AWS_DEFAULT_REGION != 'None' and AWS_DEFAULT_REGION.strip():
  pass
else:
  AWS_DEFAULT_REGION = "eu-west-1"
print("AWS default region: " + AWS_DEFAULT_REGION)

# Check to see if CV_SOURCE_DIR exists and exit if not
#
if not os.path.exists(CV_SOURCE_DIR):
  print("Error cannot find directory " + CV_SOURCE_DIR)
  die(EXIT_BAD_SOURCE_DIR)

# Try and start an S3 boto3 session
#
print("Starting boto3 session to S3 bucket " + CV_S3_BUCKET)
try:
  client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name=AWS_DEFAULT_REGION
  )
except:
  print("Error starting S3 boto3 session")
  die(EXIT_BOTO3_CLIENT)

if DEBUG:
  print("DEBUG: Response: " + str(client))

# Make sure I can list objects before doing anything else
#
print("Listing existing contents of bucket")
try:
  response = client.list_objects(
    Bucket=CV_S3_BUCKET
  )
except:
  print("Error listing objects in bucket")
  die(EXIT_LIST_S3)

if DEBUG:
  print("DEBUG: Response: " + str(response))

try:
  CONTENTS = response['Contents']
  print("Files found in bucket")
except:
  CONTENTS = False
  print("No files found in bucket")

# Delete all objects in the bucket
#
if CONTENTS:
  print("Deleting existing objects in bucket")
  for keys in CONTENTS:
    file = keys['Key']
    if DEBUG:
      print("DEBUG: Deleting: " + str(file))

    try:
      response = client.delete_objects(
        Bucket=CV_S3_BUCKET,
        Delete={
          'Objects': [
            {
              'Key': file
            }
          ]
        }
      )
    except:
      print("Error deleting object in bucket (" + file + ")")
      die(EXIT_DELETE_S3)

    if DEBUG:
      print("DEBUG: Response: " + str(response))

# Walk site directory to get files to upload. Get the MIME type
# of each as it's important for the upload. For example, index.html
# uploaded without it doesn't work at all
#
print("Uploading site content")
for root, directories, filenames in os.walk(CV_SOURCE_DIR):
  for file in filenames:
    filespec = os.path.join(root, file)
    relativepath = re.compile('^' + CV_SOURCE_DIR + '/').sub('',filespec)
    mime = mimetypes.guess_type(relativepath,strict=True)[0]
    if not mime:
      mime = "text/plain"
    if DEBUG:
      print("DEBUG: Uploading " + filespec + " (" + relativepath + ")")
      print("DEBUG: Mime Type of " + filespec + " (" + str(mime) + ")")

# Upload file to bucket and encrypt specifying MIME type (important)
#
    try:
      response = client.upload_file(
        filespec,
        CV_S3_BUCKET,
        relativepath,
        ExtraArgs={'ServerSideEncryption': "AES256", 'ContentType': mime}
      )
    except:
      print("Error uploading object to bucket (" + filespec + ")")
      die(EXIT_UPLOAD_S3)

    if DEBUG:
      print("DEBUG: Response: " + str(response))

print("Upload complete")

# Fin!
#
die(EXIT_ALL_OK)
