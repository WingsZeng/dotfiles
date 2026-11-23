import re
import sys

_SECTION_RE = re.compile(r"^\s*\[([^]]+)]\s*$")
_ASSIGNMENT_RE = re.compile(r"^(\s*)([^#;][^=]*?)(\s*=\s*)(.*)$")


def _assignment(line):
    match = _ASSIGNMENT_RE.match(line)
    if not match:
        return None
    return match, match.group(2).strip(), match.group(4).strip()


def _find_block(blocks, name):
    for block in blocks:
        if block["name"] == name:
            return block
    block = {"name": name, "lines": [f"[{name}]"]}
    blocks.append(block)
    return block


def _set_value(block, key, value):
    matches = []
    for index, line in enumerate(block["lines"]):
        parsed = _assignment(line)
        if parsed and parsed[1] == key:
            matches.append((index, parsed[0], parsed[2]))

    if matches:
        first, match, current = matches[0]
        if current != value:
            block["lines"][first] = f"{match.group(1)}{match.group(2)}{match.group(3)}{value}"
        for index, _, _ in reversed(matches[1:]):
            del block["lines"][index]
        return

    comment = re.compile(rf"^\s*[#;]\s*{re.escape(key)}\s*=")
    for index, line in enumerate(block["lines"]):
        if comment.match(line):
            block["lines"].insert(index + 1, f"{key}={value}")
            return

    index = len(block["lines"])
    while index > (1 if block["name"] else 0) and not block["lines"][index - 1].strip():
        index -= 1
    block["lines"].insert(index, f"{key}={value}")


def _replace_section(block, values):
    current = []
    assignment_indexes = []
    for index, line in enumerate(block["lines"]):
        parsed = _assignment(line)
        if parsed:
            assignment_indexes.append(index)
            current.append((parsed[1], parsed[2]))

    desired = list(values.items())
    if current == desired:
        return

    index = assignment_indexes[0] if assignment_indexes else len(block["lines"])
    for assignment_index in reversed(assignment_indexes):
        del block["lines"][assignment_index]
    while index > 1 and index <= len(block["lines"]) and not block["lines"][index - 1].strip():
        index -= 1
    block["lines"][index:index] = [f"{key}={value}" for key, value in desired]


def patch(sections, exact_sections=()):
    source = sys.stdin.read()
    blocks = [{"name": "", "lines": []}]
    for line in source.splitlines():
        match = _SECTION_RE.match(line)
        if match:
            blocks.append({"name": match.group(1), "lines": [line]})
        else:
            blocks[-1]["lines"].append(line)

    exact_sections = set(exact_sections)
    for section, values in sections.items():
        block = _find_block(blocks, section)
        if section in exact_sections:
            _replace_section(block, values)
        else:
            for key, value in values.items():
                _set_value(block, key, value)

    lines = []
    for block in blocks:
        if lines and block["name"] and lines[-1].strip():
            lines.append("")
        lines.extend(block["lines"])
    sys.stdout.write("\n".join(lines) + "\n")
