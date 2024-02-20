resource "local_file" "pet" {
  filename = var.filename[count.index]
  count = length(var.filename)
  content = "Hello pet!"
}
