#!/usr/bin/env python3

import subprocess
import os


def main():
    print("⚒️\tГенерируем проект")

    cached_binaries_path = os.path.expanduser('~/.warmer')
    subprocess.call([
        'Sources/Packages/Common/WarmerDependencies/warm.py',
        '--tuist_executable_directory', './Tools/Tuist/tuist',
        '--cached_binaries_directory', cached_binaries_path,
        '--dependency_manifest_directory', './Sources/Packages/Common/WarmerDependencies/.internal',
    ])
    subprocess.call([
        'Sources/Packages/Common/WarmerDependencies/write.py',
        '--cached_binaries_directory', cached_binaries_path,
        '--generated_manifest_directory', './Sources/Packages/Common/WarmerDependencies'
    ])
    subprocess.call(['Tools/Tuist/tuist', 'generate'])


main()
