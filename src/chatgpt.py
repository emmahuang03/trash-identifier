import openai
from keys import *

def categorizeObjectOpenai():
    openai.api_key = api_key_openai
    openai.api_base = api_base_openai
    openai.api_type = 'azure'
    openai.api_version = '2023-05-15' # this may change in the future
    deployment_name='openai-gpt35'

    # set the role of AI assistant and give examples 
    role = {"role": "system", "content": "You are an AI assistant that helps people classify garbage into appropriate bins: landfill trash, recyclable, compost, or special processing facility. The prompts will be in the form 'How should I throw out <insert object name>?' Your response should only contain the category name with no punctuation. If the item should be sent to a specific facility for processing, respond in only the name of the facility."}
    q1 = {"role": "user", "content": "how should i throw out an empty can?"}
    a1 = {"role": "assistant", "content": "recycling"}
    q2 = {"role": "user", "content": "how should i throw out a pizza box?"}
    a2 = {"role": "assistant", "content": "compost"}
    q3 = {"role": "user", "content": "how should i throw out a paper bag?"}
    a3 = {"role": "assistant", "content": "recycling"}

    # Send a completion call to generate an answer
    user_input = input("Enter item name:")
    user_q = {"role": "user", "content": "how should i throw out {}?".format(user_input)}

    response = openai.ChatCompletion.create(
        engine=deployment_name,
        messages=[
            role,
            q1, a1,
            q2, a2,
            q3, a3,
            user_q
        ]
    )

    answer = response['choices'][0]['message']['content']
    return answer

def categorizeObject():
    return categorizeObjectOpenai()
