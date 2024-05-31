#!/usr/bin/env python3

import argparse
import hashlib
import os
import subprocess


def warm_binaries(args, cached_binaries_directory_for_manifest):
    install_code = subprocess.call([
        args.tuist_executable_directory, 'install',
        '--path', args.dependency_manifest_directory
    ])

    if not install_code == 0:
        throw(install_code, cached_binaries_directory_for_manifest)

    cache_code = subprocess.call([
        args.tuist_executable_directory, 'cache',
        '--path', args.dependency_manifest_directory
    ])

    if not cache_code == 0:
        throw(cache_code, cached_binaries_directory_for_manifest)


def throw(code, directory_to_remove):
    subprocess.call(['rm', '-rf', directory_to_remove])
    exit(code)


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '--tuist_executable_directory',
        help='Путь до исполняемого файла Tuist.',
        required=True
    )
    parser.add_argument(
        '--cached_binaries_directory',
        help='Путь до кастомной директории с кешом.',
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

    manifest_path = os.path.join(args.dependency_manifest_directory, 'Tuist', 'Package.swift')
    # Считаем сумму Package.swift файла для пересбора зависимостей в случае изменения манифеста.
    # Tuist умеет делать это самостоятельно, но внутри себя — в текущем формате нам нужно делать это на нашей стороне.
    manifest_hash = hashlib.md5(open(manifest_path, 'rb').read()).hexdigest()
    cached_binaries_directory_for_manifest = os.path.join(args.cached_binaries_directory, manifest_hash)

    if not os.path.exists(cached_binaries_directory_for_manifest):
        os.environ['XDG_CACHE_HOME'] = cached_binaries_directory_for_manifest
        warm_binaries(args, cached_binaries_directory_for_manifest)
    else:
        print(f'Пропуск прогрева, найден кеш на {cached_binaries_directory_for_manifest}', flush=True)


main()
