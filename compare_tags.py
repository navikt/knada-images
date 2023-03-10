import sys
import json
import requests

from datetime import date

status_image_up_to_date = 0
status_something_wrong = 1
status_image_needs_build = 100

def get_last_knada_image(last_knada: list) -> date:
    if not len(last_knada) == 1:
        print("list of last knada images should only contain one element")
        exit(status_something_wrong)

    return date.fromisoformat(last_knada[0]["updateTime"][:10])

def get_last_jupyter_image(image_tag: str) -> date:
    res = requests.get(f"https://hub.docker.com/v2/namespaces/jupyter/repositories/base-notebook/tags/{image_tag}")
    res.raise_for_status()

    data = res.json()
    return date.fromisoformat(data["tag_last_pushed"][:10])

if __name__ == "__main__":
    date_knada = get_last_knada_image(json.loads(sys.argv[1]))
    date_jupyter = get_last_jupyter_image(sys.argv[2])

    if date_knada < date_jupyter:
        exit(status_image_needs_build)
    
    exit(status_image_up_to_date) 
