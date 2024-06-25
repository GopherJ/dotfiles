#!/usr/bin/env python3

import os
import re
import sys

def normalize_file_names(path):
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.startswith('.'):
                continue

            (fname, ext) = os.path.splitext(file)

            fname = fname.replace("（", "(")
            fname = fname.replace("）", ")")
            fname = fname.replace("【", "[")
            fname = fname.replace("】", "]")
            fname = fname.replace("＜", "<")
            fname = fname.replace("＞", ">")
            fname = fname.replace("《", "<")
            fname = fname.replace("》", ">")
            fname = fname.replace("：", ":")
            fname = fname.replace("、", "-")
            fname = fname.replace("｜", "|")
            fname = fname.replace("·", '_')
            fname = fname.replace("＂", "\"")
            fname = fname.replace("？", "?")
            fname = fname.replace("⧸", "/")
            fname = fname.replace("＊", "*")
            fname = fname.replace("ü", "\"")
            fname = fname.replace("丨", "|")
            fname = fname.replace("–", "-")
            fname = fname.replace("，", ",")

            fname = fname.replace("×", "_")
            fname = fname.replace("&", "_")
            fname = fname.replace(":", "_")

            new_fname = re.sub(r'[cC]\+\+', 'cpp', fname)
            new_fname = re.sub(r'(\d+)?\.(\d+)', r'\1_\2', fname)

            new_fname = re.sub(r'\(([^)]*)\)', r"_\1_", new_fname)
            new_fname = re.sub(r'\{([^}]*)\}', r"_\1_", new_fname)
            new_fname = re.sub(r'\[([^\]]*)\]', r"_\1_", new_fname)

            new_fname = re.sub(r'[~!@#$%^&*()+={}\[\]\|\\;:\'",<>/?]', '', new_fname)

            new_fname = re.sub(r'\.+', '_', new_fname)
            new_fname = re.sub(r'[-\s]+', '_', new_fname)
            new_fname = re.sub(r'[_—]+', '_', new_fname)

            new_fname = new_fname.strip("_")

            new_fname = new_fname + ext

            if new_fname != file:
                print(f"{file} ----> {new_fname}")
                os.rename(os.path.join(root, file), os.path.join(root, new_fname))

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <dir>")
        sys.exit(1)
    normalize_file_names(sys.argv[1])

