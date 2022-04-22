from tkinter import *
from tkinter import messagebox
import os
from pathlib import *
from sys import platform
import re

# Define necessary global variables
listfile = ""
entries = []
list_paths = []
list_names = []

# Initial Configuration and Setup
if platform == 'win32':
    hostsfile = 'c:\\windows\\system32\\drivers\\etc\\hosts'
    editor = 'notepad.exe'
elif platform == 'darwin':
    hostsfile = '/etc/hosts'
    editor = 'TextEdit'
elif platform == 'linux' or platform == 'linux2':
    hostsfile = '/etc/hosts'
    editor = 'gedit'

print("The hosts file is: " + hostsfile)
print("The editor will be: " + editor)

if os.access(hostsfile, os.W_OK):
    permission = 'Write'
else:
    permission = 'ReadOnly'

print("Permissions for hosts file are: " + permission)

list_files = {}
for file in Path.cwd().rglob('*.hosts'):
    list_files[file.stem] = str(file)

for file in Path(hostsfile).parent.glob('*.hosts'):
    list_files[file.stem] = str(file)

print("The following hosts lists are: ")
for item in list_files:
    print(item)

# Functional Code


def get_entries():
    with open(hostsfile, 'r') as hfile:
        for line in hfile:
            if not line.lstrip('ï»¿').lstrip().startswith('#'):
                if not line.startswith("\n"):
                    entries.append(line)


def edit_hostsfile():
    os.system(f"start /wait {editor} {hostsfile}")


def add_entries():
    with open(hostsfile, 'a+') as hfile:
        with open(list_files.get(list_box.get(ANCHOR)), 'r') as lfile:
            hfile.write('\n')
            for line in lfile:
                hfile.write(line)


# def remove_entries():
#     with open(hostsfile, "r") as input:
#         with open("temp.txt", "w") as output:
#             for line in input:
#                 if "# Managed" not in line.strip("\n"):
#                     output.write(line)
#     try:
#         os.replace('temp.txt', hostsfile)
#         remove_newlines()
#         get_entries()
#     except PermissionError:
#         messagebox.showerror('Access is Denied', 'PermissionError: Run application as Administrator')
#
#
# def remove_newlines():
#     with open(hostsfile, 'r') as hfile:
#         contents = hfile.read()
#         contents = re.sub(r'\n\s*\n\n', '\n\n', contents)
#     with open(hostsfile, 'w') as hfile:
#         hfile.write(contents)
#
#
# get_entries()
#
# # Graphical Interface
# window = Tk()
# window.title("Hosts File Manager")
# left_frame = Frame(window)
# left_frame.pack(side="left", padx=5)
# right_frame = Frame(window)
# right_frame.pack(side="right", padx=5)
#
# actions = Label(left_frame, text="Actions")
# actions.pack(pady=5)
#
# remove_btn = Button(left_frame, text="Remove All Manged Entries",
#                     height=2, width=25, borderwidth=3, relief="raised", padx=2, pady=5, command=remove_entries)
# remove_btn.pack()
#
# edit_btn = Button(left_frame, text="Edit Hosts File", height=2, width=25, borderwidth=3, relief="raised",
#                   padx=2, pady=5, command=lambda: [edit_hostsfile()])
# edit_btn.pack()
#
# add_btn = Button(left_frame, text="Add Manged List", height=2, width=25, borderwidth=3, relief="raised",
#                  padx=2, pady=5, command=add_entries)
# add_btn.pack()
#
# list_box = Listbox(left_frame, selectmode='single', width=30)
# for item in list_files.keys():
#     list_box.insert("end", item)
# list_box.pack()
#
# current_label = Label(right_frame, text="Currently Active Hosts Entries")
# current_label.pack(pady=5)
#
# entries_box = Text(right_frame, height=15, width=100, padx=15, pady=15)
# entries_box.insert(1.0, *entries)
# entries_box.pack()
#
# window.mainloop()
get_entries()
print(*entries.)