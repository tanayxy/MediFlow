from fastapi import FastAPI, File, UploadFile, HTTPException
import speech_recognition as sr
import openai
from typing import Optional

app = FastAPI()


openai.api_key = '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'

@app.post("/process_audio")
async def process_audio(file: UploadFile = File(...), duration: Optional[int] = 5):
    try:
        # Perform speech recognition on the uploaded WAV file
        recognizer = sr.Recognizer()
        audio_data = sr.AudioFile(file.file)
        with audio_data as source:
            audio = recognizer.record(source, duration=duration)
        recognized_text = recognizer.recognize_google(audio)

        model_name = "gpt-3.5-turbo"
        temperature = 0.7
        max_tokens = 150
        prompt = f"Tell me only the medical details from the next paragraph (if there are no medical details in it, just say no medical details available and if available list those) and summarize it in brief 3 - 4 points,{recognized_text}"

        response = openai.ChatCompletion.create(
            model=model_name,
            messages=[{"role": "system", "content": prompt}],
            max_tokens=max_tokens,
            n=1,
            stop=None,
            temperature=temperature,
        )

        return {"summary": response.choices[0].message.content.strip()}
    except Exception as e:
        return {"error": str(e)}

