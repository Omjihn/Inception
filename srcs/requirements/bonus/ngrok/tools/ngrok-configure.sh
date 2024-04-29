#!/bin/bash

# Set ngrok authtoken
/ngrok config add-authtoken "$NGROK_TOKEN"

# Start ngrok
/ngrok http nginx:443