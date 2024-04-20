#!/usr/bin/env python3

import subprocess


def main():
    print("⚒️\tГенерируем проект")
    subprocess.call(['Tools/Tuist/tuist', 'install'])
    subprocess.call(['Tools/Tuist/tuist', 'generate'])


main()