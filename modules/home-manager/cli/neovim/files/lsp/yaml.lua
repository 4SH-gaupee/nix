-- most used yaml schemas
local gitlab_ci = "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"
local taskfile = "https://taskfile.dev/schema.json"
local lefthook = "https://raw.githubusercontent.com/evilmartians/lefthook/refs/heads/master/schema.json"
local github_workflow = "https://json.schemastore.org/github-workflow.json"

return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  settings = {
    yaml = {
      schemas = {
        [gitlab_ci] = {
          "ci/*.{yaml,yml}",
          ".gitlab/**/*.{yaml,yml}",
          ".gitlab-ci.{yaml,yml}",
        },
        [taskfile] = {
          "Taskfile*.{yaml,yml}",
          "taskfile*.{yaml,yml}",
          "taskfiles/**/*.{yaml,yml}",
        },
        [lefthook] = {
          "lefthook.{yaml,yml}",
        },
        [github_workflow] = {
          ".github/workflow/**/*.{yaml,yml}",
        }
      },
    },
  },
}

