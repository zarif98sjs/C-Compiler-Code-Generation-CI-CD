# import dropbox
# dbx = dropbox.Dropbox('sl.A1BNaC4Fk7O_Uq-VF3s6KvZBwCyjC9TJmGqht2EbjM-HmZ8uUuTaMM49fpb9kPl5gkIZecSrTvFjwpRQFZ8cJVva9kdPFs50QdXKPES1C7asoxr7JH1Canj24Nm52bR07qJhI7A')

# def createFile(fileString,fileName):
#     dbx.files_upload(fileString, '/'+fileName, mute=True , mode=dropbox.files.WriteMode.overwrite)

# # with open('input.c',"rb") as f:
# #     # data = f.readlines()
# #     createFile(f.read(),'temp.txt')

# def readFile(fileName):
#     f, r = dbx.files_download('/'+fileName)
#     return r.content.decode('utf-8')

# strRead = readFile('in.txt')
# print(strRead)
