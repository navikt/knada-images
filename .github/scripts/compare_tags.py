import backoff
import json
import requests
import sys

from datetime import date, datetime

JUPYTER_REPO_URL_PREFIX = "https://quay.io/api/v1/repository/jupyter/base-notebook/tag/?specificTag=python-3.11&onlyActiveTags=true"
AIRFLOW_REPO_URL_PREFIX = "https://hub.docker.com/v2/namespaces/apache/repositories/airflow/tags"
PYTHON_REPO_URL_PREFIX = "https://hub.docker.com/v2/repositories/library/python/tags"

# Return values from script
STATUS_IMAGE_UP_TO_DATE_WITH_PARENT = 0
STATUS_IMAGE_OUTDATED = 100

def get_last_knada_image(last_knada: list) -> date:
    if len(last_knada) == 0:
        print("No image exists from before")
        exit(STATUS_IMAGE_OUTDATED)

    return date.fromisoformat(last_knada[0]["updateTime"][:10])

@backoff.on_exception(backoff.expo, requests.exceptions.RequestException, max_tries=5)
def get_request_with_retries(url: str) -> dict:
    res = requests.get(url)
    res.raise_for_status()
    return res.json()

def get_last_dockerhub_image(url: str) -> date:
    data = get_request_with_retries(url)
    return date.fromisoformat(data["tag_last_pushed"][:10])

def get_last_quay_image(url: str) -> date:
    data = get_request_with_retries(url)
    for tag in data["tags"]:
        try:
            tag["expiration"]
        except KeyError:
            ts_quay = datetime.strptime(tag["last_modified"].split(", ")[-1].split(" -")[0], "%d %b %Y %H:%M:%S")
            return ts_quay.date()
        else:
            continue

    raise Exception("unable to find active image tag for quay image")


if __name__ == "__main__":
    image_name = sys.argv[1]
    latest_gar_image = json.loads(sys.argv[2])
    image_tag = sys.argv[3]

    date_knada = get_last_knada_image(latest_gar_image)

    if image_name == "jupyterhub":
        url = JUPYTER_REPO_URL_PREFIX + "/" + image_tag
        date_base = get_last_quay_image(url)
    elif image_name == "airflow":
        url = AIRFLOW_REPO_URL_PREFIX + "/" + image_tag
        date_base = get_last_dockerhub_image(url)
    elif image_name == "python":
        url = PYTHON_REPO_URL_PREFIX + "/" + image_tag
        date_base = get_last_dockerhub_image(url)
    else:
        print(f"Unknown image: {image_name}")
        exit(1)

    if date_knada < date_base:
        print("Image is outdated")
        exit(STATUS_IMAGE_OUTDATED)

    print("Image is up to date with parent")
    exit(STATUS_IMAGE_UP_TO_DATE_WITH_PARENT) 
