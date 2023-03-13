import sys
import json
import requests
import backoff

from datetime import date

JUPYTER_REPO_URL_PREFIX = "https://hub.docker.com/v2/namespaces/jupyter/repositories/base-notebook/tags"

# Return values from script
STATUS_IMAGE_UP_TO_DATE_WITH_PARENT = 0
STATUS_ERROR = 1
STATUS_IMAGE_OUTDATED = 100

def get_last_knada_image(last_knada: list) -> date:
    if not len(last_knada) == 1:
        print("list of last knada images should only contain one element")
        exit(STATUS_ERROR)

    return date.fromisoformat(last_knada[0]["updateTime"][:10])

@backoff.on_exception(backoff.expo, requests.exceptions.RequestException, max_tries=5)
def get_request_with_retries(url: str) -> dict:
    res = requests.get(url)
    res.raise_for_status()
    return res.json

def get_last_jupyter_image(image_tag: str) -> date:
    data = get_request_with_retries(f"{JUPYTER_REPO_URL_PREFIX}/{image_tag}")
    return date.fromisoformat(data["tag_last_pushed"][:10])

if __name__ == "__main__":
    date_knada = get_last_knada_image(json.loads(sys.argv[1]))
    date_jupyter = get_last_jupyter_image(sys.argv[2])

    if date_knada < date_jupyter:
        print("Knada image is outdated")
        exit(STATUS_IMAGE_OUTDATED)

    print("Knada image is up to date with parent")
    exit(STATUS_IMAGE_UP_TO_DATE_WITH_PARENT) 
