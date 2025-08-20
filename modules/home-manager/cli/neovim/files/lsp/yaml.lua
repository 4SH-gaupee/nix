-- most used yaml schemas
local gitlab_ci = "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"
local taskfile = "https://taskfile.dev/schema.json"
local lefthook = "https://raw.githubusercontent.com/evilmartians/lefthook/refs/heads/master/schema.json"
local github_workflow = "https://json.schemastore.org/github-workflow.json"
local github_action = "http://json.schemastore.org/github-action"
local kustomization = "http://json.schemastore.org/kustomization"
local ansible = "https://raw.githubusercontent.com/ansible/ansible-lint/refs/heads/main/src/ansiblelint/schemas/ansible.json"
local ansible_playbook = "http://json.schemastore.org/ansible-playbook"
local docker_compose = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  settings = {
		yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

