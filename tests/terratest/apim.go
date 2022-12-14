package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"path/filepath"
	"testing"
)

//Testing the secure-file-transfer Module
func TestTerraformAzurePrivateDns(t *testing.T) {
	t.Parallel()


	// Terraform plan.out File Path
	exampleFolder := test_structure.CopyTerraformFolderToTemp(t, "../..", "example")
	planFilePath := filepath.Join(exampleFolder, "plan.out")

	terraformPlanOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../example",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		VarFiles: []string{"for_terratest.tfvars"},

		//Environment variables to set when running Terraform

		// Configure a plan file path so we can introspect the plan and make assertions about it.
		PlanFilePath: planFilePath,
	})

	// Run terraform init plan and show and fail the test if there are any errors
	terraform.InitAndPlanAndShowWithStruct(t, terraformPlanOptions)
}
