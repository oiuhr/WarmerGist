#!/usr/bin/env python3

import argparse
import hashlib
import os
import subprocess

from constants import package_name
from constants import executable_dependency_template
from constants import binary_target_template
from constants import manifest_template


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--cached_binaries_directory",
        help="Path to cached binaries directory.",
        required=True
    )
    parser.add_argument(
        "--generated_manifest_directory",
        help="Path to generated manifest directory.",
        required=True
    )

    return parser.parse_args()


args = parse_args()

os.chdir(args.generated_manifest_directory)

manifest_path = os.path.join('./.internal', 'Tuist', 'Package.swift')

if "SPM_WARMER_GENERATE_WITH_SOURCES" in os.environ:
    print(f'🥷 Поймано значение окружения для генерации из сурсов: используем внутренний манифест', flush=True)
    subprocess.call(['cp', f'{manifest_path}', './'])
    exit(0)

# Считаем сумму Package.swift файла для того, чтобы вытащить кеш с нужной хеш суммой.
# Tuist умеет делать это самостоятельно, но внутри себя — в текущем формате нам нужно делать это на нашей стороне.
manifest_hash = hashlib.md5(open(manifest_path, 'rb').read()).hexdigest()
print('👺', manifest_hash)
target_cache = os.path.join(args.cached_binaries_directory, manifest_hash)

if not os.path.exists('./Caches'):
    os.makedirs('./Caches')
else:
    subprocess.call(['rm', '-rf', 'Caches'])

subprocess.call(['cp', '-R', f'{target_cache}/.', './Caches'])

executable_dependencies = ''
binary_targets = ''

for dir_path, _, _ in os.walk('./Caches'):
    if str(dir_path).endswith('.xcframework') and '__MACOSX' not in str(dir_path):
        binary_name = str(dir_path).split('.xcframework')[0].split('/')[-1] + 'Framework'
        executable_dependencies += executable_dependency_template.format(name=binary_name)
        binary_targets += binary_target_template.format(
            name=binary_name,
            path=dir_path
        )

manifest_content = manifest_template.format(
    package_name=package_name,
    executable_dependencies=executable_dependencies,
    binary_targets=binary_targets
)

with open(f'./Package.swift', 'w') as manifest:
    manifest.write(manifest_content)
    manifest.close()
