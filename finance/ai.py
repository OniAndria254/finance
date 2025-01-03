from ai21 import AI21Client
from ai21.models.chat import UserMessage

# One way of passing your key to the client.
client = AI21Client(api_key="qR34CeEv3ZxjnwgaKQdVH5iJnaYxhnow")

# Another way to set your key is by setting the AI21_API_KEY
# environment variable to your key value. The default value
# of api_key in the constructor is os.environ["AI21_API_KEY"]. So:
# import os
# os.environ["AI21_API_KEY"] =  <YOUR_API_KEY>
# client = AI21Client();

def single_message_instruct():
    messages = [
        UserMessage(
            content="Tell me something I don't know. Limit the response to 30 words maximum."
        )
    ]

    response = client.chat.completions.create(
        model="jamba-1.5-large",
        messages=messages,
        top_p=1.0 # Setting to 1 encourages different responses each call.
    )
    print(response.to_json())

single_message_instruct()