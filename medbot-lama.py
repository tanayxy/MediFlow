# import requests

# API_URL = "https://api-inference.huggingface.co/models/SrikanthChellappa/mistral-7b-sharded-finetuning-medical100k-chatbot"
# headers = {"Authorization": "Bearer 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"}

# def query(payload):
# 	response = requests.post(API_URL, headers=headers, json=payload)
# 	return response.json()
	
# output = query({
# 	"inputs": "Can you please let us know more details about your ",
# })

# print(output)

# import torch
# from transformers import Speech2TextForConditionalGeneration, Speech2TextProcessor
# from datasets import load_dataset

# # Load pre-trained model and processor
# model = Speech2TextForConditionalGeneration.from_pretrained("facebook/s2t-small-librispeech-asr")
# processor = Speech2TextProcessor.from_pretrained("facebook/s2t-small-librispeech-asr")

# Load validation dataset
# ds = load_dataset("hf-internal-testing/librispeech_asr_demo", "clean", split="validation")

# # Process input audio
# inputs = processor(ds[0]["audio"]["array"], sampling_rate=ds[0]["audio"]["sampling_rate"], return_tensors="pt")

# # Generate transcription
# generated_ids = model.generate(inputs["input_features"], attention_mask=inputs["attention_mask"])

# # Decode generated transcription
# transcription = processor.batch_decode(generated_ids, skip_special_tokens=True)
# print(transcription)

# import speech_recognition as sr

# recognizer = sr.Recognizer()
# recognizer.energy_threshold = 3000  
# recognizer.dynamic_energy_threshold = True  
# recognizer.pause_threshold = 0.9  

# with sr.Microphone() as source:
#     print("Speak something...")
#     audio = recognizer.listen(source)
# try:
#     print("Recognizing...")
#     text = recognizer.recognize_google(audio)
#     print("You said:", text)
# except sr.UnknownValueError:
#     print("Sorry, could not understand audio.")
# except sr.RequestError as e:
#     print("Could not request results from Google Speech Recognition service; {0}".format(e))








import openai
import speech_recognition as sr

recognizer = sr.Recognizer()
recognizer.energy_threshold = 3000  
recognizer.dynamic_energy_threshold = True  
recognizer.pause_threshold = 0.5  
    
with sr.Microphone() as source:
    print("Speak something...")
    audio = recognizer.listen(source)
try:
    print("Recognizing...")
    text = recognizer.recognize_google(audio)
except sr.UnknownValueError:
    print("Sorry, could not understand audio.")
except sr.RequestError as e:
    print("Could not request results from Google Speech Recognition service; {0}".format(e))



openai.api_key = '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'


model_name = "gpt-3.5-turbo" 

# parah = '''
# You could leave life right now. In the treatment of schizophrenia, a prescription typically includes antipsychotic medications such as aripiprazole, haloperidol, or risperidone. Starting with the lowest effective dose, the dosage is adjusted based on individual response and side effects, with regular monitoring to ensure efficacy and manage any adverse reactions. You could leave life right now. Let that determine what you do and say and think.Long-term medication is often necessary to stabilize symptoms, and patients are advised to follow their psychiatrist's guidance on treatment duration. Common side effects like drowsiness and weight gain should be monitored, along with metabolic changes such as blood sugar and cholesterol levels. Think of the life you have lived until now as over and, as a dead man, see what’s left as a bonus and live it according to Nature. Love the hand that fate deals you and play it as your own, for what could be more fitting?Combining medication with psychotherapy, social skills training, and vocational rehabilitation can enhance treatment outcomes. Regular follow-up appointments with the treatment team are essential for ongoing monitoring and addressing any concerns promptly to optimize care for individuals with schizophrenia. External things are not the problem. It’s your assessment of them. Which you can erase right now.'''
parah = text
prompt = f"tell me only the medical details from the next paragraph (if there are no medical details in it, jus say no medical details available and if available list those) and summarize it in brief 3 - 4 points,{parah}"
temperature = 0.7  
max_tokens = 150


response = openai.ChatCompletion.create(
   model=model_name,
   messages=[{"role": "system", "content": prompt}],
   max_tokens=max_tokens,
   n=1,
   stop=None,
   temperature=temperature,
)

print(response.choices[0].message.content.strip())
