# Terraform Type Constraints

# what is type constraints?

- Type constraints are used to restrict the type of values that can be assigned to a variable.

- Terraform supports the following type constraints:

  - string
  - number
  - bool
  - list
  - map
  - set
  - object
  - tuple

# Example
variable "name" {
  type = string
}

variable "age" {
  type = number
}

variable "is_adult" {
  type = bool
}

variable "names" {
  type = list(string)
}

variable "person" {
  type = object({
    name = string
    age  = number
  })
}

variable "person" {
  type = map(object({
    name = string
    age  = number
  }))
}

variable "person" {
  type = set(object({
    name = string
    age  = number
  }))
}

variable "person" {
  type = tuple([
    string,
    number
  ])
}