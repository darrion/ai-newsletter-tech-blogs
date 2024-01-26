import feedparser
import xmltodict
import json
import requests

from bs4 import BeautifulSoup

# Function to extract the latest post from an RSS feed using feedparser
def extract_latest_post(feed):
    latest_post = feed.entries[0] if feed.entries else None

    if latest_post:
        return latest_post
    else:
        return None

# Read OPML content from the local file
opml_file_path = "engineering_blogs.opml"
with open(opml_file_path, "r") as opml_file:
    opml_content = opml_file.read()

# Convert OPML to JSON using xmltodict
opml_dict = xmltodict.parse(opml_content)

# Iterate over each outline in the OPML data
posts = {}

def process_outline(outline):
    company = outline.get("@text", "")
    title = outline.get("@title", "")
    html_url = outline.get("@htmlUrl", "")
    xml_url = outline.get("@xmlUrl", "")
    if xml_url:
        try:
            # Parse the RSS feed using feedparser
            feed = feedparser.parse(xml_url)

            # Extract the latest post from the parsed feed
            latest_post = extract_latest_post(feed)

            if latest_post:
                link = latest_post.get("link", "")

                try:

                    headers = {
                        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36"
                    }
                    # Make an HTTP request to the link
                    response = requests.get(link, headers=headers)
                    response.raise_for_status()  # Raise an error for bad responses

                    # Extract the raw text from the HTML content of the response
                    html_content = response.text
                    soup = BeautifulSoup(html_content, "html.parser")
                    raw_text = soup.get_text()

                    post = {
                        "company": company,
                        "title": title,
                        "xmlUrl": xml_url,
                        "htmlUrl": html_url,
                        "content": raw_text,  # Include the raw text in the post dictionary
                        "latestPost": {
                            **latest_post
                        }
                    }

                    return title, post

                except requests.exceptions.RequestException as e:
                    print(f"Error occurred while fetching {link}: {e}")
        except Exception as e:
            # Handle any error cases that may occur during fetching or parsing of the RSS feed
            print(f"Error occurred while processing {xml_url}: {e}")
    return ( None, None )

def extract():

    outlines = opml_dict.get("opml", {}).get("body", {}).get("outline", []).get("outline", [])

    if isinstance(outlines, list):
        for outline in outlines:
            title, post = process_outline(outline)
            if title:
                print(f"Processing {title}")
                with open(f"./data/json/{title}.json", "w") as f:
                    json.dump(post, f, indent=2)
    elif isinstance(outlines, dict):
        process_outline(outlines)

if __name__ == "__main__":
    extract()