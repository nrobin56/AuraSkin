# AuraSkin

AuraSkin is an AI-powered mobile prototype that analyzes images of human skin and classifies them into one of three categories:
- Acne
- Dark Spots
- Normal Skin

The system is built using a MobileNetV2 deep learning model, a FastAPI backend, and a Flutter mobile application. Users upload an image, press “Analyze Skin,” and receive predictions with personalized skincare recommendations.
This repository contains all components of the AuraSkin system, including the machine learning model, API server, mobile app UI, and project documentation.

# Features

- Upload a skin image from the device’s photo gallery
- Sends the image to the backend for real-time inference
- AI model predicts acne, dark spots, or normal skin
- Displays prediction + confidence score
- Personalized skincare recommendations
- Works locally using an iOS simulator
- Brand-consistent UI using lavender + tan theme
