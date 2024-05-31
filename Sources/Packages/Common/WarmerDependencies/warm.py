#!/usr/bin/env python3

import argparse
import hashlib
import os
import subprocess


def warm_binaries(args):
    install_code = subprocess.call([
        args.tuist_executable_directory, 'install',
        '--path', args.dependency_manifest_directory
    ])

    if not install_code == 0:
        throw(install_code)

    cache_code = subprocess.call([
        args.tuist_executable_directory, 'cache',
        '--path', args.dependency_manifest_directory
    ])

    if not cache_code == 0:
        throw(cache_code)


def throw(code):
    exit(code)


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '--tuist_executable_directory',
        help='Путь до исполняемого файла Tuist.',
        required=True
    )
    parser.add_argument(
        '--dependency_manifest_directory',
        help='Путь до директории, содержащей Package.swift манифест с внешними зависимостями.',
        required=True
    )

    return parser.parse_args()


def main():
    args = parse_args()
    warm_binaries(args)


main()
