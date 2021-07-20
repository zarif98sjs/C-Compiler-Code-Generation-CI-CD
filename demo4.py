# sl.A0_lQKF3CpGCQ04GOqF_qWVEWKQd6zfid9XcxDGqVTVuKKRKNE_EldDlt5Xpy-Y7jc0Ty30j7Ohjp-XqLe2x563cEmSgm2pZIpCg7obTuqTrvr_chtPojI5f6wwvi3Nfy7U9J2A
# sl.A0_lQKF3CpGCQ04GOqF_qWVEWKQd6zfid9XcxDGqVTVuKKRKNE_EldDlt5Xpy-Y7jc0Ty30j7Ohjp-XqLe2x563cEmSgm2pZIpCg7obTuqTrvr_chtPojI5f6wwvi3Nfy7U9J2A
import dropbox
import os
# print(os.environ.get('DROPBOX_TOKEN'))
dbx = dropbox.Dropbox(os.getenv('DROPBOX_TOKEN'))
# print(dbx.users_get_current_account())
filename = './tmp/code.asm'
with open(filename, "rb") as f:
    dbx.files_upload(f.read(), '/code.asm', mute=True, mode=dropbox.files.WriteMode.overwrite)
