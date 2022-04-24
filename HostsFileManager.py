from tkinter import *
from tkinter import messagebox
import os
from pathlib import *
from sys import platform
import re

# Define necessary global variables
entries = []
ability = 'normal'
list_files = {}

# Initial Configuration and Setup
if platform == 'win32':
    hostsfile = 'c:\\windows\\system32\\drivers\\etc\\hosts'
    editor = 'notepad.exe'
elif platform == 'darwin':
    hostsfile = '/etc/hosts'
    editor = 'open'
elif platform == 'linux' or platform == 'linux2':
    hostsfile = '/etc/hosts'
    editor = 'gedit'

if os.access(hostsfile, os.W_OK):
    permission = 'Write'
else:
    permission = 'Read Only'

try:
    if open(hostsfile, "a").writable():
        permission = 'Read / Write'
except PermissionError:
    permission = 'Read Only'
    ability = 'disabled'

for file in Path.cwd().rglob('*.hosts'):
    list_files[file.stem] = str(file)

for file in Path(hostsfile).parent.glob('*.hosts'):
    list_files[file.stem] = str(file)

# Function Definitions


def get_entries():
    if entries:
        entries.clear()
    with open(hostsfile, 'r') as hfile:
        for line in hfile:
            if not line.lstrip('ï»¿').lstrip().startswith('#'):
                if not line.startswith("\n"):
                    entries.append(line)


def display_entries():
    entries_box.delete(0, "end")
    get_entries()
    for entry in entries:
        entries_box.insert("end", entry)


def edit_hostsfile():
    if platform == "darwin":
        os.system(f"sudo {editor} {hostsfile} -t")
    elif platform == "win32":
        os.system(f"start /wait {editor} {hostsfile}")
    else:
        os.system("sudo vi hostsfile") 


def add_entries():
    if list_box.get(ANCHOR):
        with open(hostsfile, 'a+') as hfile:
            with open(list_files.get(list_box.get(ANCHOR)), 'r') as lfile:
                hfile.write('\n')
                for line in lfile:
                    hfile.write(line)


def remove_entries():
    try:
        with open(hostsfile, "r+") as current:
            lines = current.readlines()
            current.seek(0)
            current.truncate()
            for line in lines:
                if "# Managed" not in line.strip("\n"):
                    current.writelines(line)
    except PermissionError:
        messagebox.showerror('Access is Denied', 'PermissionError: Run application as Administrator')


def remove_newlines():
    with open(hostsfile, 'r') as hfile:
        contents = hfile.read()
        contents = re.sub(r'\n\s*\n\n', '\n\n', contents)


# Graphical Interface
window = Tk()
window.title("Hosts File Manager: " + permission)
window.geometry('750x400')

# Left Frame Configuration
left_frame = Frame(window)
left_frame.pack(side="left", padx=5)
right_frame = Frame(window)
right_frame.pack(side="right", padx=5)

actions_label = Label(left_frame, text="Actions:", font=10)
actions_label.pack(pady=5)

remove_btn = Button(left_frame, text="Remove All Manged Entries", height=2, width=30, borderwidth=3, relief="raised",
                    state=ability, padx=2, pady=5, command=lambda: [remove_entries(), remove_newlines(), get_entries(), display_entries()])
remove_btn.pack()

edit_btn = Button(left_frame, text="Edit Hosts File", height=2, width=30, borderwidth=3, relief="raised",
                  state=ability, padx=2, pady=5, command=lambda: [edit_hostsfile(), remove_newlines(), get_entries(), display_entries()])
edit_btn.pack()

add_btn = Button(left_frame, text="Add Manged List", height=2, width=30, borderwidth=3, relief="raised",
                 state=ability, padx=2, pady=5, command=lambda: [add_entries(), remove_newlines(), get_entries(), display_entries()])
add_btn.pack()

groups_label = Label(left_frame, text="Available Hosts Groups:", font=10)
groups_label.pack(pady=5)

list_box = Listbox(left_frame, selectmode='single', width=35)
for item in list_files.keys():
    list_box.insert("end", item)
list_box.pack()

# Right Frame Configuration
current_label = Label(right_frame, text="Currently Active Hosts Entries:", font=12)
current_label.pack()

entries_box = Listbox(right_frame, selectmode='none', height=22, width=150)
display_entries()
entries_box.pack()

window.mainloop()
