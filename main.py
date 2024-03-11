from fastapi import FastAPI, File, UploadFile, HTTPException
import speech_recognition as sr
import openai

app = FastAPI()

openai.api_key = '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'

@app.post("/process_voice")
async def process_voice(file: UploadFile = File(...)):
    try:
        recognizer = sr.Recognizer()
        recognizer.energy_threshold = 3000
        recognizer.dynamic_energy_threshold = True
        recognizer.pause_threshold = 0.5

        with sr.AudioFile(file.file) as source:
            audio = recognizer.record(source)

        print("Recognizing...")
        text = recognizer.recognize_google(audio)

        model_name = "gpt-3.5-turbo" 
        temperature = 0.7  
        max_tokens = 150

        parah = text
        prompt = f"tell me only the medical details from the next paragraph (if there are no medical details in it, jus say no medical details available and if available list those) and summarize it in brief 3 - 4 points,{parah}"

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
        raise HTTPException(status_code=500, detail=str(e))
