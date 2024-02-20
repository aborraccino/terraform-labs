resource "local_file" "pet" {
  filename = each.value
  content = "Hello pet!"
  for_each = var.filename
}

output "pets" {
  value = local_file.pet
  sensitive = true
}
