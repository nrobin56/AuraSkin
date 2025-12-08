from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
import numpy as np
from PIL import Image
import io
import tensorflow as tf

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

model = tf.keras.models.load_model("skin_model.h5")

# Class labels 
skin_labels = ["acne", "dark_spots", "normal"]

# Recommendations for each skin type
recommendations_map = {
    "acne": [
        "Use a salicylic acid cleanser 1–2x daily",
        "Apply a niacinamide serum to reduce redness",
        "Avoid heavy oils and pore-clogging products",
        "Use benzoyl peroxide for active breakouts"
    ],
    "dark_spots": [
        "Apply a Vitamin C serum every morning",
        "Use sunscreen daily (SPF 30+)",
        "Consider retinol at night to fade pigmentation",
        "Avoid picking or squeezing blemishes"
    ],
    "normal": [
        "Maintain your current gentle skincare routine",
        "Use a lightweight moisturizer daily",
        "Apply sunscreen every day",
        "Stay hydrated for healthy, glowing skin"
    ]
}

def preprocess_image(image_bytes):
    # Load image
    img = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    # Resize to match MobileNetV2 input
    img = img.resize((224, 224))
    # Convert to numpy array
    img_array = np.array(img) / 255.0
    # Add batch dimension
    img_array = np.expand_dims(img_array, axis=0)
    return img_array


@app.get("/")
def home():
    return {"message": "AuraSkin Backend Running Successfully!"}


@app.post("/analyze")
async def analyze_skin(file: UploadFile = File(...)):
    # Read uploaded image
    image_bytes = await file.read()

    # Preprocess for model
    img_array = preprocess_image(image_bytes)

    # Predict
    predictions = model.predict(img_array)
    predicted_idx = int(np.argmax(predictions))
    predicted_label = skin_labels[predicted_idx]
    confidence = float(np.max(predictions))

    # Send result and recommendation
    return {
        "skin_type": predicted_label,
        "confidence": confidence,
        "recommendations": recommendations_map[predicted_label]
    }

