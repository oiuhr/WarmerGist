#!/usr/bin/env python3

import argparse
import subprocess
import os


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '-s',
        help='Использовать сурсы для генерации манифеста. По умолчанию — False',
        action='store_true'
    )

    return parser.parse_args()


def main():
    print("⚒️\tГенерируем проект")

    args = parse_args()

    if args.s:
        os.environ["SPM_WARMER_GENERATE_WITH_SOURCES"] = "1"
        os.environ['TUIST_WARMER_SOURCES'] = "1"

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

    os.environ['TUIST_BUNDLES'] = 'Sources/Packages/Common/WarmerDependencies/Caches/bundle-artifacts/*.bundle'
    subprocess.call(['./Tools/Tuist/tuist', 'generate'])


main()
