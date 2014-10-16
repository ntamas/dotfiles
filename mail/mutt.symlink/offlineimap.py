#!/usr/bin/python

from os.path import expanduser
import getpass
import re
import subprocess

FOLDER_MAPPING = {
    'chats':      '[Gmail]/Chats',
    'drafts':     '[Gmail]/Drafts',
    'sent':       '[Gmail]/Sent',
    'flagged':    '[Gmail]/Starred',
    'trash':      '[Gmail]/Trash',
    'archive':    '[Gmail]/All Mail'
}

FOLDER_REVERSE_MAPPING = dict((v, k) for k, v in FOLDER_MAPPING.iteritems())

IGNORED_FOLDERS = frozenset([
    '[Gmail]/Trash', '[Gmail]/Important', '[Gmail]/Spam',
    '[Airmail]', '[Airmail]/Done', '[Airmail]/Memo', '[Airmail]/To Do',
    '[Mailbox]', '[Mailbox]/Later', '[Mailbox]/To Read', '[Mailbox]/To Watch'
])


def local_to_remote_nametrans(folder):
    global FOLDER_MAPPING
    return FOLDER_MAPPING.get(folder, folder)


def remote_to_local_nametrans(folder):
    global FOLDER_REVERSE_MAPPING
    return FOLDER_REVERSE_MAPPING.get(folder, folder)


def is_folder_synced(folder):
    global IGNORED_FOLDERS
    return folder not in IGNORED_FOLDERS


def get_keychain_pass(account=None, server=None):
    params = {
        'user': getpass.getuser(),
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'server': server,
        'keychain': expanduser('~/Library/Keychains/login.keychain'),
    }
    command = "sudo -u %(user)s %(security)s -v %(command)s -g -a %(account)s -s %(server)s %(keychain)s" % params
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    outtext = [l for l in output.splitlines()
               if l.startswith('password: ')][0]

    return re.match(r'password: "(.*)"', outtext).group(1)