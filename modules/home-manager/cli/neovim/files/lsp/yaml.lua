-- most used yaml schemas
local kustomization = "http://json.schemastore.org/kustomization"
local ansible = "https://raw.githubusercontent.com/ansible/ansible-lint/refs/heads/main/src/ansiblelint/schemas/ansible.json"
local ansible_playbook = "http://json.schemastore.org/ansible-playbook"
local docker_compose = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"
local kubernetes = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.32.2/all.json"
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
			schemas = {
        [kustomization] = "kustomization.{yml,yaml}",
        [ansible] = "ansible.{yml,yaml}",
        [ansible_playbook] = "playbook.{yml,yaml}",
        [docker_compose] = "docker-compose.{yml,yaml}",
        [kubernetes] = "*.yaml", -- This line enables Kubernetes validation for all .yaml files
      },
		},
  },
}

