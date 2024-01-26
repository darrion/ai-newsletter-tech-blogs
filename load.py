def load_html(company_name, html_file_path):
    # Read HTML file
    with open(html_file_path, "r", encoding="utf-8") as html_file:
        html_content = html_file.read()

        # Process the HTML content as needed
        # For example, you can parse the HTML using a library like BeautifulSoup

        print(f"Successfully loaded HTML for {company_name}.")
        return html_content

    # Handle other exceptions as needed
    # You might want to raise an exception or return a default value in case of an error

def load_json(company_name, json_file_path):
    import json 

    with open(json_file_path, "r", encoding="utf-8") as json_file:
        json_content = json_file.read()
        json_obj = json.loads(json_content)

        print (f"Successfully loaded JSON for {company_name}.")
        return json_obj
    