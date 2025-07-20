import os
import docx2txt
import tempfile
import mimetypes
from fastapi import FastAPI, UploadFile, Form
from fastapi.responses import JSONResponse
from anthropic import Anthropic
from pdfminer.high_level import extract_text

# Initialize the FastAPI application
app = FastAPI()

# Function to extract text content from uploaded CV file based on its MIME type
def extract_cv_text(file_path, file_type):
    if file_type == "application/pdf":
        # Extract text from PDF
        return extract_text(file_path)
    elif file_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
        # Extract text from DOCX
        return docx2txt.process(file_path)
    else:
        # Unsupported file types raise an error
        raise ValueError("Unsupported file type")

# Create and return an instance of the Anthropic client using the API key from environment
def get_anthropic_client():
    return Anthropic(api_key=os.environ['ANTHROPIC_API_KEY'])

# Function to format and tailor the CV using Claude 3.5 API
def format_with_claude(cv_text, job_description):
    anthropic = get_anthropic_client()

    # Composite prompt to guide Claude through multiple optimization stages
    composite_prompt = f"""
You are a professional CV consultant and recruiter.

Your task is to analyze, optimize, and tailor this CV for the following job role. Apply the following process:

1. **Spot the Flaws**: Briefly assess and improve weak areas, generic phrases, and missing data (e.g., metrics or impact).
2. **Rewrite for Impact**: Make it results-driven, using clear outcomes and achievements.
3. **ATS Boost**: Ensure the CV is optimized for Applicant Tracking Systems for the target job, using natural industry keywords.
4. **Craft My Hook**: Start with a sharp 3-line summary that grabs attention.
5. **Upgrade Experience**: Focus on rewriting the experience section with action verbs and quantifiable achievements.
6. **Format Fix**: Present it in a clean, modern, one-column format (no graphics, no colors).
7. **Tailor for the Role**: Emphasize and rephrase relevant experiences and skills to align with the job description below.
8. **Standout Cover Letter**: Write a 150-200 word cover letter based on this CV and job description — friendly, professional, and enthusiastic.
9. **Benchmark Me**: As a hiring manager, give 2 bullet points on what would make this CV top 1% in the market.

---  
**Job Description**:
{job_description}

---  
**CV**:
{cv_text}
"""

    # Send the prompt to Claude's Messages API
    response = anthropic.messages.create(
        model="claude-3-5-haiku-20241022",  # Model ID
        max_tokens=3000,  # Set token limit for response
        messages=[
            {
                "role": "user",
                "content": composite_prompt.strip()
            }
        ]
    )

    # Return the formatted and tailored CV text
    return response.content[0].text

# FastAPI endpoint to handle CV tailoring requests
@app.post("/tailor")
async def tailor_cv(file: UploadFile, job_description: str = Form(...)):
    # Save uploaded file to a temporary file path
    with tempfile.NamedTemporaryFile(delete=False) as tmp:
        tmp.write(await file.read())
        tmp_path = tmp.name

    # Detect the MIME type of the uploaded file
    mime_type = file.content_type

    try:
        # Extract CV text and format using Claude
        cv_text = extract_cv_text(tmp_path, mime_type)
        tailored_cv = format_with_claude(cv_text, job_description)
        return JSONResponse(content={"tailored_cv": tailored_cv})
    except Exception as e:
        # Return error if processing fails
        return JSONResponse(status_code=500, content={"error": str(e)})
    finally:
        # Clean up temporary file
        os.unlink(tmp_path)
