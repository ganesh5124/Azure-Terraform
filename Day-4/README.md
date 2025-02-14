# Terraform variables
- Variables are used to parameterize Terraform configurations.
- Variables are used to define values that can be passed into a configuration.
- Variables can be defined in a separate file and passed to the configuration.
- Variables can be defined in the configuration file itself.
- Variables can be defined in the command line.
- Variables can be defined in the environment.

# Terraform variable types
- string
- number
- bool
- list
- map
- object
- tuple

# Terraform variable definition
- Variables can be defined in a separate file.
- Variables can be defined in the configuration file itself.
- Variables can be defined in the command line. 
- Variables can be defined in the environment.

# Terraform variable definition in a separate file
- Create a file with the extension .tfvars.
- Define the variables in the file.
- Pass the file to the configuration using the -var-file option.

# Terraform variable definition in the configuration file
- Define the variables in the configuration file.
- Use the variable block to define the variables.
- Use the var.<variable_name> syntax to reference the variables.

# Terraform variable definition in the command line
- Use the -var option to define the variables in the command line.
- Use the -var-file option to define the variables in a separate file.

# Terraform variable definition in the environment
- Use the TF_VAR_<variable_name> environment variable to define the variables.
- Use the TF_VAR_<variable_name>_<index> environment variable to define the variables in a list or map.

# Terraform variable interpolation
- Variables can be interpolated in the configuration file.
- Use the var.<variable_name> syntax to interpolate the variables.
- Use the ${var.<variable_name>} syntax to interpolate the variables.

# Terraform variable validation
- Variables can be validated using the validation block.
- Use the validation block to define the validation rules.
- Use the required keyword to make the variable required.
- Use the length keyword to define the length of the variable.
- Use the range keyword to define the range of the variable.
- Use the regex keyword to define the regular expression pattern of the variable.

# Terraform variable default value
- Variables can have default values.
- Use the default keyword to define the default value of the variable.

# Terraform variable sensitive
- Variables can be marked as sensitive.
- Use the sensitive keyword to mark the variable as sensitive.
- Sensitive variables are not displayed in the output.

# Terraform variable description
- Variables can have descriptions.
- Use the description keyword to define the description of the variable.

# Terraform variable scope
- Variables have a scope.
- Variables can be defined at the root module level.
- Variables can be defined at the child module level.
- Variables can be defined at the environment level.

# Terraform variable precedence order

1. Environment variables
2. Terraform configuration file
3. Terraform variable file
4. Command line


