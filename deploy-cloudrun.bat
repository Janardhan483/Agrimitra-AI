@echo off
REM ================================================================
REM AgriMitra AI — Windows One-Click Google Cloud Run Deployment
REM ================================================================

echo ==========================================================
echo  Deploying AgriMitra AI to Google Cloud Run (asia-south1)
echo ==========================================================

where gcloud >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Google Cloud SDK (gcloud) is not installed on this machine.
    echo.
    echo Easy alternative: Open Google Cloud Shell directly in your browser:
    echo 👉 https://shell.cloud.google.com
    echo.
    echo Then run:
    echo   git clone https://github.com/Janardhan483/Agrimitra-AI.git
    echo   cd Agrimitra-AI
    echo   gcloud run deploy agrimitra-ai --source . --region asia-south1 --allow-unauthenticated
    echo.
    pause
    exit /b 1
)

echo Enabling Cloud Run and Cloud Build APIs...
call gcloud services enable run.googleapis.com cloudbuild.googleapis.com

echo Building and deploying container to Google Cloud Run...
call gcloud run deploy agrimitra-ai --source . --region asia-south1 --platform managed --allow-unauthenticated --port 8080 --memory 512Mi --cpu 1

echo.
echo ==========================================================
echo  Deployment Finished! Look for the Service URL above.
echo ==========================================================
pause
