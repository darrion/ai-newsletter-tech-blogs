import os
import json
import requests

from constants import companies

# Function to fetch HTML for a given company
def fetch_html(company_name, json_file_path):
    # Create the output folder if it doesn't exist
    output_folder = "./data/html"
    os.makedirs(output_folder, exist_ok=True)

    html_output_path = f'{output_folder}/{company_name.lower().replace(" ", "_")}.html'

    # Read JSON file
    try:
        with open(json_file_path, "r") as json_file:
            data = json.load(json_file)

            # Check if there is a 'link' key in the JSON data
            if "link" in data:
                article_link = data["link"]
                response = requests.get(article_link)

                if response.status_code == 200:
                    html_content = response.text

                    # Save HTML content to file
                    with open(html_output_path, "w", encoding="utf-8") as html_file:
                        html_file.write(html_content)
                    print(f"Successfully saved HTML for {company_name}.")
                else:
                    print(
                        f"Failed to fetch HTML for {company_name}. Status code: {response.status_code}"
                    )
            else:
                print(f"No article link found for {company_name}.")
    except FileNotFoundError as ex:
        print (f"File {json_file_path} not found.")
    except Exception as ex:
        print (f"An error occured: {ex}")

if __name__ == "__main__":
    # Iterate through companies and fetch HTML
    for company in companies:
        json_file_path = f'./data/json/{company.lower().replace(" ", "_")}.json'
        fetch_html(company, json_file_path)
