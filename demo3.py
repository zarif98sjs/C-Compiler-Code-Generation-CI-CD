from github import Github

github = Github('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')
repository = github.get_user().get_repo('C-Compiler-Code-Generation-CI-CD')

content = '{\"name\":\"beppe\",\"city\":\"amsterdam\"}'
f = repository.create_file('data.json', "create_file via PyGithub", content)
