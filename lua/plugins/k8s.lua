return {
  {
    "b0o/SchemaStore.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = require("schemastore").yaml.schemas({
                ["https://raw.githubusercontent.com/budimanjojo/talhelper/master/pkg/config/schemas/talconfig.json"] = "talconfig.yaml",
                extra = {
                  {
                    description = "Flux Kustomization",
                    fileMatch = {
                      "**/clusters/**/*.yaml",
                      "**/flux-system/**/*.yaml",
                    },
                    name = "flux-kustomization",
                    url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/kustomize.toolkit.fluxcd.io/kustomization_v1.json",
                  },
                  -- {
                  --   description = "Flux GitRepository",
                  --   fileMatch = { "*.yaml", "*.yml" },
                  --   name = "flux-gitrepo",
                  --   url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/source.toolkit.fluxcd.io/gitrepository_v1.json",
                  -- },
                  {
                    description = "Kubernetes",
                    fileMatch = { "*.yaml", "*.yml" },
                    name = "kubernetes",
                    url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone-strict/all.json",
                  },
                },
              }),
            },
          },
        },
      },
    },
  },
}
