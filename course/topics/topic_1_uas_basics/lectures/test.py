def check_blocks(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    stack = []
    slide_number = 0
    for line_number, line in enumerate(lines, start=1):
        is_closed = False
        if '##' in line and slide_number > 0:
            print(f"Stack length {len(stack)}")
            is_closed = True if len(stack) % 2 == 0 else False
            if not is_closed:
                print(f"Unmatched opening block at line {stack[-1]}")
            else:
                print(f"Slide {slide_number} is closed")
        if '##' in line:
            slide_number += 1
            print(f"Slide {slide_number}")
            stack = []
        if line.strip().startswith(':::'):
            stack.append(line_number)


if __name__ == '__main__':
    check_blocks('lecture_1b.qmd')
