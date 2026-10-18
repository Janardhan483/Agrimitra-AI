#!/bin/bash
# ================================================================
# AgriMitra AI — One-Command Google Cloud Run Deployment Script
# ================================================================

echo "=========================================================="
echo " Deploying AgriMitra AI to Google Cloud Run (asia-south1) "
echo "=========================================================="

# Check if gcloud is authenticated
if ! command -v gcloud &> /dev/null; then
    echo "Error: gcloud CLI is not installed or not in PATH."
    echo "You can deploy directly using Google Cloud Shell (browser):"
    echo "👉 https://shell.cloud.google.com"
    exit 1
fi

PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
if [ -z "$PROJECT_ID" ]; then
    echo "Please set your Google Cloud Project first:"
    echo "gcloud config set project YOUR_PROJECT_ID"
    exit 1
fi

echo "Project ID: $PROJECT_ID"
echo "Region: asia-south1 (Mumbai, India)"

# Enable required Google Cloud APIs
echo "Enabling Cloud Run & Cloud Build APIs..."
gcloud services enable run.googleapis.com cloudbuild.googleapis.com

# Deploy directly from source to Cloud Run
echo "Building and deploying container to Cloud Run..."
gcloud run deploy agrimitra-ai \
    --source . \
    --region asia-south1 \
    --platform managed \
    --allow-unauthenticated \
    --port 8080 \
    --memory 512Mi \
    --cpu 1

echo "=========================================================="
echo " Deployment Complete! Check the Service URL above."
echo "=========================================================="
