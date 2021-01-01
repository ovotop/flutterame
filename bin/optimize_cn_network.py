#!/usr/bin/env python3

import os
import sys
import re
from time import strftime, localtime
from ezutils.files import readlines, writelines
dir = os.path.abspath(os.path.dirname(__file__))
parent_dir = os.path.dirname(dir)


def replace_lines(target_reg, *, by_lines, begin_reg,  end_reg, in_lines):
    re_begin = re.compile(begin_reg)
    re_target = re.compile(target_reg)
    re_end = re.compile(end_reg)

    indexs = []
    state = 'find_begin'
    index = -1
    for line in in_lines:
        index += 1
        if state == 'find_begin' and re_begin.match(line):
            state = 'find_target'
            continue
        if state == 'find_target' and re_target.match(line):
            indexs.insert(0, index)
            state == 'find_end'
            continue
        if state == 'find_end' and re_end.match(line):
            state == 'find_begin'
            continue

    # print(indexs)
    if len(indexs) == 0:
        return None

    new_lines = in_lines
    for index in indexs:
        new_lines = new_lines[:index]+by_lines+new_lines[index+1:]
    return new_lines


def optimize_cn_network(target_file):
    print(f'Optimizing cn network: {target_file}')
    lines = readlines(target_file)
    has_google = True
    new_lines = replace_lines(
        r'\s*google().*',
        by_lines=[
            "        maven { url 'https://maven.aliyun.com/repository/google'} // google()"],
        begin_reg=r'\s*repositories\s*{.*',
        end_reg=r'\s*}.*',
        in_lines=lines)

    if(new_lines == None):
        has_google = False
        new_lines = lines

    has_jcenter = True
    new_lines = replace_lines(
        r'\s*jcenter().*',
        by_lines=[
            "        maven { url 'https://maven.aliyun.com/repository/jcenter'} // jcenter()"],
        begin_reg=r'\s*repositories\s*{.*',
        end_reg=r'\s*}.*',
        in_lines=new_lines)

    if new_lines == None and not has_google:
        print(f"No line to optimize in file: {target_file}")
        return

    writelines(new_lines, f'{target_file}.tmp')
    current_time = strftime("%Y-%m-%d_%H:%M:%S", localtime())
    os.rename(target_file, f'{target_file}.backup_{current_time}')
    os.rename(f'{target_file}.tmp', target_file)


if __name__ == "__main__":
    if len(sys.argv) == 1:
        print(
            "Input android project dir(example: 'android/' or 'modules/gallery/.android' ):")
        target_dir = input()
    else:
        target_dir = sys.argv[1]

    target_file = os.path.join(parent_dir, target_dir, 'build.gradle')
    optimize_cn_network(target_file)
