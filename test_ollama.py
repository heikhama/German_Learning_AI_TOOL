from app.services.ollama_service import OllamaService

print("====================================")
print("Testing Ollama")
print("====================================")

try:

    words = OllamaService.generate_vocabulary(
        language="German",
        count=5,
    )

    print(words)

except Exception as e:

    print("ERROR")
    print(e)