import os
import json
import requests
from load import load_html, load_json
from constants import companies
import requests

from datetime import date

import asyncio
from ollama import AsyncClient

"""
    TODO: Update terminal with percentage instead of progress instead of printing json
    TODO: In request body, set format to 'json'
"""


def get_json(data: dict = {}):
    
    return json.dumps(data)


def get_message(message: str = ""):
    
    return {"role": "user", "content": message}

def clear_file(file_path):
    try:
        with open(file_path, "w"):
            pass  # This empty block truncates the file
        print(f"Contents of '{file_path}' cleared.")
    except Exception as e:
        print(f"An error occurred: {e}")

def get_summarize_blog_prompt(company_name, company_blog_url, company_data):

    prompt = f"The following is HTML of {company_name} tech engineering blog. Do not summarize the HTML. Rather, identify the content intended for the reader. Then summarize the content intended for the reader. Speak in active voice about the company. Begin by saying \"The latest post on {company_name}'s tech blog at {company_blog_url}...\" Write in proper Markdown format. Have the company name as a header. Here is the HTML:\n\n\n{str(company_data)}"
    
    return get_message(prompt)

def get_newsletter_prompt():
    return {

    }

async def query_model(model, messages):
    print ("Querying model")
    response = await AsyncClient().chat(model=model, messages=messages)
    print (response)
    return response

async def query_model_stream(model, messages):
    print("Querying streaming model")
    async for part in await AsyncClient().chat(model=model, messages=messages, stream=True):
        print(part['message']['content'], end='', flush=True)



def process_html():
    for company_name in companies:
        input_folder = "./data/html"
        html_input_path = (
            f'{input_folder}/{company_name.lower().replace(" ", "_")}.html'
        )
        company_data = ""

        try:
            company_data = load_html(company_name, html_input_path)
        except FileNotFoundError as ex:
            print(f"HTML file {html_input_path} not found.")
            continue
        except Exception as ex:
            print(f"An error occured: {ex}")
            continue

        # Select langugage model
        model = "llama2"

        company_data = {
            "role": "user",
            "content": f"The following is HTML of a tech engineering blog. Do not summarize the HTML. Rather, identify the content intended for the reader. Then summarize the content intended for the reader. Speak in active voice about the company. These will be compiled into a newsletter. Include the date of the post in your summary. Please write in essay, paragraph format. Here is the HTML:\n\n\n{str(company_data)}",
        }

        messages = [company_data]

        asyncio.run(query_model(model, messages))


async def summarize_latest_blogs():
    all_results = []

    for company_name in companies:
        input_folder = "./data/json"
        json_input_path = (
            f'{input_folder}/{company_name.lower().replace(" ", "_")}.json'
        )

        try:
            company_data = load_json(company_name, json_input_path)
        except FileNotFoundError as ex:
            print(f"HTML file {json_input_path} not found.")
            continue
        except Exception as ex:
            print(f"An error occurred: {ex}")
            continue

        model = "llama2:13b"
        content = company_data["content"]
        blog_url = company_data["htmlUrl"]
        company_data_json = json.dumps(content)

        message = get_summarize_blog_prompt(
            company_name, 
            blog_url, 
            company_data_json)
        messages = [message]

        result = await query_model(model, messages)

        all_results.append(result)

        message_dict = result["message"]
        content_str = message_dict["content"]

        with open(f"./data/text/{company_name}.md", "w") as txt_file:
            txt_file.write(content_str)

    return all_results

async def generate_news_letter():
    
    newsletter_filename = "newsletter.md"

    clear_file(newsletter_filename)


    text_folder = "./data/text"
    filenames = os.listdir(text_folder)
    count = len(os.listdir(text_folder))
    newsletter = "# Tech Blog Llama2U Newsletter\n"
    newsletter_subheading = f"## Summary of {count} tech blogs as of {date.today()}"
    newsletter += "\n" + newsletter_subheading + "\n\n"

    try:
        for filename in filenames:
            if filename.endswith(".md"):
                file_path = os.path.join(text_folder, filename)
                with open(file_path, "r") as txt_file:
                    company_name = filename.split(".")[0]
                    summary = txt_file.read()
                    json_filename = f"{company_name}.json"
                    blogHtmlUrl = ""
                    latestPostUrl = ""
                    try:
                        with open(f"./data/json/{json_filename}", "r") as json_file:
                            json_obj = json.loads(json_file.read())
                            blogHtmlUrl = json_obj.get("htmlUrl", None)
                            latestPostUrl = json_obj.get("latestPost", {}).get("link", None)
                        newsletter_section_header = f"### {company_name}\n"
                        newsletter += newsletter_section_header + "\n"
                        newsletter += f"[Blog]({blogHtmlUrl}) | [Post]({latestPostUrl})\n"
                        newsletter += summary + "\n"
                    except Exception as ex:
                        print (f"An error occured opening {json_filename}: {ex}")
                    with open(newsletter_filename, "a") as newsletter_file:
                        newsletter_file.write(newsletter)
                    newsletter = "\n\n"
                    

    except Exception as ex:
        print(f"An error occurred while generating the newsletter: {ex}")

    

if __name__ == "__main__":
    asyncio.run(generate_news_letter())