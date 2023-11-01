terraform {
 backend "gcs" {
   bucket  = "bucket-mo-iti-final"
   prefix  = "terraform/state"
 }
}