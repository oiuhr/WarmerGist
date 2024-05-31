#!/usr/bin/env python3

import argparse
import hashlib
import os
import shutil
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


def warm_bundles(args, cached_binaries_directory_for_manifest):
    bundles_directory = os.path.join(cached_binaries_directory_for_manifest, 'bundle-artifacts', "")
    os.makedirs(bundles_directory)

    # Ловится в пост-билд скрипте проекта, который собирает зависимости (ну и собственно бандлы).
    # Сам пост-билд скрипт копирует в переданную папку из DD готовые бандлы для переиспользования.
    os.environ['CACHED_BUNDLES_DIRECTORY'] = bundles_directory

    generate_code = subprocess.call([
        args.tuist_executable_directory, 'generate',
        '--path', args.dependency_manifest_directory,
        '--no-open'
    ])
    if not generate_code == 0:
        throw(generate_code, cached_binaries_directory_for_manifest)

    # Нам нужно сбилдить конкретную схему проекта, а в текущей версии tuist cache генерирует себе .xcworkspace
    # и все ломает (не дает поймать схему). Сносим к чертям чтобы не мешал, он нам не нужен.
    shutil.rmtree(f'{args.dependency_manifest_directory}/_WarmerDependencies.xcworkspace')

    build_code = subprocess.call([
        args.tuist_executable_directory, 'build',
        '--path', args.dependency_manifest_directory
    ])
    if not build_code == 0:
        throw(build_code, cached_binaries_directory_for_manifest)


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
    if "SPM_WARMER_GENERATE_WITH_SOURCES" in os.environ:
        print(f'🥷 Поймано значение окружения для генерации из сурсов: пропуск прогрева зависимостей', flush=True)
        exit(0)

    args = parse_args()

    manifest_path = os.path.join(args.dependency_manifest_directory, 'Tuist', 'Package.swift')
    # Считаем сумму Package.swift файла для пересбора зависимостей в случае изменения манифеста.
    # Tuist умеет делать это самостоятельно, но внутри себя — в текущем формате нам нужно делать это на нашей стороне.
    manifest_hash = hashlib.md5(open(manifest_path, 'rb').read()).hexdigest()
    cached_binaries_directory_for_manifest = os.path.join(args.cached_binaries_directory, manifest_hash)

    if not os.path.exists(cached_binaries_directory_for_manifest):
        os.environ['XDG_CACHE_HOME'] = cached_binaries_directory_for_manifest
        warm_binaries(args, cached_binaries_directory_for_manifest)
        warm_bundles(args, cached_binaries_directory_for_manifest)
    else:
        print(f'Пропуск прогрева, найден кеш на {cached_binaries_directory_for_manifest}', flush=True)


main()
