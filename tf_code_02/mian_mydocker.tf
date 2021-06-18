terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_image" "sakuffo-helloword" {
  name = "sakuffo/myhello:latest"
  keep_locally = true
}

resource "docker_container" "nginx-web" {
  image = docker_image.nginx.latest
  name  = "nginx-web"
  ports {
    internal = 80
    external = 8000
  }
}

resource "docker_container" "sakuffo-helloword-web" {
  image = docker_image.sakuffo-helloword.latest
  name  = "sakuffo-helloword-web"
  ports {
    internal = 80
    external = 8001
  }
}

