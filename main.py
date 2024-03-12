from fastapi import FastAPI, UploadFile, File
import speech_recognition as sr
import logging
import openai
import io
import wave
from fastapi import FastAPI, UploadFile, File, Depends
from scipy import signal
import soundfile as sf
import librosa
import numpy as np
from fastapi.middleware.cors import CORSMiddleware
from openai import OpenAI
client = OpenAI(
    api_key = "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")

app = FastAPI()


origins = ["http://localhost:8080", "http://127.0.0.1:5500"]  # Replace with your frontend URL(s)

app.add_middleware(
    CORSMiddleware,
    allow_origins="*",
    allow_credentials=True,
    allow_methods="*",
    allow_headers=["*"],
)

@app.post("/test")
async def process_audio(file: UploadFile = File(...)):
    try:
        # Read file data
        file_data = await file.read()
        with open("converted.mp3", "wb") as f:
            f.write(file_data)
        with open('converted.mp3', 'rb') as audio_file:
            transcription = client.audio.transcriptions.create(model="whisper-1", file=audio_file)
        print(transcription.text)
        prompt = f"Tell me only the medical details from the next paragraph (if there are no medical details in it, just say no medical details available and if available list those) and summarize it in brief 3 - 4 points,{transcription.text}"

        completion = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": prompt},
        ]
        )

    
        return {"summary": completion.choices[0].message.content}
    except Exception as e:
        logging.error("Error processing audio: %s", e)
        return {}
    
    
    

    