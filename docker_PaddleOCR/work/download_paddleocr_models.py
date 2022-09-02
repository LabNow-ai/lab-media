import os
import requests
from paddleocr.paddleocr import MODEL_URLS, maybe_download, BASE_DIR
from paddleocr.paddleocr import PaddleOCR, PPStructure
from requests.exceptions import ConnectionError
from urllib3.exceptions import InsecureRequestWarning

# Suppress only the single warning from urllib3 needed.
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)


def list_files():
    for model_type, models in MODEL_URLS.items():
        # print(model_type) # OCR / STRUCTURE
        for model_ver, model in models.items():
            # print(model_ver, model) # PP-OCRv3 / PP-OCRv2 / PP-OCR
            for model_part, model_langs in model.items():
                # print(model_part, model_lang)
                for lang, model_info in model_langs.items():
                    yield model_type, model_ver, model_part, lang, model_info


def download_models():
    list_models = [PaddleOCR, PPStructure]
    for clz in list_models:
        print('Download models for', clz.__name__)
        c = clz(use_gpu=False)
        del c

    for model_type, model_ver, model_part, lang, model_info in list_files():
        # print(model_type, model_ver, model_part, lang, model_info, path_file)
        url = model_info.get('url')
        file_name = url.split('/')[-1].replace('.tar', '')
        folder_dst = os.path.join(BASE_DIR, 'whl', model_part, lang, file_name)
        download_success = False
        while not download_success:
            try:
                print('Downloading model %s to %s' % (url, folder_dst))
                maybe_download(folder_dst, url)
                download_success = True
            except ConnectionError:
                continue


def main():
    download_models()


if __name__ == '__main__':
    main()
