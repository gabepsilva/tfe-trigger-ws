

terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.36.0"
    }
  }
}

provider "tfe" {
  token    = var.token
}


// tf import tfe_organization.bank_test "bank-test"
resource "tfe_organization" "bank_test" {
  name = "bank-test"
  email = var.org_owner
}

resource "tfe_oauth_client" "gabe_client" {
  name             = "github-gabepsilva"
  organization     = tfe_organization.bank_test.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.gh_token1
  service_provider = "github"
}
// tf import tfe_workspace.tigger_ws "ws-MrPFPdLUu8Do4qJg"
resource "tfe_workspace" "target_ws" {
  name         = "tfe-target-ws"
  organization = tfe_organization.bank_test.name
  tag_names    = ["test", "app"]
  queue_all_runs = false
  file_triggers_enabled = false
  vcs_repo {
    identifier = "gabepsilva/tfe-target-ws"
    ingress_submodules = false
    oauth_token_id = tfe_oauth_client.gabe_client.oauth_token_id
  }
}

// tf import tfe_workspace.tigger_ws "ws-PMmYPgxFtUERRHX3"
resource "tfe_workspace" "tigger_ws" {
  name         = "tfe-trigger-ws"
  organization = tfe_organization.bank_test.name
  tag_names    = ["test", "app"]
  queue_all_runs = false
  file_triggers_enabled = false
  vcs_repo {
    identifier = "gabepsilva/tfe-trigger-ws"
    ingress_submodules = false
    oauth_token_id = tfe_oauth_client.gabe_client.oauth_token_id
  }
}

resource "tfe_run_trigger" "trigget_target" {
  workspace_id  = tfe_workspace.target_ws.id
  sourceable_id = tfe_workspace.tigger_ws.id
}
