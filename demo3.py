from github import Github

GITHUB_TOKEN = ""
github = Github(GITHUB_TOKEN)
repository = github.get_user().get_repo('C-Compiler-Code-Generation-CI-CD')

content = '{\"name\":\"beppe\",\"city\":\"amsterdam\"}'
f = repository.create_file('data.json', "create_file via PyGithub", content)
