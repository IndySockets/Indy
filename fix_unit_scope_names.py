#!/usr/bin/env python3
"""
Script to fix USE_UNIT_SCOPE_NAMES compiler directive usage in Indy library.

Problem: {$IFDEF USE_UNIT_SCOPE_NAMES}Namespace.{$ENDIF}UnitName
Delphi sees the "." before {$ENDIF} as end of file marker.

Solution: {$IFDEF USE_UNIT_SCOPE_NAMES}Namespace.UnitName{$ELSE}UnitName{$ENDIF}
"""

import re
import os
import sys
from pathlib import Path

def fix_unit_scope_pattern(content):
    """
    Find and fix all instances of the problematic pattern.

    Pattern: {$IFDEF USE_UNIT_SCOPE_NAMES}<namespace>.{$ENDIF}<unit_name>
    Replace: {$IFDEF USE_UNIT_SCOPE_NAMES}<namespace>.<unit_name>{$ELSE}<unit_name>{$ENDIF}
    """
    # This regex captures:
    # - The opening {$IFDEF USE_UNIT_SCOPE_NAMES}
    # - The namespace (e.g., Winapi, System, etc.)
    # - The dot after namespace
    # - The closing {$ENDIF}
    # - The unit name that follows

    pattern = r'\{\$IFDEF USE_UNIT_SCOPE_NAMES\}([A-Za-z0-9_]+)\.\{\$ENDIF\}([A-Za-z0-9_]+)'

    def replacement(match):
        namespace = match.group(1)
        unit_name = match.group(2)
        return f'{{$IFDEF USE_UNIT_SCOPE_NAMES}}{namespace}.{unit_name}{{$ELSE}}{unit_name}{{$ENDIF}}'

    new_content, count = re.subn(pattern, replacement, content)
    return new_content, count

def process_file(file_path):
    """Process a single .pas file."""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()

        new_content, count = fix_unit_scope_pattern(content)

        if count > 0:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            return count
        return 0
    except Exception as e:
        print(f"Error processing {file_path}: {e}", file=sys.stderr)
        return 0

def main():
    lib_dir = Path(__file__).parent / 'Lib'

    if not lib_dir.exists():
        print(f"Error: Lib directory not found at {lib_dir}", file=sys.stderr)
        sys.exit(1)

    total_files = 0
    total_replacements = 0

    # Find all .pas files recursively
    for pas_file in lib_dir.rglob('*.pas'):
        count = process_file(pas_file)
        if count > 0:
            total_files += 1
            total_replacements += count
            print(f"Fixed {count} instances in {pas_file.relative_to(lib_dir.parent)}")

    print(f"\nSummary:")
    print(f"  Files modified: {total_files}")
    print(f"  Total replacements: {total_replacements}")

if __name__ == '__main__':
    main()
