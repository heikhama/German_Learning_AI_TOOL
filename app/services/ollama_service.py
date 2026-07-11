import json
import requests

OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL = "llama3.1:latest"


class OllamaService:

    @staticmethod
    def generate_vocabulary(language: str, count: int = 5):

        prompt = f"""
Generate exactly {count} common {language} vocabulary words.

Return ONLY valid JSON.

Format:

[
  {{
    "word": "",
    "meaning": "",
    "pronunciation": "",
    "part_of_speech": "",
    "cefr_level": "A1",
    "category": "Daily Conversation",
    "example_sentence": "",
    "example_translation": ""
  }}
]

Do not use markdown.
Do not explain anything.
Return JSON only.
"""

        print("=" * 60)
        print("Sending request to Ollama...")
        print("=" * 60)

        response = requests.post(
            OLLAMA_URL,
            json={
                "model": MODEL,
                "prompt": prompt,
                "stream": False,
            },
            timeout=300,
        )

        response.raise_for_status()

        result = response.json()

        text = result["response"].strip()

        print("=" * 60)
        print("Raw Response")
        print("=" * 60)
        print(text)

        # Remove markdown if present
        if text.startswith("```"):
            text = text.replace("```json", "")
            text = text.replace("```", "")
            text = text.strip()

        data = json.loads(text)

        print("=" * 60)
        print(f"Generated {len(data)} words")
        print("=" * 60)

        return data