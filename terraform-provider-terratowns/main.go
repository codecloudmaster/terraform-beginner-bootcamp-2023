// main.go

package main

import (
	//"log"
	//"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

func main() {
        plugin.Serve(&plugin.ServeOpts{
                ProviderFunc: Provider,
        })
}
// in Go a titlecase function will get exported
func Provider() *schema.Provider {
    var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{
            // Define your resources here
        },
        DataSourcesMap: map[string]*schema.Resource{
            // Define your data sources here
        },
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // make the token as sensitive to hide it the logs
				Required: true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc: validateUUID,
			},
		},
	}
	//p.ConfigureContextFunc = ProviderConfigure(p)
	return p
}

//func validateUUID(v interface{}, k string) (ws []string, errors []error) {
//	log.Print("validateUUID:start")
//	value := v.(string)
//	if _, err := uuid.Parse(value); err != nil {
//		errors = append(errors, fmt.Errorf("invalid UUID format"))
//	}
//	log.Print("validateUUID:end")
//	return
//}