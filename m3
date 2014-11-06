#!/usr/bin/env python
#
# TODO use python zcat lib

import os, re, subprocess as sub, sys
from itertools import imap, islice
from funcy import identity, ifilter, silent

class Line:

    """A line of text, numbered from its source file, 
    split into fields or re-joined on demand."""

    def __init__(self, line, number):
        self.line = line.strip()
        self.number = number
        self.fields = None

    def join(self, options):
        if self.line is None:
            self.line = options.joiner.join(self.fields)
        return self

    def split(self, options):
        if self.fields is None:
            self.fields = options.splitter.split(self.line)
        return self

    def set(self, value):
        if type(value) == list:
            self.fields = value
            self.line = None
        else:
            self.line = value
            self.fields = None
        return self

    def renumber(self, number):
        self.number = number
        return self

def main(argv):


    stream = read_files(filenames)

    while len(argv):
        elif re.match(r"-?\d+(-\d*)?(\d+(-\d*)?)*", action):
            argv.appendleft(action)
            argv.appendleft("keep")
        elif action == "drop":
            stream = drop(options, stream, getargs("drop", 1, silent(int)))
        elif action == "group":
            stream = group(options, stream, getargs("group", 1, silent(Columns)))
        elif action == "grep":
            stream = grep(options, stream, getargs("grep", 1, identity))
        elif action == "head":
            stream = head(options, stream, getargs("head", 1, silent(int)))
        elif action in ["headtail", "ht"]:
            stream = headtail(options, stream)
        elif action == "hdr" or action == "header":
            header = getargs(action, 1, identity).split(",")
        elif action == "keep":
            stream = keep(options, stream, getargs("keep", 1, silent(Columns)))
        elif action == "sep":
            sep = getargs("sep", 1, identity)
            options = options._replace(joiner=sep, splitter=re.compile(sep))
        elif action == "strip":
            stream = strip(options, stream, getargs("strip", 1, identity))
        elif action == "tail":
            stream = tail(options, stream, getargs("tail", 1, silent(int)))

    if dosome:
        stream = headtail(options, stream)

    if header is not None:
        print options.joiner.join(header)
    for line in stream:
        print line.join(options).line

def group(options, stream, columns):
    groups = {}
    for line in stream:
        fields = line.split(options).fields
        key = ""
        for column in columns.listed(len(fields)):
            key = key + "/" + fields[column]
        if key in groups:
            group = groups[key]
        else:
            groups[key] = group = []
        group.append(line)
    number = 0
    for group in groups.itervalues():
        for line in group:
            yield line.renumber(number)
            number += 1

