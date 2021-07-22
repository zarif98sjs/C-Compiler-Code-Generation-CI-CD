import dropbox
import os
# print(os.environ.get('DROPBOX_TOKEN'))
dbx = dropbox.Dropbox(os.getenv('DROPBOX_TOKEN'))
# print(dbx.users_get_current_account())
filename = './tmp/code.asm'
with open(filename, "rb") as f:
    dbx.files_upload(f.read(), '/code.asm', mute=True, mode=dropbox.files.WriteMode.overwrite)
